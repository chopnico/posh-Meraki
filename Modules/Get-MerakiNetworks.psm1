function Get-MerakiNetworks {
    [CmdletBinding()]
    param (
        [Parameter(
            Position = 0,
            Mandatory = $false,
            ValueFromPipeLine = $false,
            ValueFromPipeLineByPropertyName = $false)]
        [string]
        $ApiKey = $env:ApiKey,

        [Parameter(
            Position = 1,
            Mandatory = $false,
            ValueFromPipeLine = $false,
            ValueFromPipeLineByPropertyName = $false)]
        [string]
        $OrganizationId = $env:OrgId
    )

    Try{
        Invoke-WebRequest -Uri "$env:ApiBaseUrl/organizations/$OrganizationId/networks" -Headers @{ 'X-Cisco-Meraki-API-Key' = $ApiKey } | ConvertFrom-Json
    }
    Catch{
        Write-Error $_.Exception
    }
}
