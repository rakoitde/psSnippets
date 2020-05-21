

Install-Module InstallModuleFromGitHub
Install-ModuleFromGitHub -GitHubRepo /dfinke/ImportExcel
Import-Module ImportExcel

$env:PSModulePath

### Active Directory

## Remoteserver-Verwaltungstools für Windows 10
https://www.microsoft.com/de-de/download/details.aspx?id=45520

if(get-module -list activedirectory){ 
  Import-Module activedirectory 
} else {
  write-warning "Install RSAT Tools"
}

