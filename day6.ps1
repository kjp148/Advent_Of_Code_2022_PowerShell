$CharacterArray = (Get-Content .\Input\day6.txt -Raw).Trim().ToCharArray()

for ($i = 3; $i -lt $CharacterArray.Length; $i++)
{
    if (($CharacterArray[($i - 3)..$i] | Select-Object -Unique).Length -eq 4)
    {
        Write-Host "Day 6 p1: $($i + 1)"
        break
    }
}