$scriptName = $MyInvocation.MyCommand.Name

Write-Host "Owner ${Env:REPO_OWNER}"
Write-Host "Repository ${Env:REPO}"

$PROJECT_PATH = ".\$($Env:PROJECT_NAME)\$($Env:PROJECT_NAME).csproj"
$NUGET_PACKAGE_PATH = ".\artifacts\$($Env:PROJECT_NAME).$($Env:VERSION_NUMBER).nupkg"

Write-Host "Project Path ${PROJECT_PATH}"
Write-Host "Package Path ${NUGET_PACKAGE_PATH}"

dotnet build $PROJECT_PATH --configuration Release

if ($Env:REPO_OWNER -ne "BlaiseD") {
    Write-Host "${scriptName}: Runs on BlaiseD repositories."
} else {
    dotnet pack $PROJECT_PATH -c Release -o .\artifacts --no-build
    dotnet nuget push $NUGET_PACKAGE_PATH --skip-duplicate
}
