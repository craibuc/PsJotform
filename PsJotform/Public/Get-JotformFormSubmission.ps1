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

        [string]$FormId
    )

    $BaseUri = "https://$Subdomain.jotform.com/API"

    $Uri = '{0}/form/{1}/submissions' -f $BaseUri, $FormId

    $Response = Invoke-WebRequest -Method Get -Uri $Uri -Headers @{APIKEY = $ApiKey} 

    if ($Response.Content) {
        ($Response.Content | ConvertFrom-Json -Depth 10).content
    }

}
