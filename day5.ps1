# Get current container state
$InputArray = Get-Content .\Input\day5.txt
$InstructionsBeginIndex = $InputArray.IndexOf(($InputArray -like ("move*"))[0])
$RawContainerArray = $InputArray[0..($InstructionsBeginIndex - 3)]
[array]::Reverse($RawContainerArray)
$ContainerArray = [array[]]::new(($InputArray[$InstructionsBeginIndex - 2] -replace " ", "").length) # Create new container array with length of the available container slots.
foreach ($Row in $RawContainerArray)
{
    # Loop through every four characters starting at position 2
    $ContainerPositionIterate = 0
    for ($i = 1; $i -lt $Row.Length; $i += 4)
    {
        if ($Row.ToCharArray()[$i] -ne " ")
        {
            $ContainerArray[$ContainerPositionIterate] += $Row.ToCharArray()[$i]
        }
        $ContainerPositionIterate++
    }
}

# Get an array of all instructions
$InstructionsArray = @()
foreach ($Instruction in $InputArray[($InstructionsBeginIndex)..($InputArray.Length - 1)])
{
    $InstructionSplit = $Instruction -split " "
    $InstructionsArray += @{
        Amount = [int]$InstructionSplit[1];
        Source = ([int]$InstructionSplit[3] - 1);
        Destination = ([int]$InstructionSplit[5] - 1)
    }
}

$ContainerArrayPart2 = @()
$ContainerArrayPart2 += $ContainerArray # Create copy for part 2 before ContainerArray is modified.

# PART 1 Perform instructions on ContainerArray
foreach ($Instruction in $InstructionsArray)
{
    $Src = $Instruction.Source
    for ($i = 0; $i -lt $Instruction.Amount; $i++)
    {
        # Add element to end of destination array
        $ContainerArray[$Instruction.Destination] += ($ContainerArray[$Src][$ContainerArray[$Src].Length - 1])
        # Remove last element from source array by setting it equal to itself minus the last element.
        $ContainerArray[$Src] = $ContainerArray[$Src][0..($ContainerArray[$Src].Length - 2)]
    }
}

# PART 2 Perform instructions on ContainerArray
foreach ($Instruction in $InstructionsArray)
{
    $Src = $Instruction.Source
    Write-Host "Debug: move $($Instruction.Amount) from $Src to $($Instruction.Destination)"
    Write-Host "Debug before: $($ContainerArrayPart2[$Instruction.Source]) -> $($ContainerArrayPart2[$Instruction.Destination])"
    # Add section to end of destination array
    $ContainerArrayPart2[$Instruction.Destination] += ($ContainerArrayPart2[$Src][($ContainerArrayPart2[$Src].Length - $Instruction.Amount)..($ContainerArrayPart2[$Src].Length - 1)])
    # Remove AMOUNT elements from source array by setting it equal to itself minus AMOUNT elements.
    if ($Instruction.Amount -eq $ContainerArrayPart2[$Src].Length)
    {
        $ContainerArrayPart2[$Src] = @()
    }
    else
    {
        $ContainerArrayPart2[$Src] = $ContainerArrayPart2[$Src][0..($ContainerArrayPart2[$Src].Length - $Instruction.Amount - 1)]
    }
    Write-Host "Debug after:  $($ContainerArrayPart2[$Instruction.Source]) -> $($ContainerArrayPart2[$Instruction.Destination])"
}

# PART 1 Create string of top containers
$Part1ContainerString = ""
$ContainerArray | ForEach-Object {
    $Part1ContainerString += $_[$_.Length - 1]
}

# PART 2 Create string of top containers
$Part2ContainerString = ""
$ContainerArrayPart2 | ForEach-Object {
    $Part2ContainerString += $_[$_.Length - 1]
}

Write-Host "Day 5 p1: $Part1ContainerString"
Write-Host "Day 5 p2: $Part2ContainerString"