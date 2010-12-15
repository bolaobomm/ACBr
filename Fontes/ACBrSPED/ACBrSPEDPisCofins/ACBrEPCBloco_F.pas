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
|* 14/12/2010: Isaque Pinheiro e Paulo Junqueira
|*  - Cria��o e distribui��o da Primeira Versao
*******************************************************************************}

unit ACBrEPCBloco_F;

interface

uses
  SysUtils, Classes, Contnrs, DateUtils;

type
  //REGISTRO F001: ABERTURA DO BLOCO C
  TRegistroF001 = class(TOpenBlocos)
  private
  public
  end;

  //REGISTRO F010: IDENTIFICA��O DO ESTABELECIMENTO
  TRegistroF010 = class
  private
    fCNPJ: Integer;           //02	CNPJ	N�mero de inscri��o do estabelecimento no CNPJ.	N	014*	-
  public
    property CNPJ: Integer read FCNPJ write FCNPJ;
  end;

  //REGISTRO F100: COMPLEMENTO DO DOCUMENTO - INFORMA��O COMPLEMENTAR DA NOTA FISCAL
  TRegistroF100 = class
  private
    FCOD_PART: string;           //C�digo do participante (Campo 02 do Registro 0150)
    FCOD_ITEM: string;           //C�digo do item (campo 02 do Registro 0200)
    FVL_OPER: currency;          //Valor da Opera��o/Item
    FCST_PIS: integer;           //C�digo da Situa��o Tribut�ria referente ao PIS/PASEP, conforme a Tabela indicada no item 4.3.3.
    FVL_BC_PIS: currency;        //Valor da Base de c�lculo do PIS/PASEP
    FALIQ_PIS: currency;         //Al�quota do PIS/PASEP (em percentual)
    FVL_PIS: currency;           //Valor do PIS/PASEP
    FCST_COFINS: integer;        //C�digo da Situa��o Tribut�ria referente a COFINS, conforme a Tabela indicada no item 4.3.4.
    FVL_BC_COFINS: currency;     //Valor da Base de c�lculo da COFINS
    FALIQ_COFINS: currency;      //Al�quota da COFINS (em percentual)
    FVL_COFINS: currency;        //Valor da COFINS
    FNAT_BC_CRED: string;        //C�digo da Base de C�lculo dos Cr�ditos, conforme a tabela indicada no item 4.3.7, caso seja informado c�digo representativo de cr�dito nos Campos 07 (CST_PIS) e 11 (CST_COFINS).
    FIND_ORIG_CRED: string;      //Indicador da origem do cr�dito: 0 - Opera��o no Mercado Interno 1 - Opera��o de Importa��o
    FCOD_CTA: string;            //C�digo da conta anal�tica cont�bil debitada/creditada
    FCOD_CCUS: string;           //C�digo do Centro de Custos
    FDESC_DOC_OPER: string;      //Descri��o  do Documento/Opera��o
  public
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property DT_OPER: TDateTime read FDT_OPER write FDT_OPER;
    property VL_OPER: currency read FVL_OPER write FVL_OPER;
    property CST_PIS: integer read FCST_PIS write FCST_PIS;
    property VL_BC_PIS: currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property CST_COFINS: integer read FCST_COFINS write FCST_COFINS;
    property VL_BC_COFINS: currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property IND_ORIG_CRED: string read FIND_ORIG_CRED write FIND_ORIG_CRED;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
    property COD_CCUS: string read FCOD_CCUS write FCOD_CCUS;
    property DESC_DOC_OPER: string read FDESC_DOC_OPER write FDESC_DOC_OPER;
  end;

  //REGISTRO F111: PROCESSO REFERENCIADO
  TRegistroF111 = class
  private
    fNUM_PROC: string;	           //02	Identifica��o do processo ou ato concess�rio.
    fIND_PROC: string;	           //Indicador da origem do processo: 1 - Justi�a Federal; 3 - Secretaria da Receita Federal do Brasil
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: string read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO F120: BENS INCORPORADOS AO ATIVO IMOBILIZADO - OPERA��ES GERADORAS DE CR�DITOS COM BASE NOS ENCARGOS DE DEPRECIA��O E AMORTIZA��O
  TRegistroF120 = class
  private
    fNAT_BC_CRED: string;	         //C�digo da Base de C�lculo do Cr�dito sobre Bens Incorporados ao Ativo Imobilizado, conforme a Tabela indicada no item 4.3.7: 09 = Cr�dito com Base nos Encargos de Deprecia��o; 11 = Cr�dito com Base nos Encargos de Amortiza��o
    fIDENT_BEM_IMOB: string;	     //Identifica��o dos Bens/Grupo de Bens Incorporados ao Ativo Imobilizado:
                                     //01 = Edifica��es e Benfeitorias em Im�veis Pr�prios;
                                     //02 = Edifica��es e Benfeitorias em Im�veis de Terceiros;
                                     //03 = Instala��es;
                                     //04 = M�quinas;
                                     //05 = Equipamentos;
                                     //06 = Ve�culos;
                                     //99 = Outros Bens Incorporados ao Ativo Imobilizado.
    fIND_ORIG_CRED: string;	       //Indicador da origem do bem incorporado ao ativo imobilizado, gerador de cr�dito: 0 - Aquisi��o no Mercado Interno 1 - Aquisi��o no Mercado Externo (Importa��o)
    fIND_UTIL_BEM_IMOB: string;	   //Indicador da Utiliza��o dos Bens Incorporados ao Ativo Imobilizado:
                                    //1 - Produ��o de Bens Destinados a Venda;
                                    //2 - Presta��o de Servi�os;
                                    //3 - Loca��o a Terceiros;
                                    //9 - Outros.
    fVL_OPER_DEP: currency;	       //Valor do Encargo de Deprecia��o/Amortiza��o Incorrido no Per�odo
    fPARC_OPER_NAO_BC_CRED: currency;	//Parcela do Valor do Encargo de Deprecia��o/Amortiza��o a excluir da base de c�lculo de Cr�dito
    fCST_PIS: string;	             //C�digo da Situa��o Tribut�ria referente ao PIS/PASEP, conforme a Tabela indicada no item 4.3.3.
    fVL_BC_PIS: string;	           //Base de c�lculo do Cr�dito de PIS/PASEP no per�odo
    fALIQ_PIS: currency;	         //Al�quota do PIS/PASEP (em percentual)
    fVL_PIS: currency;	           //Valor do Cr�dito de PIS/PASEP
    fCST_COFINS: string;	         //C�digo da Situa��o Tribut�ria referente a COFINS, conforme a Tabela indicada no item 4.3.4.
    fVL_BC_COFINS: currency;	     //Base de C�lculo do Cr�dito da COFINS no per�odo (06 - 07)
    fALIQ_COFINS: currency;	       //Al�quota da COFINS (em percentual)
    fVL_COFINS: currency;	         //Valor do cr�dito da COFINS
    fCOD_CTA: string;	             //C�digo da conta anal�tica cont�bil debitada/creditada
    fCOD_CCUS: string;	           //C�digo do Centro de Custos
    fDESC_BEM_IMOB: string;	       //Descri��o complementar do bem ou grupo de bens, com cr�dito apurado com base nos encargos de deprecia��o ou amortiza��o.
  public
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property IDENT_BEM_IMOB: string read fIDENT_BEM_IMOB write fIDENT_BEM_IMOB;
    property IND_ORIG_CRED: string read fIND_ORIG_CRED write fIND_ORIG_CRED;
    property IND_UTIL_BEM_IMOB: string read fIND_UTIL_BEM_IMOB write fIND_UTIL_BEM_IMOB;
    property VL_OPER_DEP: currency read fVL_OPER_DEP write fVL_OPER_DEP;
    property PARC_OPER_NAO_BC_CRED: currency read fPARC_OPER_NAO_BC_CRED write ffPARC_OPER_NAO_BC_CRED;
    property CST_PIS: string read fCST_PIS write fCST_PIS;
    property ALIQ_PIS: currency read fALIQ_PIS write fALIQ_PIS;
    property VL_PIS: currency read fVL_PIS write fVL_PIS;
    property CST_COFINS: string read fCST_COFINS write fCST_COFINS;
    property VL_BC_COFINS: currency read fVL_BC_COFINS write fVL_BC_COFINS;
    property ALIQ_COFINS: currency read fALIQ_COFINS write fALIQ_COFINS;
    property VL_COFINS: currency read fVL_COFINS write fVL_COFINS;
    property COD_CTA: string read fCOD_CTA write fCOD_CTA;
    property COD_CCUS: string read fCOD_CCUS write fCOD_CCUS;
    property DESC_BEM_IMOB: string read fDESC_BEM_IMOB write fDESC_BEM_IMOB;
  end;

  //REGISTRO F129: PROCESSO REFERENCIADO
  TRegistroF129 = class
  private
    fNUM_PROC: string;	           //02	Identifica��o do processo ou ato concess�rio.
    fIND_PROC: string;	           //Indicador da origem do processo: 1 - Justi�a Federal; 3 - Secretaria da Receita Federal do Brasil
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: string read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO F130: BENS INCORPORADOS AO ATIVO IMOBILIZADO - OPERA��ES GERADORAS DE CR�DITOS COM BASE NO VALOR DE AQUISI��O/CONTRIBUI��O
  TRegistroF130 = class
  private
    fNAT_BC_CRED: string;	         //C�digo da Base de C�lculo do Cr�dito sobre Bens Incorporados ao Ativo Imobilizado, conforme a Tabela indicada no item 4.3.7: 09 = Cr�dito com Base nos Encargos de Deprecia��o; 11 = Cr�dito com Base nos Encargos de Amortiza��o
    fIDENT_BEM_IMOB: string;	     //Identifica��o dos Bens/Grupo de Bens Incorporados ao Ativo Imobilizado:
                                     //01 = Edifica��es e Benfeitorias em Im�veis Pr�prios;
                                     //02 = Edifica��es e Benfeitorias em Im�veis de Terceiros;
                                     //03 = Instala��es;
                                     //04 = M�quinas;
                                     //05 = Equipamentos;
                                     //06 = Ve�culos;
                                     //99 = Outros Bens Incorporados ao Ativo Imobilizado.
    fIND_ORIG_CRED: string;	       //Indicador da origem do bem incorporado ao ativo imobilizado, gerador de cr�dito: 0 - Aquisi��o no Mercado Interno 1 - Aquisi��o no Mercado Externo (Importa��o)
    fIND_UTIL_BEM_IMOB: string;	   //Indicador da Utiliza��o dos Bens Incorporados ao Ativo Imobilizado:
                                    //1 - Produ��o de Bens Destinados a Venda;
                                    //2 - Presta��o de Servi�os;
                                    //3 - Loca��o a Terceiros;
                                    //9 - Outros.
    fMES_OPER_AQUIS: string;	     //M�s/Ano de Aquisi��o dos Bens Incorporados ao Ativo Imobilizado, com apura��o de cr�dito com base no valor de aquisi��o.
    fVL_OPER_AQUIS: currency;	     //Valor de Aquisi��o dos Bens Incorporados ao Ativo Imobilizado - Cr�dito com base no valor de aquisi��o.
    fPARC_OPER_NAO_BC_CRED: currency; //Parcela do Valor de Aquisi��o a excluir da base de c�lculo de Cr�dito
    fVL_BC_CRED: currency;	       //Valor da Base de C�lculo do Cr�dito sobre Bens Incorporados ao Ativo Imobilizado (07 - 08)
    fIND_NR_PARC: integer;	       //Indicador do Numero de Parcelas a serem apropriadas (Cr�dito sobre Valor de Aquisi��o):
                                    //1 - Integral (M�s de Aquisi��o);
                                    //2 - 12 Meses;
                                    //3 - 24 Meses;
                                    //4 - 48 Meses;
                                    //5 - 6 Meses (Embalagens de bebidas frias)
                                    //9 - Outra periodicidade definida em Lei.
   fCST_PIS: string;	             //C�digo da Situa��o Tribut�ria referente ao PIS/PASEP, conforme a Tabela indicada no item 4.3.3.
   fVL_BC_PIS: currency;	         //Base de c�lculo Mensal do Cr�dito de PIS/PASEP, conforme indicador informado no campo 10.
   fALIQ_PIS: currency;	           //Al�quota do PIS/PASEP
   fVL_PIS: currency;	             //Valor do Cr�dito de PIS/PASEP
   fCST_COFINS: string;	           //C�digo da Situa��o Tribut�ria referente a COFINS, conforme a Tabela indicada no item 4.3.4.
   fVL_BC_COFINS: currency;	       //Base de C�lculo Mensal do Cr�dito da COFINS, conforme indicador informado no campo 10.
   fALIQ_COFINS: currency;	       //Al�quota da COFINS
   fVL_COFINS: currency;	         //Valor do cr�dito da COFINS
   fCOD_CTA: string;	             //C�digo da conta anal�tica cont�bil debitada/creditada
   fCOD_CCUS: string;	             //C�digo do Centro de Custos
   fDESC_BEM_IMOB: string;	       //Descri��o complementar do bem ou grupo de bens, com cr�dito apurado com base no valor de aquisi��o.
  public
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property IDENT_BEM_IMOB: string read fIDENT_BEM_IMOB write fIDENT_BEM_IMOB;
    property IND_ORIG_CRED: string read fIND_ORIG_CRED write fIND_ORIG_CRED;
    property IND_UTIL_BEM_IMOB: string read fIND_UTIL_BEM_IMOB write fIND_UTIL_BEM_IMOB;
    property MES_OPER_AQUIS: string read fMES_OPER_AQUIS write fMES_OPER_AQUIS;
    property VL_OPER_AQUIS: currency read fVL_OPER_AQUIS write fVL_OPER_AQUIS;
    property PARC_OPER_NAO_BC_CRED: currency read fPARC_OPER_NAO_BC_CRED write fPARC_OPER_NAO_BC_CRED;
    property VL_BC_CRED: currency read fVL_BC_CRED write fVL_BC_CRED;
    property IND_NR_PARC: integer read fIND_NR_PARC write fIND_NR_PARC;
    property CST_PIS: string read fCST_PIS write fCST_PIS;
    property VL_BC_PIS: currency read fVL_BC_PIS write fVL_BC_PIS;
    property ALIQ_PIS: currency read fALIQ_PIS write fALIQ_PIS;
    property VL_PIS: currency read fVL_PIS write fVL_PIS;
    property CST_COFINS: string read fCST_COFINS write fCST_COFINS;
    property VL_BC_COFINS: currency read fVL_BC_COFINS write fVL_BC_COFINS;
    property ALIQ_COFINS: currency read fALIQ_COFINS write fALIQ_COFINS;
    property VL_COFINS: currency read fVL_COFINS write fVL_COFINS;
    property COD_CTA: string read fCOD_CTA write fCOD_CTA;
    property COD_CCUS: string read fCOD_CCUS write fCOD_CCUS;
    property DESC_BEM_IMOB: string read fDESC_BEM_IMOB write fDESC_BEM_IMOB;
  end;

  //REGISTRO F139: PROCESSO REFERENCIADO
  TRegistroF139 = class
  private
    FNAT_BC_CRED: string;	         //Texto fixo contendo "18" C�digo da Base de C�lculo do Cr�dito sobre Estoque de Abertura, conforme a Tabela indicada no item 4.3.7.
    FVL_TOT_EST: currency;	       //Valor Total do Estoque de Abertura
    FEST_IMP: integer;	           //Parcela do estoque de abertura referente a bens, produtos e mercadorias importados, ou adquiridas no mercado interno sem direito ao cr�dito
    FVL_BC_EST: currency;	         //Valor da Base de C�lculo do Cr�dito sobre o Estoque de Abertura (03 - 04)
    FVL_BC_MEN_EST: currency;	     //Valor da Base de C�lculo Mensal do Cr�dito sobre o Estoque de Abertura (1/12 avos do campo 05)
    fCST_PIS: string;	             //C�digo da Situa��o Tribut�ria referente ao PIS/PASEP, conforme a Tabela indicada no item 4.3.3.
    fALIQ_PIS: currency;	         //Al�quota do PIS/PASEP
    FVL_CRED_PIS: currency;	       //Valor Mensal do Cr�dito Presumido Apurado para o Per�odo -  PIS/PASEP  (06 x 08)
    fCST_COFINS: string;	         //C�digo da Situa��o Tribut�ria referente a COFINS, conforme a Tabela indicada no item 4.3.4.
    fALIQ_COFINS: currency;	       //Al�quota da COFINS
    FVL_CRED_COFINS: currency;	   //Valor Mensal do Cr�dito Presumido Apurado para o Per�odo -  COFINS (06 x 11)
    FDESC_EST: string;	           //Descri��o do estoque
    FCOD_CTA: string;	             //C�digo da conta anal�tica cont�bil debitada/creditada
  public
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property VL_TOT_EST: currency read FVL_TOT_EST write FVL_TOT_EST;
    property EST_IMP: integer read FEST_IMP write FEST_IMP;
    property VL_BC_EST: currency read FVL_BC_EST write FVL_BC_EST;
    property VL_BC_MEN_EST: currency read FVL_BC_MEN_EST write FVL_BC_MEN_EST;
    property CST_PIS: string read fCST_PIS write fCST_PIS;
    property ALIQ_PIS: currency read fALIQ_PIS write fALIQ_PIS;
    property VL_CRED_PIS: currency read FVL_CRED_PIS write FVL_CRED_PIS;
    property CST_COFINS: string read fCST_COFINS write fCST_COFINS;
    property ALIQ_COFINS: currency read fALIQ_COFINS write fALIQ_COFINS;
    property VL_CRED_COFINS: currency read FVL_CRED_COFINS write FVL_CRED_COFINS;
    property DESC_EST: string read FDESC_EST write FDESC_EST;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO F150: CR�DITO PRESUMIDO SOBRE ESTOQUE DE ABERTURA
  TRegistroF150 = class
  private
    FNAT_BC_CRED: string;	         //Texto fixo contendo "18" C�digo da Base de C�lculo do Cr�dito sobre Estoque de Abertura, conforme a Tabela indicada no item 4.3.7.
    FVL_TOT_EST: currency;
    FEST_IMP: integer;
    FVL_BC_EST: currency;
    FVL_BC_MEN_EST: currency;
    FCST_PIS: string;
    FALIQ_PIS: currency;
    FVL_CRED_PIS: currency;
    FALIQ_COFINS: currency;
    FVL_CRED_COFINS: currency;
    FCOD_CTA: string;
    FCST_COFINS: string;
    FDESC_EST: string;
  public
    property NAT_BC_CRED: string read FNAT_BC_CRED write FNAT_BC_CRED;
    property VL_TOT_EST: currency read FVL_TOT_EST write FVL_TOT_EST;
    property EST_IMP: integer read FEST_IMP write FEST_IMP;
    property VL_BC_EST: currency read FVL_BC_EST write FVL_BC_EST;
    property VL_BC_MEN_EST: currency read FVL_BC_MEN_EST write FVL_BC_MEN_EST;
    property CST_PIS: string read FCST_PIS write FCST_PIS;
    property ALIQ_PIS: currency read FALIQ_PIS write FALIQ_PIS;
    property VL_CRED_PIS: currency read FVL_CRED_PIS write FVL_CRED_PIS;
    property CST_COFINS: string read FCST_COFINS write FCST_COFINS;
    property ALIQ_COFINS: currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_CRED_COFINS: currency read FVL_CRED_COFINS write FVL_CRED_COFINS;
    property DESC_EST: string read FDESC_EST write FDESC_EST;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  //REGISTRO F200: OPERA��ES DA ATIVIDADE IMOBILI�RIA - UNIDADE IMOBILI�RIA VENDIDA
  TRegistroF200 = class
  private
    FALIQ_PIS: currency;
    FVL_REC_ACUM: currency;
    FVL_BC_COFINS: currency;
    FALIQ_COFINS: currency;
    FVL_TOT_VEND: currency;
    FPERC_REC_RECEB: currency;
    FVL_TOT_REC: currency;
    FVL_COFINS: currency;
    FVL_PIS: currency;
    FCST_COFINS: string;
    FCPF_CNPJ_ADQU: string;
    FUNID_IMOB: string;
    FCST_PIS: string;
    FIDENT_EMP: string;
    FNUM_CONT: string;
    FIND_OPER: string;
    FINF_COMP: string;
    FDESC_UNID_IMOB: string;
    FIND_NAT_EMP: string;
    FDT_OPER: TDateTime;
  public
    property IND_OPER: string read FIND_OPER write FIND_OPER;
    property UNID_IMOB: string read FUNID_IMOB write FUNID_IMOB;
    property IDENT_EMP: string read FIDENT_EMP write FIDENT_EMP;
    property DESC_UNID_IMOB: string read FDESC_UNID_IMOB write FDESC_UNID_IMOB;
    property NUM_CONT: string read FNUM_CONT write FNUM_CONT;
    property CPF_CNPJ_ADQU: string read FCPF_CNPJ_ADQU write FCPF_CNPJ_ADQU;
    property DT_OPER: TDateTime read FDT_OPER write FDT_OPER;
    property VL_TOT_VEND: currency read FVL_TOT_VEND write FVL_TOT_VEND;
    property VL_REC_ACUM: currency read FVL_REC_ACUM write FVL_REC_ACUM;
    property VL_TOT_REC: currency read FVL_TOT_REC write FVL_TOT_REC;
    property CST_PIS: string read FCST_PIS write FCST_PIS;
    property VL_TOT_REC: currency read FVL_TOT_REC write FVL_TOT_REC;
    property VL_BC_PIS: currency read FVL_BC_PIS write FVL_BC_PIS;
    property ALIQ_PIS: currency read FALIQ_PIS write FALIQ_PIS;
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property CST_COFINS: string read FCST_COFINS write FCST_COFINS;
    property VL_BC_COFINS: currency read FVL_BC_COFINS write FVL_BC_COFINS;
    property ALIQ_COFINS: currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
    property PERC_REC_RECEB: currency read FPERC_REC_RECEB write FPERC_REC_RECEB;
    property IND_NAT_EMP: string read FIND_NAT_EMP write FIND_NAT_EMP;
    property INF_COMP: string read FINF_COMP write FINF_COMP;
  end;

  //REGISTRO F205: OPERA��ES DA ATIVIDADE IMOBILI�RIA - CUSTO INCORRIDO DA UNIDADE IMOBILI�RIA
  TRegistroF205 = class
  private
    FVL_CRED_PIS_ACUM: currency;
    FVL_EXC_BC_CUS_INC_ACUM: currency;
    FVL_CUS_INC_PER_ESC: currency;
    FVL_CRED_COFINS_DESC_FUT: currency;
    FVL_BC_CUS_INC: currency;
    FALIQ_COFINS: currency;
    FVL_CRED_PIS_DESC_FUT: currency;
    FVL_CRED_COFINS_DESC_ANT: currency;
    FVL_CRED_PIS_DESC_ANT: currency;
    FVL_CRED_COFINS_ACUM: currency;
    FVL_CRED_PIS_DESC: currency;
    FVL_CUS_INC_ACUM_ANT: currency;
    FVL_CRED_COFINS_DESC: currency;
    FVL_CUS_INC_ACUM: currency;
    FCST_PIS: string;
    FCST_COFINS: string;
    FALIQ_PIS: string;
  public
    property VL_CUS_INC_ACUM_ANT: currency read FVL_CUS_INC_ACUM_ANT write FVL_CUS_INC_ACUM_ANT;
    property VL_CUS_INC_PER_ESC: currency read FVL_CUS_INC_PER_ESC write FVL_CUS_INC_PER_ESC;
    property VL_CUS_INC_ACUM: currency read FVL_CUS_INC_ACUM write FVL_CUS_INC_ACUM;
    property VL_EXC_BC_CUS_INC_ACUM: currency read FVL_EXC_BC_CUS_INC_ACUM write FVL_EXC_BC_CUS_INC_ACUM;
    property VL_BC_CUS_INC: currency read FVL_BC_CUS_INC write FVL_BC_CUS_INC;
    property CST_PIS: string read FCST_PIS write FCST_PIS;
    property ALIQ_PIS: currency read FALIQ_PIS write FALIQ_PIS;
    property VL_CRED_PIS_ACUM: currency read FVL_CRED_PIS_ACUM write FVL_CRED_PIS_ACUM;
    property VL_CRED_PIS_DESC_ANT: currency read FVL_CRED_PIS_DESC_ANT write FVL_CRED_PIS_DESC_ANT;
    property VL_CRED_PIS_DESC: currency read FVL_CRED_PIS_DESC write FVL_CRED_PIS_DESC;
    property VL_CRED_PIS_DESC_FUT: currency read FVL_CRED_PIS_DESC_FUT write FVL_CRED_PIS_DESC_FUT;
    property CST_COFINS: string read FCST_COFINS write FCST_COFINS;
    property ALIQ_COFINS: currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_CRED_COFINS_ACUM: currency read FVL_CRED_COFINS_ACUM write FVL_CRED_COFINS_ACUM;
    property VL_CRED_COFINS_DESC_ANT: currency read FVL_CRED_COFINS_DESC_ANT write FVL_CRED_COFINS_DESC_ANT;
    property VL_CRED_COFINS_DESC: currency read FVL_CRED_COFINS_DESC write FVL_CRED_COFINS_DESC;
    property VL_CRED_COFINS_DESC_FUT: currency read FVL_CRED_COFINS_DESC_FUT write FVL_CRED_COFINS_DESC_FUT;
  end;

  //REGISTRO F210: REGISTRO F210: OPERA��ES DA ATIVIDADE IMOBILI�RIA - CUSTO OR�ADO DA UNIDADE IMOBILI�RIA VENDIDA
  TRegistroF210 = class
  private
    FVL_BC_CRED: currency;
    FVL_CRED_COFINS_UTIL: currency;
    FALIQ_PIS: currency;
    FVL_EXC: currency;
    FALIQ_COFINS: currency;
    FVL_CUS_ORC_AJU: currency;
    FVL_CUS_ORC: currency;
    FVL_CRED_PIS_UTIL: currency;
    FCST_PIS: string;
    FCST_COFINS: string;
  public
    property VL_CUS_ORC: currency read FVL_CUS_ORC write FVL_CUS_ORC;
    property VL_EXC: currency read FVL_EXC write FVL_EXC;
    property VL_CUS_ORC_AJU: currency read FVL_CUS_ORC_AJU write FVL_CUS_ORC_AJU;
    property VL_BC_CRED: currency read FVL_BC_CRED write FVL_BC_CRED;
    property CST_PIS: string read FCST_PIS write FCST_PIS;
    property ALIQ_PIS: currency read FALIQ_PIS write FALIQ_PIS;
    property VL_CRED_PIS_UTIL: currency read FVL_CRED_PIS_UTIL write FVL_CRED_PIS_UTIL;
    property CST_COFINS: string read FCST_COFINS write FCST_COFINS;
    property ALIQ_COFINS: currency read FALIQ_COFINS write FALIQ_COFINS;
    property VL_CRED_COFINS_UTIL: currency read FVL_CRED_COFINS_UTIL write FVL_CRED_COFINS_UTIL;
  end;

  //REGISTRO F211: PROCESSO REFERENCIADO
  TRegistroF211 = class
  private
    fNUM_PROC: string;	           //02	Identifica��o do processo ou ato concess�rio.
    fIND_PROC: string;	           //Indicador da origem do processo: 1 - Justi�a Federal; 3 - Secretaria da Receita Federal do Brasil
  public
    property NUM_PROC: string read FNUM_PROC write FNUM_PROC;
    property IND_PROC: string read FIND_PROC write FIND_PROC;
  end;

  //REGISTRO F600: CONTRIBUI��O RETIDA NA FONTE
  TRegistroF600 = class
  private
    FVL_RET: currency;
    FVL_BC_RET: currency;
    FVL_RET_COFINS: currency;
    FVL_RET_PIS: currency;
    FCOD_REC: string;
    FIND_NAT_RET: string;
    FCNPJ: string;
    FIND_NAT_REC: string;
    FIND_DEC: string;
    FDT_RET: TDateTime;
  public
    property IND_NAT_RET: string read FIND_NAT_RET write FIND_NAT_RET;
    property DT_RET: TDateTime read FDT_RET write FDT_RET;
    property VL_BC_RET: currency read FVL_BC_RET write FVL_BC_RET;
    property VL_RET: currency read FVL_RET write FVL_RET;
    property COD_REC: string read FCOD_REC write FCOD_REC;
    property IND_NAT_REC: string read FIND_NAT_REC write FIND_NAT_REC;
    property CNPJ: string read FCNPJ write FCNPJ;
    property VL_RET_PIS: currency read FVL_RET_PIS write FVL_RET_PIS;
    property VL_RET_COFINS: currency read FVL_RET_COFINS write FVL_RET_COFINS;
    property IND_DEC: string read FIND_DEC write FIND_DEC;
  end;

  //REGISTRO F700: DEDU��ES DIVERSAS
  TRegistroF700 = class
  private
    FVL_DED_COFINS: currency;
    FVL_DED_PIS: currency;
    FIND_ORI_DED: string;
    FIND_NAT_DED: string;
  public
    property IND_ORI_DED: string read FIND_ORI_DED write FIND_ORI_DED;
    property IND_NAT_DED: string read FIND_NAT_DED write FIND_NAT_DED;
    property VL_DED_PIS: currency read FVL_DED_PIS write FVL_DED_PIS;
    property VL_DED_COFINS: currency read FVL_DED_COFINS write FVL_DED_COFINS;
  end;

  //REGISTRO F800: CR�DITOS DECORRENTES DE EVENTOS DE INCORPORA��O, FUS�O E CIS�O
  TRegistroF800 = class
  private
    FVL_CRED_COFINS: currency;
    FVL_CRED_PIS: currency;
    FPER_CRED_CIS: currency;
    FIND_NAT_EVEN: string;
    FCOD_CRED: string;
    FCNPJ_SUCED: string;
    FPA_CONT_CRED: string;
    FDT_EVEN: TDateTime;
  public
    property IND_NAT_EVEN: string read FIND_NAT_EVEN write FIND_NAT_EVEN;
    property DT_EVEN: TDateTime read FDT_EVEN write FDT_EVEN;
    property CNPJ_SUCED: string read FCNPJ_SUCED write FCNPJ_SUCED;
    property PA_CONT_CRED: string read FPA_CONT_CRED write FPA_CONT_CRED;
    property COD_CRED: string read FCOD_CRED write FCOD_CRED;
    property VL_CRED_PIS: currency read FVL_CRED_PIS write FVL_CRED_PIS;
    property VL_CRED_COFINS: currency read FVL_CRED_COFINS write FVL_CRED_COFINS;
    property PER_CRED_CIS: currency read FPER_CRED_CIS write FPER_CRED_CIS;
  end;

  //REGISTRO F990: ENCERRAMENTO DO BLOCO F
  TRegistroF990 = class
  private
    FQTD_LIN_F: integer;
  public
    property QTD_LIN_F: integer read FQTD_LIN_F write FQTD_LIN_F;
  end;

implementation

end.
