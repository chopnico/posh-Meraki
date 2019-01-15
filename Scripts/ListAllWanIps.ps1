$networks = Get-MerakiNetworks

foreach ($network in $networks){
    $devices = Get-MerakiDevices -NetworkId $network.id
}
