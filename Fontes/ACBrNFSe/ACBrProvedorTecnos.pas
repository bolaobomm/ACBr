{$I ACBr.inc}

unit ACBrProvedorTecnos;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorTecnos }

 TProvedorTecnos = class(TProvedorClass)
  protected
   { protected }
  private
   { private }
   FMetodoRecepcionar: String;
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

uses
  pcnLeitor, pcnConversao;

{ TProvedorTecnos }

constructor TProvedorTecnos.Create;
begin
 FMetodoRecepcionar := 'recepcionarLoteRps';
end;

function TProvedorTecnos.GetConfigCidade(ACodCidade,
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
  then ConfigCidade.NameSpaceEnvelope := 'http://tempuri.org/'
  else ConfigCidade.NameSpaceEnvelope := 'http://tempuri.org/';

 ConfigCidade.AssinaRPS  := True;
 ConfigCidade.AssinaLote := False;

 Result := ConfigCidade;
end;

function TProvedorTecnos.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '20.01';
 ConfigSchema.VersaoDados     := '20.01';
 ConfigSchema.VersaoXML       := '2';
 ConfigSchema.NameSpaceXML    := 'http://www.nfse-tecnos.com.br';
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

function TProvedorTecnos.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
 sHTTPPro: String;
begin
 sHTTPPro := 'https://';

 case ACodCidade of
  4307807: begin // Estrela/RS
            ConfigURL.HomNomeCidade := 'homologaest.nfse-tecnos.com.br';
            ConfigURL.ProNomeCidade := 'estrela.nfse-tecnos.com.br';
            sHTTPPro := 'http://';
           end;
  4310801: begin // Ivoti/RS
            ConfigURL.HomNomeCidade := 'homologaivo.nfse-tecnos.com.br';
            ConfigURL.ProNomeCidade := 'ivoti.nfse-tecnos.com.br';
            sHTTPPro := 'http://';
           end;
  4313300: begin // Nova Prata/RS
            ConfigURL.HomNomeCidade := 'homologaprata.nfse-tecnos.com.br';
            ConfigURL.ProNomeCidade := 'novaprata.nfse-tecnos.com.br';
            sHTTPPro := 'http://';
           end;
  4307609: begin // Estância Velha/RS
            ConfigURL.HomNomeCidade := 'homologaestan.nfse-tecnos.com.br';
            ConfigURL.ProNomeCidade := 'estanciavelha.nfse-tecnos.com.br';
            sHTTPPro := 'http://';
           end;
  4314803: begin // Portao/RS
            ConfigURL.HomNomeCidade := 'homologapor.nfse-tecnos.com.br';
            ConfigURL.ProNomeCidade := 'portao.nfse-tecnos.com.br';
            sHTTPPro := 'http://';
           end;
  4308201: begin // Flores da Cunha/RS
            ConfigURL.HomNomeCidade := 'homologaflo.nfse-tecnos.com.br';
            ConfigURL.ProNomeCidade := 'flores.nfse-tecnos.com.br';
            sHTTPPro := 'http://';
           end;
  4322806: begin // Veranopolis/RS
            ConfigURL.HomNomeCidade := 'homologaver.nfse-tecnos.com.br';
            ConfigURL.ProNomeCidade := 'veranopolis.nfse-tecnos.com.br';
            sHTTPPro := 'http://';
           end;
 end;

 ConfigURL.HomRecepcaoLoteRPS    := 'http://' + ConfigURL.HomNomeCidade + ':9091';
 ConfigURL.HomConsultaLoteRPS    := 'http://' + ConfigURL.HomNomeCidade + ':9097';
 ConfigURL.HomConsultaNFSeRPS    := 'http://' + ConfigURL.HomNomeCidade + ':9095';
 ConfigURL.HomConsultaSitLoteRPS := '';
 ConfigURL.HomConsultaNFSe       := 'http://' + ConfigURL.HomNomeCidade + ':9094';
 ConfigURL.HomCancelaNFSe        := 'http://' + ConfigURL.HomNomeCidade + ':9098';
 ConfigURL.HomGerarNFSe          := 'http://' + ConfigURL.HomNomeCidade + ':9090';
 ConfigURL.HomRecepcaoSincrono   := 'http://' + ConfigURL.HomNomeCidade + ':9091';

 ConfigURL.ProRecepcaoLoteRPS    := sHTTPPro + ConfigURL.ProNomeCidade + '9091';
 ConfigURL.ProConsultaLoteRPS    := sHTTPPro + ConfigURL.ProNomeCidade + '9097';
 ConfigURL.ProConsultaNFSeRPS    := sHTTPPro + ConfigURL.ProNomeCidade + '9095';
 ConfigURL.ProConsultaSitLoteRPS := '';
 ConfigURL.ProConsultaNFSe       := sHTTPPro + ConfigURL.ProNomeCidade + '9094';
 ConfigURL.ProCancelaNFSe        := sHTTPPro + ConfigURL.ProNomeCidade + '9098';
 ConfigURL.ProGerarNFSe          := sHTTPPro + ConfigURL.ProNomeCidade + '9090';
 ConfigURL.ProRecepcaoSincrono   := sHTTPPro + ConfigURL.ProNomeCidade + '9091';

 Result := ConfigURL;
end;

function TProvedorTecnos.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorTecnos.GetAssinarXML(Acao: TnfseAcao): Boolean;
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

function TProvedorTecnos.GetValidarLote: Boolean;
begin
 Result := False;
end;

function TProvedorTecnos.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio' + ' xmlns="http://www.abrasf.org.br/nfse.xsd">';
   acConsSit:     Result := '';
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + ' xmlns="http://www.abrasf.org.br/nfse.xsd">';
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio' + ' xmlns="http://www.abrasf.org.br/nfse.xsd">';
   acConsNFSe:    Result := '';
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + ' xmlns="http://www.abrasf.org.br/nfse.xsd">' +
                             '<' + Prefixo3 + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento ' + Identificador + '="' + URI + '">';
   acGerar:       Result := '';
   acRecSincrono: Result := '<' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio' + ' xmlns="http://www.abrasf.org.br/nfse.xsd">';
 end;
end;

function TProvedorTecnos.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorTecnos.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorTecnos.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio>';
   acConsSit:     Result := '';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRpsEnvio>';
   acConsNFSe:    Result := '';
   acCancelar:    Result := '</' + Prefixo3 + 'Pedido>' +
                            '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '';
   acRecSincrono: Result := '</' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio>';
 end;
end;

function TProvedorTecnos.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
var
   LoteRps      : string;
   Leitor       : TLeitor;
   QuantidadeRps: Integer;
begin
{ - Incluído por Márcio Teixeira em 05/03/2013 -
    O provedor permite o envio de até 3 rps por
    lote no modo síncrono, então verifico a
    quantidade de Rps no lote e valido qual
    médoto posso utilizar. Coloco numa variável
    privada porque na ação ele também deve ir
    o mesmo nome.
  }
Leitor := TLeitor.Create;

try
 Leitor.Arquivo := DadosMsg;
 Leitor.Grupo   := Leitor.Arquivo;
 LoteRps        := Leitor.rExtrai(1, 'LoteRps');
 QuantidadeRps  := Leitor.rCampo(tcInt, 'QuantidadeRps');
 FMetodoRecepcionar := 'mEnvioLoteRPSSincrono';
finally
 FreeAndNil(Leitor);
end;

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<' + FMetodoRecepcionar + ' xmlns="' + URLNS + '">' +
              '<remessa>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</remessa>' +
             '</' + FMetodoRecepcionar + '>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorTecnos.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedorTecnos.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<mConsultaLoteRPS xmlns="' + URLNS + '">' +
              '<remessa>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</remessa>' +
             '</mConsultaLoteRPS>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorTecnos.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<mConsultaNFSePorRPS xmlns="' + URLNS + '">' +
              '<remessa>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</remessa>' +
             '</mConsultaNFSePorRPS>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorTecnos.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<consultarNfse xmlns="' + URLNS + '">' +
              '<xml>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</xml>' +
             '</consultarNfse>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorTecnos.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<mCancelamentoNFSe xmlns="' + URLNS + '">' +
              '<remessa>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</remessa>' +
             '</mCancelamentoNFSe>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorTecnos.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorTecnos.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := GeraEnvelopeRecepcionarLoteRPS(URLNS, CabMsg, DadosMsg, DadosSenha);
end;

function TProvedorTecnos.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://tempuri.org/' + FMetodoRecepcionar;
   acConsSit:     Result := '';
   acConsLote:    Result := 'http://tempuri.org/mConsultaLoteRPS';
   acConsNFSeRps: Result := 'http://tempuri.org/mConsultaNFSePorRPS';
   acConsNFSe:    Result := '';
   acCancelar:    Result := 'http://tempuri.org/mCancelamentoNFSe';
   acGerar:       Result := '';
   acRecSincrono: Result := 'http://tempuri.org/' + FMetodoRecepcionar;
 end;
end;

function TProvedorTecnos.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: begin
                   Result := SeparaDados( RetornoWS, 'mEnvioLoteRPSSincronoResponse');
                  end;
   acConsSit:     begin
                   Result := SeparaDados( RetornoWS, '');
                  end;
   acConsLote:    begin
                   Result := SeparaDados( RetornoWS, 'mConsultaLoteRPSResponse');
                  end;
   acConsNFSeRps: begin
                   Result := SeparaDados( RetornoWS, 'mConsultaNFSePorRPSResponse');
                  end;
   acConsNFSe:    begin
                   Result := '';
                  end;
   acCancelar:    begin
                   Result := SeparaDados( RetornoWS, 'mCancelamentoNFSeResponse');
                  end;
   acGerar:       Result := '';
   acRecSincrono: begin
                   Result := SeparaDados( RetornoWS, 'mEnvioLoteRPSSincronoResponse');
                  end;
 end;
end;

function TProvedorTecnos.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.sistema.com.br/Nfse/arquivos/nfse_3.xsd">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorTecnos.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
