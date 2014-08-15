{$I ACBr.inc}

unit ACBrProvedorBetha;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorBetha }

 TProvedorBetha = class(TProvedorClass)
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

{ TProvedorBetha }

constructor TProvedorBetha.Create;
begin
 {----}
end;

function TProvedorBetha.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.1';
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := 'ns3:';
 ConfigCidade.Prefixo4      := '';
 ConfigCidade.Identificador := 'Id';

 if AAmbiente = 1
  then ConfigCidade.NameSpaceEnvelope := 'http://www.betha.com.br/e-nota-contribuinte-ws'
  else ConfigCidade.NameSpaceEnvelope := 'http://www.betha.com.br/e-nota-contribuinte-ws';

 ConfigCidade.AssinaRPS  := True;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorBetha.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '1.00';
 ConfigSchema.VersaoDados     := '1.00';
 ConfigSchema.VersaoXML       := '1';
 ConfigSchema.NameSpaceXML    := 'http://www.betha.com.br/e-nota-contribuinte-ws';
 ConfigSchema.Cabecalho       := ''; //'nfse_v01.xsd';
 ConfigSchema.ServicoEnviar   := 'servico_enviar_lote_rps_envio_v01.xsd';
 ConfigSchema.ServicoConSit   := 'servico_consultar_situacao_lote_rps_envio_v01.xsd';
 ConfigSchema.ServicoConLot   := 'servico_consultar_lote_rps_envio_v01.xsd';
 ConfigSchema.ServicoConRps   := 'servico_enviar_lote_rps_resposta_v01.xsd';
 ConfigSchema.ServicoConNfse  := 'servico_consultar_nfse_envio_v01.xsd';
 ConfigSchema.ServicoCancelar := 'servico_cancelar_nfse_envio_v01.xsd';
 ConfigSchema.ServicoGerar    := '';
 ConfigSchema.DefTipos        := '';

 Result := ConfigSchema;
end;

function TProvedorBetha.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 ConfigURL.HomNomeCidade         := '';
 ConfigURL.HomRecepcaoLoteRPS    := 'https://e-gov.betha.com.br/e-nota-contribuinte-test-ws/recepcionarLoteRps?wsdl';
 ConfigURL.HomConsultaLoteRPS    := 'https://e-gov.betha.com.br/e-nota-contribuinte-test-ws/consultarLoteRps?wsdl';
 ConfigURL.HomConsultaNFSeRPS    := 'https://e-gov.betha.com.br/e-nota-contribuinte-test-ws/consultarNfsePorRps?wsdl';
 ConfigURL.HomConsultaSitLoteRPS := 'https://e-gov.betha.com.br/e-nota-contribuinte-test-ws/consultarSituacaoLoteRps?wsdl';
 ConfigURL.HomConsultaNFSe       := 'https://e-gov.betha.com.br/e-nota-contribuinte-test-ws/consultarNfse?wsdl';
 ConfigURL.HomCancelaNFSe        := 'https://e-gov.betha.com.br/e-nota-contribuinte-test-ws/cancelarNfse?wsdl';

 ConfigURL.ProNomeCidade         := '';
 ConfigURL.ProRecepcaoLoteRPS    := 'https://e-gov.betha.com.br/e-nota-contribuinte-ws/recepcionarLoteRps?wsdl';
 ConfigURL.ProConsultaLoteRPS    := 'https://e-gov.betha.com.br/e-nota-contribuinte-ws/consultarLoteRps?wsdl';
 ConfigURL.ProConsultaNFSeRPS    := 'https://e-gov.betha.com.br/e-nota-contribuinte-ws/consultarNfsePorRps?wsdl';
 ConfigURL.ProConsultaSitLoteRPS := 'https://e-gov.betha.com.br/e-nota-contribuinte-ws/consultarSituacaoLoteRps?wsdl';
 ConfigURL.ProConsultaNFSe       := 'https://e-gov.betha.com.br/e-nota-contribuinte-ws/consultarNfse?wsdl';
 ConfigURL.ProCancelaNFSe        := 'https://e-gov.betha.com.br/e-nota-contribuinte-ws/cancelarNfse?wsdl';

 Result := ConfigURL;
end;

function TProvedorBetha.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorBetha.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := True;
   acConsSit:     Result := False;
   acConsLote:    Result := False;
   acConsNFSeRps: Result := False;
   acConsNFSe:    Result := False;
   acCancelar:    Result := True;
   acGerar:       Result := False;
   else           Result := False;
 end;
end;

function TProvedorBetha.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorBetha.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + NameSpaceDad;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + NameSpaceDad;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + NameSpaceDad;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfsePorRpsEnvio' + NameSpaceDad;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseEnvio' + NameSpaceDad;
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + NameSpaceDad +
                             '<Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                 DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
   acGerar:       Result := '';
 end;
end;

function TProvedorBetha.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorBetha.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorBetha.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfsePorRpsEnvio>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '</Pedido>' +
                           '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '';
 end;
end;

function TProvedorBetha.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<S:Body>' +
              DadosMsg +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorBetha.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<S:Body>' +
              DadosMsg +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorBetha.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<S:Body>' +
               DadosMsg +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorBetha.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<S:Body>' +
              DadosMsg +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorBetha.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<S:Body>' +
              DadosMsg +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorBetha.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
            '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">' +
             '<S:Body>' +
              DadosMsg +
             '</S:Body>' +
            '</S:Envelope>';
end;

function TProvedorBetha.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorBetha.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorBetha.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://www.betha.com.br/e-nota-contribuinte-ws/recepcionarLoteRps';
   acConsSit:     Result := 'http://www.betha.com.br/e-nota-contribuinte-ws/ConsultarSituacaoLoteRpsEnvio';
   acConsLote:    Result := 'http://www.betha.com.br/e-nota-contribuinte-ws/consultarLoteRps';
   acConsNFSeRps: Result := 'http://www.betha.com.br/e-nota-contribuinte-ws/consultarNfsePorRps';
   acConsNFSe:    Result := 'http://www.betha.com.br/e-nota-contribuinte-ws/consultarNfse';
   acCancelar:    Result := 'http://www.betha.com.br/e-nota-contribuinte-ws/cancelarNfse';
   acGerar:       Result := '';
 end;
end;

function TProvedorBetha.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'EnviarLoteRpsResposta', True );
   acConsSit:     Result := SeparaDados( RetornoWS, 'ConsultarSituacaoLoteRpsResposta', True );
   acConsLote:    Result := SeparaDados( RetornoWS, 'ConsultarLoteRpsResposta', True );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'ConsultarNfseRpsResposta', True );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'ConsultarNfseResposta', True );
   acCancelar:    Result := SeparaDados( RetornoWS, 'CancelarNfseReposta', True );
   acGerar:       Result := '';
 end;
end;

function TProvedorBetha.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<ComplNfse xmlns="http://www.betha.com.br/e-nota-contribuinte-ws">' +
             RetNfse +
           '</ComplNfse>';
end;

function TProvedorBetha.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
