$CurrentFolder = ""
$Folders = @{}
foreach ($Command in (Get-Content .\Input\day7.txt))
{
    switch (($Command -split " ")[0])
    {
        "$" {
            if (($Command -split " ")[1] -eq "cd")
            {
                switch (($Command -split " ")[2])
                {
                    ".." {
                        # Remove last folder from current path
                        $SplitFolders = $CurrentFolder -split "/"
                        $CurrentFolder = ($SplitFolders[0..($SplitFolders.Length - 3)] -join "/") + "/"
                    }
                    "/" { # Handling for root
                        $CurrentFolder = "/"
                        $Folders[$CurrentFolder] = @()
                    }
                    default { # Add folder to current path
                        $CurrentFolder += "$(($Command -split " ")[2])/"
                        $Folders[$CurrentFolder] = @()
                    }
                }
                # Looks like we can ignore the ls command "ls" {#List}
            }
        }
        "dir" {}#Folder
        default {$Folders[$CurrentFolder] += $Command}#File
    }
}