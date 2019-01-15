function Get-MerakiDevices {
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
        $OrganizationId = $env:OrgId,

        [Parameter(
            Position = 2,
            Mandatory = $true,
            ValueFromPipeLine = $false,
            ValueFromPipelineByPropertyName = $false)]
        [string]
        $NetworkId
    )

    Try{
        Invoke-WebRequest -Uri "$env:ApiBaseUrl/networks/$NetworkId/devices" -Headers @{ 'X-Cisco-Meraki-API-Key' = $ApiKey } | ConvertFrom-Json
    }
    Catch{
        Write-Error $_.Exception.Message
    }
}
