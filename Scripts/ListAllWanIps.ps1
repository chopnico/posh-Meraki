Import-Module $PSScriptRoot'/../Meraki.psd1'

$networks = Get-MerakiNetworks

foreach ($network in $networks){
    $devices = Get-MerakiDevices -NetworkId $network.id
    foreach ($device in $devices) {
        $device.wan1Ip
    }
}
