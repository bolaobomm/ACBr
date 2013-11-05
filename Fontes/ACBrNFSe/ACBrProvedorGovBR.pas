{$I ACBr.inc}

unit ACBrProvedorGovBR;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorGovBR }

 TProvedorGovBR = class(TProvedorClass)
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

{ TProvedorGovBR }

constructor TProvedorGovBR.Create;
begin
 {----}
end;

function TProvedorGovBR.GetConfigCidade(ACodCidade,
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

 if ACodCidade = 3205309
  then begin // Vitória/ES
   ConfigCidade.AssinaRPS  := False;
   ConfigCidade.AssinaLote := True;
  end
  else begin
   ConfigCidade.AssinaRPS  := False;
   ConfigCidade.AssinaLote := False;
  end;

 Result := ConfigCidade;
end;

function TProvedorGovBR.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
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

function TProvedorGovBR.GetConfigURL(ACodCidade: Integer): TConfigURL;
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
  3143302: begin // Montes Claros/MG
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://nfeteste.montesclaros.mg.gov.br:8081/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://nfeteste.montesclaros.mg.gov.br:8081/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://nfeteste.montesclaros.mg.gov.br:8081/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://nfeteste.montesclaros.mg.gov.br:8081/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://nfeteste.montesclaros.mg.gov.br:8081/nfsewsteste/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://nfeteste.montesclaros.mg.gov.br:8081/nfsewsteste/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://nfe.montesclaros.mg.gov.br:8082/NFSEws/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://nfe.montesclaros.mg.gov.br:8082/NFSEws/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://nfe.montesclaros.mg.gov.br:8082/NFSEws/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://nfe.montesclaros.mg.gov.br:8082/NFSEws/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://nfe.montesclaros.mg.gov.br:8082/NFSEws/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://nfe.montesclaros.mg.gov.br:8082/NFSEws/Services.svc';
           end;
  3202405: begin // Guarapari/ES
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://nfseteste.guarapari.es.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://nfseteste.guarapari.es.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://nfseteste.guarapari.es.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://nfseteste.guarapari.es.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://nfseteste.guarapari.es.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://nfseteste.guarapari.es.gov.br/NFSEWSTESTE/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://nfes.guarapari.es.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://nfes.guarapari.es.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://nfes.guarapari.es.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://nfes.guarapari.es.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://nfes.guarapari.es.gov.br/NFSEws/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://nfes.guarapari.es.gov.br/NFSEws/Services.svc';
           end;
  3205309: begin // Vitória/ES
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'https://wsnfsehomologa.vitoria.es.gov.br/NotaFiscalService.asmx';
            ConfigURL.HomConsultaLoteRPS    := 'https://wsnfsehomologa.vitoria.es.gov.br/NotaFiscalService.asmx';
            ConfigURL.HomConsultaNFSeRPS    := 'https://wsnfsehomologa.vitoria.es.gov.br/NotaFiscalService.asmx';
            ConfigURL.HomConsultaSitLoteRPS := 'https://wsnfsehomologa.vitoria.es.gov.br/NotaFiscalService.asmx';
            ConfigURL.HomConsultaNFSe       := 'https://wsnfsehomologa.vitoria.es.gov.br/NotaFiscalService.asmx';
            ConfigURL.HomCancelaNFSe        := 'https://wsnfsehomologa.vitoria.es.gov.br/NotaFiscalService.asmx';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'https://wsnfse.vitoria.es.gov.br/NotaFiscalService.asmx';
            ConfigURL.ProConsultaLoteRPS    := 'https://wsnfse.vitoria.es.gov.br/NotaFiscalService.asmx';
            ConfigURL.ProConsultaNFSeRPS    := 'https://wsnfse.vitoria.es.gov.br/NotaFiscalService.asmx';
            ConfigURL.ProConsultaSitLoteRPS := 'https://wsnfse.vitoria.es.gov.br/NotaFiscalService.asmx';
            ConfigURL.ProConsultaNFSe       := 'https://wsnfse.vitoria.es.gov.br/NotaFiscalService.asmx';
            ConfigURL.ProCancelaNFSe        := 'https://wsnfse.vitoria.es.gov.br/NotaFiscalService.asmx';
            (*
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://nfseteste.vitoria.es.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://nfseteste.vitoria.es.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://nfseteste.vitoria.es.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://nfseteste.vitoria.es.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://nfseteste.vitoria.es.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://nfseteste.vitoria.es.gov.br/NFSEWSTESTE/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://nfes.vitoria.es.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://nfes.vitoria.es.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://nfes.vitoria.es.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://nfes.vitoria.es.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://nfes.vitoria.es.gov.br/NFSEws/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://nfes.vitoria.es.gov.br/NFSEws/Services.svc';
            *)
           end;
  3305505: begin // Saquarema/RJ
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://nfe.saquarema.rj.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://nfe.saquarema.rj.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://nfe.saquarema.rj.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://nfe.saquarema.rj.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://nfe.saquarema.rj.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://nfe.saquarema.rj.gov.br/NFSEWSTESTE/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://nfe.saquarema.rj.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://nfe.saquarema.rj.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://nfe.saquarema.rj.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://nfe.saquarema.rj.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://nfe.saquarema.rj.gov.br/NFSEws/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://nfe.saquarema.rj.gov.br/NFSEws/Services.svc';
           end;
  3504008: begin // Assis/SP
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://nfseteste.assis.sp.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://nfseteste.assis.sp.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://nfseteste.assis.sp.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://nfseteste.assis.sp.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://nfseteste.assis.sp.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://nfseteste.assis.sp.gov.br/NFSEWSTESTE/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://nfse.assis.sp.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://nfse.assis.sp.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://nfse.assis.sp.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://nfse.assis.sp.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://nfse.assis.sp.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://nfse.assis.sp.gov.br/NFSEWS/Services.svc';
           end;
  3511102: begin // Catanduva/SP por fnietto
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://nfse.catanduva.sp.gov/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://nfse.catanduva.sp.gov/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://nfse.catanduva.sp.gov/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://nfse.catanduva.sp.gov/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://nfse.catanduva.sp.gov/NFSEWSTESTE/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://nfse.catanduva.sp.gov/NFSEWSTESTE/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://nfse.catanduva.sp.gov/NFSEWS/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://nfse.catanduva.sp.gov/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://nfse.catanduva.sp.gov/NFSEWS/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://nfse.catanduva.sp.gov/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://nfse.catanduva.sp.gov/NFSEWS/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://nfse.catanduva.sp.gov/NFSEWS/Services.svc';
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
  3541505: begin // Presidente Venceslau/SP
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://mail.presidentevenceslau.sp.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://mail.presidentevenceslau.sp.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://mail.presidentevenceslau.sp.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://mail.presidentevenceslau.sp.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://mail.presidentevenceslau.sp.gov.br/NFSEWSTESTE/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://mail.presidentevenceslau.sp.gov.br/NFSEWSTESTE/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://mail.presidentevenceslau.sp.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://mail.presidentevenceslau.sp.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://mail.presidentevenceslau.sp.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://mail.presidentevenceslau.sp.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://mail.presidentevenceslau.sp.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://mail.presidentevenceslau.sp.gov.br/NFSEWS/Services.svc';
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
 end;

 Result := ConfigURL;
end;

function TProvedorGovBR.GetURI(URI: String): String;
begin
 // No provedor GovBR a URI não é informada.
 Result := '';
end;

function TProvedorGovBR.GetAssinarXML(Acao: TnfseAcao): Boolean;
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

function TProvedorGovBR.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorGovBR.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
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

function TProvedorGovBR.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorGovBR.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorGovBR.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
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

function TProvedorGovBR.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, ' xmlns="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"', '', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<RecepcionarLoteRps xmlns="' + URLNS + '/">' +
              '<xmlEnvio>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                DadosMsg +
              '</xmlEnvio>' +
             '</RecepcionarLoteRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGovBR.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, ' xmlns="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"', '', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarSituacaoLoteRps xmlns="' + URLNS + '/">' +
              '<xmlEnvio>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                DadosMsg +
              '</xmlEnvio>' +
             '</ConsultarSituacaoLoteRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGovBR.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, ' xmlns="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"', '', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarLoteRps xmlns="' + URLNS + '/">' +
              '<xmlEnvio>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                DadosMsg +
              '</xmlEnvio>' +
             '</ConsultarLoteRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGovBR.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, ' xmlns="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"', '', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarNfsePorRps xmlns="' + URLNS + '/">' +
              '<xmlEnvio>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                DadosMsg +
              '</xmlEnvio>' +
             '</ConsultarNfsePorRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGovBR.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, ' xmlns="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"', '', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarNfse xmlns="' + URLNS + '/">' +
              '<xmlEnvio>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                DadosMsg +
              '</xmlEnvio>' +
             '</ConsultarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGovBR.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 DadosMsg :=StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, '>', '&gt;', [rfReplaceAll]);
 DadosMsg :=StringReplace(DadosMsg, ' xmlns="http://www.abrasf.org.br/ABRASF/arquivos/nfse.xsd"', '', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<CancelarNfse xmlns="' + URLNS + '/">' +
              '<xmlEnvio>' +
                DadosMsg +
              '</xmlEnvio>' +
             '</CancelarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorGovBR.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorGovBR.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorGovBR.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
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

function TProvedorGovBR.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
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

function TProvedorGovBR.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorGovBR.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
