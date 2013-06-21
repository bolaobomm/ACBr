 {$I ACBr.inc}

unit ACBrProvedorISSDSF;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorIssDSF }

 TProvedorIssDSF = class(TProvedorClass)
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
   function Gera_DadosMsgEnviarLoteDSF(Prefixo3, Prefixo4,Identificador, NameSpaceDad, VersaoXML,
                                       NumeroLote, CodCidade, CNPJ, IM, RazaoSocial, Transacao,
                                       QtdeNotas, ValorTotalServicos, ValorTotalDeducoes: String;
                                       DataInicial, DataFinal: TDateTime;
                                       Notas, TagI, TagF: AnsiString): AnsiString; Override;
   function Gera_DadosMsgConsLoteDSF(Prefixo3, Prefixo4, NameSpaceDad,
                                     VersaoXML, CodCidade, CNPJ, NumeroLote: String;
                                     TagI, TagF: AnsiString): AnsiString; Override;
   function Gera_DadosMsgConsNFSeRPSDSF(Prefixo3, Prefixo4, NameSpaceDad,VersaoXML,
                                        CodCidade, CNPJ, Transacao, NumeroLote: String;
                                        Notas, TagI, TagF: AnsiString): AnsiString; Override;
   function Gera_DadosMsgConsNFSeDSF(Prefixo3, Prefixo4, NameSpaceDad, VersaoXML, CodCidade,
                                     CNPJ, IM, NotaInicial: String; DataInicial, DataFinal: TDateTime;
                                     TagI, TagF: AnsiString): AnsiString; Override;
   function Gera_DadosMsgCancelarNFSeDSF(Prefixo3, Prefixo4, NameSpaceDad, VersaoXML,
                                         CNPJ, Transacao, CodMunicipio, NumeroLote: String;
                                         Notas, TagI, TagF: AnsiString): AnsiString; Override;
   function Gera_DadosMsgConsSeqRPSDSF(TagI, TagF: AnsiString; VersaoXML, CodCidade,
                                       IM, CNPJ, SeriePrestacao: String): AnsiString; Override;

   function Gera_DadosMsgEnviarLote(Prefixo3, Prefixo4, Identificador,
                                    NameSpaceDad, VersaoDados, VersaoXML,
                                    NumeroLote, CNPJ, IM, QtdeNotas: String;
                                    Notas, TagI, TagF: AnsiString): AnsiString;
   function Gera_DadosMsgConsSitLote(Prefixo3, Prefixo4, NameSpaceDad,
                                     VersaoXML, Protocolo, CNPJ, IM: String;
                                     TagI, TagF: AnsiString): AnsiString; OverRide;
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
   function Gera_DadosMsgGerarNFSe(Prefixo3, Prefixo4, Identificador,
                                   NameSpaceDad, VersaoDados, VersaoXML,
                                   NumeroLote, CNPJ, IM, QtdeNotas: String;
                                   Notas, TagI, TagF: AnsiString): AnsiString; OverRide;
   function Gera_DadosMsgEnviarSincrono(Prefixo3, Prefixo4, Identificador,
                                        NameSpaceDad, VersaoDados, VersaoXML,
                                        NumeroLote, CNPJ, IM, QtdeNotas: String;
                                        Notas, TagI, TagF: AnsiString): AnsiString; OverRide;
   *)
   function GeraEnvelopeRecepcionarLoteRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarSituacaoLoteRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarLoteRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarNFSeporRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeGerarNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeRecepcionarSincrono(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarSequencialRps(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;

   function GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String; OverRide;
   function GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString; OverRide;

   function GeraRetornoNFSe(Prefixo: String; RetNFSe: AnsiString; NomeCidade: String): AnsiString; OverRide;
   function GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer; ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String; OverRide;
  end;

implementation

{ TProvedorIssDSF }

constructor TProvedorIssDSF.Create;
begin
 {----}
end;

function TProvedorIssDSF.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.2';
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := 'ns1:';
 ConfigCidade.Prefixo4      := 'tipos:';
 ConfigCidade.Identificador := 'Id';

 if AAmbiente = 1
  then case ACodCidade of
     3509502: ConfigCidade.NameSpaceEnvelope := 'http://issdigital.campinas.sp.gov.br/WsNFe2/Lote'; // Campinas/SP
     3170206: ConfigCidade.NameSpaceEnvelope := 'http://udigital.uberlandia.mg.gov.br/WsNFe2/Lote'; // Uberlandia/MG
     1501402: ConfigCidade.NameSpaceEnvelope := 'http://www.issdigitalbel.com.br/WsNFe2/Lote';      // Belem/PA
     5002704: ConfigCidade.NameSpaceEnvelope := 'http://issdigital.pmcg.ms.gov.br/WsNFe2/Lote';     // Campo Grande/MS
     3303500: ConfigCidade.NameSpaceEnvelope := 'http://www.issmaisfacil.com.br/WsNFe2/Lote';       // Nova Iguacu/RJ
     2211001: ConfigCidade.NameSpaceEnvelope := 'http://www.issdigitalthe.com.br/WsNFe2/Lote';      // Teresina/PI
     2111300: ConfigCidade.NameSpaceEnvelope := 'http://www.issdigitalslz.com.br/WsNFe2/Lote';      // Sao Luis/MA
     3552205: ConfigCidade.NameSpaceEnvelope := 'http://www.issdigitalsod.com.br/WsNFe2/Lote';      // Sorocaba/SP
  end
  else ConfigCidade.NameSpaceEnvelope := '';

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := (AAmbiente = 1);


 Result := ConfigCidade;
end;

function TProvedorIssDSF.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
  ConfigSchema.VersaoCabecalho := '';
  ConfigSchema.VersaoDados     := '';
  ConfigSchema.VersaoXML       := '1';
  case ACodCidade of                                                      //tentar estes se não der certo 
    3509502: ConfigSchema.NameSpaceXML := 'http://localhost:8080/WsNFe2/xsd/';//'http://issdigital.campinas.sp.gov.br/WsNFe2'; // Campinas/SP
    3170206: ConfigSchema.NameSpaceXML := 'http://localhost:8080/WsNFe2/xsd/';//'http://udigital.uberlandia.mg.gov.br/WsNFe2'; // Uberlandia/MG
    1501402: ConfigSchema.NameSpaceXML := 'http://localhost:8080/WsNFe2/xsd/';//'http://www.issdigitalbel.com.br/WsNFe2';      // Belem/PA
    5002704: ConfigSchema.NameSpaceXML := 'http://localhost:8080/WsNFe2/xsd/';//'http://issdigital.pmcg.ms.gov.br/WsNFe2';     // Campo Grande/MS
    3303500: ConfigSchema.NameSpaceXML := 'http://localhost:8080/WsNFe2/xsd/';//'http://www.issmaisfacil.com.br/WsNFe2';       // Nova Iguacu/RJ
    2211001: ConfigSchema.NameSpaceXML := 'http://localhost:8080/WsNFe2/xsd/';//'http://www.issdigitalthe.com.br/WsNFe2';      // Teresina/PI
    2111300: ConfigSchema.NameSpaceXML := 'http://localhost:8080/WsNFe2/xsd/';//'http://www.issdigitalslz.com.br/WsNFe2';      // Sao Luis/MA
    3552205: ConfigSchema.NameSpaceXML := 'http://localhost:8080/WsNFe2/xsd/';//'http://www.issdigitalsod.com.br/WsNFe2';      // Sorocaba/SP
  end;
                                   //tentar este se não der certo http://localhost:8080/WsNFe2/xsd/...
  ConfigSchema.Cabecalho       := '';
  ConfigSchema.ServicoEnviar   := 'ReqEnvioLoteRPS.xsd';
  ConfigSchema.ServicoConSit   := 'ConsultaSeqRps.xsd';
  ConfigSchema.ServicoConLot   := 'ReqConsultaLote.xsd';
  ConfigSchema.ServicoConRps   := 'ReqConsultaNFSeRPS.xsd';
  ConfigSchema.ServicoConNfse  := 'ReqConsultaNotas.xsd';
  ConfigSchema.ServicoCancelar := 'RetornoCancelamentoNFSe.xsd';
  ConfigSchema.DefTipos        := 'Tipos.xsd'; 

  {// testar esssa configuração se nao der certo --
  case ACodCidade of
    3509502: begin // Campinas/SP
      ConfigSchema.ServicoEnviar   := 'http://issdigital.campinas.sp.gov.br/WsNFe2/xsd/ReqEnvioLoteRPS.xsd'
      ConfigSchema.ServicoConSit   := 'http://issdigital.campinas.sp.gov.br/WsNFe2/xsd/ConsultaSeqRps.xsd';
      ConfigSchema.ServicoConLot   := 'http://issdigital.campinas.sp.gov.br/WsNFe2/xsd/ReqConsultaLote.xsd';
      ConfigSchema.ServicoConRps   := 'http://issdigital.campinas.sp.gov.br/WsNFe2/xsd/ReqConsultaNFSeRPS.xsd';
      ConfigSchema.ServicoConNfse  := 'http://issdigital.campinas.sp.gov.br/WsNFe2/xsd/ReqConsultaNotas.xsd';
      ConfigSchema.ServicoCancelar := 'http://issdigital.campinas.sp.gov.br/WsNFe2/xsd/RetornoCancelamentoNFSe.xsd';
      ConfigSchema.DefTipos        := 'http://issdigital.campinas.sp.gov.br/WsNFe2/xsd/Tipos.xsd';
    end;
    3170206: begin // Uberlandia/MG
      ConfigSchema.ServicoEnviar   := 'http://udigital.uberlandia.mg.gov.br/WsNFe2/xsd/ReqEnvioLoteRPS.xsd'
      ConfigSchema.ServicoConSit   := 'http://udigital.uberlandia.mg.gov.br/WsNFe2/xsd/ConsultaSeqRps.xsd';
      ConfigSchema.ServicoConLot   := 'http://udigital.uberlandia.mg.gov.br/WsNFe2/xsd/ReqConsultaLote.xsd';
      ConfigSchema.ServicoConRps   := 'http://udigital.uberlandia.mg.gov.br/WsNFe2/xsd/ReqConsultaNFSeRPS.xsd';
      ConfigSchema.ServicoConNfse  := 'http://udigital.uberlandia.mg.gov.br/WsNFe2/xsd/ReqConsultaNotas.xsd';
      ConfigSchema.ServicoCancelar := 'http://udigital.uberlandia.mg.gov.br/WsNFe2/xsd/RetornoCancelamentoNFSe.xsd';
      ConfigSchema.DefTipos        := 'http://udigital.uberlandia.mg.gov.br/WsNFe2/xsd/Tipos.xsd';
    end;
    1501402: begin // Belem/PA
      ConfigSchema.ServicoEnviar   := 'http://www.issdigitalbel.com.br/WsNFe2/xsd/ReqEnvioLoteRPS.xsd'
      ConfigSchema.ServicoConSit   := 'http://www.issdigitalbel.com.br/WsNFe2/xsd/ConsultaSeqRps.xsd';
      ConfigSchema.ServicoConLot   := 'http://www.issdigitalbel.com.br/WsNFe2/xsd/ReqConsultaLote.xsd';
      ConfigSchema.ServicoConRps   := 'http://www.issdigitalbel.com.br/WsNFe2/xsd/ReqConsultaNFSeRPS.xsd';
      ConfigSchema.ServicoConNfse  := 'http://www.issdigitalbel.com.br/WsNFe2/xsd/ReqConsultaNotas.xsd';
      ConfigSchema.ServicoCancelar := 'http://www.issdigitalbel.com.br/WsNFe2/xsd/RetornoCancelamentoNFSe.xsd';
      ConfigSchema.DefTipos        := 'http://www.issdigitalbel.com.br/WsNFe2/xsd/Tipos.xsd';
    end;
    5002704: begin // Campo Grande/MS
      ConfigSchema.ServicoEnviar   := 'http://issdigital.pmcg.ms.gov.br/WsNFe2/xsd/ReqEnvioLoteRPS.xsd'
      ConfigSchema.ServicoConSit   := 'http://issdigital.pmcg.ms.gov.br/WsNFe2/xsd/ConsultaSeqRps.xsd';
      ConfigSchema.ServicoConLot   := 'http://issdigital.pmcg.ms.gov.br/WsNFe2/xsd/ReqConsultaLote.xsd';
      ConfigSchema.ServicoConRps   := 'http://issdigital.pmcg.ms.gov.br/WsNFe2/xsd/ReqConsultaNFSeRPS.xsd';
      ConfigSchema.ServicoConNfse  := 'http://issdigital.pmcg.ms.gov.br/WsNFe2/xsd/ReqConsultaNotas.xsd';
      ConfigSchema.ServicoCancelar := 'http://issdigital.pmcg.ms.gov.br/WsNFe2/xsd/RetornoCancelamentoNFSe.xsd';
      ConfigSchema.DefTipos        := 'http://issdigital.pmcg.ms.gov.br/WsNFe2/xsd/Tipos.xsd';
    end;
    3303500: begin // Nova Iguacu/RJ
      ConfigSchema.ServicoEnviar   := 'http://www.issmaisfacil.com.br/WsNFe2/xsd/ReqEnvioLoteRPS.xsd'
      ConfigSchema.ServicoConSit   := 'http://www.issmaisfacil.com.br/WsNFe2/xsd/ConsultaSeqRps.xsd';
      ConfigSchema.ServicoConLot   := 'http://www.issmaisfacil.com.br/WsNFe2/xsd/ReqConsultaLote.xsd';
      ConfigSchema.ServicoConRps   := 'http://www.issmaisfacil.com.br/WsNFe2/xsd/ReqConsultaNFSeRPS.xsd';
      ConfigSchema.ServicoConNfse  := 'http://www.issmaisfacil.com.br/WsNFe2/xsd/ReqConsultaNotas.xsd';
      ConfigSchema.ServicoCancelar := 'http://www.issmaisfacil.com.br/WsNFe2/xsd/RetornoCancelamentoNFSe.xsd';
      ConfigSchema.DefTipos        := 'http://www.issmaisfacil.com.br/WsNFe2/xsd/Tipos.xsd';
    end;
    2211001: begin // Teresina/PI
      ConfigSchema.ServicoEnviar   := 'http://www.issdigitalthe.com.br/WsNFe2/xsd/ReqEnvioLoteRPS.xsd'
      ConfigSchema.ServicoConSit   := 'http://www.issdigitalthe.com.br/WsNFe2/xsd/ConsultaSeqRps.xsd';
      ConfigSchema.ServicoConLot   := 'http://www.issdigitalthe.com.br/WsNFe2/xsd/ReqConsultaLote.xsd';
      ConfigSchema.ServicoConRps   := 'http://www.issdigitalthe.com.br/WsNFe2/xsd/ReqConsultaNFSeRPS.xsd';
      ConfigSchema.ServicoConNfse  := 'http://www.issdigitalthe.com.br/WsNFe2/xsd/ReqConsultaNotas.xsd';
      ConfigSchema.ServicoCancelar := 'http://www.issdigitalthe.com.br/WsNFe2/xsd/RetornoCancelamentoNFSe.xsd';
      ConfigSchema.DefTipos        := 'http://www.issdigitalthe.com.br/WsNFe2/xsd/Tipos.xsd';
    end;
    2111300: begin // Sao Luis/MA
      ConfigSchema.ServicoEnviar   := 'http://www.issdigitalslz.com.br/WsNFe2/xsd/ReqEnvioLoteRPS.xsd'
      ConfigSchema.ServicoConSit   := 'http://www.issdigitalslz.com.br/WsNFe2/xsd/ConsultaSeqRps.xsd';
      ConfigSchema.ServicoConLot   := 'http://www.issdigitalslz.com.br/WsNFe2/xsd/ReqConsultaLote.xsd';
      ConfigSchema.ServicoConRps   := 'http://www.issdigitalslz.com.br/WsNFe2/xsd/ReqConsultaNFSeRPS.xsd';
      ConfigSchema.ServicoConNfse  := 'http://www.issdigitalslz.com.br/WsNFe2/xsd/ReqConsultaNotas.xsd';
      ConfigSchema.ServicoCancelar := 'http://www.issdigitalslz.com.br/WsNFe2/xsd/RetornoCancelamentoNFSe.xsd';
      ConfigSchema.DefTipos        := 'http://www.issdigitalslz.com.br/WsNFe2/xsd/Tipos.xsd';
    end;
    3552205: begin // Sorocaba/SP
      ConfigSchema.ServicoEnviar   := 'http://www.issdigitalsod.com.br/WsNFe2/xsd/ReqEnvioLoteRPS.xsd'
      ConfigSchema.ServicoConSit   := 'http://www.issdigitalsod.com.br/WsNFe2/xsd/ConsultaSeqRps.xsd';
      ConfigSchema.ServicoConLot   := 'http://www.issdigitalsod.com.br/WsNFe2/xsd/ReqConsultaLote.xsd';
      ConfigSchema.ServicoConRps   := 'http://www.issdigitalsod.com.br/WsNFe2/xsd/ReqConsultaNFSeRPS.xsd';
      ConfigSchema.ServicoConNfse  := 'http://www.issdigitalsod.com.br/WsNFe2/xsd/ReqConsultaNotas.xsd';
      ConfigSchema.ServicoCancelar := 'http://www.issdigitalsod.com.br/WsNFe2/xsd/RetornoCancelamentoNFSe.xsd';
      ConfigSchema.DefTipos        := 'http://www.issdigitalsod.com.br/WsNFe2/xsd/Tipos.xsd';
    end;
  end;
 }
 Result := ConfigSchema;
end;

function TProvedorIssDSF.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
  {ConfigURL.HomNomeCidade         := '';
  ConfigURL.HomRecepcaoLoteRPS    := 'http://treinamento.dsfweb.com.br/WsNFe2/LoteRps.jws?wsdl';
  ConfigURL.HomConsultaLoteRPS    := 'http://treinamento.dsfweb.com.br/WsNFe2/LoteRps.jws?wsdl';
  ConfigURL.HomConsultaNFSeRPS    := 'http://treinamento.dsfweb.com.br/WsNFe2/LoteRps.jws?wsdl';
  ConfigURL.HomConsultaSitLoteRPS := 'http://treinamento.dsfweb.com.br/WsNFe2/LoteRps.jws?wsdl';
  ConfigURL.HomConsultaNFSe       := 'http://treinamento.dsfweb.com.br/WsNFe2/LoteRps.jws?wsdl';
  ConfigURL.HomCancelaNFSe        := 'http://treinamento.dsfweb.com.br/WsNFe2/LoteRps.jws?wsdl';
  }
  ConfigURL.HomRecepcaoLoteRPS    := '';
  ConfigURL.HomConsultaLoteRPS    := '';
  ConfigURL.HomConsultaNFSeRPS    := '';
  ConfigURL.HomConsultaSitLoteRPS := '';
  ConfigURL.HomConsultaNFSe       := '';
  ConfigURL.HomCancelaNFSe        := '';
  
  ConfigURL.ProNomeCidade         := '';

   case ACodCidade of
    3509502:
     begin // Campinas/SP
       ConfigURL.ProRecepcaoLoteRPS    := 'http://issdigital.campinas.sp.gov.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaLoteRPS    := 'http://issdigital.campinas.sp.gov.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSeRPS    := 'http://issdigital.campinas.sp.gov.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaSitLoteRPS := 'http://issdigital.campinas.sp.gov.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSe       := 'http://issdigital.campinas.sp.gov.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProCancelaNFSe        := 'http://issdigital.campinas.sp.gov.br/WsNFe2/LoteRps.jws?wsdl';
     end;
    3170206: // Uberlandia/MG
     begin
       ConfigURL.ProRecepcaoLoteRPS    := 'http://udigital.uberlandia.mg.gov.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaLoteRPS    := 'http://udigital.uberlandia.mg.gov.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSeRPS    := 'http://udigital.uberlandia.mg.gov.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaSitLoteRPS := 'http://udigital.uberlandia.mg.gov.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSe       := 'http://udigital.uberlandia.mg.gov.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProCancelaNFSe        := 'http://udigital.uberlandia.mg.gov.br/WsNFe2/LoteRps.jws?wsdl';
     end;
    1501402: // Belem/PA
     begin 
       ConfigURL.ProRecepcaoLoteRPS    := 'http://www.issdigitalbel.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaLoteRPS    := 'http://www.issdigitalbel.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSeRPS    := 'http://www.issdigitalbel.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaSitLoteRPS := 'http://www.issdigitalbel.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSe       := 'http://www.issdigitalbel.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProCancelaNFSe        := 'http://www.issdigitalbel.com.br/WsNFe2/LoteRps.jws?wsdl';
     end;
    5002704: // Campo Grande/MS
     begin 
       ConfigURL.ProRecepcaoLoteRPS    := 'http://issdigital.pmcg.ms.gov.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaLoteRPS    := 'http://issdigital.pmcg.ms.gov.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSeRPS    := 'http://issdigital.pmcg.ms.gov.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaSitLoteRPS := 'http://issdigital.pmcg.ms.gov.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSe       := 'http://issdigital.pmcg.ms.gov.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProCancelaNFSe        := 'http://issdigital.pmcg.ms.gov.br/WsNFe2/LoteRps.jws?wsdl';
     end;
    3303500: // Nova Iguacu/RJ
     begin 
       ConfigURL.ProRecepcaoLoteRPS    := 'http://www.issmaisfacil.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaLoteRPS    := 'http://www.issmaisfacil.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSeRPS    := 'http://www.issmaisfacil.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaSitLoteRPS := 'http://www.issmaisfacil.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSe       := 'http://www.issmaisfacil.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProCancelaNFSe        := 'http://www.issmaisfacil.com.br/WsNFe2/LoteRps.jws?wsdl';
     end;
    2211001: // Teresina/PI
     begin
       ConfigURL.ProRecepcaoLoteRPS    := 'http://www.issdigitalthe.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaLoteRPS    := 'http://www.issdigitalthe.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSeRPS    := 'http://www.issdigitalthe.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaSitLoteRPS := 'http://www.issdigitalthe.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSe       := 'http://www.issdigitalthe.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProCancelaNFSe        := 'http://www.issdigitalthe.com.br/WsNFe2/LoteRps.jws?wsdl';
     end;
    2111300: // Sao Luis/MA
     begin
       ConfigURL.ProRecepcaoLoteRPS    := 'http://www.issdigitalslz.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaLoteRPS    := 'http://www.issdigitalslz.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSeRPS    := 'http://www.issdigitalslz.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaSitLoteRPS := 'http://www.issdigitalslz.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSe       := 'http://www.issdigitalslz.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProCancelaNFSe        := 'http://www.issdigitalslz.com.br/WsNFe2/LoteRps.jws?wsdl';
     end;
    3552205: // Sorocaba/SP
     begin 
       ConfigURL.ProRecepcaoLoteRPS    := 'http://www.issdigitalsod.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaLoteRPS    := 'http://www.issdigitalsod.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSeRPS    := 'http://www.issdigitalsod.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaSitLoteRPS := 'http://www.issdigitalsod.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProConsultaNFSe       := 'http://www.issdigitalsod.com.br/WsNFe2/LoteRps.jws?wsdl';
       ConfigURL.ProCancelaNFSe        := 'http://www.issdigitalsod.com.br/WsNFe2/LoteRps.jws?wsdl';
     end;
  end;
  Result := ConfigURL;
end;

function TProvedorIssDSF.GetURI(URI: String): String;
begin
 Result := '';
end;

function TProvedorIssDSF.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := True;
   acConsSit:     Result := True;
   acConsLote:    Result := True;
   acConsNFSeRps: Result := True;
   acConsNFSe:    Result := True;
   acCancelar:    Result := True;
   acGerar:       Result := False;
   acConsSecRps:  Result := True;
   else           Result := False;
 end;
end;

function TProvedorIssDSF.GetValidarLote: Boolean;
begin
 Result := false;// True;
end;

function TProvedorIssDSF.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'ReqEnvioLoteRPS'     + { 'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +}
                              ' xsi:schemaLocation' + NameSpaceDad;

   acConsSit:     Result := '';

   acConsLote:    Result := '<' + Prefixo3 + 'ReqConsultaLote'     + { 'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +}
                              ' xsi:schemaLocation' + NameSpaceDad;

   acConsNFSeRps: Result := '<' + Prefixo3 + 'ReqConsultaNFSeRPS'  + { 'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +}
                              ' xsi:schemaLocation' + NameSpaceDad;

   acConsNFSe:    Result := '<' + Prefixo3 + 'ReqConsultaNotas'    + { 'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +}
                              ' xsi:schemaLocation' + NameSpaceDad;

   acCancelar:    Result := '<' + Prefixo3 + 'ReqCancelamentoNFSe' + { 'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +}
                              ' xsi:schemaLocation' + NameSpaceDad;

   acGerar:       Result := '';

   acConsSecRps:  Result := '<' + Prefixo3 + 'ConsultaSeqRps'      + { 'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' +}
                              ' xsi:schemaLocation' + NameSpaceDad;
 end;
end;

function TProvedorIssDSF.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '';
           {'<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';}
end;

function TProvedorIssDSF.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorIssDSF.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'ReqEnvioLoteRPS>';
   acConsSit:     Result := '';
   acConsLote:    Result := '</' + Prefixo3 + 'ReqConsultaLote>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ReqConsultaNFSeRPS>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ReqConsultaNotas>';
   acCancelar:    Result := '</' + Prefixo3 + 'ReqCancelamentoNFSe>';
   acGerar:       Result := '';
   acConsSecRps:  Result := '</' + Prefixo3 + 'ConsultaSeqRps>';
 end;
end;
(*
function TProvedorIssDSF.Gera_DadosMsgEnviarLoteDSF(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoXML, NumeroLote,
  CodCidade, CNPJ, IM, RazaoSocial, Transacao, QtdeNotas,
  ValorTotalServicos, ValorTotalDeducoes: String; DataInicial, DataFinal: TDateTime;
  Notas, TagI, TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<Cabecalho>' +
               '<CodCidade>'            + CodCidade   + '</CodCidade>' +
               '<CPFCNPJRemetente>'     + Cnpj        + '</CPFCNPJRemetente>' +
               '<RazaoSocialRemetente>' + RazaoSocial + '</RazaoSocialRemetente>' +
               '<transacao>'            + Transacao   + '</transacao>' +
               '<dtInicio>' + FormatDateTime('yyyy-mm-dd', DataInicial) + '</dtInicio>' +
               '<dtFim>'    + FormatDateTime('yyyy-mm-dd', DataInicial) + '</dtFim>' +
               '<QtdRPS>'               + QtdeNotas               + '</QtdRPS>' +
               '<ValorTotalServicos>'   + ValorTotalServicos + '</ValorTotalServicos>' +
               '<ValorTotalDeducoes>'   + ValorTotalDeducoes + '</ValorTotalDeducoes>' +
               '<Versao>'               + VersaoXML          + '</Versao>' +
               '<MetodoEnvio>'          + 'WS'               + '</MetodoEnvio>' +
             '</Cabecalho>' +
             '<Lote ' + Identificador + '="Lote:' + NumeroLote + '">' +
                Notas +
             '</Lote>';

  Result := TagI + DadosMsg + TagF;
end;

function TProvedorIssDSF.Gera_DadosMsgConsLoteDSF(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, CodCidade, CNPJ, NumeroLote: String; TagI,
  TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<Cabecalho>' +
               '<CodCidade>' + CodCidade + '</CodCidade>' +
               '<CPFCNPJRemetente>' + Cnpj + '</CPFCNPJRemetente>' +
               '<Versao>' + VersaoXML + '</Versao>' +
               '<NumeroLote>' + NumeroLote + '</NumeroLote>' +
             '</Cabecalho>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorIssDSF.Gera_DadosMsgConsNFSeRPSDSF(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, CodCidade, CNPJ, Transacao, NumeroLote: String;
  Notas, TagI, TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
  DadosMsg := '<Cabecalho>' +
               '<CodCidade>' + CodCidade + '</CodCidade>' +
               '<CPFCNPJRemetente>' + Cnpj + '</CPFCNPJRemetente>' +
               '<transacao>' + Transacao + '</transacao>' +
               '<Versao>' + VersaoXML + '</Versao>' +
             '</Cabecalho>' +
             '<Lote  Id="Lote:' + NumeroLote + '">' +
                Notas +
             '</Lote>';

 Result := TagI + DadosMsg + TagF;

end;

function TProvedorIssDSF.Gera_DadosMsgConsNFSeDSF(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, CodCidade, CNPJ, IM, NotaInicial: String;
  DataInicial, DataFinal: TDateTime; TagI, TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<Cabecalho Id="Consulta:notas">' +
               '<CodCidade>'         + CodCidade    + '</CodCidade>' +
               '<CPFCNPJRemetente>'  + CNPJ         + '</CPFCNPJRemetente>' +
               '<InscricaoMunicipalPrestador>' + IM + '</InscricaoMunicipalPrestador>' +

               '<dtInicio>' +
                 FormatDateTime('yyyy-mm-dd', DataInicial) +
               '</dtInicio>' +

               '<dtFim>' +
                 FormatDateTime('yyyy-mm-dd', DataInicial) +
               '</dtFim>' +

               '<NotaInicial>' + NotaInicial + '</NotaInicial>' +
               '<Versao>'      + VersaoXML   + '</Versao>' +
             '</Cabecalho>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorIssDSF.Gera_DadosMsgCancelarNFSeDSF(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, CNPJ, Transacao, CodMunicipio, NumeroLote: String;
  Notas, TagI, TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin

 DadosMsg := '<Cabecalho>' +
		         '<CodCidade>'        + CodMunicipio + '</CodCidade>' +
		         '<CPFCNPJRemetente>' + CNPJ      + '</CPFCNPJRemetente> ' +
		         '<transacao>'        + Transacao + '</transacao>' +
		         '<Versao>'           + VersaoXML + '</Versao>' +
	          '</Cabecalho>' +
             '<Lote Id="Lote:' + NumeroLote + '">' +
                Notas +
             '</Lote>';

 Result := TagI + DadosMsg + TagF;
end;

function TProvedorIssDSF.Gera_DadosMsgConsSeqRPSDSF(TagI, TagF: AnsiString; VersaoXML, CodCidade,
  IM, CNPJ, SeriePrestacao: string ):AnsiString;
var DadosMsg:ansistring;
begin
 //consultar sequencial RPS
 DadosMsg := '<Cabecalho>' +
               '<CodCid>' + CodCidade + '</CodCid>' +
               '<IMPrestador>' + IM + '</IMPrestador>' +
               '<CPFCNPJRemetente>' + CNPJ + '</CPFCNPJRemetente>' +
               '<SeriePrestacao>' + SeriePrestacao + '</SeriePrestacao>' +
               '<Versao>' + VersaoXML + '</Versao>' +
             '</Cabecalho>';

 Result := TagI + DadosMsg + TagF;
end;
*)
function TProvedorIssDSF.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soapenv:Envelope xmlns:dsf="http://dsfnet.com.br"' +
                           ' xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"' +
                           ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                           ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
             '<soapenv:Body>' +
               '<dsf:enviar soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
                 '<mensagemXml xsi:type="xsd:string">' +
                 //'<![CDATA[' +
                   DadosMsg +
                 //']]>' +
                 '</mensagemXml>' +
               '</dsf:enviar>' +
             '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorIssDSF.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedorIssDSF.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soapenv:Envelope xmlns:dsf="http://dsfnet.com.br"' +
                           ' xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"' +
                           ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                           ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
             '<soapenv:Body>' +
               '<dsf:consultarLote soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
                 '<mensagemXml xsi:type="xsd:string">' +
                 //'<![CDATA[' +
                   DadosMsg +
                 //']]>' +
                 '</mensagemXml>' +
               '</dsf:consultarLote>' +
             '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorIssDSF.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soapenv:Envelope xmlns:dsf="http://dsfnet.com.br"' +
                           ' xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"' +
                           ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                           ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
             '<soapenv:Body>' +
               '<dsf:consultarNFSeRps soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
                 '<mensagemXml xsi:type="xsd:string">' +
                 //'<![CDATA[' +
                   DadosMsg +
                 //']]>' +
                 '</mensagemXml>' +
               '</dsf:consultarNFSeRps>' +
             '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorIssDSF.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soapenv:Envelope xmlns:dsf="http://dsfnet.com.br"' +
                           ' xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"' +
                           ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                           ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
             '<soapenv:Body>' +
               '<dsf:consultarNota soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
                 '<mensagemXml xsi:type="xsd:string">' +
                 //'<![CDATA[' +
                   DadosMsg +
                 //']]>' +
                 '</mensagemXml>' +
               '</dsf:consultarNota>' +
             '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorIssDSF.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soapenv:Envelope xmlns:dsf="http://dsfnet.com.br"' +
                           ' xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"' +
                           ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                           ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
             '<soapenv:Body>' +
               '<dsf:cancelar soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
                 '<mensagemXml xsi:type="xsd:string">' +
                 //'<![CDATA[' +
                   DadosMsg +
                 //']]>' +
                 '</mensagemXml>' +
               '</dsf:cancelar>' +
             '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorIssDSF.GeraEnvelopeConsultarSequencialRps(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
  //consultar sequencial RPS
 Result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<soapenv:Envelope xmlns:dsf="http://dsfnet.com.br"' +
                           ' xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"' +
                           ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"' +
                           ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' +
             '<soapenv:Body>' +
               '<dsf:consultarSequencialRps soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
                 '<mensagemXml xsi:type="xsd:string">' +
                 //'<![CDATA[' +
                   DadosMsg +
                 //']]>' +
                 '</mensagemXml>' +
               '</dsf:consultarSequencialRps>' +
             '</soapenv:Body>' +
           '</soapenv:Envelope>';
end;

function TProvedorIssDSF.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'enviar';
   acConsSit:     Result := '';
   acConsLote:    Result := 'consultarLote';
   acConsNFSeRps: Result := 'consultarNFSeRps';
   acConsNFSe:    Result := 'consultarNota';
   acCancelar:    Result := 'cancelar';
   acGerar:       Result := '';
   acRecSincrono: Result := 'enviarSincrono';
   acConsSecRps:  Result := 'consultarSequencialRps';
 end;
end;

function TProvedorIssDSF.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'ns1:RetornoEnvioLoteRPS', True );
   acConsSit:     Result := '';
   acConsLote:    Result := SeparaDados( RetornoWS, 'ns1:RetornoConsultaLote', True );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'ns1:RetornoConsultaNFSeRPS', True );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'ns1:RetornoConsultaNotas', True );
   acCancelar:    Result := SeparaDados( RetornoWS, 'ns1:RetornoCancelamentoNFSe', True );
   acGerar:       Result := '';
   acConsSecRps:  Result := SeparaDados( RetornoWS, 'ns1:RetornoConsultaSeqRps', True );
 end;
end;

function TProvedorIssDSF.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<CompNfse xmlns:ns4="http://www.e-governeapps2.com.br/nfse.xsd">' +
            RetNFSe +
           '</CompNfse>';
end;

function TProvedorIssDSF.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;
(*
function TProvedorIssDSF.Gera_DadosMsgEnviarSincrono(Prefixo3,
  Prefixo4, Identificador, NameSpaceDad, VersaoDados, VersaoXML,
  NumeroLote, CNPJ, IM, QtdeNotas: String; Notas, TagI,
  TagF: AnsiString): AnsiString;
begin
 Result := '';
end;
*)
function TProvedorIssDSF.GeraEnvelopeRecepcionarSincrono(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;
(*
function TProvedorIssDSF.Gera_DadosMsgEnviarLote(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoDados, VersaoXML, NumeroLote, CNPJ,
  IM, QtdeNotas: String; Notas, TagI, TagF: AnsiString): AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Para este provedor use a função Gera_DadosMsgEnviarLoteDSF' );
end;

function TProvedorIssDSF.Gera_DadosMsgConsSitLote(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, Protocolo, CNPJ, IM: String; TagI,
  TagF: AnsiString): AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Para este provedor use a função Gera_DadosMsgConsSitLoteDSF' );
end;

function TProvedorIssDSF.Gera_DadosMsgConsLote(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, Protocolo, CNPJ, IM: String; TagI,
  TagF: AnsiString): AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Para este provedor use a função Gera_DadosMsgConsLoteDSF' );
end;

function TProvedorIssDSF.Gera_DadosMsgConsNFSeRPS(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, NumeroRps, SerieRps, TipoRps, CNPJ, IM: String;
  TagI, TagF: AnsiString): AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Para este provedor use a função Gera_DadosMsgConsNFSeRPSDSF' );
end;

function TProvedorIssDSF.Gera_DadosMsgConsNFSe(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, CNPJ, IM: String; DataInicial,
  DataFinal: TDateTime; TagI, TagF: AnsiString;
  NumeroNFSe: string): AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Para este provedor use a função Gera_DadosMsgConsNFSeDSF' );
end;

function TProvedorIssDSF.Gera_DadosMsgCancelarNFSe(Prefixo4, NameSpaceDad,
  NumeroNFSe, CNPJ, IM, CodMunicipio, CodCancelamento: String; TagI,
  TagF: AnsiString): AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Para este provedor use a função Gera_DadosMsgCancelarNFSeDSF' );
end;

function TProvedorIssDSF.Gera_DadosMsgGerarNFSe(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoDados, VersaoXML, NumeroLote, CNPJ,
  IM, QtdeNotas: String; Notas, TagI, TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Opção não implementada para este provedor.' );
end;
*)
function TProvedorIssDSF.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

end.


