{$I ACBr.inc}

unit ACBrProvedorFreire;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorFreire }

 TProvedorFreire = class(TProvedorClass)
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

{ TProvedorFreire }

constructor TProvedorFreire.Create;
begin
 {----}
end;

function TProvedorFreire.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.1';
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := '';
 ConfigCidade.Prefixo4      := '';
 ConfigCidade.Identificador := 'Id';

 if AAmbiente = 1					//http://www.abrasf.org.br/nfse.xsd
  then ConfigCidade.NameSpaceEnvelope := 'http://nfse.abrasf.org.br'
  else ConfigCidade.NameSpaceEnvelope := 'http://nfse.abrasf.org.br';

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := False;

 Result := ConfigCidade;
end;

function TProvedorFreire.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '2.02';
 ConfigSchema.VersaoDados     := '2.02';
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

function TProvedorFreire.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 case ACodCidade of
  2919553: begin // Luís Eduardo Magalhães / BA
            ConfigURL.HomNomeCidade := 'nfselem';
            ConfigURL.ProNomeCidade := 'nfselem';
           end;
 end;

 ConfigURL.HomRecepcaoLoteRPS    := 'http://' + ConfigURL.HomNomeCidade + '.freireinformatica.com.br:5554/webrun/webservices/NFEServices.jws';
 ConfigURL.HomConsultaLoteRPS    := 'http://' + ConfigURL.HomNomeCidade + '.freireinformatica.com.br:5554/webrun/webservices/NFEServices.jws';
 ConfigURL.HomConsultaNFSeRPS    := 'http://' + ConfigURL.HomNomeCidade + '.freireinformatica.com.br:5554/webrun/webservices/NFEServices.jws';
 ConfigURL.HomConsultaSitLoteRPS := 'http://' + ConfigURL.HomNomeCidade + '.freireinformatica.com.br:5554/webrun/webservices/NFEServices.jws';
 ConfigURL.HomConsultaNFSe       := 'http://' + ConfigURL.HomNomeCidade + '.freireinformatica.com.br:5554/webrun/webservices/NFEServices.jws';
 ConfigURL.HomCancelaNFSe        := 'http://' + ConfigURL.HomNomeCidade + '.freireinformatica.com.br:5554/webrun/webservices/NFEServices.jws';
 ConfigURL.HomGerarNFSe          := 'http://' + ConfigURL.HomNomeCidade + '.freireinformatica.com.br:5554/webrun/webservices/NFEServices.jws';

 ConfigURL.ProRecepcaoLoteRPS    := 'http://' + ConfigURL.ProNomeCidade + '.freireinformatica.com.br:4554/webrun/webservices/NFEServices.jws';
 ConfigURL.ProConsultaLoteRPS    := 'http://' + ConfigURL.ProNomeCidade + '.freireinformatica.com.br:4554/webrun/webservices/NFEServices.jws';
 ConfigURL.ProConsultaNFSeRPS    := 'http://' + ConfigURL.ProNomeCidade + '.freireinformatica.com.br:4554/webrun/webservices/NFEServices.jws';
 ConfigURL.ProConsultaSitLoteRPS := 'http://' + ConfigURL.ProNomeCidade + '.freireinformatica.com.br:4554/webrun/webservices/NFEServices.jws';
 ConfigURL.ProConsultaNFSe       := 'http://' + ConfigURL.ProNomeCidade + '.freireinformatica.com.br:4554/webrun/webservices/NFEServices.jws';
 ConfigURL.ProCancelaNFSe        := 'http://' + ConfigURL.ProNomeCidade + '.freireinformatica.com.br:4554/webrun/webservices/NFEServices.jws';
 ConfigURL.ProGerarNFSe          := 'http://' + ConfigURL.ProNomeCidade + '.freireinformatica.com.br:4554/webrun/webservices/NFEServices.jws';

 Result := ConfigURL;
end;

function TProvedorFreire.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorFreire.GetAssinarXML(Acao: TnfseAcao): Boolean;
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

function TProvedorFreire.GetValidarLote: Boolean;
begin
 Result := False;
end;

function TProvedorFreire.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
var
 xmlns: String;
begin
 xmlns := ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
          ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"';

 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + xmlns + NameSpaceDad;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + xmlns + NameSpaceDad;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + xmlns + NameSpaceDad;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio' + xmlns + NameSpaceDad;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseServicoPrestadoEnvio' + xmlns + NameSpaceDad;
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + xmlns + NameSpaceDad +
                             '<' + Prefixo3 + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                 DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
   acGerar:       Result := '<' + Prefixo3 + 'GerarNfseEnvio' + xmlns + NameSpaceDad;
 end;
end;

function TProvedorFreire.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho' +
            ' versao="'  + VersaoLayOut + '"' +
            ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
            ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorFreire.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
// Result := '<wsse:Security S:mustUnderstand="1"' +
//               ' xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd"' +
//               ' xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">' +
//            '<wsse:UsernameToken wsu:Id="UsernameToken-18">' +
//             '<wsse:Username>' +
//               CNPJ +
//             '</wsse:Username>' +
//             '<wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">' +
//              Senha +
//             '</wsse:Password>' +
//            '</wsse:UsernameToken>' +
//           '</wsse:Security>';
  Result := '';
end;

function TProvedorFreire.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
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

function TProvedorFreire.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0"' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
//            '<S:Header>' +
//              DadosSenha +
//            '</S:Header>' +
            '<S:Body>' +
             '<nfse:RecepcionarLoteRpsRequest>' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</nfse:RecepcionarLoteRpsRequest>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorFreire.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
 raise Exception.Create( 'Opção não implementada para este provedor.' );
end;

function TProvedorFreire.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="ISO-8859-1"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
//            '<S:Header>' +
//              DadosSenha +
//            '</S:Header>' +
            '<S:Body>' +
             '<nfse:ConsultarLoteRpsRequest>' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</nfse:ConsultarLoteRpsRequest>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorFreire.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="ISO-8859-1"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
//            '<S:Header>' +
//              DadosSenha +
//            '</S:Header>' +
            '<S:Body>' +
             '<nfse:ConsultarNfsePorRpsRequest>' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</nfse:ConsultarNfsePorRpsRequest>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorFreire.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="ISO-8859-1"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
//            '<S:Header>' +
//              DadosSenha +
//            '</S:Header>' +
            '<S:Body>' +
             '<nfse:ConsultarNfseServicoPrestadoRequest>' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</nfse:ConsultarNfseServicoPrestadoRequest>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorFreire.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="ISO-8859-1"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="http://nfse.abrasf.org.br">' +
//            '<S:Header>' +
//              DadosSenha +
//            '</S:Header>' +
            '<S:Body>' +
             '<nfse:CancelarNfseRequest>' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</nfse:CancelarNfseRequest>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorFreire.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '<soapenv:Envelope '+
                'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
                'xmlns:xsd="http://www.w3.org/2001/XMLSchema" '+
                'xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '+
                'xmlns:def="http://www.abrasf.org.br/"> '+
          '<soapenv:Header/> '+
          '<soapenv:Body> '+
          '<def:GerarNfse soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"> '+
            '<Nfsecabecmsg xsi:type="xsd:string"> <![CDATA[' + CabMsg + ']]> </Nfsecabecmsg> '+
            '<Nfsedadosmsg xsi:type="xsd:string"> <![CDATA[' + DadosMsg + ']]> </Nfsedadosmsg> '+
          '</def:GerarNfse>'+
          '</soapenv:Body> '+
          '</soapenv:Envelope>';
end;

function TProvedorFreire.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://nfse.abrasf.org.br/Infse/RecepcionarLoteRps';
   acConsSit:     Result := '';
   acConsLote:    Result := 'http://nfse.abrasf.org.br/Infse/ConsultarLoteRps';
   acConsNFSeRps: Result := 'http://nfse.abrasf.org.br/Infse/ConsultarNfsePorRps';
   acConsNFSe:    Result := 'http://nfse.abrasf.org.br/Infse/ConsultarNfseServicoPrestado';
   acCancelar:    Result := 'http://nfse.abrasf.org.br/Infse/CancelarNfse';
   acGerar:       Result := 'http://nfse.abrasf.org.br/Infse/GerarNfse';
   acRecSincrono: Result := 'http://nfse.abrasf.org.br/Infse/RecepcionarLoteRpsSincrono';
 end;
end;

function TProvedorFreire.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'outputXML' );
   acConsSit:     Result := RetornoWS;
   acConsLote:    Result := SeparaDados( RetornoWS, 'outputXML' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'outputXML' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'outputXML' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'outputXML' );
   acGerar:       Result := RetornoWS; //SeparaDados( RetornoWS, 'outputXML' );
   acRecSincrono: Result := SeparaDados( RetornoWS, 'outputXML' );
 end;
end;

function TProvedorFreire.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="ISO-8859-1"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/nfse.xsd">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorFreire.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
//
 if AAmbiente = 1
  then begin
   case ACodMunicipio of
    2919553: Result := 'http://nfselem.freireinformatica.ba.gov.br/webrun/open.do?sys=NFE&action=openform&formID='+
					'{1733636A-6A4B-46A6-BD46-193A27C60B03}&align=0&mode=-1&goto=-1&filter=NFE_NFSE.NFS_COD_VERIFICACAO=' +
                    ACodVerificacao;
    else Result := '';
   end;
  end
  else Result := '';
end;

function TProvedorFreire.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := CabMsg +#13#10+
           '<?xml version="1.0" encoding="ISO-8859-1"?>' + #13#10+
           DadosMsg;
end;

end.
