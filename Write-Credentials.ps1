<#
.Synopsis
   Ruft ein Anmeldeinformationsobjekt basierend auf einem Benutzernamen und Kennwort ab und speichert dieses als $user.xml im Homedir
.DESCRIPTION
   Ruft ein Anmeldeinformationsobjekt basierend auf einem Benutzernamen und Kennwort ab und speichert dieses als $user.xml im Homedir
.PARAMETER User
    Benutzername, kann auch aus Domein\Benutzername bestehen
.PARAMETER ConvertPasswort
    Gibt im zurückgegebenen PsCustomObject das Passwort im Klartext aus
.OUTPUTS
    TypeName: System.Management.Automation.PSCredential

    Name                 MemberType Definition                                                                                                                                                                                         
    ----                 ---------- ----------                                                                                                                                                                                                                                                                                                                                                                         
    Password             Property   securestring Password {get;}                                                                                                                                                                       
    UserName             Property   string UserName {get;}
.NOTES
    Autor      Date       Änderung
    Kornberger 27.05.2017
.EXAMPLE
   $cred = Write-Credential
.EXAMPLE
   $cred = Write-Credential -user domain\username
.EXAMPLE
   $cred = Write-Credential -user domain\username -ConvertPasswort
#>
Function Write-Credential {
    [CmdLetBinding()]
    Param(
        [string]$user=$env:USERNAME,
        [switch]$ConvertPasswort
    )
    $Credential = Get-Credential -user $user -Message "Domain\User"
    $user = $credential.GetNetworkCredential().username
    $credential | Export-Clixml "$($env:HOMEDRIVE)$($env:homepath)\$user.xml"
    Write-Verbose "Datei $($env:HOMEDRIVE)$($env:homepath)\$user.xml geschrieben"
    IF ($ConvertPasswort) {
        $credential | Select-Object Username, @{n="Domain"; e={$_.GetNetworkCredential().domain}},  @{n="User"; e={$_.GetNetworkCredential().username}}, @{ n="Password"; e={$_.GetNetworkCredential().Password} }
    } Else {
        $credential
    }
}


