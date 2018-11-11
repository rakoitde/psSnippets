<#
.Synopsis
    psSnippets
.NOTES
    Autor          Date           Änderung
    Kornberger     09.11.2018     Module created

#>

# Modul PS1 Dateien laden -> Alle ps1 Files im Ordner des Moduls werden geladen
(get-childitem $PSScriptRoot -Filter "*.ps1") | % { . $_.FullName  }


