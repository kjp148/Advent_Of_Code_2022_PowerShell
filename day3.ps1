$InputArray = (Get-Content .\Input\day3.txt)

# Split into each rucksack with compartments a and b
$RucksackArray = @()
$InputArray | ForEach-Object {
    $RucksackArray += @{
        a = $_.Substring(0, ($_.Length / 2)); # First half
        b = $_.Substring($_.Length / 2) # Second half
    }
}

 # Seperate rucksacks into groups of three
$ElfGroupArray = @()
for ($i = 0; $i -lt $InputArray.Length; $i += 3)
{
    $ElfGroupArray += @{
        a = $InputArray[$i];
        b = $InputArray[$i + 1];
        c = $InputArray[$i + 2]
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
$Part1PrioritySum = 0
foreach ($Rucksack in $RucksackArray)
{
    # Strip of duplicates then iterate through first compartment to see if any elements are in the second compartment
    $Rucksack.a.ToCharArray() | Select-Object -Unique | ForEach-Object {
        if ($Rucksack.b.Contains($_))
        {
            if ([int][char]$_ -gt 96) {$Part1PrioritySum += $PriorityTable."Lower$($_)"}
            else {$Part1PrioritySum += $PriorityTable."Upper$($_)"}
        }
    }
}

# Find common letter and sum priority for elf groups
$Part2PrioritySum = 0
foreach ($ElfGroup in $ElfGroupArray)
{
    # Strip duplicates from first rucksack then iterate through both other rucksacks until a match is found in both
    $ElfGroup.a.ToCharArray() | Select-Object -Unique | ForEach-Object {
        if ($ElfGroup.b.Contains($_) -and $ElfGroup.c.Contains($_))
        {
            if ([int][char]$_ -gt 96) {$Part2PrioritySum += $PriorityTable."Lower$($_)"}
            else {$Part2PrioritySum += $PriorityTable."Upper$($_)"}
        }
    }
}

Write-Host "Day 3 p1: $Part1PrioritySum"
Write-Host "Day 3 p2: $Part2PrioritySum"