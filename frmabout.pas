unit frmabout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, exever, Winapi.ShellAPI;

type
  TFormAbout = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    LinkLabel1: TLinkLabel;
    lblVersion: TLabel;
    Label2: TLabel;
    btnOk: TButton;
    LinkLabel2: TLinkLabel;
    procedure FormCreate(Sender: TObject);
    procedure LabelsLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAbout: TFormAbout;

implementation

{$R *.dfm}

procedure TFormAbout.FormCreate(Sender: TObject);
begin
  lblVersion.Caption := lblVersion.Caption + GetExeVersionDescription;
end;

procedure TFormAbout.LabelsLinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  ShellExecute(Handle, 'open', PChar(Link), nil, nil, SW_SHOW);
end;

end.
