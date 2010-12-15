{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2010   Isaque Pinheiro                      }
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
|* 14/12/2010: Isaque Pinheiro e Claudio Roberto de Souza
|*  - Cria��o e distribui��o da Primeira Versao
*******************************************************************************}

unit ACBrEPCBloco_C;

interface

uses
  SysUtils, Classes, Contnrs, DateUtils;

type
  //REGISTRO C001: ABERTURA DO BLOCO C
  TRegistroC001 = class(TOpenBlocos)
  private
  public
  end;

  //REGISTRO C010: IDENTIFICA��O DO ESTABELECIMENTO
  TRegistroC010 = class
  private
    fCNPJ: Integer;           //02	CNPJ	N�mero de inscri��o do estabelecimento no CNPJ.	N	014*	-
    fIND_ESCRI: Integer;      //03	IND_ESCRI	Indicador da apura��o das contribui��es e cr�ditos, na escritura��o das opera��es por NF-e e ECF, no per�odo:1 � Apura��o com base nos registros de consolida��o das opera��es por NF-e (C180 e C190) e por ECF (C490);2 � Apura��o com base no registro individualizado de NF-e (C100 e C170) e de ECF (C400)	C	001*	-
  public
    property CNPJ: Integer read FCNPJ write FCNPJ;
    property IND_ESCRI: Integer read FIND_ESCRI write FIND_ESCRI;
  end;

  //REGISTRO C110: COMPLEMENTO DO DOCUMENTO - INFORMA��O COMPLEMENTAR DA NOTA FISCAL
  //ver se vai ser implementado aqui ou herdar do efd

  //REGISTRO C111: PROCESSO REFERENCIADO
  TRegistroC111 = class
  private
    fNUM_PROC: string;           //02	NUM_PROC	Identifica��o do processo ou ato concess�rio	C	020	-
    fIND_PROC: Integer;          //03	IND_PROC	Indicador da origem do processo:1 - Justi�a Federal;3 � Secretaria da Receita Federal do Brasil;9 � Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO C120: COMPLEMENTO DO DOCUMENTO - OPERA��ES DE IMPORTA��O (C�DIGO 01)
  //ver tambem

  //REGISTRO C170: COMPLEMENTO DO DOCUMENTO - ITENS DO DOCUMENTO (C�DIGOS 01, 1B, 04 e 55)
  //ver tambem

  //REGISTRO C180: CONSOLIDA��O DE NOTAS FISCAIS ELETR�NICAS EMITIDAS PELA PESSOA JUR�DICA (C�DIGO 55) � OPERA��ES DE VENDAS
  TRegistroC180 = class
  private
    fCOD_MOD: string;	             //02	COD_MOD	Texto fixo contendo "55" C�digo da Nota Fiscal Eletr�nica, modelo 55, conforme a Tabela 4.1.1.	C	002*	-
    fDT_DOC_INI: TDateTime;	       //03	DT_DOC_INI	Data de Emiss�o Inicial dos Documentos	N	008*	-
    fDT_DOC_FIN: TDateTime;	       //04	DT_DOC_FIN	Data de Emiss�o Final dos Documentos	N	008*	-
    fCOD_ITEM: string;	             //05	COD_ITEM	C�digo do Item (campo 02 do Registro 0200)	C	060	-
    fCOD_NCM: string;	             //06	COD_NCM	C�digo da Nomenclatura Comum do Mercosul	C	008*	-
    fEX_IPI: string;	               //07	EX_IPI	C�digo EX, conforme a TIPI	C	003	-
    fVL_TOT_ITEM: Currency;	       //08	VL_TOT_ITEM	Valor Total do Item	N	-	02
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property DT_DOC_INI: TDateTime read FDT_DOC_INI write FDT_DOC_INI;
    property DT_DOC_FIN: TDateTime read FDT_DOC_FIN write FDT_DOC_FIN;
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property COD_NCM: string read FCOD_NCM write FCOD_NCM;
    property EX_IPI: string read FEX_IPI write FEX_IPI;
    property VL_TOT_ITEM: Currency read FVL_TOT_ITEM write FVL_TOT_ITEM;
  end;

  //REGISTRO C181: DETALHAMENTO DA CONSOLIDA��O � OPERA��ES DE VENDAS � PIS/PASEP
  TRegistroC181 = class
  private
    fCST_PIS: string;	              //02	CST_PIS	C�digo da Situa��o Tribut�ria referente ao PIS/PASEP, conforme a Tabela indicada no item 4.3.3.	N	002*	-
    fCFOP: Integer;	                //03	CFOP	C�digo fiscal de opera��o e presta��o	N	004*	-
    fVL_ITEM: Currency;	            //04	VL_ITEM	Valor do item	N	-	02
    fVL_DESC: Currency;	            //05	VL_DESC	Valor do desconto comercial	N	-	02
    fVL_BC_PIS: Currency;	          //06	VL_BC_PIS	Valor da base de c�lculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;	            //07	ALIQ_PIS	Al�quota do PIS/PASEP (em percentual)	N	008	04
    fQUANT_BC_PIS: Currency;	        //08	QUANT_BC_PIS	Quantidade � Base de c�lculo PIS/PASEP	N	 -	03
    fALIQ_PIS_QUANT: Currency;	      //09	ALIQ_PIS_QUANT	Al�quota do PIS/PASEP (em reais)	N	 -	04
    fVL_PIS: Currency;	              //10	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	              //11	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property CST_PIS: string read FCST_PIS write FCST_PIS;
    property CFOP: Integer read FCFOP write FCFOP;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property QUANT_BC_PIS: Currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property ALIQ_PIS_QUANT: Currency read FALIQ_PIS_QUANT write FALIQ_PIS_QUANT;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO C185: DETALHAMENTO DA CONSOLIDA��O � OPERA��ES DE VENDAS � COFINS
  TRegistroC185 = class
  private
    fCST_COFINS: string;	            //02	CST_COFINS	C�digo da Situa��o Tribut�ria referente a COFINS, conforme a Tabela indicada no item 4.3.4.	N	002*	-
    fCFOP: Integer;	                  //03	CFOP	C�digo fiscal de opera��o e presta��o	N	004*	-
    fVL_ITEM: Currency;	              //04	VL_ITEM	Valor do item	N	-	02
    fVL_DESC: Currency;	              //05	VL_DESC	Valor do desconto comercial	N	-	02
    fVL_BC_COFINS: Currency;	        //06	VL_BC_COFINS	Valor da base de c�lculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	          //07	ALIQ_COFINS	Al�quota da COFINS (em percentual)	N	008	04
    fQUANT_BC_COFINS: Currency;	      //08	QUANT_BC_COFINS	Quantidade � Base de c�lculo da COFINS	N	 -	03
    fALIQ_COFINS_QUANT: Currency;     //09	ALIQ_COFINS_QUANT	Al�quota da COFINS (em reais)	N	 -	04
    fVL_COFINS: Currency;	            //10	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	                //11	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property CST_COFINS: string read FCST_COFINS write FCST_COFINS;
    property CFOP: Integer read FCFOP write FCFOP;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property QUANT_BC_COFINS: Currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property ALIQ_COFINS_QUANT: Currency read FALIQ_COFINS_QUANT write FALIQ_COFINS_QUANT;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO C188: PROCESSO REFERENCIADO
  TRegistroC188 = class
  private
    fNUM_PROC: string;        //02	NUM_PROC	Identifica��o do processo ou ato concess�rio	C	020	-
    fIND_PROC: Integer;       //03	IND_PROC	Indicador da origem do processo:1 - Justi�a Federal;3 - Secretaria da Receita Federal do Brasil;9 � Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO C190: CONSOLIDA��O DE NOTAS FISCAIS ELETR�NICAS (C�DIGO 55) � OPERA��ES DE AQUISI��O COM DIREITO A CR�DITO, E OPERA��ES DE DEVOLU��O DE COMPRAS E VENDAS
  TRegistroC190 = class
  private
    fCOD_MOD: string;	               //02	COD_MOD	Texto fixo contendo "55" C�digo da Nota Fiscal Eletr�nica, modelo 55, conforme a Tabela 4.1.1.	C	002*	-
    fDT_REF_INI: TDateTime;          //03	DT_REF_INI	Data Inicial de Referencia da Consolida��o	N	008*	-
    fDT_REF_FIN: TDateTime;          //04	DT_REF_FIN	Data Final de Referencia da Consolida��o	N	008*	-
    fCOD_ITEM: string;	             //05	COD_ITEM	C�digo do item (campo 02 do Registro 0200)	C	060	-
    fCOD_NCM: string;	               //06	COD_NCM	C�digo da Nomenclatura Comum do Mercosul	C	008*	-
    fEX_IPI: string;	               //07	EX_IPI	C�digo EX, conforme a TIPI	C	003	-
    fVL_TOT_ITEM: Currency;          //08	VL_TOT_ITEM	Valor Total do Item	N	-	02
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property DT_REF_INI: TDateTime read FDT_REF_INI write FDT_REF_INI;
    property DT_REF_FIN: TDateTime read FDT_REF_FIN write FDT_REF_FIN;
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property COD_NCM: string read FCOD_NCM write FCOD_NCM;
    property EX_IPI: string read FEX_IPI write FEX_IPI;
    property VL_TOT_ITEM: Currency read FVL_TOT_ITEM write FVL_TOT_ITEM;
  end;

  //REGISTRO C191: DETALHAMENTO DA CONSOLIDA��O � OPERA��ES DE AQUISI��O COM DIREITO A CR�DITO, E OPERA��ES DE DEVOLU��O DE COMPRAS E VENDAS � PIS/PASEP
  TRegistroC191 = class
  private
    fCOD_PART: string;	             //02	COD_PART	C�digo do Participante (campo 02 do Registro 0150) do emitente dos documentos ou do remetente das mercadorias.	C	060	-
    fCST_PIS: string;	               //03	CST_PIS	C�digo da Situa��o Tribut�ria referente ao PIS/PASEP	N	002*	-
    fCFOP: Integer;	                 //04	CFOP	C�digo fiscal de opera��o e presta��o	N	004*	-
    fVL_ITEM: Currency;	             //05	VL_ITEM	Valor do item	N	-	02
    fVL_DESC: Currency;	             //06	VL_DESC	Valor do desconto comercial	N	-	02
    fVL_BC_PIS: Currency;	           //07	VL_BC_PIS	Valor da base de c�lculo do PIS/PASEP	N	-	02
    fALIQ_PIS: Currency;	           //08	ALIQ_PIS	Al�quota do PIS/PASEP (em percentual)	N	008	04
    fQUANT_BC_PIS: Currency;	       //09	QUANT_BC_PIS	Quantidade � Base de c�lculo PIS/PASEP	N	-	03
    fALIQ_PIS_QUANT: Currency;       //10	ALIQ_PIS_QUANT	Al�quota do PIS/PASEP (em reais)	N	-	04
    fVL_PIS: Currency;	             //11	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	               //12	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property CST_PIS: string  read FCST_PIS write FCST_PIS;
    property CFOP: Integer read FCFOP write FCFOP;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property QUANT_BC_PIS: Currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property ALIQ_PIS_QUANT: Currency read FALIQ_PIS_QUANT write FALIQ_PIS_QUANT;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO C195: DETALHAMENTO DA CONSOLIDA��O - OPERA��ES DE AQUISI��O COM DIREITO A CR�DITO, E OPERA��ES DE DEVOLU��O DE COMPRAS E VENDAS � COFINS
  TRegistroC195 = class
  private
    fCOD_PART: string;	                //02	COD_PART	C�digo do Participante (campo 02 do Registro 0150) do emitente dos documentos ou do remetente das mercadorias.	C	060	-
    fCST_COFINS: Integer;	              //03	CST_COFINS	C�digo da Situa��o Tribut�ria referente a COFINS.	N	002*	-
    fCFOP: Integer;	                    //04	CFOP	C�digo fiscal de opera��o e presta��o	N	004*	-
    fVL_ITEM: Currency;	                //05	VL_ITEM	Valor do item	N	-	02
    fVL_DESC: Currency;	                //06	VL_DESC	Valor do desconto comercial	N	-	02
    fVL_BC_COFINS: Currency;	          //07	VL_BC_COFINS	Valor da base de c�lculo da COFINS	N	-	02
    fALIQ_COFINS: Currency;	            //08	ALIQ_COFINS	Al�quota da COFINS (em percentual)	N	008	04
    fQUANT_BC_COFINS: Currency;	        //09	QUANT_BC_COFINS	Quantidade � Base de c�lculo da COFINS	N	-	03
    fALIQ_COFINS_QUANT: Currency;       //10	ALIQ_COFINS_QUANT	Al�quota da COFINS (em reais)	N	-	04
    fVL_COFINS: Currency;	              //11	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	                  //12	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property CFOP: Integer read FCFOP write FCFOP;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property QUANT_BC_COFINS: Currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property ALIQ_COFINS_QUANT: Currency read FALIQ_COFINS_QUANT write FALIQ_COFINS_QUANT;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO C198: PROCESSO REFERENCIADO
  TRegistroC198 = class
  private
    fNUM_PROC: string;              //02	NUM_PROC	Identifica��o do processo ou ato concess�rio	C	020	-
    fIND_PROC: Integer;             //03	IND_PROC	Indicador da origem do processo:1 - Justi�a Federal;3 � Secretaria da Receita Federal do Brasil;9 � Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO C199: COMPLEMENTO DO DOCUMENTO - OPERA��ES DE IMPORTA��O (C�DIGO 55)
  TRegistroC199 = class
  private
    fCOD_DOC_IMP: Integer;	           //02	COD_DOC_IMP	Documento de importa��o:0 � Declara��o de Importa��o;1 � Declara��o Simplificada de Importa��o.	C	001*	-
    fNUM_DOC__IMP: string;             //03	NUM_DOC__IMP	N�mero do documento de Importa��o.	C	010	-
    fVL_PIS_IMP: Currency;	           //04	VL_PIS_IMP	Valor pago de PIS na importa��o	N	-	02
    fVL_COFINS_IMP: Currency;          //05	VL_COFINS_IMP	Valor pago de COFINS na importa��o	N	-	02
    fNUM_ACDRAW: string;	             //06	NUM_ACDRAW	N�mero do Ato Concess�rio do regime Drawback 	C	011	-
  public
    property COD_DOC_IMP: Integer read FCOD_DOC_IMP write FCOD_DOC_IMP;
    property NUM_DOC__IMP: string read FNUM_DOC__IMP write FNUM_DOC__IMP;
    property VL_PIS_IMP: Currency read FVL_PIS_IMP write FVL_PIS_IMP;
    property VL_COFINS_IMP: Currency read FVL_COFINS_IMP write FVL_COFINS_IMP;
    property NUM_ACDRAW: string read FNUM_ACDRAW write FNUM_ACDRAW;
  end;

  //REGISTRO C381: DETALHAMENTO DA CONSOLIDA��O � PIS/PASEP
  TRegistroC381 = class
  private
    fCST_PIS: string;	               //02	CST_PIS	C�digo da Situa��o Tribut�ria referente ao PIS/PASEP	N	002*	-
    fCOD_ITEM: string;	             //03	COD_ITEM	C�digo do item (campo 02 do Registro 0200)	C	060	-
    fVL_ITEM: Currency;	             //04	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_PIS: Currency;	           //05	VL_BC_PIS	Valor da base de c�lculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;	           //06	ALIQ_PIS	Al�quota do PIS/PASEP (em percentual)	N	008	04
    fQUANT_BC_PIS: Currency;	       //07	QUANT_BC_PIS	Quantidade � Base de c�lculo do PIS/PASEP	N	 	03
    fALIQ_PIS_QUANT: Currency;       //08	ALIQ_PIS_QUANT	Al�quota do PIS/PASEP (em reais)	N	 -	04
    fVL_PIS: Currency;	             //09	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	               //10	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property CST_PIS: string read FCST_PIS write FCST_PIS;
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property QUANT_BC_PIS: Currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property ALIQ_PIS_QUANT: Currency read FALIQ_PIS_QUANT write FALIQ_PIS_QUANT;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO C385: DETALHAMENTO DA CONSOLIDA��O � COFINS
  TRegistroC385 = class
  private
    fCST_COFINS: string;	                //02	CST_COFINS	C�digo da Situa��o Tribut�ria referente a COFINS.	N	002*	-
    fCOD_ITEM: string;	                  //03	COD_ITEM	C�digo do item (campo 02 do Registro 0200)	C	060	-
    fVL_ITEM: Currency;	                  //04	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_COFINS: Currency;	            //05	VL_BC_COFINS	Valor da base de c�lculo da COFINS	N	 	02
    fALIQ_COFINS: Currency;	              //06	ALIQ_COFINS	Al�quota da COFINS (em percentual)	N	008	04
    fQUANT_BC_COFINS: Currency;	          //07	QUANT_BC_COFINS	Quantidade � Base de c�lculo da COFINS	N	 	03
    fALIQ_COFINS_QUANT: Currency;	        //08	ALIQ_COFINS_QUANT	Al�quota da COFINS (em reais)	N	 	04
    fVL_COFINS: Currency;	                //09	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	                    //10	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property CST_COFINS: string read FCST_COFINS write FCST_COFINS;
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property QUANT_BC_COFINS: Currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property ALIQ_COFINS_QUANT: Currency read FALIQ_COFINS_QUANT write FALIQ_COFINS_QUANT;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO C395: NOTAS FISCAIS DE VENDA A CONSUMIDOR (C�DIGOS 02, 2D, 2E e 59) � AQUISI��ES/ENTRADAS COM CR�DITO
  TRegistroC395 = class
  private
    fCOD_MOD: string;	             //02	COD_MOD	C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1 	C	002*	-
    fCOD_PART: string;             //03	COD_PART	C�digo do participante emitente do documento (campo 02 do Registro 0150).	C	060	-
    fSER: string;	                 //04	SER	S�rie do documento fiscal	C	003	-
    fSUB_SER: string;	             //05	SUB_SER	Subs�rie do documento fiscal	C	003	-
    fNUM_DOC: string;	             //06	NUM_DOC	N�mero do documento fiscal	C	006	-
    fDT_DOC: TDateTime;	           //07	DT_DOC	Data da emiss�o do documento fiscal	N	008*	-
    fVL_DOC: Currency;	           //08	VL_DOC	Valor total do documento fiscal	N	-	02
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property SER: string read FSER write FSER;
    property SUB_SER: string read FSUB_SER write FSUB_SER;
    property NUM_DOC: string read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
  end;

  //REGISTRO C396: ITENS DO DOCUMENTO (C�DIGOS 02, 2D, 2E e 59) � AQUISI��ES/ENTRADAS COM CR�DITO
  TRegistroC396 = class
  private
    fCOD_ITEM: string;	          //02	COD_ITEM	C�digo do item (campo 02 do Registro 0200)	C	060	-
    fVL_ITEM: Currency;	          //03	VL_ITEM	Valor total do item (mercadorias ou servi�os)	N	-	02
    fVL_DESC: Currency;	          //04	VL_DESC	Valor do desconto comercial do item	N	-	02
    fNAT_BC_CRED: string;	        //05	NAT_BC_CRED	C�digo da Base de C�lculo do Cr�dito, conforme a Tabela indicada no item 4.3.7.	C	002*	-
    fCST_PIS: string;	            //06	CST_PIS	C�digo da Situa��o Tribut�ria referente ao PIS/PASEP	N	002*	-
    fVL_BC_PIS: Currency;	        //07	VL_BC_PIS	Valor da base de c�lculo do cr�dito de PIS/PASEP	N	 	02
    fALIQ_PIS: Currency;	        //08	ALIQ_PIS	Al�quota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	          //09	VL_PIS	Valor do cr�dito de PIS/PASEP	N	-	02
    fCST_COFINS: Integer;	        //10	CST_COFINS	C�digo da Situa��o Tribut�ria referente a COFINS	N	002*	-
    fVL_BC_COFINS: Currency;      //11	VL_BC_COFINS	Valor da base de c�lculo do cr�dito de COFINS	N	 	02
    fALIQ_COFINS: Currency;	      //12	ALIQ_COFINS	Al�quota da COFINS (em percentual)	N	008	04
    fVL_COFINS: Currency;	        //13	VL_COFINS	Valor do cr�dito de COFINS	N	-	02
    fCOD_CTA: string;	            //14	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property CST_PIS: string read FCST_PIS write FCST_PIS;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO C400: EQUIPAMENTO ECF (C�DIGOS 02 e 2D)
  TRegistroC400 = class
  private
    fCOD_MOD: string;          //02	COD_MOD	C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1	C	002*	-
    fECF_MOD: string;          //03	ECF_MOD	Modelo do equipamento	C	020	-
    fECF_FAB: string;          //04	ECF_FAB	N�mero de s�rie de fabrica��o do ECF	C	020	-
    fECF_CX: Integer;          //05	ECF_CX	N�mero do caixa atribu�do ao ECF	N	003	-
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property ECF_MOD: string read FECF_MOD write FECF_MOD;
    property ECF_FAB: string read FECF_FAB write FECF_FAB;
    property ECF_CX: Integer read FECF_CX write FECF_CX;
  end;

  //REGISTRO C405: REDU��O Z (C�DIGOS 02 e 2D)
  TRegistroC405 = class
  private
    fDT_DOC: TDateTime;	           //02	DT_DOC	Data do movimento a que se refere a Redu��o Z	N	008*	-
    fCRO: Integer;	               //03	CRO	Posi��o do Contador de Rein�cio de Opera��o	N	003	-
    fCRZ: Integer;	               //04	CRZ	Posi��o do Contador de Redu��o Z	N	006	-
    fNUM_COO_FIN: Integer;         //05	NUM_COO_FIN	N�mero do Contador de Ordem de Opera��o do �ltimo documento emitido no dia (N�mero do COO na Redu��o Z)	N	006	-
    fGT_FIN: Currency;	           //06	GT_FIN	Valor do Grande Total final	N	-	02
    fVL_BRT: Currency;	           //07	VL_BRT	Valor da venda bruta	N	-	02
  public
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property CRO: Integer read FCRO write FCRO;
    property CRZ: Integer read FCRZ write FCRZ;
    property NUM_COO_FIN: Integer read FNUM_COO_FIN write FNUM_COO_FIN;
    property GT_FIN: Currency read FGT_FIN write FGT_FIN;
    property VL_BRT: Currency read FVL_BRT write FVL_BRT;
  end;

  //REGISTRO C481: RESUMO DI�RIO DE DOCUMENTOS EMITIDOS POR ECF � PIS/PASEP (C�DIGOS 02 e 2D)
  TRegistroC481 = class
  private
    fCST_PIS: Integer;	             //02	CST_PIS	C�digo da Situa��o Tribut�ria referente ao PIS/PASEP	N	002*	-
    fVL_ITEM: Currency;	             //03	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_PIS: Currency;	           //04	VL_BC_PIS	Valor da base de c�lculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;	           //05	ALIQ_PIS	Al�quota do PIS/PASEP (em percentual)	N	008	04
    fQUANT_BC_PIS: Currency;	       //06	QUANT_BC_PIS	Quantidade � Base de c�lculo PIS/PASEP	N	 -	03
    fALIQ_PIS_QUANT: Currency;       //07	ALIQ_PIS_QUANT	Al�quota do PIS/PASEP (em reais)	N	 -	04
    fVL_PIS: Currency;	             //08	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_ITEM: string;	             //09	COD_ITEM	C�digo do item (campo 02 do Registro 0200)	C	060	-
    fCOD_CTA: string;	               //10	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property QUANT_BC_PIS: Currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property ALIQ_PIS_QUANT: Currency read FALIQ_PIS_QUANT write FALIQ_PIS_QUANT;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO C485: RESUMO DI�RIO DE DOCUMENTOS EMITIDOS POR ECF � COFINS (C�DIGOS 02 e 2D)
  TRegistroC485 = class
  private
    fCST_COFINS: Integer;	              //02	CST_COFINS	C�digo da Situa��o Tribut�ria referente a COFINS.	N	002*	-
    fVL_ITEM: Currency;	                //03	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_COFINS: Currency;	          //04	VL_BC_COFINS	Valor da base de c�lculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	            //05	ALIQ_COFINS	Al�quota da COFINS (em percentual)	N	008	04
    fQUANT_BC_COFINS: Currency;	        //06	QUANT_BC_COFINS	Quantidade � Base de c�lculo da COFINS	N	 -	03
    fALIQ_COFINS_QUANT: Currency;       //07	ALIQ_COFINS_QUANT	Al�quota da COFINS (em reais)	N	 -	04
    fVL_COFINS: Currency;	              //08	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_ITEM: string;	                //09	COD_ITEM	C�digo do item (campo 02 do Registro 0200)	C	060	-
    fCOD_CTA: string;	                  //10	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property QUANT_BC_COFINS: Currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property ALIQ_COFINS_QUANT: Currency read FALIQ_COFINS_QUANT write FALIQ_COFINS_QUANT;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO C489: PROCESSO REFERENCIADO
  TRegistroC489 = class
  private
    fNUM_PROC: string;           //02	NUM_PROC	Identifica��o do processo ou ato concess�rio	C	020	-
    fIND_PROC: Integer;          //03	IND_PROC	Indicador da origem do processo:1 - Justi�a Federal;3 � Secretaria da Receita Federal do Brasil;9 - Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO C490: CONSOLIDA��O DE DOCUMENTOS EMITIDOS POR ECF (C�DIGOS 02, 2D e 59)
  TRegistroC490 = class
  private
    fDT_DOC_INI: TDateTime;     //02	DT_DOC_INI	Data de Emiss�o Inicial dos Documentos	N	008*	-
    fDT_DOC_FIN: TDateTime;     //03	DT_DOC_FIN	Data de Emiss�o Final dos Documentos	N	008*	-
    fCOD_MOD: string;	          //04	COD_MOD	C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1	C	002*	-
  public
    property DT_DOC_INI: TDateTime read FDT_DOC_INI write FDT_DOC_INI;
    property DT_DOC_FIN: TDateTime read FDT_DOC_FIN write FDT_DOC_FIN;
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
  end;

  //REGISTRO C491: DETALHAMENTO DA CONSOLIDA��O DE DOCUMENTOS EMITIDOS POR ECF (C�DIGOS 02, 2D e 59) � PIS/PASEP
  TRegistroC491 = class
  private
    fCOD_ITEM: string;	             //02	COD_ITEM	C�digo do item (campo 02 do Registro 0200)	C	060	-
    fCST_PIS: Integer;	             //03	CST_PIS	C�digo da Situa��o Tribut�ria referente ao PIS/PASEP	N	002*	-
    fCFOP: Integer;	                 //04	CFOP	C�digo fiscal de opera��o e presta��o	N	004*	-
    fVL_ITEM: Currency;	             //05	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_PIS: Currency;	           //06	VL_BC_PIS	Valor da base de c�lculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;	           //07	ALIQ_PIS	Al�quota do PIS/PASEP (em percentual)	N	008	04
    fQUANT_BC_PIS: Currency;	       //08	QUANT_BC_PIS	Quantidade � Base de c�lculo PIS/PASEP	N	 -	03
    fALIQ_PIS_QUANT: Currency;       //09	ALIQ_PIS_QUANT	Al�quota do PIS/PASEP (em reais)	N	 -	04
    fVL_PIS: Currency;	             //10	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	               //11	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property CFOP: Integer read FCFOP write FCFOP;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property QUANT_BC_PIS: Currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property ALIQ_PIS_QUANT: Currency read FALIQ_PIS_QUANT write FALIQ_PIS_QUANT;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO C495: DETALHAMENTO DA CONSOLIDA��O DE DOCUMENTOS EMITIDOS POR ECF (C�DIGOS 02, 2D e 59) � COFINS
  TRegistroC495 = class
  private
    fCOD_ITEM: string;	              //02	COD_ITEM	C�digo do item (campo 02 do Registro 0200)	C	060	-
    fCST_COFINS: Integer;	            //03	CST_COFINS	C�digo da Situa��o Tribut�ria referente a COFINS.	N	002*	-
    fCFOP: Integer;	                  //04	CFOP	C�digo fiscal de opera��o e presta��o	N	004*	-
    fVL_ITEM: Currency;	              //05	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_COFINS: Currency;	        //06	VL_BC_COFINS	Valor da base de c�lculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	          //07	ALIQ_COFINS	Al�quota da COFINS (em percentual)	N	008	04
    fQUANT_BC_COFINS: Currency;	      //08	QUANT_BC_COFINS	Quantidade � Base de c�lculo da COFINS	N	 -	03
    fALIQ_COFINS_QUANT: Currency;     //09	ALIQ_COFINS_QUANT	Al�quota da COFINS (em reais)	N	 -	04
    fVL_COFINS:  Currency;	          //10	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	                //11	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property CFOP: Integer read FCFOP write FCFOP;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property QUANT_BC_COFINS: Currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property ALIQ_COFINS_QUANT: Currency read FALIQ_COFINS_QUANT write FALIQ_COFINS_QUANT;
    property VL_COFINS:  Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO C499: PROCESSO REFERENCIADO
  TRegistroC499 = class
  private
    fNUM_PROC: string;            //02	NUM_PROC	Identifica��o do processo ou ato concess�rio	C	020	-
    fIND_PROC: Integer;           //03	IND_PROC	Indicador da origem do processo:1 - Justi�a Federal;3 � Secretaria da Receita Federal do Brasil;9 - Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO C500: NOTA FISCAL/CONTA DE ENERGIA EL�TRICA (C�DIGO 06), NOTA FISCAL/CONTA DE FORNECIMENTO D'�GUA CANALIZADA (C�DIGO 29) E NOTA FISCAL CONSUMO FORNECIMENTO DE G�S (C�DIGO 28) � DOCUMENTOS DE ENTRADA/AQUISI��O COM CR�DITO
  TRegistroC500 = class
  private
    fCOD_PART: string;	              //02	COD_PART	C�digo do participante do fornecedor (campo 02 do Registro 0150). 	C	060	-
    fCOD_MOD: string;	                //03	COD_MOD	C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1 	C	002*	-
    fCOD_SIT: Integer;	              //04	COD_SIT	C�digo da situa��o do documento fiscal, conforme a Tabela 4.1.2 	N	002*	-
    fSER: string;	                    //05	SER	S�rie do documento fiscal	C	004	-
    fSUB: Integer;	                  //06	SUB	Subs�rie do documento fiscal	N	003	-
    fNUM_DOC: Integer;	              //07	NUM_DOC	N�mero do documento fiscal	N	009	-
    fDT_DOC: TDateTime;	              //08	DT_DOC	Data da emiss�o do documento fiscal	N	008*	-
    fDT_ENT: TDateTime;	              //09	DT_ENT	Data da entrada	N	008*	-
    fVL_DOC: Currency;	              //10	VL_DOC	Valor total do documento fiscal	N	-	02
    fVL_ICMS: Currency;	              //11	VL_ICMS	Valor acumulado do ICMS	N	-	02
    fCOD_INF: string;	                //12	COD_INF	C�digo da informa��o complementar do documento fiscal (campo 02 do Registro 0450)	C	006	-
    fVL_PIS: Currency;	              //13	VL_PIS	Valor do PIS/PASEP	N	-	02
    fVL_COFINS: Currency;	            //14	VL_COFINS	Valor da COFINS	N	-	02
  public
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_SIT: Integer read FCOD_SIT write FCOD_SIT;
    property SER: string read FSER write FSER;
    property SUB: Integer read FSUB write FSUB;
    property NUM_DOC: Integer read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property DT_ENT: TDateTime read FDT_ENT write FDT_ENT;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
    property VL_ICMS: Currency read FVL_ICMS write FVL_ICMS;
    property COD_INF: string read FCOD_INF write FCOD_INF;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
  end;

  //REGISTRO C501: COMPLEMENTO DA OPERA��O (C�DIGOS 06, 28 e 29) � PIS/PASEP
  TRegistroC501 = class
  private
    fCST_PIS: Integer;	        //02	CST_PIS	C�digo da Situa��o Tribut�ria referente ao PIS/PASEP	N	002*	-
    fVL_ITEM: Currency;	        //03	VL_ITEM	Valor total dos itens	N	-	02
    fNAT_BC_CRED: string;	      //04	NAT_BC_CRED	C�digo da Base de C�lculo do Cr�dito, conforme a Tabela indicada no item 4.3.7.	C	002*	-
    fVL_BC_PIS: Currency;	      //05	VL_BC_PIS	Valor da base de c�lculo do PIS/PASEP	N	- 	02
    fALIQ_PIS: Currency;	      //06	ALIQ_PIS	Al�quota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	        //07	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	          //08	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO C505: COMPLEMENTO DA OPERA��O (C�DIGOS 06, 28 e 29) � COFINS
  TRegistroC505 = class
  private
    fCST_COFINS: Integer;	         //02	CST_COFINS	C�digo da Situa��o Tribut�ria referente a COFINS	N	002*	-
    fVL_ITEM: Currency;	           //03	VL_ITEM	Valor total dos itens	N	-	02
    fNAT_BC_CRED: string;	         //04	NAT_BC_CRED	C�digo da Base de C�lculo do Cr�dito, conforme a Tabela indicada no item 4.3.7 	C	002*	-
    fVL_BC_COFINS: Currency;       //05	VL_BC_COFINS	Valor da base de c�lculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	       //06	ALIQ_COFINS	Al�quota da COFINS  (em percentual)	N	008	04
    fVL_COFINS: Currency;	         //07	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	             //08	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO C509: PROCESSO REFERENCIADO
  TRegistroC509 = class
  private
    fNUM_PROC: string;         //02	NUM_PROC	Identifica��o do processo ou ato concess�rio	C	020	-
    fIND_PROC: string;         //03	IND_PROC	Indicador da origem do processo:1 - Justi�a Federal;3 � Secretaria da Receita Federal do Brasil;9 � Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: string read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO C600: CONSOLIDA��O DI�RIA DE NOTAS FISCAIS/CONTAS EMITIDAS DE ENERGIA EL�TRICA (C�DIGO 06), NOTA FISCAL/CONTA DE FORNECIMENTO D'�GUA CANALIZADA (C�DIGO 29) E NOTA FISCAL/CONTA DE FORNECIMENTO DE G�S (C�DIGO 28) (EMPRESAS OBRIGADAS OU N�O OBRIGADAS AO CONVENIO ICMS 115/03) � DOCUMENTOS DE SA�DA
  TRegistroC600 = class
  private
    fCOD_MOD: string;	                   //02	COD_MOD	C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1 	C	002*	-
    fCOD_MUN: Integer;	                 //03	COD_MUN	C�digo do munic�pio dos pontos de consumo, conforme a tabela IBGE	N	007*	-
    fSER: string;	                       //04	SER	S�rie do documento fiscal	C	004	-
    fSUB: Integer;	                     //05	SUB	Subs�rie do documento fiscal	N	003	-
    fCOD_CONS: Integer;	                 //06	COD_CONS	C�digo de classe de consumo de energia el�trica, conforme a Tabela 4.4.5, ou C�digo de Consumo de Fornecimento D��gua � Tabela 4.4.2 ou C�digo da classe de consumo de g�s canalizado   conforme Tabela 4.4.3.	N	002*	-
    fQTD_CONS: Integer;	                 //07	QTD_CONS	Quantidade de documentos consolidados neste registro	N	-	-
    fQTD_CANC: Integer;	                 //08	QTD_CANC	Quantidade de documentos cancelados	N	-	-
    fDT_DOC: TDateTime;	                 //09	DT_DOC	Data dos documentos consolidados	N	008*	-
    fVL_DOC: Currency;	                 //10	VL_DOC	Valor total dos documentos	N	-	02
    fVL_DESC: Currency;	                 //11	VL_DESC	Valor acumulado dos descontos	N	-	02
    fCONS: Integer;	                     //12	CONS	Consumo total acumulado, em kWh (C�digo 06)	N	-	-
    fVL_FORN: Currency;	                 //13	VL_FORN	Valor acumulado do fornecimento	N	-	02
    fVL_SERV_NT: Currency;	             //14	VL_SERV_NT	Valor acumulado dos servi�os n�o-tributados pelo ICMS	N	-	02
    fVL_TERC: Currency;	                 //15	VL_TERC	Valores cobrados em nome de terceiros	N	-	02
    fVL_DA: Currency;	                   //16	VL_DA	Valor acumulado das despesas acess�rias	N	-	02
    fVL_BC_ICMS: Currency;	             //17	VL_BC_ICMS	Valor acumulado da base de c�lculo do ICMS	N	-	02
    fVL_ICMS: Currency;	                 //18	VL_ICMS	Valor acumulado do ICMS	N	-	02
    fVL_BC_ICMS_ST: Currency;            //19	VL_BC_ICMS_ST	Valor acumulado da base de c�lculo do ICMS substitui��o tribut�ria	N	-	02
    fVL_ICMS_ST: Currency;	             //20	VL_ICMS_ST	Valor acumulado do ICMS retido por substitui��o tribut�ria	N	-	02
    fVL_PIS: Currency;	                 //21	VL_PIS	Valor acumulado do PIS/PASEP	N	-	02
    fVL_COFINS: Currency;	               //22	VL_COFINS	Valor acumulado da COFINS	N	-	02
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_MUN: Integer read FCOD_MUN write FCOD_MUN;
    property SER: string read FSER write FSER;
    property SUB: Integer read FSUB write FSUB;
    property COD_CONS: Integer read FCOD_CONS write FCOD_CONS;
    property QTD_CONS: Integer read FQTD_CONS write FQTD_CONS;
    property QTD_CANC: Integer read FQTD_CANC write FQTD_CANC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property CONS: Integer read FCONS write FCONS;
    property VL_FORN: Currency read FVL_FORN write FVL_FORN;
    property VL_SERV_NT: Currency read FVL_SERV_NT write FVL_SERV_NT;
    property VL_TERC: Currency read FVL_TERC write FVL_TERC;
    property VL_DA: Currency read FVL_DA write FVL_DA;
    property VL_BC_ICMS: Currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: Currency read FVL_ICMS write FVL_ICMS;
    property VL_BC_ICMS_ST: Currency read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    property VL_ICMS_ST: Currency read FVL_ICMS_ST write FVL_ICMS_ST;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
  end;

  //REGISTRO C601: COMPLEMENTO DA CONSOLIDA��O DI�RIA (C�DIGOS 06, 28 e 29) � DOCUMENTOS DE SA�DAS - PIS/PASEP
  TRegistroC601 = class
  private
    fCST_PIS: Integer;	        //02	CST_PIS	C�digo da Situa��o Tribut�ria referente ao PIS/PASEP	N	002*	-
    fVL_ITEM: Currency;	        //03	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_PIS: Currency;       //04	VL_BC_PIS	Valor da base de c�lculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;        //05	ALIQ_PIS	Al�quota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	        //06	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	          //07	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO C605: COMPLEMENTO DA CONSOLIDA��O DI�RIA (C�DIGOS 06, 28 e 29) � DOCUMENTOS DE SA�DAS - COFINS
  TRegistroC605 = class
  private
    fCST_COFINS: Integer;	        //02	CST_COFINS	C�digo da Situa��o Tribut�ria referente a COFINS	N	002*	-
    fVL_ITEM: Currency;	          //03	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_COFINS: Currency;      //04	VL_BC_COFINS	Valor da base de c�lculo da COFINS	N	 	02
    fALIQ_COFINS: Currency;	      //05	ALIQ_COFINS	Al�quota da COFINS (em percentual)	N	008	04
    fVL_COFINS: Currency;	        //06	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	            //07	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO C609: PROCESSO REFERENCIADO
  TRegistroC609 = class
  private
    fNUM_PROC: string;          //02	NUM_PROC	Identifica��o do processo ou ato concess�rio	C	020	-
    fIND_PROC: Integer;         //03	IND_PROC	Indicador da origem do processo:1 - Justi�a Federal;3 � Secretaria da Receita Federal do Brasil;9 � Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO C990: ENCERRAMENTO DO BLOCO C
  TRegistroC990 = class
  private
    fQTD_LIN_C: Integer;      //02	QTD_LIN_C	Quantidade total de linhas do Bloco C	N	-	-
  public
    property QTD_LIN_C: Integer read FQTD_LIN_C write FQTD_LIN_C;
  end;

implementation

end.
