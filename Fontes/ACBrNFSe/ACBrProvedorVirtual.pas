{$I ACBr.inc}

unit ACBrProvedorVirtual;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorVirtual }

 TProvedorVirtual = class(TProvedorClass)
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

{ TProvedorVirtual }

constructor TProvedorVirtual.Create;
begin
 {----}
end;

function TProvedorVirtual.GetConfigCidade(ACodCidade, AAmbiente: Integer): TConfigCidade;
var
  ConfigCidade: TConfigCidade;
begin
 	ConfigCidade.VersaoSoap        := '1.1';
 	ConfigCidade.Prefixo2          := '';
 	ConfigCidade.Prefixo3          := '';
 	ConfigCidade.Prefixo4          := '';
 	ConfigCidade.Identificador     := 'Id';
	ConfigCidade.NameSpaceEnvelope := 'http://www.abrasf.org.br';
 	ConfigCidade.AssinaRPS         := True;
 	ConfigCidade.AssinaLote        := False;

 	Result := ConfigCidade;
end;

function TProvedorVirtual.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho       := '2.00';
 ConfigSchema.VersaoDados           := '2.00';
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

function TProvedorVirtual.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 	ConfigURL: TConfigURL;
begin
 	 ConfigURL.HomRecepcaoLoteRPS    := '';
 	 ConfigURL.HomConsultaLoteRPS    := '';
 	 ConfigURL.HomConsultaNFSeRPS    := '';
 	 ConfigURL.HomConsultaSitLoteRPS := '';
   ConfigURL.HomConsultaNFSe       := '';
   ConfigURL.HomCancelaNFSe        := 'http://virtualserver.dyndns-free.com:8080/SCEMX32JavaEnvironment/servlet/anfse_barradogarcas?wsdl';
 	 ConfigURL.HomGerarNFSe          := 'http://virtualserver.dyndns-free.com:8080/SCEMX32JavaEnvironment/servlet/agerarnfse_barradogarcas?wsdl';
 	 ConfigURL.HomRecepcaoSincrono   := '';

 	 ConfigURL.ProRecepcaoLoteRPS    := '';
 	 ConfigURL.ProConsultaLoteRPS    := '';
 	 ConfigURL.ProConsultaNFSeRPS    := '';
 	 ConfigURL.ProConsultaSitLoteRPS := '';
 	 ConfigURL.ProConsultaNFSe       := '';
 	 ConfigURL.ProCancelaNFSe        := 'http://financas.barradogarcas.com:8080/SCEM/servlet/anfse_barradogarcas?wsdl';
   ConfigURL.ProGerarNFSe          := 'http://financas.barradogarcas.com:8080/SCEM/servlet/agerarnfse_barradogarcas?wsdl';
 	 ConfigURL.ProRecepcaoSincrono   := '';

  	Result := ConfigURL;
end;

function TProvedorVirtual.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorVirtual.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := False;
   acConsSit:     Result := False;
   acConsLote:    Result := False;
   acConsNFSeRps: Result := False;
   acConsNFSe:    Result := False;
   acCancelar:    Result := False;
   acGerar:       Result := False;
   acRecSincrono: Result := False;
   else           Result := False;
 end;
end;

function TProvedorVirtual.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorVirtual.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
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
   acRecSincrono: Result := '<' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio' + NameSpaceDad;
 end;
end;

function TProvedorVirtual.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorVirtual.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorVirtual.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
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
   acRecSincrono: Result := '</' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio>';
 end;
end;

function TProvedorVirtual.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedorVirtual.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedorVirtual.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
            '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                        'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                        'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<ConsultarLoteRps.Execute xmlns="http://tempuri.org/">' +
              '<Entrada>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</Entrada>' +
             '</ConsultarLoteRps.Execute>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorVirtual.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
            '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                        'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                        'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<ConsultarNfsePorRps.Execute xmlns="Abrasf2">' +
              '<Entrada>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</Entrada>' +
             '</ConsultarNfsePorRps.Execute>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorVirtual.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedorVirtual.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<CancelarNfse.Execute xmlns="Abrasf2">' +
              '<Entrada>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</Entrada>' +
             '</CancelarNfse.Execute>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorVirtual.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<GerarNfse.Execute xmlns="http://tempuri.org/">' +
              '<Entrada>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</Entrada>' +
             '</GerarNfse.Execute>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorVirtual.GeraEnvelopeRecepcionarSincrono(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedorVirtual.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := '';
   acConsSit:     Result := '';
   acConsLote:    Result := '';
   acConsNFSeRps: Result := '';
   acConsNFSe:    Result := '';
   acCancelar:    Result := 'NFSE_BarradoGarcasaction/ANFSE_BARRADOGARCAS.CANCELARNFSE';
   acGerar:       Result := 'http://www.abrasf.org.br/nfse.xsdaction/AGERARNFSE_BARRADOGARCAS.Execute';
   acRecSincrono: Result := '';
 end;
end;

function TProvedorVirtual.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
var
 RetWS: AnsiString;
begin
 case Acao of
   acRecepcionar: Result := RetornoWS;
   acConsSit:     Result := RetornoWS;
   acConsLote:    begin
                   RetWS := SeparaDados( RetornoWS, 'Resposta' );
                   Result := RetWS;
                  end;
   acConsNFSeRps: begin
                   RetWS := SeparaDados( RetornoWS, 'Resposta' );
                   Result := RetWS;
                  end;
   acConsNFSe:    Result := RetornoWS;
   acCancelar:    begin
                   RetWS := SeparaDados( RetornoWS, 'Resposta' );
                   Result := RetWS;
                  end;
   acGerar:       begin
                   RetWS := SeparaDados( RetornoWS, 'Resposta' );
                   Result := RetWS;
                  end;
   acRecSincrono: begin
                   RetWS := SeparaDados( RetornoWS, 'Resposta' );
                   Result := RetWS;
                  end;
 end;
end;

function TProvedorVirtual.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<CompNfse xmlns="http://www.abrasf.org.br/nfse.xsd">' +
            RetNFSe +
           '</CompNfse>';
end;

function TProvedorVirtual.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
  // Não implementada
 Result := ''; 
end;

end.
