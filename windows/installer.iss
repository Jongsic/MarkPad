; MarkPad per-user installer (Inno Setup 6).
; Compile after build.cmd:  ISCC installer.iss  [/DAppVersion=1.0.0]
; Installs to %LOCALAPPDATA%\Programs\MarkPad (no admin), adds a Start Menu
; entry, registers the .md file association, and shows up in Settings > Apps
; with a real uninstaller. The release workflow ships the result as
; MarkPad-Setup-<version>.exe.

#ifndef AppVersion
  #define AppVersion "1.3.1"
#endif

[Setup]
AppId={{9C3B5E64-2A47-4D2E-9F6B-1B8C1D4E7A21}
AppName=MarkPad
AppVersion={#AppVersion}
AppPublisher=Jongsic
AppPublisherURL=https://github.com/Jongsic/MarkPad
AppSupportURL=https://github.com/Jongsic/MarkPad/issues
DefaultDirName={autopf}\MarkPad
PrivilegesRequired=lowest
; MIT license shown up front; its as-is / no-liability terms must be
; accepted before installing. Also installed next to the app.
LicenseFile=..\LICENSE
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\MarkPad.exe
OutputDir=bin
OutputBaseFilename=MarkPad-Setup-{#AppVersion}
Compression=lzma2
SolidCompression=yes
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
WizardStyle=modern

[Files]
Source: "bin\MarkPad.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\LICENSE"; DestDir: "{app}"; DestName: "LICENSE.txt"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\MarkPad"; Filename: "{app}\MarkPad.exe"

[Registry]
; The .md association: MarkPad appears in "Open with"; Windows asks the user
; to confirm making it the default (Settings > Default apps, or Open with >
; Always). Everything is removed on uninstall.
Root: HKA; Subkey: "Software\Classes\MarkPad.md"; ValueType: string; ValueData: "Markdown Document"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\MarkPad.md\DefaultIcon"; ValueType: string; ValueData: """{app}\MarkPad.exe"",1"
Root: HKA; Subkey: "Software\Classes\MarkPad.md\shell\open\command"; ValueType: string; ValueData: """{app}\MarkPad.exe"" ""%1"""
Root: HKA; Subkey: "Software\Classes\.md\OpenWithProgids"; ValueName: "MarkPad.md"; ValueType: none; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\.markdown\OpenWithProgids"; ValueName: "MarkPad.md"; ValueType: none; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\.mdown\OpenWithProgids"; ValueName: "MarkPad.md"; ValueType: none; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\.mkd\OpenWithProgids"; ValueName: "MarkPad.md"; ValueType: none; Flags: uninsdeletevalue
; App settings (window placement, recents, one-time flags): not created by
; the installer, but cleaned up on uninstall.
Root: HKA; Subkey: "Software\MarkPad"; ValueType: none; Flags: dontcreatekey uninsdeletekey

[Run]
Filename: "{app}\MarkPad.exe"; Description: "Launch MarkPad"; Flags: nowait postinstall skipifsilent
