unit ACBrUtilTest;

{$IFDEF FPC}
{$mode objfpc}{$H+}
{$ENDIF}

interface

uses
  Classes, SysUtils,
  {$ifdef FPC}
  fpcunit, testutils, testregistry,
  {$else}
  TestFramework,
  {$endif}
  ACBrUtil;

type

  { ParseTextTest }

  ParseTextTest = class(TTestCase)
  private

  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure VerificarConversao;
    procedure VerificarConversaoTextoLongo;
  end;

  { LerTagXMLTest }

  LerTagXMLTest = class(TTestCase)
  private

  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Simples;
    procedure SemIgnorarCase;
    procedure ComVariasTags;
  end;

  { SepararDadosTest }

  SepararDadosTest = class(TTestCase)
  private

  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Simples;
    procedure TextoLongo;
    procedure MostrarChave;
    procedure ComVariasChaves;
    procedure SemFecharChave;
    procedure SemAbrirChave;
  end;

  { padLTest }

  padLTest = class(TTestCase)
  private

  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure CompletarString;
    procedure ManterString;
    procedure TruncarString;
  end;

  { padRTest }

  padRTest = class(TTestCase)
  private

  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure CompletarString;
   procedure ManterString;
   procedure TruncarString;
  end;

  { padCTest }

  padCTest = class(TTestCase)
  private

  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure PreencherString;
   procedure TruncarString;
  end;

  { padSTest }

  padSTest = class(TTestCase)
  private

  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure CompletarString;
   procedure TruncarString;
   procedure SubstituirSeparadorPorEspacos;
   procedure SubstituirSeparadorPorCaracter;
  end;

  { RemoverEspacosDuplosTest }

  RemoverEspacosDuplosTest = class(TTestCase)
  private

  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure RemoverApenasEspacosDuplos;
   procedure RemoverMaisQueDoisEspacos;
  end;

  { RemoveStringTest }

  RemoveStringTest = class(TTestCase)
  private

  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure Remover;
  end;

  { RemoveStringsTest }

  RemoveStringsTest = class(TTestCase)
  private
    StringsToRemove: array [1..5] of AnsiString;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure TextoSimples;
   procedure TextoLongo;
  end;

  { StripHTMLTest }

  StripHTMLTest = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure TesteSimples;
   procedure TesteCompleto;
  end;

  { CompareVersionsTest }

  CompareVersionsTest = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure VersaoIgual;
   procedure VersaoMaior;
   procedure VersaoMenor;
   procedure TrocarDelimitador;
  end;

  { IfEmptyThenTest }

  IfEmptyThenTest = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure RetornarValorNormal;
   procedure SeVazioRetornaValorPadrao;
   procedure RealizarDoTrim;
   procedure NaoRealizarDoTrim;
  end;

  { Poem_ZerosTest }

  Poem_ZerosTest = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure ColocarZeros;
  end;

  { IntToStrZeroTest }

  IntToStrZeroTest = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure AdicionarZerosAoNumero;
   procedure TamanhoMenorQueLimite;
  end;

  { FloatToIntStrTest }

  FloatToIntStrTest = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure Normal;
   procedure ValorSemDecimais;
   procedure MudandoPadraoDeDecimais;
   procedure EnviandoDecimaisDiferenteDoPadrao;
  end;

  { FloatToStringTest }

  FloatToStringTest = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure Normal;
   procedure ComDecimaisZerados;
  end;

  { StringToFloatTest }

  StringToFloatTest = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure Normal;
  end;

  { StringToFloatDefTest }

  StringToFloatDefTest = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure Normal;
   procedure ValorDefault;
  end;

  { StringToDateTimeTest }

  StringToDateTimeTest = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure Data;
   procedure Hora;
   procedure DataEHora;
  end;

  { StringToDateTimeDefTest }

  StringToDateTimeDefTest = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure Data;
   procedure Hora;
   procedure DataEHora;
   procedure ValorDefault;
  end;

  { StoDTest }

  StoDTest = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure Normal;
   procedure DataInvalida;
  end;

  { DtoSTest }

  DtoSTest = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure Data;
  end;

  { DTtoSTest }

  DTtoSTest = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure DataEHora;
   procedure DataSemHora;
  end;

  { StrIsAlphaTest }

  StrIsAlphaTest = class(TTestCase)
  private
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure Texto;
   procedure TextoComNumeros;
   procedure TextoComCaractersEspeciais;
   procedure TextoComCaractersAcentuados;
  end;

implementation

{ StrIsAlphaTest }

procedure StrIsAlphaTest.SetUp;
begin
  inherited SetUp;
end;

procedure StrIsAlphaTest.TearDown;
begin
  inherited TearDown;
end;

procedure StrIsAlphaTest.Texto;
begin
  CheckTrue(StrIsAlpha('TesteACBrUtil'));
end;

procedure StrIsAlphaTest.TextoComNumeros;
begin
  CheckFalse(StrIsAlpha('TesteACBrUtil1234'));
end;

procedure StrIsAlphaTest.TextoComCaractersEspeciais;
begin
  CheckFalse(StrIsAlpha('_%#$@$*&!""'));
end;

procedure StrIsAlphaTest.TextoComCaractersAcentuados;
begin
  CheckTrue(StrIsAlpha('TesteACBrÃštil'));
end;

{ DTtoSTest }

procedure DTtoSTest.SetUp;
begin
  inherited SetUp;
end;

procedure DTtoSTest.TearDown;
begin
  inherited TearDown;
end;

procedure DTtoSTest.DataEHora;
var
  Date: TDateTime;
begin
  Date := StrToDateTime('14/01/2015 12:51:49');
  CheckEquals('20150114125149', DTtoS(Date));;
end;

procedure DTtoSTest.DataSemHora;
var
  Date: TDateTime;
begin
  Date := StrToDate('14/01/2015');
  CheckEquals('20150114000000', DTtoS(Date));
end;

{ DtoSTest }

procedure DtoSTest.SetUp;
begin
  inherited SetUp;
end;

procedure DtoSTest.TearDown;
begin
  inherited TearDown;
end;

procedure DtoSTest.Data;
var
  Date: TDateTime;
begin
  Date := StrToDate('14/01/2015');
  CheckEquals('20150114', DtoS(Date));
end;

{ StoDTest }

procedure StoDTest.SetUp;
begin
  inherited SetUp;
end;

procedure StoDTest.TearDown;
begin
  inherited TearDown;
end;

procedure StoDTest.Normal;
var
  Date: TDateTime;
begin
  Date := StrToDateTime('14/01/2015 16:28:12');
  CheckEquals(Date, StoD('20150114162812'));
end;

procedure StoDTest.DataInvalida;
begin
  CheckEquals(0, StoD('DataInvalida'));
end;

{ StringToDateTimeDefTest }

procedure StringToDateTimeDefTest.SetUp;
begin
  inherited SetUp;
end;

procedure StringToDateTimeDefTest.TearDown;
begin
  inherited TearDown;
end;

procedure StringToDateTimeDefTest.Data;
var
  Date: TDateTime;
begin
  Date := StrToDate('01/01/2015');
  CheckEquals(Date, StringToDateTimeDef('01/01/2015', Date));
end;

procedure StringToDateTimeDefTest.Hora;
var
  Date: TDateTime;
begin
  Date := StrToTime('12:45:12');
  CheckEquals(Date, StringToDateTimeDef('12:45:12', Date));
end;

procedure StringToDateTimeDefTest.DataEHora;
var
  Date: TDateTime;
begin
  Date := StrToDateTime('14/01/2015 12:45:12');
  CheckEquals(Date, StringToDateTimeDef('14/01/2015 12:45:12', Date));
end;

procedure StringToDateTimeDefTest.ValorDefault;
var
  Date: TDateTime;
begin
  Date := StrToDateTime('14/01/2015 12:45:12');
  CheckEquals(Date, StringToDateTimeDef('01-01-2001 00:01:12', Date));
end;

{ StringToDateTimeTest }

procedure StringToDateTimeTest.SetUp;
begin
  inherited SetUp;
end;

procedure StringToDateTimeTest.TearDown;
begin
  inherited TearDown;
end;

procedure StringToDateTimeTest.Data;
var
  Date: TDateTime;
begin
  Date := StrToDate('01/01/2015');
  CheckEquals(Date, StringToDateTime('01/01/2015'));
end;

procedure StringToDateTimeTest.Hora;
var
  Date: TDateTime;
begin
  Date := StrToTime('12:45:12');
  CheckEquals(Date, StringToDateTime('12:45:12'));
end;

procedure StringToDateTimeTest.DataEHora;
var
  Date: TDateTime;
begin
  Date := StrToDateTime('14/01/2015 12:45:12');
  CheckEquals(Date, StringToDateTime('14/01/2015 12:45:12'));
end;

{ StringToFloatDefTest }

procedure StringToFloatDefTest.SetUp;
begin
  inherited SetUp;
end;

procedure StringToFloatDefTest.TearDown;
begin
  inherited TearDown;
end;

procedure StringToFloatDefTest.Normal;
begin
  CheckEquals(123.45, StringToFloatDef('123.45', 10.00));
end;

procedure StringToFloatDefTest.ValorDefault;
begin
  CheckEquals(123.45, StringToFloatDef('ewerwt', 123.45));
end;

{ StringToFloatTest }

procedure StringToFloatTest.SetUp;
begin
  inherited SetUp;
end;

procedure StringToFloatTest.TearDown;
begin
  inherited TearDown;
end;

procedure StringToFloatTest.Normal;
begin
  CheckEquals(123.45, StringToFloat('123.45'));
end;


{ FloatToStringTest }

procedure FloatToStringTest.SetUp;
begin
  inherited SetUp;
end;

procedure FloatToStringTest.TearDown;
begin
  inherited TearDown;
end;

procedure FloatToStringTest.Normal;
begin
  CheckEquals('115.89', FloatToString(115.89));
end;

procedure FloatToStringTest.ComDecimaisZerados;
begin
  CheckEquals('115', FloatToString(115.00));
end;

{ FloatToIntStrTest }

procedure FloatToIntStrTest.SetUp;
begin
  inherited SetUp;
end;

procedure FloatToIntStrTest.TearDown;
begin
  inherited TearDown;
end;

procedure FloatToIntStrTest.Normal;
begin
  CheckEquals('12345', FloatToIntStr(123.45));
end;

procedure FloatToIntStrTest.ValorSemDecimais;
begin
  CheckEquals('1234500', FloatToIntStr(12345));
end;

procedure FloatToIntStrTest.MudandoPadraoDeDecimais;
begin
  CheckEquals('12345000', FloatToIntStr(123.45, 5));
end;

procedure FloatToIntStrTest.EnviandoDecimaisDiferenteDoPadrao;
begin
  CheckEquals('12345', FloatToIntStr(123.453));
end;

{ IntToStrZeroTest }

procedure IntToStrZeroTest.SetUp;
begin
  inherited SetUp;
end;

procedure IntToStrZeroTest.TearDown;
begin
  inherited TearDown;
end;

procedure IntToStrZeroTest.AdicionarZerosAoNumero;
begin
  CheckEquals('0000000123', IntToStrZero(123, 10));
end;

procedure IntToStrZeroTest.TamanhoMenorQueLimite;
begin
  CheckEquals('98', IntToStrZero(987, 2));
end;

{ Poem_ZerosTest }

procedure Poem_ZerosTest.SetUp;
begin
  inherited SetUp;
end;

procedure Poem_ZerosTest.TearDown;
begin
  inherited TearDown;
end;

procedure Poem_ZerosTest.ColocarZeros;
begin
  CheckEquals('000000TesteACBr', Poem_Zeros('TesteACBr', 15));
  CheckEquals('000000000000000', Poem_Zeros('         ', 15));
end;

{ IfEmptyThenTest }

procedure IfEmptyThenTest.SetUp;
begin
  inherited SetUp;
end;

procedure IfEmptyThenTest.TearDown;
begin
  inherited TearDown;
end;

procedure IfEmptyThenTest.RetornarValorNormal;
begin
  CheckEquals('ACBrTeste', IfEmptyThen('ACBrTeste', 'ValorPadrao'));
end;

procedure IfEmptyThenTest.SeVazioRetornaValorPadrao;
begin
  CheckEquals('ValorPadrao', IfEmptyThen('', 'ValorPadrao'));
end;

procedure IfEmptyThenTest.RealizarDoTrim;
begin
  CheckEquals('ValorPadrao', IfEmptyThen('      ', 'ValorPadrao', true));
  CheckEquals('ValorPadrao', IfEmptyThen('      ', 'ValorPadrao'));
end;

procedure IfEmptyThenTest.NaoRealizarDoTrim;
begin
  CheckEquals('ACBrTeste  ', IfEmptyThen('ACBrTeste  ', 'ValorPadrao', false));
end;

{ CompareVersionsTest }

procedure CompareVersionsTest.SetUp;
begin
  inherited SetUp;
end;

procedure CompareVersionsTest.TearDown;
begin
  inherited TearDown;
end;

procedure CompareVersionsTest.VersaoIgual;
begin
   CheckEquals(0, CompareVersions('1.3.1' , '1.3.1'));
end;

procedure CompareVersionsTest.VersaoMaior;
begin
   CheckEquals(11, CompareVersions('1.3.4' , '1.2.1'));
end;

procedure CompareVersionsTest.VersaoMenor;
begin
   CheckEquals(-11, CompareVersions('1.2.1' , '1.3.4'));
end;

procedure CompareVersionsTest.TrocarDelimitador;
begin
   CheckEquals(-109, CompareVersions('1-4-9', '3-8-7', '-'));
end;

{ StripHTMLTest }

procedure StripHTMLTest.SetUp;
begin
  inherited SetUp;
end;

procedure StripHTMLTest.TearDown;
begin
  inherited TearDown;
end;

procedure StripHTMLTest.TesteSimples;
begin
  CheckEquals('Teste string em html', StripHTML('<br><b>Teste string em html</b><br>'));
end;

procedure StripHTMLTest.TesteCompleto;
begin
  CheckEquals('FPCUnit de TestesACBrUtil, Testes Unitários', StripHTML('<!DOCTYPE html>'
                           +'<html>'
                               +'<head>'
                                   +'FPCUnit de Testes'
                               +'</head>'
                               +'<body>'
                                   +'ACBrUtil, Testes Unitários'
                               +'</body>'
                           +'</html>'));
end;

{ RemoveStringsTest }

procedure RemoveStringsTest.SetUp;
begin
  StringsToRemove[1] := 'a';
  StringsToRemove[2] := 'b';
  StringsToRemove[3] := 'c';
  StringsToRemove[4] := 'te';
  StringsToRemove[5] := 'AC';
end;

procedure RemoveStringsTest.TearDown;
begin
  inherited TearDown;
end;

procedure RemoveStringsTest.TextoSimples;
begin
  CheckEquals('s', RemoveStrings('testeabc', StringsToRemove));
end;

procedure RemoveStringsTest.TextoLongo;
begin
  CheckEquals('Tes Unitrio BrUtil ', RemoveStrings('Teste Unitario ACBrUtil ', StringsToRemove));
end;

{ RemoveStringTest }

procedure RemoveStringTest.SetUp;
begin
  inherited SetUp;
end;

procedure RemoveStringTest.TearDown;
begin
  inherited TearDown;
end;

procedure RemoveStringTest.Remover;
begin
  CheckEquals('TstACBr', RemoveString('e', 'TesteACBr'));
  CheckEquals('#####', RemoveString('ACBr', '#ACBr#ACBr#ACBr#ACBr#'));
end;

{ RemoverEspacosDuplosTest }

procedure RemoverEspacosDuplosTest.SetUp;
begin
  inherited SetUp;
end;

procedure RemoverEspacosDuplosTest.TearDown;
begin
  inherited TearDown;
end;

procedure RemoverEspacosDuplosTest.RemoverApenasEspacosDuplos;
begin
  CheckEquals('Teste ACBr', RemoverEspacosDuplos('  Teste  ACBr  '));
end;

procedure RemoverEspacosDuplosTest.RemoverMaisQueDoisEspacos;
begin
  CheckEquals('Teste ACBr Com FPCUnit', RemoverEspacosDuplos('Teste    ACBr Com  FPCUnit     '));
end;

{ padSTest }

procedure padSTest.SetUp;
begin
  inherited SetUp;
end;

procedure padSTest.TearDown;
begin
  inherited TearDown;
end;

procedure padSTest.CompletarString;
begin
  CheckEquals('TesteACBrZZZZZZ', padS('TesteACBr', 15, '|', 'Z'));
  CheckEquals('TesteACBr      ', padS('TesteACBr', 15, '|'));
end;

procedure padSTest.TruncarString;
begin
  CheckEquals('TesteACBr', padS('TesteACBrZZZZZZ', 9, '|'));
end;

procedure padSTest.SubstituirSeparadorPorEspacos;
begin
  CheckEquals(' Teste Unitario ACBr ', padS('|Teste|Unitario|ACBr|', 21, '|'));
  CheckEquals('   Teste   Unitario   ACBr    ', padS('|Teste|Unitario|ACBr|', 30, '|'));
end;

procedure padSTest.SubstituirSeparadorPorCaracter;
begin
  CheckEquals('ZTesteZUnitarioZACBrZ', padS('|Teste|Unitario|ACBr|', 21, '|', 'Z'));
  CheckEquals('ZZZTesteZZZUnitarioZZZACBrZZZZ', padS('|Teste|Unitario|ACBr|', 30, '|', 'Z'));
end;

{ padCTest }

procedure padCTest.SetUp;
begin
  inherited SetUp;
end;

procedure padCTest.TearDown;
begin
  inherited TearDown;
end;

procedure padCTest.PreencherString;
begin
  CheckEquals('ZZZTESTEZZZZ', padC('TESTE', 12, 'Z'));
  CheckEquals('ZZZZTESTEZZZZ', padC('TESTE', 13, 'Z'));
  CheckEquals('    TESTE    ', padC('TESTE', 13));
end;

procedure padCTest.TruncarString;
begin
  CheckEquals('TesteACBr', padC('TesteACBrUtil', 9));
end;

{ padRTest }

procedure padRTest.SetUp;
begin
  inherited SetUp;
end;

procedure padRTest.TearDown;
begin
  inherited TearDown;
end;

procedure padRTest.CompletarString;
begin
  CheckEquals('ZZZACBrCompletaString', padR('ACBrCompletaString', 21, 'Z'));
  CheckEquals('   ACBrCompletaString', padR('ACBrCompletaString', 21));
end;

procedure padRTest.ManterString;
begin
  CheckEquals('ACBrMantemString', padR('ACBrMantemString', 16, 'Z'));
end;

procedure padRTest.TruncarString;
begin
  CheckEquals('TruncaString', padR('ACBrTruncaString', 12, 'Z'));
end;

{ padLTest }

procedure padLTest.SetUp;
begin
  inherited SetUp;
end;

procedure padLTest.TearDown;
begin
  inherited TearDown;
end;

procedure padLTest.CompletarString;
begin
  CheckEquals('ACBrCompletaStringZZZ', padL('ACBrCompletaString', 21, 'Z'));
  CheckEquals('ACBrCompletaString   ', padL('ACBrCompletaString', 21));
end;

procedure padLTest.ManterString;
begin
  CheckEquals('ACBrMantemString', padL('ACBrMantemString', 16, 'Z'));
end;

procedure padLTest.TruncarString;
begin
  CheckEquals('ACBrTrunca', padL('ACBrTruncaString', 10, 'Z'));
end;

{ SepararDadosTest }

procedure SepararDadosTest.SetUp;
begin
  Inherited SetUp;
end;

procedure SepararDadosTest.TearDown;
begin
  Inherited TearDown;
end;

procedure SepararDadosTest.Simples;
begin
  CheckEquals('Teste Simples', SeparaDados('<ACBr>Teste Simples</ACBr>', 'ACBr'));
  CheckEquals('Teste     Simples', SeparaDados('<ACBr>Teste     Simples</ACBr>', 'ACBr'));
  CheckEquals('TesteSimples', SeparaDados('<ACBr>TesteSimples</ACBr>', 'ACBr'));
end;

procedure SepararDadosTest.TextoLongo;
begin
  CheckEquals('ACBr Util', SeparaDados('<ACBrUtil>Teste com texto longo <b>ACBr Util</b> feito por DJSystem</ACBrUtil>', 'b'));
  CheckEquals('#ACBrUtil', SeparaDados('<ACBrUtil>Teste com texto longo <b>#ACBrUtil</b> feito por DJSystem</ACBrUtil>', 'b'));
end;

procedure SepararDadosTest.MostrarChave;
begin
  CheckEquals('<ACBr>Teste Simples</ACBr>', SeparaDados('<ACBr>Teste Simples</ACBr>', 'ACBr',  true));
  CheckEquals('<ACBrTeste>Teste     Simples</ACBrTeste>', SeparaDados('<ACBrTeste>Teste     Simples</ACBrTeste>', 'ACBrTeste', true));
  CheckEquals('<ACBr>TesteSimples</ACBr>', SeparaDados('<ACBr>TesteSimples</ACBr>', 'ACBr', true));
  CheckEquals('<b>ACBr Util</b>', SeparaDados('<ACBrUtil>Teste com texto longo <b>ACBr Util</b> feito por DJSystem', 'b', true));
  CheckEquals('<u>#ACBrUtil</u>', SeparaDados('<ACBrUtil>Teste com texto longo <u>#ACBrUtil</u> feito por DJSystem', 'u', true));
end;

procedure SepararDadosTest.ComVariasChaves;
begin
  CheckEquals('ACBrUtil', SeparaDados('<ACBr>Teste <ACBrTeste>ACBrUtil</ACBrTeste> com <ACBrTeste>FPCUnit</ACBrTeste></ACBr>', 'ACBrTeste'));
end;

procedure SepararDadosTest.SemFecharChave;
begin
  CheckEquals('', SeparaDados('<ACBrUtil>Teste com texto longo <b>ACBr Util</b> realizado por FPCUnit', 'ACBrUtil'));
end;

procedure SepararDadosTest.SemAbrirChave;
begin
  CheckEquals('', SeparaDados('Teste com texto longo <b>ACBr Util</b> realizado por FPCUnit</ACBrUtil>', 'ACBrUtil'));
end;

{ LerTagXMLTest }

procedure LerTagXMLTest.SetUp;
begin
  inherited SetUp;
end;

procedure LerTagXMLTest.TearDown;
begin
  inherited TearDown;
end;

procedure LerTagXMLTest.Simples;
begin
  CheckEquals('Teste Simples', LerTagXML('<ACBr>Teste Simples</ACBr>', 'acbr'));
end;

procedure LerTagXMLTest.SemIgnorarCase;
begin
  CheckEquals('Teste sem ignorar case', LerTagXML('<ACBr>Teste sem ignorar case</ACBr>', 'ACBr', false));
  CheckEquals('', LerTagXML('<ACBr>Teste sem ignorar case</ACBr>', 'acbr', false));
  CheckEquals('Ler Aqui', LerTagXML('<ACBr>Teste sem <acbr>Ler Aqui</acbr> ignorar case</ACBr>', 'acbr', false));
end;

procedure LerTagXMLTest.ComVariasTags;
begin
  CheckEquals('mais um teste', LerTagXML('<ACBr> teste <br> outro teste </br> <b>mais um teste</b> </ACBr>', 'b'));
end;

{ ParseTextTest }

procedure ParseTextTest.SetUp;
begin
  inherited SetUp;
end;

procedure ParseTextTest.TearDown;
begin
  inherited TearDown;
end;

procedure ParseTextTest.VerificarConversao;
begin
  CheckEquals('&', ParseText('&amp;'));
  CheckEquals('<', ParseText('&lt;'));
  CheckEquals('>', ParseText('&gt;'));
  CheckEquals('"', ParseText('&quot;'));
  CheckEquals(#39, ParseText('&#39;'));
  CheckEquals('Ã¡', ParseText('&aacute;', True, False));
  CheckEquals('Ã', ParseText('&Aacute;', True, False));
  CheckEquals('Ã¢', ParseText('&acirc;',  True, False));
  CheckEquals('Ã‚', ParseText('&Acirc;',  True, False));
  CheckEquals('Ã£', ParseText('&atilde;', True, False));
  CheckEquals('Ãƒ', ParseText('&Atilde;', True, False));
  CheckEquals('Ã ', ParseText('&agrave;', True, False));
  CheckEquals('Ã€', ParseText('&Agrave;', True, False));
  CheckEquals('Ã©', ParseText('&eacute;', True, False));
  CheckEquals('Ã‰', ParseText('&Eacute;', True, False));
  CheckEquals('Ãª', ParseText('&ecirc;',  True, False));
  CheckEquals('ÃŠ', ParseText('&Ecirc;',  True, False));
  CheckEquals('Ã­', ParseText('&iacute;', True, False));
  CheckEquals('Ã', ParseText('&Iacute;', True, False));
  CheckEquals('Ã³', ParseText('&oacute;', True, False));
  CheckEquals('Ã“', ParseText('&Oacute;', True, False));
  CheckEquals('Ãµ', ParseText('&otilde;', True, False));
  CheckEquals('Ã•', ParseText('&Otilde;', True, False));
  CheckEquals('Ã´', ParseText('&ocirc;',  True, False));
  CheckEquals('Ã”', ParseText('&Ocirc;',  True, False));
  CheckEquals('Ãº', ParseText('&uacute;', True, False));
  CheckEquals('Ãš', ParseText('&Uacute;', True, False));
  CheckEquals('Ã¼', ParseText('&uuml;',   True, False));
  CheckEquals('Ãœ', ParseText('&Uuml;',   True, False));
  CheckEquals('Ã§', ParseText('&ccedil;', True, False));
  CheckEquals('Ã‡', ParseText('&Ccedil;', True, False));
  CheckEquals('''', ParseText('&apos;',  True, False));
end;

procedure ParseTextTest.VerificarConversaoTextoLongo;
begin
  //A Fazer
  CheckEquals('&<>"', ParseText('&amp;&lt;&gt;&quot;'));
  CheckEquals('&"<>', ParseText('&amp;&quot;&lt;&gt;'));
  CheckEquals('<&">', ParseText('&lt;&amp;&quot;&gt;'));
end;

initialization

  RegisterTest('ACBrComum.ACBrUtil', ParseTextTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', LerTagXMLTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', SepararDadosTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', padLTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', padRTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', padCTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', padSTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', RemoverEspacosDuplosTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', RemoveStringTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', RemoveStringsTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StripHTMLTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', CompareVersionsTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', IfEmptyThenTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', Poem_ZerosTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', IntToStrZeroTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', FloatToIntStrTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', FloatToStringTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StringToFloatTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StringToFloatDefTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StringToDateTimeTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StringToDateTimeDefTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StoDTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', DtoSTest{$ifndef FPC}.Suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', DTtoSTest{$ifndef FPC}.suite{$endif});
  RegisterTest('ACBrComum.ACBrUtil', StrIsAlphaTest{$ifndef FPC}.suite{$endif});
end.

