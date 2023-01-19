
Get-childitem -recurse -filter ".vs*" -Force | Remove-Item -Force -Recurse -Verbose
Get-childitem -recurse -filter ".git*" -Force | Remove-Item -Force -Recurse -Verbose
Remove-Item -Recurse -Force ./Intermediate
Remove-Item -Recurse -Force ./Binaries  
Remove-Item -Recurse -Force ./*metadata -ErrorAction Ignore

$upluginFiles = Get-ChildItem -Filter "*.uplugin" -Recurse -Force
foreach ($Child in $upluginFiles)
{
    (Get-Content $Child.FullName) -Replace 'ENGINE_VERSION', "$env:UEVersion" | Set-Content $Child.FullName
}
