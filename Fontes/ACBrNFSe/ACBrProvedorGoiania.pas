{$I ACBr.inc}

unit ACBrProvedorGoiania;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorGinfes }

 TProvedorGoiania = class(TProvedorClass)
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

{ TProvedorGinfes }

constructor TProvedorGoiania.Create;
begin
 {----}
end;

function TProvedorGoiania.GetConfigCidade(ACodCidade, AAmbiente: Integer): TConfigCidade;
var
  ConfigCidade: TConfigCidade;
begin
 	ConfigCidade.VersaoSoap    := '1.1';
 	ConfigCidade.Prefixo2      := '';
 	ConfigCidade.Prefixo3      := '';
 	ConfigCidade.Prefixo4      := '';
 	ConfigCidade.Identificador := 'Id';

 	{if AAmbiente = 1
  	then ConfigCidade.NameSpaceEnvelope := 'http://nfse.goiania.go.gov.br/xsd/nfse_gyn_v02.xsd'
  else }
	ConfigCidade.NameSpaceEnvelope := 'http://nfse.goiania.go.gov.br/xsd/nfse_gyn_v02.xsd';

 	ConfigCidade.AssinaRPS  := True;
 	ConfigCidade.AssinaLote := False;

 	Result := ConfigCidade;
end;

function TProvedorGoiania.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '2.01';
 ConfigSchema.VersaoDados     := '2.01';
 ConfigSchema.VersaoXML       := '2';
 ConfigSchema.NameSpaceXML    := 'http://nfse.goiania.go.gov.br/xsd/';
 ConfigSchema.Cabecalho       := 'nfse_gyn_v02.xsd';
 ConfigSchema.ServicoEnviar   := 'nfse_gyn_v02.xsd';
 ConfigSchema.ServicoConSit   := 'nfse_gyn_v02.xsd';
 ConfigSchema.ServicoConLot   := 'nfse_gyn_v02.xsd';
 ConfigSchema.ServicoConRps   := 'nfse_gyn_v02.xsd';
 ConfigSchema.ServicoConNfse  := 'nfse_gyn_v02.xsd';
 ConfigSchema.ServicoCancelar := 'nfse_gyn_v02.xsd';
// ConfigSchema.ServicoGerar    := 'nfse_gyn_v02.xsd';
 ConfigSchema.DefTipos        := '';

 Result := ConfigSchema;
end;

function TProvedorGoiania.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 	ConfigURL: TConfigURL;
begin
 	ConfigURL.HomNomeCidade         := 'goiania';
 	ConfigURL.HomRecepcaoLoteRPS    := 'https://nfse.goiania.go.gov.br/ws/nfse.asmx';
 	ConfigURL.HomConsultaLoteRPS    := 'https://nfse.goiania.go.gov.br/ws/nfse.asmx';
 	ConfigURL.HomConsultaNFSeRPS    := 'https://nfse.goiania.go.gov.br/ws/nfse.asmx';
 	ConfigURL.HomConsultaSitLoteRPS := 'https://nfse.goiania.go.gov.br/ws/nfse.asmx';
 	ConfigURL.HomConsultaNFSe       := 'https://nfse.goiania.go.gov.br/ws/nfse.asmx';
 	ConfigURL.HomCancelaNFSe        := 'https://nfse.goiania.go.gov.br/ws/nfse.asmx';
 	ConfigURL.HomGerarNFSe          := 'https://nfse.goiania.go.gov.br/ws/nfse.asmx';

 	ConfigURL.ProNomeCidade         := 'goiania';
 	ConfigURL.ProRecepcaoLoteRPS    := 'https://nfse.goiania.go.gov.br/ws/nfse.asmx';
 	ConfigURL.ProConsultaLoteRPS    := 'https://nfse.goiania.go.gov.br/ws/nfse.asmx';
 	ConfigURL.ProConsultaNFSeRPS    := 'https://nfse.goiania.go.gov.br/ws/nfse.asmx';
 	ConfigURL.ProConsultaSitLoteRPS := 'https://nfse.goiania.go.gov.br/ws/nfse.asmx';
 	ConfigURL.ProConsultaNFSe       := 'https://nfse.goiania.go.gov.br/ws/nfse.asmx';
 	ConfigURL.ProCancelaNFSe        := 'https://nfse.goiania.go.gov.br/ws/nfse.asmx';
  ConfigURL.ProGerarNFSe          := 'https://nfse.goiania.go.gov.br/ws/nfse.asmx';

 	Result := ConfigURL;
end;

function TProvedorGoiania.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorGoiania.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := False;
   acConsSit:     Result := False;
   acConsLote:    Result := False;
   acConsNFSeRps: Result := False;
   acConsNFSe:    Result := False;
   acCancelar:    Result := False;
   acGerar:       Result := True;
   else           Result := False;
 end;
end;

function TProvedorGoiania.GetValidarLote: Boolean;
begin
 Result := False;
end;

function TProvedorGoiania.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
var
 xmlns: String;
begin
 xmlns := ' xmlns="http://nfse.goiania.go.gov.br/xsd/nfse_gyn_v02.xsd"';

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
   acGerar:       Result := '<' + Prefixo3 + 'GerarNfseEnvio' + xmlns + NameSpaceDad;
 end;
end;

function TProvedorGoiania.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorGoiania.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorGoiania.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
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

function TProvedorGoiania.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<EnviarLoteRpsEnvio xmlns="' + URLNS + '">' +
              '<MensagemXML>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</MensagemXML>' +
             '</EnviarLoteRpsEnvio>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorGoiania.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedorGoiania.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedorGoiania.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
						'<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
						               'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                           'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
             '<soap:Body>' +
              '<ConsultarNfseRps xmlns="http://nfse.goiania.go.gov.br/ws/">' +
               '<ArquivoXML>' + DadosMsg + '</ArquivoXML>' +
              '</ConsultarNfseRps>' +
             '</soap:Body>' +
            '</soap:Envelope>';
end;

function TProvedorGoiania.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedorGoiania.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedorGoiania.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
	result := '<?xml version="1.0" encoding="utf-8"?>' +
            '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                           'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                           'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'+
             '<soap:Body>'+
              '<GerarNfse xmlns="http://nfse.goiania.go.gov.br/ws/">' +
               '<ArquivoXML>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
               '</ArquivoXML>'+
      				'</GerarNfse>' +
             '</soap:Body>' +
						'</soap:Envelope>';
end;

function TProvedorGoiania.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorGoiania.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/RecepcionarLoteRps';
   acConsSit:     Result := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/ConsultarSituacaoLoteRps';
   acConsLote:    Result := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/ConsultarLoteRps';
   acConsNFSeRps: Result := 'http://nfse.goiania.go.gov.br/ws/ConsultarNfseRps';
   acConsNFSe:    Result := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/ConsultarNfse';
   acCancelar:    Result := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/CancelarNfse';
   acGerar:       Result := 'http://nfse.goiania.go.gov.br/ws/GerarNfse';
 end;
end;

function TProvedorGoiania.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
var
 RetWS: AnsiString;
begin
 case Acao of
   acRecepcionar: begin
                   RetWS := SeparaDados( RetornoWS, 'EnviarLoteRpsResposta>' );
                   RetWS := RetWS + '</EnviarLoteRpsResposta>';
                   Result := RetWS;
                  end;
   acConsSit:     Result := SeparaDados( RetornoWS, 'ConsultarSituacaoLoteRpsResposta' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'ConsultarLoteRpsRpsResposta' );
   acConsNFSeRps: begin
                   RetWS := SeparaDados( RetornoWS, 'ConsultarNfseRpsResult>' );
                   RetWS := RetWS + '</ConsultarNfseRpsResult>';
                   Result := RetWS;
                  end;
   acConsNFSe:    begin
                   RetWS := SeparaDados( RetornoWS, 'ConsultarNfseResposta>' );
                   RetWS := RetWS + '</ConsultarNfseResposta>';
                   Result := RetWS;
                  end;
   acCancelar:    begin
                   RetWS := SeparaDados( RetornoWS, 'CancelarNfseResposta>' );
                   RetWS := RetWS + '</CancelarNfseResposta>';
                   Result := RetWS;
                  end;
   acGerar:       begin
                   RetWS := SeparaDados( RetornoWS, 'GerarNfseResult' );
                   RetWS := RetWS + '</GerarNfseResult>';
                   Result := RetWS;
                  end;
 end;
end;

function TProvedorGoiania.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="https://nfse.goiania.go.gov.br/ws/">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorGoiania.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
Var
   vUrlNota : string;
begin
  vUrlNota := 'http://www2.goiania.go.gov.br/sistemas/snfse/asp/snfse00200w0.asp?inscricao=' + AInscricaoM;
  vUrlNota := vUrlNota + '&nota=' + IntToStr(ANumeroNFSe) + '&verificador=' + ACodVerificacao;
  Result   := vUrlNota;
end;

end.
