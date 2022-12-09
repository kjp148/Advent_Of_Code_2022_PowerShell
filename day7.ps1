$CurrentFolder = ""
foreach ($Command in (Get-Content .\Input\day7.txt))
{
    switch (($Command -split " ")[0])
    {
        "$" {
            switch (($Command -split " ")[1])
            {
                "cd" {Write-Host $Command}
                "ls" {Write-Host $Command}
            }
        }
        "dir" {
            
        }
    }
}