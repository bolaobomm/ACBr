{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009   Isaque Pinheiro                      }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 23/08/2013: Juliana Tamizou
|*  - Padroniza��o de componente existen no Branches de acordo com o ACBr
*******************************************************************************}
unit ACBrSEF2Conversao;

interface

Uses SysUtils, Classes, ACBrTXTClass, contnrs;

  /// C�digo da finalidade do arquivo - TRegistro0000
  type TSEFIICodFinalidade = (raOriginal,     // 0 - Remessa do arquivo original
                              raSubstituto    // 1 - Remessa do arquivo substituto
                             );

  /// Vers�o do Leiaute do arquivo - TRegistro0000
  TSEFIIVersaoLeiaute = (
                         vlVersao2000  // C�digo 002 - Vers�o 2.0.0.0
                        );

  /// Tabela Conte�do do Arquivo-texto - TRegistro0000
  TSEFIIConteudArquivo = (
                         caLancOpResultFiscal,  // C�digo 20 - Lan�amentos de opera��es e resultados fiscais
                         caExtratodocfiscais
                         );

  ///Indicador de Conteudo TRegistro001
  TSEFIIIndicadorConteudo = (
                             icContConteudo,//0- Documento com conte�do
                             icSemConteudo // 1- Documento sem conte�do
                             );

  /// Tabela Externa 3.3.1 Tabela de Qualifica��o de Assinantes TRegistro005
  TSEFIIQualiAssinante = (
                  qaDiretor, //203	Diretor
                  qaConsAdministracao, //204	Conselheiro de administra��o
                  qaAdministrador, //205	Administrador
                  qaAdmGrupo, //206	Administrador de grupo
                  qaAdmSociedadeFiliada, //207	Administrador de sociedade filiada
                  qaAdmJudicialPessoaFisica, //220	Administrador judicial - pessoa f�sica
                  qaAdmJudicialPessoaJuridica, //222	Administrador judicial - pessoa jur�dica/profissional respons�vel
                  qaAdmJudicial, //223	Administrador judicial - gestor
                  qaGestorJudicial, //226	Gestor judicial
                  qaProcurador, //309	Procurador
                  qaInventariante, //312	Inventariante
                  qaLiquidante, //313	Liquidante
                  qaInterventor, //315	Interventor
                  qaEmpresario, //801	Empres�rio
                  qaContador, //900	Contador
                  qaOutros //999	Outros
                  );

  /// 6.1.1 - 	Tabela de Benef�cios Fiscais do ICMS - TRegistro0025
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
                            daTranscDocEmissaoPropria,  //1- Transcri��o de documentos de emiss�o pr�pria
                            daTranscDocEmitTerceiros,  //2- Transcri��o de documentos emitidos por terceiros
                            daTranscDocCaptDigitacao,  //3- Transcri��o de documentos capturados por digitaliza��o
                            daTranscDocEmitEquipEspecializado,  //4- Transcri��o de documentos emitidos em equipamento especializado
                            daLivrosResultObrigacoes,  //5- Livros de resultados e obriga��es
                            daLivrosMapasControle,  //6- Livros e mapas de controle
                            daGuiaInfoEconomFiscais,  //7- Guias de informa��es econ�mico-fiscais
                            daLivrosContabilidade,  //8- Livros da contabilidade
                            daExtratosDocumentos  //9- Extratos de documentos
                            );

  //Indicador de exigibilidade da escritura��o do ISS: TRegistro0030
  TSEFIIindicadorExigEscriISS = (
                                issRegSimpEscrituraImposto,//0- Sim, com regime simplificado de escritura��o do imposto
                                issRegimeIntEscrituApuracaoImposto,//2- Sim, com regime integral de escritura��o e apura��o do imposto
                                issNaoObrigadoEscriturar//9- N�o obrigado a escriturar
                                  );

  ///Indicador de exigibilidade da escritura��o do ICMS: TRegistro0030
  TSEFIndicadorExigEscriICMS = (
                                eiRegSimpEscImposto,//0- Sim, com regime simplificado de escritura��o do imposto
                                eiRegIntermEscApuracaoNormal,//1- Sim, com regime intermedi�rio de escritura��o e apura��o normal do imposto
                                eiRegimeIntEscApuracao,//2- Sim, com regime integral de escritura��o e apura��o normal do imposto
                                eiNaoObrigadoEscriturar//9- N�o obrigado a escriturar
                              );

  ///Indicador de exigibilidade do Registro de Impress�o de Documentos Fiscais: TRegistro0030
  TSEFIIIndicadorExigRegImpDocFiscais =(
                                        idSim,
                                        idNao
                                       );

  //Indicador de exigibilidade do Registro de Utiliza��o de Documentos Fiscais: TRegistro0030
  TSEFIIIndicadorExigRegUtiDocFiscais = (
                                         ufSim,
                                         ufNao
                                        );
  //Indicador de exigibilidade do Livro de Movimenta��o de Combust�veis: TRegistro0030
  TSEFIIIndicadorExigLivMovCombustiveis = (
                                          mcSim,
                                          mcNao
                                          );

  ///Indicador de exigibilidade do Registro de Ve�culos: TRegistro0030
  TSEFIIIndicadorExigRegVeiculos = (
                                    rvSim,
                                    rvNao
                                   );

  ///Indicador de exigibilidade anual do Registro de Invent�rio: TRegistro0030
  TSEFIIIndicadorExigRegAnualInvent = (
                                       aiSim,
                                       aiNao
                                      );

  //Indicador de apresenta��o da escritura��o cont�bil: TRegistro0030
  TSEFIIIndicadorExigEscContabil = (
                                    ecCompRegArqDigital,//0- Completa registrada em arquivo digital
                                    ecCompRegPapelMFA,//1- Completa registrada em papel, microfilme, fichas avulsas, ou fichas/folhas cont�nuas
                                    ecSimpRegArqDigial,//2- Simplificada registrada em arquivo digital
                                    ecSimpRegPapelMFA,//3- Simplificada registrada papel, microfilme, fichas avulsas, ou fichas/folhas cont�nuas
                                    ecLivroCaixaRegArqDigial,//4- Livro Caixa registrado em arquivo digital
                                    ecLivroCaixaRegPapelMFA,//5- Livro Caixa registrado papel, microfilme, fichas avulsas, ou fichas/folhas cont�nuas
                                    ecNaoObrigadoEscriturar//9- N�o obrigado a escriturar
                                   );
  //Indicador de opera��es sujeitas ao ISS: TRegistro0030
  TSEFIIIndicadorOpSujISS = (
                             issSim,
                             issNao
                            );

  //Indicador de opera��es sujeitas � reten��o tribut�ria do ISS, na condi��o de contribuinte-substitu�do: TRegistro0030
  TSEFIIIndicadorOpSujRetTribISSSub = (
                                       issSubSim,
                                       issSubNao
                                      );

  //Indicador de opera��es sujeitas ao ICMS:
  TSEFIIIndicadorOpSujICMS = (
                              sicmsSim,
                              sicmsNao
                             );

  //Indicador de opera��es sujeitas � substitui��o tribut�ria do ICMS, na condi��o de contribuinte-substituto: TRegistro0030
  TSEFIIIndicadorOpSujSTICMSContributSub = (
                                stSim,
                                stNao
                               );

  //Indicador de opera��es sujeitas � antecipa��o tribut�ria do ICMS, nas entradas: TRegistro0030
  TSEFIIIndicadorOpSujSTICMSEntradas = (
                                steSim,
                                steNao
                                      );

  //Indicador de opera��es sujeitas ao IPI: TRegistro0030
  TSEFIIIndicadorOpSujIPI = (
                                ipiSim,
                                ipiNao
                                      );
                           
  //Indicador de apresenta��o avulsa do Registro de Invent�rio: TRegistro0030
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
                              SrefNFVCCVC,   //02    - Nota Fiscal de Venda a Consumidor (NFVC � ou CVC, se emitida por ECF)	2
                              SrefCCF,       //2D    - Cupom Fiscal, emitido por ECF (CCF)	-
                              SrefCBP,       //2E    - Bilhete de Passagem, emitido por ECF (CBP)	-
                              SrefNFPR,      //04    - Nota Fiscal de Produtor (NFPR)	4
                              SrefNFEE,      //06    - Nota Fiscal/Conta de Energia El�trica (NFEE)	6
                              SrefNFTR,      //07    - Nota Fiscal de Servi�o de Transporte (NFTR)	7
                              SrefCTRC,      //08    - Conhecimento de Transporte Rodovi�rio de Cargas (CTRC)	8
                              SrefCTAQ,      //09    - Conhecimento de Transporte Aquavi�rio de Cargas (CTAQ)	9
                              SrefCTAR,      //10    - Conhecimento A�reo (CTAR)	10
                              SrefCTFC,      //11    - Conhecimento de Transporte Ferrovi�rio de Cargas (CTFC)	11
                              SrefBPR,       //13    - Bilhete de Passagem Rodovi�rio (BPR)	13
                              SrefBPAQ,      //14    - Bilhete de Passagem Aquavi�rio (BPAQ)	14
                              SrefBPNB,      //15    - Bilhete de Passagem e Nota de Bagagem (BPNB)	15
                              SrefBPF,       //16    - Bilhete de Passagem Ferrovi�rio (BPF)	16
                              SrefDT,        //17    - Despacho de Transporte (DT)	17
                              SrefRMD,       //18    - Resumo de Movimento Di�rio (RMD)	18
                              SrefOCC,       //20    - Ordem de Coleta de Cargas (OCC)	20
                              SrefNFSC,      //21    - Nota Fiscal de Servi�o de Comunica��o (NFSC)	21
                              SrefNFST,      //22    - Nota Fiscal de Servi�o de Telecomunica��o (NFST)	22
                              SrefGNRE,      //23    - Guia Nacional de Recolhimento Estadual (GNRE)	23
                              SrefACT,       //24    - Autoriza��o de Carregamento e Transporte (ACT)	24
                              SrefMC,        //25    - Manifesto de Carga (MC)	25
                              SrefCTMC,      //26    - Conhecimento de Transporte Multimodal de Cargas (CTMC)	26
                              SrefNFTF,      //27    - Nota Fiscal de Servi�o de Transporte Ferrovi�rio (NFTF)	27
                              SrefNFGC,      //28    - Nota Fiscal/Conta de Fornecimento de G�s Canalizado (NFGC)	-
                              SrefNFAC,      //29    - Nota Fiscal/Conta de Fornecimento de �gua Canalizada (NFAC)	-
                              SrefMV,        //30    - Manifesto de V�o (MV)	-
                              SrefBRP,       //31    - Bilhete/Recibo do Passageiro (BRP)	-
                              SrefNFe,       //55    - Nota Fiscal Eletr�nica (NF-e)	55
                              SrefCTe        //57    - Conhecimento de Transporte Eletr�nico (CT-e)	57
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

    TIndicePagamento = (SefipAVista, SefAPrazao, SefNaoOnerada);

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
                                  impsimRegimeIntermediario,
                                  impSimRegimeIntegral,
                                  impNaoObrigado);

    TIndicadorExigeDiversas = (exSim,exNao);

    TIndicadorEscrContabil = (esCompletaArquivo,
                              esCompletaPapel,
                              esSimplificadaArquivo,
                              esSimplificadaPapel,
                              esLivroCaixaArquivo,
                              esLivroCaixaPapel,
                              esNaoObrigado);



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
      FDT_INI: TDateTime;  /// Data inicial das informa��es contidas no arquivo
      FDT_FIN: TDateTime;  /// Data final das informa��es contidas no arquivo
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
                               'e n�o existe nenhum %:1s pai!', [ANomeFilho, ANomePai]);
end;

end.
