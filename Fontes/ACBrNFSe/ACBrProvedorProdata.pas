{$I ACBr.inc}

unit ACBrProvedorProdata;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorProdata }

 TProvedorProdata = class(TProvedorClass)
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

{ TProvedorProdata }

constructor TProvedorProdata.Create;
begin
 {----}
end;

function TProvedorProdata.GetConfigCidade(ACodCidade,
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
  then ConfigCidade.NameSpaceEnvelope := 'http://services.nfse'
  else ConfigCidade.NameSpaceEnvelope := 'http://services.nfse';

 ConfigCidade.AssinaRPS  := True;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorProdata.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
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
 ConfigSchema.ServicoEnviarSincrono := 'nfse.xsd';
 ConfigSchema.DefTipos              := '';

 Result := ConfigSchema;
end;

function TProvedorProdata.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 case ACodCidade of
  5208004: begin // Formosa/GO
            ConfigURL.HomNomeCidade := '189.75.118.162:8181';
            ConfigURL.ProNomeCidade := '189.75.118.162:8181';
           end;
  5213103: begin // Mineiros/GO
            ConfigURL.HomNomeCidade := 'homologacao.mineiros.gdc.net.br:90';
            ConfigURL.ProNomeCidade := 'mineiros.gdc.net.br';
           end;
  5218805: begin // Rio Verde/GO
            ConfigURL.HomNomeCidade := 'homologacao.rioverdegoias.com.br';
            ConfigURL.ProNomeCidade := 'online.rioverdegoias.com.br';
           end;
 end;

 ConfigURL.HomRecepcaoLoteRPS    := 'http://' + ConfigURL.HomNomeCidade + '/prodataws/services/NfseWSService?wsdl/';
 ConfigURL.HomConsultaLoteRPS    := 'http://' + ConfigURL.HomNomeCidade + '/prodataws/services/NfseWSService?wsdl/';
 ConfigURL.HomConsultaNFSeRPS    := 'http://' + ConfigURL.HomNomeCidade + '/prodataws/services/NfseWSService?wsdl/';
 ConfigURL.HomConsultaSitLoteRPS := 'http://' + ConfigURL.HomNomeCidade + '/prodataws/services/NfseWSService?wsdl/';
 ConfigURL.HomConsultaNFSe       := 'http://' + ConfigURL.HomNomeCidade + '/prodataws/services/NfseWSService?wsdl/';
 ConfigURL.HomCancelaNFSe        := 'http://' + ConfigURL.HomNomeCidade + '/prodataws/services/NfseWSService?wsdl/';
 ConfigURL.HomGerarNFSe          := 'http://' + ConfigURL.HomNomeCidade + '/prodataws/services/NfseWSService?wsdl/';
 ConfigURL.HomRecepcaoSincrono   := 'http://' + ConfigURL.HomNomeCidade + '/prodataws/services/NfseWSService?wsdl/';

 ConfigURL.ProRecepcaoLoteRPS    := 'http://' + ConfigURL.ProNomeCidade + '/prodataws/services/NfseWSService?wsdl/';
 ConfigURL.ProConsultaLoteRPS    := 'http://' + ConfigURL.ProNomeCidade + '/prodataws/services/NfseWSService?wsdl/';
 ConfigURL.ProConsultaNFSeRPS    := 'http://' + ConfigURL.ProNomeCidade + '/prodataws/services/NfseWSService?wsdl/';
 ConfigURL.ProConsultaSitLoteRPS := 'http://' + ConfigURL.ProNomeCidade + '/prodataws/services/NfseWSService?wsdl/';
 ConfigURL.ProConsultaNFSe       := 'http://' + ConfigURL.ProNomeCidade + '/prodataws/services/NfseWSService?wsdl/';
 ConfigURL.ProCancelaNFSe        := 'http://' + ConfigURL.ProNomeCidade + '/prodataws/services/NfseWSService?wsdl/';
 ConfigURL.ProGerarNFSe          := 'http://' + ConfigURL.ProNomeCidade + '/prodataws/services/NfseWSService?wsdl/';
 ConfigURL.ProRecepcaoSincrono   := 'http://' + ConfigURL.ProNomeCidade + '/prodataws/services/NfseWSService?wsdl/';

 Result := ConfigURL;
end;

function TProvedorProdata.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorProdata.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 Result := False;
 case Acao of
   acRecepcionar: Result := True;
   acConsSit:     Result := True;
   acConsLote:    Result := True;
   acConsNFSeRps: Result := True;
   acConsNFSe:    Result := True;
   acCancelar:    Result := True;
   acGerar:       Result := True;
   acRecSincrono: Result := True;
 end;
end;

function TProvedorProdata.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorProdata.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
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
   acGerar:       Result := '<' + Prefixo3 + 'GerarNfseEnvio' + NameSpaceDad;
   acRecSincrono: Result := '<' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio' + NameSpaceDad;
 end;
end;

function TProvedorProdata.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorProdata.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorProdata.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRpsEnvio>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '</' + Prefixo3 + 'Pedido>' +
                            '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '</' + Prefixo3 + 'GerarNfseEnvio>';
   acRecSincrono: Result := '</' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio>';
 end;
end;

function TProvedorProdata.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ns2:RecepcionarLoteRpsRequest xmlns:ns2="' + URLNS + '">' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</ns2:RecepcionarLoteRpsRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorProdata.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ns2:ConsultarSituacaoLoteRpsRequest xmlns:ns2="' + URLNS + '">' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</ns2:ConsultarSituacaoLoteRpsRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorProdata.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ns2:ConsultarLoteRpsRequest xmlns:ns2="' + URLNS + '">' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</ns2:ConsultarLoteRpsRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorProdata.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ns2:ConsultarNfsePorRpsRequest xmlns:ns2="' + URLNS + '">' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</ns2:ConsultarNfsePorRpsRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorProdata.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ns2:ConsultarNfseRequest xmlns:ns2="' + URLNS + '">' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</ns2:ConsultarNfseRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorProdata.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ns2:CancelarNfseRequest xmlns:ns2="' + URLNS + '">' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</ns2:CancelarNfseRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorProdata.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ns2:RecepcionarLoteRpsRequest xmlns:ns2="' + URLNS + '">' +
              '<nfseCabecMsg>' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</ns2:RecepcionarLoteRpsRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
 raise Exception.Create( 'Opção não implementada para este provedor.' );
end;

function TProvedorProdata.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ns2:RecepcionarLoteRpsSincronoRequest xmlns:ns2="' + URLNS + '">' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</ns2:RecepcionarLoteRpsSincronoRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorProdata.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://services.nfse/RecepcionarLoteRps';
   acConsSit:     Result := 'http://services.nfse/ConsultarSituacaoLoteRps';
   acConsLote:    Result := 'http://services.nfse/ConsultarLoteRps';
   acConsNFSeRps: Result := 'http://services.nfse/ConsultarNfsePorRps';
   acConsNFSe:    Result := 'http://services.nfse/ConsultarNfseServicoPrestado';
   acCancelar:    Result := 'http://services.nfse/CancelarNfse';
   acGerar:       Result := 'http://services.nfse/GerarNfse';
   acRecSincrono: Result := 'http://services.nfse/RecepcionarLoteRpsSincrono';
 end;
end;

function TProvedorProdata.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'outputXML' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'outputXML' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'outputXML' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'outputXML' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'outputXML' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'outputXML' );
   acGerar:       Result := SeparaDados( RetornoWS, 'outputXML' );
   acRecSincrono: Result := SeparaDados( RetornoWS, 'outputXML' );
 end;
end;

function TProvedorProdata.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/nfse">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorProdata.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
