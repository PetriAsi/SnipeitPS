<#
.SYNOPSIS
# Gets a list of Snipe-it Licenses

.PARAMETER search
A text string to search the Licenses data

.PARAMETER id
A id of specific License

.PARAMETER limit
Specify the number of results you wish to return. Defaults to 50. Defines batch size for -all

.PARAMETER offset
Offset to use

.PARAMETER all
A return all results, works with -offset and other parameters


.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-License -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-License -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "License" }

#>

function Get-License() {
    Param(
        [string]$search,

        [string]$id,

        [string]$name,

        [int] $company_id,

        [string]$product_key,

        [int]$order_number,

        [string]$purchase_order,

        [string]$license_name,

        [mailaddress]$license_email,

        [int]$manufacturer_id,

        [int]$supplier_id,

        [int]$depreciation_id,

        [int]$category_id,

        [ValidateSet("asc", "desc")]
        [string]$order = "desc",

        [ValidateSet('id', 'name', 'purchase_cost', 'expiration_date', 'purchase_order', 'order_number', 'notes', 'purchase_date', 'serial', 'company', 'category', 'license_name', 'license_email', 'free_seats_count', 'seats', 'manufacturer', 'supplier')]
        [string]$sort = "created_at",

        [int]$limit = 50,

        [int]$offset,

        [switch]$all = $false,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $SearchParameter = . Get-ParameterValue $MyInvocation.MyCommand.Parameters
    
    $apiurl = "$url/api/v1/licenses"

    if ($search -and $id ) {
         Throw "[$($MyInvocation.MyCommand.Name)] Please specify only -search or -id parameter , not both "
    }
    
    if ($id) {
       $apiurl= "$url/api/v1/licenses/$id"      
    }

    $Parameters = @{
        Uri           = $apiurl
        Method        = 'Get'
        Token         = $apiKey
        GetParameters = $SearchParameter
    }

    if ($all) {
        $offstart = $(if($offset){$offset} Else {0})
        $callargs = $SearchParameter
        $callargs.Remove('all')

        while ($true) {
            $callargs['offset'] = $offstart
            $callargs['limit'] = $limit         
            $res=Get-License @callargs 
            $res
            if ($res.count -lt $limit) {
                break
            }
            $offstart = $offstart + $limit
        }
    } else {
        $result = Invoke-SnipeitMethod @Parameters
        $result
    }
}

