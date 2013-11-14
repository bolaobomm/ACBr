{$I ACBr.inc}

unit ACBrProvedorEquiplano;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorEquiplano }

 TProvedorEquiplano = class(TProvedorClass)
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

{ TProvedorEquiplano }

constructor TProvedorEquiplano.Create;
begin
 {----}
end;

function TProvedorEquiplano.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.1';
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := 'es:';
 ConfigCidade.Prefixo4      := '';
 ConfigCidade.Identificador := 'Id';

 if AAmbiente = 1
  then ConfigCidade.NameSpaceEnvelope := 'http://services.enfsws.es'
  else ConfigCidade.NameSpaceEnvelope := 'http://services.enfsws.es';

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorEquiplano.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '1.00';
 ConfigSchema.VersaoDados     := '1.00';
 ConfigSchema.VersaoXML       := '1';
 ConfigSchema.NameSpaceXML    := 'http://services.enfsws.es';
 ConfigSchema.Cabecalho       := '';
 ConfigSchema.ServicoEnviar   := 'esRecepcionarLoteRpsEnvio_v01.xsd';
 ConfigSchema.ServicoConSit   := 'esConsultarSituacaoLoteRpsEnvio_v01.xsd';
 ConfigSchema.ServicoConLot   := 'esConsultarLoteRpsEnvio_v01.xsd';
 ConfigSchema.ServicoConRps   := 'esConsultarNfsePorRpsEnvio_v01.xsd';
 ConfigSchema.ServicoConNfse  := 'esConsultarNfseEnvio_v01.xsd';
 ConfigSchema.ServicoCancelar := 'esCancelarNfseEnvio_v01.xsd';
 ConfigSchema.DefTipos        := '';

 Result := ConfigSchema;
end;

function TProvedorEquiplano.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 ConfigURL.HomNomeCidade         := '';
 ConfigURL.HomRecepcaoLoteRPS    := 'https://www.esnfs.com.br:9444/homologacaows/services/Enfs';
 ConfigURL.HomConsultaLoteRPS    := 'https://www.esnfs.com.br:9444/homologacaows/services/Enfs';
 ConfigURL.HomConsultaNFSeRPS    := 'https://www.esnfs.com.br:9444/homologacaows/services/Enfs';
 ConfigURL.HomConsultaSitLoteRPS := 'https://www.esnfs.com.br:9444/homologacaows/services/Enfs';
 ConfigURL.HomConsultaNFSe       := 'https://www.esnfs.com.br:9444/homologacaows/services/Enfs';
 ConfigURL.HomCancelaNFSe        := 'https://www.esnfs.com.br:9444/homologacaows/services/Enfs';

 ConfigURL.ProNomeCidade         := '';
 ConfigURL.ProRecepcaoLoteRPS    := 'https://www.esnfs.com.br:8444/enfsws/services/Enfs';
 ConfigURL.ProConsultaLoteRPS    := 'https://www.esnfs.com.br:8444/enfsws/services/Enfs';
 ConfigURL.ProConsultaNFSeRPS    := 'https://www.esnfs.com.br:8444/enfsws/services/Enfs';
 ConfigURL.ProConsultaSitLoteRPS := 'https://www.esnfs.com.br:8444/enfsws/services/Enfs';
 ConfigURL.ProConsultaNFSe       := 'https://www.esnfs.com.br:8444/enfsws/services/Enfs';
 ConfigURL.ProCancelaNFSe        := 'https://www.esnfs.com.br:8444/enfsws/services/Enfs';

 Result := ConfigURL;
end;

function TProvedorEquiplano.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorEquiplano.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := False;
   acConsSit:     Result := True;
   acConsLote:    Result := True;
   acConsNFSeRps: Result := True;
   acConsNFSe:    Result := False;
   acCancelar:    Result := True;
   acGerar:       Result := False;
   else           Result := False;
 end;
end;

function TProvedorEquiplano.GetValidarLote: Boolean;
begin
 Result := False;
end;

function TProvedorEquiplano.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'enviarLoteRpsEnvio' + NameSpaceDad;
   acConsSit:     Result := '<' + Prefixo3 + 'esConsultarSituacaoLoteRpsEnvio' + NameSpaceDad;
   acConsLote:    Result := '<' + Prefixo3 + 'esConsultarLoteRpsEnvio' + NameSpaceDad;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'esConsultarNfsePorRpsEnvio' + NameSpaceDad;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseEnvio' + NameSpaceDad;
   acCancelar:    Result := '<' + Prefixo3 + 'esCancelarNfseEnvio' + NameSpaceDad;
   acGerar:       Result := '';
 end;
end;

function TProvedorEquiplano.Gera_CabMsg(Prefixo2, VersaoLayOut,
  VersaoDados, NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorEquiplano.Gera_DadosSenha(CNPJ,  Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorEquiplano.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'enviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'esConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'esConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'esConsultarNfsePorRpsEnvio>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '</' + Prefixo3 + 'esCancelarNfseEnvio>';
   acGerar:       Result := '';
 end;
end;

function TProvedorEquiplano.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<esRecepcionarLoteRps xmlns="' + URLNS + '">' +
              '<nrVersaoXml>' +
                '1' +
              '</nrVersaoXml>' +
              '<xml>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</xml>' +
             '</esRecepcionarLoteRps>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorEquiplano.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<esConsultarSituacaoLoteRps xmlns="' + URLNS + '">' +
              '<nrVersaoXml>' +
                '1' +
              '</nrVersaoXml>' +
              '<xml>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</xml>' +
             '</esConsultarSituacaoLoteRps>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorEquiplano.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
             '<S:Header/>' +
             '<S:Body>' +
               '<esConsultarLoteRps xmlns="' + URLNS + '">' +
                 '<nrVersaoXml>1</nrVersaoXml>' +
                 '<xml>' +
                   '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                   StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                 '</xml>' +
               '</esConsultarLoteRps>' +
             '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorEquiplano.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result:= '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.enfsws.es">' +
             '<S:Header/>' +
             '<S:Body>' +
                '<ser:esConsultarNfsePorRps>' +
                   '<ser:nrVersaoXml>1</ser:nrVersaoXml>' +
                   '<ser:xml>' +
                     StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                   '</ser:xml>' +
                '</ser:esConsultarNfsePorRps>' +
             '</S:Body>' +
          '</S:Envelope>';
end;

function TProvedorEquiplano.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +

            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorEquiplano.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result:= '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://services.enfsws.es">' +
             '<S:Header/>' +
             '<S:Body>' +
                '<ser:esCancelarNfse>' +
                   '<ser:nrVersaoXml>1</ser:nrVersaoXml>' +
                   '<ser:xml>' +
                     StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
                   '</ser:xml>' +
                '</ser:esCancelarNfse>' +
             '</S:Body>' +
          '</S:Envelope>';
end;

function TProvedorEquiplano.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorEquiplano.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorEquiplano.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'urn:esRecepcionarLoteRps';
   acConsSit:     Result := 'urn:esConsultarSituacaoLoteRps';
   acConsLote:    Result := 'urn:esConsultarLoteRps';
   acConsNFSeRps: Result := 'urn:esConsultarNfsePorRps';
   acConsNFSe:    Result := 'urn:esConsultarNfse';
   acCancelar:    Result := 'urn:esCancelarNfse';
   acGerar:       Result := '';
 end;
end;

function TProvedorEquiplano.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'ns:return' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'ns:return' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'ns:return' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'ns:return' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'ns:return' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'ns:return' );
   acGerar:       Result := '';
 end;
 Result:= AnsiString(StringReplace(String(Result), '&#xd;', '', [rfReplaceAll]));
end;

function TProvedorEquiplano.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorEquiplano.GetLinkNFSe(ACodMunicipio,
  ANumeroNFSe: Integer; ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
