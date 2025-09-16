<#
.LINK
https://api.jotform.com/docs/#submission-id
#>
function Get-JotformSubmission {
    param (
        [Parameter(Mandatory)]
        [string]$ApiKey,

        [Parameter(Mandatory)]
        [string]$Subdomain,

        [string]$SubmissionId
    )

    $BaseUri = "https://$Subdomain.jotform.com/API"

    $Uri = '{0}/submission/{1}' -f $BaseUri, $SubmissionId

    $Response = Invoke-WebRequest -Method Get -Uri $Uri -Headers @{APIKEY = $ApiKey} 

    if ($Response.Content) {
        ($Response.Content | ConvertFrom-Json -Depth 10).content
    }

}
