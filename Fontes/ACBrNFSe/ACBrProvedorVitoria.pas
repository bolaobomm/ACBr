{$I ACBr.inc}

unit ACBrProvedorVitoria;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorVitoria }

 TProvedorVitoria = class(TProvedorClass)
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

{ TProvedorVitoria }

constructor TProvedorVitoria.Create;
begin
 {----}
end;

function TProvedorVitoria.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.1';
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := '';
 ConfigCidade.Prefixo4      := '';
 ConfigCidade.Identificador := 'Id';

 ConfigCidade.NameSpaceEnvelope := 'http://www.abrasf.org.br';

 ConfigCidade.AssinaRPS  := True;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorVitoria.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
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

function TProvedorVitoria.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 case ACodCidade of
  3205309: begin // Vit�ria/ES
             ConfigURL.HomNomeCidade         := 'https://wsnfsehomologa.vitoria.es.gov.br';
             ConfigURL.HomRecepcaoLoteRPS    := ConfigURL.HomNomeCidade + '/NotaFiscalService.asmx';
             ConfigURL.HomConsultaLoteRPS    := ConfigURL.HomNomeCidade + '/NotaFiscalService.asmx';
             ConfigURL.HomConsultaNFSeRPS    := ConfigURL.HomNomeCidade + '/NotaFiscalService.asmx';
             ConfigURL.HomConsultaSitLoteRPS := ConfigURL.HomNomeCidade + '/NotaFiscalService.asmx';
             ConfigURL.HomConsultaNFSe       := ConfigURL.HomNomeCidade + '/NotaFiscalService.asmx';
             ConfigURL.HomCancelaNFSe        := ConfigURL.HomNomeCidade + '/NotaFiscalService.asmx';
             ConfigURL.HomGerarNFSe          := ConfigURL.HomNomeCidade + '/NotaFiscalService.asmx';
             ConfigURL.HomRecepcaoSincrono   := ConfigURL.HomNomeCidade + '/NotaFiscalService.asmx';

             ConfigURL.ProNomeCidade         := 'https://wsnfse.vitoria.es.gov.br';
             ConfigURL.ProRecepcaoLoteRPS    := ConfigURL.ProNomeCidade + '/NotaFiscalService.asmx';
             ConfigURL.ProConsultaLoteRPS    := ConfigURL.ProNomeCidade + '/NotaFiscalService.asmx';
             ConfigURL.ProConsultaNFSeRPS    := ConfigURL.ProNomeCidade + '/NotaFiscalService.asmx';
             ConfigURL.ProConsultaSitLoteRPS := ConfigURL.ProNomeCidade + '/NotaFiscalService.asmx';
             ConfigURL.ProConsultaNFSe       := ConfigURL.ProNomeCidade + '/NotaFiscalService.asmx';
             ConfigURL.ProCancelaNFSe        := ConfigURL.ProNomeCidade + '/NotaFiscalService.asmx';
             ConfigURL.ProGerarNFSe          := ConfigURL.ProNomeCidade + '/NotaFiscalService.asmx';
             ConfigURL.ProRecepcaoSincrono   := ConfigURL.ProNomeCidade + '/NotaFiscalService.asmx';
           end;
 end;
 Result := ConfigURL;
end;

function TProvedorVitoria.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorVitoria.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 Result := False;
 case Acao of
   acRecepcionar: Result := True;
   acConsSit:     Result := False;
   acConsLote:    Result := False;
   acConsNFSeRps: Result := False;
   acConsNFSe:    Result := False;
   acCancelar:    Result := True;
   acGerar:       Result := True;
   acRecSincrono: Result := True;
 end;
end;

function TProvedorVitoria.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorVitoria.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
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

function TProvedorVitoria.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorVitoria.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorVitoria.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
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

function TProvedorVitoria.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<RecepcionarLoteRps xmlns="' + URLNS + '/nfse.xsd' + '">' +
              '<mensagemXML>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</mensagemXML>' +
             '</RecepcionarLoteRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorVitoria.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
 raise Exception.Create( 'Op��o n�o implementada para este provedor.' );
end;

function TProvedorVitoria.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarLoteRps xmlns="' + URLNS + '/nfse.xsd' + '">' +
              '<mensagemXML>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</mensagemXML>' +
             '</ConsultarLoteRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorVitoria.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarNfsePorRps xmlns="' + URLNS + '/nfse.xsd' + '">' +
              '<mensagemXML>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</mensagemXML>' +
             '</ConsultarNfsePorRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorVitoria.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
 raise Exception.Create( 'Op��o n�o implementada para este provedor.' );
end;

function TProvedorVitoria.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<CancelarNfse xmlns="' + URLNS + '/nfse.xsd' + '">' +
              '<mensagemXML>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</mensagemXML>' +
             '</CancelarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorVitoria.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<GerarNfse xmlns="' + URLNS + '/nfse.xsd' + '">' +
              '<mensagemXML>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</mensagemXML>' +
             '</GerarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorVitoria.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"' +
                      ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +
                      ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<RecepcionarLoteRpsSincrono xmlns="' + URLNS + '/nfse.xsd' + '">' +
              '<mensagemXML>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</mensagemXML>' +
             '</RecepcionarLoteRpsSincrono>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorVitoria.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://www.abrasf.org.br/nfse.xsd/RecepcionarLoteRps';
   acConsSit:     Result := 'http://www.abrasf.org.br/nfse.xsd/ConsultarSituacaoLoteRps';
   acConsLote:    Result := 'http://www.abrasf.org.br/nfse.xsd/ConsultarLoteRps';
   acConsNFSeRps: Result := 'http://www.abrasf.org.br/nfse.xsd/ConsultarNfsePorRps';
   acConsNFSe:    Result := 'http://www.abrasf.org.br/nfse.xsd/ConsultarNfseFaixa';
   acCancelar:    Result := 'http://www.abrasf.org.br/nfse.xsd/CancelarNfse';
   acGerar:       Result := 'http://www.abrasf.org.br/nfse.xsd/GerarNfse';
   acRecSincrono: Result := 'http://www.abrasf.org.br/nfse.xsd/RecepcionarLoteRpsSincrono';
 end;
end;

function TProvedorVitoria.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'RecepcionarLoteRpsResult' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'outputXML' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'ConsultarLoteRpsResult' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'ConsultarNfsePorRpsResult' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'ConsultarNfseFaixaResult' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'CancelarNfseResult' );
   acGerar:       Result := SeparaDados( RetornoWS, 'GerarNfseResult' );
   acRecSincrono: Result := SeparaDados( RetornoWS, 'RecepcionarLoteRpsSincronoResult' );
 end;
end;

function TProvedorVitoria.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/nfse">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorVitoria.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
  Result := 'http://sistemas3.vitoria.es.gov.br/isiss/Aberto/exibenfe.cfm?key=' +
           ACodVerificacao + '&num=' + IntToStr(ANumeroNFSe);
end;

end.