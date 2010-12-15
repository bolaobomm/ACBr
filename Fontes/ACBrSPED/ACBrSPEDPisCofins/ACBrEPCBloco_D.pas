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

unit ACBrEPCBloco_D;

interface

uses
  SysUtils, Classes, Contnrs, DateUtils;

type
  //REGISTRO D001: ABERTURA DO BLOCO D
  TRegistroD001 = class(TOpenBlocos)
  private
  public
  end;

  //REGISTRO D010: IDENTIFICA��O DO ESTABELECIMENTO
  TRegistroD010 = class
  private
    fCNPJ: Integer;        //02	CNPJ	N�mero de inscri��o do estabelecimento no CNPJ.	N	014*	-
  public
    property CNPJ: Integer read FCNPJ write FCNPJ;
  end;

  //REGISTRO D100: AQUISI��O DE SERVI�OS DE TRANSPORTE - NOTA FISCAL DE SERVI�O DE TRANSPORTE (C�DIGO 07) E CONHECIMENTOS DE TRANSPORTE RODOVI�RIO DE CARGAS (C�DIGO 08), CONHECIMENTO DE TRANSPORTE DE CARGAS AVULSO (C�DIGO 8B), AQUAVI�RIO DE CARGAS (C�DIGO 09), A�REO (C�DIGO 10), FERROVI�RIO DE CARGAS (C�DIGO 11), MULTIMODAL DE CARGAS (C�DIGO 26), NOTA FISCAL DE TRANSPORTE FERROVI�RIO DE CARGA (C�DIGO 27) E CONHECIMENTO DE TRANSPORTE ELETR�NICO � CT-e (C�DIGO 57)
  TRegistroD100 = class
  private
    fIND_OPER: string;	         //02	IND_OPER	Indicador do tipo de opera��o:0- Aquisi��o;	C	001*	-
    fIND_EMIT: string;	         //03	IND_EMIT	Indicador do emitente do documento fiscal:0- Emiss�o Pr�pria;1- Emiss�o por Terceiros	C	001*	-
    fCOD_PART: string;	         //04	COD_PART	C�digo do participante (campo 02 do Registro 0150).	C	060	-
    fCOD_MOD: string;	           //05	COD_MOD	C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1 	C	002*	-
    fCOD_SIT: Integer;	         //06	COD_SIT	C�digo da situa��o do documento fiscal, conforme a Tabela 4.1.2	N	002*	-
    fSER: string;	               //07	SER	S�rie do documento fiscal	C	004	-
    fSUB: string;	               //08	SUB	Subs�rie do documento fiscal	C	003	-
    fNUM_DOC: Integer;	         //09	NUM_DOC	N�mero do documento fiscal	N	009	-
    fCHV_CTE: Integer;	         //10	CHV_CTE	Chave do Conhecimento de Transporte Eletr�nico	N	044*	-
    fDT_DOC: TDateTime;	         //11	DT_DOC	Data de refer�ncia/emiss�o dos documentos fiscais	N	008*	-
    fDT_A_P: TDateTime;	         //12	DT_A_P	Data da aquisi��o ou da presta��o do servi�o	N	008*	-
    fTP_CT_e: Integer;	         //13	TP_CT-e	Tipo de Conhecimento de Transporte Eletr�nico conforme definido no Manual de Integra��o do CT-e	N	001*	-
    fCHV_CTE_REF: Integer;	     //14	CHV_CTE_REF	Chave do CT-e de refer�ncia cujos valores foram complementados (op��o �1� do campo anterior) ou cujo d�bito foi anulado (op��o �2� do campo anterior). 	N	044*	-
    fVL_DOC: Currency;	         //15	VL_DOC	Valor total do documento fiscal	N	-	02
    fVL_DESC: Currency;	         //16	VL_DESC	Valor total do desconto	N	-	02
    fIND_FRT: Integer;	         //17	IND_FRT	Indicador do tipo do frete:0- Por conta de terceiros;1- Por conta do emitente;2- Por conta do destinat�rio;9- Sem cobran�a de frete.	C	001*	-
    fVL_SERV: Currency;	         //18	VL_SERV	Valor total da presta��o de servi�o	N	-	02
    fVL_BC_ICMS: Currency;	     //19	VL_BC_ICMS	Valor da base de c�lculo do ICMS	N	-	02
    fVL_ICMS: Currency;	         //20	VL_ICMS	Valor do ICMS	N	-	02
    fVL_NT: Currency;	           //21	VL_NT	Valor n�o-tributado do ICMS	N	-	02
    fCOD_INF: string;	           //22	COD_INF	C�digo da informa��o complementar do documento fiscal (campo 02 do Registro 0450)	C	006	-
    fCOD_CTA: string;	           //23	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property IND_OPER: string read FIND_OPER write FIND_OPER;
    property IND_EMIT: string read FIND_EMIT write FIND_EMIT;
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_SIT: Integer read FCOD_SIT write FCOD_SIT;
    property SER: string read FSER write FSER;
    property SUB: string read FSUB write FSUB;
    property NUM_DOC: Integer read FNUM_DOC write FNUM_DOC;
    property CHV_CTE: Integer read FCHV_CTE write FCHV_CTE;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property DT_A_P: TDateTime read FDT_A_P write FDT_A_P;
    property TP_CT_e: Integer read FTP_CT_e write FTP_CT_e;
    property CHV_CTE_REF: Integer read FCHV_CTE_REF write FCHV_CTE_REF;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property IND_FRT: Integer read FIND_FRT write FIND_FRT;
    property VL_SERV: Currency read FVL_SERV write FVL_SERV;
    property VL_BC_ICMS: Currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: Currency read FVL_ICMS write FVL_ICMS;
    property VL_NT: Currency read FVL_NT write FVL_NT;
    property COD_INF: string read FCOD_INF write FCOD_INF;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D101: COMPLEMENTO DO DOCUMENTO DE TRANSPORTE (C�digos 07, 08, 8B, 09, 10, 11, 26, 27 e 57) � PIS/PASEP
  TRegistroD101 = class
  private
    fIND_NAT_FRT: Integer;	        //02	IND_NAT_FRT	Indicador da Natureza do Frete Contratado, referente a:0 � Opera��es de vendas, com �nus suportado pelo estabelecimento vendedor;1 � Opera��es de vendas, com �nus suportado pelo adquirente;2 � Opera��es de compras (bens para revenda, mat�rias-prima e outros produtos, geradores de cr�dito);3 � Opera��es de compras (bens para revenda, mat�rias-prima e outros produtos, n�o geradores de cr�dito);4 � Transfer�ncia de produtos acabados entre estabelecimentos da pessoa jur�dica;5 � Transfer�ncia de produtos em elabora��o entre estabelecimentos da pessoa jur�dica;9 � Outras.	C	001*	-
    fVL_ITEM: Currency;	            //03	VL_ITEM	Valor total dos itens	N	-	02
    fCST_PIS: Integer;	            //04	CST_PIS	C�digo da Situa��o Tribut�ria referente ao PIS/PASEP	N	002*	-
    fNAT_BC_CRED: string;	          //05	NAT_BC_CRED	C�digo da Base de C�lculo do Cr�dito, conforme a Tabela indicada no item 4.3.7.	C	002*	-
    fVL_BC_PIS: Currency;	          //06	VL_BC_PIS	Valor da base de c�lculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;	          //07	ALIQ_PIS	Al�quota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	            //08	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	              //09	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property IND_NAT_FRT: Integer read FIND_NAT_FRT write FIND_NAT_FRT;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D105: COMPLEMENTO DO DOCUMENTO DE TRANSPORTE (C�digos 07, 08, 8B, 09, 10, 11, 26, 27 e 57) � COFINS
  TRegistroD105 = class
  private
    fIND_NAT_FRT: Integer;	          //02	IND_NAT_FRT	Indicador da Natureza do Frete Contratado, referente a:0 � Opera��es de vendas, com �nus suportado pelo estabelecimento vendedor;1 � Opera��es de vendas, com �nus suportado pelo adquirente;2 � Opera��es de compras (bens para revenda, mat�rias-prima e outros produtos, geradores de cr�dito);3 � Opera��es de compras (bens para revenda, mat�rias-prima e outros produtos, n�o geradores de cr�dito);4 � Transfer�ncia de produtos acabados entre estabelecimentos da pessoa jur�dica;5 � Transfer�ncia de produtos em elabora��o entre estabelecimentos da pessoa jur�dica;9 � Outras.	C	001*	-
    fVL_ITEM: Currency;	              //03	VL_ITEM	Valor total dos itens	N	-	02
    fCST_COFINS: Integer;	            //04	CST_COFINS	C�digo da Situa��o Tribut�ria referente a COFINS	N	002*	-
    fNAT_BC_CRED: string;	            //05	NAT_BC_CRED	C�digo da base de C�lculo do Cr�dito, conforme a Tabela indicada no item 4.3.7 	C	002*	-
    fVL_BC_COFINS: Currency;          //06	VL_BC_COFINS	Valor da base de c�lculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	          //07	ALIQ_COFINS	Al�quota da COFINS (em percentual)	N	008	04
    fVL_COFINS: Currency;	            //08	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	                //09	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property IND_NAT_FRT: Integer read FIND_NAT_FRT write FIND_NAT_FRT;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D111: PROCESSO REFERENCIADO
  TRegistroD111 = class
  private
    fNUM_PROC: string;        //02	NUM_PROC	Identifica��o do processo ou ato concess�rio	C	020	-
    fIND_PROC: Integer;       //03	IND_PROC	Indicador da origem do processo:1 - Justi�a Federal;3 � Secretaria da Receita Federal do Brasil;9 � Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO D200: RESUMO DA ESCRITURA��O DI�RIA � PRESTA��O DE SERVI�OS DE TRANSPORTE - NOTA FISCAL DE SERVI�O DE TRANSPORTE (C�DIGO 07) E CONHECIMENTOS DE TRANSPORTE RODOVI�RIO DE CARGAS (C�DIGO 08), CONHECIMENTO DE TRANSPORTE DE CARGAS AVULSO (C�DIGO 8B), AQUAVI�RIO DE CARGAS (C�DIGO 09), A�REO (C�DIGO 10), FERROVI�RIO DE CARGAS (C�DIGO 11), MULTIMODAL DE CARGAS (C�DIGO 26), NOTA FISCAL DE TRANSPORTE FERROVI�RIO DE CARGA (C�DIGO 27) E CONHECIMENTO DE TRANSPORTE ELETR�NICO � CT-e (C�DIGO 57)
  TRegistroD200 = class
  private
    fCOD_MOD: string;	           //02	COD_MOD	C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1 	C	002*	-
    fCOD_SIT: Integer;	         //03	COD_SIT	C�digo da situa��o do documento fiscal, conforme a Tabela 4.1.2	N	002*	-
    fSER: string;	               //04	SER	S�rie do documento fiscal	C	004	-
    fSUB: string;	               //05	SUB	Subs�rie do documento fiscal	C	003	-
    fNUM_DOC_INI: Integer;       //06	NUM_DOC_INI	N�mero do documento fiscal inicial emitido no per�odo (mesmo modelo, s�rie e subs�rie).	N	009	-
    fNUM_DOC_FIN: Integer;       //07	NUM_DOC_FIN	N�mero do documento fiscal final emitido no per�odo (mesmo modelo, s�rie e subs�rie).	N	009	-
    fCFOP: Integer;	             //08	CFOP	C�digo Fiscal de Opera��o e Presta��o conforme tabela indicada no item 4.2.2	N	004*	-
    fDT_REF: TDateTime;	         //09	DT_REF	Data do dia de refer�ncia do resumo di�rio	N	008*	-
    fVL_DOC: Currency;	         //10	VL_DOC	Valor total dos documentos fiscais	N	-	02
    fVL_DESC: Currency;	         //11	VL_DESC	Valor total dos descontos	N	-	02
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_SIT: Integer read FCOD_SIT write FCOD_SIT;
    property SER: string read FSER write FSER;
    property SUB: string read FSUB write FSUB;
    property NUM_DOC_INI: Integer read FNUM_DOC_INI write FNUM_DOC_INI;
    property NUM_DOC_FIN: Integer read FNUM_DOC_FIN write FNUM_DOC_FIN;
    property CFOP: Integer read FCFOP write FCFOP;
    property DT_REF: TDateTime read FDT_REF write FDT_REF;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
  end;

  //REGISTRO D201: TOTALIZA��O DO RESUMO DI�RIO � PIS/PASEP
  TRegistroD201 = class
  private
    fCST_PIS: Integer;	             //02	CST_PIS	C�digo da Situa��o Tribut�ria referente ao PIS/PASEP	N	002*	-
    fVL_ITEM: Currency;	             //03	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_PIS: Currency;            //04	VL_BC_PIS	Valor da base de c�lculo do PIS/PASEP	N	-	02
    fALIQ_PIS: Currency;             //05	ALIQ_PIS	Al�quota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	             //06	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	               //07	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_ITEM: Currency  read FVL_ITEM write FVL_ITEM;
    property VL_BC_PIS: Currency  read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency  read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency  read FVL_PIS write FVL_PIS;
    property COD_CTA: string  read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D205: TOTALIZA��O DO RESUMO DI�RIO � COFINS
  TRegistroD205 = class
  private
    fCST_COFINS: string;	             //02	CST_COFINS	C�digo da Situa��o Tribut�ria referente a COFINS.	N	002*	-
    fVL_ITEM: Currency;	               //03	VL_ITEM	Valor total dos itens	N	-	02
    fVL_BC_COFINS: Currency;           //04	VL_BC_COFINS	Valor da base de c�lculo da COFINS	N	-	02
    fALIQ_COFINS: Currency;	           //05	ALIQ_COFINS	Al�quota da COFINS (em percentual)	N	008	04
    fVL_COFINS: Currency;	             //06	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	                 //07	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property CST_COFINS: string read FCST_COFINS write FCST_COFINS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D209: PROCESSO REFERENCIADO
  TRegistroD209 = class
  private
    fNUM_PROC: string;            //02	NUM_PROC	Identifica��o do processo ou ato concess�rio	C	020	-
    fIND_PROC: Integer;           //03	IND_PROC	Indicador da origem do processo:1 - Justi�a Federal;3 � Secretaria da Receita Federal do Brasil;9 � Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO D300: RESUMO DA ESCRITURA��O DI�RIA - BILHETES CONSOLIDADOS DE PASSAGEM RODOVI�RIO (C�DIGO 13), DE PASSAGEM AQUAVI�RIO (C�DIGO 14), DE PASSAGEM E NOTA DE BAGAGEM (C�DIGO 15) E DE PASSAGEM FERROVI�RIO (C�DIGO 16)
  TRegistroD300 = class
  private
    fCOD_MOD: string;	            //02	COD_MOD	C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1.	C	002*	-
    fSER: string;	                //03	SER	S�rie do documento fiscal	C	004	-
    fSUB: Integer;	              //04	SUB	Subs�rie do documento fiscal	N	003	-
    fNUM_DOC_INI: Integer;	      //05	NUM_DOC_INI	N�mero do primeiro documento fiscal emitido no per�odo (mesmo modelo, s�rie e subs�rie)	N	006	-
    fNUM_DOC_FIN: Integer;	      //06	NUM_DOC_FIN	N�mero do �ltimo documento fiscal emitido no per�odo (mesmo modelo, s�rie e subs�rie)	N	006	-
    fCFOP: Integer;	              //07	CFOP	C�digo Fiscal de Opera��o e Presta��o conforme tabela indicada no item 4.2.2	N	004*	-
    fDT_REF: TDateTime;	          //08	DT_REF	Data do dia de refer�ncia do resumo di�rio	N	008*	-
    fVL_DOC: Currency;	          //09	VL_DOC	Valor total dos documentos fiscais emitidos	N	-	02
    fVL_DESC: Currency;	          //10	VL_DESC	Valor total dos descontos	N	-	02
    fCST_PIS: Integer;	          //11	CST_PIS	C�digo da Situa��o Tribut�ria referente ao PIS/PASEP	N	002*	-
    fVL_BC_PIS: Currency;	        //12	VL_BC_PIS	Valor da base de c�lculo do PIS/PASEP	N	-	02
    fALIQ_PIS: Currency;	        //13	ALIQ_PIS	Al�quota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	          //14	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCST_COFINS: Integer;	        //15	CST_COFINS	C�digo da Situa��o Tribut�ria referente a COFINS	N	002*	-
    fVL_BC_COFINS: Currency;      //16	VL_BC_COFINS	Valor da base de c�lculo da COFINS	N	-	02
    fALIQ_COFINS: Currency;	      //17	ALIQ_COFINS	Al�quota da COFINS (em percentual)	N	008	04
    fVL_COFINS: Currency;	        //18	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	            //19	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property SER: string read FSER write FSER;
    property SUB: Integer read FSUB write FSUB;
    property NUM_DOC_INI: Integer read FNUM_DOC_INI write FNUM_DOC_INI;
    property NUM_DOC_FIN: Integer read FNUM_DOC_FIN write FNUM_DOC_FIN;
    property CFOP: Integer read FCFOP write FCFOP;
    property DT_REF: TDateTime read FDT_REF write FDT_REF;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D309: PROCESSO REFERENCIADO
  TRegistroD309 = class
  private
    fNUM_PROC: string;            //02	NUM_PROC	Identifica��o do processo ou ato concess�rio	C	020	-
    fIND_PROC: Integer;           //03	IND_PROC	Indicador da origem do processo:1 - Justi�a Federal;3 � Secretaria da Receita Federal do Brasil ;9 � Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO D350: RESUMO DI�RIO DE CUPOM FISCAL EMITIDO POR ECF - (C�DIGOS 2E, 13, 14, 15 e 16)
  TRegistroD350 = class
  private
    fCOD_MOD: string;	             //02	COD_MOD	C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1	C	002*	-
    fECF_MOD: string;	             //03	ECF_MOD	Modelo do equipamento	C	020	-
    fECF_FAB: string;	             //04	ECF_FAB	N�mero de s�rie de fabrica��o do ECF	C	020	-
    fDT_DOC: TDateTime;	           //05	DT_DOC	Data do movimento a que se refere a Redu��o Z	N	008*	-
    fCRO: Integer;	               //06	CRO	Posi��o do Contador de Rein�cio de Opera��o	N	003	-
    fCRZ: Integer;	               //07	CRZ	Posi��o do Contador de Redu��o Z	N	006	-
    fNUM_COO_FIN: Integer;	       //08	NUM_COO_FIN	N�mero do Contador de Ordem de Opera��o do �ltimo documento emitido no dia. (N�mero do COO na Redu��o Z)	N	006	-
    fGT_FIN: Currency;	           //09	GT_FIN	Valor do Grande Total final	N	-	02
    fVL_BRT: Currency;	           //10	VL_BRT	Valor da venda bruta	N	-	02
    fCST_PIS: Integer;	           //11	CST_PIS	C�digo da Situa��o Tribut�ria referente ao PIS/PASEP	N	002*	-
    fVL_BC_PIS: Currency;	         //12	VL_BC_PIS	Valor da base de c�lculo do PIS/PASEP	N	- 	02
    fALIQ_PIS: Currency;	         //13	ALIQ_PIS	Al�quota do PIS/PASEP (em percentual)	N	008	04
    fQUANT_BC_PIS: Currency;	     //14	QUANT_BC_PIS	Quantidade � Base de c�lculo PIS/PASEP	N	- 	03
    fALIQ_PIS_QUANT: Currency;	   //15	ALIQ_PIS_QUANT	Al�quota do PIS/PASEP (em reais)	N	 -	04
    fVL_PIS: Currency;	           //16	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCST_COFINS: Integer;	         //17	CST_COFINS	C�digo da Situa��o Tribut�ria referente a COFINS	N	002*	-
    fVL_BC_COFINS: Currency;	     //18	VL_BC_COFINS	Valor da base de c�lculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	       //19	ALIQ_COFINS	Al�quota da COFINS (em percentual)	N	008	04
    fQUANT_BC_COFINS: Currency;	   //20	QUANT_BC_COFINS	Quantidade � Base de c�lculo da COFINS	N	- 	03
    fALIQ_COFINS_QUANT: Currency;  //21	ALIQ_COFINS_QUANT	Al�quota da COFINS (em reais)	N	- 	04
    fVL_COFINS: Currency;	         //22	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	             //23	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property ECF_MOD: string read FECF_MOD write FECF_MOD;
    property ECF_FAB: string read FECF_FAB write FECF_FAB;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property CRO: Integer read FCRO write FCRO;
    property CRZ: Integer read FCRZ write FCRZ;
    property NUM_COO_FIN: Integer read FNUM_COO_FIN write FNUM_COO_FIN;
    property GT_FIN: Currency read FGT_FIN write FGT_FIN;
    property VL_BRT: Currency read FVL_BRT write FVL_BRT;
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property QUANT_BC_PIS: Currency read FQUANT_BC_PIS write FQUANT_BC_PIS;
    property ALIQ_PIS_QUANT: Currency read FALIQ_PIS_QUANT write FALIQ_PIS_QUANT;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property QUANT_BC_COFINS: Currency read FQUANT_BC_COFINS write FQUANT_BC_COFINS;
    property ALIQ_COFINS_QUANT: Currency read FALIQ_COFINS_QUANT write FALIQ_COFINS_QUANT;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D359: PROCESSO REFERENCIADO
  TRegistroD359 = class
  private
    fNUM_PROC: string;        //02	NUM_PROC	Identifica��o do processo ou ato concess�rio	C	020	-
    fIND_PROC: Integer;       //03	IND_PROC	Indicador da origem do processo:1 - Justi�a Federal;3 � Secretaria da Receita Federal do Brasil;9 � Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO D500: NOTA FISCAL DE SERVI�O DE COMUNICA��O (C�DIGO 21) E NOTA FISCAL DE SERVI�O DE TELECOMUNICA��O (C�DIGO 22) � DOCUMENTOS DE AQUISI��O COM DIREITO A CR�DITO
  TRegistroD500 = class
  private
    fIND_OPER: string;	              //02	IND_OPER	Indicador do tipo de opera��o:0- Aquisi��o	C	001*	-
    fIND_EMIT: string;	              //03	IND_EMIT	Indicador do emitente do documento fiscal:0- Emiss�o pr�pria;1- Terceiros	C	001*	-
    fCOD_PART: string;	              //04	COD_PART	C�digo do participante prestador do servi�o (campo 02 do Registro 0150).	C	060	-
    fCOD_MOD: string;	                //05	COD_MOD	C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1.	C	002*	-
    fCOD_SIT: Integer;	              //06	COD_SIT	��digo da situa��o do documento fiscal, conforme a Tabela 4.1.2.	N	002*	-
    fSER: string;	                    //07	SER	S�rie do documento fiscal	C	004	-
    fSUB: Integer;	                  //08	SUB	Subs�rie do documento fiscal	N	003	-
    fNUM_DOC: Integer;	              //09	NUM_DOC	N�mero do documento fiscal	N	009	-
    fDT_DOC: TDateTime;	              //10	DT_DOC	Data da emiss�o do documento fiscal	N	008*	-
    fDT_A_P: TDateTime;	              //11	DT_A_P	Data da entrada (aquisi��o)	N	008*	-
    fVL_DOC: Currency;	              //12	VL_DOC	Valor total do documento fiscal	N	-	02
    fVL_DESC: Currency;	              //13	VL_DESC	Valor total do desconto	N	-	02
    fVL_SERV: Currency;	              //14	VL_SERV	Valor da presta��o de servi�os	N	-	02
    fVL_SERV_NT: Currency;            //15	VL_SERV_NT	Valor total dos servi�os n�o-tributados pelo ICMS	N	-	02
    fVL_TERC: Currency;	              //16	VL_TERC	Valores cobrados em nome de terceiros	N	-	02
    fVL_DA: Currency;	                //17	VL_DA	Valor de outras despesas indicadas no documento fiscal	N	-	02
    fVL_BC_ICMS: Currency;            //18	VL_BC_ICMS	Valor da base de c�lculo do ICMS	N	-	02
    fVL_ICMS: Currency;	              //19	VL_ICMS	Valor do ICMS	N	-	02
    fCOD_INF: string;	                //20	COD_INF	C�digo da informa��o complementar (campo 02 do Registro 0450)	C	006	-
    fVL_PIS: Currency;                //21	VL_PIS	Valor do PIS/PASEP	N	-	02
    fVL_COFINS: Currency;             //22	VL_COFINS	Valor da COFINS	N	-	02
  public
    property IND_OPER: string read FIND_OPER write FIND_OPER;
    property IND_EMIT: string read FIND_EMIT write FIND_EMIT;
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_SIT: Integer read FCOD_SIT write FCOD_SIT;
    property SER: string read FSER write FSER;
    property SUB: Integer read FSUB write FSUB;
    property NUM_DOC: Integer read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property DT_A_P: TDateTime read FDT_A_P write FDT_A_P;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property VL_SERV: Currency read FVL_SERV write FVL_SERV;
    property VL_SERV_NT: Currency read FVL_SERV_NT write FVL_SERV_NT;
    property VL_TERC: Currency read FVL_TERC write FVL_TERC;
    property VL_DA: Currency read FVL_DA write FVL_DA;
    property VL_BC_ICMS: Currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: Currency read FVL_ICMS write FVL_ICMS;
    property COD_INF: string read FCOD_INF write FCOD_INF;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
  end;

  //REGISTRO D501: COMPLEMENTO DA OPERA��O (C�DIGOS 21 e 22) � PIS/PASEP
  TRegistroD501 = class
  private
    fCST_PIS: Integer;	         //02	CST_PIS	C�digo da Situa��o Tribut�ria referente ao PIS/PASEP	N	002*	-
    fVL_ITEM: Currency;	         //03	VL_ITEM	Valor Total dos Itens (Servi�os)	N	-	02
    fNAT_BC_CRED: string;	       //04	NAT_BC_CRED	C�digo da Base de C�lculo do Cr�dito, conforme a Tabela indicada no item 4.3.7.	C	002*	-
    fVL_BC_PIS: Currency;	       //05	VL_BC_PIS	Valor da base de c�lculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;	       //06	ALIQ_PIS	Al�quota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	         //07	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	           //08	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D505: COMPLEMENTO DA OPERA��O (C�DIGOS 21 e 22) � COFINS
  TRegistroD505 = class
  private
    fCST_COFINS: Integer;	          //02	CST_COFINS	C�digo da Situa��o Tribut�ria referente a COFINS	N	002*	-
    fVL_ITEM: Currency;	            //03	VL_ITEM	Valor Total dos Itens	N	-	02
    fNAT_BC_CRED: string;	          //04	NAT_BC_CRED	C�digo da Base de C�lculo do Cr�dito, conforme a Tabela indicada no item 4.3.7.	C	002*	-
    fVL_BC_COFINS: Currency;        //05	VL_BC_COFINS	Valor da base de c�lculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	        //06	ALIQ_COFINS	Al�quota da COFINS (em percentual)	N	008	04
    fVL_COFINS: Currency;	          //07	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	              //08	COD_CTA	C�digo da conta anal�tica cont�bil debitada/creditada	C	060	-
  public
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D509: PROCESSO REFERENCIADO
  TRegistroD509 = class
  private
    fNUM_PROC: string;         //02	NUM_PROC	Identifica��o do processo ou ato concess�rio	C	020	-
    fIND_PROC: Integer;        //03	IND_PROC	Indicador da origem do processo:1 - Justi�a Federal;3 � Secretaria da Receita Federal do Brasil;9 � Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO D600: CONSOLIDA��O DA PRESTA��O DE SERVI�OS - NOTAS DE SERVI�O DE COMUNICA��O (C�DIGO 21) E DE SERVI�O DE TELECOMUNICA��O (C�DIGO 22)
  TRegistroD600 = class
  private
    fCOD_MOD: string;	            //02	COD_MOD	C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1.	C	002*	-
    fCOD_MUN: Integer;	          //03	COD_MUN	C�digo do munic�pio dos terminais faturados, conforme a tabela IBGE	N	007*	-
    fSER: string;	                //04	SER	S�rie do documento fiscal	C	004	-
    fSUB: Integer;	              //05	SUB	Subs�rie do documento fiscal	N	003	-
    fIND_REC: Integer;	          //06	IND_REC	Indicador do tipo de receita:0- Receita pr�pria - servi�os prestados;1- Receita pr�pria - cobran�a de d�bitos;2- Receita pr�pria - venda de servi�o pr�-pago � faturamento de per�odos anteriores;3- Receita pr�pria - venda de servi�o pr�-pago � faturamento no per�odo;4- Outras receitas pr�prias de servi�os de comunica��o e telecomunica��o;5- Receita pr�pria - co-faturamento;6- Receita pr�pria � servi�os a faturar em per�odo futuro;7� Outras receitas pr�prias de natureza n�o-cumulativa;8 - Outras receitas de terceiros;9 � Outras receitas	N	001*	-
    fQTD_CONS: Integer;	          //07	QTD_CONS	Quantidade de documentos consolidados neste registro	N	-	-
    fDT_DOC_INI: TDateTime;       //08	DT_DOC_INI	Data Inicial dos documentos consolidados no per�odo	N	008*	-
    fDT_DOC_FIN: TDateTime;       //09	DT_DOC_FIN	Data Final dos documentos consolidados no per�odo	N	008*	-
    fVL_DOC: Currency;	          //10	VL_DOC	Valor total acumulado dos documentos fiscais	N	-	02
    fVL_DESC: Currency;	          //11	VL_DESC	Valor acumulado dos descontos	N	-	02
    fVL_SERV: Currency;	          //12	VL_SERV	Valor acumulado das presta��es de servi�os tributados pelo ICMS	N	-	02
    fVL_SERV_NT: Currency;        //13	VL_SERV_NT	Valor acumulado dos servi�os n�o-tributados pelo ICMS	N	-	02
    fVL_TERC: Currency;	          //14	VL_TERC	Valores cobrados em nome de terceiros	N	-	02
    fVL_DA: Currency;	            //15	VL_DA	Valor acumulado das despesas acess�rias	N	-	02
    fVL_BC_ICMS: Currency;        //16	VL_BC_ICMS	Valor acumulado da base de c�lculo do ICMS	N	-	02
    fVL_ICMS: Currency;	          //17	VL_ICMS	Valor acumulado do ICMS	N	-	02
    fVL_PIS: Currency;	          //18	VL_PIS	Valor do PIS/PASEP	N	-	02
    fVL_COFINS: Currency;	        //19	VL_COFINS	Valor da COFINS	N	-	02
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_MUN: Integer read FCOD_MUN write FCOD_MUN;
    property SER: string read FSER write FSER;
    property SUB: Integer read FSUB write FSUB;
    property IND_REC: Integer read FIND_REC write FIND_REC;
    property QTD_CONS: Integer read FQTD_CONS write FQTD_CONS;
    property DT_DOC_INI: TDateTime read FDT_DOC_INI write FDT_DOC_INI;
    property DT_DOC_FIN: TDateTime read FDT_DOC_FIN write FDT_DOC_FIN;
    property VL_DOC: Currency read FVL_DOC write FVL_DOC;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property VL_SERV: Currency read FVL_SERV write FVL_SERV;
    property VL_SERV_NT: Currency read FVL_SERV_NT write FVL_SERV_NT;
    property VL_TERC: Currency read FVL_TERC write FVL_TERC;
    property VL_DA: Currency read FVL_DA write FVL_DA;
    property VL_BC_ICMS: Currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: Currency read FVL_ICMS write FVL_ICMS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
  end;

  //REGISTRO D601: COMPLEMENTO DA CONSOLIDA��O DA PRESTA��O DE SERVI�OS (C�DIGOS 21 E 22) - PIS/PASEP
  TRegistroD601 = class
  private
    fCOD_CLASS: Integer;              //02	COD_CLASS	C�digo de classifica��o do item do servi�o de comunica��o ou de telecomunica��o, conforme a Tabela 4.4.1	N	004*	-
    fVL_ITEM: Currency;	              //03	VL_ITEM	Valor acumulado do item	N	-	02
    fVL_DESC: Currency;	              //04	VL_DESC	Valor acumulado dos descontos/exclus�es da base de c�lculo	N	-	02
    fCST_PIS: Integer;	              //05	CST_PIS	C�digo da Situa��o Tribut�ria referente ao PIS/PASEP	N	002*	-
    fVL_BC_PIS: Currency;             //06	VL_BC_PIS	Valor da base de c�lculo do PIS/PASEP	N	 -	02
    fALIQ_PIS: Currency;              //07	ALIQ_PIS	Al�quota do PIS/PASEP (em percentual)	N	008	04
    fVL_PIS: Currency;	              //08	VL_PIS	Valor do PIS/PASEP	N	-	02
    fCOD_CTA: string;	                //09	COD_CTA	C�digo da conta cont�bil debitada/creditada	C	060	-
  public
    property COD_CLASS: Integer read FCOD_CLASS write FCOD_CLASS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property CST_PIS: Integer read FCST_PIS write FCST_PIS;
    property VL_BC_PIS: Currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: Currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: Currency read FVL_PIS write FVL_PIS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D605: COMPLEMENTO DA CONSOLIDA��O DA PRESTA��O DE SERVI�OS (C�DIGOS 21 E 22) - COFINS
  TRegistroD605 = class
  private
    fCOD_CLASS: Integer;	         //02	COD_CLASS	C�digo de classifica��o do item do servi�o de comunica��o ou de telecomunica��o, conforme a Tabela 4.4.1	N	004*	-
    fVL_ITEM: Currency;	           //03	VL_ITEM	Valor acumulado do item	N	-	02
    fVL_DESC: Currency;	           //04	VL_DESC	Valor acumulado dos descontos/exclus�es da base de c�lculo	N	-	02
    fCST_COFINS: Integer;	         //05	CST_COFINS	C�digo da Situa��o Tribut�ria referente a COFINS	N	002*	-
    fVL_BC_COFINS: Currency;       //06	VL_BC_COFINS	Valor da base de c�lculo da COFINS	N	 -	02
    fALIQ_COFINS: Currency;	       //07	ALIQ_COFINS	Al�quota da COFINS (em percentual)	N	008-	04
    fVL_COFINS: Currency;	         //08	VL_COFINS	Valor da COFINS	N	-	02
    fCOD_CTA: string;	             //09	COD_CTA	C�digo da conta cont�bil debitada/creditada	C	060	-
  public
    property COD_CLASS: Integer read FCOD_CLASS write FCOD_CLASS;
    property VL_ITEM: Currency read FVL_ITEM write FVL_ITEM;
    property VL_DESC: Currency read FVL_DESC write FVL_DESC;
    property CST_COFINS: Integer read FCST_COFINS write FCST_COFINS;
    property VL_BC_COFINS: Currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: Currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: Currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO D609: PROCESSO REFERENCIADO
  TRegistroD609 = class
  private
    fNUM_PROC: string;        //02	NUM_PROC	Identifica��o do processo ou ato concess�rio	C	020	-
    fIND_PROC: Integer;       //03	IND_PROC	Indicador da origem do processo:1 - Justi�a Federal;3 � Secretaria da Receita Federal do Brasil;9 � Outros.	C	001*	-
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: Integer read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO D990: ENCERRAMENTO DO BLOCO D
  TRegistroD990 = class
  private
    fQTD_LIN_D: Integer;         //02	QTD_LIN_D	Quantidade total de linhas do Bloco D	N	-	-
  public
    property QTD_LIN_D: Integer read FQTD_LIN_D write FQTD_LIN_D;
  end;

implementation

end.
