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

function Get-FolderSize ([Object]$Folder, [String]$Path) # Recursive function for finding the size of each folder
{
    $Folder.items | ForEach-Object {
        if ($_ -like "dir *")
        {
            $NewPath = $Path + ($_ -split " ")[1] + "/"
            $Folder.size += [int](Get-FolderSize -Folder $Folders[$NewPath] -Path $NewPath) # Add subfolder's size
        }
        else {$Folder.size += [int]($_ -split " ")[0]} # Add file's size
    }
    return $Folder.size # Return folder's size to parent folder
}

Get-FolderSize -Folder $Folders["/"] -Path "/" | Out-Null

$Part1Output = ($Folders.GetEnumerator() | Where-Object {$_.Value.size -le 10000} | Select-Object -Property @{label = "size"; expression = {[int]$_.Value.size}} | Measure-Object -Property size -Sum).Sum

#$Folders.GetEnumerator() | Select-Object -Property Key, @{label = "size"; expression = {[int]$_.Value.size}} | Sort-Object -Property size

# Output tree
function Get-FileTree ([Object]$Folder, [String]$Path) # Recursive function for finding the size of each folder
{
    $Folder.items | Sort-Object -Descending | ForEach-Object {
        if ($_ -like "dir *")
        {
            $NewPath = $Path + ($_ -split " ")[1] + "/"
            Write-Host "$($Indent.Substring(0, $Indent.Length - 4))\---/$(($_ -split " ")[1])/"
            $Indent = "|   " + $Indent
            Get-FileTree -Folder $Folders[$NewPath] -Path $NewPath
            $Indent = $Indent.Substring(4)
        }
        else {Write-Host "$($Indent.Substring(4))    $_"}
    }
}

$Indent = "|   "
Get-FileTree -Folder $Folders["/"] -Path "/" | Out-Null