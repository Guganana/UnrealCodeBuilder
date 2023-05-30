param ([string]$UEVersion)

function SetEnvVar( $name, $value ) {
	Invoke-Expression "`$env:$name='$value'"
	echo "$name=$value" >> $env:GITHUB_ENV;
}

SetEnvVar "releaseSHA" "$(git rev-parse HEAD)"
SetEnvVar "releaseDate" "$(Get-Date -Format "yyyy, M, d")"
SetEnvVar "UEVersion" "$UEVersion"


if (Test-Path -Path ./.codebuilder/metadata) 
{
	Get-ChildItem -Path ./.codebuilder/metadata | ForEach-Object {
		$varname = $_.Name
		$value = Get-Content $_.Fullname -TotalCount 1

		SetEnvVar $varname $value
	}
	
	SetEnvVar "releaseVersion" (Invoke-Expression """$env:releaseVersionFormat""")
	SetEnvVar "releaseName" (Invoke-Expression """$env:releaseNameFormat""")
}
else
{
	Write-Warning "Unable to find .codebuilder/metadata folder in root directory of project"
	Write-Warning "Will use default release version and format..."
	
	SetEnvVar "releaseName" "Placeholder"
	SetEnvVar "releaseVersion" "Placeholder-$env:releaseSHA-@$UEVersion"
}


