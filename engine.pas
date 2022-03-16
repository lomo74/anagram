unit engine;

interface

uses System.SysUtils, Generics.Collections, System.IniFiles, System.Classes;

type
  iconv_t = Pointer;
  size_t = Integer;

  TAnagramStatus = (asEmpty, asIncomplete, asComplete, asExcess);

  TLetters = array['A'..'Z'] of Integer;
  TLetterOrder = array['A'..'Z'] of Char;

  TAnagramEngine = class;
  TAnagram = class;

  TEngineClearedEvent = procedure(Sender: TAnagramEngine) of object;
  TAnagramsLoadingEvent = procedure(Sender: TAnagramEngine; ACount: Integer; const ASentence: string) of object;
  TAnagramChangedEvent = procedure(Sender: TAnagramEngine; AAnagram: TAnagram; AIndex: Integer) of object;

  TAnagram = class
  private
    FAnagram: string;
    FLetters: TLetters;
    FEngine: TAnagramEngine;
    FSelStart: Integer;
    FSelLength: Integer;
    procedure SetAnagram(const Value: string);
    function GetLetters(C: Char): Integer;
  public
    constructor Create(AEngine: TAnagramEngine);
    procedure Clear; overload;
    procedure Clear(var ALetters: TLetters); overload;
    procedure Recalculate;
    procedure ProcessString(const S: string; bAdd: Boolean); overload;
    procedure ProcessString(const S: string; bAdd: Boolean; var ALetters: TLetters); overload;
    function AcceptChar(Key: Char): Boolean; overload;
    function AcceptChar(Key: Char; const Selection: string): Boolean; overload;
    function Status: TAnagramStatus;
    property Anagram: string read FAnagram write SetAnagram;
    property Letters[C: Char]: Integer read GetLetters;
    property SelStart: Integer read FSelStart write FSelStart;
    property SelLength: Integer read FSelLength write FSelLength;
  end;

  TAnagramList = TList<TAnagram>;

  TAnagramEngine = class
  private
    FChanged: Boolean;
    FLoading: Boolean;
    FSentence: string;
    FOrder: TLetterOrder;
    FAnagramList: TAnagramList;
    FOnEngineCleared: TEngineClearedEvent;
    FOnAnagramsLoading: TAnagramsLoadingEvent;
    FOnAnagramChanged: TAnagramChangedEvent;
    FAnagramIndex: Integer;
    procedure SetCurrentIndex(const Value: Integer);
    function GetCurrentAnagram: TAnagram;
    procedure SetSentence(const Value: string);
    function GetCurrentAnagramString: string;
    procedure SetCurrentAnagramString(const Value: string);
    function GetLetters(C: Char): Integer;
    function GetCount: Integer;
    function GetAnagram(Index: Integer): TAnagram;
    function GetLetterAtPosition(C: Char): Char;
  public
    class function Filter(C: Char): Char; overload;
    class function Filter(C: AnsiChar): AnsiChar; overload;
    class function Normalize(AChar: Char): string; overload;
    class function Normalize(const AString: string): string; overload;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure ClearAnagrams;
    function AcceptChar(Key: Char): Boolean; overload;
    function AcceptChar(Key: Char; const Selection: string): Boolean; overload;
    procedure AddAnagram;
    procedure RemoveAnagram(AIndex: Integer);
    procedure MoveCurrentTo(ANewIndex: Integer);
    procedure Load(const FileName: string);
    procedure LoadOld(const FileName: string);
    procedure LoadNew(const FileName: string);
    procedure Save(const FileName: string);
    procedure Shuffle;
    procedure Sort;
    property OnEngineCleared: TEngineClearedEvent read FOnEngineCleared write FOnEngineCleared;
    property OnAnagramsLoading: TAnagramsLoadingEvent read FOnAnagramsLoading write FOnAnagramsLoading;
    property OnAnagramChanged: TAnagramChangedEvent read FOnAnagramChanged write FOnAnagramChanged;
    property CurrentIndex: Integer read FAnagramIndex write SetCurrentIndex;
    property CurrentAnagram: TAnagram read GetCurrentAnagram;
    property Sentence: string read FSentence write SetSentence;
    property CurrentAnagramString: string read GetCurrentAnagramString write SetCurrentAnagramString;
    property Letters[C: Char]: Integer read GetLetters;
    property LetterAtPosition[C: Char]: Char read GetLetterAtPosition;
    property AnagramsCount: Integer read GetCount;
    property Anagram[Index: Integer]: TAnagram read GetAnagram;
    property Loading: Boolean read FLoading;
    property Changed: Boolean read FChanged;
  end;

implementation

var
  GIconvHandle: iconv_t;

const
  ICONV_DLL = 'libiconv-2.dll';

function iconv_open(const tocode, fromcode: PAnsiChar): iconv_t; cdecl;
  external ICONV_DLL name 'libiconv_open';

function iconv_close(cd: iconv_t): Integer; cdecl;
  external ICONV_DLL name 'libiconv_close';

function iconv (cd: iconv_t; var inbuf: Pointer; var inbytesleft: size_t;
  var outbuf: Pointer; var outbytesleft: size_t): size_t; cdecl;
  external ICONV_DLL name 'libiconv';

const
  szMAIN = 'MAIN';
  szFRASE = 'frase';
  szANAGRAMMA = 'anagramma';
  szCOMPLETI = 'COMPLETI';

{ TAnagram }

function TAnagram.AcceptChar(Key: Char): Boolean;
var
  S: string;
  C: Char;
begin
  S := TAnagramEngine.Normalize(Key);

  Result := True;

  for C in S do
    Result := Result and (FLetters[C] > 0);
end;

function TAnagram.AcceptChar(Key: Char; const Selection: string): Boolean;
var
  ALetters: TLetters;
  S: string;
  C: Char;
begin
  S := TAnagramEngine.Normalize(Key);

  Result := True;

  if Length(S) = 0 then
    Exit;

  ProcessString(FEngine.Sentence, True, ALetters);
  ProcessString(FAnagram, False, ALetters);
  ProcessString(Selection, True, ALetters);

  for C in S do
    Result := Result and (ALetters[C] > 0);
end;

procedure TAnagram.Clear(var ALetters: TLetters);
var
  C: Char;
begin
  for C := 'A' to 'Z' do
    ALetters[C] := 0;
end;

procedure TAnagram.Clear;
begin
  Clear(FLetters);
end;

constructor TAnagram.Create(AEngine: TAnagramEngine);
begin
  FEngine := AEngine;
  inherited Create;
end;

procedure TAnagram.ProcessString(const S: string; bAdd: Boolean;
  var ALetters: TLetters);
var
  I: Integer;
  C: Char;
  temp: string;
begin
  {
  for I := 1 to Length(S) do begin
    C := TAnagramEngine.Normalize(S[I]);

    if C = #0 then
      Continue;

    if bAdd then
      Inc(ALetters[C])
    else
      Dec(ALetters[C]);
  end;
  }

  temp := TAnagramEngine.Normalize(S);

  for I := 1 to Length(temp) do begin
    C := TAnagramEngine.Filter(temp[I]);

    if C = #0 then
      Continue;

    if bAdd then
      Inc(ALetters[C])
    else
      Dec(ALetters[C]);
  end;
end;

function TAnagram.GetLetters(C: Char): Integer;
begin
  Result := FLetters[C];
end;

function TAnagram.Status: TAnagramStatus;
var
  C: Char;
begin
  if (Trim(FEngine.Sentence) = '') and (Trim(FAnagram) = '') then begin
    Result := asEmpty;
    Exit;
  end;

  Result := asComplete;

  for C := 'A' to 'Z' do begin
    if FLetters[C] < 0 then begin
      Result := asExcess;
      Exit;
    end;

    if FLetters[C] > 0 then
      Result := asIncomplete;
  end;
end;

procedure TAnagram.ProcessString(const S: string; bAdd: Boolean);
begin
  ProcessString(S, bAdd, FLetters);
end;

procedure TAnagram.Recalculate;
begin
  Clear;

  ProcessString(FEngine.Sentence, True);
  ProcessString(FAnagram, False);

  if Assigned(FEngine.FOnAnagramChanged) then
    FEngine.FOnAnagramChanged(FEngine, Self, FEngine.FAnagramList.IndexOf(Self));
end;

procedure TAnagram.SetAnagram(const Value: string);
begin
  FAnagram := Value;
  FEngine.FChanged := True;

  Recalculate;
end;

{ TAnagramEngine }

function TAnagramEngine.AcceptChar(Key: Char): Boolean;
begin
  Result := CurrentAnagram.AcceptChar(Key);
end;

function TAnagramEngine.AcceptChar(Key: Char; const Selection: string): Boolean;
begin
  Result := CurrentAnagram.AcceptChar(Key, Selection);
end;

procedure TAnagramEngine.AddAnagram;
var
  Obj: TAnagram;
begin
  Obj := TAnagram.Create(Self);
  FAnagramList.Add(Obj);
  Obj.Recalculate;
end;

procedure TAnagramEngine.Clear;
var
  C: Char;
begin
  FSentence := '';
  FAnagramIndex := 0;

  ClearAnagrams;
  AddAnagram;

  for C := 'A' to 'Z' do
    FOrder[C] := C;

  FChanged := False;

  if Assigned(FOnEngineCleared) then
    FOnEngineCleared(Self);
end;

procedure TAnagramEngine.ClearAnagrams;
var
  Obj: TAnagram;
begin
  for Obj in FAnagramList do
    Obj.Free;

  FAnagramList.Clear;
end;

constructor TAnagramEngine.Create;
var
  C: Char;
begin
  Randomize;

  FAnagramList := TAnagramList.Create;
  FAnagramIndex := 0;

  for C := 'A' to 'Z' do
    FOrder[C] := C;

  AddAnagram;
end;

destructor TAnagramEngine.Destroy;
begin
  ClearAnagrams;

  FAnagramList.Free;

  inherited;
end;

function TAnagramEngine.GetCurrentAnagram: TAnagram;
begin
  Assert(FAnagramIndex < FAnagramList.Count);
  Result := FAnagramList[FAnagramIndex];
end;

function TAnagramEngine.GetCurrentAnagramString: string;
begin
  Result := CurrentAnagram.Anagram;
end;

function TAnagramEngine.GetAnagram(Index: Integer): TAnagram;
begin
  Result := FAnagramList[Index];
end;

function TAnagramEngine.GetCount: Integer;
begin
  Result := FAnagramList.Count;
end;

function TAnagramEngine.GetLetterAtPosition(C: Char): Char;
begin
  Result := FOrder[C];
end;

function TAnagramEngine.GetLetters(C: Char): Integer;
begin
  Result := CurrentAnagram.Letters[C];
end;

{
class function TAnagramEngine.Normalize(C: Char): Char;
begin
  case C of
    'A'..'Z': Result := C;
    'a'..'z': Result := UpCase(C);
    'À', 'à', 'Á', 'á', 'Â', 'â', 'Ä', 'ä', 'Ã', 'ã', 'Å', 'å':   Result := 'A';
    'È', 'è', 'É', 'é', 'Ê', 'ê', 'Ë', 'ë':                       Result := 'E';
    'Ì', 'ì', 'Í', 'í', 'Î', 'î', 'Ï', 'ï':                       Result := 'I';
    'Ò', 'ò', 'Ó', 'ó', 'Ô', 'ô', 'Ö', 'ö', 'Õ', 'õ':             Result := 'O';
    'Ù', 'ù', 'Ú', 'ú', 'Û', 'û', 'Ü', 'ü':                       Result := 'U';
    else Result := #0;
  end;
end;
}

class function TAnagramEngine.Filter(C: Char): Char;
begin
  case C of
    'A'..'Z': Result := C;
    'a'..'z': Result := UpCase(C);
    else Result := #0;
  end;
end;

class function TAnagramEngine.Filter(C: AnsiChar): AnsiChar;
begin
  case C of
    'A'..'Z': Result := C;
    'a'..'z': Result := UpCase(C);
    else Result := #0;
  end;
end;

class function TAnagramEngine.Normalize(AChar: Char): string;
var
  I, X: Integer;
  C: AnsiChar;
  inptr: Pointer;
  inlen: size_t;
  temp: array[1..8] of AnsiChar;
  outptr, outptr_init: Pointer;
  outlen: size_t;
begin
  inptr := @AChar;
  inlen := SizeOf(Char);
  outptr_init := @temp;
  outptr := outptr_init;
  outlen := SizeOf(temp);

  if iconv(GIconvHandle, inptr, inlen, outptr, outlen) <> -1 then begin
    outlen := Cardinal(outptr) - Cardinal(outptr_init);

    SetLength(Result, outlen);

    X := 0;

    for I := 1 to outlen do begin
      C := Filter(temp[I]);

      if C <> #0 then begin
        Inc(X);
        Result[X] := Char(C);
      end;
    end;

    SetLength(Result, X);
  end;
end;

class function TAnagramEngine.Normalize(const AString: string): string;
var
  I, X: Integer;
  C: AnsiChar;
  inptr: Pointer;
  inlen: size_t;
  temp: AnsiString;
  outptr, outptr_init: Pointer;
  outlen: size_t;
begin
  inptr := PChar(AString);
  inlen := Length(AString) * SizeOf(Char);
  SetLength(temp, Length(AString) * 8);
  outptr_init := PAnsiChar(temp);
  outptr := outptr_init;
  outlen := Length(temp);

  if iconv(GIconvHandle, inptr, inlen, outptr, outlen) <> -1 then begin
    outlen := Cardinal(outptr) - Cardinal(outptr_init);

    SetLength(Result, outlen);

    X := 0;

    for I := 1 to outlen do begin
      C := Filter(temp[I]);

      if C <> #0 then begin
        Inc(X);
        Result[X] := Char(C);
      end;
    end;

    SetLength(Result, X);
  end;
end;

procedure TAnagramEngine.RemoveAnagram(AIndex: Integer);
var
  Obj: TAnagram;
begin
  Obj := FAnagramList[AIndex];
  FAnagramList.Delete(AIndex);
  Obj.Free;

  if FAnagramIndex >= FAnagramList.Count then
    FAnagramIndex := FAnagramList.Count - 1;

  FChanged := True;
end;

procedure TAnagramEngine.SetCurrentAnagramString(const Value: string);
begin
  CurrentAnagram.Anagram := Value;
end;

procedure TAnagramEngine.SetCurrentIndex(const Value: Integer);
begin
  FAnagramIndex := Value;

  if Assigned(FOnAnagramChanged) then
    FOnAnagramChanged(Self, FAnagramList[FAnagramIndex], FAnagramIndex);
end;

procedure TAnagramEngine.SetSentence(const Value: string);
var
  Obj: TAnagram;
begin
  FSentence := Value;
  FChanged := True;

  for Obj in FAnagramList do
    Obj.Recalculate;
end;

procedure TAnagramEngine.Shuffle;
var
  C, X: Char;
  J: Integer;
begin
  for C := 'Z' downto 'B' do begin
    J := Random(Ord(C) - Ord('A') + 1);
    X := FOrder[Char(Ord('A') + J)];
    FOrder[Char(Ord('A') + J)] := FOrder[C];
    FOrder[C] := X;
  end;

  FChanged := True;

  if Assigned(FOnAnagramChanged) then
    FOnAnagramChanged(Self, FAnagramList[FAnagramIndex], FAnagramIndex);
end;

procedure TAnagramEngine.Sort;
var
  C: Char;
begin
  for C := 'A' to 'Z' do
    FOrder[C] := C;

  FChanged := True;

  if Assigned(FOnAnagramChanged) then
    FOnAnagramChanged(Self, FAnagramList[FAnagramIndex], FAnagramIndex);
end;

procedure TAnagramEngine.Load(const FileName: string);
var
  fs: TFileStream;
  magic: array[0..1] of Byte;
  bNew: Boolean;
begin
  fs := TFileStream.Create(FileName, fmOpenRead);
  try
    bNew := (fs.ReadData(magic) = 2) and
      (magic[0] = 19) and
      ((magic[1] = 74) or (magic[1] = 98));
  finally
    fs.Free;
  end;

  ClearAnagrams;
  FAnagramIndex := 0;

  if bNew then
    LoadNew(FileName)
  else
    LoadOld(FileName);
end;

procedure TAnagramEngine.LoadNew(const FileName: string);
var
  fs: TFileStream;
  sl1: TStringList;
  Obj: TAnagram;
  I, L: Integer;
  S: string;
  magic: array[0..1] of Byte;
  version: ShortInt;
  C: Char;
begin
  FLoading := True;
  try
    fs := TFileStream.Create(FileName, fmOpenRead);
    sl1 := TStringList.Create;
    try
      fs.ReadData(magic);

      if magic[1] = 98 then
        fs.ReadData(version)
      else
        version := 0;

      if version > 0 then
        fs.ReadData(FOrder)
      else begin
        for C := 'A' to 'Z' do
          FOrder[C] := C;
      end;

      fs.ReadData(L);
      SetLength(FSentence, L);
      fs.ReadData(PChar(FSentence), L * SizeOf(Char));

      while fs.Position < fs.Size do begin
        fs.ReadData(L);
        SetLength(S, L);
        fs.ReadData(PChar(S), L * SizeOf(Char));

        sl1.Add(S);
      end;

      if sl1.Count = 0 then
        sl1.Add('');

      if Assigned(FOnAnagramsLoading) then
        FOnAnagramsLoading(Self, sl1.Count, FSentence);

      for I := 0 to sl1.Count - 1 do begin
        Obj := TAnagram.Create(Self);
        FAnagramList.Add(Obj);
        Obj.Anagram := sl1[I];
      end;

      FChanged := False;
    finally
      fs.Free;
      sl1.Free;
    end;
  finally
    FLoading := False;
  end;
end;

procedure TAnagramEngine.LoadOld(const FileName: string);
var
  ini: TIniFile;
  sl1, sl2: TStringList;
  I: Integer;
  Obj: TAnagram;
  temp: string;
begin
  FLoading := True;
  try
    ini := TIniFile.Create(FileName);
    sl1 := TStringList.Create;
    sl2 := TStringList.Create;
    sl2.CaseSensitive := False;
    sl2.Duplicates := dupIgnore;
    try
      FSentence := ini.ReadString(szMAIN, szFRASE, '');

      ini.ReadSectionValues(szCOMPLETI, sl1);

      for I := 0 to sl1.Count - 1 do
        sl2.Add(sl1.ValueFromIndex[I]);

      temp := ini.ReadString(szMAIN, szANAGRAMMA, '');
      if (temp <> '') and (sl2.IndexOf(temp) < 0) then
        sl2.Insert(0, temp);

      if sl2.Count = 0 then
        sl2.Add('');

      if Assigned(FOnAnagramsLoading) then
        FOnAnagramsLoading(Self, sl2.Count, FSentence);

      for I := 0 to sl2.Count - 1 do begin
        Obj := TAnagram.Create(Self);
        FAnagramList.Add(Obj);
        Obj.Anagram := sl2[I];
      end;

      FChanged := False;
    finally
      ini.Free;
      sl1.Free;
      sl2.Free;
    end;
  finally
    FLoading := False;
  end;
end;

procedure TAnagramEngine.MoveCurrentTo(ANewIndex: Integer);
begin
  if FAnagramIndex = ANewIndex then
    Exit;

  FAnagramList.Move(FAnagramIndex, ANewIndex);

  FAnagramIndex := ANewIndex;
end;

procedure TAnagramEngine.Save(const FileName: string);
var
  fs: TFileStream;
  Obj: TAnagram;
  S: string;
const
  magic: array[0..1] of Byte = (19, 98);
  version: ShortInt = 1;
begin
  fs := TFileStream.Create(FileName, fmCreate);
  try
    fs.WriteData(magic);
    fs.WriteData(version);

    fs.WriteData(FOrder);

    fs.WriteData(Length(FSentence));
    fs.WriteData(PChar(FSentence), Length(FSentence) * SizeOf(Char));

    for Obj in FAnagramList do begin
      S := Obj.Anagram;
      fs.WriteData(Length(S));
      fs.WriteData(PChar(S), Length(S) * SizeOf(Char));
    end;

    FChanged := False;
  finally
    fs.Free;
  end;
end;

initialization
  GIconvHandle := iconv_open('ASCII//TRANSLIT//IGNORE', 'UCS-2LE');

finalization
  iconv_close(GIconvHandle);

end.
