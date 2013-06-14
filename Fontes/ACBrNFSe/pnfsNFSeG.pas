unit pnfsNFSeG;

interface

uses
  SysUtils, Classes, Forms,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pnfsNFSe, pnfsConversao, ACBrDFeUtil;

type

  TNFSeG = class
   private

   protected

   public
     class function Gera_DadosMsgEnviarLote(Prefixo3, Prefixo4, Identificador,
                                    NameSpaceDad, VersaoDados, VersaoXML,
                                    NumeroLote, CNPJ, IM, QtdeNotas: String;
                                    Notas, TagI, TagF: AnsiString; AProvedor: TnfseProvedor = proNenhum): AnsiString;

     class function Gera_DadosMsgConsSitLote(Prefixo3, Prefixo4, NameSpaceDad,
                                     VersaoXML, Protocolo, CNPJ, IM: String;
                                     TagI, TagF: AnsiString; AProvedor: TnfseProvedor = proNenhum): AnsiString;

     class function Gera_DadosMsgConsLote(Prefixo3, Prefixo4, NameSpaceDad,
                                  VersaoXML, Protocolo, CNPJ, IM: String;
                                  TagI, TagF: AnsiString; AProvedor: TnfseProvedor = proNenhum): AnsiString;

     class function Gera_DadosMsgConsNFSeRPS(Prefixo3, Prefixo4, NameSpaceDad, VersaoXML,
                                     NumeroRps, SerieRps, TipoRps, CNPJ, IM: String;
                                     TagI, TagF: AnsiString; AProvedor: TnfseProvedor = proNenhum): AnsiString;

     class function Gera_DadosMsgConsNFSe(Prefixo3, Prefixo4, NameSpaceDad, VersaoXML,
                                  CNPJ, IM: String;
                                  DataInicial, DataFinal: TDateTime;
                                  TagI, TagF: AnsiString; NumeroNFSe: string = ''; AProvedor: TnfseProvedor = proNenhum): AnsiString;

     class function Gera_DadosMsgCancelarNFSe(Prefixo4, NameSpaceDad, NumeroNFSe, CNPJ, IM,
                                      CodMunicipio, CodCancelamento: String;
                                      TagI, TagF: AnsiString; AProvedor: TnfseProvedor = proNenhum): AnsiString;

     class function Gera_DadosMsgGerarNFSe(Prefixo3, Prefixo4, Identificador,
                                   NameSpaceDad, VersaoDados, VersaoXML,
                                   NumeroLote, CNPJ, IM, QtdeNotas: String;
                                   Notas, TagI, TagF: AnsiString; AProvedor: TnfseProvedor = proNenhum): AnsiString;

     class function Gera_DadosMsgEnviarSincrono(Prefixo3, Prefixo4, Identificador,
                                        NameSpaceDad, VersaoDados, VersaoXML,
                                        NumeroLote, CNPJ, IM, QtdeNotas: String;
                                        Notas, TagI, TagF: AnsiString; AProvedor: TnfseProvedor = proNenhum): AnsiString;

   published

   end;

implementation

//uses
// IniFiles, Variants, ACBrUtil, ACBrConsts;

class function TNFSeG.Gera_DadosMsgEnviarLote(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoDados, VersaoXML, NumeroLote, CNPJ,
  IM, QtdeNotas: String; Notas, TagI, TagF: AnsiString; AProvedor: TnfseProvedor = proNenhum): AnsiString;
var
 DadosMsg: AnsiString;
begin
 if AProvedor = proBetha
  then Prefixo3 := '';
  
 DadosMsg := '<' + Prefixo3 + 'LoteRps'+
               DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + NumeroLote + '"', '') +
               DFeUtil.SeSenao(AProvedor in [proAbaco, proBetha, proGinfes, proGoiania, proGovBR,
                                             proISSDigital, proIssCuritiba, proISSNET, proNatal,
                                             proRecife, proRJ, proSimplISS, proThema, proTiplan], '',
                DFeUtil.SeSenao(VersaoDados <> '', ' versao="' + VersaoDados + '"', '')) + '>' +
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

class function TNFSeG.Gera_DadosMsgConsSitLote(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, Protocolo, CNPJ, IM: String; TagI,
  TagF: AnsiString; AProvedor: TnfseProvedor = proNenhum): AnsiString;
var
 DadosMsg: AnsiString;
begin
 if AProvedor = proBetha
  then Prefixo3 := '';
  
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

class function TNFSeG.Gera_DadosMsgConsLote(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, Protocolo, CNPJ, IM: String; TagI,
  TagF: AnsiString; AProvedor: TnfseProvedor = proNenhum): AnsiString;
var
 DadosMsg: AnsiString;
begin
 if AProvedor = proBetha
  then Prefixo3 := '';
  
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

class function TNFSeG.Gera_DadosMsgConsNFSeRPS(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, NumeroRps, SerieRps, TipoRps, CNPJ, IM: String; TagI,
  TagF: AnsiString; AProvedor: TnfseProvedor = proNenhum): AnsiString;
var
 DadosMsg: AnsiString;
begin
 if AProvedor = proBetha
  then Prefixo3 := '';
  
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

class function TNFSeG.Gera_DadosMsgConsNFSe(Prefixo3, Prefixo4,
  NameSpaceDad, VersaoXML, CNPJ, IM: String; DataInicial, DataFinal: TDateTime; TagI,
  TagF: AnsiString; NumeroNFSe: string = ''; AProvedor: TnfseProvedor = proNenhum): AnsiString;
var
 DadosMsg: AnsiString;
begin
 if AProvedor = proBetha
  then Prefixo3 := '';
  
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

class function TNFSeG.Gera_DadosMsgCancelarNFSe(Prefixo4, NameSpaceDad, NumeroNFSe,
  CNPJ, IM, CodMunicipio, CodCancelamento: String; TagI,
  TagF: AnsiString; AProvedor: TnfseProvedor = proNenhum): AnsiString;
var
 DadosMsg: AnsiString;
begin
 case AProvedor of
  proGinfes: DadosMsg := '<Prestador>' +
                          '<' + Prefixo4 + 'Cnpj>' +
                            Cnpj +
                          '</' + Prefixo4 + 'Cnpj>' +
                          '<' + Prefixo4 + 'InscricaoMunicipal>' +
                            IM +
                          '</' + Prefixo4 + 'InscricaoMunicipal>' +
                         '</Prestador>' +
                         '<NumeroNfse>' +
                           NumeroNFSe +
                         '</NumeroNfse>';
                         
  else DadosMsg := '<' + Prefixo4 + 'IdentificacaoNfse>' +
                    '<' + Prefixo4 + 'Numero>' +
                      NumeroNFse +
                    '</' + Prefixo4 + 'Numero>' +

                   DFeUtil.SeSenao(AProvedor = pro4R,

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
 end;
 
 Result := TagI + DadosMsg + TagF;
end;

class function TNFSeG.Gera_DadosMsgGerarNFSe(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoDados, VersaoXML, NumeroLote, CNPJ,
  IM, QtdeNotas: String; Notas, TagI, TagF: AnsiString; AProvedor: TnfseProvedor = proNenhum): AnsiString;
var
 DadosMsg: AnsiString;
begin
 if AProvedor = proBetha
  then Prefixo3 := '';
  
 case AProvedor of
  pro4R: Result := TagI + Notas + TagF;
  else begin // proWebISS
   DadosMsg := '<' + Prefixo3 + 'LoteRps'+
                 DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + NumeroLote + '"', '') +
                 DFeUtil.SeSenao(VersaoDados <> '', ' versao="' + VersaoDados + '"', '') + '>' +
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
 end;
end;

class function TNFSeG.Gera_DadosMsgEnviarSincrono(Prefixo3, Prefixo4,
  Identificador, NameSpaceDad, VersaoDados, VersaoXML, NumeroLote, CNPJ,
  IM, QtdeNotas: String; Notas, TagI, TagF: AnsiString; AProvedor: TnfseProvedor = proNenhum): AnsiString;
begin
 Result := Gera_DadosMsgEnviarLote(Prefixo3, Prefixo4, Identificador, NameSpaceDad,
                              VersaoDados, VersaoXML, NumeroLote, CNPJ, IM,
                              QtdeNotas, Notas, TagI, TagF, AProvedor);
end;

end.
