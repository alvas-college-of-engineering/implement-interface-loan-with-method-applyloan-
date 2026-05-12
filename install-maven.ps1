$version = '3.9.10'
$zipUrl = "https://archive.apache.org/dist/maven/maven-3/$version/binaries/apache-maven-$version-bin.zip"
$destZip = Join-Path $env:TEMP "apache-maven-$version-bin.zip"
Write-Host "Downloading Maven from $zipUrl"
Invoke-WebRequest -Uri $zipUrl -OutFile $destZip -UseBasicParsing
$installDir = Join-Path $env:USERPROFILE 'maven'
if (-not (Test-Path $installDir)) {
    New-Item -Path $installDir -ItemType Directory | Out-Null
}
Expand-Archive -Path $destZip -DestinationPath $installDir -Force
$mavenHome = Join-Path $installDir "apache-maven-$version"
if (-not (Test-Path $mavenHome)) {
    throw 'Maven unzip failed'
}
$mavenBin = Join-Path $mavenHome 'bin'
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
if ($userPath -notlike ('*' + $mavenBin + '*')) {
    $newPath = $mavenBin + ';' + $userPath
    [Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
    Write-Host 'Added Maven bin to user PATH'
} else {
    Write-Host 'Maven bin already in user PATH'
}
$env:PATH = $mavenBin + ';' + $env:PATH
Write-Host 'Maven install complete.'
Write-Host 'Please restart your terminal or use a new shell session to load the updated PATH.'
