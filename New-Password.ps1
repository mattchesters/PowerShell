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
