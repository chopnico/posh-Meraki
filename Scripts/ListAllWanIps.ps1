$networks = Get-MerakiNetworks

foreach ($network in $networks){
    $devices = Get-MerakiDevices -NetworkId $network.id
    foreach ($device in $devices){
        $uplinks = Get-MerakiDeviceUplink -NetworkId $network.id -Serial $device.serial
        Write-Output $uplinks
    }
}
