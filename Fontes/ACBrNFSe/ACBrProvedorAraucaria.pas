{******************************************************************************}
{ Projeto: Componente ACBrNFSe                                                 }
{  Biblioteca multiplataforma de componentes Delphi                            }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
{                                                                              }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrProvedorAraucaria;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorAraucaria }

 TProvedorAraucaria = class(TProvedorClass)
  protected
   { protected }
  private
   { private }
  public
   { public }
   Constructor Create;

   function GetConfigCidade(ACodCidade, AAmbiente: Integer): TConfigCidade; OverRide;
   function GetConfigSchema(ACodCidade: Integer): TConfigSchema; OverRide;
   function GetConfigURL(ACodCidade: Integer): TConfigURL; OverRide;
   function GetURI(URI: String): String; OverRide;
   function GetAssinarXML(Acao: TnfseAcao): Boolean; OverRide;
   function GetValidarLote: Boolean; OverRide;

   function Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4, NameSpaceDad, Identificador, URI: String): AnsiString; OverRide;
   function Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados, NameSpaceCab: String; ACodCidade: Integer): AnsiString; OverRide;
   function Gera_DadosSenha(CNPJ, Senha: String): AnsiString; OverRide;
   function Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString; OverRide;

   function GeraEnvelopeRecepcionarLoteRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarSituacaoLoteRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarLoteRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarNFSeporRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeGerarNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeRecepcionarSincrono(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;

   function GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String; OverRide;
   function GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString; OverRide;

   function GeraRetornoNFSe(Prefixo: String; RetNFSe: AnsiString; NomeCidade: String): AnsiString; OverRide;
   function GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer; ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String; OverRide;
  end;

implementation

{ TProvedorAraucaria }

constructor TProvedorAraucaria.Create;
begin
 {----}
end;

function TProvedorAraucaria.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.1';
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := '';
 ConfigCidade.Prefixo4      := '';
 ConfigCidade.Identificador := 'id'; // Dever ser trocado depois para id

 ConfigCidade.NameSpaceEnvelope := 'http://tempuri.org';

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := False;

 Result := ConfigCidade;
end;

function TProvedorAraucaria.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '1.00';
 ConfigSchema.VersaoDados     := '1.00';
 ConfigSchema.VersaoXML       := '1';
 ConfigSchema.NameSpaceXML    := 'http://www.abrasf.org.br/ABRASF/arquivos/';
 ConfigSchema.Cabecalho       := 'nfse.xsd';
 ConfigSchema.ServicoEnviar   := 'nfse.xsd';
 ConfigSchema.ServicoConSit   := 'nfse.xsd';
 ConfigSchema.ServicoConLot   := 'nfse.xsd';
 ConfigSchema.ServicoConRps   := 'nfse.xsd';
 ConfigSchema.ServicoConNfse  := 'nfse.xsd';
 ConfigSchema.ServicoCancelar := 'nfse.xsd';
 ConfigSchema.DefTipos        := '';
 ConfigSchema.ServicoGerar    := '';

 Result := ConfigSchema;
end;

function TProvedorAraucaria.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 ConfigURL.HomNomeCidade         := '';
 ConfigURL.HomRecepcaoLoteRPS    := 'http://nfse.araucaria.pr.gov.br/nfsews/nfse.asmx';
 ConfigURL.HomConsultaLoteRPS    := 'http://nfse.araucaria.pr.gov.br/nfsews/nfse.asmx';
 ConfigURL.HomConsultaNFSeRPS    := 'http://nfse.araucaria.pr.gov.br/nfsews/nfse.asmx';
 ConfigURL.HomConsultaSitLoteRPS := 'http://nfse.araucaria.pr.gov.br/nfsews/nfse.asmx';
 ConfigURL.HomConsultaNFSe       := 'http://nfse.araucaria.pr.gov.br/nfsews/nfse.asmx';
 ConfigURL.HomCancelaNFSe        := 'http://nfse.araucaria.pr.gov.br/nfsews/nfse.asmx';
 ConfigURL.HomGerarNFSe          := 'http://nfse.araucaria.pr.gov.br/nfsews/nfse.asmx';

 ConfigURL.ProNomeCidade         := '';
 ConfigURL.ProRecepcaoLoteRPS    := 'http://nfse.araucaria.pr.gov.br/nfsews/nfse.asmx';
 ConfigURL.ProConsultaLoteRPS    := 'http://nfse.araucaria.pr.gov.br/nfsews/nfse.asmx';
 ConfigURL.ProConsultaNFSeRPS    := 'http://nfse.araucaria.pr.gov.br/nfsews/nfse.asmx';
 ConfigURL.ProConsultaSitLoteRPS := 'http://nfse.araucaria.pr.gov.br/nfsews/nfse.asmx';
 ConfigURL.ProConsultaNFSe       := 'http://nfse.araucaria.pr.gov.br/nfsews/nfse.asmx';
 ConfigURL.ProCancelaNFSe        := 'http://nfse.araucaria.pr.gov.br/nfsews/nfse.asmx';
 ConfigURL.ProGerarNFSe          := 'http://nfse.araucaria.pr.gov.br/nfsews/nfse.asmx';

 Result := ConfigURL;
end;

function TProvedorAraucaria.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorAraucaria.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := False;
   acConsSit:     Result := False;
   acConsLote:    Result := False;
   acConsNFSeRps: Result := False;
   acConsNFSe:    Result := False;
   acCancelar:    Result := False;
   acGerar:       Result := False;
   else           Result := False;
 end;
end;

function TProvedorAraucaria.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorAraucaria.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + NameSpaceDad;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + NameSpaceDad;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + NameSpaceDad;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio' + NameSpaceDad;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseEnvio' + NameSpaceDad;
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + NameSpaceDad +
                             '<' + Prefixo3 + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                 DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
   acGerar:       Result := '';
 end;
end;

function TProvedorAraucaria.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorAraucaria.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorAraucaria.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRpsEnvio>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '</' + Prefixo3 + 'Pedido>' +
                            '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '';
 end;
end;

function TProvedorAraucaria.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                          'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                          'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<RecebeLoteRPS xmlns="' + URLNS + '/">' +
              '<xml>' +
                DadosMsg +
              '</xml>' +
             '</RecebeLoteRPS>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorAraucaria.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                          'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                          'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<ConsultarSituacaoLoteRPS xmlns="' + URLNS + '/">' +
              '<xml>' +
                DadosMsg +
              '</xml>' +
             '</ConsultarSituacaoLoteRPS>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorAraucaria.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                          'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                          'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<ConsultarLoteRPS xmlns="' + URLNS + '/">' +
              '<xml>' +
                DadosMsg +
              '</xml>' +
             '</ConsultarLoteRPS>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorAraucaria.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                          'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                          'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<ConsultarNFSEPorRPS xmlns="' + URLNS + '/">' +
              '<xml>' +
                DadosMsg +
              '</xml>' +
             '</ConsultarNFSEPorRPS>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorAraucaria.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                          'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                          'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<ConsultaNFSE xmlns="' + URLNS + '/">' +
              '<xml>' +
                DadosMsg +
              '</xml>' +
             '</ConsultaNFSE>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorAraucaria.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                          'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                          'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<CancelamentoNFSE xmlns="' + URLNS + '/">' +
              '<xml>' +
                DadosMsg +
              '</xml>' +
             '</CancelamentoNFSE>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorAraucaria.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorAraucaria.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorAraucaria.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://tempuri.org/RecebeLoteRPS';
   acConsSit:     Result := 'http://tempuri.org/ConsultarSituacaoLoteRPS';
   acConsLote:    Result := 'http://tempuri.org/ConsultarLoteRPS';
   acConsNFSeRps: Result := 'http://tempuri.org/ConsultarNFSEPorRPS';
   acConsNFSe:    Result := 'http://tempuri.org/ConsultaNFSE';
   acCancelar:    Result := 'http://tempuri.org/CancelamentoNFSE';
   acGerar:       Result := '';
 end;
end;

function TProvedorAraucaria.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'RecebeLoteRPSResult' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'ConsultarSituacaoLoteRPSResult' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'ConsultarLoteRPSResult' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'ConsultarNFSEPorLoteRPSResult' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'ConsultaNFSEResult' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'CancelamentoNFSEResult' );
   acGerar:       Result := '';
 end;
end;

function TProvedorAraucaria.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorAraucaria.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
