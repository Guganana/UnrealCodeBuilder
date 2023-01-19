
$Results = Get-ChildItem -Filter PluginInformation.h -Recurse -Force
foreach ($Child in $Results)
{
    (Get-Content $Child.FullName) -Replace 'NO_VERSION', $env:friendlyVersion | Set-Content $Child.FullName
    (Get-Content $Child.FullName) -Replace 'NO_SHA', $env:releaseSHA.Substring(0, 7) | Set-Content $Child.FullName
    (Get-Content $Child.FullName) -Replace "FDateTime::Now\(\)", "FDateTime($env:releaseDate)" | Set-Content $Child.FullName
}

$UnixTimestamp = [int][double]::Parse((Get-Date -UFormat %s))
$VersionNumber = "$UnixTimestamp"

$UPlugin = Get-ChildItem -Filter "*.uplugin" -Recurse -Force
foreach ($Child in $UPlugin)
{
    (Get-Content $Child.FullName) -Replace 'DEV_VERSION_NAME', $env:releaseName | Set-Content $Child.FullName
    (Get-Content $Child.FullName) -Replace '123456789', $VersionNumber | Set-Content $Child.FullName
    (Get-Content $Child.FullName) -Replace 'ENGINE_VERSION', "$env:UEVersion" | Set-Content $Child.FullName
}
