$CharacterArray = (Get-Content .\Input\day6.txt -Raw).Trim().ToCharArray()
$Part1Done = $false
$Part2Done = $false
for ($i = 3; $i -lt $CharacterArray.Length; $i++)
{
    # Part 1
    if (!$Part1Done -and ($CharacterArray[($i - 3)..$i] | Select-Object -Unique).Length -eq 4)
    {
        Write-Host "Day 6 p1: $($i + 1)"
        $Part1Done = $true
    }

    # Part 2
    if (!$Part2Done -and ($CharacterArray[($i - 13)..$i] | Select-Object -Unique).Length -eq 14)
    {
        Write-Host "Day 6 p2: $($i + 1)"
        $Part2Done = $true
    }

    if ($Part1Done -and $Part2Done) {break}
}