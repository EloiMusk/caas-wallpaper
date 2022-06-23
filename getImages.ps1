using module modules\WConfig.psm1

$conf = [WConfig]::new()
$conf.init($PSScriptRoot)
[int]$count = $conf.images.imageCount
[int]$i = 0
Remove-Item $PSScriptRoot/wallpapers/*
while ($count -ge $i)
{
    Invoke-WebRequest https://cataas.com/c -o $PSScriptRoot\wallpapers\cat$i.png
    $i++
}