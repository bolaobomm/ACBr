program AcbrBoletoDemo;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazreport, ACBr_Boleto, uDemo, ACBr_BoletoFC_LazReport;

{$R *.res}

begin
  Application.Initialize;
   Application.CreateForm ( TfrmDemo, frmDemo ) ;
  Application.Run;
end.

