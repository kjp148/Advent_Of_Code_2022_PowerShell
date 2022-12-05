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

# Perform instructions on ContainerArray
foreach ($Instruction in $InstructionsArray)
{
    for ($i = 0; $i -lt $Instruction.Amount; $i++)
    {
        # Add element to end of destination array
        $ContainerArray[$Instruction.Destination] += ($ContainerArray[$Instruction.Source][$ContainerArray[$Instruction.Source].Length - 1])
        # Remove last element from source array by setting it equal to itself minus the last element.
        $ContainerArray[$Instruction.Source] = $ContainerArray[$Instruction.Source][0..($ContainerArray[$Instruction.Source].Length - 2)]
    }
}

# Create string of top containers
$Part1ContainerString = ""
$ContainerArray | ForEach-Object {
    $Part1ContainerString += $_[$_.Length - 1]
}

Write-Host "Day 5 p1: $Part1ContainerString"