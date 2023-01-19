param($UEVersion)

function SetEnvVar( $name, $value ) {
	Invoke-Expression "`$env:$name='$value'"
	echo "$name=$value" >> $env:GITHUB_ENV;
}

Get-ChildItem -Path ./.metadata | ForEach-Object {
	$varname = $_.Name
	$value = Get-Content $_.Fullname -TotalCount 1

	SetEnvVar $varname $value
}

SetEnvVar "releaseName" (Invoke-Expression """$env:releaseFormat""")
SetEnvVar "releaseSHA" "$(git rev-parse HEAD)"
SetEnvVar "releaseDate" "$(Get-Date -Format "yyyy, M, d")"
SetEnvVar "UEVersion" "$UEVersion"
