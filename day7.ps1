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
                        $Folders[$CurrentFolder] = @() # Add item to array key=FolderPath value=EmptyArrayForFiles
                    }
                    default { # Add folder to current path
                        $CurrentFolder += "$($SplitCommand[2])/"
                        $Folders[$CurrentFolder] = @() # Add item to array key=FolderPath value=EmptyArrayForFiles
                    }
                }
                # Looks like we can ignore the ls command "ls" {} # List
            }
        }
        "dir" {} # Folder, ignore
        default {$Folders[$CurrentFolder] += $Command} # File
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