program anagram;

uses
  Vcl.Forms,
  main in 'main.pas' {FormMain},
  frmconfig in 'frmconfig.pas' {FormConfig},
  engine in 'engine.pas',
  config in 'config.pas',
  frmabout in 'frmabout.pas' {FormAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
