param
(
    [switch]$KeepGit = $false
)

Get-childitem -recurse -filter ".vs*" -Force | Remove-Item -Force -Recurse -Verbose
if(!$KeepGit)
{
  Get-childitem -recurse -filter ".git*" -Force | Remove-Item -Force -Recurse -Verbose
}

Remove-Item -Recurse -Force ./Intermediate -ErrorAction Ignore
Remove-Item -Recurse -Force ./Binaries -ErrorAction Ignore
Remove-Item -Recurse -Force ./metadata -ErrorAction Ignore
