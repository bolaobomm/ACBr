program Convenio115Exemplo;

uses
  Vcl.Forms,
  uFrmMain in 'uFrmMain.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
