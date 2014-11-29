{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 04/04/2013:  Andr� Ferreira de Moraes
|*   Inicio do desenvolvimento
|* 20/11/2014:  Welkson Renny de Medeiros
|*   Contribui��es para impress�o na Bematech e Daruma
|* 25/11/2014: R�gys Silveira
|*   Acertos gerais e adapta��o do layout a norma t�cnica
|*   adi��o de m�todo para impress�o de relat�rios
|*   adi��o de impress�o de eventos
|* 28/11/2014: R�gys Silveira
|*   Implementa��o da possibilidade de utilizar tags nos relatorios (segue o
|*   padr�o do acbrecf)
******************************************************************************}

{$I ACBr.inc}

unit ACBrNFeDANFeESCPOS;

interface

uses
  Classes, SysUtils, {$IFDEF FPC} LResources, {$ENDIF}
  ACBrNFeDANFEClass, ACBrDevice, ACBrUtil, ACBrDFeUtil,
  pcnNFe, pcnEnvEventoNFe, pcnConversao, pcnAuxiliar;

type
  TACBrNFeMarcaImpressora = (iEpson, iBematech, iDaruma);

  TACBrNFeDANFeESCPOS = class(TACBrNFeDANFEClass)
  private
    FDevice: TACBrDevice;
    FMarcaImpressora: TACBrNFeMarcaImpressora;
    FLinhasEntreCupons: Integer;
    FImprimeEmUmaLinha: Boolean;
    FLinhaCmd: AnsiString;
    FBuffer: TStringList;
    FImprimeDescAcrescItem: Boolean;
    FIgnorarTagsFormatacao: Boolean;

    cCmdImpZera: String;
    cCmdEspacoLinha: String;
    cCmdPagCod: String;
    cCmdImpNegrito: String;
    cCmdImpFimNegrito: String;
    cCmdImpExpandido: String;
    cCmdImpFimExpandido: String;
    cCmdFonteNormal: String;
    cCmdFontePequena: String;
    cCmdImpSublinhado: String;
    cCmdImpFimSublinhado: String;
    cCmdImpItalico: String;
    cCmdImpFimItalico: String;
    cCmdImpCondensado: String;
    cCmdImpFimCondensado: String;
    cCmdAlinhadoEsquerda: String;
    cCmdAlinhadoCentro: String;
    cCmdAlinhadoDireita: String;
    cCmdCortaPapel: String;
    cCmdImprimeLogo: String;

    cCmdCodeBarEAN8: String;
    cCmdCodeBarEAN13: String;
    cCmdCodeBarSTD25: String;
    cCmdCodeBarINTER25: String;
    cCmdCodeBarCODE11: String;
    cCmdCodeBarCODE39: String;
    cCmdCodeBarCODE93: String;
    cCmdCodeBarCODE128: String;
    cCmdCodeBarUPCA: String;
    cCmdCodeBarCODABAR: String;
    cCmdCodeBarMSI: String;
    cCmdCodeBarFim: String;

    nLargPapel: Integer;
    FConfigBarras: TACBrECFConfigBarras;

    procedure InicializarComandos;
    procedure ImprimePorta(AString: AnsiString);
    procedure MontarEnviarDANFE(NFE: TNFe; const AResumido: Boolean);

    function Int2TB(AInteger: Integer): AnsiString;
    function GetLinhaSimples: String;
    function GetLinhaDupla: String;
    function DecodificarTagsFormatacao(AString: AnsiString): AnsiString;
    function TraduzirTag(const ATag: AnsiString): AnsiString;
  protected
    FpNFe: TNFe;
    FpEvento: TEventoNFe;
    procedure GerarCabecalho;
    procedure GerarItens;
    procedure GerarTotais(Resumido: Boolean = False);
    procedure GerarPagamentos(Resumido: Boolean = False);
    procedure GerarTotTrib;
    procedure GerarObsCliente;
    procedure GerarObsFisco;
    procedure GerarDadosConsumidor;
    procedure GerarRodape(CortaPapel: Boolean = True; Cancelamento: Boolean = False);
    procedure GerarDadosEvento;
    procedure GerarObservacoesEvento;
    procedure GerarClicheEmpresa;
    procedure PulaLinhas(NumLinhas: Integer = 0);
    function ParseTextESCPOS(Text: AnsiString): AnsiString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE: TNFe = nil); override;
    procedure ImprimirDANFEResumido(NFE: TNFe = nil); override;
    procedure ImprimirEVENTO(NFE: TNFe = nil); override;

    procedure ImprimirRelatorio(const ATexto: TStrings; const AVias: Integer = 1;
      const ACortaPapel: Boolean = True);
    procedure CortarPapel;
  published
    property Device: TACBrDevice read FDevice;
    property ConfigBarras: TACBrECFConfigBarras read FConfigBarras write FConfigBarras;
    property MarcaImpressora: TACBrNFeMarcaImpressora read FMarcaImpressora write FMarcaImpressora default iEpson;
    property LinhasEntreCupons: Integer read FLinhasEntreCupons write FLinhasEntreCupons default 21;
    property ImprimeEmUmaLinha: Boolean read FImprimeEmUmaLinha write FImprimeEmUmaLinha default True;
    property ImprimeDescAcrescItem: Boolean read FImprimeDescAcrescItem write FImprimeDescAcrescItem default True;
    property IgnorarTagsFormatacao: Boolean read FIgnorarTagsFormatacao write FIgnorarTagsFormatacao default False;
  end;

procedure Register;

implementation

uses
  ACBrNFe, ACBrNFeUtil, StrUtils, Math, ACBrConsts;

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrNFeDANFeESCPOS]);
end;

{ TACBrNFeDANFeESCPOS }

function TACBrNFeDANFeESCPOS.Int2TB(AInteger: Integer): AnsiString;
var
  AHexStr: String;
begin
  AHexStr := IntToHex(AInteger, 4);
  Result  := AnsiChar(chr(StrToInt('$' + copy(AHexStr, 3, 2)))) + AnsiChar(chr(StrToInt('$' + copy(AHexStr, 1, 2))));
  AHexStr := Result;
end;

function TACBrNFeDANFeESCPOS.TraduzirTag(const ATag: AnsiString): AnsiString;
var
  I: Integer;
  LowerTag: AnsiString;

  function ConfigurarBarras(const ACodigo: AnsiString): AnsiString;
  var
    Largura: Integer;
    Altura: Integer;
    Mostrar: AnsiString;
  begin
    if Trim(ACodigo) <> '' then
    begin
      Largura := StrToInt('$'+ IntToHex( max( min( ConfigBarras.LarguraLinha, 5), 2), 2));
      Altura  := StrToInt('$'+ IntToHex( max( min( ConfigBarras.Altura, 200), 50), 2));
      Mostrar := IfThen(ConfigBarras.MostrarCodigo, '1', '0');

      Result := ACodigo + chr(Largura) + chr(Altura) + Mostrar;
    end;
  end;

begin
  {*****************************************************************************
  tags permitidas pelo acbr, nem todas foram implementadas ainda.
  </linha_simples>,              0
  </linha_dupla>,                1
  <e>, </e>,                     2,3
  <n>, </n>,                     4,5
  <s>, </s>,                     6,7
  <c>, </c>,                     8,9
  <i>, </i>,                     10,11
  <ean8>, </ean8>,               12,13
  <ean13>, </ean13>,             14,15
  <std>, </std>,                 16,17
  <inter>, </inter>,             18,19
  <code11>, </code11>,           20,21
  <code39>, </code39>,           22,23
  <code93>, </code93>,           24,25
  <code128>, </code128>,         26,27
  <upca>, </upca>,               28,29
  <codabar>, </codabar>,         30,31
  <msi>, </msi>,                 32,33
  <ad>,</ad>,                    34,35
  <ce>,</ce>,                    36,37
  <ae>,</ae> );                  38,39
  <fn>,</fn>                     40,41
  <fp>,</fp>                     42,43
  *****************************************************************************}

  Result := '';
  if ATag = '' then
    exit;

  LowerTag := LowerCase(ATag);
  case AnsiIndexText(LowerTag, ARRAY_TAGS) of
    -1: Result := LowerTag;
     0: Result := GetLinhaSimples;
     1: Result := GetLinhaDupla;
     2: Result := cCmdImpExpandido;
     3: Result := cCmdImpFimExpandido;
     4: Result := cCmdImpNegrito;
     5: Result := cCmdImpFimNegrito;
     6: Result := cCmdImpSublinhado;
     7: Result := cCmdImpFimSublinhado;
     8: Result := cCmdImpCondensado;
     9: Result := cCmdImpFimCondensado;
    10: Result := cCmdImpItalico;
    11: Result := cCmdImpFimItalico;
    12: Result := ConfigurarBarras(cCmdCodeBarEAN8);
    13: Result := cCmdCodeBarFim;
    14: Result := ConfigurarBarras(cCmdCodeBarEAN13);
    15: Result := cCmdCodeBarFim;
    16: Result := ConfigurarBarras(cCmdCodeBarSTD25);
    17: Result := cCmdCodeBarFim;
    18: Result := ConfigurarBarras(cCmdCodeBarINTER25);
    19: Result := cCmdCodeBarFim;
    20: Result := ConfigurarBarras(cCmdCodeBarCODE11);
    21: Result := cCmdCodeBarFim;
    22: Result := ConfigurarBarras(cCmdCodeBarCODE39);
    23: Result := cCmdCodeBarFim;
    24: Result := ConfigurarBarras(cCmdCodeBarCODE93);
    25: Result := cCmdCodeBarFim;
    26: Result := ConfigurarBarras(cCmdCodeBarCODE128);
    27: Result := cCmdCodeBarFim;
    28: Result := ConfigurarBarras(cCmdCodeBarUPCA);
    29: Result := cCmdCodeBarFim;
    30: Result := ConfigurarBarras(cCmdCodeBarCODABAR);
    31: Result := cCmdCodeBarFim;
    32: Result := ConfigurarBarras(cCmdCodeBarMSI);
    33: Result := cCmdCodeBarFim;
    34: Result := cCmdAlinhadoDireita;
    35: Result := cCmdAlinhadoEsquerda;
    36: Result := cCmdAlinhadoCentro;
    37: Result := cCmdAlinhadoEsquerda;
    38: Result := cCmdAlinhadoEsquerda;
    39: Result := cCmdAlinhadoEsquerda;
    40: Result := cCmdFonteNormal;
    41: Result := ''; // n�o precisa voltar, porque � a fonte padr�o
    42: Result := cCmdFontePequena;
    43: Result := cCmdFonteNormal; // voltar para a fonte padr�o
    44: Result := cCmdImprimeLogo;
  else
    Result := '' ;
  end;
end;

function TACBrNFeDANFeESCPOS.DecodificarTagsFormatacao(AString: AnsiString): AnsiString;

  Procedure AchaTag(const AString: AnsiString; const PosIni: Integer; var ATag: AnsiString; var PosTag: Integer);
  var
    PosTagAux, FimTag, LenTag: Integer;
  begin
    ATag := '';
    PosTag := PosEx('<', AString, PosIni);
    if PosTag > 0 then
    begin
      // Verificando se Tag � inv�lida
      PosTagAux := PosEx('<', Result, PosTag + 1);
      FimTag := PosEx('>', Result, PosTag + 1);

      // Tag n�o fechada ?
      if FimTag = 0 then
      begin
        PosTag := 0;
        exit;
      end;

      while (PosTagAux > 0) and (PosTagAux < FimTag) do
      // Achou duas aberturas Ex: <<e>
      begin
        PosTag := PosTagAux;
        PosTagAux := PosEx('<', Result, PosTag + 1);
      end;

      LenTag := FimTag - PosTag + 1;
      ATag := copy(AString, PosTag, LenTag);
    end;
  end;

Var
  Tag1, Tag2, Cmd, LowerTag: AnsiString;
  PosTag1, IndTag1, LenTag1, PosTag2, FimTag: Integer;
begin
  Result := AString;

  Tag1    := '';
  PosTag1 := 0;
  AchaTag(Result, 1, Tag1, PosTag1);

  while Tag1 <> '' do
  begin
    LenTag1  := Length(Tag1);
    LowerTag := LowerCase(Tag1);
    IndTag1  := AnsiIndexText(LowerTag, ARRAY_TAGS);
    Tag2     := '';
    PosTag2  := 0;

    if IgnorarTagsFormatacao and (IndTag1 in TAGS_FORMATACAO) then
      Cmd := ''
    else
      Cmd := TraduzirTag(Tag1);

    FimTag := PosTag1 + LenTag1 - 1;

    if Cmd <> Tag1 then
    begin
      Result := StuffString(Result, PosTag1, LenTag1, Cmd);
      FimTag := FimTag + (Length(Cmd) - LenTag1);
    end;

    Tag1    := '';
    PosTag1 := 0;
    AchaTag(Result, FimTag + 1, Tag1, PosTag1);
  end;
end;

function TACBrNFeDANFeESCPOS.ParseTextESCPOS(Text: AnsiString): AnsiString;
begin
  // codifica linhas de texto com UTF-8 para evitar erros de acentua��o na Bematech
  if MarcaImpressora = iBematech then
    Result := UTF8Encode(Text)
  else
    Result := Text;
end;

constructor TACBrNFeDANFeESCPOS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // Instanciando SubComponente TACBrDevice
  FDevice := TACBrDevice.Create(self);

  // instanciando subclasse de configura��o de barras
  FConfigBarras := TACBrECFConfigBarras.Create;

  // O dono � o proprio componente
  FDevice.Name := 'ACBrDevice';

  {$IFDEF COMPILER6_UP}
  // Apenas para aparecer no Object Inspector
  FDevice.SetSubComponent(True);
  {$ENDIF}

  // para gravar no DFM/XFM
  FDevice.SetDefaultValues;
  FDevice.Porta := 'COM1';

  FBuffer            := TStringList.Create;
  FMarcaImpressora   := iEpson;
  FLinhasEntreCupons := 21;
end;

destructor TACBrNFeDANFeESCPOS.Destroy;
begin
  FBuffer.Free;
  FreeAndNil(FDevice);
  FreeAndNil(FConfigBarras);

  inherited Destroy;
end;

procedure TACBrNFeDANFeESCPOS.InicializarComandos;
begin
  if MarcaImpressora = iBematech then
  begin
    cCmdImpZera          := ESC + '@'#29#249#32#48;  // ESC + +'@' Inicializa impressora, demais selecionam ESC/Bema temporariamente
    cCmdEspacoLinha      := ESC + '3'#14;  // Verificar comando BEMA/POS
    cCmdPagCod           := ESC + 't'#8; // codepage UTF-8
    cCmdImpNegrito       := ESC + 'E'; //;ESC + 'N' + #3;
    cCmdImpFimNegrito    := ESC + 'F'; //;ESC + 'N' + #2;
    cCmdImpExpandido     := ESC + 'W'#1;
    cCmdImpFimExpandido  := ESC + 'W'#0;
    cCmdFonteNormal      := DC2;
    cCmdFontePequena     := SI;
    cCmdImpSublinhado    := ESC + '-'#1;
    cCmdImpFimSublinhado := ESC + '-'#0;
    cCmdImpItalico       := ESC + '4';
    cCmdImpFimItalico    := ESC + '5';
    cCmdImpCondensado    := ESC + SI;
    cCmdImpFimCondensado := ESC + 'H';
    cCmdAlinhadoEsquerda := ESC + 'a0';
    cCmdAlinhadoCentro   := ESC + 'a1';
    cCmdAlinhadoDireita  := ESC + 'a2'; // Verificar comando BEMA/POS
    cCmdCortaPapel       := ESC + 'w'#29#249#31#49; // ESC + +'w' corta papel, demais voltam a configura��o da impressora
    cCmdImprimeLogo      := '';
    cCmdCodeBarEAN8      := '';
    cCmdCodeBarEAN13     := '';
    cCmdCodeBarSTD25     := '';
    cCmdCodeBarINTER25   := '';
    cCmdCodeBarCODE11    := '';
    cCmdCodeBarCODE39    := '';
    cCmdCodeBarCODE93    := '';
    cCmdCodeBarCODE128   := '';
    cCmdCodeBarUPCA      := '';
    cCmdCodeBarCODABAR   := '';
    cCmdCodeBarMSI       := '';
    cCmdCodeBarFim       := NUL;
    nLargPapel           := 64;
  end
  else if MarcaImpressora = iDaruma then
  begin
    cCmdImpZera          := ESC + '@';
    cCmdEspacoLinha      := ESC + '2';
    cCmdPagCod           := ''; // pelo aplicativo da Daruma (Tool) selecione ISO 8859-1 (TODO: tentar implementar essa mudan�a via c�digo)
    cCmdImpNegrito       := ESC + 'E';
    cCmdImpFimNegrito    := ESC + 'F';
    cCmdImpExpandido     := ESC + 'W'#1;
    cCmdImpFimExpandido  := ESC + 'W'#0;
    cCmdFonteNormal      := DC4;
    cCmdFontePequena     := SI;
    cCmdImpSublinhado    := ESC + '-'#1;
    cCmdImpFimSublinhado := ESC + '-'#0;
    cCmdImpItalico       := ESC + '4'#1;
    cCmdImpFimItalico    := ESC + '4'#0;
    cCmdImpCondensado    := ESC + SI + #1;
    cCmdImpFimCondensado := ESC + SI + #0;
    cCmdAlinhadoEsquerda := ESC + 'j'#0;
    cCmdAlinhadoCentro   := ESC + 'j'#1;
    cCmdAlinhadoDireita  := ESC + 'j'#2;
    cCmdCortaPapel       := ESC + 'm';
    cCmdImprimeLogo      := SYN + BS + SYN + TAB;
    cCmdCodeBarEAN8      := ESC + 'b' + chr($02);
    cCmdCodeBarEAN13     := ESC + 'b' + chr($01);
    cCmdCodeBarSTD25     := ESC + 'b' + chr($03);
    cCmdCodeBarINTER25   := ESC + 'b' + chr($04);
    cCmdCodeBarCODE11    := ESC + 'b' + chr($11);
    cCmdCodeBarCODE39    := ESC + 'b' + chr($06);
    cCmdCodeBarCODE93    := ESC + 'b' + chr($07);
    cCmdCodeBarCODE128   := ESC + 'b' + chr($05);
    cCmdCodeBarUPCA      := ESC + 'b' + chr($08);
    cCmdCodeBarCODABAR   := ESC + 'b' + chr($09);
    cCmdCodeBarMSI       := ESC + 'b' + chr($10);
    cCmdCodeBarFim       := NUL;
    nLargPapel           := 57;
  end
  else
  begin
    cCmdImpZera          := ESC + '@';
    cCmdEspacoLinha      := ESC + '3'#14;
    cCmdPagCod           := ESC + 't'#39;
    cCmdImpNegrito       := ESC + 'E1';
    cCmdImpFimNegrito    := ESC + 'E2';
    cCmdImpExpandido     := GS + '!'#16;
    cCmdImpFimExpandido  := GS + '!'#0;
    cCmdFonteNormal      := ESC + 'M0';
    cCmdFontePequena     := ESC + 'M1';
    cCmdImpSublinhado    := ESC + '-'#1;
    cCmdImpFimSublinhado := ESC + '-'#0;
    cCmdImpItalico       := ESC + '4'#1;
    cCmdImpFimItalico    := ESC + '4'#0;
    cCmdImpCondensado    := ESC + SI + #1;
    cCmdImpFimCondensado := ESC + SI + #0;
    cCmdAlinhadoEsquerda := ESC + 'a0';
    cCmdAlinhadoCentro   := ESC + 'a1';
    cCmdAlinhadoDireita  := ESC + 'a2';
    cCmdCortaPapel       := #29'V1';
    cCmdImprimeLogo      := #29'(L'#6#0'0E  '#1#1;
    cCmdCodeBarEAN8      := '';
    cCmdCodeBarEAN13     := '';
    cCmdCodeBarSTD25     := '';
    cCmdCodeBarINTER25   := '';
    cCmdCodeBarCODE11    := '';
    cCmdCodeBarCODE39    := '';
    cCmdCodeBarCODE93    := '';
    cCmdCodeBarCODE128   := '';
    cCmdCodeBarUPCA      := '';
    cCmdCodeBarCODABAR   := '';
    cCmdCodeBarMSI       := '';
    cCmdCodeBarFim       := NUL;
    nLargPapel           := 64;
  end;
end;

function TACBrNFeDANFeESCPOS.GetLinhaSimples: String;
begin
  Result := cCmdAlinhadoEsquerda + cCmdFontePequena + LinhaSimples(nLargPapel);
end;

function TACBrNFeDANFeESCPOS.GetLinhaDupla: String;
begin
  Result := cCmdAlinhadoEsquerda + cCmdFontePequena + LinhaDupla(nLargPapel);
end;

procedure TACBrNFeDANFeESCPOS.PulaLinhas(NumLinhas: Integer);
var
  i: Integer;
begin
  if NumLinhas = 0 then
    NumLinhas := LinhasEntreCupons;

  for i := 0 to NumLinhas do
    FBuffer.Add('');
end;

procedure TACBrNFeDANFeESCPOS.ImprimePorta(AString: AnsiString);
begin
  FDevice.EnviaString(AString);
end;

procedure TACBrNFeDANFeESCPOS.GerarClicheEmpresa;
begin
  InicializarComandos;

  FBuffer.clear;
  FBuffer.Add(cCmdImpZera + cCmdEspacoLinha + cCmdPagCod + cCmdFonteNormal + cCmdAlinhadoCentro + cCmdImprimeLogo);

  FBuffer.Add(cCmdAlinhadoCentro + cCmdImpNegrito + FpNFe.Emit.xNome + cCmdImpFimNegrito);
  FBuffer.Add(cCmdFontePequena + ParseTextESCPOS(QuebraLinhas(
    Trim(FpNFe.Emit.EnderEmit.xLgr) + ', ' +
    Trim(FpNFe.Emit.EnderEmit.nro) + '  ' +
    Trim(FpNFe.Emit.EnderEmit.xCpl) + '  ' +
    Trim(FpNFe.Emit.EnderEmit.xBairro) +  ' ' +
    Trim(FpNFe.Emit.EnderEmit.xMun) + '/' + Trim(FpNFe.Emit.EnderEmit.UF) + '  ' +
    'Cep: ' + DFeUtil.FormatarCEP(IntToStr(FpNFe.Emit.EnderEmit.CEP)) + '  ' +
    'Tel: ' + DFeUtil.FormatarFone(FpNFe.Emit.EnderEmit.fone)
    , nLargPapel)
  ));

  FLinhaCmd := 'CNPJ: ' + DFeUtil.FormatarCNPJ(FpNFe.Emit.CNPJCPF);
  if Trim(FpNFe.Emit.IE) <> '' then
  begin
    FLinhaCMd := padL(FLinhaCmd, Trunc(nLargPapel / 2)) +
    'IE: ' + DFeUtil.FormatarIE(FpNFe.Emit.IE, FpNFe.Emit.EnderEmit.UF);
  end;

  FBuffer.Add(cCmdAlinhadoEsquerda + cCmdImpNegrito + cCmdFontePequena +
    ParseTextESCPOS(FLinhaCmd) + cCmdImpFimNegrito
  );

  if Trim(FpNFe.Emit.IM) <> '' then
  begin
    FBuffer.Add(cCmdAlinhadoEsquerda + cCmdImpNegrito + cCmdFontePequena +
      ParseTextESCPOS('IM: ' + FpNFe.Emit.IM) + cCmdImpFimNegrito
    );
  end;

  FBuffer.Add(GetLinhaSimples);
end;

procedure TACBrNFeDANFeESCPOS.GerarCabecalho;
begin
  GerarClicheEmpresa;

  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoCentro + cCmdImpNegrito +
    ParseTextESCPOS('DANFE NFC-e - Documento Auxiliar')
  );
  FBuffer.Add(ParseTextESCPOS('da Nota Fiscal Eletr�nica para Consumidor Final'));
  FBuffer.Add(ParseTextESCPOS('N�o permite aproveitamento de cr�dito de ICMS') + cCmdImpFimNegrito);
end;

procedure TACBrNFeDANFeESCPOS.GerarItens;
var
  i : integer;
  nTamDescricao: Integer;
  StrDescricao: String;
  VlrLiquido: Double;
begin
  if ImprimeItens then
  begin
    FBuffer.Add(GetLinhaSimples);
    FBuffer.Add(cCmdFonteNormal + ParseTextESCPOS('#|COD|DESCRI��O|QTD|UN|VL UN R$|VL TOTAL R$'));
    FBuffer.Add(GetLinhaSimples);

    for i:=0 to FpNFe.Det.Count - 1 do
    begin
      if ImprimeEmUmaLinha then
      begin
        FLinhaCmd := IntToStrZero(FpNFe.Det.Items[i].Prod.nItem,3) + ' '+
                     Trim(FpNFe.Det.Items[i].Prod.cProd) + ' ' +
                     '[DesProd] ' +
                     DFeUtil.FormatFloat(FpNFe.Det.Items[i].Prod.QCom,DFeUtil.SeSenao(CasasDecimais._Mask_qCom='',NotaUtil.PreparaCasasDecimais(CasasDecimais._qCom),CasasDecimais._Mask_qCom)) + ' ' +
                     Trim(FpNFe.Det.Items[i].Prod.uCom) + ' X ' +
                     DFeUtil.FormatFloat(FpNFe.Det.Items[i].Prod.VUnCom,DFeUtil.SeSenao(CasasDecimais._Mask_vUnCom='',NotaUtil.PreparaCasasDecimais(CasasDecimais._vUnCom),CasasDecimais._Mask_vUnCom)) + ' ' +
                     FormatFloat('#,###,##0.00', FpNFe.Det.Items[i].Prod.vProd);

        nTamDescricao := nLargPapel - Length(FLinhaCmd) + 9;
        StrDescricao := Copy(FpNFe.Det.Items[i].Prod.xProd, 1, nTamDescricao);
        while Length(strDescricao) < nTamDescricao  do
          StrDescricao := StrDescricao + ' ';

        FLinhaCmd := StringReplace(FLinhaCmd, '[DesProd]', StrDescricao, [rfReplaceAll]);
        FLinhaCmd := ParseTextESCPOS(FLinhaCmd);
        FBuffer.Add(cCmdAlinhadoEsquerda + cCmdFontePequena + FLinhaCmd);
      end
      else
      begin
        FLinhaCmd :=
          IntToStrZero(FpNFe.Det.Items[i].Prod.nItem, 3) + ' ' +
          padL(Trim(FpNFe.Det.Items[i].Prod.cProd), 8) + ' ' +
          padL(Trim(FpNFe.Det.Items[i].Prod.xProd), nLargPapel - 13);
        FBuffer.Add(cCmdAlinhadoEsquerda + cCmdFontePequena + FLinhaCmd);

        FLinhaCmd :=
          padL(DFeUtil.FormatFloat(FpNFe.Det.Items[i].Prod.QCom,DFeUtil.SeSenao(CasasDecimais._Mask_qCom='',NotaUtil.PreparaCasasDecimais(CasasDecimais._qCom),CasasDecimais._Mask_qCom)), 15) + ' ' +
          padL(Trim(FpNFe.Det.Items[i].Prod.uCom), 6) + ' X ' +
          padL(DFeUtil.FormatFloat(FpNFe.Det.Items[i].Prod.VUnCom,DFeUtil.SeSenao(CasasDecimais._Mask_vUnCom='',NotaUtil.PreparaCasasDecimais(CasasDecimais._vUnCom),CasasDecimais._Mask_vUnCom)), 13) + '|' +
          DFeUtil.FormatFloat(FpNFe.Det.Items[i].Prod.vProd, '0.00');
        FLinhaCmd := padS(FLinhaCmd, nLargPapel, '|');
        FBuffer.Add(cCmdAlinhadoEsquerda + cCmdFontePequena + FLinhaCmd);
      end;

      if ImprimeDescAcrescItem then
      begin
        // desconto
        if FpNFe.Det.Items[i].Prod.vDesc > 0 then
        begin
          VlrLiquido :=
            (FpNFe.Det.Items[i].Prod.qCom * FpNFe.Det.Items[i].Prod.vUnCom) - FpNFe.Det.Items[i].Prod.vDesc;

          FLinhaCmd := cCmdAlinhadoEsquerda + cCmdFontePequena +
            ParseTextESCPOS(padS(
              'desconto ' + padR(DFeUtil.FormatFloat(FpNFe.Det.Items[i].Prod.vDesc, '-0.00'), 15, ' ')
              + '|' + DFeUtil.FormatFloat(VlrLiquido, '0.00'), nLargPapel, '|')
            );
          FBuffer.Add(cCmdAlinhadoEsquerda + cCmdFontePequena + FLinhaCmd);
        end;

        // ascrescimo
        if FpNFe.Det.Items[i].Prod.vOutro > 0 then
        begin
          VlrLiquido :=
            (FpNFe.Det.Items[i].Prod.qCom * FpNFe.Det.Items[i].Prod.vUnCom) + FpNFe.Det.Items[i].Prod.vOutro;

          FLinhaCmd := cCmdAlinhadoEsquerda + cCmdFontePequena +
            ParseTextESCPOS(padS(
              'acr�scimo ' + padR(DFeUtil.FormatFloat(FpNFe.Det.Items[i].Prod.vOutro, '+0.00'), 15, ' ')
              + '|' + DFeUtil.FormatFloat(VlrLiquido, '0.00'), nLargPapel, '|')
            );
          FBuffer.Add(cCmdAlinhadoEsquerda + cCmdFontePequena + FLinhaCmd);
        end;
      end;
    end;
  end;
end;

procedure TACBrNFeDANFeESCPOS.GerarTotais(Resumido: Boolean);
begin
  FBuffer.Add(GetLinhaSimples);
  FBuffer.Add(cCmdFontePequena + ParseTextESCPOS(padS('QTD. TOTAL DE ITENS|' + IntToStrZero(FpNFe.Det.Count, 3), nLargPapel, '|')));

  if not Resumido then
  begin
    if (FpNFe.Total.ICMSTot.vDesc > 0) or (FpNFe.Total.ICMSTot.vOutro > 0) then
      FBuffer.Add(cCmdFontePequena + ParseTextESCPOS(padS('Subtotal|' + FormatFloat('#,###,##0.00', FpNFe.Total.ICMSTot.vProd), nLargPapel, '|')));

    if FpNFe.Total.ICMSTot.vDesc > 0 then
      FBuffer.Add(cCmdFontePequena + ParseTextESCPOS(padS('Descontos|' + FormatFloat('-#,###,##0.00', FpNFe.Total.ICMSTot.vDesc), nLargPapel, '|')));

    if FpNFe.Total.ICMSTot.vOutro > 0 then
      FBuffer.Add(cCmdFontePequena + ParseTextESCPOS(padS(('Acr�scimos|') + FormatFloat('+#,###,##0.00', FpNFe.Total.ICMSTot.vOutro), nLargPapel, '|')));
  end;

  FLinhaCmd := cCmdAlinhadoEsquerda + cCmdImpExpandido + ParseTextESCPOS(padS('VALOR TOTAL R$|' + FormatFloat('#,###,##0.00', FpNFe.Total.ICMSTot.vNF), nLargPapel div 2, '|')) + cCmdImpFimExpandido;

  FBuffer.Add(FLinhaCmd);
end;

procedure TACBrNFeDANFeESCPOS.GerarPagamentos(Resumido: Boolean = False);
var
  i: Integer;
  Total, Troco: Real;
begin
  Total := 0;
  FBuffer.Add(cCmdFontePequena + ParseTextESCPOS(padS('FORMA DE PAGAMENTO ' + '|' + ' Valor Pago', nLargPapel, '|')));

  for i := 0 to FpNFe.pag.Count - 1 do
  begin
    FBuffer.Add(cCmdFontePequena + ParseTextESCPOS(padS(FormaPagamentoToDescricao(FpNFe.pag.Items[i].tPag) + '|' + FormatFloat('#,###,##0.00', FpNFe.pag.Items[i].vPag), nLargPapel, '|')));
    Total := Total + FpNFe.pag.Items[i].vPag;
  end;

  Troco := Total - FpNFe.Total.ICMSTot.vNF;
  if Troco > 0 then
    FBuffer.Add(cCmdFontePequena + ParseTextESCPOS(padS('Troco R$|' + FormatFloat('#,###,##0.00', Troco), nLargPapel, '|')));

  FBuffer.Add(GetLinhaSimples);
end;

procedure TACBrNFeDANFeESCPOS.GerarTotTrib;
begin
  if FpNFe.Total.ICMSTot.vTotTrib > 0 then
  begin
    FBuffer.Add(cCmdFontePequena + ParseTextESCPOS(padS('Informa��o dos Tributos Totais Incidentes|' +
      FormatFloat('#,###,##0.00', FpNFe.Total.ICMSTot.vTotTrib), nLargPapel, '|'))
    );
    FBuffer.Add(cCmdFontePequena + ParseTextESCPOS('(Lei Federal 12.741/2012)'));
    FBuffer.Add(GetLinhaSimples);
  end;
end;

procedure TACBrNFeDANFeESCPOS.GerarObsCliente;
var
  TextoObservacao: AnsiString;
begin
  TextoObservacao := Trim(FpNFe.InfAdic.infCpl);
  if TextoObservacao <> '' then
  begin
    TextoObservacao := StringReplace(FpNFe.InfAdic.infCpl, ';', sLineBreak, [rfReplaceAll]);
    FBuffer.Add(cCmdFontePequena + ParseTextESCPOS(TextoObservacao));
    FBuffer.Add(GetLinhaSimples);
  end;
end;

procedure TACBrNFeDANFeESCPOS.GerarObsFisco;
begin
  // se homologa��o imprimir o texto de homologa��o
  if FpNFe.ide.tpAmb = taHomologacao then
  begin
    FBuffer.Add(cCmdFontePequena + cCmdAlinhadoCentro + cCmdImpNegrito +
      ParseTextESCPOS('EMITIDA EM AMBIENTE DE HOMOLOGA��O - SEM VALOR FISCAL')
    );
  end;

  // se diferente de normal imprimir a emiss�o em conting�ncia
  if FpNFe.ide.tpEmis <> teNormal then
  begin
    FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoCentro + cCmdImpNegrito +
      ParseTextESCPOS('EMITIDA EM CONTING�NCIA')
    );
  end;

  // dados da nota eletronica de consumidor
  FBuffer.Add(cCmdImpFimNegrito + cCmdFontePequena + cCmdAlinhadoCentro + ParseTextESCPOS(
    'N�mero ' + IntToStrZero(FpNFe.ide.nNF, 9) +
    ' S�rie ' + IntToStrZero(FpNFe.ide.serie, 3) +
    ' Emiss�o ' + DateTimeToStr(FpNFe.ide.dEmi)
  ));

  // via consumidor ou estabelecimento
  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoCentro + IfThen(ViaConsumidor, 'Via Consumidor', 'Via Estabelecimento'));

  // chave de acesso
  FBuffer.Add(cCmdAlinhadoCentro + cCmdFontePequena + ParseTextESCPOS('Consulte pela Chave de Acesso em:'));
  FBuffer.Add(cCmdAlinhadoCentro + cCmdFontePequena + ParseTextESCPOS(NotaUtil.GetURLConsultaNFCe(FpNFe.ide.cUF, FpNFe.ide.tpAmb)));
  FBuffer.Add(cCmdAlinhadoCentro + cCmdFonteNormal  + ParseTextESCPOS('CHAVE DE ACESSO'));
  FBuffer.Add(cCmdAlinhadoCentro + cCmdFontePequena + DFeUtil.FormatarChaveAcesso(OnlyNumber(FpNFe.infNFe.ID)) + cCmdFonteNormal);
  FBuffer.Add(GetLinhaSimples);
end;

procedure TACBrNFeDANFeESCPOS.GerarDadosConsumidor;
begin
  FLinhaCmd := cCmdFonteNormal + cCmdAlinhadoCentro + cCmdImpNegrito +
    ParseTextESCPOS('CONSUMIDOR') + cCmdImpFimNegrito;
  FBuffer.Add(FLinhaCmd);

  if (FpNFe.Dest.idEstrangeiro = '') and (FpNFe.Dest.CNPJCPF = '') then
  begin
    FBuffer.Add(ParseTextESCPOS('CONSUMIDOR N�O IDENTIFICADO'));
  end
  else
  begin
    if FpNFe.Dest.idEstrangeiro <> '' then
      FLinhaCmd := 'ID Estrangeiro: ' + FpNFe.Dest.idEstrangeiro
    else
    begin
      if Length(Trim(FpNFe.Dest.CNPJCPF)) > 11 then
        FLinhaCmd := 'CNPJ: ' + DFeUtil.FormatarCNPJ(FpNFe.Dest.CNPJCPF)
      else
        FLinhaCmd := 'CPF: ' + DFeUtil.FormatarCPF(FpNFe.Dest.CNPJCPF);
    end;
    FBuffer.Add(ParseTextESCPOS(FLinhaCmd));

    FLinhaCmd := Trim(FpNFe.Dest.xNome);
    if FLinhaCmd <> '' then
      FBuffer.Add(ParseTextESCPOS(FLinhaCmd));

    FLinhaCmd := Trim(
      Trim(FpNFe.Dest.EnderDest.xLgr) + ' ' +
      Trim(FpNFe.Dest.EnderDest.nro) + ' ' +
      Trim(FpNFe.Dest.EnderDest.xCpl) + ' ' +
      Trim(FpNFe.Dest.EnderDest.xBairro) + ' ' +
      Trim(FpNFe.Dest.EnderDest.xMun) + ' ' +
      Trim(FpNFe.Dest.EnderDest.UF)
    );
    if FLinhaCmd <> '' then
      FBuffer.Add(cCmdFontePequena + ParseTextESCPOS(FLinhaCmd));
  end;
end;

procedure TACBrNFeDANFeESCPOS.GerarRodape(CortaPapel: Boolean = True; Cancelamento: Boolean = False);
var
  qrcode: string;
  cCaracter: String;
  i, cTam1, cTam2: Integer;
  bMenos, bMais, iQtdBytes, iLargMod, iNivelCorrecao: Integer;
begin
  FBuffer.Add(GetLinhaSimples);
  FBuffer.Add(cCmdAlinhadoCentro + ParseTextESCPOS('Consulta via leitor de QR Code'));
  FBuffer.Add(' ');

  qrcode := NotaUtil.GetURLQRCode(
    FpNFe.ide.cUF,
    FpNFe.ide.tpAmb,
    FpNFe.infNFe.ID,
    DFeUtil.SeSenao(FpNFe.Dest.idEstrangeiro <> '', FpNFe.Dest.idEstrangeiro, FpNFe.Dest.CNPJCPF),
    FpNFe.ide.dEmi,
    FpNFe.Total.ICMSTot.vNF,
    FpNFe.Total.ICMSTot.vICMS,
    FpNFe.signature.DigestValue, TACBrNFe(ACBrNFe).Configuracoes.Geral.IdToken,
    TACBrNFe(ACBrNFe).Configuracoes.Geral.Token
  );

  if MarcaImpressora = iBematech then
  begin
    for i := 1 to Length(qrcode) do
      cCaracter := cCaracter + chr(Ord(qrcode[i]));

    if (Length(qrcode) > 255) then
    begin
      cTam1 := Length(qrcode) mod 255;
      cTam2 := Length(qrcode) div 255;
    end
    else
    begin
      cTam1 := Length(qrcode);
      cTam2 := 0;
    end;

    FLinhaCmd := chr(27) + chr(97) + chr(1) + chr(29) + chr(107) + chr(81) +
                 chr(3) + chr(8) + chr(8) + chr(1) + chr(cTam1) + chr(cTam2) + cCaracter;
  end
  else if MarcaImpressora = iDaruma then
  begin
    iQtdBytes      := Length(qrcode);
    iLargMod       := 3;
    bMenos         := iQtdBytes shr 8;
    bMais          := iQtdBytes AND 255 + 2;
    iNivelCorrecao := (Ord('M'));

    FLinhaCmd := #27#129 + chr(bMais) + chr(bMenos) + chr(iLargMod) + chr(iNivelCorrecao) + qrcode;
  end
  else
  begin
    FLinhaCmd := chr(29) + '(k' + chr(4) + chr(0) + '1A2' + chr(0) + chr(29) +
                 '(k' + chr(3) + chr(0) + '1C' + chr(4) + chr(29) +
                 '(k' + chr(3) + chr(0) + '1E0' + chr(29) +
                 '(k' + Int2TB(Length(qrcode) + 3) + '1P0' + qrcode + chr(29) +
                 '(k' + chr(3) + chr(0) + '1Q0';
  end;

  // impress�o do qrcode
  FBuffer.Add(FLinhaCmd);

  // protocolo de autoriza��o
  FBuffer.Add(cCmdFontePequena + ParseTextESCPOS('Protocolo de Autoriza��o'));
  FBuffer.Add(cCmdFontePequena + ParseTextESCPOS(Trim(FpNFe.procNFe.nProt) + ' ' + DFeUtil.SeSenao(FpNFe.procNFe.dhRecbto <> 0, DateTimeToStr(FpNFe.procNFe.dhRecbto), '')) + cCmdFonteNormal);
  FBuffer.Add(GetLinhaSimples);

  // sistema
  FBuffer.Add(cCmdFontePequena + cCmdAlinhadoCentro + Sistema);
  FBuffer.Add(cCmdFontePequena + cCmdAlinhadoCentro + Site);

  // pular linhas e cortar o papel
  PulaLinhas;
  if CortaPapel then
    FBuffer.Add(cCmdCortaPapel);
end;

procedure TACBrNFeDANFeESCPOS.MontarEnviarDANFE(NFE: TNFe;
  const AResumido: Boolean);
begin
  if NFE = nil then
  begin
    if not Assigned(ACBrNFe) then
      raise Exception.Create(ACBrStr('Componente ACBrNFe n�o atribu�do'));

    FpNFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFE;
  end
  else
    FpNFe := NFE;

  GerarCabecalho;
  GerarItens;
  GerarTotais(AResumido);
  GerarPagamentos(AResumido);
  GerarTotTrib;
  GerarObsCliente;
  GerarObsFisco;
  GerarDadosConsumidor;
  GerarRodape;

  ImprimePorta(FBuffer.Text);
end;

procedure TACBrNFeDANFeESCPOS.ImprimirDANFE(NFE: TNFe);
begin
  MontarEnviarDANFE(NFE, False);
end;

procedure TACBrNFeDANFeESCPOS.ImprimirDANFEResumido(NFE: TNFe);
var
  OldImprimeItens: Boolean;
begin
  OldImprimeItens := ImprimeItens;
  try
    ImprimeItens := False;
    MontarEnviarDANFE(NFE, True);
  finally
    ImprimeItens := OldImprimeItens;
  end;
end;

procedure TACBrNFeDANFeESCPOS.GerarDadosEvento;
const
  TAMCOLDESCR = 11;
begin
  // dados da nota eletr�nica
  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoCentro + cCmdImpNegrito +
    ParseTextESCPOS('Nota Fiscal para Consumidor Final') + cCmdImpFimNegrito
  );
  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoCentro + cCmdImpNegrito +
    ParseTextESCPOS('N�mero: ' + IntToStrZero(FpNFe.ide.nNF, 9) + ' S�rie: ' + IntToStrZero(FpNFe.ide.serie, 3)) +
    cCmdImpFimNegrito
  );
  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoCentro + cCmdImpNegrito +
    ParseTextESCPOS('Emiss�o: ' + DateTimeToStr(FpNFe.ide.dEmi)) + cCmdImpFimNegrito
  );
  FBuffer.Add(' ');
  FBuffer.Add(cCmdAlinhadoCentro + cCmdFontePequena +
    ParseTextESCPOS('CHAVE ACESSO')
  );
  FBuffer.Add(cCmdAlinhadoCentro + cCmdFontePequena +
    ParseTextESCPOS(DFeUtil.FormatarChaveAcesso(OnlyNumber(FpNFe.infNFe.ID)))
  );
  FBuffer.Add(GetLinhaSimples);

  // dados do evento
  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoCentro + cCmdImpNegrito +
    ParseTextESCPOS('EVENTO') + cCmdImpFimNegrito
  );
  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoEsquerda + ParseTextESCPOS(
    padL('Evento:', TAMCOLDESCR) + FpEvento.Evento[0].InfEvento.TipoEvento
  ));
  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoEsquerda + ParseTextESCPOS(
    padL('Descri��o:', TAMCOLDESCR) + FpEvento.Evento[0].InfEvento.DescEvento
  ));
  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoEsquerda + ParseTextESCPOS(
    padL('Org�o:', TAMCOLDESCR) + IntToStr(FpEvento.Evento[0].InfEvento.cOrgao)
  ));
  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoEsquerda + ParseTextESCPOS(
    padL('Ambiente:', TAMCOLDESCR) + IfThen(FpEvento.Evento[0].InfEvento.tpAmb = taProducao, 'PRODUCAO', 'HOMOLOGA��O - SEM VALOR FISCAL')
  ));
  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoEsquerda + ParseTextESCPOS(
    padL('Emiss�o:', TAMCOLDESCR) + DateTimeToStr(FpEvento.Evento[0].InfEvento.dhEvento)
  ));
  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoEsquerda + ParseTextESCPOS(
    padL('Sequencia:', TAMCOLDESCR) + IntToStr(FpEvento.Evento[0].InfEvento.nSeqEvento)
  ));
  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoEsquerda + ParseTextESCPOS(
    padL('Vers�o:', TAMCOLDESCR) + FpEvento.Evento[0].InfEvento.versaoEvento
  ));
  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoEsquerda + ParseTextESCPOS(
    padL('Status:', TAMCOLDESCR) + FpEvento.Evento[0].RetInfEvento.xMotivo
  ));
  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoEsquerda + ParseTextESCPOS(
    padL('Protocolo:', TAMCOLDESCR) + FpEvento.Evento[0].RetInfEvento.nProt
  ));
  FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoEsquerda + ParseTextESCPOS(
    padL('Registro:', TAMCOLDESCR) + DateTimeToStr(FpEvento.Evento[0].RetInfEvento.dhRegEvento)
  ));

  FBuffer.Add(GetLinhaSimples);
end;


procedure TACBrNFeDANFeESCPOS.GerarObservacoesEvento;
begin
  if FpEvento.Evento[0].InfEvento.detEvento.xJust <> '' then
  begin
    FBuffer.Add(GetLinhaSimples);
    FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoCentro + cCmdImpNegrito +
      ParseTextESCPOS('JUSTIFICATIVA') + cCmdImpFimNegrito
    );
    FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoEsquerda + ParseTextESCPOS(
      FpEvento.Evento[0].InfEvento.detEvento.xJust
    ));
  end
  else if FpEvento.Evento[0].InfEvento.detEvento.xCorrecao <> '' then
  begin
    FBuffer.Add(GetLinhaSimples);
    FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoCentro + cCmdImpNegrito +
      ParseTextESCPOS('CORRECAO') + cCmdImpFimNegrito
    );
    FBuffer.Add(cCmdFonteNormal + cCmdAlinhadoEsquerda + ParseTextESCPOS(
      FpEvento.Evento[0].InfEvento.detEvento.xCorrecao
    ));
  end;
end;

procedure TACBrNFeDANFeESCPOS.ImprimirEVENTO(NFE: TNFe);
begin
  if NFE = nil then
  begin
    if not Assigned(ACBrNFe) then
      raise Exception.Create(ACBrStr('Componente ACBrNFe n�o atribu�do'));

    FpNFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFE;
  end
  else
    FpNFe := NFE;

  FpEvento := TACBrNFe(ACBrNFe).EventoNFe;
  if not Assigned(FpEvento) then
    raise Exception.Create('Evento n�o foi assinalado!');


  GerarClicheEmpresa;
  GerarDadosEvento;
  GerarDadosConsumidor;
  GerarObservacoesEvento;
  GerarRodape;

  ImprimePorta(FBuffer.Text);
end;

procedure TACBrNFeDANFeESCPOS.ImprimirRelatorio(const ATexto: TStrings;
  const AVias: Integer; const ACortaPapel: Boolean);
var
  I: Integer;
begin
  InicializarComandos;

  FBuffer.clear;
  FBuffer.Add(cCmdImpZera + cCmdEspacoLinha + cCmdPagCod + cCmdFonteNormal + cCmdAlinhadoCentro + cCmdImprimeLogo);
  FBuffer.Add(cCmdAlinhadoEsquerda);
  for I := 0 to AVias - 1 do
  begin
    FBuffer.Add(ParseTextESCPOS(DecodificarTagsFormatacao(ATexto.Text)));
    PulaLinhas(LinhasEntreCupons);
  end;

  ImprimePorta(FBuffer.Text);
  if ACortaPapel then
    CortarPapel;
end;

procedure TACBrNFeDANFeESCPOS.CortarPapel;
begin
  InicializarComandos;
  ImprimePorta(cCmdImpZera + cCmdEspacoLinha + cCmdPagCod + cCmdFonteNormal + cCmdCortaPapel);
end;

{$IFDEF FPC}
initialization
{$I ACBrNFeDANFeESCPOS.lrs}
{$ENDIF}

end.
