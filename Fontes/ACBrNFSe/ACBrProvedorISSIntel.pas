{$I ACBr.inc}

unit ACBrProvedorISSIntel;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorISSIntel }

 TProvedorISSIntel = class(TProvedorClass)
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
   (*
   function Gera_DadosMsgEnviarLote(Prefixo3, Prefixo4, Identificador,
                                    NameSpaceDad, VersaoDados, VersaoXML,
                                    NumeroLote, CNPJ, IM, QtdeNotas: String;
                                    Notas, TagI, TagF: AnsiString): AnsiString; OverRide;
   function Gera_DadosMsgConsLote(Prefixo3, Prefixo4, NameSpaceDad,
                                  VersaoXML, Protocolo, CNPJ, IM: String;
                                  TagI, TagF: AnsiString): AnsiString; OverRide;
   function Gera_DadosMsgConsNFSeRPS(Prefixo3, Prefixo4, NameSpaceDad, VersaoXML,
                                     NumeroRps, SerieRps, TipoRps, CNPJ, IM: String;
                                     TagI, TagF: AnsiString): AnsiString; OverRide;
   function Gera_DadosMsgConsNFSe(Prefixo3, Prefixo4, NameSpaceDad, VersaoXML,
                                  CNPJ, IM: String;
                                  DataInicial, DataFinal: TDateTime;
                                  TagI, TagF: AnsiString; NumeroNFSe: string = ''): AnsiString; OverRide;
   function Gera_DadosMsgCancelarNFSe(Prefixo4, NameSpaceDad, NumeroNFSe, CNPJ, IM,
                                      CodMunicipio, CodCancelamento: String;
                                      TagI, TagF: AnsiString): AnsiString; OverRide;
   *)
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

{ TProvedorISSIntel }

constructor TProvedorISSIntel.Create;
begin
 {----}
end;

function TProvedorISSIntel.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.1';
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := '';
 ConfigCidade.Prefixo4      := '';
 ConfigCidade.Identificador := 'Id';

 case ACodCidade of
  1709500: begin // Gurupi/TO
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://gurupi-to.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://gurupi-to.treino-issintel.com.br/webservices/abrasf/api';
           end;
  2112209: begin // Timon/MA
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://timon-ma.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://timon-ma.treino-issintel.com.br/webservices/abrasf/api';
           end;
  2207009: begin // Oeiras/PI
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://oeiras-pi.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://oeiras-pi.treino-issintel.com.br/webservices/abrasf/api';
           end;
  2208007: begin // Picos/PI
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://picos-pi.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://picos-pi.treino-issintel.com.br/webservices/abrasf/api';
           end;
  2211209: begin // Uru�u�/PI
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://urucui-pi.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://urucui-pi.treino-issintel.com.br/webservices/abrasf/api';
           end;
  2307304: begin // Juazeiro do Norte/CE
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://juazeirodonorte-ce.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://juazeirodonorte-ce.treino-issintel.com.br/webservices/abrasf/api';
           end;
  2910727: begin // Eunapolis/BA
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://eunapolis-ba.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://eunapolis-ba.treino-issintel.com.br/webservices/abrasf/api';
           end;
  2925303: begin // Porto Seguro/BA
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://portoseguro-ba.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://portoseguro-ba.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3107109: begin // Boa Esperan�a/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://boaesperanca-mg.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://boaesperanca-mg.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3112505: begin // Capim Branco/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://capimbranco-mg.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://capimbranco-mg.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3113305: begin // Carangola/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://carangola-mg.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://carangola-mg.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3114402: begin // Carmo do Rio Claro/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://carmodorioclaro-mg.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://carmodorioclaro-mg.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3116605: begin // Cl�udio/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://claudio-mg.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://claudio-mg.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3128006: begin // Guanh�es/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://guanhaes-mg.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://guanhaes-mg.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3128105: begin // Guap�/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://guape-mg.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://guape-mg.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3131307: begin // Ipatinga/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://ipatinga-mg.issintel.com.br:442/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://ipatinga-mg.treino-issintel.com.br:442/webservices/abrasf/api';
           end;
//  3157807: begin // Santa Luzia/MG
//            if AAmbiente = 1
//             then ConfigCidade.NameSpaceEnvelope := 'https://santaluzia-mg.issintel.com.br/webservices/abrasf/api'
//             else ConfigCidade.NameSpaceEnvelope := 'https://santaluzia-mg.treino-issintel.com.br/webservices/abrasf/api';
//           end;
  3147907: begin // Passos/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://passos-mg.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://passos-mg.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3148004: begin // Patos de Minas/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://patosdeminas-mg.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://patosdeminas-mg.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3149903: begin // Perd�es/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://perdoes-mg.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://perdoes-mg.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3151503: begin // Piumhi/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://piumhi-mg.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://piumhi-mg.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3152600: begin // Pouso Alto/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://pousoalto-mg.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://pousoalto-mg.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3153905: begin // Raposos/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://raposos-mg.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://raposos-mg.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3170800: begin // V�rzea da Palma/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://varzeadapalma-mg.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://varzeadapalma-mg.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3171303: begin // Vi�osa/MG
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://vicosa-mg.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://vicosa-mg.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3200102: begin // Afonso Cl�udio/ES
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://afonsoclaudio-es.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://afonsoclaudio-es.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3200300: begin // Alfredo Chaves/ES
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://alfredochaves-es.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://alfredochaves-es.treino-issintel.com.br/webservices/abrasf/api';
           end;
  3204708: begin // S�o Gabriel da Palha/ES
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://saogabrieldapalha-es.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://saogabrieldapalha-es.treino-issintel.com.br/webservices/abrasf/api';
           end;
  4109609: begin // Guaratuba/PR
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://guaratuba-pr.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://guaratuba-pr.treino-issintel.com.br/webservices/abrasf/api';
           end;
  4300406: begin // Alegrete/RS
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://alegrete-rs.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://alegrete-rs.treino-issintel.com.br/webservices/abrasf/api';
           end;
  4313953: begin // Pantano Grande/RS
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://pantanogrande-rs.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://pantanogrande-rs.treino-issintel.com.br/webservices/abrasf/api';
           end;
  5106505: begin // Pocon�/MT
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://pocone-mt.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://pocone-mt.treino-issintel.com.br/webservices/abrasf/api';
           end;
  5106778: begin // Porto Alegre do Norte/MT
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://portoalegredonorte-mt.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://portoalegredonorte-mt.treino-issintel.com.br/webservices/abrasf/api';
           end;
  5107107: begin // S�o Jos� dos Quatro Marcos/MT
            if AAmbiente = 1
             then ConfigCidade.NameSpaceEnvelope := 'https://saojosedosquatromarcos-mt.issintel.com.br/webservices/abrasf/api'
             else ConfigCidade.NameSpaceEnvelope := 'https://saojosedosquatromarcos-mt.treino-issintel.com.br/webservices/abrasf/api';
           end;
 end;
 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorISSIntel.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '1.00';
 ConfigSchema.VersaoDados     := '1.00';
 ConfigSchema.VersaoXML       := '2';
 ConfigSchema.NameSpaceXML    := 'http://www.abrasf.org.br/';
// ConfigSchema.NameSpaceXML    := 'http://www.abrasf.org.br/ABRASF/arquivos/';
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

function TProvedorISSIntel.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
 Porta: String;
begin
 case ACodCidade of
  1709500: begin // Gurupi/TO
            ConfigURL.HomNomeCidade := 'gurupi-to';
            ConfigURL.ProNomeCidade := 'gurupi-to';
            Porta := ''; //Porta := ':442';
           end;
  2112209: begin // Timon/MA
            ConfigURL.HomNomeCidade := 'timon-ma';
            ConfigURL.ProNomeCidade := 'timon-ma';
            Porta := ''; //Porta := ':442';
           end;
  2207009: begin // Oeiras/PI
            ConfigURL.HomNomeCidade := 'oeiras-pi';
            ConfigURL.ProNomeCidade := 'oeiras-pi';
            Porta := ''; //Porta := ':442';
           end;
  2208007: begin // Picos/PI
            ConfigURL.HomNomeCidade := 'picos-pi';
            ConfigURL.ProNomeCidade := 'picos-pi';
            Porta := ''; //Porta := ':442';
           end;
  2211209: begin // Uru�u�/PI
            ConfigURL.HomNomeCidade := 'urucui-pi';
            ConfigURL.ProNomeCidade := 'urucui-pi';
            Porta := ''; //Porta := ':442';
           end;
  2307304: begin // Juazeiro do Norte/CE
            ConfigURL.HomNomeCidade := 'juazeirodonorte-ce';
            ConfigURL.ProNomeCidade := 'juazeirodonorte-ce';
            Porta := ''; //Porta := ':442';
           end;
  2910727: begin // Eunapolis/BA
            ConfigURL.HomNomeCidade := 'eunapolis-ba';
            ConfigURL.ProNomeCidade := 'eunapolis-ba';
            Porta := ''; //Porta := ':442';
           end;
  2925303: begin // Porto Seguro/BA
            ConfigURL.HomNomeCidade := 'portoseguro-ba';
            ConfigURL.ProNomeCidade := 'portoseguro-ba';
            Porta := '';
           end;
  3107109: begin // Boa Esperan�a/MG
            ConfigURL.HomNomeCidade := 'boaesperanca-mg';
            ConfigURL.ProNomeCidade := 'boaesperanca-mg';
            Porta := ''; //Porta := ':442';
           end;
  3112505: begin // Capim Branco/MG
            ConfigURL.HomNomeCidade := 'capimbranco-mg';
            ConfigURL.ProNomeCidade := 'capimbranco-mg';
            Porta := ''; //Porta := ':442';
           end;
  3113305: begin // Carangola/MG
            ConfigURL.HomNomeCidade := 'carangola-mg';
            ConfigURL.ProNomeCidade := 'carangola-mg';
            Porta := ''; //Porta := ':442';
           end;
  3114402: begin // Carmo do Rio Claro/MG
            ConfigURL.HomNomeCidade := 'carmodorioclaro-mg';
            ConfigURL.ProNomeCidade := 'carmodorioclaro-mg';
            Porta := ''; //Porta := ':442';
           end;
  3116605: begin // Cl�udio/MG
            ConfigURL.HomNomeCidade := 'claudio-mg';
            ConfigURL.ProNomeCidade := 'claudio-mg';
            Porta := ''; //Porta := ':442';
           end;
  3128006: begin // Guanh�es/MG
            ConfigURL.HomNomeCidade := 'guanhaes-mg';
            ConfigURL.ProNomeCidade := 'guanhaes-mg';
            Porta := ''; //Porta := ':442';
           end;
  3128105: begin // Guap�/MG
            ConfigURL.HomNomeCidade := 'guape-mg';
            ConfigURL.ProNomeCidade := 'guape-mg';
            Porta := ''; //Porta := ':442';
           end;
  3131307: begin // Ipatinga/MG
            ConfigURL.HomNomeCidade := 'ipatinga-mg';
            ConfigURL.ProNomeCidade := 'ipatinga-mg';
            Porta := ''; //Porta := ':442';
           end;
  3147907: begin // Passos/MG
            ConfigURL.HomNomeCidade := 'passos-mg';
            ConfigURL.ProNomeCidade := 'passos-mg';
            Porta := ''; //Porta := ':442';
           end;
  3148004: begin // Patos de Minas/MG
            ConfigURL.HomNomeCidade := 'patosdeminas-mg';
            ConfigURL.ProNomeCidade := 'patosdeminas-mg';
            Porta := ''; //Porta := ':442';
           end;
  3149903: begin // Perd�es/MG
            ConfigURL.HomNomeCidade := 'perdoes-mg';
            ConfigURL.ProNomeCidade := 'perdoes-mg';
            Porta := ''; //Porta := ':442';
           end;
  3151503: begin // Piumhi/MG
            ConfigURL.HomNomeCidade := 'piumhi-mg';
            ConfigURL.ProNomeCidade := 'piumhi-mg';
            Porta := ''; //Porta := ':442';
           end;
  3152600: begin // Pouso Alto/MG
            ConfigURL.HomNomeCidade := 'pousoalto-mg';
            ConfigURL.ProNomeCidade := 'pousoalto-mg';
            Porta := ''; //Porta := ':442';
           end;
  3153905: begin // Raposos/MG
            ConfigURL.HomNomeCidade := 'raposos-mg';
            ConfigURL.ProNomeCidade := 'raposos-mg';
            Porta := ''; //Porta := ':442';
           end;
  3170800: begin // V�rzea da Palma/MG
            ConfigURL.HomNomeCidade := 'varzeadapalma-mg';
            ConfigURL.ProNomeCidade := 'varzeadapalma-mg';
            Porta := ''; //Porta := ':442';
           end;
  3171303: begin // Vi�osa/MG
            ConfigURL.HomNomeCidade := 'vicosa-mg';
            ConfigURL.ProNomeCidade := 'vicosa-mg';
            Porta := ''; //Porta := ':442';
           end;
  3200102: begin // Afonso Cl�udio/ES
            ConfigURL.HomNomeCidade := 'afonsoclaudio-es';
            ConfigURL.ProNomeCidade := 'afonsoclaudio-es';
            Porta := ''; //Porta := ':442';
           end;
  3200300: begin // Alfredo Chaves/ES
            ConfigURL.HomNomeCidade := 'alfredochaves-es';
            ConfigURL.ProNomeCidade := 'alfredochaves-es';
            Porta := ''; //Porta := ':442';
           end;
  3204708: begin // S�o Gabriel da Palha/ES
            ConfigURL.HomNomeCidade := 'saogabrieldapalha-es';
            ConfigURL.ProNomeCidade := 'saogabrieldapalha-es';
            Porta := ''; //Porta := ':442';
           end;
  4109609: begin // Guaratuba/PR
            ConfigURL.HomNomeCidade := 'guaratuba-pr';
            ConfigURL.ProNomeCidade := 'guaratuba-pr';
            Porta := ''; //Porta := ':442';
           end;
  4300406: begin // Alegrete/RS
            ConfigURL.HomNomeCidade := 'alegrete-rs';
            ConfigURL.ProNomeCidade := 'alegrete-rs';
            Porta := ''; //Porta := ':442';
           end;
  4313953: begin // Pantano Grande/RS
            ConfigURL.HomNomeCidade := 'pantanogrande-rs';
            ConfigURL.ProNomeCidade := 'pantanogrande-rs';
            Porta := ''; //Porta := ':442';
           end;
  5106505: begin // Pocon�/MT
            ConfigURL.HomNomeCidade := 'pocone-mt';
            ConfigURL.ProNomeCidade := 'pocone-mt';
            Porta := ''; //Porta := ':442';
           end;
  5106778: begin // Porto Alegre do Norte/MT
            ConfigURL.HomNomeCidade := 'portoalegredonorte-mt';
            ConfigURL.ProNomeCidade := 'portoalegredonorte-mt';
            Porta := ''; //Porta := ':442';
           end;
  5107107: begin // S�o Jos� dos Quatro Marcos/MT
            ConfigURL.HomNomeCidade := 'saojosedosquatromarcos-mt';
            ConfigURL.ProNomeCidade := 'saojosedosquatromarcos-mt';
            Porta := ''; //Porta := ':442';
           end;
 end;

 ConfigURL.HomRecepcaoLoteRPS    := 'https://' + ConfigURL.HomNomeCidade + '.treino-issintel.com.br' + Porta + '/webservices/abrasf/api';
 ConfigURL.HomConsultaLoteRPS    := 'https://' + ConfigURL.HomNomeCidade + '.treino-issintel.com.br' + Porta + '/webservices/abrasf/api';
 ConfigURL.HomConsultaNFSeRPS    := 'https://' + ConfigURL.HomNomeCidade + '.treino-issintel.com.br' + Porta + '/webservices/abrasf/api';
 ConfigURL.HomConsultaSitLoteRPS := 'https://' + ConfigURL.HomNomeCidade + '.treino-issintel.com.br' + Porta + '/webservices/abrasf/api';
 ConfigURL.HomConsultaNFSe       := 'https://' + ConfigURL.HomNomeCidade + '.treino-issintel.com.br' + Porta + '/webservices/abrasf/api';
 ConfigURL.HomCancelaNFSe        := 'https://' + ConfigURL.HomNomeCidade + '.treino-issintel.com.br' + Porta + '/webservices/abrasf/api';

 ConfigURL.ProRecepcaoLoteRPS    := 'https://' + ConfigURL.ProNomeCidade + '.issintel.com.br' + Porta + '/webservices/abrasf/api';
 ConfigURL.ProConsultaLoteRPS    := 'https://' + ConfigURL.ProNomeCidade + '.issintel.com.br' + Porta + '/webservices/abrasf/api';
 ConfigURL.ProConsultaNFSeRPS    := 'https://' + ConfigURL.ProNomeCidade + '.issintel.com.br' + Porta + '/webservices/abrasf/api';
 ConfigURL.ProConsultaSitLoteRPS := 'https://' + ConfigURL.ProNomeCidade + '.issintel.com.br' + Porta + '/webservices/abrasf/api';
 ConfigURL.ProConsultaNFSe       := 'https://' + ConfigURL.ProNomeCidade + '.issintel.com.br' + Porta + '/webservices/abrasf/api';
 ConfigURL.ProCancelaNFSe        := 'https://' + ConfigURL.ProNomeCidade + '.issintel.com.br' + Porta + '/webservices/abrasf/api';

 Result := ConfigURL;
end;

function TProvedorISSIntel.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorISSIntel.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := False;
   acConsSit:     Result := False;
   acConsLote:    Result := False;
   acConsNFSeRps: Result := False;
   acConsNFSe:    Result := False;
   acCancelar:    Result := True;
   acGerar:       Result := False;
   else           Result := False;
 end;
end;

function TProvedorISSIntel.GetValidarLote: Boolean;
begin
 // Alterado por Italo em 14/03/2013
 Result := False;
end;

function TProvedorISSIntel.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
begin
{
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
}
 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio>';
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio>' +
                             '<' + Prefixo3 + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento>';
   acGerar:       Result := '';
 end;
end;

function TProvedorISSIntel.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorISSIntel.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorISSIntel.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
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
(*
function TProvedorISSIntel.Gera_DadosMsgEnviarLote(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoDados, VersaoXML, NumeroLote, CNPJ,
  IM, QtdeNotas: String; Notas, TagI, TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'LoteRps'+
               DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + NumeroLote + '"', '') + '>' +
               ' versao="' + VersaoDados + '">' +
              '<' + Prefixo4 + 'NumeroLote>' +
                NumeroLote +
              '</' + Prefixo4 + 'NumeroLote>' +

              DFeUtil.SeSenao(VersaoXML = '1',

                '<' + Prefixo4 + 'CpfCnpj>' +
                '<' + Prefixo4 + 'Cnpj>' +
                  Cnpj +
                '</' + Prefixo4 + 'Cnpj>' +
                '</' + Prefixo4 + 'CpfCnpj>',

                '<' + Prefixo4 + 'Cnpj>' +
                  Cnpj +
                '</' + Prefixo4 + 'Cnpj>') +

              '<' + Prefixo4 + 'InscricaoMunicipal>' +
                IM +
              '</' + Prefixo4 + 'InscricaoMunicipal>' +
              '<' + Prefixo4 + 'QuantidadeRps>' +
                QtdeNotas +
              '</' + Prefixo4 + 'QuantidadeRps>' +
              '<' + Prefixo4 + 'ListaRps>' +
               Notas +
              '</' + Prefixo4 + 'ListaRps>' +
             '</' + Prefixo3 + 'LoteRps>';

  Result := TagI + DadosMsg + TagF;
end;

function TProvedorISSIntel.Gera_DadosMsgConsLote(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, Protocolo, CNPJ, IM: String; TagI,
  TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'Prestador>' +

               DFeUtil.SeSenao(VersaoXML = '1',

                 '<' + Prefixo4 + 'CpfCnpj>' +
                 '<' + Prefixo4 + 'Cnpj>' +
                   Cnpj +
                 '</' + Prefixo4 + 'Cnpj>' +
                 '</' + Prefixo4 + 'CpfCnpj>',

                 '<' + Prefixo4 + 'Cnpj>' +
                   Cnpj +
                 '</' + Prefixo4 + 'Cnpj>') +

               '<' + Prefixo4 + 'InscricaoMunicipal>' +
                 IM +
               '</' + Prefixo4 + 'InscricaoMunicipal>' +
              '</' + Prefixo3 + 'Prestador>' +
              '<' + Prefixo3 + 'Protocolo>' +
                Protocolo +
              '</' + Prefixo3 + 'Protocolo>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorISSIntel.Gera_DadosMsgConsNFSeRPS(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, NumeroRps, SerieRps, TipoRps, CNPJ, IM: String; TagI,
  TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'IdentificacaoRps>' +
              '<' + Prefixo4 + 'Numero>' +
                NumeroRps +
              '</' + Prefixo4 + 'Numero>' +
              '<' + Prefixo4 + 'Serie>' +
                SerieRps +
              '</' + Prefixo4 + 'Serie>' +
              '<' + Prefixo4 + 'Tipo>' +
                TipoRps +
              '</' + Prefixo4 + 'Tipo>' +
             '</' + Prefixo3 + 'IdentificacaoRps>' +
             '<' + Prefixo3 + 'Prestador>' +

              DFeUtil.SeSenao(VersaoXML = '1',

                '<' + Prefixo4 + 'CpfCnpj>' +
                '<' + Prefixo4 + 'Cnpj>' +
                  Cnpj +
                '</' + Prefixo4 + 'Cnpj>' +
                '</' + Prefixo4 + 'CpfCnpj>',

                '<' + Prefixo4 + 'Cnpj>' +
                  Cnpj +
                '</' + Prefixo4 + 'Cnpj>') +

              '<' + Prefixo4 + 'InscricaoMunicipal>' +
                IM +
              '</' + Prefixo4 + 'InscricaoMunicipal>' +
             '</' + Prefixo3 + 'Prestador>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorISSIntel.Gera_DadosMsgConsNFSe(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, CNPJ, IM: String; DataInicial, DataFinal: TDateTime; TagI,
  TagF: AnsiString; NumeroNFSe: string = ''): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'Prestador>' +

               DFeUtil.SeSenao(VersaoXML = '1',

                 '<' + Prefixo4 + 'CpfCnpj>' +
                 '<' + Prefixo4 + 'Cnpj>' +
                  Cnpj +
                 '</' + Prefixo4 + 'Cnpj>' +
                 '</' + Prefixo4 + 'CpfCnpj>',

                 '<' + Prefixo4 + 'Cnpj>' +
                  Cnpj +
                 '</' + Prefixo4 + 'Cnpj>') +

               '<' + Prefixo4 + 'InscricaoMunicipal>' +
                IM +
               '</' + Prefixo4 + 'InscricaoMunicipal>' +
              '</' + Prefixo3 + 'Prestador>';

 if NumeroNFSe <> ''
  then DadosMsg := DadosMsg + '<' + Prefixo3 + 'NumeroNfse>' +
                               NumeroNFSe +
                              '</' + Prefixo3 + 'NumeroNfse>';

 if (DataInicial>0) and (DataFinal>0)
  then DadosMsg := DadosMsg + '<' + Prefixo3 + 'PeriodoEmissao>' +
                               '<' + Prefixo3 + 'DataInicial>' +
                                 FormatDateTime('yyyy-mm-dd', DataInicial) +
                               '</' + Prefixo3 + 'DataInicial>' +
                               '<' + Prefixo3 + 'DataFinal>' +
                                 FormatDateTime('yyyy-mm-dd', DataFinal) +
                               '</' + Prefixo3 + 'DataFinal>' +
                              '</' + Prefixo3 + 'PeriodoEmissao>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorISSIntel.Gera_DadosMsgCancelarNFSe(Prefixo4, NameSpaceDad, NumeroNFSe,
  CNPJ, IM, CodMunicipio, CodCancelamento: String; TagI,
  TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo4 + 'IdentificacaoNfse>' +
              '<' + Prefixo4 + 'Numero>' +
                NumeroNFse +
              '</' + Prefixo4 + 'Numero>' +
              '<' + Prefixo4 + 'Cnpj>' +
                Cnpj +
              '</' + Prefixo4 + 'Cnpj>' +
              '<' + Prefixo4 + 'InscricaoMunicipal>' +
                IM +
              '</' + Prefixo4 + 'InscricaoMunicipal>' +
              '<' + Prefixo4 + 'CodigoMunicipio>' +
                CodMunicipio +
              '</' + Prefixo4 + 'CodigoMunicipio>' +
              '</' + Prefixo4 + 'IdentificacaoNfse>' +
              '<' + Prefixo4 + 'CodigoCancelamento>' +

               // Codigo de Cancelamento
               // 1 - Erro de emiss�o
               // 2 - Servi�o n�o concluido
               // 3 - RPS Cancelado na Emiss�o

                CodCancelamento +

              '</' + Prefixo4 + 'CodigoCancelamento>' +
             '</' + Prefixo4 + 'InfPedidoCancelamento>';

// Result := TagI + DadosMsg + TagF;
 Result := DadosMsg;
end;
*)
function TProvedorISSIntel.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:seriorsIssIntel">' +
            '<soapenv:Header/>' +
             '<soapenv:Body>' +
              '<urn:RecepcionarLoteRps>' +
                DadosMsg +
              '</urn:RecepcionarLoteRps>' +
             '</soapenv:Body>' +
            '</soapenv:Envelope>';
end;

function TProvedorISSIntel.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:seriorsIssIntel">' +
            '<soapenv:Header/>' +
             '<soapenv:Body>' +
              '<urn:ConsultarSituacaoLoteRps>' +
                DadosMsg +
              '</urn:ConsultarSituacaoLoteRps>' +
             '</soapenv:Body>' +
            '</soapenv:Envelope>';
end;

function TProvedorISSIntel.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:seriorsIssIntel">' +
            '<soapenv:Header/>' +
             '<soapenv:Body>' +
              '<urn:ConsultarLoteRps>' +
                DadosMsg +
              '</urn:ConsultarLoteRps>' +
             '</soapenv:Body>' +
            '</soapenv:Envelope>';
end;

function TProvedorISSIntel.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:seriorsIssIntel">' +
            '<soapenv:Header/>' +
             '<soapenv:Body>' +
              '<urn:ConsultarNfsePorRps>' +
                DadosMsg +
              '</urn:ConsultarNfsePorRps>' +
             '</soapenv:Body>' +
            '</soapenv:Envelope>';
end;

function TProvedorISSIntel.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:seriorsIssIntel">' +
            '<soapenv:Header/>' +
             '<soapenv:Body>' +
              '<urn:ConsultarNfse>' +
                DadosMsg +
              '</urn:ConsultarNfse>' +
             '</soapenv:Body>' +
            '</soapenv:Envelope>';
end;

function TProvedorISSIntel.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:seriorsIssIntel">' +
            '<soapenv:Header/>' +
             '<soapenv:Body>' +
              '<urn:CancelarNfse>' +
                DadosMsg +
              '</urn:CancelarNfse>' +
             '</soapenv:Body>' +
            '</soapenv:Envelope>';
end;

function TProvedorISSIntel.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Op��o n�o implementada para este provedor.' );
end;

function TProvedorISSIntel.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
var
 Porta: String;
begin
 if NomeCidade = 'ipatinga-mg'
  then Porta := ':442'
  else Porta := '';

 case Acao of
   acRecepcionar: Result := 'https://' + NomeCidade + '.issintel.com.br' + Porta + '/webservices/abrasf/api/RecepcionarLoteRps';
   acConsSit:     Result := 'https://' + NomeCidade + '.issintel.com.br' + Porta + '/webservices/abrasf/api/ConsultarSituacaoLoteRps';
   acConsLote:    Result := 'https://' + NomeCidade + '.issintel.com.br' + Porta + '/webservices/abrasf/api/ConsultarLoteRps';
   acConsNFSeRps: Result := 'https://' + NomeCidade + '.issintel.com.br' + Porta + '/webservices/abrasf/api/ConsultarNfsePorRps';
   acConsNFSe:    Result := 'https://' + NomeCidade + '.issintel.com.br' + Porta + '/webservices/abrasf/api/ConsultarNfse';
   acCancelar:    Result := 'https://' + NomeCidade + '.issintel.com.br' + Porta + '/webservices/abrasf/api/CancelarNfse';
   acGerar:       Result := '';
 end;
end;

function TProvedorISSIntel.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
{
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'Body' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'Body' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'Body' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'Body' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'Body' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'Body' );
   acGerar:       Result := '';
 end;
}
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'env:Body' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'env:Body' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'env:Body' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'env:Body' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'env:Body' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'env:Body' );
   acGerar:       Result := '';
 end;
end;

function TProvedorISSIntel.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="https://' + NomeCidade + '.issintel.com.br/webservices/abrasf/api">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorISSIntel.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

function TProvedorISSIntel.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

end.
