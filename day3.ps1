$RucksackArray = @() # Split into each rucksack with compartments a and b
Get-Content .\Input\day3.txt | ForEach-Object {
    $RucksackArray += @{
        a = $_.Substring(0, ($_.Length / 2)); # First half
        b = $_.Substring($_.Length / 2) # Second half
    }
}

# Create hashtable of char values
$PriorityTable = @{}
for ($i = 0; $i -lt 26; $i++)
{
    $PriorityTable.$("Lower" + [string][char](65+$i)) = 1+$i # Lowercase (a = 97)
    $PriorityTable.$("Upper" + [string][char](65+$i)) = 27+$i # Uppercase (A = 65)
}

# Find letter that appears in both compartments
$PrioritySum = 0
foreach ($Rucksack in $RucksackArray)
{
    #Strip of duplicates then iterate through first compartment to see if any elements are in the second compartment
    $Rucksack.a.ToCharArray() | Select-Object -Unique | ForEach-Object {
        if ($Rucksack.b.Contains($_))
        {
            if ([int][char]$_ -gt 96) {$PrioritySum += $PriorityTable."Lower$($_)"}
            else {$PrioritySum += $PriorityTable."Upper$($_)"}
        }
    }
}

Write-Host "Day 3 p1: $PrioritySum"