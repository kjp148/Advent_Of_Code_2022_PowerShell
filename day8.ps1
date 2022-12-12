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