$file = $args[0]
$extraArgs = $args[1..$args.Length] 
$ext = [System.IO.Path]::GetExtension($file).ToLower()
$fileName = [System.IO.Path]::GetFileNameWithoutExtension($file)

switch ($ext) {
    ".js" {
        if (-not (Get-Command bun -ErrorAction SilentlyContinue)) {
        Write-Host "Братишь bun-а нема как так, качаем? (y/n)"
        $answer = Read-Host
        if ($answer -eq "y" -or $answer -eq "Y" -or $answer -eq "yes" -or $answer -eq "Yes") {
            irm bun.sh/install.ps1 | iex
        } else {
            Write-Host "ну и хуй с ним пака"
            exit
        }
        }
        Write-Host "running JS..." 
        & "bun" $file @extraArgs }
    ".py" { 
        $pythonCmd = (Get-Command python, py -ErrorAction SilentlyContinue | Select-Object -First 1).Name
        if (-not $pythonCmd) {
        Write-Host "Python? Py? Нихуя не нашел. Накати нормально криворукое блядь." -ForegroundColor Red
        exit
        }
        & $pythonCmd $file @extraArgs
        }
    ".c" { 
        Write-Host "Running C"
        if (-not (Get-Command gcc -ErrorAction SilentlyContinue)) {
        Write-Host "Нене без gcc никуда качай давай, а если скачано в PATH добавь"
        exit
        }
        & "gcc" "./$file" "-o" "./$fileName.exe"
        if($?) {
            & "$fileName.exe"
            Remove-Item -Path ./"$fileName.exe"
        }
        }
    default { 
        Write-Host "Not supported extention yet" 
    }
}