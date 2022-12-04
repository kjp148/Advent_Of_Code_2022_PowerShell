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

# Count how many pairs overlap fully/partially
$FullOverlapCount = 0
$PartialOverlapCount = 0
foreach ($Pair in $PairsOfElves)
{
    $FirstResult = (($Pair.First.Start -le $Pair.Second.Start) -and ($Pair.First.End -ge $Pair.Second.End))
    $SecondResult = (($Pair.Second.Start -le $Pair.First.Start) -and ($Pair.Second.End -ge $Pair.First.End))
    if ($FirstResult -or $SecondResult) {$FullOverlapCount++}

    $FirstResult = (($Pair.First.Start -le $Pair.Second.Start) -and ($Pair.First.End -ge $Pair.Second.Start))
    $SecondResult = (($Pair.First.Start -le $Pair.Second.End) -and ($Pair.First.End -ge $Pair.Second.End))
    $ThirdResult = (($Pair.Second.Start -le $Pair.First.Start) -and ($Pair.Second.End -ge $Pair.First.Start))
    $FourthResult = (($Pair.Second.Start -le $Pair.First.End) -and ($Pair.Second.End -ge $Pair.First.End))
    if ($FirstResult -or $SecondResult -or $ThirdResult -or $FourthResult) {$PartialOverlapCount++}
}

Write-Host "Day 4 p1: $FullOverlapCount"
Write-Host "Day 4 p2: $PartialOverlapCount"