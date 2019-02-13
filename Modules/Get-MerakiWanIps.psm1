function Get-MerakiWanIps {
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
        $networks = Get-MerakiNetworks -ApiKey $ApiKey -OrganizationId $OrganizationId

        $uplinks = @()
        foreach ($network in $networks){
            $devices = Get-MerakiDevices -NetworkId $network.id -ApiKey $ApiKey -OrganizationId $OrganizationId
            foreach ($device in $devices){
                $uplink = Get-MerakiDeviceUplink -NetworkId $network.id -Serial $device.serial -ApiKey $ApiKey -OrganizationId $OrganizationId
                $uplinks += $uplink
            }
        }

        Write-Output $uplinks
    }
    Catch{
        Write-Error $-.Exception
    }
}
