; -- setup.iss --
;
; Setup script per il software Anagram Helper

#define SrcApp "..\Win32\Release\anagram.exe"
#define FileVerStr GetFileVersion(SrcApp)
#define StripBuild(str VerStr) Copy(VerStr, 1, RPos(".", VerStr) - 1)
#define AppVerStr FileVerStr
#define AppName "Anagram Helper"

[Setup]
AppId={{A33B1807-BBEB-4030-A03E-3D73FA9E82B2}
AppName={#AppName}
AppVersion={#AppVerStr}
AppVerName={#AppName} {#AppVerStr}
AppPublisher=Monti Lorenzo
AppPublisherURL=https://archivio.101anagrammizen.net/
AppSupportURL=https://archivio.101anagrammizen.net/
AppUpdatesURL=https://archivio.101anagrammizen.net/
VersionInfoCompany=Monti Lorenzo
VersionInfoCopyright=Copyright © 2019-2022 Monti Lorenzo
VersionInfoDescription={#AppName} setup program
VersionInfoProductName={#AppName}
VersionInfoVersion={#FileVerStr}
WizardImageFile=..\images\setup.bmp

CreateAppDir=yes
DefaultDirName={pf}\Anagram Helper
DefaultGroupName=Anagram Helper

OutputBaseFilename=anagram-setup

UninstallDisplayName={#AppName} {#AppVerStr}
UninstallDisplayIcon={app}\ico322.ico

DisableWelcomePage=False

SignTool=lorenzomonti /d "{#AppName}"

[Languages]
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checkedonce
Name: "extension"; Description: "{cm:CreateFileAssociation}"; GroupDescription: "{cm:FileAssociation}"; Flags: checkedonce

[Icons]
Name: "{group}\Anagram Helper"; Filename: "{app}\anagram.exe"; WorkingDir: "{app}";
Name: "{commondesktop}\Anagram Helper"; Filename: "{app}\anagram.exe"; WorkingDir: "{app}"; Tasks: desktopicon

[Files]
Source: "..\Win32\Release\anagram.exe"; DestDir: "{app}"; Flags: replacesameversion
Source: "..\Win32\Release\libgcc_s_sjlj-1.dll"; DestDir: "{app}"; Flags: replacesameversion
Source: "..\Win32\Release\libiconv-2.dll"; DestDir: "{app}"; Flags: replacesameversion
Source: "..\Win32\Release\libwinpthread-1.dll"; DestDir: "{app}"; Flags: replacesameversion
Source: "..\images\ico322.ico"; DestDir: "{app}";

[CustomMessages]
CreateFileAssociation=Associate file extension (*.anf)
italian.CreateFileAssociation=Associa con l'estensione (*.anf)
FileAssociation=File type associations:
italian.FileAssociation=Associazione tipi di file:

[Registry]
Root: "HKCR"; Subkey: ".anf"; ValueType: string; ValueData: "AnagramFile"; Flags: uninsdeletekey; Tasks: extension
Root: "HKCR"; Subkey: "AnagramFile"; ValueType: string; ValueData: "Anagram file"; Flags: uninsdeletekey; Tasks: extension
Root: "HKCR"; Subkey: "AnagramFile\DefaultIcon"; ValueType: string; ValueData: "{app}\anagram.exe"; Flags: uninsdeletekey; Tasks: extension
Root: "HKCR"; Subkey: "AnagramFile\shell\open\command"; ValueType: string; ValueData: """{app}\anagram.exe"" ""%1"""; Flags: uninsdeletekey; Tasks: extension

[Code]
procedure SHChangeNotify(wEventId: LongInt; uFlags: Cardinal; dwItem1, dwItem2: Cardinal); external 'SHChangeNotify@shell32.dll stdcall';

const
  SHCNE_ASSOCCHANGED = $08000000;
  SHCNF_IDLIST = $0000;

{----------------------------------------------------------------------------------------}
procedure CurStepChanged(CurStep: TSetupStep);
var
  rc: Integer;
begin
  case CurStep of
    ssPostInstall:
      begin
        SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, 0, 0);
      end;
  end;
end;

{----------------------------------------------------------------------------------------}
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  rc: Integer;
begin
  case CurUninstallStep of
    usPostUninstall:
      begin
        SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, 0, 0);
      end;
  end;
end;
