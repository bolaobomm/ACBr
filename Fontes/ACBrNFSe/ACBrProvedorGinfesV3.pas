{$I ACBr.inc}

unit ACBrProvedorGinfesV3;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorGinfes }

 TProvedorGinfesV3 = class(TProvedorClass)
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

constructor TProvedorGinfesV3.Create;
begin
 {----}
end;

function TProvedorGinfesV3.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.2';
 ConfigCidade.Prefixo2      := 'ns2:';
 ConfigCidade.Prefixo3      := 'ns3:';
 ConfigCidade.Prefixo4      := 'ns4:';
 ConfigCidade.Identificador := 'Id';

 case ACodCidade of
  2304400: begin // Fortaleza/CE
            ConfigCidade.NameSpaceEnvelope := 'http://producao.issfortaleza.com.br';
            (*
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'http://producao.issfortaleza.com.br'
             else ConfigCidade.NameSpaceEnvelope := 'http://homologacao.issfortaleza.com.br';
            *)
           end;
  else     begin // Demais cidades
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'http://producao.ginfes.com.br'
             else ConfigCidade.NameSpaceEnvelope := 'http://homologacao.ginfes.com.br';
           end;
 end;

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorGinfesV3.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '3';
 ConfigSchema.VersaoDados     := '3';
 ConfigSchema.VersaoXML       := '1';
 ConfigSchema.NameSpaceXML    := 'http://www.ginfes.com.br/';
 ConfigSchema.Cabecalho       := 'cabecalho_v03.xsd';
 ConfigSchema.ServicoEnviar   := 'servico_enviar_lote_rps_envio_v03.xsd';
 ConfigSchema.ServicoConSit   := 'servico_consultar_situacao_lote_rps_envio_v03.xsd';
 ConfigSchema.ServicoConLot   := 'servico_consultar_lote_rps_envio_v03.xsd';
 ConfigSchema.ServicoConRps   := 'servico_consultar_nfse_rps_envio_v03.xsd';
 ConfigSchema.ServicoConNfse  := 'servico_consultar_nfse_envio_v03.xsd';

 case ACodCidade of
  3300456: ConfigSchema.ServicoCancelar := 'servico_cancelar_nfse_envio_v03.xsd' // Schema usado por Belford Roxo/RJ
  else ConfigSchema.ServicoCancelar := 'servico_cancelar_nfse_envio_v02.xsd';
 end;

 ConfigSchema.DefTipos        := 'tipos_v03.xsd';

 Result := ConfigSchema;
end;

function TProvedorGinfesV3.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 if ACodCidade = 2304400  // Fortaleza/CE
  then begin
   ConfigURL.HomNomeCidade         := '';
   ConfigURL.HomRecepcaoLoteRPS    := 'http://isshomo.sefin.fortaleza.ce.gov.br:80/grpfor-iss/ServiceGinfesImplService';
   ConfigURL.HomConsultaLoteRPS    := 'http://isshomo.sefin.fortaleza.ce.gov.br:80/grpfor-iss/ServiceGinfesImplService';
   ConfigURL.HomConsultaNFSeRPS    := 'http://isshomo.sefin.fortaleza.ce.gov.br:80/grpfor-iss/ServiceGinfesImplService';
   ConfigURL.HomConsultaSitLoteRPS := 'http://isshomo.sefin.fortaleza.ce.gov.br:80/grpfor-iss/ServiceGinfesImplService';
   ConfigURL.HomConsultaNFSe       := 'http://isshomo.sefin.fortaleza.ce.gov.br:80/grpfor-iss/ServiceGinfesImplService';
   ConfigURL.HomCancelaNFSe        := 'http://isshomo.sefin.fortaleza.ce.gov.br:80/grpfor-iss/ServiceGinfesImplService';

   ConfigURL.ProNomeCidade         := '';
   ConfigURL.ProRecepcaoLoteRPS    := 'https://iss.fortaleza.ce.gov.br/grpfor-iss/ServiceGinfesImplService';
   ConfigURL.ProConsultaLoteRPS    := 'https://iss.fortaleza.ce.gov.br/grpfor-iss/ServiceGinfesImplService';
   ConfigURL.ProConsultaNFSeRPS    := 'https://iss.fortaleza.ce.gov.br/grpfor-iss/ServiceGinfesImplService';
   ConfigURL.ProConsultaSitLoteRPS := 'https://iss.fortaleza.ce.gov.br/grpfor-iss/ServiceGinfesImplService';
   ConfigURL.ProConsultaNFSe       := 'https://iss.fortaleza.ce.gov.br/grpfor-iss/ServiceGinfesImplService';
   ConfigURL.ProCancelaNFSe        := 'https://iss.fortaleza.ce.gov.br/grpfor-iss/ServiceGinfesImplService';
   (*
   ConfigURL.HomNomeCidade         := '';
   ConfigURL.HomRecepcaoLoteRPS    := 'https://homologacao.issfortaleza.com.br/ServiceGinfesImpl';
   ConfigURL.HomConsultaLoteRPS    := 'https://homologacao.issfortaleza.com.br/ServiceGinfesImpl';
   ConfigURL.HomConsultaNFSeRPS    := 'https://homologacao.issfortaleza.com.br/ServiceGinfesImpl';
   ConfigURL.HomConsultaSitLoteRPS := 'https://homologacao.issfortaleza.com.br/ServiceGinfesImpl';
   ConfigURL.HomConsultaNFSe       := 'https://homologacao.issfortaleza.com.br/ServiceGinfesImpl';
   ConfigURL.HomCancelaNFSe        := 'https://homologacao.issfortaleza.com.br/ServiceGinfesImpl';

   ConfigURL.ProNomeCidade         := '';
   ConfigURL.ProRecepcaoLoteRPS    := 'https://producao.issfortaleza.com.br/ServiceGinfesImpl';
   ConfigURL.ProConsultaLoteRPS    := 'https://producao.issfortaleza.com.br/ServiceGinfesImpl';
   ConfigURL.ProConsultaNFSeRPS    := 'https://producao.issfortaleza.com.br/ServiceGinfesImpl';
   ConfigURL.ProConsultaSitLoteRPS := 'https://producao.issfortaleza.com.br/ServiceGinfesImpl';
   ConfigURL.ProConsultaNFSe       := 'https://producao.issfortaleza.com.br/ServiceGinfesImpl';
   ConfigURL.ProCancelaNFSe        := 'https://producao.issfortaleza.com.br/ServiceGinfesImpl';
   *)
  end
  else begin  // Demais Cidades
   ConfigURL.HomNomeCidade         := '';
   ConfigURL.HomRecepcaoLoteRPS    := 'https://homologacao.ginfes.com.br/ServiceGinfesImpl';
   ConfigURL.HomConsultaLoteRPS    := 'https://homologacao.ginfes.com.br/ServiceGinfesImpl';
   ConfigURL.HomConsultaNFSeRPS    := 'https://homologacao.ginfes.com.br/ServiceGinfesImpl';
   ConfigURL.HomConsultaSitLoteRPS := 'https://homologacao.ginfes.com.br/ServiceGinfesImpl';
   ConfigURL.HomConsultaNFSe       := 'https://homologacao.ginfes.com.br/ServiceGinfesImpl';
   ConfigURL.HomCancelaNFSe        := 'https://homologacao.ginfes.com.br/ServiceGinfesImpl';

   ConfigURL.ProNomeCidade         := '';
   ConfigURL.ProRecepcaoLoteRPS    := 'https://producao.ginfes.com.br/ServiceGinfesImpl';
   ConfigURL.ProConsultaLoteRPS    := 'https://producao.ginfes.com.br/ServiceGinfesImpl';
   ConfigURL.ProConsultaNFSeRPS    := 'https://producao.ginfes.com.br/ServiceGinfesImpl';
   ConfigURL.ProConsultaSitLoteRPS := 'https://producao.ginfes.com.br/ServiceGinfesImpl';
   ConfigURL.ProConsultaNFSe       := 'https://producao.ginfes.com.br/ServiceGinfesImpl';
   ConfigURL.ProCancelaNFSe        := 'https://producao.ginfes.com.br/ServiceGinfesImpl';
  end;

 Result := ConfigURL;
end;

function TProvedorGinfesV3.GetURI(URI: String): String;
begin
 // No provedor Ginfes a URI n�o � informada.
 Result := '';
end;

function TProvedorGinfesV3.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := True;
   acConsSit:     Result := True;
   acConsLote:    Result := True;
   acConsNFSeRps: Result := True;
   acConsNFSe:    Result := True;
   acCancelar:    Result := True;
   acGerar:       Result := False;
   else           Result := False;
 end;
end;

function TProvedorGinfesV3.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorGinfesV3.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + NameSpaceDad;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + NameSpaceDad;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + NameSpaceDad;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio' + NameSpaceDad;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseEnvio' + NameSpaceDad;
   acCancelar:    Result := '<CancelarNfseEnvio' +
                               ' xmlns="http://www.ginfes.com.br/servico_cancelar_nfse_envio"' +
                               ' xmlns:' + stringReplace(Prefixo4, ':', '', []) + '="http://www.ginfes.com.br/tipos">';
   acGerar:       Result := '';
 end;
end;

function TProvedorGinfesV3.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
  Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
             '<versaoDados>' + VersaoDados + '</versaoDados>'+
            '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorGinfesV3.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorGinfesV3.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRpsEnvio>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '</CancelarNfseEnvio>';
   acGerar:       Result := '';
 end;
end;

function TProvedorGinfesV3.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
var
 TagCab, TagDados: String;
begin
 if Pos('issfortaleza', URLNS) > 0
  then begin
   TagCab   := 'Cabecalho';
   TagDados := 'EnviarLoteRpsEnvio';
  end
  else begin
   TagCab   := 'arg0';
   TagDados := 'arg1';
  end;

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<s:Body>' +
             '<ns1:RecepcionarLoteRpsV3 xmlns:ns1="' + URLNS + '">' +
              '<' + TagCab + '>' + CabMsg + '</' + TagCab + '>' +
              '<' + TagDados + '>' + DadosMsg + '</' + TagDados + '>' +
             '</ns1:RecepcionarLoteRpsV3>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGinfesV3.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
var
 TagCab, TagDados: String;
begin
 if Pos('issfortaleza', URLNS) > 0
  then begin
   TagCab   := 'Cabecalho';
   TagDados := 'ConsultarSituacaoLoteRpsEnvio';
  end
  else begin
   TagCab   := 'arg0';
   TagDados := 'arg1';
  end;

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<s:Body>' +
             '<ns1:ConsultarSituacaoLoteRpsV3 xmlns:ns1="' + URLNS + '">' +
              '<' + TagCab + '>' + CabMsg + '</' + TagCab + '>' +
              '<' + TagDados + '>' + DadosMsg + '</' + TagDados + '>' +
             '</ns1:ConsultarSituacaoLoteRpsV3>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGinfesV3.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
var
 TagCab, TagDados: String;
begin
 if Pos('issfortaleza', URLNS) > 0
  then begin
   TagCab   := 'Cabecalho';
   TagDados := 'ConsultarLoteRpsEnvio';
  end
  else begin
   TagCab   := 'arg0';
   TagDados := 'arg1';
  end;

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<s:Body>' +
             '<ns1:ConsultarLoteRpsV3 xmlns:ns1="' + URLNS + '">' +
              '<' + TagCab + '>' + CabMsg + '</' + TagCab + '>' +
              '<' + TagDados + '>' + DadosMsg + '</' + TagDados + '>' +
             '</ns1:ConsultarLoteRpsV3>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGinfesV3.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
var
 TagCab, TagDados: String;
begin
 if Pos('issfortaleza', URLNS) > 0
  then begin
   TagCab   := 'Cabecalho';
   TagDados := 'ConsultarNfseRpsEnvio';
  end
  else begin
   TagCab   := 'arg0';
   TagDados := 'arg1';
  end;

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<s:Body>' +
             '<ns1:ConsultarNfsePorRpsV3 xmlns:ns1="' + URLNS + '">' +
              '<' + TagCab + '>' + CabMsg + '</' + TagCab + '>' +
              '<' + TagDados + '>' + DadosMsg + '</' + TagDados + '>' +
             '</ns1:ConsultarNfsePorRpsV3>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGinfesV3.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
var
 TagCab, TagDados: String;
begin
 if Pos('issfortaleza', URLNS) > 0
  then begin
   TagCab   := 'Cabecalho';
   TagDados := 'ConsultarNfseEnvio';
  end
  else begin
   TagCab   := 'arg0';
   TagDados := 'arg1';
  end;

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<s:Body>' +
             '<ns1:ConsultarNfseV3 xmlns:ns1="' + URLNS + '">' +
              '<' + TagCab + '>' + CabMsg + '</' + TagCab + '>' +
              '<' + TagDados + '>' + DadosMsg + '</' + TagDados + '>' +
             '</ns1:ConsultarNfseV3>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGinfesV3.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
var
 TagDados: String;
begin
 if Pos('issfortaleza', URLNS) > 0
  then TagDados := 'CancelarNfseEnvio'
  else TagDados := 'arg0';

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<s:Body>' +
             '<ns1:CancelarNfse xmlns:ns1="' + URLNS + '">' +
              '<' + TagDados +'>' +
               '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
               StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</' + TagDados +'>' +
             '</ns1:CancelarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGinfesV3.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorGinfesV3.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorGinfesV3.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := '';
   acConsSit:     Result := '';
   acConsLote:    Result := '';
   acConsNFSeRps: Result := '';
   acConsNFSe:    Result := '';
   acCancelar:    Result := '';
   acGerar:       Result := '';
 end;
end;

function TProvedorGinfesV3.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: begin
                   Result := SeparaDados( RetornoWS, 'return' );
                   if Result = ''
                    then Result := SeparaDados( RetornoWS, 'EnviarLoteRpsResposta' );
                   if Result = ''
                    then Result := SeparaDados( RetornoWS, 'soap:Body' );
                  end;
   acConsSit:     begin
                   Result := SeparaDados( RetornoWS, 'return' );
                   if Result = ''
                    then Result := SeparaDados( RetornoWS, 'ConsultarSituacaoLoteRpsResposta' );
                   if Result = ''
                    then Result := SeparaDados( RetornoWS, 'soap:Body' );
                  end;
   acConsLote:    begin
                   Result := SeparaDados( RetornoWS, 'return' );
                   if Result = ''
                    then Result := SeparaDados( RetornoWS, 'ConsultarLoteRpsResposta' );
                   if Result = ''
                    then Result := SeparaDados( RetornoWS, 'soap:Body' );
                  end;
   acConsNFSeRps: begin
                   Result := SeparaDados( RetornoWS, 'return' );
                   if Result = ''
                    then Result := SeparaDados( RetornoWS, 'ConsultarNfsePorRpsResposta' );
                   if Result = ''
                    then Result := SeparaDados( RetornoWS, 'soap:Body' );
                  end;
   acConsNFSe:    begin
                   Result := SeparaDados( RetornoWS, 'return' );
                   if Result = ''
                    then Result := SeparaDados( RetornoWS, 'ConsultarNfseResposta' );
                   if Result = ''
                    then Result := SeparaDados( RetornoWS, 'soap:Body' );
                  end;
   acCancelar:    begin
                   Result := SeparaDados( RetornoWS, 'return' );
                   if Result = ''
                    then Result := SeparaDados( RetornoWS, 'CancelarNfseResposta' );
                   if Result = ''
                    then Result := SeparaDados( RetornoWS, 'soap:Body' );
                  end;
   acGerar:       begin
                   Result := '';
                  end;
 end;
end;

function TProvedorGinfesV3.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<CompNfse xmlns:ns4="http://www.ginfes.com.br/tipos_v03.xsd">' +
            RetNFSe +
           '</CompNfse>';
end;

function TProvedorGinfesV3.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 if AAmbiente = 1 then
   Result := 'http://visualizar.ginfes.com.br/report/consultarNota?__report=nfs_ver4&cdVerificacao=' +
             ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe) + '&cnpjPrestador=null'
 else
   Result := 'http://visualizar.ginfesh.com.br/report/consultarNota?__report=nfs_ver4&cdVerificacao=' +
             ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe) + '&cnpjPrestador=null';
(*
 if AAmbiente = 1
  then begin
   case ACodMunicipio of
    2304400: Result := 'http://nfse.issfortaleza.com.br/report/consultarNota?__report=nfs_ver4&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe) + '&cnpjPrestador=null';
    3143906: Result := 'http://muriae.ginfes.com.br/birt/frameset?__report=nfs_novo.rptdesign&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe);
    3503208: Result := 'http://araraquara.ginfes.com.br/birt/frameset?_report=nfs_novo.rptdesign&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe);
    3506359: Result := 'http://bertioga.ginfes.com.br/birt/frameset?__report=nfs_ver4.rptdesign&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe);
    3518800: Result := 'http://guarulhos.ginfes.com.br/birt/frameset?_report=nfs_ver4.rptdesign&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe);
    3525102: Result := 'http://jardinopolis.ginfes.com.br/report/consultarNota?__report=nfs_ribeirao_preto&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe);
    3543402: Result := 'http://ribeiraopreto.ginfes.com.br/report/consultarNota?__report=nfs_ribeirao_preto&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe);
    3547809: Result := 'http://santoandre.ginfes.com.br/birt/frameset?_report=nfs_novo.rptdesign&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe);
   else Result := '';
   end;
  end
  else begin
   case ACodMunicipio of
    2304400: Result := 'http://nfse.issfortaleza.com.br/report/consultarNota?__report=nfs_ver4&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe) + '&cnpjPrestador=null';
    3143906: Result := 'http://muriae.ginfesh.com.br/birt/frameset?__report=nfs_novo.rptdesign&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe);
    3503208: Result := 'http://araraquara.ginfesh.com.br/birt/frameset?_report=nfs_novo.rptdesign&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe);
    3506359: Result := 'http://bertioga.ginfesh.com.br/birt/frameset?__report=nfs_ver4.rptdesign&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe);
    3518800: Result := 'http://guarulhos.ginfesh.com.br/birt/frameset?_report=nfs_ver4.rptdesign&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe);
    3525102: Result := 'http://jardinopolis.ginfesh.com.br/report/consultarNota?__report=nfs_ribeirao_preto&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe);
    3543402: Result := 'http://ribeiraopreto.ginfesh.com.br/report/consultarNota?__report=nfs_ribeirao_preto&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe);
    3547809: Result := 'http://santoandre.ginfesh.com.br/birt/frameset?_report=nfs_novo.rptdesign&cdVerificacao=' +
                       ACodVerificacao + '&numNota=' + IntToStr(ANumeroNFSe);
   else Result := '';
   end;
  end;
*)
end;

end.
