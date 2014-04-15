{$I ACBr.inc}

unit ACBrProvedorActcon;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorActcon }

 TProvedorActcon = class(TProvedorClass)
  protected
   { protected }
  private
   { private }
  public
   { public }
   DescAmbiente:String;
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

{ TProvedorActcon }

constructor TProvedorActcon.Create;
begin
 {----}
end;

function TProvedorActcon.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
 NomeCidade:String;
begin
 case ACodCidade of
  3131307: NomeCidade:='ipatinga';
 end;

 ConfigCidade.VersaoSoap    := '1.2';
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := '';
 ConfigCidade.Prefixo4      := '';
 ConfigCidade.Identificador := 'Id';

 if AAmbiente = 1  then  DescAmbiente:='nfseserv' else DescAmbiente:='homologacao';
 ConfigCidade.NameSpaceEnvelope:='http://nfe.'+NomeCidade+'.mg.gov.br/'+DescAmbiente+'/webservice/nfse.wsdl';
 ConfigCidade.AssinaRPS  := false;
 ConfigCidade.AssinaLote := true;

 Result := ConfigCidade;
end;

function TProvedorActcon.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
 NomeCidade:String;
begin
 case ACodCidade of
  3131307: NomeCidade:='ipatinga';
 end;
ConfigSchema.VersaoCabecalho := '1.00';
ConfigSchema.VersaoDados     := '1.00';
ConfigSchema.VersaoXML       := '1';
ConfigSchema.NameSpaceXML    := 'http://nfe.'+NomeCidade+'.mg.gov.br/'+DescAmbiente+'/schema/';
ConfigSchema.Cabecalho       := 'nfse_v01.xsd';
ConfigSchema.ServicoEnviar   := 'nfse_v01.xsd';
ConfigSchema.ServicoConSit   := 'nfse_v01.xsd';
ConfigSchema.ServicoConLot   := 'nfse_v01.xsd';
ConfigSchema.ServicoConRps   := 'nfse_v01.xsd';
ConfigSchema.ServicoConNfse  := 'nfse_v01.xsd';
ConfigSchema.ServicoCancelar := 'nfse_v01.xsd';
ConfigSchema.ServicoEnviarSincrono:='nfse_v01.xsd';
ConfigSchema.ServicoGerar    := '';
ConfigSchema.DefTipos        := '';
Result := ConfigSchema;
end;

function TProvedorActcon.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 case ACodCidade of
  3131307: begin // Ipatinga
            ConfigURL.HomNomeCidade := 'ipatinga';
            ConfigURL.ProNomeCidade := 'ipatinga';
           end;
 end;

 ConfigURL.HomRecepcaoLoteRPS    := 'http://nfe.'+ConfigURL.HomNomeCidade+'.mg.gov.br/homologacao/webservice/servicos';
 ConfigURL.HomConsultaLoteRPS    := 'http://nfe.'+ConfigURL.HomNomeCidade+'.mg.gov.br/homologacao/webservice/servicos';
 ConfigURL.HomConsultaNFSeRPS    := 'http://nfe.'+ConfigURL.HomNomeCidade+'.mg.gov.br/homologacao/webservice/servicos';
 ConfigURL.HomConsultaSitLoteRPS := 'http://nfe.'+ConfigURL.HomNomeCidade+'.mg.gov.br/homologacao/webservice/servicos';
 ConfigURL.HomConsultaNFSe       := 'http://nfe.'+ConfigURL.HomNomeCidade+'.mg.gov.br/homologacao/webservice/servicos';
 ConfigURL.HomCancelaNFSe        := 'http://nfe.'+ConfigURL.HomNomeCidade+'.mg.gov.br/homologacao/webservice/servicos';
 ConfigURL.HomRecepcaoSincrono   := 'http://nfe.'+ConfigURL.HomNomeCidade+'.mg.gov.br/homologacao/webservice/servicos';

 ConfigURL.ProRecepcaoLoteRPS    := 'http://nfe.'+ConfigURL.ProNomeCidade+'.mg.gov.br/nfseserv/webservice/servicos';
 ConfigURL.ProConsultaLoteRPS    := 'http://nfe.'+ConfigURL.ProNomeCidade+'.mg.gov.br/nfseserv/webservice/servicos';
 ConfigURL.ProConsultaNFSeRPS    := 'http://nfe.'+ConfigURL.ProNomeCidade+'.mg.gov.br/nfseserv/webservice/servicos';
 ConfigURL.ProConsultaSitLoteRPS := 'http://nfe.'+ConfigURL.ProNomeCidade+'.mg.gov.br/s/webservice/servicos';
 ConfigURL.ProConsultaNFSe       := 'http://nfe.'+ConfigURL.ProNomeCidade+'.mg.gov.br/nfseserv/webservice/servicos';
 ConfigURL.ProCancelaNFSe        := 'http://nfe.'+ConfigURL.ProNomeCidade+'.mg.gov.br/nfseserv/webservice/servicos';
 ConfigURL.ProRecepcaoSincrono   := 'http://nfe.'+ConfigURL.ProNomeCidade+'.mg.gov.br/nfseserv/webservice/servicos';

 Result := ConfigURL;
end;

function TProvedorActcon.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorActcon.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := False;
   acConsSit:     Result := False;
   acConsLote:    Result := False;
   acConsNFSeRps: Result := False;
   acConsNFSe:    Result := False;
   acCancelar:    Result := False;
   acGerar:       Result := False;
   acRecSincrono: result := false;
   else           Result := False;
 end;
end;

function TProvedorActcon.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorActcon.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
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
   acRecSincrono: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + NameSpaceDad;
 end;
end;

function TProvedorActcon.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorActcon.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorActcon.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
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
   acRecSincrono: result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
 end;
end;

function TProvedorActcon.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="'+URLNs+'" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
            '<S:Header>' +
              DadosSenha +
            '</S:Header>' +
            '<S:Body>' +
             '<nfse:RecepcionarLoteRpsSincronoRequest xsi:type="nfse:RecepcionarLoteRpsSincrono">' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</nfse:RecepcionarLoteRpsSincronoRequest>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorActcon.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="'+URLNs+'" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
            '<S:Header>' +
              DadosSenha +
            '</S:Header>' +
            '<S:Body>' +
             '<nfse:ConsultarLoteRpsRequest xsi:type="nfse:ConsultarLoteRps">' +
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

function TProvedorActcon.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="'+URLNs+'" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
            '<S:Header>' +
              DadosSenha +
            '</S:Header>' +
            '<S:Body>' +
             '<nfse:ConsultarLoteRpsRequest xsi:type="nfse:ConsultarLoteRps">' +
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

function TProvedorActcon.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="'+URLNs+'" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
            '<S:Header>' +
              DadosSenha +
            '</S:Header>' +
            '<S:Body>' +
             '<nfse:ConsultarNfsePorRpsRequest xsi:type="nfse:ConsultarNfsePorRps">' +
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

function TProvedorActcon.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarNfse xmlns="' + URLNS + '/">' +
              '<cabec>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</cabec>' +
              '<msg>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</msg>' +
             '</ConsultarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorActcon.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="'+URLNs+'" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
            '<S:Header>' +
              DadosSenha +
            '</S:Header>' +
            '<S:Body>' +
             '<nfse:CancelarNfseRequest xsi:type="nfse:CancelarNfse">' +
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

function TProvedorActcon.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<GerarNfse xmlns="' + URLNS + '/">' +
              '<cabec>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</cabec>' +
              '<msg>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</msg>' +
             '</GerarNfse>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorActcon.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:nfse="'+URLNs+'" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
            '<S:Header>' +
              DadosSenha +
            '</S:Header>' +
            '<S:Body>' +
             '<nfse:RecepcionarLoteRpsSincronoRequest xsi:type="nfse:RecepcionarLoteRpsSincrono">' +
              '<nfseCabecMsg>' +
               '<![CDATA[' + CabMsg + ']]>' +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
               '<![CDATA[' + DadosMsg + ']]>' +
              '</nfseDadosMsg>' +
             '</nfse:RecepcionarLoteRpsSincronoRequest>' +
            '</S:Body>' +
           '</S:Envelope>';

end;

function TProvedorActcon.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
case Acao of
   acRecepcionar: Result := 'RecepcionarLoteRpsRequest';
   acConsSit:     Result := 'ConsultarLoteRpsRequest';
   acConsLote:    Result := 'ConsultarLoteRpsRequest';
   acConsNFSeRps: Result := 'ConsultarNfsePorRpsRequest';
   acConsNFSe:    Result := 'http://nfse.abrasf.org.br/Infse/ConsultarNfseServicoPrestado';
   acCancelar:    Result := 'CancelarNfseRequest';
   acGerar:       Result := 'http://nfse.abrasf.org.br/Infse/GerarNfse';
   acRecSincrono: Result := 'RecepcionarLoteRpsRequest';
 end;
end;

function TProvedorActcon.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
result:= SeparaDados( RetornoWS, 'outputXML' );
{ case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'EnviarLoteRpsSincronoResposta' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'ConsultarLoteRpsResposta' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'ConsultarLoteRpsResposta' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'ConsultarNfseRpsResposta' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'ConsultarNfsePorRps' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'CancelarNfseResposta' );
   acGerar:       Result := SeparaDados( RetornoWS, 'GerarNfseResult' );
   acRecSincrono: result:= SeparaDados( RetornoWS, 'RecepcionarLoteRpsSincronoResult' );
 end;}
end;

function TProvedorActcon.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/nfse">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorActcon.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.