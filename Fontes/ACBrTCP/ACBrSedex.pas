{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2014 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{ Esse arquivo usa a classe  SynaSer   Copyright (c)2001-2003, Lukas Gebauer   }
{  Project : Ararat Synapse     (Found at URL: http://www.ararat.cz/synapse/)  }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }

{******************************************************************************}
{******************************************************************************
|* Historico
|* Doação por "datilas" no link
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

  TACBrRastreio = class
  private
    fDataHora: TDateTime;
    fLocal: string;
    fSituacao: string;
    fObservacao:String;

  public
    property DataHora: TDateTime read fDataHora write fDataHora;
    property Local: string read fLocal write fLocal;
    property Situacao: string read fSituacao write fSituacao;
    property Observacao: string read fObservacao write fObservacao;
  end;

  TACBrRastreioClass = class(TObjectList)
  protected
    procedure SetObject(Index: integer; Item: TACBrRastreio);
    function GetObject(Index: integer): TACBrRastreio;
  public
    function Add(Obj: TACBrRastreio): integer;
    function New: TACBrRastreio;
    property Objects[Index: integer]: TACBrRastreio read GetObject write SetObject; default;
  end;

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

   fRastreio : TACBrRastreioClass;

   procedure SetTpServico(const AValue: TACBrTpServico);
   procedure SetTpFormato(const AValue: TACBrTpFormato);
   procedure SetMaoPropria(const AValue: TACBrMaoPropria);
   procedure SetAvisoRecebimento(const AValue: TACBrAvisoRecebimento);

  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
   function Consultar: Boolean;
   Procedure Rastrear(Const CodRastreio:String);
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
   property Rastreio: TACBrRastreioClass read fRastreio write fRastreio;

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
  fRastreio := TACBrRastreioClass.Create;
  fRastreio.Clear;
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

procedure TACBrRastreioClass.SetObject(Index: integer; Item: TACBrRastreio);
begin
  inherited SetItem(Index, Item);
end;

function TACBrRastreioClass.GetObject(Index: integer): TACBrRastreio;
begin
  Result := inherited GetItem(Index) as TACBrRastreio;
end;

function TACBrRastreioClass.New: TACBrRastreio;
begin
  Result := TACBrRastreio.Create;
  Add(Result);
end;

function TACBrRastreioClass.Add(Obj: TACBrRastreio): integer;
begin
  Result := inherited Add(Obj);
end;


destructor TACBrSedex.Destroy;
begin
 fRastreio.Free;
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
 Else raise EACBrSedexException.Create('Tipo de Serviço Invalido');

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
//Código de erro Mensagem de erro
//0 Processamento com sucesso
//-1 Código de serviço inválido
//-2 CEP de origem inválido
//-3 CEP de destino inválido
//-4 Peso excedido
//-5 O Valor Declarado não deve exceder R$ 10.000,00
//-6 Serviço indisponível para o trecho informado
//-7 O Valor Declarado é obrigatório para este serviço
//-8 Este serviço não aceita Mão Própria
//-9 Este serviço não aceita Aviso de Recebimento
//-10 Precificação indisponível para o trecho informado
//-11 Para definição do preço deverão ser informados, também, o comprimento, a largura e altura do objeto em centímetros (cm).
//-12 Comprimento inválido.
//-13 Largura inválida.
//-14 Altura inválida.
//-15 O comprimento não pode ser maior que 105 cm.
//-16 A largura não pode ser maior que 105 cm.
//-17 A altura não pode ser maior que 105 cm.
//-18 A altura não pode ser inferior a 2 cm.
//-20 A largura não pode ser inferior a 11 cm.
//-22 O comprimento não pode ser inferior a 16 cm.
//-23 A soma resultante do comprimento + largura + altura não deve superar a 200 cm.
//-24 Comprimento inválido.
//-25 Diâmetro inválido
//-26 Informe o comprimento.
//-27 Informe o diâmetro.
//-28 O comprimento não pode ser maior que 105 cm.
//-29 O diâmetro não pode ser maior que 91 cm.
//-30 O comprimento não pode ser inferior a 18 cm.
//-31 O diâmetro não pode ser inferior a 5 cm.
//-32 A soma resultante do comprimento + o dobro do diâmetro não deve superar a 200 cm.
//-33 Sistema temporariamente fora do ar. Favor tentar mais tarde.
//-34 Código Administrativo ou Senha inválidos.
//-35 Senha incorreta.
//-36 Cliente não possui contrato vigente com os Correios.
//-37 Cliente não possui serviço ativo em seu contrato.
//-38 Serviço indisponível para este código administrativo.
//-39 Peso excedido para o formato envelope
//-40 Para definicao do preco deverao ser informados, tambem, o comprimento e a largura e altura do objeto em centimetros (cm).
//-41 O comprimento nao pode ser maior que 60 cm.
//-42 O comprimento nao pode ser inferior a 16 cm.
//-43 A soma resultante do comprimento + largura nao deve superar a 120 cm.
//-44 A largura nao pode ser inferior a 11 cm.
//-45 A largura nao pode ser maior que 60 cm.
//-888 Erro ao calcular a tarifa
//006 Localidade de origem não abrange o serviço informado
//007 Localidade de destino não abrange o serviço informado
//008 Serviço indisponível para o trecho informado
//009 CEP inicial pertencente a Área de Risco.
//010 CEP final pertencente a Área de Risco. A entrega será realizada, temporariamente, na agência mais próxima do endereço do destinatário.
//011 CEP inicial e final pertencentes a Área de Risco
//7 Serviço indisponível, tente mais tarde
//99 Outros erros diversos do .Net
Procedure TACBrSedex.Rastrear(const CodRastreio: String);
Var
 sl1: TStringList;
 i,cont:Integer;
 vobs:String;

  function CopyDeAte(Texto, TextIni, TextFim: string): string;
  var
    ContIni, ContFim: integer;
  begin
    Result := '';
    if (Pos(TextFim, Texto) <> 0) and (Pos(TextIni, Texto) <> 0) then
    begin
      ContIni := Pos(TextIni, Texto) + Length(TextIni);
      ContFim := Pos(TextFim, Texto);
      Result := Copy(Texto, ContIni, ContFim - ContIni);
    end;
  end;
begin
 If Length(CodRastreio) <> 13 Then
  raise EACBrSedexException.Create('Código de rastreamento deve conter 13 caracteres');

 try
  Self.HTTPGet('http://websro.correios.com.br/sro_bin/txect01$.QueryList?P_LINGUA=001&P_TIPO=001&P_COD_UNI='+CodRastreio);
 except
  on E: Exception do
   begin
    raise EACBrSedexException.Create('Erro ao Rastrear' + #13#10 + E.Message);
   end;
 end;

 if Pos('O nosso sistema não possui dados sobre o objeto',Self.RespHTTP.Text) > 0 Then
 raise EACBrSedexException.Create('O nosso sistema não possui dados sobre o objeto' + #13#10 +
 'informado. Se o objeto foi postado recentemente, é natural que seus rastros não tenham ingressado no sistema,' + #13#10 +
 'nesse caso, por favor, tente novamente mais tarde. Adicionalmente,' + #13#10 +
 'verifique se o código digitado está correto: '+CodRastreio);

 Try
 sl1 := TStringList.Create;
 sl1.Text := Self.RespHTTP.Text;
 cont := sl1.Count -1;

  For i := cont DownTo 0 Do
  Begin
   If Pos('colspan',sl1[i]) > 0 Then
    Begin
    vObs := CopyDeAte(sl1[i],'colspan=2>','</td></tr>');
    end
   Else
   If Pos('rowspan',sl1[i]) > 0 Then
    Begin
    with Rastreio.New do
     begin
     DataHora := StrToDateTime(Copy(sl1[i],19,16)+':00');
     Local := CopyDeAte(sl1[i],'</td><td>','</td><td><FONT');
     Situacao := CopyDeAte(sl1[i],'">','</font>');
     Observacao := vObs;
     End;
     vObs := '';
    end;
  End;
 Finally
  sl1.Free;
 End;
End;

end.
