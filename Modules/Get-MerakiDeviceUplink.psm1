function Get-MerakiDeviceUplink {
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
            -Uri "$env:ApiBaseUrl/networks/$NetworkId/devices/$Serial/uplink" `
            -Method Get `
            -ContentType "application/json" `
            -Headers @{ 'X-Cisco-Meraki-API-Key' = $ApiKey }

        $response | ForEach-Object {
            $deviceUplink = [DeviceUplink]@{
                Interface       = $_.interface
                Status          = $_.status
                Ip              = $_.ip
                Gateway         = $_.gateway
                PublicIp        = $_.publicIp
                Dns             = $_.dns -split ","
                UsingStaticIp   = $_.usingStaticIp
            }

            Write-Output $deviceUplink
        }
    } 
    Catch{
        Write-Error $_.Exception
    }
}
