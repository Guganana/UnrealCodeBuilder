Param(
    [string]$BaseDir,
    [string[]]$Exceptions
)

$TempDir = "$BaseDir-Temp";

if (Test-Path $TempDir)
{
    Remove-Item -Path $TempDir -Recurse
}

New-Item -ItemType Directory -Path $TempDir -Force


foreach ($exception in $Exceptions)
{
    #check if folder exists
    if (Test-Path "$BaseDir/$exception")
    {
        Write-Host "Copying $BaseDir/$exception to $TempDir/$plugin"
        Copy-Item -Path "$BaseDir/$exception" -Destination "$TempDir/$exception" -Recurse
    }
}

$FolderName = (Get-Item $BaseDir).Name;
Remove-Item -Path $BaseDir -Recurse -Force
Rename-Item -Path $TempDir -NewName $FolderName

