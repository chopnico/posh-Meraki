function Get-MerakiOrganizations {
    [CmdletBinding()]
    param (
        [Parameter(
            Position = 0,
            Mandatory = $false,
            ValueFromPipeLine = $false,
            ValueFromPipeLineByPropertyName = $false)]
        [string]
        $ApiKey = $env:ApiKey
    )

    Try{
        $response = Invoke-RestMethod `
            -Uri "$env:ApiBaseUrl/organizations" `
            -Method Get `
            -ContentType "application/json" `
            -Headers @{ 'X-Cisco-Meraki-API-Key' = $ApiKey }

        $response | ForEach-Object {
            $device = [Organization]@{
                Id      = $_.id
                Name    = $_.name
            }

            Write-Output $device
        }
    }
    Catch{
        Write-Error $_.Exception
    }
}
