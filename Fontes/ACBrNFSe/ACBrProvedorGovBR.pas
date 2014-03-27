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
 ConfigCidade.Prefixo4      := 'tc:'; // Alterado por Italo em 05/02/2014
 ConfigCidade.Identificador := 'id';

 if AAmbiente = 1
  then ConfigCidade.NameSpaceEnvelope := 'http://tempuri.org'
  else ConfigCidade.NameSpaceEnvelope := 'http://tempuri.org';

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := False;

 Result := ConfigCidade;
end;

function TProvedorGovBR.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '1.00';
 ConfigSchema.VersaoDados     := '1.00';
 ConfigSchema.VersaoXML       := '1';

// case ACodCidade of
//  4102000,       // Assis Chateaubriand/PR
//  4321709: begin // Tres Coroas/RS
            ConfigSchema.NameSpaceXML    := 'http://tempuri.org/';
            ConfigSchema.Cabecalho       := '';
            ConfigSchema.ServicoEnviar   := 'servico_enviar_lote_rps_envio.xsd';
            ConfigSchema.ServicoConSit   := 'servico_consultar_situacao_lote_rps_envio.xsd';
            ConfigSchema.ServicoConLot   := 'servico_consultar_lote_rps_envio.xsd';
            ConfigSchema.ServicoConRps   := 'servico_consultar_nfse_rps_envio';
            ConfigSchema.ServicoConNfse  := 'servico_consultar_nfse_envio';
            ConfigSchema.ServicoCancelar := 'servico_cancelar_nfse_envio';
            ConfigSchema.DefTipos        := 'tipos_complexos.xsd'; // Alterado por Italo em 05/02/2014
(*
           end;
  else     begin
            ConfigSchema.NameSpaceXML    := 'http://www.abrasf.org.br/ABRASF/arquivos/';
            ConfigSchema.Cabecalho       := 'nfse.xsd';
            ConfigSchema.ServicoEnviar   := 'nfse.xsd';
            ConfigSchema.ServicoConSit   := 'nfse.xsd';
            ConfigSchema.ServicoConLot   := 'nfse.xsd';
            ConfigSchema.ServicoConRps   := 'nfse.xsd';
            ConfigSchema.ServicoConNfse  := 'nfse.xsd';
            ConfigSchema.ServicoCancelar := 'nfse.xsd';
            ConfigSchema.DefTipos        := '';
           end;
 end;
*)
 Result := ConfigSchema;
end;

function TProvedorGovBR.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 case ACodCidade of
 (*
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
           *)
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
            ConfigURL.ProRecepcaoLoteRPS    := 'http://nfse.guarapari.es.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://nfse.guarapari.es.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://nfse.guarapari.es.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://nfse.guarapari.es.gov.br/NFSEws/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://nfse.guarapari.es.gov.br/NFSEws/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://nfse.guarapari.es.gov.br/NFSEws/Services.svc';
           end;
           (*
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
           *)
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
           (*
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
           *)
           (*
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
           *)
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
  4101408: begin // Apucarana/PR
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := '';
            ConfigURL.HomConsultaLoteRPS    := '';
            ConfigURL.HomConsultaNFSeRPS    := '';
            ConfigURL.HomConsultaSitLoteRPS := '';
            ConfigURL.HomConsultaNFSe       := '';
            ConfigURL.HomCancelaNFSe        := '';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://cetil.apucarana.pr.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://cetil.apucarana.pr.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://cetil.apucarana.pr.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://cetil.apucarana.pr.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://cetil.apucarana.pr.gov.br/NFSEWS/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://cetil.apucarana.pr.gov.br/NFSEWS/Services.svc';
           end;
  4102000: begin // Assis Chateaubriand/PR
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://201.89.84.202:8184/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://201.89.84.202:8184/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://201.89.84.202:8184/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://201.89.84.202:8184/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://201.89.84.202:8184/nfsewsteste/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://201.89.84.202:8184/nfsewsteste/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://201.89.84.202:8184/nfsews/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://201.89.84.202:8184/nfsews/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://201.89.84.202:8184/nfsews/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://201.89.84.202:8184/nfsews/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://201.89.84.202:8184/nfsews/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://201.89.84.202:8184/nfsews/Services.svc';
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
           (*
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
           *)
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
  4321709: begin // Tres Coroas/RS
            ConfigURL.HomNomeCidade         := '';
            ConfigURL.HomRecepcaoLoteRPS    := 'http://nfseteste.pmtcoroas.com.br/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaLoteRPS    := 'http://nfseteste.pmtcoroas.com.br/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'http://nfseteste.pmtcoroas.com.br/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'http://nfseteste.pmtcoroas.com.br/nfsewsteste/Services.svc';
            ConfigURL.HomConsultaNFSe       := 'http://nfseteste.pmtcoroas.com.br/nfsewsteste/Services.svc';
            ConfigURL.HomCancelaNFSe        := 'http://nfseteste.pmtcoroas.com.br/nfsewsteste/Services.svc';

            ConfigURL.ProNomeCidade         := '';
            ConfigURL.ProRecepcaoLoteRPS    := 'http://nfse.pmtcoroas.com.br/nfsews/Services.svc';
            ConfigURL.ProConsultaLoteRPS    := 'http://nfse.pmtcoroas.com.br/nfsews/Services.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'http://nfse.pmtcoroas.com.br/nfsews/Services.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'http://nfse.pmtcoroas.com.br/nfsews/Services.svc';
            ConfigURL.ProConsultaNFSe       := 'http://nfse.pmtcoroas.com.br/nfsews/Services.svc';
            ConfigURL.ProCancelaNFSe        := 'http://nfse.pmtcoroas.com.br/nfsews/Services.svc';
           end;
  {4322400: begin // Uruguaiana/RS
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
           end;}
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
