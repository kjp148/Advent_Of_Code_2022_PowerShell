<# Pseduo
    Seperate into object Pair.First.Start Pair.First.End Pair.Second.Start Pair.First.End
        using foreach line -> split "," | foreach-object $_ -split "-"
    foreach pair
        if Pair.First.Start - Pair.Second.Start -gt 0 AND Pair.First.End - Pair.Second.End -gt 0 OR (REVERSE pair.second.start - pair.first.start etc.)
            PairsEncapsulatingOther++
#>

# Seperate each line into an object with two pairs of pairs
$PairsOfElves = @()
foreach ($Line in (Get-Content .\Input\day4.txt))
{
    $SplitElves = ($Line -split ",")
    $PairsOfElves += @{
        First = @{
            Start = [int]($SplitElves[0] -split "-")[0];
            End = [int]($SplitElves[0] -split "-")[1]
        };
        Second = @{
            Start = [int]($SplitElves[1] -split "-")[0];
            End = [int]($SplitElves[1] -split "-")[1]
        }
    }
}