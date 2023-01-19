
Get-childitem -recurse -filter ".vs*" -Force | Remove-Item -Force -Recurse -Verbose
Get-childitem -recurse -filter ".git*" -Force | Remove-Item -Force -Recurse -Verbose
Remove-Item -Recurse -Force ./Intermediate
Remove-Item -Recurse -Force ./Binaries  
Remove-Item -Recurse -Force ./*metadata -ErrorAction Ignore
