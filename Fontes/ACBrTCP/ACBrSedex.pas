{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2014 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{ Esse arquivo usa a classe  SynaSer   Copyright (c)2001-2003, Lukas Gebauer   }
{  Project : Ararat Synapse     (Found at URL: http://www.ararat.cz/synapse/)  }
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
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }

{******************************************************************************}
{******************************************************************************
|* Historico
|* Doa��o por "datilas" no link
|* http://www.projetoacbr.com.br/forum/index.php?/topic/17388-correios-calculo-de-sedex-pac/
******************************************************************************}

{$I ACBr.inc}

unit ACBrSedex;

interface

uses
 Classes, SysUtils, contnrs, ACBrSocket, ACBrUtil;

type
 TACBrTpServico = (Tps41106PAC, Tps40010SEDEX, Tps40215SEDEX10, Tps40290SEDEXHOJE, Tps81019eSEDEX, Tps44105MALOTE,
 Tps85480AEROGRAMA, Tps10030CARTASIMPLES, Tps10014CARTAREGISTRADA, Tps16012CARTAOPOSTAL, Tps20010IMPRESSO, Tps14010MALADIRETA,
 Tps40010SEDEXVarejo, Tps40045SEDEXaCobrarVarejo, Tps40215SEDEX10Varejo, Tps40290SEDEXHojeVarejo, Tps41106PACVarejo);

 TACBrTpFormato = (TpfCaixaPacote, TpfRoloPrisma, TpfEnvelope);

 TACBrMaoPropria = (mpSim, mpNao);

 TACBrAvisoRecebimento = (arSim, arNao);

 EACBrSedexException = class(Exception);

  TACBrSedex = class(TACBrHTTP)

  private
   fsCodContrato: string;
   fsDsSenha: string;
   fsCepOrigem: string;
   fsCepDestino: string;
   fnVlPeso: Double;
   fnCdFormato: TACBrTpFormato;
   fnVlComprimento: Double;
   fnVlAltura: Double;
   fnVlLargura: Double;
   fsCdMaoPropria: TACBrMaoPropria;
   fnVlValorDeclarado: Double;
   fsCdAvisoRecebimento: TACBrAvisoRecebimento;
   fnCdServico: TACBrTpServico;
   fnVlDiametro: Double;
   fUrlConsulta: string;

   fCodigoServico: String;
   fValor: Double;
   fPrazoEntrega: Integer;
   fValorSemAdicionais: Double;
   fValorMaoPropria: Double;
   fValorAvisoRecebimento: Double;
   fValorValorDeclarado: Double;
   fEntregaDomiciliar: String;
   fEntregaSabado: String;
   fErro: Integer;
   fMsgErro: String;

   procedure SetTpServico(const AValue: TACBrTpServico);
   procedure SetTpFormato(const AValue: TACBrTpFormato);
   procedure SetMaoPropria(const AValue: TACBrMaoPropria);
   procedure SetAvisoRecebimento(const AValue: TACBrAvisoRecebimento);

  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
   function Consultar: Boolean;
   property retCodigoServico: string read fCodigoServico write fCodigoServico;
   property retValor: Double read fValor write fValor;
   property retPrazoEntrega: Integer read fPrazoEntrega write fPrazoEntrega;
   property retValorSemAdicionais: Double read fValorSemAdicionais write fValorSemAdicionais;
   property retValorMaoPropria: Double read fValorMaoPropria write fValorMaoPropria;
   property retValorAvisoRecebimento: Double read fValorAvisoRecebimento write fValorAvisoRecebimento;
   property retValorValorDeclarado: Double read fValorValorDeclarado write fValorValorDeclarado;
   property retEntregaDomiciliar: String read fEntregaDomiciliar write fEntregaDomiciliar;
   property retEntregaSabado: String read fEntregaSabado write fEntregaSabado;
   property retErro: Integer read fErro write fErro;
   property retMsgErro: String read fMsgErro write fMsgErro;

  published
   property CodContrato: string read fsCodContrato write fsCodContrato;
   property Senha: string read fsDsSenha write fsDsSenha;
   property CepOrigem: string read fsCepOrigem write fsCepOrigem;
   property CepDestino: string read fsCepDestino write fsCepDestino;
   property Peso: Double read fnVlPeso write fnVlPeso;
   property Formato: TACBrTpFormato read fnCdFormato write fnCdFormato;
   property Comprimento: Double read fnVlComprimento write fnVlComprimento;
   property Altura: Double read fnVlAltura write fnVlAltura;
   property Largura: Double read fnVlLargura write fnVlLargura;
   property MaoPropria: TACBrMaoPropria read fsCdMaoPropria write fsCdMaoPropria;
   property ValorDeclarado: Double read fnVlValorDeclarado write fnVlValorDeclarado;
   property AvisoRecebimento: TACBrAvisoRecebimento read fsCdAvisoRecebimento write fsCdAvisoRecebimento;
   property Servico: TACBrTpServico read fnCdServico write fnCdServico;
   property Diametro: Double read fnVlDiametro write fnVlDiametro;
   property UrlConsulta: string read fUrlConsulta write fUrlConsulta;
  end;


implementation

constructor TACBrSedex.Create(AOwner: TComponent);
begin
  inherited;
  fsCodContrato := '';
  fsDsSenha := '';
  fsCepOrigem := '';
  fsCepDestino := '';
  fnVlPeso := 0;
  fnCdFormato := TpfCaixaPacote;
  fnVlComprimento := 0;
  fnVlAltura := 0;
  fnVlLargura := 0;
  fsCdMaoPropria := mpNao;
  fnVlValorDeclarado := 0;
  fsCdAvisoRecebimento := arNao;
  fnCdServico := Tps41106PAC;
  fUrlConsulta := 'http://ws.correios.com.br/calculador/CalcPrecoPrazo.aspx?';

  fCodigoServico := '';
  fValor := 0;
  fPrazoEntrega := 0;
  fValorSemAdicionais := 0;
  fValorMaoPropria := 0;
  fValorAvisoRecebimento := 0;
  fValorValorDeclarado := 0;
  fEntregaDomiciliar := '';
  fEntregaSabado := '';
  fErro := 0;
  fMsgErro := '';
end;

destructor TACBrSedex.Destroy;
begin
  inherited Destroy;
end;

procedure TACBrSedex.SetTpServico(const AValue: TACBrTpServico);
begin
  if fnCdServico = AValue then
    exit;
  fnCdServico := AValue;
end;

procedure TACBrSedex.SetTpFormato(const AValue: TACBrTpFormato);
begin
  if fnCdFormato = AValue then
    exit;
  fnCdFormato := AValue;
end;

procedure TACBrSedex.SetMaoPropria(const AValue: TACBrMaoPropria);
begin
  if fsCdMaoPropria = AValue then
    exit;
  fsCdMaoPropria := AValue;
end;

procedure TACBrSedex.SetAvisoRecebimento(const AValue: TACBrAvisoRecebimento);
begin
  if fsCdAvisoRecebimento = AValue then
    exit;
  fsCdAvisoRecebimento := AValue;
end;

function TACBrSedex.Consultar: Boolean;
var
  TpServico, TpFormato, TpMaoPropria, TpAvisoRecebimento,
  Buffer: string;
begin
Result := False;
 if fnCdServico = Tps41106PAC then
  TpServico := '41106'
 else if fnCdServico = Tps40010SEDEX then
  TpServico := '40010'
 else if fnCdServico = Tps40215SEDEX10 then
  TpServico := '40215'
  else if fnCdServico = Tps40290SEDEXHOJE then
  TpServico := '40290'
 else if fnCdServico = Tps81019eSEDEX then
  TpServico := '81019'
 else if fnCdServico = Tps44105MALOTE then
  TpServico := '44105'
 else if fnCdServico = Tps85480AEROGRAMA then
  TpServico := '85480'
 else if fnCdServico = Tps10030CARTASIMPLES then
  TpServico := '10030'
 else if fnCdServico = Tps10014CARTAREGISTRADA then
  TpServico := '10014'
 else if fnCdServico = Tps16012CARTAOPOSTAL then
  TpServico := '16012'
 else if fnCdServico = Tps20010IMPRESSO then
  TpServico := '20010'
 else if fnCdServico = Tps14010MALADIRETA then
  TpServico := '14010'
 else if fnCdServico = Tps40010SEDEXVarejo then
    TpServico := '40010'
 else if fnCdServico = Tps40045SEDEXaCobrarVarejo then
  TpServico := '40045'
 else if fnCdServico = Tps40215SEDEX10Varejo then
  TpServico := '40215'
 else if fnCdServico = Tps40290SEDEXHojeVarejo then
  TpServico := '40290'
 else if fnCdServico = Tps41106PACVarejo then
  TpServico := '41106'
 Else raise EACBrSedexException.Create('Tipo de Servi�o Invalido');

 if fnCdFormato = TpfCaixaPacote then
  TpFormato := '1'
 Else if fnCdFormato = TpfRoloPrisma then
 TpFormato := '2'
 Else if fnCdFormato = TpfEnvelope then
 TpFormato := '3'
 Else raise EACBrSedexException.Create('Formato da Embalagem Inavlido');

 if fsCdMaoPropria = mpSim then
 TpMaoPropria := 'S'
 Else if fsCdMaoPropria = mpNao then
 TpMaoPropria := 'N'
 Else raise EACBrSedexException.Create('Mao Propria Invalida');

 if fsCdAvisoRecebimento = arSim then
 TpAvisoRecebimento := 'S'
 Else if fsCdAvisoRecebimento = arNao then
 TpAvisoRecebimento := 'N'
 Else raise EACBrSedexException.Create('Aviso de Recebimento Invalido');

 try
  Self.HTTPGet(fUrlConsulta+
   'nCdEmpresa='+fsCodContrato+
   '&sDsSenha='+fsDsSenha+
   '&sCepOrigem='+OnlyNumber(fsCepOrigem)+
   '&sCepDestino='+OnlyNumber(fsCepDestino)+
   '&nVlPeso='+FormatFloat('#,000',fnVlPeso)+
   '&nCdFormato='+TpFormato+
   '&nVlComprimento='+FormatFloat('#,000',fnVlComprimento)+
   '&nVlAltura='+FormatFloat('#,000',fnVlAltura)+
   '&nVlLargura='+FormatFloat('#,000',fnVlLargura)+
   '&sCdMaoPropria='+TpMaoPropria+
   '&nVlValorDeclarado='+FormatFloat('#0,00',fnVlValorDeclarado)+
   '&sCdAvisoRecebimento='+TpAvisoRecebimento+
   '&nCdServico='+TpServico+
   '&nVlDiametro='+FormatFloat('#,000',fnVlDiametro)+
   '&StrRetorno=xml');
 except
  on E: Exception do
   begin
    raise EACBrSedexException.Create('Erro ao consultar Sedex' + #13#10 + E.Message);
   end;
 end;

 Buffer := Self.RespHTTP.Text;

 retCodigoServico := LerTagXml(Buffer,'Codigo',True);
 retvalor := StrToFloat(LerTagXml(Buffer,'Valor',True));
 retPrazoEntrega := StrToInt(LerTagXml(Buffer,'PrazoEntrega',True));
 retValorSemAdicionais := StrToFloat(LerTagXml(Buffer,'ValorSemAdicionais',True));
 retValorMaoPropria := StrToFloat(LerTagXml(Buffer,'ValorMaoPropria',True));
 retValorAvisoRecebimento := StrToFloat(LerTagXml(Buffer,'ValorAvisoRecebimento',True));
 retValorValorDeclarado := StrToFloat(LerTagXml(Buffer,'ValorValorDeclarado',True));;
 retEntregaDomiciliar := LerTagXml(Buffer,'EntregaDomiciliar',True);
 retEntregaSabado := LerTagXml(Buffer,'EntregaSabado',True);
 retErro := StrToInt(LerTagXml(Buffer,'Erro',True));
 retMsgErro := LerTagXml(Buffer,'MsgErro',True);
 retMsgErro := StringReplace(retMsgErro,'<![CDATA[','',[rfReplaceAll]);
 retMsgErro := StringReplace(retMsgErro,']]>','',[rfReplaceAll]);



 if retErro = 0 then
 Result := True;
end;
//C�digo de erro Mensagem de erro
//0 Processamento com sucesso
//-1 C�digo de servi�o inv�lido
//-2 CEP de origem inv�lido
//-3 CEP de destino inv�lido
//-4 Peso excedido
//-5 O Valor Declarado n�o deve exceder R$ 10.000,00
//-6 Servi�o indispon�vel para o trecho informado
//-7 O Valor Declarado � obrigat�rio para este servi�o
//-8 Este servi�o n�o aceita M�o Pr�pria
//-9 Este servi�o n�o aceita Aviso de Recebimento
//-10 Precifica��o indispon�vel para o trecho informado
//-11 Para defini��o do pre�o dever�o ser informados, tamb�m, o comprimento, a largura e altura do objeto em cent�metros (cm).
//-12 Comprimento inv�lido.
//-13 Largura inv�lida.
//-14 Altura inv�lida.
//-15 O comprimento n�o pode ser maior que 105 cm.
//-16 A largura n�o pode ser maior que 105 cm.
//-17 A altura n�o pode ser maior que 105 cm.
//-18 A altura n�o pode ser inferior a 2 cm.
//-20 A largura n�o pode ser inferior a 11 cm.
//-22 O comprimento n�o pode ser inferior a 16 cm.
//-23 A soma resultante do comprimento + largura + altura n�o deve superar a 200 cm.
//-24 Comprimento inv�lido.
//-25 Di�metro inv�lido
//-26 Informe o comprimento.
//-27 Informe o di�metro.
//-28 O comprimento n�o pode ser maior que 105 cm.
//-29 O di�metro n�o pode ser maior que 91 cm.
//-30 O comprimento n�o pode ser inferior a 18 cm.
//-31 O di�metro n�o pode ser inferior a 5 cm.
//-32 A soma resultante do comprimento + o dobro do di�metro n�o deve superar a 200 cm.
//-33 Sistema temporariamente fora do ar. Favor tentar mais tarde.
//-34 C�digo Administrativo ou Senha inv�lidos.
//-35 Senha incorreta.
//-36 Cliente n�o possui contrato vigente com os Correios.
//-37 Cliente n�o possui servi�o ativo em seu contrato.
//-38 Servi�o indispon�vel para este c�digo administrativo.
//-39 Peso excedido para o formato envelope
//-40 Para definicao do preco deverao ser informados, tambem, o comprimento e a largura e altura do objeto em centimetros (cm).
//-41 O comprimento nao pode ser maior que 60 cm.
//-42 O comprimento nao pode ser inferior a 16 cm.
//-43 A soma resultante do comprimento + largura nao deve superar a 120 cm.
//-44 A largura nao pode ser inferior a 11 cm.
//-45 A largura nao pode ser maior que 60 cm.
//-888 Erro ao calcular a tarifa
//006 Localidade de origem n�o abrange o servi�o informado
//007 Localidade de destino n�o abrange o servi�o informado
//008 Servi�o indispon�vel para o trecho informado
//009 CEP inicial pertencente a �rea de Risco.
//010 CEP final pertencente a �rea de Risco. A entrega ser� realizada, temporariamente, na ag�ncia mais pr�xima do endere�o do destinat�rio.
//011 CEP inicial e final pertencentes a �rea de Risco
//7 Servi�o indispon�vel, tente mais tarde
//99 Outros erros diversos do .Net
end.
