; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

; Extraido o numero de Vers�o do arquivo "VERSAO.TXT"
#define FileHandle = FileOpen(AddBackslash(SourcePath) + "versao.txt")
#define FileLine = FileRead(FileHandle)
#define FileHandle FileClose(FileHandle)
#define MyAppVersion Str( FileLine )
#define MyAppVersion copy( MyAppVersion, pos("'", MyAppVersion) + 1, pos(";", MyAppVersion) )
#define MyAppVersion Copy( MyAppVersion, 0, pos("'", MyAppVersion) - 1 )

#define MyAppName "ACBrNFeMonitor"
#define MyAppVerName "ACBrNFeMonitor2-OpenSSL-"+MyAppVersion
#define MyAppPublisher "Projeto ACBr"
#define MyAppURL "http://acbr.sourceforge.net/drupal/"
#define MyAppUrlName "ACBrNFeMonitor.url"
#define MyAppExeName "ACBrNFeMonitor.exe"
#define QTDLL "qtintf70.dll"

[Setup]
AppName={#MyAppName}
AppVerName={#MyAppVerName}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={sd}\{#MyAppName}
DefaultGroupName={#MyAppName}
LicenseFile=licenca.txt
OutputBaseFilename={#MyAppVerName}-Windows-Instalador
Compression=lzma
SolidCompression=yes
AppMuTex=ACBrNFeMonitor

[Types]
Name: compact; Description: Instala��o M�nima
Name: full; Description: Instala��o Completa
Name: custom; Description: Instala��o Customizada; Flags: iscustom

[Components]
Name: programa; Description: Programa ACBrNFeMonitor; Types: full compact custom; Flags: fixed
Name: help; Description: Arquivos de Ajuda; Types: full custom
Name: exemplos; Description: Exemplos de Uso; Types: full custom

[Languages]
Name: brazilianportuguese; MessagesFile: compiler:Languages\BrazilianPortuguese.isl

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
Source: ACBrNFeMonitor.exe; DestDir: {app}; Flags: ignoreversion; Components: programa
Source: banner_acbrmonitor.gif; DestDir: {app}; Flags: ignoreversion; Components: programa
Source: leia-me.txt; DestDir: {app}; Flags: isreadme ignoreversion; Components: programa
Source: LICENCA.TXT; DestDir: {app}; Flags: ignoreversion; Components: programa
Source: LICENSE.TXT; DestDir: {app}; Flags: ignoreversion; Components: programa
Source: ACBrNFeMonitor.chm; DestDir: {app}; Flags: ignoreversion; Components: help
Source: ACBrNFeMonitor.pdf; DestDir: {app}; Flags: ignoreversion; Components: help
;Source: {#QTDLL}; DestDir: {sys}; Flags: ; Components: programa
Source: ..\..\..\DLLs\OpenSSL\libeay32.dll; DestDir: {app}; Flags: ; Components: programa
Source: ..\..\..\DLLs\OpenSSL\ssleay32.dll; DestDir: {app}; Flags: ; Components: programa
Source: ..\..\..\DLLs\XMLSec\libxml2.dll; DestDir: {app}; Flags: ; Components: programa
Source: ..\..\..\DLLs\XMLSec\libxmlsec.dll; DestDir: {app}; Flags: ; Components: programa
Source: ..\..\..\DLLs\XMLSec\libxmlsec-openssl.dll; DestDir: {app}; Flags: ; Components: programa
Source: ..\..\..\DLLs\XMLSec\libxslt.dll; DestDir: {app}; Flags: ; Components: programa
Source: ..\..\..\DLLs\XMLSec\zlib1.dll; DestDir: {app}; Flags: ; Components: programa
Source: ..\..\..\DLLs\Diversos\iconv.dll; DestDir: {app}; Flags: ; Components: programa
Source: ..\..\..\DLLs\MSVCR\msvcr71.dll; DestDir: {app}; Flags: ; Components: programa
Source: Report\*.*; DestDir: {app}\Report; Components: programa; 
Source: Schemas\*.*; DestDir: {app}\Schemas; Components: programa; 
Source: MunIBGE\*.*; DestDir: {app}\MunIBGE; Flags: ; Components: programa
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[INI]
Filename: {app}\{#MyAppUrlName}; Section: InternetShortcut; Key: URL; String: {#MyAppURL}; Components: help

[Icons]
Name: {group}\{#MyAppName}; Filename: {app}\{#MyAppExeName}; WorkingDir: {app}; Components: programa
Name: {group}\LEIA-ME.TXT; Filename: notepad; Parameters: leia-me.txt; WorkingDir: {app}; Components: help
Name: {group}\Manual do ACBrNFeMonitor; Filename: {app}\ACBrNFeMonitor.chm; WorkingDir: {app}; Components: help
Name: {userdesktop}\{#MyAppName}; Filename: {app}\{#MyAppExeName}; WorkingDir: {app}; Tasks: desktopicon
Name: {userstartup}\{#MyAppName}; Filename: {app}\{#MyAppExeName}; WorkingDir: {app}
Name: {group}\{cm:ProgramOnTheWeb,{#MyAppName}}; Filename: {app}\{#MyAppUrlName}; Components: help

[Run]
Filename: {app}\{#MyAppExeName}; Description: {cm:LaunchProgram,{#MyAppName}}; Flags: nowait postinstall skipifsilent

