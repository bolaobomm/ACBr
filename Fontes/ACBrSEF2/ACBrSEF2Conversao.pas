{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009   Isaque Pinheiro                      }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 23/08/2013: Juliana Tamizou
|*  - Padronização de componente existen no Branches de acordo com o ACBr
*******************************************************************************}
unit ACBrSEF2Conversao;

interface

Uses SysUtils, Classes, ACBrTXTClass, contnrs;

  /// Código da finalidade do arquivo - TRegistro0000
  type TSEFIICodFinalidade = (raOriginal,     // 0 - Remessa do arquivo original
                              raSubstituto    // 1 - Remessa do arquivo substituto
                             );

  /// Versão do Leiaute do arquivo - TRegistro0000
  TSEFIIVersaoLeiaute = (
                         vlVersao2000  // Código 002 - Versão 2.0.0.0
                        );

  /// Tabela Conteúdo do Arquivo-texto - TRegistro0000
  TSEFIIConteudArquivo = (
                         caLancOpResultFiscal,  // Código 20 - Lançamentos de operações e resultados fiscais
                         caLancControlesFiscais, // Código 21 - Lançamentos de controles fiscais
                         caExtratodocfiscais  // Código 91 - Lançamentos de controles fiscais 
                         );

  ///Indicador de Conteudo TRegistro001
  TSEFIIIndicadorConteudo = (
                             icContConteudo,//0- Documento com conteúdo
                             icSemConteudo // 1- Documento sem conteúdo
                             );

  /// Tabela Externa 3.3.1 Tabela de Qualificação de Assinantes TRegistro005
  TSEFIIQualiAssinante = (
                  qaDiretor, //203	Diretor
                  qaConsAdministracao, //204	Conselheiro de administração
                  qaAdministrador, //205	Administrador
                  qaAdmGrupo, //206	Administrador de grupo
                  qaAdmSociedadeFiliada, //207	Administrador de sociedade filiada
                  qaAdmJudicialPessoaFisica, //220	Administrador judicial - pessoa física
                  qaAdmJudicialPessoaJuridica, //222	Administrador judicial - pessoa jurídica/profissional responsável
                  qaAdmJudicial, //223	Administrador judicial - gestor
                  qaGestorJudicial, //226	Gestor judicial
                  qaProcurador, //309	Procurador
                  qaInventariante, //312	Inventariante
                  qaLiquidante, //313	Liquidante
                  qaInterventor, //315	Interventor
                  qaEmpresario, //801	Empresário
                  qaContador, //900	Contador
                  qaOutros //999	Outros
                  );

  /// 6.1.1 - 	Tabela de Benefícios Fiscais do ICMS - TRegistro0025
  TSEFIIBeniFiscalICMS = (bfNenhum, //Nenhum beneficio fiscal
                          bfProdepe //PE001	Programa de Desenvolvimento do Estado de Pernambuco - Prodepe
                         );


  //Indicador de entrada de dados: TRegistro0030
  TSEFIIindicadorEntDados = (
                            iedDigitacaoDados,
                            iedImportacaoArquivo,
                            iedValidacaoArqTexto
                            );


  //Indicador do documento contido no arquivo:: TRegistro0030
  TSEFIIindicadorDocArquivo = (
                            daDocOriginalEmitArquivo,  //0- Documento original emitido em arquivo
                            daTranscDocEmissaoPropria,  //1- Transcrição de documentos de emissão própria
                            daTranscDocEmitTerceiros,  //2- Transcrição de documentos emitidos por terceiros
                            daTranscDocCaptDigitacao,  //3- Transcrição de documentos capturados por digitalização
                            daTranscDocEmitEquipEspecializado,  //4- Transcrição de documentos emitidos em equipamento especializado
                            daLivrosResultObrigacoes,  //5- Livros de resultados e obrigações
                            daLivrosMapasControle,  //6- Livros e mapas de controle
                            daGuiaInfoEconomFiscais,  //7- Guias de informações econômico-fiscais
                            daLivrosContabilidade,  //8- Livros da contabilidade
                            daExtratosDocumentos  //9- Extratos de documentos
                            );

  //Indicador de exigibilidade da escrituração do ISS: TRegistro0030
  TSEFIIindicadorExigEscriISS = (
                                issRegSimpEscrituraImposto,//0- Sim, com regime simplificado de escrituração do imposto
                                issRegimeIntEscrituApuracaoImposto,//2- Sim, com regime integral de escrituração e apuração do imposto
                                issNaoObrigadoEscriturar//9- Não obrigado a escriturar
                                  );

  ///Indicador de exigibilidade da escrituração do ICMS: TRegistro0030
  TSEFIndicadorExigEscriICMS = (
                                eiRegSimpEscImposto,//0- Sim, com regime simplificado de escrituração do imposto
                                eiRegIntermEscApuracaoNormal,//1- Sim, com regime intermediário de escrituração e apuração normal do imposto
                                eiRegimeIntEscApuracao,//2- Sim, com regime integral de escrituração e apuração normal do imposto
                                eiNaoObrigadoEscriturar//9- Não obrigado a escriturar
                              );

  ///Indicador de exigibilidade do Registro de Impressão de Documentos Fiscais: TRegistro0030
  TSEFIIIndicadorExigRegImpDocFiscais =(
                                        idSim,
                                        idNao
                                       );

  //Indicador de exigibilidade do Registro de Utilização de Documentos Fiscais: TRegistro0030
  TSEFIIIndicadorExigRegUtiDocFiscais = (
                                         ufSim,
                                         ufNao
                                        );
  //Indicador de exigibilidade do Livro de Movimentação de Combustíveis: TRegistro0030
  TSEFIIIndicadorExigLivMovCombustiveis = (
                                          mcSim,
                                          mcNao
                                          );

  ///Indicador de exigibilidade do Registro de Veículos: TRegistro0030
  TSEFIIIndicadorExigRegVeiculos = (
                                    rvSim,
                                    rvNao
                                   );

  ///Indicador de exigibilidade anual do Registro de Inventário: TRegistro0030
  TSEFIIIndicadorExigRegAnualInvent = (
                                       aiSim,
                                       aiNao
                                      );

  //Indicador de apresentação da escrituração contábil: TRegistro0030
  TSEFIIIndicadorExigEscContabil = (
                                    ecCompRegArqDigital,//0- Completa registrada em arquivo digital
                                    ecCompRegPapelMFA,//1- Completa registrada em papel, microfilme, fichas avulsas, ou fichas/folhas contínuas
                                    ecSimpRegArqDigial,//2- Simplificada registrada em arquivo digital
                                    ecSimpRegPapelMFA,//3- Simplificada registrada papel, microfilme, fichas avulsas, ou fichas/folhas contínuas
                                    ecLivroCaixaRegArqDigial,//4- Livro Caixa registrado em arquivo digital
                                    ecLivroCaixaRegPapelMFA,//5- Livro Caixa registrado papel, microfilme, fichas avulsas, ou fichas/folhas contínuas
                                    ecNaoObrigadoEscriturar//9- Não obrigado a escriturar
                                   );
  //Indicador de operações sujeitas ao ISS: TRegistro0030
  TSEFIIIndicadorOpSujISS = (
                             issSim,
                             issNao
                            );

  //Indicador de operações sujeitas à retenção tributária do ISS, na condição de contribuinte-substituído: TRegistro0030
  TSEFIIIndicadorOpSujRetTribISSSub = (
                                       issSubSim,
                                       issSubNao
                                      );

  //Indicador de operações sujeitas ao ICMS:
  TSEFIIIndicadorOpSujICMS = (
                              sicmsSim,
                              sicmsNao
                             );

  //Indicador de operações sujeitas à substituição tributária do ICMS, na condição de contribuinte-substituto: TRegistro0030
  TSEFIIIndicadorOpSujSTICMSContributSub = (
                                stSim,
                                stNao
                               );

  //Indicador de operações sujeitas à antecipação tributária do ICMS, nas entradas: TRegistro0030
  TSEFIIIndicadorOpSujSTICMSEntradas = (
                                steSim,
                                steNao
                                      );

  //Indicador de operações sujeitas ao IPI: TRegistro0030
  TSEFIIIndicadorOpSujIPI = (
                                ipiSim,
                                ipiNao
                                      );
                           
  //Indicador de apresentação avulsa do Registro de Inventário: TRegistro0030
  TSEFIndicadorRegIvent = (
                           riSim,
                           riNao
                          );


 TSEFIIIndicadorDocArregadacao = (
                                 daEstadualDistrital,
                                 daGuiaNasRecEstadual,
                                 daDocArrecadacaoMunicipal,
                                 daDocArrecadacaoFederal,
                                 daOutros
                                 );



 TSEFIIDocFiscalReferenciado = (
                              SrefNF,        //01    - Nota Fiscal (NF)	1/1-A
                              SrefNFVCCVC,   //02    - Nota Fiscal de Venda a Consumidor (NFVC – ou CVC, se emitida por ECF)	2
                              SrefCCF,       //2D    - Cupom Fiscal, emitido por ECF (CCF)	-
                              SrefCBP,       //2E    - Bilhete de Passagem, emitido por ECF (CBP)	-
                              SrefNFPR,      //04    - Nota Fiscal de Produtor (NFPR)	4
                              SrefNFEE,      //06    - Nota Fiscal/Conta de Energia Elétrica (NFEE)	6
                              SrefNFTR,      //07    - Nota Fiscal de Serviço de Transporte (NFTR)	7
                              SrefCTRC,      //08    - Conhecimento de Transporte Rodoviário de Cargas (CTRC)	8
                              SrefCTAQ,      //09    - Conhecimento de Transporte Aquaviário de Cargas (CTAQ)	9
                              SrefCTAR,      //10    - Conhecimento Aéreo (CTAR)	10
                              SrefCTFC,      //11    - Conhecimento de Transporte Ferroviário de Cargas (CTFC)	11
                              SrefBPR,       //13    - Bilhete de Passagem Rodoviário (BPR)	13
                              SrefBPAQ,      //14    - Bilhete de Passagem Aquaviário (BPAQ)	14
                              SrefBPNB,      //15    - Bilhete de Passagem e Nota de Bagagem (BPNB)	15
                              SrefBPF,       //16    - Bilhete de Passagem Ferroviário (BPF)	16
                              SrefDT,        //17    - Despacho de Transporte (DT)	17
                              SrefRMD,       //18    - Resumo de Movimento Diário (RMD)	18
                              SrefOCC,       //20    - Ordem de Coleta de Cargas (OCC)	20
                              SrefNFSC,      //21    - Nota Fiscal de Serviço de Comunicação (NFSC)	21
                              SrefNFST,      //22    - Nota Fiscal de Serviço de Telecomunicação (NFST)	22
                              SrefGNRE,      //23    - Guia Nacional de Recolhimento Estadual (GNRE)	23
                              SrefACT,       //24    - Autorização de Carregamento e Transporte (ACT)	24
                              SrefMC,        //25    - Manifesto de Carga (MC)	25
                              SrefCTMC,      //26    - Conhecimento de Transporte Multimodal de Cargas (CTMC)	26
                              SrefNFTF,      //27    - Nota Fiscal de Serviço de Transporte Ferroviário (NFTF)	27
                              SrefNFGC,      //28    - Nota Fiscal/Conta de Fornecimento de Gás Canalizado (NFGC)	-
                              SrefNFAC,      //29    - Nota Fiscal/Conta de Fornecimento de Água Canalizada (NFAC)	-
                              SrefMV,        //30    - Manifesto de Vôo (MV)	-
                              SrefBRP,       //31    - Bilhete/Recibo do Passageiro (BRP)	-
                              SrefNFe,       //55    - Nota Fiscal Eletrônica (NF-e)	55
                              SrefCTe        //57    - Conhecimento de Transporte Eletrônico (CT-e)	57
                              );

   TIndiceOperacao = (SefioEntrada, SefioSaida);
   TIndiceEmissao = (SefiePropria, SefieTerceiros);
   TCodigoSituacao = (
                      SefcsEmissaonormal,             //00
                      SefcsEmissaocontingencia,       //01
                      SefcsEmissaocontingenciaFS,     //02
                      SefcsEmissaocontingenciaSCAN,   //03
                      SefcsEmissaocontingenciaDPEC,   //04
                      SefcsEmissaocontingenciaFSDA,   //05
                      SefcsEmissaoavulsa,             //10
                      SefcsComplemento,               //20
                      SefcsConsolidavalores,          //25
                      SefcsAutorizadenegada,          //80
                      SefcsNumerainutilizada,         //81
                      SefcsOperacancelada,            //90
                      SefcsNegociodesfeito,           //91
                      SefcsAjusteinformacoes,         //95
                      SefcsSemrepercussaofiscal       //99
                      );

    TIndicePagamento = (SefNenhum,SefipAVista, SefAPrazao, SefNaoOnerada);

    TIndicadorDados = (entDigitacao,entImportacao,entValidacao);

    TIndicadorDocArquivo = (arqOriginal,
                            arqTranscricaoEmissaoPropria,
                            arqTranscricaoEmissaoTerceiros,
                            arqTrancricaoDigitalizacao,
                            arqTranscricaoEmissaoEquipEspecilizado,
                            arqLivrosResultadosObrigacoes,
                            arqLivroMapaControles,
                            arqGuiasInfEconomicasFiscais,
                            arqLivrosContabilidade,
                            arqExtratoDocumentos);


    TIndicadorExigeEscrImposto = (impSimRegimeSimplificado,
                                  impSimRegimeIntermediario,
                                  impSimRegimeIntegral,
                                  impNaoObrigado);

    TIndicadorExigeDiversas = (exSim,exNao,exVazio);

    TIndicadorEscrContabil = (esCompletaArquivo,
                              esCompletaPapel,
                              esSimplificadaArquivo,
                              esSimplificadaPapel,
                              esLivroCaixaArquivo,
                              esLivroCaixaPapel,
                              esNaoObrigado,
                              esVazio);



    { TOpenBlocos }

    TOpenBlocos = class
    private
      fCOD_MUN: Integer;
      fIND_MOV: TSEFIIIndicadorConteudo;    /// Indicador de movimento: 0- Bloco com dados informados, 1- Bloco sem dados informados.
    public
      property COD_MUN: Integer read fCOD_MUN write fCOD_MUN;
      property IND_MOV: TSEFIIIndicadorConteudo read fIND_MOV write fIND_MOV;
    end;

    TACBrSEFIIRegistros = class(TObjectList)
    public
      function AchaUltimoPai(ANomePai, ANomeFilho: String): Integer;
    end;

    TACBrSEFIIEDOC = class(TACBrTXTClass)
    private
      FDT_INI: TDateTime;  /// Data inicial das informações contidas no arquivo
      FDT_FIN: TDateTime;  /// Data final das informações contidas no arquivo
      FGravado: Boolean;
    public
      property DT_INI : TDateTime read FDT_INI  write FDT_INI;
      property DT_FIN : TDateTime read FDT_FIN  write FDT_FIN;
      property Gravado: Boolean   read FGravado write FGravado ;
    end;

implementation

{ TACBrSEFIIRegistros }

function TACBrSEFIIRegistros.AchaUltimoPai(ANomePai,
  ANomeFilho: String): Integer;
begin
   Result := Count - 1;
   if Result < 0 then
     raise Exception.CreateFmt('O registro %:0s deve ser filho do registro %:1s, ' +
                               'e não existe nenhum %:1s pai!', [ANomeFilho, ANomePai]);
end;

end.
