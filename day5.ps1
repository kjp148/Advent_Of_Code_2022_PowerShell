<#Pseudocode
    Reverse loop through first X lines to get the container order.
        Where X is the three lines less than the first occurence of "move"
        Put this into a 2d array.
        Use direct column position as the data doesn't change
            Still check if the location is blank so it works for other similar inputs
    Create array of instructions (Get-content starting at first "move")
        amount = split " "[1]
        source = split " "[3]
        destination = split " "[5]

    Perform each move
        example: move 7 from 3 to 9
        for ($i = 0; $i -lt amount; $i++)
        {
            Add element to end of destination array
            $ContainerArray[destination].Add($ContainerArray[source][lastIndex])
            Remove last element from source array by setting it equal to itself minus the last element.
            $containerArray[source] = $containerArray[source][0..($ContainerArray[source].Count - 2)]
        }

    Get the top container of each array
        $TopContainers = ""
        $ContainerArray | Foreach-object {
            $TopContainers += $_[$_.Count - 1]
        }
#>

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
        Source = [int]$InstructionSplit[3];
        Destination = [int]$InstructionSplit[5]
    }
}