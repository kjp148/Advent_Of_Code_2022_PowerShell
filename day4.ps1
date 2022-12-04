<# Pseduo
    Seperate into object Pair.First.Start Pair.First.End Pair.Second.Start Pair.First.End
        using foreach line -> split "," | foreach-object $_ -split "-"
    foreach pair
        if Pair.First.Start - Pair.Second.Start -gt 0 AND Pair.First.End - Pair.Second.End -gt 0 OR (REVERSE pair.second.start - pair.first.start etc.)
            PairsEncapsulatingOther++
#>