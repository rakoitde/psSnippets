<#
.Synopsis
   Ließt ein Anmeldeinformationsobjekt aus der $user.xml im Homedir und gibt diese zurück
.DESCRIPTION
   Ließt ein Anmeldeinformationsobjekt aus der $user.xml im Homedir und gibt diese zurück. Wenn keine $user.xml existiert, wird ein write-myCredential ausgeführt.
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
   $cred = Read-Credential
.EXAMPLE
   $cred = Read-Credential -user Username
.EXAMPLE
   $cred = Read-Credential -user Username -ConvertPasswort
#>
Function Read-Credential {
    [CmdLetBinding()]
    Param(
        [string]$User=$env:USERNAME,
        [switch]$ConvertPasswort
    )

    If (Test-Path -Path "$($env:HOMEDRIVE)$($env:homepath)\$user.xml") {
        $credential = Import-Clixml "$($env:HOMEDRIVE)$($env:homepath)\$user.xml"
        Write-Verbose "Datei $($env:HOMEDRIVE)$($env:homepath)\$user.xml geladen"
    } else {
        Write-Warning "Datei $($env:HOMEDRIVE)$($env:homepath)\$user.xml nicht gefunden. Schreibe Credential in Datei"
        $credential = Write-Credential -user $user
    }

    IF ($ConvertPasswort) {
        $credential | Select-Object Username, @{n="Domain"; e={$_.GetNetworkCredential().domain}},  @{n="User"; e={$_.GetNetworkCredential().username}}, @{ n="Password"; e={$_.GetNetworkCredential().Password} }
    } Else {
        $credential
    }
}