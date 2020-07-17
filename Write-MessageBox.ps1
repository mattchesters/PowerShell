function Write-MessageBox {
    param (
        $TitleBar,
        $Body,
        $Footer,
        $Question
    )
Clear-Host
Write-Host -ForegroundColor "Gray" -BackgroundColor "Black" $TitleBar
Write-Host -ForegroundColor "White" -BackgroundColor "Black" $Body
Write-Host -ForegroundColor "Yellow" -BackgroundColor "Black" $Footer
$userInput = Read-Host -Prompt $Question
}
$msgHeader = @(
"╔═════════════════════════════════════════════════╗
║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀Manual intevention required⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀║
╚═════════════════════════════════════════════════╝"
)
$msgBody = @(
"╔═════════════════════════════════════════════════╗
║⠀To avoid incurring additional costs, a data cap⠀║
║⠀must be set to cap the logs at 0.15GB per day.⠀⠀║
║⠀The Pay-As-You-Go Sku allows for 5GB of logs⠀⠀⠀⠀║
║⠀per month.⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀║
║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀║
║⠀This change can only be made in the Azure⠀⠀⠀⠀⠀⠀⠀║
║⠀Portal. To continue, visit:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀║
╚═════════════════════════════════════════════════╝"
)
$msgFooter = @(
"╔═════════════════════════════════════════════════╗
║⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀https://portal.azure.com⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀║
╚═════════════════════════════════════════════════╝"
)
$msgQuestion = "Press [n] to skip, or [y] to view instructions"
Write-MessageBox -TitleBar $msgHeader -Body $msgBody -Footer $msgFooter -Question $msgQuestion
if ($userInput -match "n"){
    Write-Host Proceeding...
} else {
    $msgInstructions = @("╔═════════════════════════════════════════════════╗
║⠀1. Browse to the $WorkspaceName resource⠀⠀⠀⠀⠀⠀⠀║
║⠀2. Select the Usage & Billing blade⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀║
║⠀3. Select the Data volume management tab⠀⠀⠀⠀⠀⠀⠀⠀║
║⠀4. Turn the Daily Volume Cap ON⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀║
║⠀5. Set a volume which keeps you within the⠀⠀⠀⠀⠀⠀║
║⠀⠀⠀⠀⠀5GB/month limit (e.g. 0.15GB/day)⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀║
║⠀6. Press OK to apply the settings⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀║
╚═════════════════════════════════════════════════╝")
$msgQuestion = "Press any key to continue"
Write-MessageBox -TitleBar $msgHeader -Body $msgInstructions -Footer $msgFooter -Question $msgQuestion
}
