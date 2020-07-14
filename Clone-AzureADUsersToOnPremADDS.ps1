<##
Creates Active Directory Users from existing identies in Azure AD
##>

# Required Modules
Import-Module ActiveDirectory
Import-Module MSOnline
Connect-MSOLService

# Hashtables for recording results
$NewResults = $null
$NewResults = @{}
$ExchangeOnlineOutput = $null
$ExchangeOnlineOutput = @{}

# Export Exchange Users to Hashtable
$ExchangeOnlineOutput = Get-MSOLUser -all | Select-Object City,Country,Department,DisplayName,Fax,FirstName,LastName,MobilePhone,Office,PhoneNumber,PostalCode,SignInName,StreetAddress,Title,UserPrincipalName,@{Name='proxyAddresses';Expression={[string]::join(";", ($_.proxyAddresses))}}

# Random password generator for new user accounts
 function New-Password {
    # 1 Uppercase Letter
    $PhaseA = -join ((65..90) | Get-Random -Count 1 | % {[char]$_})
    # 2 Lowercase Letters
    $PhaseB = -join ((97..122) | Get-Random -Count 2 | % {[char]$_})
    # Combine PhaseA and PhaseB
    $Phase1 = -join $PhaseA + $PhaseB
    # 2 Numbers
    $Phase2 = -join ((48..57) | Get-Random -Count 2 | % {[char]$_})
    # 3 Lowercase Letters
    $Phase3 = -join ((97..122) | Get-Random -Count 3 | % {[char]$_})
    # 1 Symbol
    $Phase4 = -join (33,36,37,40,41,42,43,63,64 | Get-Random -Count 1 | % {[char]$_})
    # Randomise Phases
    $Dice = 1,2,3,4 | Get-Random 
    if ($Dice -eq 1){
        $NewPassword = -join $Phase1 + $Phase2 + $Phase3 + $Phase4
    } elseif ($Dice -eq 2){
        $NewPassword = -join $Phase2 + $Phase1 + $Phase3 + $Phase4
    } elseif ($Dice -eq 3){
        $NewPassword = -join $Phase3 + $Phase2 + $Phase1 + $Phase4
    }  elseif ($Dice -eq 4){
        $NewPassword = -join $Phase1 + $Phase3 + $Phase2 + $Phase4
    }
    Return $NewPassword
 }

# Import the CSV and create the new AD userObject for each line
foreach ($user in $ExchangeOnlineOutput) {
    $UserPrincipalName = $user.UserPrincipalName
    # Make the SAM from the UPN
    $sAM = $UserPrincipalName.Split("@")[0]
    # Generate a password for the user
    $UserPassword = New-Password
    # Create the userObject
    New-ADUser `
     -Name $user.DisplayName `
     -City $user.City `
     -Department $user.Department `
     -DisplayName $user.DisplayName `
     -Fax $user.Fax `
     -GivenName $user.FirstName `
     -Surname $user.LastName `
     -MobilePhone $user.MobilePhone `
     -Office $user.Office `
     -OfficePhone $user.PhoneNumber `
     -PostalCode $user.PostalCode `
     -StreetAddress $user.StreetAddress `
     -Title $user.Title `
     -UserPrincipalName $user.UserPrincipalName `
     -SamAccountName $sAM `
     -AccountPassword (ConvertTo-SecureString -String $UserPassword -AsPlainText -Force) `
     -ChangePasswordAtLogon $true  `
     -Enabled $true `
     -Country $user.Country `
    # Export User, Password, and Status to hashtable
    $NewResults.add($UserPrincipalName,$UserPassword)
}

Write-Host $NewResults
Return $NewResults
