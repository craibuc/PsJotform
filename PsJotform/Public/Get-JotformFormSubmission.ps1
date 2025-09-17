<#
.LINK
https://api.jotform.com/docs/#form-id-submissions
#>
function Get-JotformFormSubmission {
    param (
        [Parameter(Mandatory)]
        [string]$ApiKey,

        [Parameter(Mandatory)]
        [string]$Subdomain,

        [string]$FormId,

        [ValidateSet('id','username','title','status','created_at','updated_at','new','count','slug')]
        [string]$OrderBy
    )

    $BaseUri = "https://$Subdomain.jotform.com/API/form/$FormId/submissions"
    $Offset = 0

    do {

        # offset; orderby
        $QueryParams = @{}

        $QueryParams.offset = $Offset
        if ($OrderBy) { $QueryParams.orderby = $OrderBy }

        $QueryString = ($QueryParams.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join '&'

        $Uri = $QueryString ? "$BaseUri`?$QueryString" : $BaseUri
        Write-Debug "Uri: $Uri"

        $Response = Invoke-WebRequest -Method Get -Uri $Uri -Headers @{APIKEY = $ApiKey}

        if ($Response.Content) {
            # convert JSON to PsCustomObject
            $Content = $Response.Content | ConvertFrom-Json -Depth 10
            
            # calculate new offset
            $Offset = $Offset += [int]$Content.resultSet.limit

            # return the records
            $Content.content
        }

    } while ($Content.resultSet.count -gt 0)

}
