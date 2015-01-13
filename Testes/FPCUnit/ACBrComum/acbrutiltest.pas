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
    procedure LerTagSimples;
    procedure LerTagSemIgnorarCase;
    procedure LerComVariasTags;
  end;

  { SepararDadosTest }

  SepararDadosTest = class(TTestCase)
  private

  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure SepararTextoSimples;
    procedure SepararTextoLongo;
    procedure SepararTextoEMostrarChave;
    procedure SepararTextoComVariasChaves;
    procedure SepararTextoSemFecharChave;
    procedure SepararTextoSemAbrirChave;
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

  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
   procedure Teste;
  end;

implementation

{ RemoveStringsTest }

procedure RemoveStringsTest.SetUp;
begin
  inherited SetUp;
end;

procedure RemoveStringsTest.TearDown;
begin
  inherited TearDown;
end;

procedure RemoveStringsTest.Teste;
begin

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

procedure SepararDadosTest.SepararTextoSimples;
begin
  CheckEquals('Teste Simples', SeparaDados('<ACBr>Teste Simples</ACBr>', 'ACBr'));
  CheckEquals('Teste     Simples', SeparaDados('<ACBr>Teste     Simples</ACBr>', 'ACBr'));
  CheckEquals('TesteSimples', SeparaDados('<ACBr>TesteSimples</ACBr>', 'ACBr'));
end;

procedure SepararDadosTest.SepararTextoLongo;
begin
  CheckEquals('ACBr Util', SeparaDados('<ACBrUtil>Teste com texto longo <b>ACBr Util</b> feito por DJSystem</ACBrUtil>', 'b'));
  CheckEquals('#ACBrUtil', SeparaDados('<ACBrUtil>Teste com texto longo <b>#ACBrUtil</b> feito por DJSystem</ACBrUtil>', 'b'));
end;

procedure SepararDadosTest.SepararTextoEMostrarChave;
begin
  CheckEquals('<ACBr>Teste Simples</ACBr>', SeparaDados('<ACBr>Teste Simples</ACBr>', 'ACBr',  true));
  CheckEquals('<ACBrTeste>Teste     Simples</ACBrTeste>', SeparaDados('<ACBrTeste>Teste     Simples</ACBrTeste>', 'ACBrTeste', true));
  CheckEquals('<ACBr>TesteSimples</ACBr>', SeparaDados('<ACBr>TesteSimples</ACBr>', 'ACBr', true));
  CheckEquals('<b>ACBr Util</b>', SeparaDados('<ACBrUtil>Teste com texto longo <b>ACBr Util</b> feito por DJSystem', 'b', true));
  CheckEquals('<u>#ACBrUtil</u>', SeparaDados('<ACBrUtil>Teste com texto longo <u>#ACBrUtil</u> feito por DJSystem', 'u', true));
end;

procedure SepararDadosTest.SepararTextoComVariasChaves;
begin
  CheckEquals('ACBrUtil', SeparaDados('<ACBr>Teste <ACBrTeste>ACBrUtil</ACBrTeste> com <ACBrTeste>FPCUnit</ACBrTeste></ACBr>', 'ACBrTeste'));
end;

procedure SepararDadosTest.SepararTextoSemFecharChave;
begin
  CheckEquals('', SeparaDados('<ACBrUtil>Teste com texto longo <b>ACBr Util</b> realizado por FPCUnit', 'ACBrUtil'));
end;

procedure SepararDadosTest.SepararTextoSemAbrirChave;
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

procedure LerTagXMLTest.LerTagSimples;
begin
  CheckEquals('Teste Simples', LerTagXML('<ACBr>Teste Simples</ACBr>', 'acbr'));
end;

procedure LerTagXMLTest.LerTagSemIgnorarCase;
begin
  CheckEquals('Teste sem ignorar case', LerTagXML('<ACBr>Teste sem ignorar case</ACBr>', 'ACBr', false));
  CheckEquals('', LerTagXML('<ACBr>Teste sem ignorar case</ACBr>', 'acbr', false));
  CheckEquals('Ler Aqui', LerTagXML('<ACBr>Teste sem <acbr>Ler Aqui</acbr> ignorar case</ACBr>', 'acbr', false));
end;

procedure LerTagXMLTest.LerComVariasTags;
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
  CheckEquals('á', ParseText('&aacute;', True, False));
  CheckEquals('Á', ParseText('&Aacute;', True, False));
  CheckEquals('â', ParseText('&acirc;',  True, False));
  CheckEquals('Â', ParseText('&Acirc;',  True, False));
  CheckEquals('ã', ParseText('&atilde;', True, False));
  CheckEquals('Ã', ParseText('&Atilde;', True, False));
  CheckEquals('à', ParseText('&agrave;', True, False));
  CheckEquals('À', ParseText('&Agrave;', True, False));
  CheckEquals('é', ParseText('&eacute;', True, False));
  CheckEquals('É', ParseText('&Eacute;', True, False));
  CheckEquals('ê', ParseText('&ecirc;',  True, False));
  CheckEquals('Ê', ParseText('&Ecirc;',  True, False));
  CheckEquals('í', ParseText('&iacute;', True, False));
  CheckEquals('Í', ParseText('&Iacute;', True, False));
  CheckEquals('ó', ParseText('&oacute;', True, False));
  CheckEquals('Ó', ParseText('&Oacute;', True, False));
  CheckEquals('õ', ParseText('&otilde;', True, False));
  CheckEquals('Õ', ParseText('&Otilde;', True, False));
  CheckEquals('ô', ParseText('&ocirc;',  True, False));
  CheckEquals('Ô', ParseText('&Ocirc;',  True, False));
  CheckEquals('ú', ParseText('&uacute;', True, False));
  CheckEquals('Ú', ParseText('&Uacute;', True, False));
  CheckEquals('ü', ParseText('&uuml;',   True, False));
  CheckEquals('Ü', ParseText('&Uuml;',   True, False));
  CheckEquals('ç', ParseText('&ccedil;', True, False));
  CheckEquals('Ç', ParseText('&Ccedil;', True, False));
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
end.

