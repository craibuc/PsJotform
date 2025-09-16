<#
.LINK
https://api.jotform.com/docs/#form-id
#>
function Get-JotformForm {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$ApiKey,

        [Parameter(Mandatory)]
        [string]$Subdomain,

        [string]$FormId
    )

    $Uri = "https://$Subdomain.jotform.com/API/form/$FormId"
    Write-Debug "Uri: $Uri"

    $Response = Invoke-WebRequest -Method Get -Uri $Uri -Headers @{APIKEY = $ApiKey} 

    if ($Response.Content) {
        ($Response.Content | ConvertFrom-Json -Depth 10).content
    }

}