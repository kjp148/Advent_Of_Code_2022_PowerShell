# Map folder structure
$CurrentFolder = ""
$Folders = @{}
foreach ($Command in (Get-Content .\Input\day7.txt))
{
    $SplitCommand = $Command -split " "
    switch ($SplitCommand[0])
    {
        "$" {
            if ($SplitCommand[1] -eq "cd")
            {
                switch ($SplitCommand[2])
                {
                    ".." { # Back one folder
                        $SplitFolders = $CurrentFolder -split "/"
                        $CurrentFolder = ($SplitFolders[0..($SplitFolders.Length - 3)] -join "/") + "/" # Remove last folder from current path
                    }
                    "/" { # Handling for root
                        $CurrentFolder = "/"
                        $Folders[$CurrentFolder] = @{size = 0; items = @()} # Add item to array key=FolderPath value=EmptyArrayForFiles
                    }
                    default { # Add folder to current path
                        $CurrentFolder += "$($SplitCommand[2])/"
                        $Folders[$CurrentFolder] = @{size = 0; items = @()} # Add item to array key=FolderPath value=EmptyArrayForFiles
                    }
                }
                # Looks like we can ignore the ls command "ls" {} # List
            }
        }
        default {$Folders[$CurrentFolder].items += $Command} # File or folder, add to the hashtable element's array
    }
}

<# Folder sizing pseudocode
Recursive foreach function
FolderSearch($CurrentFolder)

function FolderSearch ($Folder)
{
    if ($Folders[$Folder].contains(Any folder)
    {
        foreach ($Subfolder in ($Folders[$Folder].subfolders))
        {
            FolderSearch ($Subfolder)
        }
    }
}#>

# Find size of each folder
function Get-FolderSize ([Object]$Folder, [String]$Path)
{
    $Folder.items | ForEach-Object {
        if ($_ -like "dir *")
        {
            $NewPath = $Path + ($_ -split " ")[1] + "/"
            $Folder.size += [int](Get-FolderSize -Folder $Folders[$NewPath] -Path $NewPath)
        }
        else
        {
            $Folder.size += [int]($_ -split " ")[0]
        }
    }

    return $Folder.size
}

Get-FolderSize -Folder $Folders["/"] -Path "/" | Out-Null