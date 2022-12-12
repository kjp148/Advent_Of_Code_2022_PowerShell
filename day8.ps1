$RawInput = Get-Content .\Input\day8.txt
$xMax = $RawInput[0].Length # Left to right in the file
$yMax = $RawInput.Length # Top to bottom in the file
$TreeGrid = New-Object 'object[,]' $xMax, $yMax # Create 2d array for grid of trees
for ($y = 0; $y -lt $yMax; $y++) # Populate 2d array with coords
 {
    for ($x = 0; $x -lt $xMax; $x++)
    {
        $TreeGrid[$x, $y] = $RawInput[$y].ToCharArray()[$x]
    }
}

# Part 1 - Count trees visible from the edge
$VisibleCount = 0
for ($y = 0; $y -lt $yMax; $y++)
{
    for ($x = 0; $x -lt $xMax; $x++)
    {
        if (($x -eq 0) -or ($x -eq $xMax - 1) -or ($y -eq 0) -or ($y -eq $yMax - 1)) {$VisibleCount++} # Check for edge tree
        else # Loop through horiz and vert to see if it's visible
        {
            $FoundVisible = @($true, $true, $true, $true)
            for ($xSearchIterate = 0; $xSearchIterate -lt $x; $xSearchIterate++) # Search for horiz match from left
            {
                if ($TreeGrid[$xSearchIterate, $y] -ge $TreeGrid[$x, $y])
                {
                    $FoundVisible[0] = $false
                    break
                }
            }
            for ($xSearchIterate = $x + 1; $xSearchIterate -lt $xMax; $xSearchIterate++) # Search for horiz match from right
            {
                if ($TreeGrid[$xSearchIterate, $y] -ge $TreeGrid[$x, $y])
                {
                    $FoundVisible[1] = $false
                    break
                }
            }
            for ($ySearchIterate = 0; $ySearchIterate -lt $y; $ySearchIterate++) # Search for vert match from top
            {
                if ($TreeGrid[$x, $ySearchIterate] -ge $TreeGrid[$x, $y])
                {
                    $FoundVisible[2] = $false
                    break
                }
            }
            for ($ySearchIterate = $y + 1; $ySearchIterate -lt $yMax; $ySearchIterate++) # Search for vert match from bottom
            {
                if ($TreeGrid[$x, $ySearchIterate] -ge $TreeGrid[$x, $y])
                {
                    $FoundVisible[3] = $false
                    break
                }
            }
            if ($FoundVisible -contains $true) {$VisibleCount++} # Match found
        }
    }
}

Write-Host "Day 8 p1: $VisibleCount"

# Part 2
$ViewGrid = New-Object 'object[,]' $xMax, $yMax # Create 2d array for view score from each tree
for ($y = 0; $y -lt $yMax; $y++)
{
    for ($x = 0; $x -lt $xMax; $x++)
    {
        $Up = $Down = $Left = $Right = 0
        if ($x -ne 0) # Check left
        {
            for ($xSearchIterate = $x - 1; $xSearchIterate -ge 0; $xSearchIterate--)
            {
                $Left++
                if ($TreeGrid[$xSearchIterate, $y] -ge $TreeGrid[$x, $y]) {break}
            }
        }
        if ($x -ne $xMax - 1) # Check right
        {
            for ($xSearchIterate = $x + 1; $xSearchIterate -le $xMax; $xSearchIterate++)
            {
                $Right++
                if ($TreeGrid[$xSearchIterate, $y] -ge $TreeGrid[$x, $y]) {break}
            }
        }
        if ($y -ne 0) # Check up
        {
            for ($ySearchIterate = $y - 1; $ySearchIterate -ge 0; $ySearchIterate--)
            {
                $Up++
                if ($TreeGrid[$x, $ySearchIterate] -ge $TreeGrid[$x, $y]) {break}
            }
        }
        if ($y -ne $yMax - 1) # Check down
        {
            for ($ySearchIterate = $y + 1; $ySearchIterate -le $yMax; $ySearchIterate++)
            {
                $Down++
                if ($TreeGrid[$x, $ySearchIterate] -ge $TreeGrid[$x, $y]) {break}
            }
        }
        $ViewGrid[$x, $y] = $Up * $Down * $Left * $Right
    }
}

Write-Host "Day 8 p2: $(($ViewGrid | Sort-Object -Descending)[0])"