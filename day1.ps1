$RawInput = Get-Content .\input\day1.txt

# Find largest calorie count
$HighestCount = 0
$CurrentTotal = 0
foreach ($Line in $RawInput)
{
    if ($Line -eq "")
    {
        if ($HighestCount -lt $CurrentTotal)
        {
            $HighestCount = $CurrentTotal
        }
        $CurrentTotal = 0
    }
    else
    {
        $CurrentTotal += $Line
    }
}

Write-Host "Day 1 p1: $($HighestCount)"