# Load classes
using module './Classes/Device.psm1'
using module './Classes/Network.psm1'
using module './Classes/Organization.psm1'
using module './Classes/DeviceUplink.psm1'

# Read configuration from user's home folder
# Windows C:\Users\<username>
# Linux /home/<username>
$configuration = Get-Content $home/.meraki.conf | ConvertFrom-Json

# Set some environment variables (global)
$env:ApiBaseUrl = "https://api.meraki.com/api/v0"
$env:ApiKey = $configuration.apiKey
$env:OrgId = $configuration.orgId
