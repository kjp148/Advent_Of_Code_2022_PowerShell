$Part1PointsTotal = 0
$Part2PointsTotal = 0
Get-Content .\input\day2.txt | ForEach-Object {
    $OpponentMove = ($_ -split " ")[0]
    $MyMove = ($_ -split " ")[1]

    switch ($OpponentMove)
    {
        "A" {
            switch ($MyMove)
            {
                "X" {$Part1PointsTotal += 1 + 3; $Part2PointsTotal += 2 + 0} # Rock/Lose(Paper)
                "Y" {$Part1PointsTotal += 2 + 6; $Part2PointsTotal += 1 + 3} # Paper/Draw(Rock)
                "Z" {$Part1PointsTotal += 3 + 0; $Part2PointsTotal += 3 + 6} # Scissors/Win(Scissors)
            }
        }
        "B" {
            switch ($MyMove)
            {
                "X" {$Part1PointsTotal += 1 + 0; $Part2PointsTotal += 1 + 0} # Rock/Lose(Rock)
                "Y" {$Part1PointsTotal += 2 + 3; $Part2PointsTotal += 2 + 3} # Paper/Draw(Paper)
                "Z" {$Part1PointsTotal += 3 + 6; $Part2PointsTotal += 3 + 6} # Scissors/Win(Scissors)
            }
        }
        "C" {
            switch ($MyMove)
            {
                "X" {$Part1PointsTotal += 1 + 6; $Part2PointsTotal += 2 + 0} # Rock/Lose(Paper)
                "Y" {$Part1PointsTotal += 2 + 0; $Part2PointsTotal += 3 + 3} # Paper/Draw(Scissors)
                "Z" {$Part1PointsTotal += 3 + 3; $Part2PointsTotal += 1 + 6} # Scissors/Win(Rock)
            }
        }
    }
}

Write-Host "Day 2 p1: $Part1PointsTotal"
Write-Host "Day 2 p2: $Part2PointsTotal"