$RawInput = Get-Content .\Input\day8.txt
$xMax = $RawInput[0].Length # Left to right in the file
$yMax = $RawInput.Length # Top to bottom in the file
$TreeGrid = New-Object 'object[,]' $xMax, $yMax # Create 2d array
for ($y = 0; $y -lt $yMax; $y++) # Populate 2d array with coords
 {
    for ($x = 0; $x -lt $xMax; $x++)
    {
        $TreeGrid[$x, $y] = $RawInput[$y].ToCharArray()[$x]
    }
}

# Count trees visible from the edge
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