<#
    .SYNOPSIS
    Removes category from Snipe-it asset system
    .DESCRIPTION
    Removes category or multiple categories from Snipe-it asset system
    .PARAMETER ID
    Unique ID For categoryto be removed
    .PARAMETER url
    Deprecated parameter, please use Connect-SnipeitPS instead. URL of Snipeit system.

    .PARAMETER apiKey
    Deprecated parameter, please use Connect-SnipeitPS instead. User's API Key for Snipeit.

    .EXAMPLE
    Remove-SnipeitCategory -ID 44

    .EXAMPLE
    Get-SnipeitCategory -search something  | Remove-SnipeitCategory
#>

function Remove-SnipeitCategory () {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey

    )
    begin {
    }
    process {
        foreach($category_id in $id) {
            $Parameters = @{
                Api    = "/api/v1/categories/$category_id"
                Method = 'Delete'
            }

            if ($PSBoundParameters.ContainsKey('apiKey')) {
                Write-Warning "-apiKey parameter is deprecated, please use Connect-SnipeitPS instead."
                Set-SnipeitPSSessionApiKey -apiKey $apikey
            }

            if ($PSBoundParameters.ContainsKey('url')) {
                Write-Warning "-url parameter is deprecated, please use Connect-SnipeitPS instead."
                Set-SnipeitPSSessionApiKey -url $url
            }

            if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
                $result = Invoke-SnipeitMethod @Parameters
            }

            $result
        }
    }
}
