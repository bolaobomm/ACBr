{$I ACBr.inc}

unit ACBrProvedorGovDigital;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorGovDigital }

 TProvedorGovDigital = class(TProvedorClass)
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

{ TProvedorGovDigital }

constructor TProvedorGovDigital.Create;
begin
 {----}
end;

function TProvedorGovDigital.GetConfigCidade(ACodCidade, AAmbiente: Integer): TConfigCidade;
var
  ConfigCidade: TConfigCidade;
begin
 	ConfigCidade.VersaoSoap    := '1.1';
 	ConfigCidade.Prefixo2      := '';
 	ConfigCidade.Prefixo3      := '';
 	ConfigCidade.Prefixo4      := '';
 	ConfigCidade.Identificador := 'Id';

  case ACodCidade of
   3132404: begin // Itajubá/MG
             if AAmbiente = 1
              then ConfigCidade.NameSpaceEnvelope := 'https://www.govdigital.com.br/ws/itj'
              else ConfigCidade.NameSpaceEnvelope := 'https://homolog.govdigital.com.br/ws/itj';
            end;
   3147006: begin // Paracatu/MG
             if AAmbiente = 1
              then ConfigCidade.NameSpaceEnvelope := 'https://www.govdigital.com.br/ws/pctu'
              else ConfigCidade.NameSpaceEnvelope := 'https://homolog.govdigital.com.br/ws/pctu';
            end;
   3151800: begin // Poços de Caldas/MG
             if AAmbiente = 1
              then ConfigCidade.NameSpaceEnvelope := 'https://www.govdigital.com.br/ws/pocos'
              else ConfigCidade.NameSpaceEnvelope := 'https://homolog.govdigital.com.br/ws/pocos';
            end;
   // A Cidade de Itapetininga/SP trocou o provedor de GovDigital para ISSNet         
//   3522307: begin // Itapetininga/SP
//             if AAmbiente = 1
//              then ConfigCidade.NameSpaceEnvelope := 'https://www.govdigital.com.br/ws/itapetininga'
//              else ConfigCidade.NameSpaceEnvelope := 'https://homolog.govdigital.com.br/ws/itapetininga';
//            end;
  end;

 	ConfigCidade.AssinaRPS  := True;
 	ConfigCidade.AssinaLote := False;

 	Result := ConfigCidade;
end;

function TProvedorGovDigital.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '2.0';
 ConfigSchema.VersaoDados     := '2.0';
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

function TProvedorGovDigital.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 	ConfigURL: TConfigURL;
  Porta: String;
begin
  case ACodCidade of
   3132404: begin
             ConfigURL.HomNomeCidade := 'itj';
             ConfigURL.ProNomeCidade := 'itj';
             Porta := '80';
            end;
   3147006: begin // Paracatu/MG
             ConfigURL.HomNomeCidade := 'pctu';
             ConfigURL.ProNomeCidade := 'pctu';
             Porta := '443';
            end;
   3151800: begin
             ConfigURL.HomNomeCidade := 'pocos';
             ConfigURL.ProNomeCidade := 'pocos';
             Porta := '80';
            end;
//   3522307: begin // Itapetininga/SP
//             ConfigURL.HomNomeCidade := 'itapetininga';
//             ConfigURL.ProNomeCidade := 'itapetininga';
//            end;
  end;

 	ConfigURL.HomRecepcaoLoteRPS    := 'http://homolog.govdigital.com.br:' + Porta + '/ws/' + ConfigURL.HomNomeCidade;
 	ConfigURL.HomConsultaLoteRPS    := 'http://homolog.govdigital.com.br:' + Porta + '/ws/' + ConfigURL.HomNomeCidade;
 	ConfigURL.HomConsultaNFSeRPS    := 'http://homolog.govdigital.com.br:' + Porta + '/ws/' + ConfigURL.HomNomeCidade;
 	ConfigURL.HomConsultaSitLoteRPS := 'http://homolog.govdigital.com.br:' + Porta + '/ws/' + ConfigURL.HomNomeCidade;
 	ConfigURL.HomConsultaNFSe       := 'http://homolog.govdigital.com.br:' + Porta + '/ws/' + ConfigURL.HomNomeCidade;
 	ConfigURL.HomCancelaNFSe        := 'http://homolog.govdigital.com.br:' + Porta + '/ws/' + ConfigURL.HomNomeCidade;
 	ConfigURL.HomGerarNFSe          := 'http://homolog.govdigital.com.br:' + Porta + '/ws/' + ConfigURL.HomNomeCidade;

 	ConfigURL.ProRecepcaoLoteRPS    := 'http://www.govdigital.com.br:' + Porta + '/ws/' + ConfigURL.ProNomeCidade;
 	ConfigURL.ProConsultaLoteRPS    := 'http://www.govdigital.com.br:' + Porta + '/ws/' + ConfigURL.ProNomeCidade;
 	ConfigURL.ProConsultaNFSeRPS    := 'http://www.govdigital.com.br:' + Porta + '/ws/' + ConfigURL.ProNomeCidade;
 	ConfigURL.ProConsultaSitLoteRPS := 'http://www.govdigital.com.br:' + Porta + '/ws/' + ConfigURL.ProNomeCidade;
 	ConfigURL.ProConsultaNFSe       := 'http://www.govdigital.com.br:' + Porta + '/ws/' + ConfigURL.ProNomeCidade;
 	ConfigURL.ProCancelaNFSe        := 'http://www.govdigital.com.br:' + Porta + '/ws/' + ConfigURL.ProNomeCidade;
  ConfigURL.ProGerarNFSe          := 'http://www.govdigital.com.br:' + Porta + '/ws/' + ConfigURL.ProNomeCidade;

 	Result := ConfigURL;
end;

function TProvedorGovDigital.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorGovDigital.GetAssinarXML(Acao: TnfseAcao): Boolean;
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

function TProvedorGovDigital.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorGovDigital.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
var
 xmlns: String;
begin
 xmlns := ' xmlns="http://www.abrasf.org.br/nfse.xsd"';

 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + NameSpaceDad;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + NameSpaceDad;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + NameSpaceDad;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRps' + NameSpaceDad;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseEnvio' + NameSpaceDad;
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + NameSpaceDad +
                             '<' + Prefixo3 + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                 DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
   acGerar:       Result := '<' + Prefixo3 + 'GerarNfseEnvio' + NameSpaceDad;
 end;
end;

function TProvedorGovDigital.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorGovDigital.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorGovDigital.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRps>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '</' + Prefixo3 + 'Pedido>' +
                            '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '</' + Prefixo3 + 'GerarNfseEnvio>';
 end;
end;

function TProvedorGovDigital.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<RecepcionarLoteRpsRequest xmlns="' + URLNS + '">' +
                DadosMsg +
             '</RecepcionarLoteRpsRequest>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorGovDigital.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<s:Body>' +
             '<ConsultarSituacaoRequest xmlns="' + URLNS + '">' +
                DadosMsg +
             '</ConsultarSituacaoRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGovDigital.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<s:Body>' +
             '<ConsultarLoteRpsRequest xmlns="' + URLNS + '">' +
                DadosMsg +
             '</ConsultarLoteRpsRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGovDigital.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<s:Body>' +
             '<ConsultarNfsePorRpsRequest xmlns="' + URLNS + '">' +
                DadosMsg +
             '</ConsultarNfsePorRpsRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGovDigital.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<s:Body>' +
             '<ConsultarNfsePorFaixaRequest xmlns="' + URLNS + '">' +
                DadosMsg +
             '</ConsultarNfsePorFaixaRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGovDigital.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<s:Body>' +
             '<CancelarNfseRequest xmlns="' + URLNS + '">' +
                DadosMsg +
             '</CancelarNfseRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGovDigital.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<GerarNfseRequest xmlns="' + URLNS + '">' +
                DadosMsg +
             '</GerarNfseRequest>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorGovDigital.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://nfse.abrasf.org.br/RecepcionarLoteRpsSincrono';
   acConsSit:     Result := '';
   acConsLote:    Result := 'http://nfse.abrasf.org.br/ConsultarLoteRps';
   acConsNFSeRps: Result := 'http://nfse.abrasf.org.br/ConsultarNfsePorRps';
   acConsNFSe:    Result := 'http://nfse.abrasf.org.br/ConsultarNfsePorFaixa';
   acCancelar:    Result := 'http://nfse.abrasf.org.br/CancelarNfse';
   acGerar:       Result := 'http://nfse.abrasf.org.br/GerarNfse';
 end;
end;

function TProvedorGovDigital.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
var
 RetWS: AnsiString;
begin
 case Acao of
   acRecepcionar: begin
                   RetWS := SeparaDados( RetornoWS, 'RecepcionarLoteRpsResponse>' );
                   RetWS := RetWS + '</RecepcionarLoteRpsResponse>';
                   Result := RetWS;
                  end;
   acConsSit:     Result := SeparaDados( RetornoWS, 'ConsultarSituacaoLoteRpsResponse' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'ConsultarLoteRpsResponse' );
   acConsNFSeRps: begin
                   RetWS := SeparaDados( RetornoWS, 'ConsultarNfsePorRpsResponse>' );
                   RetWS := RetWS + '</ConsultarNfsePorRpsResponse>';
                   Result := RetWS;
                  end;
   acConsNFSe:    begin
                   RetWS := SeparaDados( RetornoWS, 'ConsultarNfsePorFaixaResponse>' );
                   RetWS := RetWS + '</ConsultarNfsePorFaixaResponse>';
                   Result := RetWS;
                  end;
   acCancelar:    begin
                   RetWS := SeparaDados( RetornoWS, 'CancelarNfseResponse>' );
                   RetWS := RetWS + '</CancelarNfseResponse>';
                   Result := RetWS;
                  end;
   acGerar:       begin
                   RetWS := SeparaDados( RetornoWS, 'GerarNfseResponse' );
                   RetWS := RetWS + '</GerarNfseResponse>';
                   Result := RetWS;
                  end;
 end;
end;

function TProvedorGovDigital.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<CompNfse xmlns="http://www.abrasf.org.br/nfse.xsd">' +
            RetNFSe +
           '</CompNfse>';
end;

function TProvedorGovDigital.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

function TProvedorGovDigital.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

end.
