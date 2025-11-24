<#
.SYNOPSIS
    Test if we are connected to Exchange Online and connect if not
.DESCRIPTION
    Test if we are connected to Exchange Online and connect if not
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Test-EXOConnection {
    # In all cases make sure we are "connected" to EXO
    try {
        $null = Get-OrganizationConfig -erroraction stop
    }
    catch [System.Management.Automation.CommandNotFoundException] {
        # Connect to EXO if we couldn't find the command
        Out-LogFile "Not Connected to Exchange Online" -Information
        Out-LogFile "Connecting to EXO using Exchange Online Module using Browser Based Authentication" -Action

        # Beginning in Exchange Online PowerShell module version 3.7.0, Microsoft is implementing Web Account Manager (WAM) as the default authentication broker for user authentication. 
        if ((Get-Module -Name ExchangeOnlineManagement).Version -ge [version]'3.7.0') {
            Connect-ExchangeOnline -ShowBanner:$false
        }
        else {
            Connect-ExchangeOnline -ShowBanner:$false -DisableWAM
        }
    }
}