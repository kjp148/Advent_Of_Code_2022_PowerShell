$RucksackArray = @() # Split into each rucksack with compartments a and b
Get-Content .\Input\day3.txt | ForEach-Object {
    $RucksackArray += @{
        a = $_.Substring(0, ($_.Length / 2));
        b = $_.Substring($_.Length / 2)
    }
}

# Create hashtable of char values
$CharTable = @{}
for ($i = 0; $i -lt 26; $i++)
{
    $CharTable.$([char](97+$i)) = 1+$i # Lowercase (a = 97)
    $CharTable.$([char](65+$i)) = 27+$i # Uppercase (A = 65)
}