{$I ACBr.inc}

unit ACBrProvedorRecife;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorRecife }

 TProvedorRecife = class(TProvedorClass)
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

{ TProvedorRecife }

constructor TProvedorRecife.Create;
begin
 {----}
end;

function TProvedorRecife.GetConfigCidade(ACodCidade,
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
  then ConfigCidade.NameSpaceEnvelope := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd'
  else ConfigCidade.NameSpaceEnvelope := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd';

 ConfigCidade.AssinaRPS  := True;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorRecife.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '1.00';
 ConfigSchema.VersaoDados     := '1.00';
 ConfigSchema.VersaoXML       := '1';
 ConfigSchema.NameSpaceXML    := 'http://www.abrasf.org.br/ABRASF/arquivos/';
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

function TProvedorRecife.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 ConfigURL.HomNomeCidade         := '';
 ConfigURL.HomRecepcaoLoteRPS    := 'https://nfse.recife.pe.gov.br/WSNacional/nfse_v01.asmx';
 ConfigURL.HomConsultaLoteRPS    := 'https://nfse.recife.pe.gov.br/WSNacional/nfse_v01.asmx';
 ConfigURL.HomConsultaNFSeRPS    := 'https://nfse.recife.pe.gov.br/WSNacional/nfse_v01.asmx';
 ConfigURL.HomConsultaSitLoteRPS := 'https://nfse.recife.pe.gov.br/WSNacional/nfse_v01.asmx';
 ConfigURL.HomConsultaNFSe       := 'https://nfse.recife.pe.gov.br/WSNacional/nfse_v01.asmx';
 ConfigURL.HomCancelaNFSe        := 'https://nfse.recife.pe.gov.br/WSNacional/nfse_v01.asmx';

 ConfigURL.ProNomeCidade         := '';
 ConfigURL.ProRecepcaoLoteRPS    := 'https://nfse.recife.pe.gov.br/WSNacional/nfse_v01.asmx';
 ConfigURL.ProConsultaLoteRPS    := 'https://nfse.recife.pe.gov.br/WSNacional/nfse_v01.asmx';
 ConfigURL.ProConsultaNFSeRPS    := 'https://nfse.recife.pe.gov.br/WSNacional/nfse_v01.asmx';
 ConfigURL.ProConsultaSitLoteRPS := 'https://nfse.recife.pe.gov.br/WSNacional/nfse_v01.asmx';
 ConfigURL.ProConsultaNFSe       := 'https://nfse.recife.pe.gov.br/WSNacional/nfse_v01.asmx';
 ConfigURL.ProCancelaNFSe        := 'https://nfse.recife.pe.gov.br/WSNacional/nfse_v01.asmx';

 Result := ConfigURL;
end;

function TProvedorRecife.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorRecife.GetAssinarXML(Acao: TnfseAcao): Boolean;
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

function TProvedorRecife.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorRecife.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
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
   acGerar:       Result := '';
 end;
end;

function TProvedorRecife.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorRecife.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorRecife.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRpsEnvio>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '</' + Prefixo3 + 'Pedido>' +
                            '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '';
 end;
end;

function TProvedorRecife.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
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

function TProvedorRecife.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<ConsultarSituacaoLoteRpsEnvio xmlns="' + URLNS + '">' +
              '<MensagemXML>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</MensagemXML>' +
             '</ConsultarSituacaoLoteRpsEnvio>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorRecife.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<ConsultarLoteRpsEnvio xmlns="' + URLNS + '">' +
              '<MensagemXML>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</MensagemXML>' +
             '</ConsultarLoteRpsEnvio>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorRecife.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<ConsultarNfseRpsEnvio xmlns="' + URLNS + '">' +
              '<MensagemXML>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</MensagemXML>' +
             '</ConsultarNfseRpsEnvio>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorRecife.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<ConsultarNfseEnvio xmlns="' + URLNS + '">' +
              '<MensagemXML>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</MensagemXML>' +
             '</ConsultarNfseEnvio>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorRecife.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<CancelarNfseEnvio xmlns="' + URLNS + '">' +
              '<MensagemXML>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</MensagemXML>' +
             '</CancelarNfseEnvio>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorRecife.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorRecife.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Op��o n�o implementada para este provedor.' );
end;

function TProvedorRecife.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/RecepcionarLoteRps';
   acConsSit:     Result := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/ConsultarSituacaoLoteRps';
   acConsLote:    Result := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/ConsultarLoteRps';
   acConsNFSeRps: Result := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/ConsultarNfsePorRps';
   acConsNFSe:    Result := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/ConsultarNfse';
   acCancelar:    Result := 'http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd/WSNacional/CancelarNfse';
   acGerar:       Result := '';
 end;
end;

function TProvedorRecife.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
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
                   RetWS := SeparaDados( RetornoWS, 'ConsultarNfseRpsResposta>' );
                   RetWS := RetWS + '</ConsultarNfseRpsResposta>';
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
   acGerar:       Result := '';
 end;
end;

function TProvedorRecife.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorRecife.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
