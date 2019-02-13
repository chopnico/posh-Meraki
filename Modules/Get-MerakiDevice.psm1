function Get-MerakiDevice {
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
        $NetworkId,

        [Parameter(
            Position = 3,
            Mandatory = $true,
            ValueFromPipeLine = $false,
            ValueFromPipelineByPropertyName = $false)]
        [string]
        $Serial
    )

    Try{
        $response = Invoke-RestMethod `
            -Uri "$env:ApiBaseUrl/networks/$NetworkId/devices/$Serial" `
            -Method Get `
            -ContentType "application/json" `
            -Headers @{ 'X-Cisco-Meraki-API-Key' = $ApiKey }

        $response | ForEach-Object {
            $device = [Device]@{
                Name       = $_.name
                Serial     = $_.serial
                Mac        = $_.mac
                Model      = $_.model
                LanIp      = $_.lanIp
                NetworkId  = $_.networkId
                Tags       = $_.tags
            }

            Write-Output $device
        }
    } 
    Catch{
        Write-Error $_.Exception
    }
}
