unit frmconfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvExControls, JvColorBox, JvColorButton,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.ExtCtrls, cxGroupBox, Vcl.StdCtrls, Vcl.Menus, cxButtons;

type
  TFormConfig = class(TForm)
    gbColors: TcxGroupBox;
    btnColorVowels: TJvColorButton;
    panBottom: TPanel;
    panMain: TPanel;
    btnColorConsonants: TJvColorButton;
    Label1: TLabel;
    Label2: TLabel;
    chkAllowExcess: TCheckBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    btnColorExcess: TJvColorButton;
    Label3: TLabel;
    rgFontSize: TRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormConfig: TFormConfig;

implementation

{$R *.dfm}

end.
