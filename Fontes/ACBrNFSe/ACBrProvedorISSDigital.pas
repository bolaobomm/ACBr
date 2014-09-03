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

unit ACBrProvedorISSDigital;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorISSDigital }

 TProvedorISSDigital = class(TProvedorClass)
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

{ TProvedorISSDigital }

constructor TProvedorISSDigital.Create;
begin
 {----}
end;

function TProvedorISSDigital.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.1';
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := '';
 ConfigCidade.Prefixo4      := '';
 ConfigCidade.Identificador := 'Id';

 if AAmbiente = 1
  then ConfigCidade.NameSpaceEnvelope := 'http://tempuri.org'
  else ConfigCidade.NameSpaceEnvelope := 'http://tempuri.org';

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := False;

 Result := ConfigCidade;
end;

function TProvedorISSDigital.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '2.01';
 ConfigSchema.VersaoDados     := '2.01';
 ConfigSchema.VersaoXML       := '2';
 ConfigSchema.NameSpaceXML    := 'http://www.abrasf.org.br/';
 ConfigSchema.Cabecalho       := 'nfse.xsd';
 ConfigSchema.ServicoEnviar   := 'nfse.xsd';
 ConfigSchema.ServicoConSit   := 'nfse.xsd';
 ConfigSchema.ServicoConLot   := 'nfse.xsd';
 ConfigSchema.ServicoConRps   := 'nfse.xsd';
 ConfigSchema.ServicoConNfse  := 'nfse.xsd';
 ConfigSchema.ServicoCancelar := 'nfse.xsd';
 ConfigSchema.ServicoGerar    := 'nfse.xsd';
 ConfigSchema.DefTipos        := '';

 Result := ConfigSchema;
end;

function TProvedorISSDigital.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
 URL: String;
begin
 case ACodCidade of
  3144805: begin
            URL := 'http://issonline.pnl.mg.gov.br/nfe/snissdigitalsvc';
            ConfigURL.HomNomeCidade := ''; // 'novalima';
            ConfigURL.ProNomeCidade := ''; // 'novalima';
           end;
  3157807: begin
            URL := 'http://209.126.222.200/nfe/snissdigitalsvc';
            ConfigURL.HomNomeCidade := '_santaluzia';
            ConfigURL.ProNomeCidade := '_santaluzia';
           end;
  3300704: begin
            URL := 'http://186.232.160.26/nfe/snissdigitalsvc';
            ConfigURL.HomNomeCidade := ''; // 'cabo frio/rj';
            ConfigURL.ProNomeCidade := ''; // 'cabo frio/rj';
           end;
 end;

 ConfigURL.HomRecepcaoLoteRPS    := URL + ConfigURL.HomNomeCidade + '.dll/soap/IuWebServiceIssDigital';
 ConfigURL.HomConsultaLoteRPS    := URL + ConfigURL.HomNomeCidade + '.dll/soap/IuWebServiceIssDigital';
 ConfigURL.HomConsultaNFSeRPS    := URL + ConfigURL.HomNomeCidade + '.dll/soap/IuWebServiceIssDigital';
 ConfigURL.HomConsultaSitLoteRPS := URL + ConfigURL.HomNomeCidade + '.dll/soap/IuWebServiceIssDigital';
 ConfigURL.HomConsultaNFSe       := URL + ConfigURL.HomNomeCidade + '.dll/soap/IuWebServiceIssDigital';
 ConfigURL.HomCancelaNFSe        := URL + ConfigURL.HomNomeCidade + '.dll/soap/IuWebServiceIssDigital';
 ConfigURL.HomGerarNFSe          := URL + ConfigURL.HomNomeCidade + '.dll/soap/IuWebServiceIssDigital';

 ConfigURL.ProRecepcaoLoteRPS    := URL + ConfigURL.ProNomeCidade + '.dll/soap/IuWebServiceIssDigital';
 ConfigURL.ProConsultaLoteRPS    := URL + ConfigURL.ProNomeCidade + '.dll/soap/IuWebServiceIssDigital';
 ConfigURL.ProConsultaNFSeRPS    := URL + ConfigURL.ProNomeCidade + '.dll/soap/IuWebServiceIssDigital';
 ConfigURL.ProConsultaSitLoteRPS := URL + ConfigURL.ProNomeCidade + '.dll/soap/IuWebServiceIssDigital';
 ConfigURL.ProConsultaNFSe       := URL + ConfigURL.ProNomeCidade + '.dll/soap/IuWebServiceIssDigital';
 ConfigURL.ProCancelaNFSe        := URL + ConfigURL.ProNomeCidade + '.dll/soap/IuWebServiceIssDigital';
 ConfigURL.ProGerarNFSe          := URL + ConfigURL.ProNomeCidade + '.dll/soap/IuWebServiceIssDigital';

 Result := ConfigURL;
end;

function TProvedorISSDigital.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorISSDigital.GetAssinarXML(Acao: TnfseAcao): Boolean;
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

function TProvedorISSDigital.GetValidarLote: Boolean;
begin
 Result := False;
end;

function TProvedorISSDigital.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
var
 xmlns: String;
begin
 xmlns := NameSpaceDad;

 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + xmlns;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + xmlns;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + xmlns;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio' + xmlns;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseServicoPrestadoEnvio' + xmlns;
   {
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + xmlns +
                             '<' + Prefixo3 + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                 DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
   }
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + xmlns +
                             '<' + Prefixo3 + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento';
   acGerar:       Result := '<' + Prefixo3 + 'GerarNfseEnvio' + xmlns;
 end;
end;

function TProvedorISSDigital.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho' +
            ' versao="'  + VersaoLayOut + '"' +
            ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
            ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorISSDigital.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorISSDigital.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRpsEnvio>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseServicoPrestadoEnvio>';
   acCancelar:    Result := '</' + Prefixo3 + 'Pedido>' +
                            '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '</' + Prefixo3 + 'GerarNfseEnvio>';
 end;
end;

function TProvedorISSDigital.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
            '<s:Header>' +
              DadosSenha +
            '</s:Header>' +
            '<s:Body>' +
             '<NS1:RecepcionarLoteRps xmlns:NS1="urn:uWebServiceIssDigitalIntf-IuWebServiceIssDigital">' +
//              '<nfseCabecMsg>' +
//               '<![CDATA[' + CabMsg + ']]>' +
//              '</nfseCabecMsg>' +
              '<Value xsi:type="xsd:string">' +
//               '<![CDATA[' + DadosMsg + ']]>' +
                 DadosMsg +
              '</Value>' +
             '</NS1:RecepcionarLoteRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorISSDigital.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
 raise Exception.Create( 'Opção não implementada para este provedor.' );
end;

// Removido a palavra Request dos nfse:, exemplo:
// '<nfse:ConsultarLoteRpsRequest>' para '<nfse:ConsultarLoteRps>'
function TProvedorISSDigital.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 // Jonatan - Consulta Lote RPS Nova Lima
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
            '<s:Header>' +
              DadosSenha +
            '</s:Header>' +
            '<s:Body>' +
             '<NS1:ConsultarLoteRps xmlns:NS1="urn:uWebServiceIssDigitalIntf-IuWebServiceIssDigital">' +
              '<Value xsi:type="xsd:string">' +
                 DadosMsg +
              '</Value>' +
             '</NS1:ConsultarLoteRps>' +
            '</s:Body>' +
           '</s:Envelope>';
 (*
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
            '<S:Header>' +
              DadosSenha +
            '</S:Header>' +
            '<S:Body>' +
             '<nfse:ConsultarLoteRps>' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</nfse:ConsultarLoteRps>' +
            '</S:Body>' +
           '</S:Envelope>';
 *)
end;

function TProvedorISSDigital.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 // Jonatan
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
            '<s:Header>' +
              DadosSenha +
            '</s:Header>' +
            '<s:Body>' +
             '<NS1:ConsultarNfsePorRps xmlns:NS1="urn:uWebServiceIssDigitalIntf-IuWebServiceIssDigital">' +
              '<Value xsi:type="xsd:string">' +
                 DadosMsg +
              '</Value>' +
             '</NS1:ConsultarNfsePorRps>' +
            '</s:Body>' +
           '</s:Envelope>';
 (*
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
            '<S:Header>' +
              DadosSenha +
            '</S:Header>' +
            '<S:Body>' +
             '<nfse:ConsultarNfsePorRps>' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</nfse:ConsultarNfsePorRps>' +
            '</S:Body>' +
           '</S:Envelope>';
 *)
end;

function TProvedorISSDigital.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 // Jonatan Augusto - Nova Lima MG
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
            '<s:Header>' +
              DadosSenha +
            '</s:Header>' +
            '<s:Body>' +
             '<NS1:ConsultarNfseServicoPrestado xmlns:NS1="urn:uWebServiceIssDigitalIntf-IuWebServiceIssDigital">' +
              '<Value xsi:type="xsd:string">' +
                 DadosMsg +
              '</Value>' +
             '</NS1:ConsultarNfseServicoPrestado>' +
            '</s:Body>' +
           '</s:Envelope>';
 (*
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
            '<S:Header>' +
              DadosSenha +
            '</S:Header>' +
            '<S:Body>' +
             '<nfse:ConsultarNfseServicoPrestado>' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</nfse:ConsultarNfseServicoPrestado>' +
            '</S:Body>' +
           '</S:Envelope>';
 *)
end;

function TProvedorISSDigital.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 // Jonatan Augusto - Nova Lima MG
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
            '<s:Header>' +
              DadosSenha +
            '</s:Header>' +
            '<s:Body>' +
             '<NS1:CancelarNfse xmlns:NS1="urn:uWebServiceIssDigitalIntf-IuWebServiceIssDigital">' +
              '<Value xsi:type="xsd:string">' +
                 DadosMsg +
              '</Value>' +
             '</NS1:CancelarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
 (*
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
            '<S:Header>' +
              DadosSenha +
            '</S:Header>' +
            '<S:Body>' +
             '<nfse:CancelarNfse>' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</nfse:CancelarNfse>' +
            '</S:Body>' +
           '</S:Envelope>';
 *)
end;

function TProvedorISSDigital.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 // Jonatan - Nova Lima MG
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
            '<s:Header>' +
              DadosSenha +
            '</s:Header>' +
            '<s:Body>' +
             '<NS1:GerarNfse xmlns:NS1="urn:uWebServiceIssDigitalIntf-IuWebServiceIssDigital">' +
              '<Value xsi:type="xsd:string">' +
                 DadosMsg +
              '</Value>' +
             '</NS1:GerarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
 (*
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
            '<S:Header>' +
              DadosSenha +
            '</S:Header>' +
            '<S:Body>' +
             '<nfse:GerarNfse>' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</nfse:GerarNfse>' +
            '</S:Body>' +
           '</S:Envelope>';
 *)
end;

function TProvedorISSDigital.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorISSDigital.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'urn:uWebServiceIssDigitalIntf-IuWebServiceIssDigital#RecepcionarLoteRps';
   acConsSit:     Result := '';
   acConsLote:    Result := 'urn:uWebServiceIssDigitalIntf-IuWebServiceIssDigital#ConsultarLoteRps';
   acConsNFSeRps: Result := 'urn:uWebServiceIssDigitalIntf-IuWebServiceIssDigital#ConsultarNfsePorRps';
   acConsNFSe:    Result := 'urn:uWebServiceIssDigitalIntf-IuWebServiceIssDigital#ConsultarNfseServicoPrestado';
   acCancelar:    Result := 'urn:uWebServiceIssDigitalIntf-IuWebServiceIssDigital#CancelarNfse';
   acGerar:       Result := 'urn:uWebServiceIssDigitalIntf-IuWebServiceIssDigital#GerarNfse';
 end;
end;

function TProvedorISSDigital.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'return' );
   acConsSit:     Result := RetornoWS;
   acConsLote:    Result := SeparaDados( RetornoWS, 'return' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'return' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'return' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'return' );
   acGerar:       Result := SeparaDados( RetornoWS, 'return' );
 end;
end;

function TProvedorISSDigital.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/nfse.xsd">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorISSDigital.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 if AAmbiente = 1
  then begin
   case ACodMunicipio of
    3157807: Result := '';
   else Result := '';
   end;
  end
  else Result := '';
end;

end.
