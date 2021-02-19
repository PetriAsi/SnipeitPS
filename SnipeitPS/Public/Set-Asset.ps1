<#
    .SYNOPSIS
    Update a Asset in the Snipe-it asset system

    .DESCRIPTION
    Long description

    .PARAMETER id
    ID of the Asset

    .PARAMETER Name
    Name of the Asset

    .PARAMETER Status_id
    Status ID of the asset, this can be got using Get-Status

    .PARAMETER Model_id
    Model ID of the asset, this can be got using Get-Model

    .PARAMETER url
    URL of Snipeit system, can be set using Set-Info command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-Info command

    .PARAMETER customfields
    Hastable of custom fields and extra fields that need passing through to Snipeit

    .EXAMPLE
    Set-Asset -id 1 -status_id 1 -model_id 1 -name "Machine1"

    .EXAMPLE
    Set-Asset -id 1 -status_id 1 -model_id 1 -name "Machine1" -CustomValues = @{ "_snipeit_os_5 = "Windows 10 Pro" }
#>

function Set-Asset()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$id,

        [parameter(mandatory = $false)]
        [int]$status_id,

        [parameter(mandatory = $false)]
        [int]$model_id,

        [parameter(mandatory = $false)]
        [string]$name,

        [parameter(mandatory = $false)]
        [string]$asset_tag,

        [parameter(mandatory = $false)]
        [string]$serial,

        [parameter(mandatory = $false)]
        [int]$company_id,

        [parameter(mandatory = $false)]
        [string]$order_number,

        [parameter(mandatory = $false)]
        [string]$notes,

        [parameter(mandatory = $false)]
        [int]$warranty_months,

        [parameter(mandatory = $false)]
        [string]$purchase_cost,

        [parameter(mandatory = $false)]
        [string]$purchase_date,

        [parameter(mandatory = $false)]
        [int]$supplier_id,

        [parameter(mandatory = $false)]
        [int]$rtd_location_id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey,

        [hashtable] $customfields
    )

    $Values = . Get-ParameterValue $MyInvocation.MyCommand.Parameters

       
    if ($customfields)
    {
        $Values += $customfields
    }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/hardware/$id"
        Method = 'Put'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
