
---

## Background


My work copy of SnipeItPS. Including many fixes and features, including:

Works with powershell 7


Get any entity with -id parameter

Returns all requested items ( get-asset, get-user ,get-[anything]) with
-all switch


Module tries to follow snipe it apis and require only fields required by api. 
So you can create assets with automaticly generated asset tags. Update assets without specifying status_ids etc..

I hope that my fixes will get into SnipeitPS, but maybe I'll release this to powershell gallery  under different module name some day.






### Installation

In this time no install from powershell gallery so you have to clone repository and copy SnipeItPS/SnipeItPS folder to powershell module folder.


# To use each session:
Import-Module SnipeitPS
Set-Info -URL 'https://asset.example.com' -apiKey 'tokenKey'
```

### Usage

```powershell
# Review the help at any time!
Get-Help about_SnipeitPS
Get-Command -Module SnipeitPS
Get-Help Get-Asset -Full   # or any other command
```
