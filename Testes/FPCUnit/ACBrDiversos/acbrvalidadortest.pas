unit ACBrValidadorTest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry,
  ACBrValidador;

type

  { TTestCaseACBrValidadorCPF }

  TTestCaseACBrValidadorCPF = class(TTestCase)
  private
    fACBrValidador : TACBrValidador;
    function MsgErroCPF: String;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Valido;
    procedure ValidoComSeparadores;
    procedure Invalido;
    procedure NumerosSequenciais;
    procedure MenorOnzeDigitos;
    procedure MaiorOnzeDigitos;
    procedure ComLetras;
    procedure Formatar;
  end;

  { TTestCaseACBrValidadorCNPJ }

  TTestCaseACBrValidadorCNPJ = class(TTestCase)
  private
    fACBrValidador : TACBrValidador;
    function MsgErroCNPJ: String;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Valido;
    procedure ValidoComSeparadores;
    procedure Invalido;
    procedure NumeroComZeros;
    procedure MenorQuatorzeDigitos;
    procedure MaiorQuatorzeDigitos;
    procedure ComLetras;
    procedure Formatar;
  end;

implementation

{ TTestCaseACBrValidadorCPF }

function TTestCaseACBrValidadorCPF.MsgErroCPF: String;
begin
  Result := fACBrValidador.MsgErro + ' - '+fACBrValidador.Documento;
end;

procedure TTestCaseACBrValidadorCPF.SetUp;
begin
  fACBrValidador := TACBrValidador.Create(nil);
  fACBrValidador.TipoDocto := docCPF;
  fACBrValidador.ExibeDigitoCorreto := True;
end;

procedure TTestCaseACBrValidadorCPF.TearDown;
begin
  FreeAndNil( fACBrValidador );
end;

procedure TTestCaseACBrValidadorCPF.Valido;
begin
  fACBrValidador.Documento := '12345678909';
  AssertTrue(MsgErroCPF , fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCPF.ValidoComSeparadores;
begin
  fACBrValidador.Documento := '123.456.789-09';
  AssertTrue(MsgErroCPF , fACBrValidador.Validar);
  fACBrValidador.Documento := '191';
  fACBrValidador.AjustarTamanho := True;
  AssertTrue(MsgErroCPF , fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCPF.Invalido;
begin
  fACBrValidador.Documento := '12345678901';
  AssertFalse(MsgErroCPF , fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCPF.NumerosSequenciais;
var
  I: Char;
begin
  For I := '1' to '9' do
  begin
    fACBrValidador.Documento := StringOfChar(I,11);
    AssertFalse( MsgErroCPF, fACBrValidador.Validar );
  end;
end;

procedure TTestCaseACBrValidadorCPF.MenorOnzeDigitos;
begin
  fACBrValidador.Documento := '123456789';
  fACBrValidador.AjustarTamanho := False;
  AssertFalse(MsgErroCPF , fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCPF.MaiorOnzeDigitos;
begin
  fACBrValidador.Documento := '1234567890123';
  fACBrValidador.AjustarTamanho := False;
  AssertFalse(MsgErroCPF , fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCPF.ComLetras;
begin
  fACBrValidador.Documento := '123456789AB';
  AssertFalse(MsgErroCPF , fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCPF.Formatar;
begin
  fACBrValidador.Documento := '191';
  fACBrValidador.AjustarTamanho := True;
  AssertEquals('000.000.001-91', fACBrValidador.Formatar);
  fACBrValidador.Documento := '12345678909';
  AssertEquals('123.456.789-09', fACBrValidador.Formatar);
end;


{ TTestCaseACBrValidadorCNPJ }

function TTestCaseACBrValidadorCNPJ.MsgErroCNPJ: String;
begin
  Result := fACBrValidador.MsgErro + ' - '+fACBrValidador.Documento;
end;

procedure TTestCaseACBrValidadorCNPJ.SetUp;
begin
  fACBrValidador := TACBrValidador.Create(nil);
  fACBrValidador.TipoDocto := docCNPJ;
  fACBrValidador.ExibeDigitoCorreto := True;
end;

procedure TTestCaseACBrValidadorCNPJ.TearDown;
begin
  FreeAndNil( fACBrValidador );
end;

procedure TTestCaseACBrValidadorCNPJ.Valido;
begin
  fACBrValidador.Documento := '12345678000195';
  AssertTrue(MsgErroCNPJ, fACBrValidador.Validar);
  fACBrValidador.Documento := '191';
  fACBrValidador.AjustarTamanho := True;
  AssertTrue(MsgErroCNPJ , fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCNPJ.ValidoComSeparadores;
begin
  fACBrValidador.Documento := '12.345.678/0001-95';
  AssertTrue(MsgErroCNPJ, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCNPJ.Invalido;
begin
  fACBrValidador.Documento := '12345678901234';
  AssertFalse(MsgErroCNPJ, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCNPJ.NumeroComZeros;
begin
  fACBrValidador.Documento := StringOfChar('0',14);
  AssertFalse(MsgErroCNPJ, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCNPJ.MenorQuatorzeDigitos;
begin
  fACBrValidador.Documento := '1234567890';
  fACBrValidador.AjustarTamanho := False;
  AssertFalse(MsgErroCNPJ, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCNPJ.MaiorQuatorzeDigitos;
begin
  fACBrValidador.Documento := '123456789012345';
  fACBrValidador.AjustarTamanho := False;
  AssertFalse(MsgErroCNPJ, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCNPJ.ComLetras;
begin
  fACBrValidador.Documento := '1234567890ABCD';
  AssertFalse(MsgErroCNPJ, fACBrValidador.Validar);
end;

procedure TTestCaseACBrValidadorCNPJ.Formatar;
begin
  fACBrValidador.Documento := '191';
  fACBrValidador.AjustarTamanho := True;
  AssertEquals('00.000.000/0001-91', fACBrValidador.Formatar);
  fACBrValidador.Documento := '12345678000195';
  AssertEquals('12.345.678/0001-95', fACBrValidador.Formatar);
end;

initialization

  RegisterTest(TTestCaseACBrValidadorCPF);
  RegisterTest(TTestCaseACBrValidadorCNPJ);
end.

