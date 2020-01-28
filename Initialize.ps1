# Load classes
$classes = Get-ChildItem -Path $PSScriptRoot\Classes\*.ps1

ForEach($class in $classes){
    Write-Verbose "Importing classs $($class)"
    . $class.FullName
}

# Read configuration from user's home folder
# Windows C:\Users\<username>
# Linux /home/<username>
if(Test-Path $home/.meraki.conf){
    $configuration = Get-Content $home/.meraki.conf | ConvertFrom-Json    
}
else{
    $configuration = $null
}

# Set some environment variables (global)
$env:ApiBaseUrl = "https://api.meraki.com/api/v0"
$env:ApiKey     = $configuration.apiKey
$env:OrgId      = $configuration.orgId
