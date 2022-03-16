unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus,
  cxGraphics, cxControls, cxLookAndFeels, System.UITypes, config, System.Win.Registry,
  cxLookAndFeelPainters, cxSplitter, cxPC, engine, Vcl.ComCtrls, Winapi.RichEdit,
  Winapi.ShlObj, System.RegularExpressions, frmabout, JvExStdCtrls,
  JvRichEdit, Vcl.Clipbrd, TextServ, ThiscallWrapper;

type
  TFormMain = class(TForm)
    panTop: TPanel;
    panData: TPanel;
    Grid: TGridPanel;
    panBottom: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Menu: TMainMenu;
    mnuFile: TMenuItem;
    mnuOpen: TMenuItem;
    mnuSave: TMenuItem;
    OpenDlg: TOpenDialog;
    SaveDlg: TSaveDialog;
    edtSentence: TMemo;
    edtAnagram: TJvRichEdit;
    lblVowels: TLabel;
    lblConsonants: TLabel;
    mnuNew: TMenuItem;
    tabCtrl: TcxTabControl;
    split: TcxSplitter;
    mnuSaveas: TMenuItem;
    Label53: TLabel;
    Label54: TLabel;
    chkAllowExcess: TCheckBox;
    N1: TMenuItem;
    mnuClose: TMenuItem;
    N2: TMenuItem;
    mnuOptions: TMenuItem;
    mnuUtilities: TMenuItem;
    mnuShuffle: TMenuItem;
    mnuSort: TMenuItem;
    N3: TMenuItem;
    mnuAddAssociation: TMenuItem;
    Tim: TTimer;
    mnuDeleteAssociation: TMenuItem;
    mnuInfo: TMenuItem;
    N4: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure mnuOpenClick(Sender: TObject);
    procedure mnuSaveClick(Sender: TObject);
    procedure edtAnagramKeyPress(Sender: TObject; var Key: Char);
    procedure edtAnagramChange(Sender: TObject);
    procedure edtSentenceChange(Sender: TObject);
    procedure tabCtrlChange(Sender: TObject);
    procedure tabCtrlCanCloseEx(Sender: TObject; ATabIndex: Integer;
      var ACanClose: Boolean);
    procedure tabCtrlNewTabButtonClick(Sender: TObject; var AHandled: Boolean);
    procedure mnuNewClick(Sender: TObject);
    procedure mnuSaveasClick(Sender: TObject);
    procedure mnuCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LabelsMouseEnter(Sender: TObject);
    procedure LabelsMouseLeave(Sender: TObject);
    procedure LabelsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LabelsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnuOptionsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnuShuffleClick(Sender: TObject);
    procedure mnuSortClick(Sender: TObject);
    procedure mnuAddAssociationClick(Sender: TObject);
    procedure TimTimer(Sender: TObject);
    procedure tabCtrlTabEndDrag(AControl: TcxCustomTabControl;
      ANewIndex: Integer);
    procedure mnuDeleteAssociationClick(Sender: TObject);
    procedure mnuInfoClick(Sender: TObject);
    procedure edtAnagramProtectChangeEx(Sender: TObject; const Msg: TMessage;
      StartPos, EndPos: Integer; var AllowChange: Boolean);
  private
    FRemoveCrLf, FNormalizeSpaces: TRegEx;
    FFileName: string;
    FBaseCaption: string;
    FStopEvents: Boolean;
    FEngine: TAnagramEngine;
    FOldSel, FOldLen: Integer;
    procedure FillGrid;
    function AskConfirmation: Boolean;
    procedure Highlight(AChar: Char);
    procedure EngineCleared(Sender: TAnagramEngine);
    procedure ConfigChanged(Sender: TObject);
    procedure AnagramsLoading(Sender: TAnagramEngine; ACount: Integer; const ASentence: string);
    procedure AnagramChanged(Sender: TAnagramEngine; Anagram: TAnagram; AIndex: Integer);
    function GetTabCaption(AIndex: Integer; const AText: string): string;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

const
  GRID_FONTSIZES: array[0..2] of Integer = (12, 15, 18);
  OFF_FONTSIZES: array[0..2] of Integer = (8, 10, 12);
  MEMO_FONTSIZES: array[0..2] of Integer = (11, 14, 16);
  GRID_HEIGHTS: array[0..2] of Integer = (70, 80, 90);

procedure TFormMain.AnagramChanged(Sender: TAnagramEngine; Anagram: TAnagram;
  AIndex: Integer);
begin
  if FStopEvents then
    Exit;

  if Anagram = FEngine.CurrentAnagram then begin
    FillGrid;

    if FEngine.Loading then try
      FStopEvents := True;
      edtAnagram.Text := Anagram.Anagram;
    finally
      FStopEvents := False;
    end;
  end;

  tabCtrl.Tabs[AIndex].Caption := GetTabCaption(AIndex + 1, Anagram.Anagram);

  case Anagram.Status of
    asEmpty: tabCtrl.Tabs[AIndex].Color := clBtnFace;
    asIncomplete: tabCtrl.Tabs[AIndex].Color := clYellow;
    asComplete: tabCtrl.Tabs[AIndex].Color := clLime;
    asExcess: tabCtrl.Tabs[AIndex].Color := clRed;
  end;
end;

procedure TFormMain.AnagramsLoading(Sender: TAnagramEngine; ACount: Integer;
  const ASentence: string);
var
  I: Integer;
begin
  FStopEvents := True;
  try
    tabCtrl.Tabs.Clear;

    for I := 1 to ACount do
      tabCtrl.Tabs.Add('');

    tabCtrl.TabIndex := 0;

    edtSentence.Text := ASentence;
  finally
    FStopEvents := False;
  end;
end;

function TFormMain.AskConfirmation: Boolean;
begin
  if not FEngine.Changed then begin
    Result := True;
    Exit;
  end;

  Result := MessageDlg('Modifiche non ancora salvate! Sei sicuro di voler abbandonare?', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes;
end;

procedure TFormMain.ConfigChanged(Sender: TObject);
var
  old_selstart, old_sellength: Integer;
begin
  lblVowels.Font.Color := GConfig.ColorVowels;
  lblConsonants.Font.Color := GConfig.ColorConsonants;
  edtSentence.Font.Size := MEMO_FONTSIZES[GConfig.FontSize];

  old_selstart := edtAnagram.SelStart;
  old_sellength := edtAnagram.SelLength;
  edtAnagram.SelectAll;
  edtAnagram.SelAttributes.Size := MEMO_FONTSIZES[GConfig.FontSize];
  edtAnagram.SelStart := old_selstart;
  edtAnagram.SelLength := old_sellength;

  edtAnagram.Font.Size := MEMO_FONTSIZES[GConfig.FontSize];

  lblVowels.Font.Size := MEMO_FONTSIZES[GConfig.FontSize];
  lblConsonants.Font.Size := MEMO_FONTSIZES[GConfig.FontSize];
  Grid.Height := GRID_HEIGHTS[GConfig.FontSize];
  FillGrid;
end;

procedure TFormMain.mnuOpenClick(Sender: TObject);
begin
  if not AskConfirmation then
    Exit;

  if not OpenDlg.Execute then
    Exit;

  FFileName := OpenDlg.FileName;
  Caption := FBaseCaption + ' - ' + FFileName;

  FEngine.Load(FFileName);
end;

procedure TFormMain.mnuOptionsClick(Sender: TObject);
begin
  GConfig.ShowForm;
end;

procedure TFormMain.EngineCleared(Sender: TAnagramEngine);
begin
  FStopEvents := True;
  try
    edtSentence.Text := '';
    edtAnagram.Text := '';
    tabCtrl.Tabs.Clear;
    tabCtrl.Tabs.Add('&1.');
  finally
    FStopEvents := False;
  end;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GConfig.FormWidth := Width;
  GConfig.FormHeight := Height;
  GConfig.Splitter := panTop.Height;
  GConfig.SaveForm;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := AskConfirmation;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  fmt: CHARFORMAT2;
  pUnk: IUnknown;
  pTxtSvc: ITextServices;
begin
  FRemoveCrLf.Create('[\r\n]+');
  FNormalizeSpaces.Create('\s+');

  FBaseCaption := Caption;
  Caption := FBaseCaption + ' - [senza nome]';

  GConfig.OnConfigChanged := Self.ConfigChanged;

  lblVowels.Font.Color := GConfig.ColorVowels;
  lblConsonants.Font.Color := GConfig.ColorConsonants;
  chkAllowExcess.Checked := GConfig.AllowExcess;

  FEngine := TAnagramEngine.Create;
  FEngine.OnEngineCleared := Self.EngineCleared;
  FEngine.OnAnagramsLoading := Self.AnagramsLoading;
  FEngine.OnAnagramChanged := Self.AnagramChanged;

  tabCtrl.Properties.NewButtonMode := nbmTab;
  with tabCtrl.Properties.NewButton do begin
    Width := 80;
    Caption := 'A&ggiungi...';
  end;

  FillGrid;

  if GConfig.FormWidth > 0 then
    Width := GConfig.FormWidth;

  if GConfig.FormHeight > 0 then
    Height := GConfig.FormHeight;

  if GConfig.Splitter > 0 then
    panTop.Height := GConfig.Splitter;

  edtSentence.Font.Size := MEMO_FONTSIZES[GConfig.FontSize];
  edtAnagram.Font.Size := MEMO_FONTSIZES[GConfig.FontSize];
  lblVowels.Font.Size := MEMO_FONTSIZES[GConfig.FontSize];
  lblConsonants.Font.Size := MEMO_FONTSIZES[GConfig.FontSize];
  Grid.Height := GRID_HEIGHTS[GConfig.FontSize];

  if ParamCount > 0 then begin
    FFileName := ParamStr(1);
    FEngine.Load(FFileName);
    Tim.Enabled := True;
  end;

  FillChar(fmt, SizeOf(fmt), 0);
  fmt.cbSize := SizeOf(fmt);
  fmt.dwMask := CFM_PROTECTED;
  fmt.dwEffects := CFE_PROTECTED;

  edtAnagram.Perform(EM_SETCHARFORMAT, SCF_DEFAULT, Longint(@fmt));

  if edtAnagram.Perform(EM_GETOLEINTERFACE, 0, @pUnk) <> 0 then begin
    if Succeeded(QueryThiscallInterface(pUnk, ITextServices, pTxtSvc)) then
      pTxtSvc.OnTxPropertyBitsChange(TXTBIT_ALLOWBEEP, 0);
  end;
end;

function TFormMain.GetTabCaption(AIndex: Integer; const AText: string): string;
var
  S: string;
begin
  S := FRemoveCrLf.Replace(AText, ' ');
  S := FNormalizeSpaces.Replace(S, ' ');
  Result := '&' + IntToStr(AIndex) + '. ' + Trim(S);
end;

procedure TFormMain.Highlight(AChar: Char);
var
  S1, S2: string;
  I: Integer;
  fmt: CHARFORMAT2;
begin
  FillChar(fmt, SizeOf(fmt), 0);
  fmt.cbSize := SizeOf(fmt);
  fmt.dwMask := CFM_BACKCOLOR or CFM_COLOR or CFM_BOLD;
  fmt.crBackColor := clRed;
  fmt.crTextColor := clWhite;
  fmt.dwEffects := CFE_BOLD;

  FOldSel := edtAnagram.SelStart;
  FOldLen := edtAnagram.SelLength;

  S1 := StringReplace(edtAnagram.Text, #13#10, #10, [rfReplaceAll]);
  for I := 1 to Length(S1) do begin
    S2 := TAnagramEngine.Normalize(S1[I]);
    if Pos(AChar, S2) > 0 then begin
      edtAnagram.SelStart := I - 1;
      edtAnagram.SelLength := 1;
      edtAnagram.Perform(EM_SETCHARFORMAT, SCF_SELECTION, Longint(@fmt));
    end;
  end;

  edtAnagram.SelStart := FOldSel;
  edtAnagram.SelLength := 0;
end;

procedure TFormMain.LabelsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FStopEvents := True;
  try
    Highlight(TLabel(Sender).Caption[1]);
  finally
    FStopEvents := False;
  end;
end;

procedure TFormMain.LabelsMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style + [fsUnderline];
end;

procedure TFormMain.LabelsMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style - [fsUnderline];
end;

procedure TFormMain.LabelsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  fmt: CHARFORMAT2;
begin
  FillChar(fmt, SizeOf(fmt), 0);
  fmt.cbSize := SizeOf(fmt);
  fmt.dwMask := CFM_BACKCOLOR or CFM_COLOR or CFM_BOLD;
  fmt.crBackColor := clWhite;
  fmt.crTextColor := clBlack;
  fmt.dwEffects := 0;

  FStopEvents := True;
  try
    edtAnagram.Perform(EM_SETCHARFORMAT, SCF_ALL, Longint(@fmt));
    edtAnagram.SelStart := FOldSel;
    edtAnagram.SelLength := FOldLen;
  finally
    FStopEvents := False;
  end;
end;

procedure TFormMain.mnuAddAssociationClick(Sender: TObject);
begin
  if MessageDlg('I file con estensione .anf verranno associati con il programma ' + ParamStr(0) + '. Proseguo?', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrNo then
    Exit;

  with TRegistry.Create do try
    RootKey := HKEY_CURRENT_USER;
    if OpenKey('\Software\Classes\.anf', True) then
      WriteString('', 'AnagramFile');
    if OpenKey('\Software\Classes\AnagramFile', True) then
      WriteString('', 'Anagram file');
    if OpenKey('\Software\Classes\AnagramFile\DefaultIcon', True) then
      WriteString('', ParamStr(0));
    if OpenKey('\Software\Classes\AnagramFile\shell\open\command', True) then
      WriteString('', '"' + ParamStr(0) + '" "%1"');

    ShowMessage('Associazione creata con successo');
  finally
    Free;
  end;

  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

procedure TFormMain.mnuCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.mnuDeleteAssociationClick(Sender: TObject);
begin
  with TRegistry.Create do try
    RootKey := HKEY_CURRENT_USER;
    DeleteKey('\Software\Classes\.anf');
    DeleteKey('\Software\Classes\AnagramFile\shell\open\command');
    DeleteKey('\Software\Classes\AnagramFile\shell\open');
    DeleteKey('\Software\Classes\AnagramFile\shell');
    DeleteKey('\Software\Classes\AnagramFile\DefaultIcon');
    DeleteKey('\Software\Classes\AnagramFile');

    ShowMessage('L''associazione ai file con estensione .anf è stata eliminata');
  finally
    Free;
  end;

  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

procedure TFormMain.mnuInfoClick(Sender: TObject);
begin
  with TFormAbout.Create(Self) do try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.mnuNewClick(Sender: TObject);
begin
  if not AskConfirmation then
    Exit;

  FFileName := '';
  Caption := FBaseCaption + ' - [senza nome]';

  FEngine.Clear;
end;

procedure TFormMain.edtAnagramChange(Sender: TObject);
begin
  if FStopEvents then
    Exit;

  FEngine.CurrentAnagramString := edtAnagram.Text;
end;

procedure TFormMain.edtAnagramKeyPress(Sender: TObject; var Key: Char);
var
  bAccept: Boolean;
begin
  if chkAllowExcess.Checked then
    Exit;

  if edtAnagram.SelLength = 0 then
    bAccept := FEngine.AcceptChar(Key)
  else
    bAccept := FEngine.AcceptChar(Key, edtAnagram.SelText);

  if not bAccept then begin
    Key := #0;
    Beep;
  end;
end;

procedure TFormMain.edtAnagramProtectChangeEx(Sender: TObject;
  const Msg: TMessage; StartPos, EndPos: Integer; var AllowChange: Boolean);
begin
  if Msg.Msg = WM_PASTE then begin
    if Clipboard.HasFormat(CF_TEXT) then
      edtAnagram.SelText := Clipboard.AsText;
    AllowChange := False;
  end else
    AllowChange := True;
end;

procedure TFormMain.edtSentenceChange(Sender: TObject);
begin
  if FStopEvents then
    Exit;

  FEngine.Sentence := edtSentence.Text;
end;

procedure TFormMain.FillGrid;
var
  X, C: Char;
  lbl1, lbl2: TLabel;
  vocali, consonanti: string;
  acolor: TColor;
begin
  for X := 'A' to 'Z' do begin
    C := FEngine.LetterAtPosition[X];

    lbl1 := TLabel(Grid.ControlCollection.Controls[Ord(C) - Ord('A'), 0]);
    lbl2 := TLabel(Grid.ControlCollection.Controls[Ord(C) - Ord('A'), 1]);

    lbl1.Caption := IntToStr(FEngine.Letters[C]);
    lbl2.Caption := C;

    if FEngine.Letters[C] <> 0 then begin
      lbl1.Font.Size := GRID_FONTSIZES[GConfig.FontSize];
      lbl2.Font.Size := GRID_FONTSIZES[GConfig.FontSize];
      lbl1.Font.Style := [fsBold];
      lbl2.Font.Style := [fsBold];
      if FEngine.Letters[C] > 0 then begin
        if CharInSet(C, ['A', 'E', 'I', 'O', 'U']) then
          acolor := GConfig.ColorVowels
        else
          acolor := GConfig.ColorConsonants;
        lbl1.Font.Color := acolor;
        lbl2.Font.Color := acolor;
      end else begin
        lbl1.Font.Color := GConfig.ColorExcess;
        lbl2.Font.Color := GConfig.ColorExcess;
      end;

      if FEngine.Letters[C] > 0 then begin
        if CharInSet(C, ['A', 'E', 'I', 'O', 'U']) then
          vocali := vocali + ' ' + StringOfChar(C, FEngine.Letters[C])
        else
          consonanti := consonanti + ' ' + StringOfChar(C, FEngine.Letters[C])
      end;
    end else begin
      lbl1.Font.Size := OFF_FONTSIZES[GConfig.FontSize];
      lbl2.Font.Size := OFF_FONTSIZES[GConfig.FontSize];
      lbl1.Font.Style := [];
      lbl2.Font.Style := [];
      lbl1.Font.Color := clGray;
      lbl2.Font.Color := clGray;
    end;
  end;

  if vocali = '' then
    lblVowels.Caption := '--'
  else
    lblVowels.Caption := Trim(vocali);

  if consonanti = '' then
    lblConsonants.Caption := '--'
  else
    lblConsonants.Caption := Trim(consonanti);
end;

procedure TFormMain.mnuSaveasClick(Sender: TObject);
begin
  if not SaveDlg.Execute then
    Exit;

  FFileName := SaveDlg.FileName;
  Caption := FBaseCaption + ' - ' + FFileName;

  FEngine.Save(FFileName);
end;

procedure TFormMain.mnuSaveClick(Sender: TObject);
begin
  if FFileName = '' then begin
    if not SaveDlg.Execute then
      Exit;

    FFileName := SaveDlg.FileName;
    Caption := FBaseCaption + ' - ' + FFileName;
  end;

  FEngine.Save(FFileName);
end;

procedure TFormMain.mnuShuffleClick(Sender: TObject);
begin
  FEngine.Shuffle;
end;

procedure TFormMain.mnuSortClick(Sender: TObject);
begin
  FEngine.Sort;
end;

procedure TFormMain.tabCtrlCanCloseEx(Sender: TObject; ATabIndex: Integer;
  var ACanClose: Boolean);
begin
  ACanClose := tabCtrl.Tabs.Count > 1;

  if ACanClose then begin
    if Trim(FEngine.Anagram[ATabIndex].Anagram) <> '' then
      ACanClose := MessageDlg('Sei sicuro di eliminare questa scheda?', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes;
  end;

  if ACanClose then
    FEngine.RemoveAnagram(ATabIndex);
end;

procedure TFormMain.tabCtrlChange(Sender: TObject);
begin
  if FStopEvents then
    Exit;

  FEngine.CurrentAnagram.SelStart := edtAnagram.SelStart;
  FEngine.CurrentAnagram.SelLength := edtAnagram.SelLength;

  FEngine.CurrentIndex := tabCtrl.TabIndex;

  FStopEvents := True;
  try
    edtAnagram.Text := FEngine.CurrentAnagram.Anagram;
    edtAnagram.SelStart := FEngine.CurrentAnagram.SelStart;
    edtAnagram.SelLength := FEngine.CurrentAnagram.SelLength;
  finally
    FStopEvents := False;
  end;
end;

procedure TFormMain.tabCtrlNewTabButtonClick(Sender: TObject;
  var AHandled: Boolean);
begin
  FStopEvents := True;
  try
    FEngine.AddAnagram;
  finally
    FStopEvents := False;
  end;
end;

procedure TFormMain.tabCtrlTabEndDrag(AControl: TcxCustomTabControl;
  ANewIndex: Integer);
var
  I: Integer;
begin
  FEngine.MoveCurrentTo(ANewIndex);

  for I := 0 to tabCtrl.Tabs.Count - 1 do
    tabCtrl.Tabs[I].Caption := GetTabCaption(I + 1, FEngine.Anagram[I].Anagram);
end;

procedure TFormMain.TimTimer(Sender: TObject);
begin
  Tim.Enabled := False;
  lblVowels.AutoSize := False;
  lblConsonants.AutoSize := False;
  lblVowels.AutoSize := True;
  lblConsonants.AutoSize := True;
end;

end.
