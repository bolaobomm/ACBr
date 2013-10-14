{$I ACBr.inc}

unit ACBrProvedorISSe;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorISSe }

 TProvedorISSe = class(TProvedorClass)
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

{ TProvedorISSe }

constructor TProvedorISSe.Create;
begin
 {----}
end;

function TProvedorISSe.GetConfigCidade(ACodCidade,
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
  then ConfigCidade.NameSpaceEnvelope := 'http://nfse.abrasf.org.br'
  else ConfigCidade.NameSpaceEnvelope := 'http://nfse.abrasf.org.br';

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorISSe.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
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

function TProvedorISSe.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 case ACodCidade of
  4115200: begin
            ConfigURL.HomNomeCidade         := 'teste.maringa.pr';

            ConfigURL.ProNomeCidade         := '.maringa.pr';
           end;
 end;

 ConfigURL.HomRecepcaoLoteRPS    := 'https://isse' + ConfigURL.HomNomeCidade + '.gov.br/ws/';
 ConfigURL.HomConsultaLoteRPS    := 'https://isse' + ConfigURL.HomNomeCidade + '.gov.br/ws/';
 ConfigURL.HomConsultaNFSeRPS    := 'https://isse' + ConfigURL.HomNomeCidade + '.gov.br/ws/';
 ConfigURL.HomConsultaSitLoteRPS := 'https://isse' + ConfigURL.HomNomeCidade + '.gov.br/ws/';
 ConfigURL.HomConsultaNFSe       := 'https://isse' + ConfigURL.HomNomeCidade + '.gov.br/ws/';
 ConfigURL.HomCancelaNFSe        := 'https://isse' + ConfigURL.HomNomeCidade + '.gov.br/ws/';
 ConfigURL.HomGerarNFSe          := 'https://isse' + ConfigURL.HomNomeCidade + '.gov.br/ws/';
 ConfigURL.HomRecepcaoSincrono   := 'https://isse' + ConfigURL.HomNomeCidade + '.gov.br/ws/';

 ConfigURL.ProRecepcaoLoteRPS    := 'https://isse' + ConfigURL.ProNomeCidade + '.gov.br/ws/';
 ConfigURL.ProConsultaLoteRPS    := 'https://isse' + ConfigURL.ProNomeCidade + '.gov.br/ws/';
 ConfigURL.ProConsultaNFSeRPS    := 'https://isse' + ConfigURL.ProNomeCidade + '.gov.br/ws/';
 ConfigURL.ProConsultaSitLoteRPS := 'https://isse' + ConfigURL.ProNomeCidade + '.gov.br/ws/';
 ConfigURL.ProConsultaNFSe       := 'https://isse' + ConfigURL.ProNomeCidade + '.gov.br/ws/';
 ConfigURL.ProCancelaNFSe        := 'https://isse' + ConfigURL.ProNomeCidade + '.gov.br/ws/';
 ConfigURL.ProGerarNFSe          := 'https://isse' + ConfigURL.ProNomeCidade + '.gov.br/ws/';
 ConfigURL.ProRecepcaoSincrono   := 'https://isse' + ConfigURL.ProNomeCidade + '.gov.br/ws/';

 Result := ConfigURL;
end;

function TProvedorISSe.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorISSe.GetAssinarXML(Acao: TnfseAcao): Boolean;
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

function TProvedorISSe.GetValidarLote: Boolean;
begin
 Result := False;
end;

function TProvedorISSe.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
var
 xmlns: String;
begin
 xmlns := ' xmlns:ds="http://www.w3.org/2000/09/xmldsig#"' +
          ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
          ' xsi:schemaLocation="http://www.abrasf.org.br/nfse.xsd nfse_v2.01.xsd"' +
          NameSpaceDad;

 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + xmlns;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + xmlns;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + xmlns;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio' + xmlns;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseServicoPrestadoEnvio' + xmlns;
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + xmlns +
                             '<' + Prefixo3 + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                 DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
   acGerar:       Result := '<' + Prefixo3 + 'GerarNfseEnvio' + xmlns;
   acRecSincrono: Result := '<' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio' + xmlns;
 end;
end;

function TProvedorISSe.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho' +
            ' versao="'  + VersaoLayOut + '"' +
            ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
            ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorISSe.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorISSe.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
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

function TProvedorISSe.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
            '<S:Body>' +
             '<EnviarLoteRps>' +
              '<xml>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</xml>' +
             '</EnviarLoteRps>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorISSe.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
 raise Exception.Create( 'Op��o n�o implementada para este provedor.' );
end;

function TProvedorISSe.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
            '<S:Body>' +
             '<ConsultarLoteRps>' +
              '<xml>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</xml>' +
             '</ConsultarLoteRps>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorISSe.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
            '<S:Body>' +
             '<ConsultarNfseRps>' +
              '<xml>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</xml>' +
             '</ConsultarNfseRps>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorISSe.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
            '<S:Body>' +
             '<consultarNfseFaixa>' +
              '<xml>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</xml>' +
             '</ConsultarNfseFaixa>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorISSe.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
            '<S:Body>' +
             '<CancelarNfse>' +
              '<xml>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</xml>' +
             '</CancelarNfse>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorISSe.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
            '<S:Body>' +
             '<GerarNfse>' +
              '<xml>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</xml>' +
             '</GerarNfse>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorISSe.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'https://isse' + NomeCidade + '.gov.br/ws/#EnviarLoteRps';
   acConsSit:     Result := '';
   acConsLote:    Result := 'https://isse' + NomeCidade + '.gov.br/ws/#ConsultarLoteRps';
   acConsNFSeRps: Result := 'https://isse' + NomeCidade + '.gov.br/ws/#ConsultarNfseRps';
   acConsNFSe:    Result := 'https://isse' + NomeCidade + '.gov.br/ws/#ConsultarNfseFaixa';
   acCancelar:    Result := 'https://isse' + NomeCidade + '.gov.br/ws/#CancelarNfse';
   acGerar:       Result := 'https://isse' + NomeCidade + '.gov.br/ws/#GerarNfse';
   acRecSincrono: Result := 'https://isse' + NomeCidade + '.gov.br/ws/#EnviarLoteRpsSincrono';
 end;
end;

function TProvedorISSe.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'return' );
   acConsSit:     Result := RetornoWS;
   acConsLote:    Result := SeparaDados( RetornoWS, 'return' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'return' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'return' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'return' );
   acGerar:       Result := SeparaDados( RetornoWS, 'return' );
   // Alterado por Joel Takei 13/06/2013
   acRecSincrono: Result := SeparaDados( RetornoWS, 'return' );
 end;
end;

function TProvedorISSe.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/nfse.xsd">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorISSe.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 if AAmbiente = 1
  then begin
   case ACodMunicipio of
    4115200: Result := '';
   else Result := '';
   end;
  end
  else Result := '';
end;

function TProvedorISSe.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
            '<S:Body>' +
             '<EnviarLoteRpsSincrono>' +
              '<xml>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</xml>' +
             '</EnviarLoteRpsSincrono>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

end.
