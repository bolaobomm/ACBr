{******************************************************************************}
{ Projeto: Componente ACBrNFSe                                                 }
{  Biblioteca multiplataforma de componentes Delphi                            }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
{                                                                              }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrProvedorDBSeller;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorDBSeller }

 TProvedorDBSeller = class(TProvedorClass)
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

{ TProvedorDBSeller }

constructor TProvedorDBSeller.Create;
begin
 {----}
end;

function TProvedorDBSeller.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
  ConfigCidade: TConfigCidade;
  NomeCidade: String;
begin
  ConfigCidade.VersaoSoap    := '1.1';
  ConfigCidade.Prefixo2      := '';
  ConfigCidade.Prefixo3      := '';
  ConfigCidade.Prefixo4      := '';
  ConfigCidade.Identificador := 'Id';
  ConfigCidade.QuebradeLinha := ';';

  case ACodCidade of
   4300406: NomeCidade := 'alegrete.rs';
   4304705: NomeCidade := 'carazinho.rs';
  end;

  if AAmbiente = 1 then
    ConfigCidade.NameSpaceEnvelope := 'http://nfse.' + NomeCidade + '.gov.br/webservice/index/producao'
  else
    ConfigCidade.NameSpaceEnvelope := 'http://nfse.' + NomeCidade + '.gov.br:82/webservice/index/homologacao';

  ConfigCidade.AssinaRPS  := False;
  ConfigCidade.AssinaLote := True;

  Result := ConfigCidade;
end;

function TProvedorDBSeller.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
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

function TProvedorDBSeller.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 case ACodCidade of
  4300406: begin
            ConfigURL.HomNomeCidade := 'alegrete.rs';
            ConfigURL.ProNomeCidade := 'alegrete.rs';
           end;
  4304705: begin
            ConfigURL.HomNomeCidade := 'carazinho.rs';
            ConfigURL.ProNomeCidade := 'carazinho.rs';
           end;
 end;

 ConfigURL.HomRecepcaoLoteRPS    := 'http://nfse.' + ConfigURL.HomNomeCidade + '.gov.br/webservice/index/homologacao';
 ConfigURL.HomConsultaLoteRPS    := 'http://nfse.' + ConfigURL.HomNomeCidade + '.gov.br/webservice/index/homologacao';
 ConfigURL.HomConsultaNFSeRPS    := 'http://nfse.' + ConfigURL.HomNomeCidade + '.gov.br/webservice/index/homologacao';
 ConfigURL.HomConsultaSitLoteRPS := 'http://nfse.' + ConfigURL.HomNomeCidade + '.gov.br/webservice/index/homologacao';
 ConfigURL.HomConsultaNFSe       := 'http://nfse.' + ConfigURL.HomNomeCidade + '.gov.br/webservice/index/homologacao';
 ConfigURL.HomCancelaNFSe        := 'http://nfse.' + ConfigURL.HomNomeCidade + '.gov.br/webservice/index/homologacao';
 ConfigURL.HomGerarNFSe          := 'http://nfse.' + ConfigURL.HomNomeCidade + '.gov.br/webservice/index/homologacao';

 ConfigURL.ProRecepcaoLoteRPS    := 'http://nfse.' + ConfigURL.ProNomeCidade + '.gov.br/webservice/index/producao';
 ConfigURL.ProConsultaLoteRPS    := 'http://nfse.' + ConfigURL.ProNomeCidade + '.gov.br/webservice/index/producao';
 ConfigURL.ProConsultaNFSeRPS    := 'http://nfse.' + ConfigURL.ProNomeCidade + '.gov.br/webservice/index/producao';
 ConfigURL.ProConsultaSitLoteRPS := 'http://nfse.' + ConfigURL.ProNomeCidade + '.gov.br/webservice/index/producao';
 ConfigURL.ProConsultaNFSe       := 'http://nfse.' + ConfigURL.ProNomeCidade + '.gov.br/webservice/index/producao';
 ConfigURL.ProCancelaNFSe        := 'http://nfse.' + ConfigURL.ProNomeCidade + '.gov.br/webservice/index/producao';
 ConfigURL.ProGerarNFSe          := 'http://nfse.' + ConfigURL.ProNomeCidade + '.gov.br/webservice/index/producao';

 Result := ConfigURL;
end;

function TProvedorDBSeller.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorDBSeller.GetAssinarXML(Acao: TnfseAcao): Boolean;
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

function TProvedorDBSeller.GetValidarLote: Boolean;
begin
 // O Schema que o provedor disponibilizou n�o esta em conformidade,
 // gerando um erro ao executar a valida��o
 Result := False;
end;

function TProvedorDBSeller.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
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

function TProvedorDBSeller.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorDBSeller.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorDBSeller.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
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

function TProvedorDBSeller.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg := '<?xml version="1.0" encoding="utf-8"?>' + DadosMsg;
 DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]),
                           '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                          'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                          'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<RecepcionarLoteRps xmlns="' + URLNS + '/">' +
              '<xml xmlns="">' +
                DadosMsg +
              '</xml>' +
             '</RecepcionarLoteRps>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorDBSeller.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg := '<?xml version="1.0" encoding="utf-8"?>' + DadosMsg;
 DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]),
                           '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                          'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                          'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<ConsultarSituacaoLoteRps xmlns="' + URLNS + '">' +
              '<xml xmlns="">' +
                DadosMsg +
              '</xml>' +
             '</ConsultarSituacaoLoteRps>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorDBSeller.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg := '<?xml version="1.0" encoding="utf-8"?>' + DadosMsg;
 DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]),
                           '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                          'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                          'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<ConsultarLoteRps xmlns="' + URLNS + '">' +
              '<xml xmlns="">' +
                DadosMsg +
              '</xml>' +
             '</ConsultarLoteRps>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorDBSeller.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg := '<?xml version="1.0" encoding="utf-8"?>' + DadosMsg;
 DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]),
                           '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                          'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                          'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<ConsultarNfsePorRps xmlns="' + URLNS + '">' +
              '<xml xmlns="">' +
                DadosMsg +
              '</xml>' +
             '</ConsultarNfsePorRps>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorDBSeller.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg := '<?xml version="1.0" encoding="utf-8"?>' + DadosMsg;
 DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]),
                           '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                          'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                          'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<ConsultarNfse xmlns="' + URLNS + '">' +
              '<xml xmlns="">' +
                DadosMsg +
              '</xml>' +
             '</ConsultarNfse>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorDBSeller.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg := '<?xml version="1.0" encoding="utf-8"?>' + DadosMsg;
 DadosMsg := StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]),
                           '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                          'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                          'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<CancelarNfse xmlns="' + URLNS + '">' +
              '<xml xmlns="">' +
                DadosMsg +
              '</xml>' +
             '</CancelarNfse>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorDBSeller.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorDBSeller.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorDBSeller.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := '';
   acConsSit:     Result := '';
   acConsLote:    Result := '';
   acConsNFSeRps: Result := '';
   acConsNFSe:    Result := '';
   acCancelar:    Result := '';
   acGerar:       Result := '';
 end;
end;

function TProvedorDBSeller.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar,
   acConsSit,
   acConsLote,
   acConsNFSeRps,
   acConsNFSe,
   acCancelar: begin
                 Result := SeparaDados( RetornoWS, 'return' );
                 if Result = '' then
                   Result := SeparaDados( RetornoWS, 'SOAP-ENV:Body' );
               end;
   acGerar:    Result := '';
 end;
end;

function TProvedorDBSeller.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorDBSeller.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
