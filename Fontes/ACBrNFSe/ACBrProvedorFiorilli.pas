{$I ACBr.inc}

unit ACBrProvedorFiorilli;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorFiorilli }

 TProvedorFiorilli = class(TProvedorClass)
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

{ TProvedorFiorilli }

constructor TProvedorFiorilli.Create;
begin
 {----}
end;

function TProvedorFiorilli.GetConfigCidade(ACodCidade,
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
  then ConfigCidade.NameSpaceEnvelope := 'http://ws.issweb.fiorilli.com.br/'
  else ConfigCidade.NameSpaceEnvelope := 'http://ws.issweb.fiorilli.com.br/';

 ConfigCidade.AssinaRPS  := True;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorFiorilli.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho       := '2.01';
 ConfigSchema.VersaoDados           := '2.01';
 ConfigSchema.VersaoXML             := '2';
 ConfigSchema.NameSpaceXML          := 'http://www.abrasf.org.br/';
 ConfigSchema.Cabecalho             := 'nfse.xsd';
 ConfigSchema.ServicoEnviar         := 'nfse.xsd';
 ConfigSchema.ServicoConSit         := 'nfse.xsd';
 ConfigSchema.ServicoConLot         := 'nfse.xsd';
 ConfigSchema.ServicoConRps         := 'nfse.xsd';
 ConfigSchema.ServicoConNfse        := 'nfse.xsd';
 ConfigSchema.ServicoCancelar       := 'nfse.xsd';
 ConfigSchema.ServicoGerar          := 'nfse.xsd';
 ConfigSchema.ServicoEnviarSincrono := 'nfse.xsd';
 ConfigSchema.DefTipos              := '';

 Result := ConfigSchema;
end;

function TProvedorFiorilli.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
 cURL_Producao : string;
const
  cURL_Homologacao = 'http://201.28.69.146:5663/IssWeb-ejb/IssWebWS/IssWebWS';
begin
 // URL de produção
 case ACodCidade of
  1100122 : // Ji-Parana/RO
    cURL_Producao := 'http://177.124.184.59:5660/IssWeb-ejb/IssWebWS/IssWebWS';
  1508407 : // Xinguara/PA
    cURL_Producao := 'http://177.23.231.79:5661/IssWeb-ejb/IssWebWS/IssWebWS?wsdl';
  2103000 : // Caxias/MA
    cURL_Producao := 'http://177.105.209.118:8080/IssWeb-ejb/IssWebWS/IssWebWS';
  3504800 : // Balsamo/SP
    cURL_Producao := 'http://201.28.69.146:5663/IssWeb-ejb/IssWebWS/IssWebWS';
  3505203 : // Bariri/SP
    cURL_Producao := 'http://sipweb.bariri.sp.gov.br:8080/IssWeb-ejb/IssWebWS/IssWebWS?wsdl';
  3512902 : // Cosmorama/SP 
    cURL_Producao := 'http://189.111.140.145:8080/IssWeb-ejb/IssWebWS/IssWebWS?wsdl';	
  3514502 : // Duartina/SP
    cURL_Producao := 'http://186.224.0.62:5661/IssWeb-ejb/IssWebWS/IssWebWS?wsdl';
  3516705 : // Garca/SP
    cURL_Producao := 'http://187.51.71.242:2014/IssWeb-ejb/IssWebWS/IssWebWS?wsdl';
  3540200 : // Pontal/SP
    cURL_Producao := 'http://177.69.210.132:8080/IssWeb-ejb/IssWebWS/IssWebWS';
  3549409 : // Sao Joaquim Da Barra/SP
    cURL_Producao := 'http://187.72.128.133:5661/IssWeb-ejb/IssWebWS/IssWebWS';
  3551603 : // Serra Negra/SP
    cURL_Producao := 'http://intra.serranegra.sp.gov.br/IssWeb-ejb/IssWebWS/IssWebWS';
  5003207 : // Corumba/MS
    cURL_Producao := 'http://nfse.corumba.ms.gov.br:8080/IssWeb-ejb/IssWebWS/IssWebWS';
 end;

 ConfigURL.HomNomeCidade         := '';
 ConfigURL.HomRecepcaoLoteRPS    := cURL_Homologacao;
 ConfigURL.HomConsultaLoteRPS    := cURL_Homologacao;
 ConfigURL.HomConsultaNFSeRPS    := cURL_Homologacao;
 ConfigURL.HomConsultaSitLoteRPS := cURL_Homologacao;
 ConfigURL.HomConsultaNFSe       := cURL_Homologacao;
 ConfigURL.HomCancelaNFSe        := cURL_Homologacao;
 ConfigURL.HomGerarNFSe          := cURL_Homologacao;
 ConfigURL.HomRecepcaoSincrono   := cURL_Homologacao;

 ConfigURL.ProNomeCidade         := '';
 ConfigURL.ProRecepcaoLoteRPS    := cURL_Producao;
 ConfigURL.ProConsultaLoteRPS    := cURL_Producao;
 ConfigURL.ProConsultaNFSeRPS    := cURL_Producao;
 ConfigURL.ProConsultaSitLoteRPS := cURL_Producao;
 ConfigURL.ProConsultaNFSe       := cURL_Producao;
 ConfigURL.ProCancelaNFSe        := cURL_Producao;
 ConfigURL.ProGerarNFSe          := cURL_Producao;
 ConfigURL.ProRecepcaoSincrono   := cURL_Producao;

 Result := ConfigURL;
end;

function TProvedorFiorilli.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorFiorilli.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := False;
   acConsSit:     Result := False;
   acConsLote:    Result := False;
   acConsNFSeRps: Result := False;
   acConsNFSe:    Result := False;
   acCancelar:    Result := True;
   acGerar:       Result := False;
   acRecSincrono: Result := False;
   else           Result := False;
 end;
end;

function TProvedorFiorilli.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorFiorilli.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + NameSpaceDad;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + NameSpaceDad;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + NameSpaceDad;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio' + NameSpaceDad;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseServicoPrestadoEnvio' + NameSpaceDad;
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + NameSpaceDad +
                             '<' + Prefixo3 + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                 DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
   acGerar:       Result := '<' + Prefixo3 + 'GerarNfseEnvio' + NameSpaceDad;
   acRecSincrono: Result := '<' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio' + NameSpaceDad;
 end;
end;

function TProvedorFiorilli.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorFiorilli.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '<username>' + CNPJ + '</username>' +
           '<password>' + Senha + '</password>';
end;

function TProvedorFiorilli.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
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
   acRecSincrono: Result := '</' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio>';
 end;
end;

function TProvedorFiorilli.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>'+
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '+
                             'xmlns:ws="http://ws.issweb.fiorilli.com.br/" '+
                             'xmlns:xd="http://www.w3.org/2000/09/xmldsig#"> ' +
           '<soapenv:Header/>' +
             '<soapenv:Body>' +
               '<ws:recepcionarLoteRps>' +
                   DadosMsg +
                   DadosSenha +
                '</ws:recepcionarLoteRps>' +
             '</soapenv:Body>' +
          '</soapenv:Envelope>';
end;

function TProvedorFiorilli.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>'+
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '+
                             'xmlns:ws="http://ws.issweb.fiorilli.com.br/" '+
                             'xmlns:xd="http://www.w3.org/2000/09/xmldsig#"> ' +
           '<soapenv:Header/>' +
              '<soapenv:Body>' +
                '<ws:consultarSituacaoLoteRps>' +
                    DadosMsg +
                    DadosSenha +
                 '</ws:consultarSituacaoLoteRps>' +
              '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorFiorilli.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>'+
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '+
                             'xmlns:ws="http://ws.issweb.fiorilli.com.br/" '+
                             'xmlns:xd="http://www.w3.org/2000/09/xmldsig#"> ' +
           '<soapenv:Header/>' +
              '<soapenv:Body>' +
                '<ws:consultarLoteRps>' +
                    DadosMsg +
                    DadosSenha +
                 '</ws:consultarLoteRps>' +
              '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorFiorilli.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>'+
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '+
                             'xmlns:ws="http://ws.issweb.fiorilli.com.br/" '+
                             'xmlns:xd="http://www.w3.org/2000/09/xmldsig#"> ' +
           '<soapenv:Header/>' +
              '<soapenv:Body>' +
                '<ws:consultarNfsePorRps>' +
                    DadosMsg +
                    DadosSenha +
                 '</ws:consultarNfsePorRps>' +
              '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorFiorilli.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>'+
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '+
                             'xmlns:ws="http://ws.issweb.fiorilli.com.br/" '+
                             'xmlns:xd="http://www.w3.org/2000/09/xmldsig#"> ' +
           '<soapenv:Header/>' +
              '<soapenv:Body>' +
                '<ws:consultarNfseServicoPrestado>' +
                    DadosMsg +
                    DadosSenha +
                 '</ws:consultarNfseServicoPrestado>' +
              '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorFiorilli.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>'+
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '+
                             'xmlns:ws="http://ws.issweb.fiorilli.com.br/" '+
                             'xmlns:xd="http://www.w3.org/2000/09/xmldsig#"> ' +
           '<soapenv:Header/>' +
              '<soapenv:Body>' +
                '<ws:cancelarNfse>' +
                    DadosMsg +
                    DadosSenha +
                '</ws:cancelarNfse>' +
              '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorFiorilli.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>'+
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '+
                             'xmlns:ws="http://ws.issweb.fiorilli.com.br/" '+
                             'xmlns:xd="http://www.w3.org/2000/09/xmldsig#"> ' +
           '<soapenv:Header/>' +
              '<soapenv:Body>' +
                '<ws:gerarNfse>' +
                    DadosMsg +
                    DadosSenha +
                '</ws:gerarNfse>' +
              '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorFiorilli.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>'+
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '+
                             'xmlns:ws="http://ws.issweb.fiorilli.com.br/" '+
                             'xmlns:xd="http://www.w3.org/2000/09/xmldsig#"> ' +
           '<soapenv:Header/>' +
              '<soapenv:Body>' +
                '<ws:recepcionarLoteRpsSincrono>' +
                    DadosMsg +
                    DadosSenha +
                '</ws:recepcionarLoteRpsSincrono>' +
              '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorFiorilli.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
const
 urlsoap = 'http://ws.issweb.fiorilli.com.br/';
begin
 case Acao of
   acRecepcionar: Result := urlsoap + 'recepcionarLoteRps';
   acConsSit:     Result := urlsoap + 'consultarSituacaoLoteRps';
   acConsLote:    Result := urlsoap + 'consultarLoteRps';
   acConsNFSeRps: Result := urlsoap + 'consultarNfsePorRps';
   acConsNFSe:    Result := urlsoap + 'consultarNfseServicoPrestado';
   acCancelar:    Result := urlsoap + 'cancelarNfse';
   acGerar:       Result := urlsoap + 'gerarNfse';
   acRecSincrono: Result := urlsoap + 'recepcionarLoteRpsSincrono';
 end;
end;

function TProvedorFiorilli.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'ns3:recepcionarLoteRpsResponse' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'ns3:consultarSituacaoLoteRpsResponse' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'ns3:consultarLoteRpsResponse' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'ns3:consultarNfsePorRpsResponse' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'ns3:consultarNfseResponse' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'ns3:cancelarNfseResponse' );
   acGerar:       Result := SeparaDados( RetornoWS, 'ns3:gerarNfseResponse' );
   acRecSincrono: Result := SeparaDados( RetornoWS, 'ns3:recepcionarLoteRpsSincronoResponse' );
 end;
 (*
 Result := SeparaDados( RetornoWS, 'soap:Body' );
 *)
end;

function TProvedorFiorilli.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/nfse">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorFiorilli.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
