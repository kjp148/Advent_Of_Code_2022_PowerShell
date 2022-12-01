$CalorieTotalArray = (((Get-Content .\input\day1.txt -Raw) -split "\n\n") | ForEach-Object {($_ -split "\n" | Measure-Object -Sum).Sum} | Sort-Object -Descending)

Write-Host "Day 1 p1: $($CalorieTotalArray[0])"
Write-Host "Day 2 p2: $($CalorieTotalArray[0] + $CalorieTotalArray[1] + $CalorieTotalArray[2])"