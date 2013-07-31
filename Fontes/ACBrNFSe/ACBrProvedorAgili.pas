{$I ACBr.inc}

unit ACBrProvedorAgili;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorAgili }

 TProvedorAgili = class(TProvedorClass)
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

{ TProvedorAgili }

constructor TProvedorAgili.Create;
begin
 {----}
end;

function TProvedorAgili.GetConfigCidade(ACodCidade,
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
  then ConfigCidade.NameSpaceEnvelope := 'http://nfse.abrasf.org.br'
  else ConfigCidade.NameSpaceEnvelope := 'http://nfse.abrasf.org.br';

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorAgili.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '1.00';
 ConfigSchema.VersaoDados     := '1.00';
 ConfigSchema.VersaoXML       := '2';
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

function TProvedorAgili.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
 nfse: String;
begin
 case ACodCidade of
  5106224: begin // Nova Mutum/MT
//            ConfigURL.HomNomeCidade := 'http://201.57.87.179:92';
//            ConfigURL.ProNomeCidade := 'http://201.57.87.179:9292';
            ConfigURL.HomNomeCidade := '201.57.87.179:92';
            ConfigURL.ProNomeCidade := '201.57.87.179:9292';
           end;
  5105150: begin // Juina/MT
//            ConfigURL.HomNomeCidade := 'http://187.6.65.35:92';
//            ConfigURL.ProNomeCidade := 'http://187.6.65.35:9292';
            ConfigURL.HomNomeCidade := '187.6.65.35:92';
            ConfigURL.ProNomeCidade := '187.6.65.35:9292';
           end;
 end;

 ConfigURL.HomRecepcaoLoteRPS    := 'http://' + ConfigURL.HomNomeCidade + '/ServicoNFSe.asmx';
 ConfigURL.HomConsultaLoteRPS    := 'http://' + ConfigURL.HomNomeCidade + '/ServicoNFSe.asmx';
 ConfigURL.HomConsultaNFSeRPS    := 'http://' + ConfigURL.HomNomeCidade + '/ServicoNFSe.asmx';
 ConfigURL.HomConsultaSitLoteRPS := 'http://' + ConfigURL.HomNomeCidade + '/ServicoNFSe.asmx';
 ConfigURL.HomConsultaNFSe       := 'http://' + ConfigURL.HomNomeCidade + '/ServicoNFSe.asmx';
 ConfigURL.HomCancelaNFSe        := 'http://' + ConfigURL.HomNomeCidade + '/ServicoNFSe.asmx';

 ConfigURL.ProRecepcaoLoteRPS    := 'http://' + ConfigURL.ProNomeCidade + '/ServicoNFSe.asmx';
 ConfigURL.ProConsultaLoteRPS    := 'http://' + ConfigURL.ProNomeCidade + '/ServicoNFSe.asmx';
 ConfigURL.ProConsultaNFSeRPS    := 'http://' + ConfigURL.ProNomeCidade + '/ServicoNFSe.asmx';
 ConfigURL.ProConsultaSitLoteRPS := 'http://' + ConfigURL.ProNomeCidade + '/ServicoNFSe.asmx';
 ConfigURL.ProConsultaNFSe       := 'http://' + ConfigURL.ProNomeCidade + '/ServicoNFSe.asmx';
 ConfigURL.ProCancelaNFSe        := 'http://' + ConfigURL.ProNomeCidade + '/ServicoNFSe.asmx';

 Result := ConfigURL;
end;

function TProvedorAgili.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorAgili.GetAssinarXML(Acao: TnfseAcao): Boolean;
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

function TProvedorAgili.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedorAgili.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
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
   acRecSincrono: Result := '';
 end;
end;

function TProvedorAgili.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorAgili.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorAgili.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
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
   acRecSincrono: Result := '';
 end;
end;
(*
function TProvedorAgili.Gera_DadosMsgEnviarLote(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoDados, VersaoXML, NumeroLote, CNPJ,
  IM, QtdeNotas: String; Notas, TagI, TagF: AnsiString): AnsiString;
var
 DadosMsg: AnsiString;
begin
 DadosMsg := '<' + Prefixo3 + 'LoteRps'+
               DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + NumeroLote + '"', '') + '>' +
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

function TProvedorAgili.Gera_DadosMsgConsLote(Prefixo3, Prefixo4,
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

function TProvedorAgili.Gera_DadosMsgConsNFSeRPS(Prefixo3, Prefixo4,
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

function TProvedorAgili.Gera_DadosMsgConsNFSe(Prefixo3, Prefixo4,
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

function TProvedorAgili.Gera_DadosMsgCancelarNFSe(Prefixo4, NameSpaceDad, NumeroNFSe,
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
               // 1 - Erro de emissão
               // 2 - Serviço não concluido
               // 3 - RPS Cancelado na Emissão

                CodCancelamento +

              '</' + Prefixo4 + 'CodigoCancelamento>' +
             '</' + Prefixo4 + 'InfPedidoCancelamento>';

 Result := TagI + DadosMsg + TagF;
end;
*)
function TProvedorAgili.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Header>' +
             '<Token xmlns="' + URLNS + '/">' +
              '<Chave> '+ DadosSenha + '</Chave>' +
             '</Token>'+
            '</s:Header>' +
            '<S:Body>' +
             '<RecepcionarLoteRpsRequest xmlns="' + URLNS + '/">' +
             '<nfseCabecMsg xmlns="">' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg xmlns="">' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseDadosMsg>' +
             '</RecepcionarLoteRpsRequest>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedorAgili.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Header>' +
             '<Token xmlns="' + URLNS + '/">' +
              '<Chave> '+ DadosSenha + '</Chave>' +
             '</Token>'+
            '</s:Header>' +
            '<s:Body>' +
             '<ConsultarSituacaoLoteRpsRequest xmlns="' + URLNS + '/">' +
              '<nfseCabecMsg xmlns="">' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg xmlns="">' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseDadosMsg>' +
             '</ConsultarSituacaoLoteRpsRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorAgili.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Header>' +
             '<Token xmlns="' + URLNS + '/">' +
              '<Chave> '+ DadosSenha + '</Chave>' +
             '</Token>'+
            '</s:Header>' +
            '<s:Body>' +
             '<ConsultarLoteRpsRequest xmlns="' + URLNS + '/">' +
              '<nfseCabecMsg xmlns="">' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg xmlns="">' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseDadosMsg>' +
             '</ConsultarLoteRpsRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorAgili.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Header>' +
             '<Token xmlns="' + URLNS + '/">' +
              '<Chave> '+ DadosSenha + '</Chave>' +
             '</Token>'+
            '</s:Header>' +
            '<s:Body>' +
             '<ConsultarNfsePorRpsRequest xmlns="' + URLNS + '/">' +
              '<nfseCabecMsg xmlns="">' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg xmlns="">' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseDadosMsg>' +
             '</ConsultarNfsePorRpsRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorAgili.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Header>' +
             '<Token xmlns="' + URLNS + '/">' +
              '<Chave> '+ DadosSenha + '</Chave>' +
             '</Token>'+
            '</s:Header>' +
            '<s:Body>' +
             '<ConsultarNfseRequest xmlns="' + URLNS + '/">' +
              '<nfseCabecMsg xmlns="">' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg xmlns="">' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseDadosMsg>' +
             '</ConsultarNfseRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorAgili.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<s:Header>' +
             '<Token xmlns="' + URLNS + '/">' +
              '<Chave> '+ DadosSenha + '</Chave>' +
             '</Token>'+
            '</s:Header>' +
            '<s:Body>' +
             '<CancelarNfseRequest xmlns="' + URLNS + '/">' +
              '<nfseCabecMsg xmlns="">' +
                StringReplace(StringReplace(CabMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseCabecMsg>' +
              '<nfseDadosMsg xmlns="">' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</nfseDadosMsg>' +
             '</CancelarNfseRequest>' +
            '</s:Body>' +
           '</s:Envelope>';
end;

function TProvedorAgili.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Opção não implementada para este provedor.' );
end;

function TProvedorAgili.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'http://nfse.abrasf.org.br/RecepcionarLoteRps';
   acConsSit:     Result := '';
   acConsLote:    Result := 'http://nfse.abrasf.org.br/ConsultarLoteRps';
   acConsNFSeRps: Result := 'http://nfse.abrasf.org.br/ConsultarNfsePorRps';
   acConsNFSe:    Result := '';
   acCancelar:    Result := 'http://nfse.abrasf.org.br/CancelarNfse';
   acGerar:       Result := 'http://nfse.abrasf.org.br/GerarNfse';
   acRecSincrono: Result := '';
 end;
end;

function TProvedorAgili.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'outputXML' );
   acConsSit:     Result := '';
   acConsLote:    Result := SeparaDados( RetornoWS, 'outputXML' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'outputXML' );
   acConsNFSe:    Result := '';
   acCancelar:    Result := SeparaDados( RetornoWS, 'outputXML' );
   acGerar:       Result := SeparaDados( RetornoWS, 'outputXML' );
   acRecSincrono: Result := '';
 end;
end;

function TProvedorAgili.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorAgili.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

function TProvedorAgili.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
 raise Exception.Create( 'Opção não implementada para este provedor.' );
end;

end.
