unit config;

interface

uses System.Classes, Vcl.Graphics, System.IniFiles, Winapi.ShlObj,
  System.SysUtils, Winapi.Windows, System.UITypes, frmconfig;

type
  TConfig = class
  private
    FOnConfigChanged: TNotifyEvent;
    FColorVowels, FColorConsonants, FColorExcess: TColor;
    FAllowExcess: Boolean;
    FFormWidth, FFormHeight, FSplitter, FFontSize: Integer;
    FIni: TIniFile;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ShowForm;
    procedure SaveForm;
    property OnConfigChanged: TNotifyEvent read FOnConfigChanged write FOnConfigChanged;
    property ColorVowels: TColor read FColorVowels;
    property ColorConsonants: TColor read FColorConsonants;
    property ColorExcess: TColor read FColorExcess;
    property AllowExcess: Boolean read FAllowExcess;
    property FormWidth: Integer read FFormWidth write FFormWidth;
    property FormHeight: Integer read FFormHeight write FFormHeight;
    property Splitter: Integer read FSplitter write FSplitter;
    property FontSize: Integer read FFontSize write FFontSize;
  end;

var
  GConfig: TConfig;

implementation

const
  sINIFILE = 'anagram.ini';
  sMAIN = 'MAIN';
  sCOLORVOWELS = 'COLORVOWELS';
  sCOLORCONSONANTS = 'COLORCONSONANTS';
  sCOLOREXCESS = 'COLOREXCESS';
  sALLOWEXCESS = 'ALLOWEXCESS';
  sFONTSIZE = 'FONTSIZE';
  sFORMWIDTH = 'FORMWIDTH';
  sFORMHEIGHT = 'FORMHEIGHT';
  sSPLITTER = 'SPLITTER';

var
  FPrivateFolder: string;

function GetPrivateFolder: string;
var
  path: array[0..MAX_PATH-1] of Char;
begin
  Result := '';
  if FPrivateFolder = '' then begin
    if Failed(SHGetFolderPath(0, CSIDL_LOCAL_APPDATA, 0, SHGFP_TYPE_CURRENT, @path)) then
      Exit;
    FPrivateFolder := IncludeTrailingPathDelimiter(path) + '.anagram\';
    ForceDirectories(FPrivateFolder);
  end;
  Result := FPrivateFolder;
end;

{ TConfig }

constructor TConfig.Create;
begin
  FIni := TIniFile.Create(GetPrivateFolder + sINIFILE);

  FColorVowels := FIni.ReadInteger(sMAIN, sCOLORVOWELS, clOlive);
  FColorConsonants := FIni.ReadInteger(sMAIN, sCOLORCONSONANTS, clNavy);
  FColorExcess := FIni.ReadInteger(sMAIN, sCOLOREXCESS, clRed);
  FAllowExcess := FIni.ReadBool(sMAIN, sALLOWEXCESS, False);
  FFontSize := FIni.ReadInteger(sMAIN, sFONTSIZE, 1);
  if FFontSize < 0 then FFontSize := 0;
  if FFontSize > 2 then FFontSize := 2;

  FFormWidth := FIni.ReadInteger(sMAIN, sFORMWIDTH, 0);
  FFormHeight := FIni.ReadInteger(sMAIN, sFORMHEIGHT, 0);
  FSplitter := FIni.ReadInteger(sMAIN, sSPLITTER, 0);
end;

destructor TConfig.Destroy;
begin
  FIni.Free;
  inherited;
end;

procedure TConfig.SaveForm;
begin
  FIni.WriteInteger(sMAIN, sFORMWIDTH, FFormWidth);
  FIni.WriteInteger(sMAIN, sFORMHEIGHT, FFormHeight);
  FIni.WriteInteger(sMAIN, sSPLITTER, FSplitter);
end;

procedure TConfig.ShowForm;
var
  frm: TFormConfig;
begin
  frm := TFormConfig.Create(nil);
  try
    frm.btnColorVowels.Color := FColorVowels;
    frm.btnColorConsonants.Color := FColorConsonants;
    frm.btnColorExcess.Color := FColorExcess;
    frm.chkAllowExcess.Checked := FAllowExcess;
    frm.rgFontSize.ItemIndex := FFontSize;

    if frm.ShowModal = mrOk then begin
      FColorVowels := frm.btnColorVowels.Color;
      FColorConsonants := frm.btnColorConsonants.Color;
      FColorExcess := frm.btnColorExcess.Color;
      FAllowExcess := frm.chkAllowExcess.Checked;
      FFontSize := frm.rgFontSize.ItemIndex;

      FIni.WriteInteger(sMAIN, sCOLORVOWELS, FColorVowels);
      FIni.WriteInteger(sMAIN, sCOLORCONSONANTS, FColorConsonants);
      FIni.WriteInteger(sMAIN, sCOLOREXCESS, FColorExcess);
      FIni.WriteBool(sMAIN, sALLOWEXCESS, FAllowExcess);
      FIni.WriteInteger(sMAIN, sFONTSIZE, FFontSize);

      if Assigned(FOnConfigChanged) then
        FOnConfigChanged(Self);
    end;
  finally
    frm.Free;
  end;
end;

initialization
  GConfig := TConfig.Create;

finalization
  GConfig.Free;

end.
