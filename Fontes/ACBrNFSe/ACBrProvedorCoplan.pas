{$I ACBr.inc}

unit ACBrProvedorCoplan;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorCoplan }

 TProvedorCoplan = class(TProvedorClass)
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

{ TProvedorCoplan }

constructor TProvedorCoplan.Create;
begin
 {----}
end;

function TProvedorCoplan.GetConfigCidade(ACodCidade,
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

 ConfigCidade.AssinaRPS  := True;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorCoplan.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '2.00';
 ConfigSchema.VersaoDados     := '2.00';
 ConfigSchema.VersaoXML       := '2';
 ConfigSchema.NameSpaceXML    := 'http://www.abrasf.org.br/';
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

function TProvedorCoplan.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 case ACodCidade of
  5102678: begin // Campo Verde/MT
            ConfigURL.HomNomeCidade := 'campoverde';
            ConfigURL.ProNomeCidade := 'campoverde';
           end;
  5103205: begin // Colider/MT
            ConfigURL.HomNomeCidade := 'colider';
            ConfigURL.ProNomeCidade := 'colider';
           end;
  5104104: begin // Guarantã Do Norte/MT
            ConfigURL.HomNomeCidade := 'guarantadonorte';
            ConfigURL.ProNomeCidade := 'guarantadonorte';
           end;
  5104542 : begin // Itanhanga/MT
            ConfigURL.HomNomeCidade := 'itanhanga';
            ConfigURL.ProNomeCidade := 'itanhanga';
           end;
  5105606 : begin // Matupá/MT
            ConfigURL.HomNomeCidade := 'matupa';
            ConfigURL.ProNomeCidade := 'matupa';
           end;
  5106208 : begin // Nova Brasilandia/MT
            ConfigURL.HomNomeCidade := 'novabrasilandia';
            ConfigURL.ProNomeCidade := 'novabrasilandia';
           end;
  5106307 : begin // Paranatinga/MT
            ConfigURL.HomNomeCidade := 'paranatinga';
            ConfigURL.ProNomeCidade := 'paranatinga';
           end;
  5106455 : begin // Planalto da Serra/MT
            ConfigURL.HomNomeCidade := 'planaltodaserra';
            ConfigURL.ProNomeCidade := 'planaltodaserra';
           end;
  5108006 : begin // Tapurah/MT
            ConfigURL.HomNomeCidade := 'tapurah';
            ConfigURL.ProNomeCidade := 'tapurah';
           end;
 end;

 ConfigURL.HomRecepcaoLoteRPS    := 'https://' + ConfigURL.HomNomeCidade + '.issqn.srv.br/webservice/NfseWSService';
 ConfigURL.HomConsultaLoteRPS    := 'https://' + ConfigURL.HomNomeCidade + '.issqn.srv.br/webservice/NfseWSService';
 ConfigURL.HomConsultaNFSeRPS    := 'https://' + ConfigURL.HomNomeCidade + '.issqn.srv.br/webservice/NfseWSService';
 ConfigURL.HomConsultaSitLoteRPS := 'https://' + ConfigURL.HomNomeCidade + '.issqn.srv.br/webservice/NfseWSService';
 ConfigURL.HomConsultaNFSe       := 'https://' + ConfigURL.HomNomeCidade + '.issqn.srv.br/webservice/NfseWSService';
 ConfigURL.HomCancelaNFSe        := 'https://' + ConfigURL.HomNomeCidade + '.issqn.srv.br/webservice/NfseWSService';
 ConfigURL.HomGerarNFSe          := 'https://' + ConfigURL.HomNomeCidade + '.issqn.srv.br/webservice/NfseWSService';

 ConfigURL.ProRecepcaoLoteRPS    := 'https://' + ConfigURL.ProNomeCidade + '.issqn.srv.br/webservice/NfseWSService';
 ConfigURL.ProConsultaLoteRPS    := 'https://' + ConfigURL.ProNomeCidade + '.issqn.srv.br/webservice/NfseWSService';
 ConfigURL.ProConsultaNFSeRPS    := 'https://' + ConfigURL.ProNomeCidade + '.issqn.srv.br/webservice/NfseWSService';
 ConfigURL.ProConsultaSitLoteRPS := 'https://' + ConfigURL.ProNomeCidade + '.issqn.srv.br/webservice/NfseWSService';
 ConfigURL.ProConsultaNFSe       := 'https://' + ConfigURL.ProNomeCidade + '.issqn.srv.br/webservice/NfseWSService';
 ConfigURL.ProCancelaNFSe        := 'https://' + ConfigURL.ProNomeCidade + '.issqn.srv.br/webservice/NfseWSService';
 ConfigURL.ProGerarNFSe          := 'https://' + ConfigURL.ProNomeCidade + '.issqn.srv.br/webservice/NfseWSService';

 Result := ConfigURL;
end;

function TProvedorCoplan.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorCoplan.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := True;
   acConsSit:     Result := True;
   acConsLote:    Result := True;
   acConsNFSeRps: Result := True;
   acConsNFSe:    Result := True;
   acCancelar:    Result := True;
   acGerar:       Result := True;
   else           Result := False;
 end;
end;

function TProvedorCoplan.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorCoplan.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
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
 end;
end;

function TProvedorCoplan.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorCoplan.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorCoplan.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
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
 end;
end;

function TProvedorCoplan.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ns2:RecepcionarLoteRpsRequest xmlns:ns2="' + URLNS + '">' +
              '<nfseCabecMsg>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                 StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseDadosMsg>' +
             '</ns2:RecepcionarLoteRpsRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorCoplan.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ns2:ConsultarSituacaoLoteRpsRequest xmlns:ns2="' + URLNS + '">' +
              '<nfseCabecMsg>' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseDadosMsg>' +
             '</ns2:ConsultarSituacaoLoteRpsRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorCoplan.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ns2:ConsultarLoteRpsRequest xmlns:ns2="' + URLNS + '">' +
              '<nfseCabecMsg>' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseDadosMsg>' +
             '</ns2:ConsultarLoteRpsRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorCoplan.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ns2:ConsultarNfsePorRpsRequest xmlns:ns2="' + URLNS + '">' +
              '<nfseCabecMsg>' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseDadosMsg>' +
             '</ns2:ConsultarNfsePorRpsRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorCoplan.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ns2:ConsultarNfseRequest xmlns:ns2="' + URLNS + '">' +
              '<nfseCabecMsg>' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseDadosMsg>' +
             '</ns2:ConsultarNfseRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorCoplan.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ns2:CancelarNfseRequest xmlns:ns2="' + URLNS + '">' +
              '<nfseCabecMsg>' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseDadosMsg>' +
             '</ns2:CancelarNfseRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorCoplan.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ns2:RecepcionarLoteRpsRequest xmlns:ns2="' + URLNS + '">' +
              '<nfseCabecMsg>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                 StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseDadosMsg>' +
             '</ns2:RecepcionarLoteRpsRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorCoplan.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorCoplan.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://nfse.abrasf.org.br/RecepcionarLoteRps';
   acConsSit:     Result := 'http://nfse.abrasf.org.br/ConsultarSituacaoLoteRps';
   acConsLote:    Result := 'http://nfse.abrasf.org.br/ConsultarLoteRps';
   acConsNFSeRps: Result := 'http://nfse.abrasf.org.br/ConsultarNfsePorRps';
   acConsNFSe:    Result := 'http://nfse.abrasf.org.br/ConsultarNfseServicoPrestado';
   acCancelar:    Result := 'http://nfse.abrasf.org.br/CancelarNfse';
   acGerar:       Result := 'http://nfse.abrasf.org.br/GerarNfse';
 end;
end;

function TProvedorCoplan.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'outputXML' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'outputXML' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'outputXML' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'outputXML' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'outputXML' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'outputXML' );
   acGerar:       Result := SeparaDados( RetornoWS, 'outputXML' );
 end;
end;

function TProvedorCoplan.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/nfse">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorCoplan.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
