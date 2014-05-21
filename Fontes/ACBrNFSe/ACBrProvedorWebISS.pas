{$I ACBr.inc}

unit ACBrProvedorWebISS;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorWebISS }

 TProvedorWebISS = class(TProvedorClass)
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

{ TProvedorWebISS }

constructor TProvedorWebISS.Create;
begin
 {----}
end;

function TProvedorWebISS.GetConfigCidade(ACodCidade,
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
  then ConfigCidade.NameSpaceEnvelope := 'http://tempuri.org'
  else ConfigCidade.NameSpaceEnvelope := 'http://tempuri.org';

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorWebISS.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 case ACodCidade of
  3303302, // Niteroi/RJ
  4301602: // Bage/RS
          begin
           ConfigSchema.VersaoCabecalho := '1.00';
           ConfigSchema.VersaoDados     := ''; // '1.00';
           ConfigSchema.VersaoXML       := '1';
           ConfigSchema.NameSpaceXML    := 'http://www.abrasf.org.br/nfse';
           ConfigSchema.Cabecalho       := '';
           ConfigSchema.ServicoEnviar   := 'servico_enviar_lote_rps_envio.xsd';
           ConfigSchema.ServicoConSit   := 'servico_consultar_situacao_lote_rps_envio.xsd';
           ConfigSchema.ServicoConLot   := 'servico_consultar_lote_rps_envio.xsd';
           ConfigSchema.ServicoConRps   := 'servico_consultar_nfse_rps_envio.xsd';
           ConfigSchema.ServicoConNfse  := 'servico_consultar_nfse_envio.xsd';
           ConfigSchema.ServicoCancelar := 'servico_cancelar_nfse_envio.xsd';
           ConfigSchema.ServicoGerar    := 'servico_gerar_nfse_envio.xsd';
           ConfigSchema.DefTipos        := ''; //'tipos_complexos.xsd';
          end;
  else begin
        ConfigSchema.VersaoCabecalho := '1.00';
        ConfigSchema.VersaoDados     := '1.00';
        ConfigSchema.VersaoXML       := '1';
        ConfigSchema.NameSpaceXML    := 'http://www.abrasf.org.br/';
        ConfigSchema.Cabecalho       := 'nfse.xsd';
        ConfigSchema.ServicoEnviar   := 'nfse.xsd';
        ConfigSchema.ServicoConSit   := 'nfse.xsd';
        ConfigSchema.ServicoConLot   := 'nfse.xsd';
        ConfigSchema.ServicoConRps   := 'nfse.xsd';
        ConfigSchema.ServicoConNfse  := 'nfse.xsd';
        ConfigSchema.ServicoCancelar := 'nfse.xsd';
        ConfigSchema.ServicoGerar    := '';
        ConfigSchema.DefTipos        := '';
       end;
 end;
 Result := ConfigSchema;
end;

function TProvedorWebISS.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 case ACodCidade of
  1100049: begin // Cacoal/RO
            ConfigURL.HomNomeCidade := 'cacoalro';
            ConfigURL.ProNomeCidade := 'cacoalro';
           end;
  2800308: begin // Aracaju/SE
            ConfigURL.HomNomeCidade := 'aracajuse';
            ConfigURL.ProNomeCidade := 'aracajuse';
           end;
  2801009: begin // Campo do Brito/SE
            ConfigURL.HomNomeCidade := 'campodobritose';
            ConfigURL.ProNomeCidade := 'campodobritose';
           end;
  2802106: begin // Estância/SE
            ConfigURL.HomNomeCidade := 'estanciase';
            ConfigURL.ProNomeCidade := 'estanciase';
           end;
  2803500: begin // Lagarto/SE
            ConfigURL.HomNomeCidade := 'lagartose';
            ConfigURL.ProNomeCidade := 'lagartose';
           end;
  2901007: begin // Amargosa/BA
            ConfigURL.HomNomeCidade := 'amargosaba';
            ConfigURL.ProNomeCidade := 'amargosaba';
           end;
  2901106: begin // Amelia Rodrigues/BA
            ConfigURL.HomNomeCidade := 'ameliarodriguesba';
            ConfigURL.ProNomeCidade := 'ameliarodriguesba';
           end;
  2910800: begin // Feira de Santana/BA
            ConfigURL.HomNomeCidade := 'feiradesantanaba';
            ConfigURL.ProNomeCidade := 'feiradesantanaba';
           end;
  3104205: begin // Arcos/MG
            ConfigURL.HomNomeCidade := 'arcosmg';
            ConfigURL.ProNomeCidade := 'arcosmg';
           end;
  2907509: begin // Catu/BA
            ConfigURL.HomNomeCidade := 'catuba';
            ConfigURL.ProNomeCidade := 'catuba';
           end;
  2925204: begin // Pojuca/BA
            ConfigURL.HomNomeCidade := 'bapojuca';
            ConfigURL.ProNomeCidade := 'bapojuca';
           end;
  3101508: begin // Alem Paraiba/MG
            ConfigURL.HomNomeCidade := 'alemparaibamg';
            ConfigURL.ProNomeCidade := 'alemparaibamg';
           end;
  3105608: begin // Barbacena/MG
            ConfigURL.HomNomeCidade := 'mgbarbacena';
            ConfigURL.ProNomeCidade := 'mgbarbacena';
           end;
  3105905: begin // Barroso/MG
            ConfigURL.HomNomeCidade := 'barrosomg';
            ConfigURL.ProNomeCidade := 'barrosomg';
           end;
  3110202: begin // Cajuri/MG
            ConfigURL.HomNomeCidade := 'cajurimg';
            ConfigURL.ProNomeCidade := 'cajurimg';
           end;
  3110509: begin // Camanducaia/MG
            ConfigURL.HomNomeCidade := 'camanducaiamg';
            ConfigURL.ProNomeCidade := 'camanducaiamg';
           end;
  3111200: begin // Campo Belo/MG
            ConfigURL.HomNomeCidade := 'campobelomg';
            ConfigURL.ProNomeCidade := 'campobelomg';
           end;
  3119401: begin // Coronel Fabriciano/MG
            ConfigURL.HomNomeCidade := 'fabriciano';
            ConfigURL.ProNomeCidade := 'fabriciano';
           end;
  3126109: begin // Formiga/MG
            ConfigURL.HomNomeCidade := 'formigamg';
            ConfigURL.ProNomeCidade := 'formigamg';
           end;
  3127107: begin // Frutal/MG
            ConfigURL.HomNomeCidade := 'mgfrutal';
            ConfigURL.ProNomeCidade := 'mgfrutal';
           end;
  3133808: begin // Itaúna/MG
            ConfigURL.HomNomeCidade := 'itauna';
            ConfigURL.ProNomeCidade := 'itauna';
           end;
  3136207: begin // João Monlevade/MG
            ConfigURL.HomNomeCidade := 'mgjoaomonlevade';
            ConfigURL.ProNomeCidade := 'mgjoaomonlevade';
           end;
  3150703: begin // Pirajuba/MG
            ConfigURL.HomNomeCidade := 'pirajubamg';
            ConfigURL.ProNomeCidade := 'pirajubamg';
           end;
  3152303: begin // Porto Firme/MG
            ConfigURL.HomNomeCidade := 'portofirmemg';
            ConfigURL.ProNomeCidade := 'portofirmemg';
           end;
  3155702: begin // Rio Piracicaba/MG
            ConfigURL.HomNomeCidade := 'riopiracicabamg';
            ConfigURL.ProNomeCidade := 'riopiracicabamg';
           end;
  3159605: begin // Santa Rita do Sapucaí/MG
            ConfigURL.HomNomeCidade := 'santaritadosapucai';
            ConfigURL.ProNomeCidade := 'santaritadosapucai';
           end;
  3162104: begin // São Gotardo/MG
            ConfigURL.HomNomeCidade := 'saogotardomg';
            ConfigURL.ProNomeCidade := 'saogotardomg';
           end;
  3170107: begin // Uberaba/MG
            ConfigURL.HomNomeCidade := 'Uberaba';
            ConfigURL.ProNomeCidade := 'Uberaba';
           end;
  3300209: begin // Araruama/RJ
            ConfigURL.HomNomeCidade := 'araruama';
            ConfigURL.ProNomeCidade := 'araruama';
           end;
  3300803: begin // Cachoeiras de Macacu/RJ
            ConfigURL.HomNomeCidade := 'cachoeirasdemacacurj';
            ConfigURL.ProNomeCidade := 'cachoeirasdemacacurj';
           end;
  3301207: begin // Carmo/RJ
            ConfigURL.HomNomeCidade := 'carmorj';
            ConfigURL.ProNomeCidade := 'carmorj';
           end;
  3301306: begin // Casimiro de Abreu/RJ
            ConfigURL.HomNomeCidade := 'casimirodeabreurj';
            ConfigURL.ProNomeCidade := 'casimirodeabreurj';
           end;
  3301504: begin // Cordeiro/RJ
            ConfigURL.HomNomeCidade := 'cordeirorj';
            ConfigURL.ProNomeCidade := 'cordeirorj';
           end;
  3302908: begin // Miguel Pereira/RJ
            ConfigURL.HomNomeCidade := 'miguelpereirarj';
            ConfigURL.ProNomeCidade := 'miguelpereirarj';
           end;
  3303302: begin // Niteroi/RJ
            ConfigURL.HomNomeCidade := 'rjniteroi';
            ConfigURL.ProNomeCidade := 'rjniteroi';
           end;
  3303401: begin // Nova Friburgo/RJ
            ConfigURL.HomNomeCidade := 'rjnovafriburgo';
            ConfigURL.ProNomeCidade := 'rjnovafriburgo';
           end;
  3303856: begin // Paty do Alferes/RJ
            ConfigURL.HomNomeCidade := 'patydoalferesrj';
            ConfigURL.ProNomeCidade := 'patydoalferesrj';
           end;
  3304110: begin // Porto Real/RJ
            ConfigURL.HomNomeCidade := 'rjportoreal';
            ConfigURL.ProNomeCidade := 'rjportoreal';
           end;
  3304144: begin // Queimados/RJ
            ConfigURL.HomNomeCidade := 'queimadosrj';
            ConfigURL.ProNomeCidade := 'queimadosrj';
           end;
  3304607: begin // Santa Maria Madalena/RJ
            ConfigURL.HomNomeCidade := 'santamariamadalenarj';
            ConfigURL.ProNomeCidade := 'santamariamadalenarj';
           end;
  3305000: begin // São João da Barra/RJ
            ConfigURL.HomNomeCidade := 'saojoaodabarrarj';
            ConfigURL.ProNomeCidade := 'saojoaodabarrarj';
           end;
  3305604: begin // Silva Jardim/RJ
            ConfigURL.HomNomeCidade := 'silvajardimrj';
            ConfigURL.ProNomeCidade := 'silvajardimrj';
           end;
  3305802: begin // Teresópolis/RJ
            ConfigURL.HomNomeCidade := 'rjteresopolis';
            ConfigURL.ProNomeCidade := 'rjteresopolis';
           end;
  4210100: begin // Mafra/SC
            ConfigURL.HomNomeCidade := 'mafrasc';
            ConfigURL.ProNomeCidade := 'mafrasc';
           end;
  4301602: begin // Bage/RS
            ConfigURL.HomNomeCidade := 'bagers';
            ConfigURL.ProNomeCidade := 'bagers';
           end;
  5101308: begin // Arenapolis/MT
            ConfigURL.HomNomeCidade := 'arenapolismt';
            ConfigURL.ProNomeCidade := 'arenapolismt';
           end;
  5101704: begin // Barra do Bugres/MT
            ConfigURL.HomNomeCidade := 'barradobugresmt';
            ConfigURL.ProNomeCidade := 'barradobugresmt';
           end;
  5105259: begin // Lucas do Rio Verde/MT
            ConfigURL.HomNomeCidade := 'lucasdorioverdemt';
            ConfigURL.ProNomeCidade := 'lucasdorioverdemt';
           end;
  5107909: begin // Sinop/MT
            ConfigURL.HomNomeCidade := 'sinop';
            ConfigURL.ProNomeCidade := 'sinop';
           end;
  5107958: begin // Tangara da Serra/MT
            ConfigURL.HomNomeCidade := 'tangaradaserramt';
            ConfigURL.ProNomeCidade := 'tangaradaserramt';
           end;
  5204508: begin // Caldas Novas/GO
            ConfigURL.HomNomeCidade := 'caldasnovasgo';
            ConfigURL.ProNomeCidade := 'caldasnovasgo';
           end;
  2919553: begin // Luiz Eduardo Magalhães/BA
            ConfigURL.HomNomeCidade := 'luiseduardomagalhaesba';
            ConfigURL.ProNomeCidade := 'luiseduardomagalhaesba';
           end;
 end;

 case ACodCidade of
  2925204,
  3105608,
  3119401,
  3127107,
  3133808,
  3136207,
  3159605,
  3300209,
  3300803,
  5107909: begin
            ConfigURL.HomRecepcaoLoteRPS    := 'https://www.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaLoteRPS    := 'https://www.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'https://www.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'https://www.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaNFSe       := 'https://www.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomCancelaNFSe        := 'https://www.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';

            ConfigURL.ProRecepcaoLoteRPS    := 'https://www.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaLoteRPS    := 'https://www.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'https://www.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'https://www.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaNFSe       := 'https://www.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProCancelaNFSe        := 'https://www.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
           end;

  2901007,
  2907509,
  3104205,
  3105905,
  3110509,
  3111200,
  3126109,
  3170107,
  3302908,
  3303401,
  3303856,
  3304110,
  3304144,
  3305802,
  4301602,
  5105259: begin
            ConfigURL.HomRecepcaoLoteRPS    := 'https://www1.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaLoteRPS    := 'https://www1.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'https://www1.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'https://www1.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaNFSe       := 'https://www1.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomCancelaNFSe        := 'https://www1.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomGerarNFSe          := 'https://www1.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';

            ConfigURL.ProRecepcaoLoteRPS    := 'https://www1.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaLoteRPS    := 'https://www1.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'https://www1.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'https://www1.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaNFSe       := 'https://www1.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProCancelaNFSe        := 'https://www1.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProGerarNFSe          := 'https://www1.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
           end;

  2800308,
  2801009,
  2803500,
  2802106,
  2910800,
  3303302,
  3155702,
  3301504,
  3304607,
  3305604,
  5204508: begin
            ConfigURL.HomRecepcaoLoteRPS    := 'https://www3.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaLoteRPS    := 'https://www3.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'https://www3.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'https://www3.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaNFSe       := 'https://www3.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomCancelaNFSe        := 'https://www3.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';

            ConfigURL.ProRecepcaoLoteRPS    := 'https://www3.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaLoteRPS    := 'https://www3.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'https://www3.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'https://www3.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaNFSe       := 'https://www3.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProCancelaNFSe        := 'https://www3.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
           end;

  1100049,
  2901106,
  3101508,
  3110202,
  3150703,
  3152303,
  3162104,
  3301207,
  3301306,
  5101308,
  5101704,
  5107958,
  2919553: begin
            ConfigURL.HomRecepcaoLoteRPS    := 'https://www4.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaLoteRPS    := 'https://www4.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'https://www4.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'https://www4.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaNFSe       := 'https://www4.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomCancelaNFSe        := 'https://www4.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';

            ConfigURL.ProRecepcaoLoteRPS    := 'https://www4.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaLoteRPS    := 'https://www4.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'https://www4.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'https://www4.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaNFSe       := 'https://www4.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProCancelaNFSe        := 'https://www4.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
           end;

  4210100: begin 
            ConfigURL.HomRecepcaoLoteRPS    := 'https://www5.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaLoteRPS    := 'https://www5.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaNFSeRPS    := 'https://www5.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaSitLoteRPS := 'https://www5.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomConsultaNFSe       := 'https://www5.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';
            ConfigURL.HomCancelaNFSe        := 'https://www5.webiss.com.br/' + ConfigURL.HomNomeCidade + '_wsnfse_homolog/NfseServices.svc';

            ConfigURL.ProRecepcaoLoteRPS    := 'https://www5.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaLoteRPS    := 'https://www5.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaNFSeRPS    := 'https://www5.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaSitLoteRPS := 'https://www5.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProConsultaNFSe       := 'https://www5.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
            ConfigURL.ProCancelaNFSe        := 'https://www5.webiss.com.br/' + ConfigURL.ProNomeCidade + '_wsnfse/NfseServices.svc';
           end;
 end;


 Result := ConfigURL;
end;

function TProvedorWebISS.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorWebISS.GetAssinarXML(Acao: TnfseAcao): Boolean;
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

function TProvedorWebISS.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorWebISS.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
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
   acGerar:       Result := '<' + Prefixo3 + 'GerarNfseEnvio' + NameSpaceDad;
 end;
end;

function TProvedorWebISS.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorWebISS.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorWebISS.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRpsEnvio>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '</' + Prefixo3 + 'Pedido>' +
                            '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '</' + Prefixo3 + 'GerarNfseEnvio>';
 end;
end;

function TProvedorWebISS.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<RecepcionarLoteRps xmlns="' + URLNS + '/">' +
              '<cabec>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</cabec>' +
              '<msg>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</msg>' +
             '</RecepcionarLoteRps>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorWebISS.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarSituacaoLoteRps xmlns="' + URLNS + '/">' +
              '<cabec>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</cabec>' +
              '<msg>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</msg>' +
             '</ConsultarSituacaoLoteRps>' +
             '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorWebISS.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarLoteRps xmlns="' + URLNS + '/">' +
              '<cabec>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</cabec>' +
              '<msg>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</msg>' +
             '</ConsultarLoteRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorWebISS.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarNfsePorRps xmlns="' + URLNS + '/">' +
              '<cabec>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</cabec>' +
              '<msg>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</msg>' +
             '</ConsultarNfsePorRps>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorWebISS.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<ConsultarNfse xmlns="' + URLNS + '/">' +
              '<cabec>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</cabec>' +
              '<msg>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</msg>' +
             '</ConsultarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorWebISS.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Body>' +
             '<CancelarNfse xmlns="' + URLNS + '/">' +
              '<cabec>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</cabec>' +
              '<msg>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</msg>' +
             '</CancelarNfse>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorWebISS.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<GerarNfse xmlns="' + URLNS + '/">' +
              '<cabec>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</cabec>' +
              '<msg>' +
                '&lt;?xml version="1.0" encoding="UTF-8"?&gt;' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</msg>' +
             '</GerarNfse>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorWebISS.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

function TProvedorWebISS.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://tempuri.org/INfseServices/RecepcionarLoteRps';
   acConsSit:     Result := 'http://tempuri.org/INfseServices/ConsultarSituacaoLoteRps';
   acConsLote:    Result := 'http://tempuri.org/INfseServices/ConsultarLoteRps';
   acConsNFSeRps: Result := 'http://tempuri.org/INfseServices/ConsultarNfsePorRps';
   acConsNFSe:    Result := 'http://tempuri.org/INfseServices/ConsultarNfse';
   acCancelar:    Result := 'http://tempuri.org/INfseServices/CancelarNfse';
   acGerar:       Result := 'http://tempuri.org/INfseServices/GerarNfse';
 end;
end;

function TProvedorWebISS.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'RecepcionarLoteRpsResult' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'ConsultarSituacaoLoteRpsResult' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'ConsultarLoteRpsResult' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'ConsultarNfsePorRpsResult' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'ConsultarNfseResult' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'CancelarNfseResult' );
   acGerar:       Result := SeparaDados( RetornoWS, 'GerarNfseResult' );
 end;
end;

function TProvedorWebISS.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/nfse">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorWebISS.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

end.
