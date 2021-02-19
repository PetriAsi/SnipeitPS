function Get-ParameterValue {
    # returns command parameters as hastable, kays in lowercase
    # This helps keeping function parameters formated as Titlecase
    # and usen them directly with snipeit api in lowercase
    #
    # Get-ParameterValue must be dot-sourced, like this: . Get-ParameterValue
    # 
    [CmdletBinding()]
    param(
        # Pass $MyInvocation.MyCommand.Parameters to function, powershell 7 seems to only populate variables with dot sourcing
        [parameter(mandatory = $true)]
        $Parameters
        ,

        [string[]]$DefaultExcludeParameter = @("id", "url", "apiKey", 'Debug', 'Verbose', 'RequestType','customfields')
    )

    if ($MyInvocation.Line[($MyInvocation.OffsetInLine - 1)] -ne '.') {
        throw "Get-ParameterValue must be dot-sourced, like this: . Get-ParameterValue"
    }
    

    $ParameterValues = @{}
    foreach ($parameter in $Parameters.GetEnumerator()) {
        # gm -in $parameter.Value | Out-Default
        try {
            $key = $parameter.Key
            if ($key -notin $DefaultExcludeParameter) {
                if ($null -ne ($value = Get-Variable -Name $key -ValueOnly -ErrorAction Ignore )) {
                    if ($value -ne ($null -as $parameter.Value.ParameterType)) {
                        $ParameterValues[$key.toLower()] = $value
                    }
                }

            }
        }
        finally {}
    }
    return $ParameterValues
}
