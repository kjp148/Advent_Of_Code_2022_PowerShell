$PointsTotal = 0
Get-Content .\input\day2.txt | ForEach-Object {
    $OpponentMove = ($_ -split " ")[0]
    $MyMove = ($_ -split " ")[1]

    switch ($OpponentMove)
    {
        "A" {
            switch ($MyMove)
            {
                "X" {$PointsTotal += 1 + 3}
                "Y" {$PointsTotal += 2 + 6}
                "Z" {$PointsTotal += 3}
            }
        }
        "B" {
            switch ($MyMove)
            {
                "X" {$PointsTotal += 1}
                "Y" {$PointsTotal += 2 + 3}
                "Z" {$PointsTotal += 3 + 6}
            }
        }
        "C" {
            switch ($MyMove)
            {
                "X" {$PointsTotal += 1 + 6}
                "Y" {$PointsTotal += 2}
                "Z" {$PointsTotal += 3 + 3}
            }
        }
    }
}

Write-Host Day 2 p1: $PointsTotal