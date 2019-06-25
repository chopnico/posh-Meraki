function Get-MerakiVlan {
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
        $VlanId
    )

    Try{
        $response = Invoke-RestMethod `
            -Uri "$env:ApiBaseUrl/networks/$NetworkId/vlans/$VlanId" `
            -Method Get `
            -ContentType "application/json" `
            -Headers @{ 'X-Cisco-Meraki-API-Key' = $ApiKey }

        $response | ForEach-Object {
            $device = [Vlan]@{
                Id          = $_.id
                NetworkId   = $_.networkId
                Name        = $_.name
                ApplianceIp = $_.applianceIp
                Subnet      = $_.subnet
            }
            Write-Output $device
        }
    }
    Catch{
        Write-Error $_.Exception
    }
}
