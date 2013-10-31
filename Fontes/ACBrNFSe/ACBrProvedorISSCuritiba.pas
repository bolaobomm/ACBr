{$I ACBr.inc}

unit ACBrProvedorIssCuritiba;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorIssCuritiba }

 TProvedorIssCuritiba = class(TProvedorClass)
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

{ TProvedorIssCuritiba }

constructor TProvedorIssCuritiba.Create;
begin
 {----}
end;

function TProvedorIssCuritiba.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.2';
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := '';
 ConfigCidade.Prefixo4      := '';
 ConfigCidade.Identificador := 'id';

// if AAmbiente = 1
//  then ConfigCidade.NameSpaceEnvelope := 'https://isscuritiba.curitiba.pr.gov.br'
//  else ConfigCidade.NameSpaceEnvelope := 'http://200.189.192.82/pilotonota_iss/';

 ConfigCidade.NameSpaceEnvelope := 'http://www.e-governeapps2.com.br/';

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorIssCuritiba.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '';
 ConfigSchema.VersaoDados     := '';
 ConfigSchema.VersaoXML       := '1';
// ConfigSchema.NameSpaceXML    := 'http://www.e-governeapps2.com.br/';
 ConfigSchema.NameSpaceXML    := 'http://isscuritiba.curitiba.pr.gov.br/iss/';
 ConfigSchema.Cabecalho       := 'nfse.xsd';
 ConfigSchema.ServicoEnviar   := 'nfse.xsd';
 ConfigSchema.ServicoConSit   := 'nfse.xsd';
 ConfigSchema.ServicoConLot   := 'nfse.xsd';
 ConfigSchema.ServicoConRps   := 'nfse.xsd';
 ConfigSchema.ServicoConNfse  := 'nfse.xsd';
 ConfigSchema.ServicoCancelar := 'nfse.xsd';
 ConfigSchema.DefTipos        := '';

 Result := ConfigSchema;
end;

function TProvedorIssCuritiba.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 ConfigURL.HomNomeCidade         := '';
 (*
 ConfigURL.HomRecepcaoLoteRPS    := 'http://200.189.192.82/pilotonota_webservice/nfsews.asmx';
 ConfigURL.HomConsultaLoteRPS    := 'http://200.189.192.82/pilotonota_webservice/nfsews.asmx';
 ConfigURL.HomConsultaNFSeRPS    := 'http://200.189.192.82/pilotonota_webservice/nfsews.asmx';
 ConfigURL.HomConsultaSitLoteRPS := 'http://200.189.192.82/pilotonota_webservice/nfsews.asmx';
 ConfigURL.HomConsultaNFSe       := 'http://200.189.192.82/pilotonota_webservice/nfsews.asmx';
 ConfigURL.HomCancelaNFSe        := 'http://200.189.192.82/pilotonota_webservice/nfsews.asmx';
 *)
 ConfigURL.HomRecepcaoLoteRPS    := 'https://pilotoisscuritiba.curitiba.pr.gov.br/nfse_ws/NfseWs.asmx';
 ConfigURL.HomConsultaLoteRPS    := 'https://pilotoisscuritiba.curitiba.pr.gov.br/nfse_ws/NfseWs.asmx';
 ConfigURL.HomConsultaNFSeRPS    := 'https://pilotoisscuritiba.curitiba.pr.gov.br/nfse_ws/NfseWs.asmx';
 ConfigURL.HomConsultaSitLoteRPS := 'https://pilotoisscuritiba.curitiba.pr.gov.br/nfse_ws/NfseWs.asmx';
 ConfigURL.HomConsultaNFSe       := 'https://pilotoisscuritiba.curitiba.pr.gov.br/nfse_ws/NfseWs.asmx';
 ConfigURL.HomCancelaNFSe        := 'https://pilotoisscuritiba.curitiba.pr.gov.br/nfse_ws/NfseWs.asmx';

 ConfigURL.ProNomeCidade         := '';
 ConfigURL.ProRecepcaoLoteRPS    := 'https://isscuritiba.curitiba.pr.gov.br/Iss.NfseWebService/Nfsews.asmx';
 ConfigURL.ProConsultaLoteRPS    := 'https://isscuritiba.curitiba.pr.gov.br/Iss.NfseWebService/Nfsews.asmx';
 ConfigURL.ProConsultaNFSeRPS    := 'https://isscuritiba.curitiba.pr.gov.br/Iss.NfseWebService/Nfsews.asmx';
 ConfigURL.ProConsultaSitLoteRPS := 'https://isscuritiba.curitiba.pr.gov.br/Iss.NfseWebService/Nfsews.asmx';
 ConfigURL.ProConsultaNFSe       := 'https://isscuritiba.curitiba.pr.gov.br/Iss.NfseWebService/Nfsews.asmx';
 ConfigURL.ProCancelaNFSe        := 'https://isscuritiba.curitiba.pr.gov.br/Iss.NfseWebService/Nfsews.asmx';

 Result := ConfigURL;
end;

function TProvedorIssCuritiba.GetURI(URI: String): String;
begin
 Result := '';
end;

function TProvedorIssCuritiba.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := True;
   acConsSit:     Result := True;
   acConsLote:    Result := True;
   acConsNFSeRps: Result := True;
   acConsNFSe:    Result := True;
   acCancelar:    Result := True;
   acGerar:       Result := False;
   else           Result := False;
 end;
end;

function TProvedorIssCuritiba.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorIssCuritiba.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
var
 xmlns: String;
begin
 xmlns := NameSpaceDad {+
          ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
          ' xsi:schemaLocation="http://isscuritiba.curitiba.pr.gov.br/iss/nfse.xsd">'};

 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + xmlns;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + xmlns;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + xmlns;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio' + xmlns;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseEnvio' + xmlns;
   acCancelar:    Result := '<CancelarNfseEnvio' + xmlns + '<Pedido>'; // Alterado por Akai - L. Massao Aihara 31/10/2013
   acGerar:       Result := '';
 end;
end;

function TProvedorIssCuritiba.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '';
           {'<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';}
end;

function TProvedorIssCuritiba.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorIssCuritiba.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRpsEnvio>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '</Pedido></CancelarNfseEnvio>'; // Alterado por Akai - L. Massao Aihara 31/10/2013
   acGerar:       Result := '';
 end;
end;

function TProvedorIssCuritiba.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                           ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                           ' xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">' +
            '<soap12:Body>' +
             '<RecepcionarLoteRps xmlns="http://www.e-governeapps2.com.br/">' +
               DadosMsg +
             '</RecepcionarLoteRps>' +
            '</soap12:Body>' +
           '</soap12:Envelope>';
end;

function TProvedorIssCuritiba.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 rESULT := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                           ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                           ' xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">' +
           '<soap12:Body>' +
            '<ConsultarSituacaoLoteRps xmlns="http://www.e-governeapps2.com.br/">' +
              DadosMsg +
            '</ConsultarSituacaoLoteRps>' +
           '</soap12:Body>' +
          '</soap12:Envelope>';
end;

function TProvedorIssCuritiba.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                           ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                           ' xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">' +
            '<soap12:Body>' +
             '<ConsultarLoteRps xmlns="http://www.e-governeapps2.com.br/">' +
               DadosMsg +
             '</ConsultarLoteRps>' +
            '</soap12:Body>' +
           '</soap12:Envelope>';
end;

function TProvedorIssCuritiba.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                           ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                           ' xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">' +
            '<soap12:Body>' +
             '<ConsultarNfsePorRps xmlns="http://www.e-governeapps2.com.br/">' +
               DadosMsg +
             '</ConsultarNfsePorRps>' +
            '</soap12:Body>' +
           '</soap12:Envelope>';
end;

function TProvedorIssCuritiba.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                           ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                           ' xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">' +
           '<soap12:Body>' +
            '<ConsultarNfse xmlns="http://www.e-governeapps2.com.br/">' +
              DadosMsg +
            '</ConsultarNfse>'+
           '</soap12:Body>' +
          '</soap12:Envelope>';
end;

function TProvedorIssCuritiba.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                           ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                           ' xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">' +
            '<soap12:Body>' +
             '<CancelarNfse xmlns="http://www.e-governeapps2.com.br/">' +
               DadosMsg +
             '</CancelarNfse>' +
            '</soap12:Body>' +
           '</soap12:Envelope>';
end;

function TProvedorIssCuritiba.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Opção não implementada para este provedor.' );
end;

function TProvedorIssCuritiba.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://www.e-governeapps2.com.br/RecepcionarLoteRps';
   acConsSit:     Result := 'http://www.e-governeapps2.com.br/ConsultarSituacaoLoteRps';
   acConsLote:    Result := 'http://www.e-governeapps2.com.br/ConsultarLoteRps';
   acConsNFSeRps: Result := 'http://www.e-governeapps2.com.br/ConsultarNfsePorRps';
   acConsNFSe:    Result := 'http://www.e-governeapps2.com.br/ConsultarNfse';
   acCancelar:    Result := 'http://www.e-governeapps2.com.br/CancelarNfse';
   acGerar:       Result := '';
   acRecSincrono: Result := '';
 end;
end;

function TProvedorIssCuritiba.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 // Alterado por Akai - L. Massao Aihara 31/10/2013
 // para manter as chaves...
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'RecepcionarLoteRpsResult', True );
   acConsSit:     Result := SeparaDados( RetornoWS, 'ConsultarSituacaoLoteRpsResult', True );
   acConsLote:    Result := SeparaDados( RetornoWS, 'ConsultarLoteRpsResult', True );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'ConsultarNfsePorRpsResult', True );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'ConsultarNfseResult', True );
   acCancelar:    Result := SeparaDados( RetornoWS, 'CancelarNfseResult', True );
   acGerar:       Result := '';
   acRecSincrono: Result := '';
 end;
end;

function TProvedorIssCuritiba.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<CompNfse xmlns:ns4="http://www.e-governeapps2.com.br/nfse.xsd">' +
            RetNFSe +
           '</CompNfse>';
end;

function TProvedorIssCuritiba.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := 'https://isscuritiba.curitiba.pr.gov.br/portalnfse/Default.aspx?doc=' +
           AInscricaoM + '&num=' + IntToStr(ANumeroNFSe) + '&cod=' + ACodVerificacao;
end;

function TProvedorIssCuritiba.GeraEnvelopeRecepcionarSincrono(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

end.
