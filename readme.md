

Install-Module InstallModuleFromGitHub
Install-ModuleFromGitHub -GitHubRepo /dfinke/ImportExcel
Import-Module ImportExcel

$env:PSModulePath

if(get-module -list activedirectory){'found'}
