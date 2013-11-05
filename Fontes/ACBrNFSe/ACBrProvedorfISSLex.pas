{$I ACBr.inc}

unit ACBrProvedorFISSLEX;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorFISSLEX }

 TProvedorFISSLEX = class(TProvedorClass)
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

{ TProvedorFISSLEX }

constructor TProvedorFISSLEX.Create;
begin
 {----}
end;

function TProvedorFISSLEX.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.2';
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := '';
 ConfigCidade.Prefixo4      := '';
 ConfigCidade.Identificador := 'id';

 if AAmbiente = 1
  then ConfigCidade.NameSpaceEnvelope := 'https://demo.fisslex.com.br'
  else begin
   case ACodCidade of
    1100304: ConfigCidade.NameSpaceEnvelope := 'https://vilhena.fisslex.com.br';
    5101704: ConfigCidade.NameSpaceEnvelope := 'https://barradobugres.fisslex.com.br';
    5102504: ConfigCidade.NameSpaceEnvelope := 'https://caceres.fisslex.com.br';
    5102702: ConfigCidade.NameSpaceEnvelope := 'https://canarana.fisslex.com.br';
    5103007: ConfigCidade.NameSpaceEnvelope := 'https://chapada.fisslex.com.br';
    5104559: ConfigCidade.NameSpaceEnvelope := 'https://itauba.fisslex.com.br';
    5104609: ConfigCidade.NameSpaceEnvelope := 'https://itiquira.fisslex.com.br';
    5107248: ConfigCidade.NameSpaceEnvelope := 'https://santacarmen.fisslex.com.br';
    5107800: ConfigCidade.NameSpaceEnvelope := 'https://leverger.fisslex.com.br';
    5107875: ConfigCidade.NameSpaceEnvelope := 'https://sapezal.fisslex.com.br';
    5107958: ConfigCidade.NameSpaceEnvelope := 'https://tangara.fisslex.com.br';
   end;
  end;

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorFISSLEX.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
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

function TProvedorFISSLEX.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 case ACodCidade of
  1100304: begin // Vilhena/RO
            ConfigURL.HomNomeCidade := 'vilhena';
            ConfigURL.ProNomeCidade := 'vilhena';
           end;
  5101704: begin // Barra do Bugres/MT
            ConfigURL.HomNomeCidade := 'barradobugres';
            ConfigURL.ProNomeCidade := 'barradobugres';
           end;
  5102504: begin // Cáceres/MT
            ConfigURL.HomNomeCidade := 'caceres';
            ConfigURL.ProNomeCidade := 'caceres';
           end;
  5102702: begin // Canarana/MT
            ConfigURL.HomNomeCidade := 'canarana';
            ConfigURL.ProNomeCidade := 'canarana';
           end;
  5103007:begin // Chapada dos Guimarães/MT
            ConfigURL.HomNomeCidade := 'chapada';
            ConfigURL.ProNomeCidade := 'chapada';
           end;
  5104559: begin // Itaúba/MT
            ConfigURL.HomNomeCidade := 'itauba';
            ConfigURL.ProNomeCidade := 'itauba';
           end;
  5104609: begin // Itiquira/MT
            ConfigURL.HomNomeCidade := 'itiquira';
            ConfigURL.ProNomeCidade := 'itiquira';
           end;
  5107248: begin // Santa Carmen/MT
            ConfigURL.HomNomeCidade := 'santacarmen';
            ConfigURL.ProNomeCidade := 'santacarmen';
           end;
  5107800: begin // Santo Antônio do Leverger/MT
            ConfigURL.HomNomeCidade := 'leverger';
            ConfigURL.ProNomeCidade := 'leverger';
           end;
  5107875: begin // Sapezal/MT
            ConfigURL.HomNomeCidade := 'sapezal';
            ConfigURL.ProNomeCidade := 'sapezal';
           end;
  5107958: begin // Tangara da Serra/MT
            ConfigURL.HomNomeCidade := 'tangara';
            ConfigURL.ProNomeCidade := 'tangara';
           end;
 end;

 ConfigURL.HomRecepcaoLoteRPS    := 'https://demo.fisslex.com.br/fiss-lex/servlet/aws_recepcionarloterps';
 ConfigURL.HomConsultaLoteRPS    := 'https://demo.fisslex.com.br/fiss-lex/servlet/aws_consultaloterps';
 ConfigURL.HomConsultaNFSeRPS    := 'https://demo.fisslex.com.br/fiss-lex/servlet/aws_consultanfseporrps';
 ConfigURL.HomConsultaSitLoteRPS := 'https://demo.fisslex.com.br/fiss-lex/servlet/aws_consultarsituacaoloterps';
 ConfigURL.HomConsultaNFSe       := 'https://demo.fisslex.com.br/fiss-lex/servlet/aws_consultanfse';
 ConfigURL.HomCancelaNFSe        := 'https://demo.fisslex.com.br/fiss-lex/servlet/aws_cancelarnfse';

 ConfigURL.ProRecepcaoLoteRPS    := 'https://' + ConfigURL.ProNomeCidade + '.fisslex.com.br/fiss-lex/servlet/aws_recepcionarloterps';
 ConfigURL.ProConsultaLoteRPS    := 'https://' + ConfigURL.ProNomeCidade + '.fisslex.com.br/fiss-lex/servlet/aws_consultaloterps';
 ConfigURL.ProConsultaNFSeRPS    := 'https://' + ConfigURL.ProNomeCidade + '.fisslex.com.br/fiss-lex/servlet/aws_consultanfseporrps';
 ConfigURL.ProConsultaSitLoteRPS := 'https://' + ConfigURL.ProNomeCidade + '.fisslex.com.br/fiss-lex/servlet/aws_consultarsituacaoloterps';
 ConfigURL.ProConsultaNFSe       := 'https://' + ConfigURL.ProNomeCidade + '.fisslex.com.br/fiss-lex/servlet/aws_consultanfse';
 ConfigURL.ProCancelaNFSe        := 'https://' + ConfigURL.ProNomeCidade + '.fisslex.com.br/fiss-lex/servlet/aws_cancelarnfse';

 Result := ConfigURL;
end;

function TProvedorFISSLEX.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorFISSLEX.GetAssinarXML(Acao: TnfseAcao): Boolean;
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

function TProvedorFISSLEX.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorFISSLEX.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
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

function TProvedorFISSLEX.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorFISSLEX.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorFISSLEX.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
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

function TProvedorFISSLEX.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg := SeparaDados( DadosMsg, 'EnviarLoteRpsEnvio' );
 DadosMsg := '<EnviarLoteRpsEnvio>' + DadosMsg + '</EnviarLoteRpsEnvio>';

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<WS_RecepcionarLoteRps.Execute xmlns="FISS-LEX">' +
              '<Enviarloterpsenvio xmlns="FISS-LEX">' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</Enviarloterpsenvio>' +
             '</WS_RecepcionarLoteRps.Execute>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorFISSLEX.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg := SeparaDados( DadosMsg, 'ConsultarSituacaoLoteRpsEnvio' );

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:fiss="FISS-LEX">' +
            '<soapenv:Header/>' +
            '<soapenv:Body>' +
             '<fiss:WS_ConsultarSituacaoLoteRps.Execute>' +
              '<fiss:Consultarsituacaoloterpsenvio>' +
                DadosMsg +
              '</fiss:Consultarsituacaoloterpsenvio>' +
             '</fiss:WS_ConsultarSituacaoLoteRps.Execute>' +
            '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorFISSLEX.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg := SeparaDados( DadosMsg, 'ConsultarLoteRpsEnvio' );

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:fiss="FISS-LEX">' +
            '<soapenv:Header/>' +
            '<soapenv:Body>' +
             '<fiss:WS_ConsultaLoteRps.Execute>' +
              '<fiss:Consultarloterpsenvio>' +
                DadosMsg +
              '</fiss:Consultarloterpsenvio>' +
             '</fiss:WS_ConsultaLoteRps.Execute>' +
            '</soapenv:Body>' +
           '</soapenv:Envelope>';
(*
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<WS_ConsultaLoteRps.Execute xmlns="FISS-LEX">' +
              '<Consultarloterpsenvio>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</Consultarloterpsenvio>' +
             '</WS_ConsultaLoteRps.Execute>' +
            '</s:Body>' +
           '</s:Envelope>';
*)
end;

function TProvedorFISSLEX.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<WS_ConsultaNfsePorRps.Execute xmlns="FISS-LEX">' +
              '<Consultarnfserpsenvio xmlns="FISS-LEX">' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</Consultarnfserpsenvio>' +
             '</WS_ConsultarNfsePorRps.Execute>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorFISSLEX.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<WS_ConsultaNfse.Execute xmlns="FISS-LEX">' +
              '<Consultarnfseenvio xmlns="FISS-LEX">' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</Consultarnfseenvio>' +
             '</WS_ConsultaNfse.Execute>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorFISSLEX.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<WS_CancelarNfse.Execute xmlns="FISS-LEX">' +
              '<CancelarNfseenvio xmlns="FISS-LEX">' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</CancelarNfseenvio>' +
             '</WS_CancelarNfse.Execute>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorFISSLEX.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorFISSLEX.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorFISSLEX.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'FISS-LEXaction/AWS_RECEPCIONARLOTERPS.Execute';
   acConsSit:     Result := 'FISS-LEXaction/AWS_CONSULTARSITUACAOLOTERPS.Execute';
   acConsLote:    Result := 'FISS-LEXaction/AWS_CONSULTARLOTERPS.Execute';
   acConsNFSeRps: Result := 'FISS-LEXaction/AWS_CONSULTARNFSEPORRPS.Execute';
   acConsNFSe:    Result := 'FISS-LEXaction/AWS_CONSULTARNFSE.Execute';
   acCancelar:    Result := 'FISS-LEXaction/AWS_CANCELARNFSE.Execute';
   acGerar:       Result := '';
 end;
end;

function TProvedorFISSLEX.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'WS_RecepcionarLoteRps.ExecuteResponse' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'WS_ConsultarSituacaoLoteRps.ExecuteResponse' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'WS_ConsultaLoteRps.ExecuteResponse' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'WS_ConsultaNfsePorRps.ExecuteResponse' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'WS_ConsultaNfse.ExecuteResponse' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'WS_CancelarNfse.ExecuteResponse' );
   acGerar:       Result := '';
 end;
end;

function TProvedorFISSLEX.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="https://' + NomeCidade + '.fisslex.com.br/webservices/abrasf/api">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorFISSLEX.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
