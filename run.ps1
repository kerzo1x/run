$file = $args[0]
$extraArgs = $args[1..$args.Length] 
$ext = [System.IO.Path]::GetExtension($file).ToLower()
$fileName = [System.IO.Path]::GetFileNameWithoutExtension($file)
switch ($ext) {
    ".js" {
        if (-not (Get-Command bun -ErrorAction SilentlyContinue)) {
        Write-Host "bun is not installed, download? (y/n)"
        $answer = Read-Host
        if ($answer -eq "y" -or $answer -eq "Y" -or $answer -eq "yes" -or $answer -eq "Yes") {
            irm bun.sh/install.ps1 | iex
        } else {
            Write-Host "canceled"
            exit
        }
        }
        Write-Host "running JS..." 
        & "bun" $file @extraArgs }
    ".py" { 
        Write-Host "Running Python" 
    }
    ".c" { 
        Write-Host "Running C"
        if (-not (Get-Command gcc -ErrorAction SilentlyContinue)) {
        Write-Host "gcc is not installed, download it please"
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