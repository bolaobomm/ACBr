{$I ACBr.inc}

unit ACBrProvedorSpeedGov;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorSpeedGov }

 TProvedorSpeedGov = class(TProvedorClass)
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

{ TProvedorSpeedGov }

constructor TProvedorSpeedGov.Create;
begin
 {----}
end;

function TProvedorSpeedGov.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.1';
 ConfigCidade.Prefixo2      := 'p:';
 ConfigCidade.Prefixo3      := 'p:';
 ConfigCidade.Prefixo4      := 'p1:';
 ConfigCidade.Identificador := 'Id';

 if AAmbiente = 1
  then ConfigCidade.NameSpaceEnvelope := 'http://ws.speedgov.com.br'
  else ConfigCidade.NameSpaceEnvelope := 'http://ws.speedgov.com.br';

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := False;

 Result := ConfigCidade;
end;

function TProvedorSpeedGov.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho       := '1';
 ConfigSchema.VersaoDados           := '1';
 ConfigSchema.VersaoXML             := '1';
 ConfigSchema.NameSpaceXML          := 'http://ws.speedgov.com.br/';
 ConfigSchema.Cabecalho             := 'cabecalho_v1.xsd';
 ConfigSchema.ServicoEnviar         := 'enviar_lote_rps_envio_v1.xsd';
 ConfigSchema.ServicoConSit         := 'consultar_situacao_lote_rps_envio_v1.xsd';
 ConfigSchema.ServicoConLot         := 'consultar_lote_rps_envio_v1.xsd';
 ConfigSchema.ServicoConRps         := 'consultar_nfse_rps_envio_v1.xsd';
 ConfigSchema.ServicoConNfse        := 'consultar_nfse_envio_v1.xsd';
 ConfigSchema.ServicoCancelar       := 'cancelar_nfse_envio_v1.xsd';
 ConfigSchema.ServicoGerar          := '';
 ConfigSchema.ServicoEnviarSincrono := '';
 ConfigSchema.DefTipos              := 'tipos_v1.xsd';

 Result := ConfigSchema;
end;

function TProvedorSpeedGov.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
 URL: String;
begin
 case ACodCidade of
  2301000: begin // Aquiraz/CE
            ConfigURL.HomNomeCidade := 'aqz';
            ConfigURL.ProNomeCidade := 'aqz';
           end;
  2611101: begin // Petrolina
            ConfigURL.HomNomeCidade := 'pet';
            ConfigURL.ProNomeCidade := 'pet';
           end;
 end;

 ConfigURL.HomRecepcaoLoteRPS    := 'http://speedgov.com.br/wsmod/Nfes';
 ConfigURL.HomConsultaLoteRPS    := 'http://speedgov.com.br/wsmod/Nfes';
 ConfigURL.HomConsultaNFSeRPS    := 'http://speedgov.com.br/wsmod/Nfes';
 ConfigURL.HomConsultaSitLoteRPS := 'http://speedgov.com.br/wsmod/Nfes';
 ConfigURL.HomConsultaNFSe       := 'http://speedgov.com.br/wsmod/Nfes';
 ConfigURL.HomCancelaNFSe        := 'http://speedgov.com.br/wsmod/Nfes';
 ConfigURL.HomGerarNFSe          := 'http://speedgov.com.br/wsmod/Nfes';
 ConfigURL.HomRecepcaoSincrono   := 'http://speedgov.com.br/wsmod/Nfes';

 ConfigURL.ProRecepcaoLoteRPS    := 'http://www.speedgov.com.br/ws' + ConfigURL.ProNomeCidade + '/Nfes';
 ConfigURL.ProConsultaLoteRPS    := 'http://www.speedgov.com.br/ws' + ConfigURL.ProNomeCidade + '/Nfes';
 ConfigURL.ProConsultaNFSeRPS    := 'http://www.speedgov.com.br/ws' + ConfigURL.ProNomeCidade + '/Nfes';
 ConfigURL.ProConsultaSitLoteRPS := 'http://www.speedgov.com.br/ws' + ConfigURL.ProNomeCidade + '/Nfes';
 ConfigURL.ProConsultaNFSe       := 'http://www.speedgov.com.br/ws' + ConfigURL.ProNomeCidade + '/Nfes';
 ConfigURL.ProCancelaNFSe        := 'http://www.speedgov.com.br/ws' + ConfigURL.ProNomeCidade + '/Nfes';
 ConfigURL.ProGerarNFSe          := 'http://www.speedgov.com.br/ws' + ConfigURL.ProNomeCidade + '/Nfes';
 ConfigURL.ProRecepcaoSincrono   := 'http://www.speedgov.com.br/ws' + ConfigURL.ProNomeCidade + '/Nfes';

 Result := ConfigURL;
end;

function TProvedorSpeedGov.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorSpeedGov.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
  Result := false;
 case Acao of
   acRecepcionar: Result := False;
   acConsSit:     Result := False;
   acConsLote:    Result := False;
   acConsNFSeRps: Result := False;
   acConsNFSe:    Result := False;
   acCancelar:    Result := False;
   acGerar:       Result := False;
   acRecSincrono: Result := False;
 end;
end;

function TProvedorSpeedGov.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorSpeedGov.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
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
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + xmlns +
                             '<' + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento>';
   acGerar:       Result := '<' + Prefixo3 + 'GerarNfseEnvio' + xmlns;
   acRecSincrono: Result := '<' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio' + xmlns;
 end;
end;

function TProvedorSpeedGov.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<p:cabecalho versao="1"' +
            ' xmlns:ds="http://www.w3.org/2000/09/xmldsig#"' +
            ' xmlns:p="http://ws.speedgov.com.br/cabecalho_v1.xsd"' +
            ' xmlns:p1="http://ws.speedgov.com.br/tipos_v1.xsd"' +
            ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
            ' xsi:schemaLocation="http://ws.speedgov.com.br/cabecalho_v1.xsd cabecalho_v1.xsd ">' +
            '<versaoDados>1</versaoDados>' +
           '</p:cabecalho>';
end;

function TProvedorSpeedGov.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorSpeedGov.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRpsEnvio>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseServicoPrestadoEnvio>';
   acCancelar:    Result := '</' + 'Pedido>' +
                            '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '</' + Prefixo3 + 'GerarNfseEnvio>';
   acRecSincrono: Result := '</' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio>';
 end;
end;

function TProvedorSpeedGov.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 CabMsg := '<?xml version="1.0" encoding="UTF-8" ?>' + CabMsg;
 DadosMsg := '<?xml version="1.0" encoding="UTF-8" ?>' + DadosMsg;

 CabMsg :=StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]);
 CabMsg :=StringReplace(CabMsg, '>', '&gt;', [rfReplaceAll]);

 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"' +
                            ' xmlns:nfse="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd">' +
            '<soapenv:Header />' +
            '<soapenv:Body>' +
             '<nfse:RecepcionarLoteRps>' +
              '<header>' + CabMsg + '</header>' +
              '<parameters>' + DadosMsg + '</parameters>' +
             '</nfse:RecepcionarLoteRps>' +
            '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorSpeedGov.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 CabMsg := '<?xml version="1.0" encoding="UTF-8" ?>' + CabMsg;
 DadosMsg := '<?xml version="1.0" encoding="UTF-8" ?>' + DadosMsg;

 CabMsg :=StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]);
 CabMsg :=StringReplace(CabMsg, '>', '&gt;', [rfReplaceAll]);

 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"' +
                            ' xmlns:nfse="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd">' +
            '<soapenv:Header />' +
            '<soapenv:Body>' +
             '<nfse:ConsultarSituacaoLoteRps>' +
              '<header>' + CabMsg + '</header>' +
              '<parameters>' + DadosMsg + '</parameters>' +
             '</nfse:ConsultarSituacaoLoteRps>' +
            '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorSpeedGov.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 CabMsg := '<?xml version="1.0" encoding="UTF-8" ?>' + CabMsg;
 DadosMsg := '<?xml version="1.0" encoding="UTF-8" ?>' + DadosMsg;

 CabMsg :=StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]);
 CabMsg :=StringReplace(CabMsg, '>', '&gt;', [rfReplaceAll]);

 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"' +
                            ' xmlns:nfse="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd">' +
            '<soapenv:Header />' +
            '<soapenv:Body>' +
             '<nfse:ConsultarLoteRps>' +
              '<header>' + CabMsg + '</header>' +
              '<parameters>' + DadosMsg + '</parameters>' +
             '</nfse:ConsultarLoteRps>' +
            '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorSpeedGov.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 CabMsg := '<?xml version="1.0" encoding="UTF-8" ?>' + CabMsg;
 DadosMsg := '<?xml version="1.0" encoding="UTF-8" ?>' + DadosMsg;

 CabMsg :=StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]);
 CabMsg :=StringReplace(CabMsg, '>', '&gt;', [rfReplaceAll]);

 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"' +
                            ' xmlns:nfse="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd">' +
            '<soapenv:Header />' +
            '<soapenv:Body>' +
             '<nfse:ConsultarNfsePorRps>' +
              '<header>' + CabMsg + '</header>' +
              '<parameters>' + DadosMsg + '</parameters>' +
             '</nfse:ConsultarNfsePorRps>' +
            '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorSpeedGov.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 CabMsg := '<?xml version="1.0" encoding="UTF-8" ?>' + CabMsg;
 DadosMsg := '<?xml version="1.0" encoding="UTF-8" ?>' + DadosMsg;

 CabMsg :=StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]);
 CabMsg :=StringReplace(CabMsg, '>', '&gt;', [rfReplaceAll]);

 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"' +
                            ' xmlns:nfse="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd">' +
            '<soapenv:Header />' +
            '<soapenv:Body>' +
             '<nfse:ConsultarNfse>' +
              '<header>' + CabMsg + '</header>' +
              '<parameters>' + DadosMsg + '</parameters>' +
             '</nfse:ConsultarNfse>' +
            '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorSpeedGov.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 CabMsg := '<?xml version="1.0" encoding="UTF-8" ?>' + CabMsg;
 DadosMsg := '<?xml version="1.0" encoding="UTF-8" ?>' + DadosMsg;

 CabMsg :=StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]);
 CabMsg :=StringReplace(CabMsg, '>', '&gt;', [rfReplaceAll]);

 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"' +
                            ' xmlns:nfse="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd">' +
            '<soapenv:Header />' +
            '<soapenv:Body>' +
             '<nfse:CancelarNfse>' +
              '<header>' + CabMsg + '</header>' +
              '<parameters>' + DadosMsg + '</parameters>' +
             '</nfse:CancelarNfse>' +
            '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorSpeedGov.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedorSpeedGov.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedorSpeedGov.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := '';
   acConsSit:     Result := '';
   acConsLote:    Result := '';
   acConsNFSeRps: Result := '';
   acConsNFSe:    Result := '';
   acCancelar:    Result := '';
   acGerar:       Result := '';
   acRecSincrono: Result := '';
 end;;
end;

function TProvedorSpeedGov.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'return' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'return' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'return' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'return' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'return' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'return' );
   acGerar:       Result := SeparaDados( RetornoWS, 'return' );
   acRecSincrono: Result := SeparaDados( RetornoWS, 'return' );
 end;
end;

function TProvedorSpeedGov.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/nfse.xsd">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorSpeedGov.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
