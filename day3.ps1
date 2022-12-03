$RucksackArray = @() # Split into each rucksack with compartments a and b
Get-Content .\Input\day3.txt | ForEach-Object {
    $RucksackArray += @{
        a = $_.Substring(0, ($_.Length / 2));
        b = $_.Substring($_.Length / 2)
    }
}