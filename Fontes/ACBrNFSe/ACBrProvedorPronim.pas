{$I ACBr.inc}

unit ACBrProvedorPronim;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorPronim }

 TProvedorPronim = class(TProvedorClass)
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

{ TProvedorPronim }

constructor TProvedorPronim.Create;
begin
 {----}
end;

function TProvedorPronim.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.1';
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := '';
 ConfigCidade.Prefixo4      := '';
 ConfigCidade.Identificador := 'id';

 if AAmbiente = 1
  then ConfigCidade.NameSpaceEnvelope := 'http://tempuri.org'
  else ConfigCidade.NameSpaceEnvelope := 'http://tempuri.org';

 ConfigCidade.AssinaRPS  := False;
 case ACodCidade of
  3118601: ConfigCidade.AssinaLote := True; {Denio Incluido para Contagem} 
  4309407: ConfigCidade.AssinaLote := True; {Dalvan}
  4320800: ConfigCidade.AssinaLote := True; {Dalvan}
  else     ConfigCidade.AssinaLote := False;
 end;

 Result := ConfigCidade;
end;

function TProvedorPronim.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
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

function TProvedorPronim.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 case ACodCidade of
  3118601: begin // Contagem/MG
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://teste.contagem.mg.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://teste.contagem.mg.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://teste.contagem.mg.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://teste.contagem.mg.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://teste.contagem.mg.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://teste.contagem.mg.gov.br/NFSEWSTESTE/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://nfse.contagem.mg.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://nfse.contagem.mg.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://nfse.contagem.mg.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://nfse.contagem.mg.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://nfse.contagem.mg.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://nfse.contagem.mg.gov.br/NFSEWS/Services.svc';
           end;
  3304706: begin // Santo Antonio de Padua/RJ
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://177.67.128.86/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://177.67.128.86/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://177.67.128.86/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://177.67.128.86/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://177.67.128.86/NFSEWSTESTE/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://177.67.128.86/NFSEWSTESTE/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://177.67.128.86/NFSEWS/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://177.67.128.86/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://177.67.128.86/NFSEWS/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://177.67.128.86/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://177.67.128.86/NFSEWS/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://177.67.128.86/NFSEWS/Services.svc';
           end;
  3511102: begin // Catanduva/SP por fnietto
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://nfse.catanduva.sp.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://nfse.catanduva.sp.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://nfse.catanduva.sp.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://nfse.catanduva.sp.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://nfse.catanduva.sp.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://nfse.catanduva.sp.gov.br/NFSEWSTESTE/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://nfse.catanduva.sp.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://nfse.catanduva.sp.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://nfse.catanduva.sp.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://nfse.catanduva.sp.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://nfse.catanduva.sp.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://nfse.catanduva.sp.gov.br/NFSEWS/Services.svc';
           end;
  3530300: begin // Mirassol/SP por Daniel Junior
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://nfse.mirassol.sp.gov.br:5555/NFSEWSteste/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://nfse.mirassol.sp.gov.br:5555/NFSEWSteste/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://nfse.mirassol.sp.gov.br:5555/NFSEWSteste/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://nfse.mirassol.sp.gov.br:5555/NFSEWSteste/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://nfse.mirassol.sp.gov.br:5555/NFSEWSteste/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://nfse.mirassol.sp.gov.br:5555/NFSEWSteste/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://nfse.mirassol.sp.gov.br:5555/NFSEWS/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://nfse.mirassol.sp.gov.br:5555/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://nfse.mirassol.sp.gov.br:5555/NFSEWS/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://nfse.mirassol.sp.gov.br:5555/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://nfse.mirassol.sp.gov.br:5555/NFSEWS/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://nfse.mirassol.sp.gov.br:5555/NFSEWS/Services.svc';
           end;
  4118501: begin // Pato Branco/PR
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://nfse.patobranco.pr.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://nfse.patobranco.pr.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://nfse.patobranco.pr.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://nfse.patobranco.pr.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://nfse.patobranco.pr.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://nfse.patobranco.pr.gov.br/NFSEWSTESTE/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://nfse.patobranco.pr.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://nfse.patobranco.pr.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://nfse.patobranco.pr.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://nfse.patobranco.pr.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://nfse.patobranco.pr.gov.br/NFSEws/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://nfse.patobranco.pr.gov.br/NFSEws/Services.svc';
           end;
  4201307: begin // Araquari/SC
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://201.14.131.162:8288/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://201.14.131.162:8288/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://201.14.131.162:8288/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://201.14.131.162:8288/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://201.14.131.162:8288/NFSEWSTESTE/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://201.14.131.162:8288/NFSEWSTESTE/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://201.14.131.162:8288/NFSEWS/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://201.14.131.162:8288/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://201.14.131.162:8288/NFSEWS/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://201.14.131.162:8288/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://201.14.131.162:8288/NFSEWS/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://201.14.131.162:8288/NFSEWS/Services.svc';
           end;
  4205902: begin // Gaspar/SC
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://nfse.gaspar.sc.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://nfse.gaspar.sc.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://nfse.gaspar.sc.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://nfse.gaspar.sc.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://nfse.gaspar.sc.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://nfse.gaspar.sc.gov.br/NFSEWSTESTE/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://nfse.gaspar.sc.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://nfse.gaspar.sc.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://nfse.gaspar.sc.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://nfse.gaspar.sc.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://nfse.gaspar.sc.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://nfse.gaspar.sc.gov.br/NFSEWS/Services.svc';
           end;
  4308102: begin // Feliz/RS
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://187.84.56.69:8082/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://187.84.56.69:8082/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://187.84.56.69:8082/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://187.84.56.69:8082/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://187.84.56.69:8082/nfsewsteste/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://187.84.56.69:8082/nfsewsteste/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://187.84.56.68:8081/nfsews/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://187.84.56.68:8081/nfsews/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://187.84.56.68:8081/nfsews/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://187.84.56.68:8081/nfsews/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://187.84.56.68:8081/nfsews/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://187.84.56.68:8081/nfsews/Services.svc';
           end;
  4309407: begin // Guapore/RS
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://177.20.255.245/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://177.20.255.245/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://177.20.255.245/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://177.20.255.245/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://177.20.255.245/NFSEWSTESTE/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://177.20.255.245/NFSEWSTESTE/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://177.20.255.244/NFSEWS/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://177.20.255.244/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://177.20.255.244/NFSEWS/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://177.20.255.244/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://177.20.255.244/NFSEWS/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://177.20.255.244/NFSEWS/Services.svc';
           end;
  4310207: begin // Ijui/RS
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://ambienteteste.ijui.rs.gov.br/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://ambienteteste.ijui.rs.gov.br/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://ambienteteste.ijui.rs.gov.br/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://ambienteteste.ijui.rs.gov.br/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://ambienteteste.ijui.rs.gov.br/nfsewsteste/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://ambienteteste.ijui.rs.gov.br/nfsewsteste/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://server21.ijui.rs.gov.br/nfsews/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://server21.ijui.rs.gov.br/nfsews/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://server21.ijui.rs.gov.br/nfsews/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://server21.ijui.rs.gov.br/nfsews/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://server21.ijui.rs.gov.br/nfsews/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://server21.ijui.rs.gov.br/nfsews/Services.svc';
           end;
  4320800: begin // Soledade/RS
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := '';
            ConfigURL.HomConsultaLoteRPS    := '';
            ConfigURL.HomConsultaNFSeRPS    := '';
            ConfigURL.HomConsultaSitLoteRPS := '';
            ConfigURL.HomConsultaNFSe       := '';
            ConfigURL.HomCancelaNFSe        := '';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://177.101.230.30/nfsews/services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://177.101.230.30/nfsews/services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://177.101.230.30/nfsews/services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://177.101.230.30/nfsews/services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://177.101.230.30/nfsews/services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://177.101.230.30/nfsews/services.svc';
           end;
  4322400: begin // Uruguaiana/RS
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://dueto-web.uruguaiana.rs.gov.br:7778/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://dueto-web.uruguaiana.rs.gov.br:7778/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://dueto-web.uruguaiana.rs.gov.br:7778/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://dueto-web.uruguaiana.rs.gov.br:7778/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://dueto-web.uruguaiana.rs.gov.br:7778/NFSEWSTESTE/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://dueto-web.uruguaiana.rs.gov.br:7778/NFSEWSTESTE/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://dueto-web.uruguaiana.rs.gov.br:7778/NFSEWS/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://dueto-web.uruguaiana.rs.gov.br:7778/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://dueto-web.uruguaiana.rs.gov.br:7778/NFSEWS/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://dueto-web.uruguaiana.rs.gov.br:7778/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://dueto-web.uruguaiana.rs.gov.br:7778/NFSEWS/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://dueto-web.uruguaiana.rs.gov.br:7778/NFSEWS/Services.svc';
           end;
 end;

 Result := ConfigURL;
end;

function TProvedorPronim.GetURI(URI: String): String;
begin
 // No provedor Pronim a URI não é informada.
 Result := '';
end;

function TProvedorPronim.GetAssinarXML(Acao: TnfseAcao): Boolean;
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

function TProvedorPronim.GetValidarLote: Boolean;
begin
 Result := False; {Dalvan}
end;

function TProvedorPronim.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + NameSpaceDad;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + NameSpaceDad;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + NameSpaceDad;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio' + NameSpaceDad;
//   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfsePorRpsEnvio' + NameSpaceDad;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseEnvio' + NameSpaceDad;
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + NameSpaceDad +
                             '<' + Prefixo3 + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                 DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
   acGerar:       Result := '';
 end;
end;

function TProvedorPronim.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorPronim.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorPronim.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRpsEnvio>';
//   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfsePorRpsEnvio>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '</' + Prefixo3 + 'Pedido>' +
                            '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '';
 end;
end;

function TProvedorPronim.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, ' xmlns="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"', '', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                       'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<RecepcionarLoteRps xmlns="' + URLNS + '/">' +
              '<xmlEnvio>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                DadosMsg +
              '</xmlEnvio>' +
             '</RecepcionarLoteRps>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorPronim.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, ' xmlns="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"', '', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                       'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<ConsultarSituacaoLoteRps xmlns="' + URLNS + '/">' +
              '<xmlEnvio>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                DadosMsg +
              '</xmlEnvio>' +
             '</ConsultarSituacaoLoteRps>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorPronim.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, ' xmlns="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"', '', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                       'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<ConsultarLoteRps xmlns="' + URLNS + '/">' +
              '<xmlEnvio>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                DadosMsg +
              '</xmlEnvio>' +
             '</ConsultarLoteRps>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorPronim.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, ' xmlns="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"', '', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                       'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<ConsultarNfsePorRps xmlns="' + URLNS + '/">' +
              '<xmlEnvio>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                DadosMsg +
              '</xmlEnvio>' +
             '</ConsultarNfsePorRps>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorPronim.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, ' xmlns="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"', '', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                       'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<ConsultarNfse xmlns="' + URLNS + '/">' +
              '<xmlEnvio>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                DadosMsg +
              '</xmlEnvio>' +
             '</ConsultarNfse>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorPronim.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, ' xmlns="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"', '', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                       'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' +
            '<soap:Body>' +
             '<CancelarNfse xmlns="' + URLNS + '/">' +
              '<xmlEnvio>' +
                DadosMsg +
              '</xmlEnvio>' +
             '</CancelarNfse>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorPronim.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorPronim.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorPronim.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://tempuri.org/INFSEGeracao/RecepcionarLoteRps';
   acConsSit:     Result := 'http://tempuri.org/INFSEConsultas/ConsultarSituacaoLoteRps';
   acConsLote:    Result := 'http://tempuri.org/INFSEConsultas/ConsultarLoteRps';
   acConsNFSeRps: Result := 'http://tempuri.org/INFSEConsultas/ConsultarNfsePorRps';
   acConsNFSe:    Result := 'http://tempuri.org/INFSEConsultas/ConsultarNfse';
   acCancelar:    Result := 'http://tempuri.org/INFSEGeracao/CancelarNfse';
   acGerar:       Result := '';
 end;
end;

function TProvedorPronim.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'RecepcionarLoteRpsResult' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'ConsultarSituacaoLoteRpsResult' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'ConsultarLoteRpsResult' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'ConsultarNfsePorRpsResult' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'ConsultarNfseResult' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'CancelarNfseResult' );
   acGerar:       Result := '';
 end;
end;

function TProvedorPronim.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorPronim.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
var
 sCNPJ: String;
begin

 sCNPJ := ''; // Incluido somente para poder compilar, deve ser feita uma alteração nessa
              // function contemplando a passagem do parametro CNPJ

 case ACodMunicipio of
  4310207: begin // Ijui/RS
            Result := 'http://server21.ijui.rs.gov.br/nfse/VisualizarXMLdaNota.aspx?Prestador=' + sCNPJ +
                      '&Numero=' + IntToStr(ANumeroNFSe) +
                      '&Codigo=' + ACodVerificacao +
                      '&page=default.aspx&origin=ConAut&pdf=true'
           end;
  else Result := '';
 end;
end;

end.
