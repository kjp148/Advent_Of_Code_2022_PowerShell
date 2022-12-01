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

# Find top three total
$CurrentTotal = 0
$ElfCalorieArray = @()
foreach ($Line in $RawInput)
{
    if ($Line -eq "")
    {
        $ElfCalorieArray += $CurrentTotal
        $CurrentTotal = 0
    }
    else
    {
        $CurrentTotal += $Line
    }
}

$SortedCalorieArray = ($ElfCalorieArray | Sort-Object -Descending)
Write-Host "Day 2 p2: $($SortedCalorieArray[0] + $SortedCalorieArray[1] + $SortedCalorieArray[2])"