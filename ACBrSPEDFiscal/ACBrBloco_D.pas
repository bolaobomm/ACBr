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
|* 10/04/2009: Isaque Pinheiro
|*  - Cria��o e distribui��o da Primeira Versao
*******************************************************************************}

unit ACBrBloco_D;

interface

uses
  SysUtils, Classes, DateUtils, ACBrBlocos;

type
  /// Registro D001 - ABERTURA DO BLOCO D

  TRegistroD001 = class(TOpenBlocos)
  private
  public
  end;

  /// Registro D100 - NOTA FISCAL DE SERVI�O DE TRANSPORTE (C�DIGO 07) E CONHECIMENTOS DE TRANSPORTE RODOVI�RIO DE CARGAS (C�DIGO 08), AQUAVI�RIO DE CARGAS (C�DIGO 09), A�REO (C�DIGO 10), FERROVI�RIO DE CARGAS (C�DIGO 11) E MULTIMODAL DE CARGAS (C�DIGO 26) E NOTA FISCAL DE TRANSPORTE FERROVI�RIO DE CARGA (C�DIGO 27)

  TRegistroD100 = class(TPersistent)
  private
  public
  end;

  /// Registro D100 - Lista

  TRegistroD100List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD100; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD100); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD100;
    property Items[Index: Integer]: TRegistroD100 read GetItem write SetItem;
  end;

  /// Registro D110 - COMPLEMENTO DOS BILHETES (C�DIGO 13, C�DIGO 14 E C�DIGO 16)

  TRegistroD110 = class(TPersistent)
  private
    fUF_ORIG: string;          /// Sigla da unidade da federa��o:
    fCOD_MUN_ORIG: string;     /// C�digo do munic�pio de origem do servi�o:
    fUF_DEST: string;          /// Sigla da unidade da federa��o de destino do passageiro:
    fCOD_MUN_DEST: string;     /// C�digo do munic�pio de destino do passageiro:
    fCOD_LINHA: string;        /// C�digo do prefixo da linha de transporte:
    fLINHA: string;            /// Descri��o da linha de transporte:
    fPOLT_CAB: string;         /// N�mero da poltrona ou cabine:
    fAGENTE: string;           /// Identifica�� o do agente:
  public
    property UF_ORIG: string read FUF_ORIG write FUF_ORIG;
    property COD_MUN_ORIG: string read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property UF_DEST: string read FUF_DEST write FUF_DEST;
    property COD_MUN_DEST: string read FCOD_MUN_DEST write FCOD_MUN_DEST;
    property COD_LINHA: string read FCOD_LINHA write FCOD_LINHA;
    property LINHA: string read FLINHA write FLINHA;
    property POLT_CAB: string read FPOLT_CAB write FPOLT_CAB;
    property AGENTE: string read FAGENTE write FAGENTE;
  end;

  /// Registro D110 - Lista

  TRegistroD110List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD110; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD110); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD110;
    property Items[Index: Integer]: TRegistroD110 read GetItem write SetItem;
  end;

  /// Registro D120 - RESUMO DOS BILHETES DE PASSAGEM RODOVI�RIO (C�DIGO 13), DE PASSAGEM AQUAVI�RIO (C�DIGO 14), DE PASSAGEM E NOTA DE BAGAGEM (C�DIGO 15) E DE PASSAGEM FERROVI�RIO (C�DIGO 16)

  TRegistroD120 = class(TPersistent)
  private
    fCOD_MOD: string;          /// C�digo do modelo do documento fiscal:
    fSER: string;              /// S�rie do documento fiscal:
    fSUB: string;              /// Subs �rie do documento fiscal:
    fNUM_DOC_INI: string;      /// N�mero do primeiro documento fiscal emitido:
    fNUM_DOC_FIN: string;      /// N�mero do �ltimo documento fiscal emitido:
    fQTD_CANC: currency;       /// Quantidade de documentos cancelados:
    fDT_DOC: currency;         /// Data da emiss�o dos documentos fiscais:
    fVL_DOC: currency;         /// Valor total acumulado:
    fVL_DESC: currency;        /// Valor total dos descontos:
    fVL_SERV: currency;        /// Valor total da presta ��o de servi�o:
    fVL_BC_ICMS: currency;     /// Valor total da base de c�lculo do ICMS:
    fVL_ICMS: currency;        /// Valor total do ICMS:
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property SER: string read FSER write FSER;
    property SUB: string read FSUB write FSUB;
    property NUM_DOC_INI: string read FNUM_DOC_INI write FNUM_DOC_INI;
    property NUM_DOC_FIN: string read FNUM_DOC_FIN write FNUM_DOC_FIN;
    property QTD_CANC: currency read FQTD_CANC write FQTD_CANC;
    property DT_DOC: currency read FDT_DOC write FDT_DOC;
    property VL_DOC: currency read FVL_DOC write FVL_DOC;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
  end;

  /// Registro D120 - Lista

  TRegistroD120List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD120; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD120); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD120;
    property Items[Index: Integer]: TRegistroD120 read GetItem write SetItem;
  end;

  /// Registro D130 - COMPLEMENTO DO CONHECIMENTO RODOVI�RIO DE CARGAS (C�DIGO 08)

  TRegistroD130 = class(TPersistent)
  private
    fCOD_PART_CONSG: string;      /// C�digo do participante (campo 02 do Registro 0150):
    fCOD_PART_RED: string;        /// C�digo do participante (campo 02 do Registro 0150):
    fIND_FRT_RED: string;         /// Indicador do tipo do frete da opera��o de redespacho:
    fCOD_MUN_ORIG: string;        /// C�digo do munic�pio de origem do servi�o, conforme a tabela IBGE
    fCOD_MUN_DEST: string;        /// C�digo do munic�pio de destino, conforme a tabela IBGE
    fVEIC_ID: string;             /// Placa de identifica��o do ve�culo
    fVL_LIQ_FRT: currency;        /// Valor l�quido do frete
    fVL_SEC_CAT: currency;        /// Soma de valores de Sec/Cat (servi�os de coleta/custo adicional de transporte)
    fVL_DESP: currency;           /// Soma de valores de despacho
    fVL_PEDG: currency;           /// Soma dos valores de ped�gio
    fVL_OUT: currency;            /// Outros valores
    fVL_FRT: currency;            /// Valor total do frete
    fUF_ID: string;               /// Sigla da UF da placa do ve�culo
  public
    property COD_PART_CONSG: string read FCOD_PART_CONSG write FCOD_PART_CONSG;
    property COD_PART_RED: string read FCOD_PART_RED write FCOD_PART_RED;
    property IND_FRT_RED: string read FIND_FRT_RED write FIND_FRT_RED;
    property COD_MUN_ORIG: string read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property COD_MUN_DEST: string read FCOD_MUN_DEST write FCOD_MUN_DEST;
    property VEIC_ID: string read FVEIC_ID write FVEIC_ID;
    property VL_LIQ_FRT: currency read FVL_LIQ_FRT write FVL_LIQ_FRT;
    property VL_SEC_CAT: currency read FVL_SEC_CAT write FVL_SEC_CAT;
    property VL_DESP: currency read FVL_DESP write FVL_DESP;
    property VL_PEDG: currency read FVL_PEDG write FVL_PEDG;
    property VL_OUT: currency read FVL_OUT write FVL_OUT;
    property VL_FRT: currency read FVL_FRT write FVL_FRT;
    property UF_ID: string read FUF_ID write FUF_ID;
  end;

  /// Registro D130 - Lista

  TRegistroD130List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD130; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD130); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD130;
    property Items[Index: Integer]: TRegistroD130 read GetItem write SetItem;
  end;

  /// Registro D140 - COMPLEMENTO DO CONHECIMENTO AQUAVI�RIO DE CARGAS (C�DIGO 09)

  TRegistroD140 = class(TPersistent)
  private
    fCOD_PART_CONSG: string;        /// C�digo do participante (campo 02 do Registro 0150):
    fCOD_MUN_ORIG: string;          /// C�digo do munic�pio de origem do servi�o, conforme a tabela IBGE
    fCOD_MUN_DEST: string;          /// C�digo do munic�pio de destino, conforme a tabela IBGE
    fIND_VEIC: string;              /// Indicador do tipo do ve�culo transportador:
    fVEIC_ID: string;               /// Identifica��o da embarca��o (IRIM ou Registro CPP)
    fIND_NAV: string;               /// Indicador do tipo da navega��o:
    fVIAGEM: string;                /// N�mero da viagem
    fVL_FRT_LIQ: currency;          /// Valor l�quido do frete
    fVL_DESP_PORT: currency;        /// Valor das despesas portu�rias
    fVL_DESP_CAR_DESC: currency;    /// Valor das despesas com carga e descarga
    fVL_OUT: currency;              /// Outros valores
    fVL_FRT_BRT: currency;          /// Valor bruto do frete
    fVL_FRT_MM: currency;           /// Valor adicional do frete para renova��o da Marinha Mercante
  public
    property COD_PART_CONSG: string read FCOD_PART_CONSG write FCOD_PART_CONSG;
    property COD_MUN_ORIG: string read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property COD_MUN_DEST: string read FCOD_MUN_DEST write FCOD_MUN_DEST;
    property IND_VEIC: string read FIND_VEIC write FIND_VEIC;
    property VEIC_ID: string read FVEIC_ID write FVEIC_ID;
    property IND_NAV: string read FIND_NAV write FIND_NAV;
    property VIAGEM: string read FVIAGEM write FVIAGEM;
    property VL_FRT_LIQ: currency read FVL_FRT_LIQ write FVL_FRT_LIQ;
    property VL_DESP_PORT: currency read FVL_DESP_PORT write FVL_DESP_PORT;
    property VL_DESP_CAR_DESC: currency read FVL_DESP_CAR_DESC write FVL_DESP_CAR_DESC;
    property VL_OUT: currency read FVL_OUT write FVL_OUT;
    property VL_FRT_BRT: currency read FVL_FRT_BRT write FVL_FRT_BRT;
    property VL_FRT_MM: currency read FVL_FRT_MM write FVL_FRT_MM;
  end;

  /// Registro D140 - Lista

  TRegistroD140List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD140; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD140); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD140;
    property Items[Index: Integer]: TRegistroD140 read GetItem write SetItem;
  end;

  /// Registro D150 - COMPLEMENTO DO CONHECIMENTO A�REO (C�DIGO 10)

  TRegistroD150 = class(TPersistent)
  private
    fCOD_MUN_ORIG: string;    /// C�digo do munic�pio de origem do servi�o, conforme a tabela IBGE
    fCOD_MUN_DEST: string;    /// C�digo do munic�pio de destino, conforme a tabela IBGE
    fVEIC_ID: string;         /// Identifica��o da aeronave (DAC)
    fVIAGEM: string;          /// N�mero do v�o.
    fIND_TFA: string;         /// Indicador do tipo de tarifa aplicada: 0- Exp., 1- Enc., 2- C.I., 9- Outra
    fVL_PESO_TX: currency;    /// Peso taxado
    fVL_TX_TERR: currency;    /// Valor da taxa terrestre
    fVL_TX_RED: currency;     /// Valor da taxa de redespacho
    fVL_OUT: currency;        /// Outros valores
    fVL_TX_ADV: currency;     /// Valor da taxa "ad valorem"
  public
    property COD_MUN_ORIG: string read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property COD_MUN_DEST: string read FCOD_MUN_DEST write FCOD_MUN_DEST;
    property VEIC_ID: string read FVEIC_ID write FVEIC_ID;
    property VIAGEM: string read FVIAGEM write FVIAGEM;
    property IND_TFA: string read FIND_TFA write FIND_TFA;
    property VL_PESO_TX: currency read FVL_PESO_TX write FVL_PESO_TX;
    property VL_TX_TERR: currency read FVL_TX_TERR write FVL_TX_TERR;
    property VL_TX_RED: currency read FVL_TX_RED write FVL_TX_RED;
    property VL_OUT: currency read FVL_OUT write FVL_OUT;
    property VL_TX_ADV: currency read FVL_TX_ADV write FVL_TX_ADV;
  end;

  /// Registro D150 - Lista

  TRegistroD150List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD150; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD150); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD150;
    property Items[Index: Integer]: TRegistroD150 read GetItem write SetItem;
  end;

  /// Registro D160 - CARGA TRANSPORTADA (C�DIGO 07, 08, 09, 10, 11, 26 E 27)

  TRegistroD160 = class(TPersistent)
  private
    fCNPJ_CPF_REM: string;       /// CNPJ ou CPF do remetente das mercadorias que constam na nota fiscal.
    fUF_REM: string;             /// Sigla da unidade da federa��o do remetente das mercadorias que constam na nota fiscal.
    fIE_REM: string;             /// Inscri��o Estadual do remetente das mercadorias que constam na nota fiscal
    fCNPJ_CPF_DEST: string;      /// CNPJ ou CPF do destinat�rio das mercadorias que constam na nota fiscal.
    fUF_DEST: string;            /// Sigla da unidade da federa��o do .destinat�rio das mercadorias que constam na nota fiscal.
    fIE_DEST: string;            /// Inscri��o Estadual do destinat�rio das mercadorias que constam na nota fiscal
    fCOD_MOD: string;            /// C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1
    fSER: string;                /// S�rie do documento fiscal
    fNUM_DOC: string;            /// N�mero do documento fiscal
    fDT_DOC: TDateTime;          /// Data da emiss�o do documento fiscal
    fCHV_NFE: string;            /// Chave da Nota Fiscal Eletr�nica
    fVL_DOC: currency;           /// Valor total do documento fiscal
    fVL_MERC: currency;          /// Valor das mercadorias constantes no documento fiscal
    fQTD_VOL: currency;          /// Quantidade de volumes transportados
    fPESO_BRT: currency;         /// Peso bruto dos volumes transportados (em Kg)
    fPESO_LIQ: currency;         /// Peso l�quido dos volumes transportados (em Kg)
  public
    property CNPJ_CPF_REM: string read FCNPJ_CPF_REM write FCNPJ_CPF_REM;
    property UF_REM: string read FUF_REM write FUF_REM;
    property IE_REM: string read FIE_REM write FIE_REM;
    property CNPJ_CPF_DEST: string read FCNPJ_CPF_DEST write FCNPJ_CPF_DEST;
    property UF_DEST: string read FUF_DEST write FUF_DEST;
    property IE_DEST: string read FIE_DEST write FIE_DEST;
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property SER: string read FSER write FSER;
    property NUM_DOC: string read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property CHV_NFE: string read FCHV_NFE write FCHV_NFE;
    property VL_DOC: currency read FVL_DOC write FVL_DOC;
    property VL_MERC: currency read FVL_MERC write FVL_MERC;
    property QTD_VOL: currency read FQTD_VOL write FQTD_VOL;
    property PESO_BRT: currency read FPESO_BRT write FPESO_BRT;
    property PESO_LIQ: currency read FPESO_LIQ write FPESO_LIQ;
  end;

  /// Registro D160 - Lista

  TRegistroD160List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD160; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD160); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD160;
    property Items[Index: Integer]: TRegistroD160 read GetItem write SetItem;
  end;

  /// Registro D161 - LOCAL DA COLETA E ENTREGA (C�DIGO 07, 08, 09, 10, 11, 26 E 27)

  TRegistroD161 = class(TPersistent)
  private
    fIND_CARGA: string;       /// Indicador do tipo de transporte da carga coletada:
    fCNPJ_COL: string;        /// N�mero do CNPJ do contribuinte do local de coleta
    fIE_COL: string;          /// Inscri��o Estadual do contribuinte do local de coleta
    fCOD_MUN_COL: string;     /// C�digo do Munic�pio do local de coleta, conforme tabela IBGE
    fCNPJ_ENTG: string;       /// N�mero do CNPJ do contribuinte do local de entrega
    fIE_ENTG: string;         /// Inscri��o Estadual do contribuinte do local de entrega
    fCOD_MUN_ENTG: string;    /// C�digo do Munic�pio do local de entrega, conforme tabela IBGE
  public
    property IND_CARGA: string read FIND_CARGA write FIND_CARGA;
    property CNPJ_COL: string read FCNPJ_COL write FCNPJ_COL;
    property IE_COL: string read FIE_COL write FIE_COL;
    property COD_MUN_COL: string read FCOD_MUN_COL write FCOD_MUN_COL;
    property CNPJ_ENTG: string read FCNPJ_ENTG write FCNPJ_ENTG;
    property IE_ENTG: string read FIE_ENTG write FIE_ENTG;
    property COD_MUN_ENTG: string read FCOD_MUN_ENTG write FCOD_MUN_ENTG;
  end;

  /// Registro D161 - Lista

  TRegistroD161List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD161; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD161); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD161;
    property Items[Index: Integer]: TRegistroD161 read GetItem write SetItem;
  end;

  /// Registro D170 - COMPLEMENTO DO CONHECIMENTO MULTIMODAL DE CARGAS (C�DIGO 26)

  TRegistroD170 = class(TPersistent)
  private
    fCOD_PART_CONSG: string;     /// C�digo do participante (campo 02 do Registro 0150):
    fCOD_PART_RED: string;       /// C�digo do participante (campo 02 do Registro 0150):
    fCOD_MUN_ORIG: string;       /// C�digo do munic�pio de origem do servi�o, conforme a tabela IBGE
    fCOD_MUN_DEST: string;       /// C�digo do munic�pio de destino, conforme a tabela IBGE
    fOTM: string;                /// Registro do operador de transporte multimodal
    fIND_NAT_FRT: string;        /// Indicador da natureza do frete:
    fVL_LIQ_FRT: currency;       /// Valor l�quido do frete
    fVL_GRIS: currency;          /// Valor do gris (gerenciamento de risco)
    fVL_PDG: currency;           /// Somat�rio dos valores de ped�gio
    fVL_OUT: currency;           /// Outros valores
    fVL_FRT: currency;           /// Valor total do frete
    fVEIC_ID: string;            /// Placa de identifica��o do ve�culo
    fUF_ID: string;              /// Sigla da UF da placa do ve�culo
  public
    property COD_PART_CONSG: string read FCOD_PART_CONSG write FCOD_PART_CONSG;
    property COD_PART_RED: string read FCOD_PART_RED write FCOD_PART_RED;
    property COD_MUN_ORIG: string read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property COD_MUN_DEST: string read FCOD_MUN_DEST write FCOD_MUN_DEST;
    property OTM: string read FOTM write FOTM;
    property IND_NAT_FRT: string read FIND_NAT_FRT write FIND_NAT_FRT;
    property VL_LIQ_FRT: currency read FVL_LIQ_FRT write FVL_LIQ_FRT;
    property VL_GRIS: currency read FVL_GRIS write FVL_GRIS;
    property VL_PDG: currency read FVL_PDG write FVL_PDG;
    property VL_OUT: currency read FVL_OUT write FVL_OUT;
    property VL_FRT: currency read FVL_FRT write FVL_FRT;
    property VEIC_ID: string read FVEIC_ID write FVEIC_ID;
    property UF_ID: string read FUF_ID write FUF_ID;
  end;

  /// Registro D170 - Lista

  TRegistroD170List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD170; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD170); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD170;
    property Items[Index: Integer]: TRegistroD170 read GetItem write SetItem;
  end;

  /// Registro D180 - MODAIS (C�DIGO 26)

  TRegistroD180 = class(TPersistent)
  private
    fNUM_SEQ: string;            /// N�mero de ordem seq�encial do modal
    fIND_EMIT: string;           /// Indicador do emitente do documento fiscal: 0- Emiss�o pr�pria, 1- Terceiros
    fCNPJ_EMIT: string;          /// CNPJ do participante emitente do modal
    fUF_EMIT: string;            /// Sigla da unidade da federa��o do participante emitente do modal
    fIE_EMIT: string;            /// Inscri��o Estadual do participante emitente do modal
    fCOD_MUN_ORIG: string;       /// C�digo do munic�pio de origem do servi�o, conforme a tabela IBGE
    fCNPJ_CPF_TOM: string;       /// CNPJ/CPF do participante tomador do servi�o
    fUF_TOM: string;             /// Sigla da unidade da federa��o do participante tomador do servi�o
    fIE_TOM: string;             /// Inscri��o Estadual do participante tomador do servi�o
    fCOD_MUN_DEST: string;       /// C�digo do munic�pio de destino, conforme a tabela IBGE(Preencher com 9999999, se Exterior)
    fCOD_MOD: string;            /// C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1
    fSER: string;                /// S�rie do documento fiscal
    fSUB: string;                /// Subs�rie do documento fiscal
    fNUM_DOC: string;            /// N�mero do documento fiscal
    fDT_DOC: TDateTime;          /// Data da emiss�o do documento fiscal
    fVL_DOC: currency;           /// Valor total do documento fiscal
  public
    property NUM_SEQ: string read FNUM_SEQ write FNUM_SEQ;
    property IND_EMIT: string read FIND_EMIT write FIND_EMIT;
    property CNPJ_EMIT: string read FCNPJ_EMIT write FCNPJ_EMIT;
    property UF_EMIT: string read FUF_EMIT write FUF_EMIT;
    property IE_EMIT: string read FIE_EMIT write FIE_EMIT;
    property COD_MUN_ORIG: string read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property CNPJ_CPF_TOM: string read FCNPJ_CPF_TOM write FCNPJ_CPF_TOM;
    property UF_TOM: string read FUF_TOM write FUF_TOM;
    property IE_TOM: string read FIE_TOM write FIE_TOM;
    property COD_MUN_DEST: string read FCOD_MUN_DEST write FCOD_MUN_DEST;
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property SER: string read FSER write FSER;
    property SUB: string read FSUB write FSUB;
    property NUM_DOC: string read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property VL_DOC: currency read FVL_DOC write FVL_DOC;
  end;

  /// Registro D180 - Lista

  TRegistroD180List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD180; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD180); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD180;
    property Items[Index: Integer]: TRegistroD180 read GetItem write SetItem;
  end;

  /// Registro D190 - REGISTRO ANAL�TICO DOS DOCUMENTOS (C�DIGO 07, 08, 09, 10, 11, 26 E 27)

  TRegistroD190 = class(TPersistent)
  private
    fCST_ICMS: string;        /// C�digo da Situa��o Tribut�ria, conforme a tabela indicada no item 4.3.1
    fCFOP: string;            /// C�digo Fiscal de Opera��o e Presta��o, conforme a tabela indicada no item 4.2.2
    fALIQ_ICMS: currency;     /// Al�quota do ICMS
    fVL_OPR: currency;        /// Valor da opera��o correspondente � combina��o de CST_ICMS, CFOP, e al�quota do ICMS.
    fVL_BC_ICMS: currency;    /// Parcela correspondente ao "Valor da base de c�lculo do ICMS" referente � combina��o CST_ICMS, CFOP, e al�quota do ICMS
    fVL_ICMS: currency;       /// Parcela correspondente ao "Valor do ICMS" referente � combina��o CST_ICMS,  CFOP e al�quota do ICMS
    fVL_RED_BC: currency;     /// Valor n�o tributado em fun��o da redu��o da base de c�lculo do ICMS, referente � combina��o de CST_ICMS, CFOP e al�quota do ICMS.
    fCOD_OBS: string;         /// C�digo da observa��o do lan�amento fiscal (campo 02 do Registro 0460)
  public
    property CST_ICMS: string read FCST_ICMS write FCST_ICMS;
    property CFOP: string read FCFOP write FCFOP;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property VL_OPR: currency read FVL_OPR write FVL_OPR;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_RED_BC: currency read FVL_RED_BC write FVL_RED_BC;
    property COD_OBS: string read FCOD_OBS write FCOD_OBS;
  end;

  /// Registro D190 - Lista

  TRegistroD190List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD190; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD190); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD190;
    property Items[Index: Integer]: TRegistroD190 read GetItem write SetItem;
  end;

  /// Registro D300 - REGISTRO ANAL�TICO DOS BILHETES CONSOLIDADOS DE PASSAGEM RODOVI�RIO (C�DIGO 13), DE PASSAGEM AQUAVI�RIO (C�DIGO 14), DE PASSAGEM E NOTA DE BAGAGEM (C�DIGO 15) E DE PASSAGEM FERROVI�RIO (C�DIGO 16)

  TRegistroD300 = class(TPersistent)
  private
    fCOD_MOD: string;         /// C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1
    fSER: string;             /// S�rie do documento fiscal
    fSUB: string;             /// Subs�rie do documento fiscal
    fNUM_DOC_INI: string;     /// N�mero do primeiro documento fiscal emitido (mesmo modelo, s�rie e subs�rie)
    fNUM_DOC_FIN: string;     /// N�mero do �ltimo documento fiscal emitido (mesmo modelo, s�rie e subs�rie)
    fCST_ICMS: string;        /// C�digo da Situa��o Tribut�ria, conforme a Tabela indicada no item 4.3.1
    fCFOP: string;            /// C�digo Fiscal de Opera��o e Presta��o conforme tabela indicada no item 4.2.2
    fALIQ_ICMS: currency;     /// Al�quota do ICMS
    fDT_DOC: TDateTime;       /// Data da emiss�o dos documentos fiscais
    fVL_OPR: currency;        /// Valor total acumulado das opera��es correspondentes � combina��o de CST_ICMS, CFOP e al�quota do ICMS, inclu�das as despesas acess�rias e acr�scimos.
    fVL_DESC: currency;       /// Valor total dos descontos
    fVL_SERV: currency;       /// Valor total da presta��o de servi�o
    fVL_SEG: currency;        /// Valor de seguro
    fVL_OUT_DESP: currency;   /// Valor de outras despesas
    fVL_BC_ICMS: currency;    /// Valor total da base de c�lculo do ICMS
    fVL_ICMS: currency;       /// Valor total do ICMS
    fVL_RED_BC: currency;     /// Valor n�o tributado em fun��o da redu��o da base de c�lculo do ICMS, referente � combina��o de CST_ICMS, CFOP e al�quota do ICMS.
    fCOD_OBS: string;         /// C�digo da observa��o do lan�amento fiscal (campo 02 do Registro 0460)
    fCOD_CTA: string;         /// C�digo da conta anal�tica cont�bil debitada/creditada
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property SER: string read FSER write FSER;
    property SUB: string read FSUB write FSUB;
    property NUM_DOC_INI: string read FNUM_DOC_INI write FNUM_DOC_INI;
    property NUM_DOC_FIN: string read FNUM_DOC_FIN write FNUM_DOC_FIN;
    property CST_ICMS: string read FCST_ICMS write FCST_ICMS;
    property CFOP: string read FCFOP write FCFOP;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property VL_OPR: currency read FVL_OPR write FVL_OPR;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property VL_SEG: currency read FVL_SEG write FVL_SEG;
    property VL_OUT_DESP: currency read FVL_OUT_DESP write FVL_OUT_DESP;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_RED_BC: currency read FVL_RED_BC write FVL_RED_BC;
    property COD_OBS: string read FCOD_OBS write FCOD_OBS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  /// Registro D300 - Lista

  TRegistroD300List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD300; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD300); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD300;
    property Items[Index: Integer]: TRegistroD300 read GetItem write SetItem;
  end;

  /// Registro D301 - DOCUMENTOS CANCELADOS DOS BILHETES DE PASSAGEM RODOVI�RIO (C�DIGO 13), DE PASSAGEM AQUAVI�RIO (C�DIGO 14), DE PASSAGEM E NOTA DE BAGAGEM (C�DIGO 15) E DE PASSAGEM FERROVI�RIO (C�DIGO 16)

  TRegistroD301 = class(TPersistent)
  private
    fNUM_DOC_CANC: string;    /// N�mero do documento fiscal cancelado
  public
    property NUM_DOC_CANC: string read FNUM_DOC_CANC write FNUM_DOC_CANC;
  end;

  /// Registro D301 - Lista

  TRegistroD301List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD301; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD301); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD301;
    property Items[Index: Integer]: TRegistroD301 read GetItem write SetItem;
  end;

  /// Registro D310 - COMPLEMENTO DOS BILHETES (C�DIGO 13, 14, 15 E 16)

  TRegistroD310 = class(TPersistent)
  private
    fCOD_MUN_ORIG: string;    /// C�digo do munic�pio de origem do servi�o, conforme a tabela IBGE
    fVL_SERV: currency;       /// Valor total da presta��o de servi�o
    fVL_BC_ICMS: currency;    /// Valor total da base de c�lculo do ICMS
    fVL_ICMS: currency;       /// Valor total do ICMS
  public
    property COD_MUN_ORIG: string read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
  end;

  /// Registro D310 - Lista

  TRegistroD310List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD310; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD310); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD310;
    property Items[Index: Integer]: TRegistroD310 read GetItem write SetItem;
  end;

  /// Registro D350 - EQUIPAMENTO ECF (C�DIGOS 2E, 13, 14, 15 e 16)

  TRegistroD350 = class(TPersistent)
  private
    fCOD_MOD: string;      /// C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1
    fECF_MOD: string;      /// Modelo do equipamento
    fECF_FAB: string;      /// N�mero de s�rie de fabrica��o do ECF
    fECF_CX: string;       /// N�mero do caixa atribu�do ao ECF
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property ECF_MOD: string read FECF_MOD write FECF_MOD;
    property ECF_FAB: string read FECF_FAB write FECF_FAB;
    property ECF_CX: string read FECF_CX write FECF_CX;
  end;

  /// Registro D350 - Lista

  TRegistroD350List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD350; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD350); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD350;
    property Items[Index: Integer]: TRegistroD350 read GetItem write SetItem;
  end;

  /// Registro D355 - REDU��O Z (C�DIGOS 2E, 13, 14, 15 e 16)

  TRegistroD355 = class(TPersistent)
  private
    fDT_DOC: TDateTime;       /// Data do movimento a que se refere a Redu��o Z
    fCRO: integer;            /// Posi��o do Contador de Rein�cio de Opera��o
    fCRZ: integer;            /// Posi��o do Contador de Redu��o Z
    fNUM_COO_FIN: integer;    /// N�mero do Contador de Ordem de Opera��o do �ltimo documento emitido no dia. (N�mero do COO na Redu��o Z)
    fGT_FIN: currency;        /// Valor do Grande Total final
    fVL_BRT: currency;        /// Valor da venda bruta
  public
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property CRO: integer read FCRO write FCRO;
    property CRZ: integer read FCRZ write FCRZ;
    property NUM_COO_FIN: integer read FNUM_COO_FIN write FNUM_COO_FIN;
    property GT_FIN: currency read FGT_FIN write FGT_FIN;
    property VL_BRT: currency read FVL_BRT write FVL_BRT;
  end;

  /// Registro D355 - Lista

  TRegistroD355List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD355; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD355); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD355;
    property Items[Index: Integer]: TRegistroD355 read GetItem write SetItem;
  end;

  /// Registro D360 - PIS E COFINS TOTALIZADOS NO DIA (C�DIGOS 2E, 13, 14, 15 e 16)

  TRegistroD360 = class(TPersistent)
  private
    fCOD_TOT_PAR: string;        /// C�digo do totalizador, conforme Tabela 4.4.6
    fVLR_ACUM_TOT: currency;     /// Valor acumulado no totalizador, relativo � respectiva Redu��o Z.
    fNR_TOT: string;             /// N�mero do totalizador quando ocorrer mais de uma situa��o com a mesma carga tribut�ria efetiva.
    fDESCR_NR_TOT: string;       /// Descri��o da situa��o tribut�ria relativa ao totalizador parcial, quando houver mais de um com a mesma carga tribut�ria efetiva.
  public
    property COD_TOT_PAR: string read FCOD_TOT_PAR write FCOD_TOT_PAR;
    property VLR_ACUM_TOT: currency read FVLR_ACUM_TOT write FVLR_ACUM_TOT;
    property NR_TOT: string read FNR_TOT write FNR_TOT;
    property DESCR_NR_TOT: string read FDESCR_NR_TOT write FDESCR_NR_TOT;
  end;

  /// Registro D360 - Lista

  TRegistroD360List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD360; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD360); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD360;
    property Items[Index: Integer]: TRegistroD360 read GetItem write SetItem;
  end;

  /// Registro D370 - COMPLEMENTO DOS DOCUMENTOS INFORMADOS (C�DIGO 13, 14, 15, 16 E 2E)

  TRegistroD370 = class(TPersistent)
  private
    fCOD_MUN_ORIG: string;    /// C�digo do munic�pio de origem do servi�o, conforme a tabela IBGE
    fVL_SERV: currency;       /// Valor total da presta��o de servi�o
    fQTD_BILH: currency;      /// Quantidade de bilhetes emitidos
    fVL_BC_ICMS: currency;    /// Valor total da base de c�lculo do ICMS
    fVL_ICMS: currency;       /// Valor total do ICMS
  public
    property COD_MUN_ORIG: string read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property QTD_BILH: currency read FQTD_BILH write FQTD_BILH;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
  end;

  /// Registro D370 - Lista

  TRegistroD370List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD370; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD370); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD370;
    property Items[Index: Integer]: TRegistroD370 read GetItem write SetItem;
  end;

  /// Registro D390 - REGISTRO ANAL�TICO DO MOVIMENTO DI�RIO (C�DIGOS 13, 14, 15, 16 E 2E)

  TRegistroD390 = class(TPersistent)
  private
    fCST_ICMS: string;           /// C�digo da Situa��o Tribut�ria, conforme a Tabela indicada no item 4.3.1.
    fCFOP: string;               /// C�digo Fiscal de Opera��o e Presta��o
    fALIQ_ICMS: currency;        /// Al�quota do ICMS
    fVL_OPR: currency;           /// Valor da opera��o correspondente � combina��o de CST_ICMS, CFOP, e al�quota do ICMS, inclu�das as despesas acess�rias e acr�scimos
    fVL_BC_ISSQN: currency;      /// Valor da base de c�lculo do ISSQN
    fALIQ_ISSQN: currency;       /// Al�quota do ISSQN
    fVL_ISSQN: currency;         /// Valor do ISSQN
    fVL_BC_ICMS: currency;       /// Base de c�lculo do ICMS acumulada relativa � al�quota informada
    fVL_ICMS: currency;          /// Valor do ICMS acumulado relativo � al�quota informada
    fCOD_OBS: string;            /// C�digo da observa��o do lan�amento fiscal (campo 02 do Registro 0460)
  public
    property CST_ICMS: string read FCST_ICMS write FCST_ICMS;
    property CFOP: string read FCFOP write FCFOP;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property VL_OPR: currency read FVL_OPR write FVL_OPR;
    property VL_BC_ISSQN: currency read FVL_BC_ISSQN write FVL_BC_ISSQN;
    property ALIQ_ISSQN: currency read FALIQ_ISSQN write FALIQ_ISSQN;
    property VL_ISSQN: currency read FVL_ISSQN write FVL_ISSQN;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property COD_OBS: string read FCOD_OBS write FCOD_OBS;
  end;

  /// Registro D390 - Lista

  TRegistroD390List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD390; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD390); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD390;
    property Items[Index: Integer]: TRegistroD390 read GetItem write SetItem;
  end;

  /// Registro D400 - RESUMO DE MOVIMENTO DI�RIO (C�DIGO 18)

  TRegistroD400 = class(TPersistent)
  private
    fCOD_PART: string;        /// C�digo do participante (campo 02 do Registro 0150): - ag�ncia, filial ou posto
    fCOD_MOD: string;         /// C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1
    fCOD_SIT: string;         /// C�digo da situa��o do documento fiscal, conforme a Tabela 4.1.2
    fSER: string;             /// S�rie do documento fiscal
    fSUB: string;             /// Subs�rie do documento fiscal
    fNUM_DOC: string;         /// N�mero do documento fiscal resumo.
    fDT_DOC: TDateTime;       /// Data da emiss�o do documento fiscal
    fVL_DOC: currency;        /// Valor total do documento fiscal
    fVL_DESC: currency;       /// Valor acumulado dos descontos
    fVL_SERV: currency;       /// Valor acumulado da presta��o de servi�o
    fVL_BC_ICMS: currency;    /// Valor total da base de c�lculo do ICMS
    fVL_ICMS: currency;       /// Valor total do ICMS
    fVL_PIS: currency;        /// Valor do PIS
    fVL_COFINS: currency;     /// Valor da COFINS
    fCOD_CTA: string;         /// C�digo da conta anal�tica cont�bil debitada/creditada
  public
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_SIT: string read FCOD_SIT write FCOD_SIT;
    property SER: string read FSER write FSER;
    property SUB: string read FSUB write FSUB;
    property NUM_DOC: string read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property VL_DOC: currency read FVL_DOC write FVL_DOC;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  /// Registro D400 - Lista

  TRegistroD400List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD400; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD400); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD400;
    property Items[Index: Integer]: TRegistroD400 read GetItem write SetItem;
  end;

  /// Registro D410 - DOCUMENTOS INFORMADOS (C�DIGOS 13, 14, 15 E 16)

  TRegistroD410 = class(TPersistent)
  private
    fCOD_MOD: string;         /// C�digo do modelo do documento fiscal , conforme a Tabela 4.1.1
    fSER: string;             /// S�rie do documento fiscal
    fSUB: string;             /// Subs�rie do documento fiscal
    fNUM_DOC_INI: string;     /// N�mero do documento fiscal inicial (mesmo modelo, s�rie e subs�rie)
    fNUM_DOC_FIN: string;     /// N�mero do documento fiscal final(mesmo modelo, s�rie e subs�rie)
    fDT_DOC: TDateTime;       /// Data da emiss�o dos documentos fiscais
    fCST_ICMS: string;        /// C�digo da Situa��o Tribut�ria, conforme a Tabela indicada no item 4.3.1
    fCFOP: string;            /// C�digo Fiscal de Opera��o e Presta��o
    fALIQ_ICMS: currency;     /// Al�quota do ICMS
    fVL_OPR: currency;        /// Valor total acumulado das opera��es correspondentes � combina��o de CST_ICMS, CFOP e al�quota do ICMS, inclu�das as despesas acess�rias e acr�scimos.
    fVL_DESC: currency;       /// Valor acumulado dos descontos
    fVL_SERV: currency;       /// Valor acumulado da presta��o de servi�o
    fVL_BC_ICMS: currency;    /// Valor acumulado da base de c�lculo do ICMS
    fVL_ICMS: currency;       /// Valor acumulado do ICMS
  public
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property SER: string read FSER write FSER;
    property SUB: string read FSUB write FSUB;
    property NUM_DOC_INI: string read FNUM_DOC_INI write FNUM_DOC_INI;
    property NUM_DOC_FIN: string read FNUM_DOC_FIN write FNUM_DOC_FIN;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property CST_ICMS: string read FCST_ICMS write FCST_ICMS;
    property CFOP: string read FCFOP write FCFOP;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;
    property VL_OPR: currency read FVL_OPR write FVL_OPR;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
  end;

  /// Registro D410 - Lista

  TRegistroD410List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD410; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD410); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD410;
    property Items[Index: Integer]: TRegistroD410 read GetItem write SetItem;
  end;

  /// Registro D411 - DOCUMENTOS CANCELADOS DOS DOCUMENTOS INFORMADOS (C�DIGOS 13, 14, 15 E 16)

  TRegistroD411 = class(TPersistent)
  private
    fNUM_DOC_CANC: string;    /// N�mero do documento fiscal cancelado
  public
    property NUM_DOC_CANC: string read FNUM_DOC_CANC write FNUM_DOC_CANC;
  end;

  /// Registro D411 - Lista

  TRegistroD411List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD411; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD411); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD411;
    property Items[Index: Integer]: TRegistroD411 read GetItem write SetItem;
  end;

  /// Registro D420 - COMPLEMENTO DOS DOCUMENTOS INFORMADOS(C�DIGOS 13, 14, 15 E 16)

  TRegistroD420 = class(TPersistent)
  private
    fCOD_MUN_ORIG: string;    /// C�digo do munic�pio de origem do servi�o, conforme a tabela IBGE
    fVL_SERV: currency;       /// Valor total da presta��o de servi�o
    fVL_BC_ICMS: currency;    /// Valor total da base de c�lculo do ICMS
    fVL_ICMS: currency;       /// Valor total do ICMS
  public
    property COD_MUN_ORIG: string read FCOD_MUN_ORIG write FCOD_MUN_ORIG;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
  end;

  /// Registro D420 - Lista

  TRegistroD420List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD420; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD420); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD420;
    property Items[Index: Integer]: TRegistroD420 read GetItem write SetItem;
  end;

  /// Registro D500 - NOTA FISCAL DE SERVI�O DE COMUNICA��O (C�DIGO 21) E NOTA FISCAL DE SERVI�O DE TELECOMUNICA��O (C�DIGO 22)

  TRegistroD500 = class(TPersistent)
  private
    fIND_OPER: string;        /// Indicador do tipo de opera��o: 0- Aquisi��o, 1- Presta��o
    fIND_EMIT: string;        /// Indicador do emitente do documento fiscal: 0- Emiss�o pr�pria, 1- Terceiros
    fCOD_PART: string;        /// C�digo do participante (campo 02 do Registro 0150): - do prestador do servi�o, no caso de aquisi��o, - do tomador do servi�o, no caso de presta��o.
    fCOD_MOD: string;         /// C�digo do modelo do documento fiscal, conforme a Tabela 4.1.1
    fCOD_SIT: string;         /// ��digo da situa��o do documento fiscal, conforme a Tabela 4.1.2
    fSER: string;             /// S�rie do documento fiscal
    fSUB: string;             /// Subs�rie do documento fiscal
    fNUM_DOC: string;         /// N�mero do documento fiscal
    fDT_DOC: TDateTime;       /// Data da emiss�o do documento fiscal
    fDT_A_P: TDateTime;       /// Data da entrada (aquisi��o) ou da sa�da (presta��o do servi�o)
    fVL_DOC: currency;        /// Valor total do documento fiscal
    fVL_DESC: currency;       /// Valor total do desconto
    fVL_SERV: currency;       /// Valor da presta��o de servi�os
    fVL_SERV_NT: currency;    /// Valor total dos servi�os n�o-tributados pelo ICMS
    fVL_TERC: currency;       /// Valores cobrados em nome de terceiros
    fVL_DA: currency;         /// Valor de outras despesas indicadas no documento fiscal
    fVL_BC_ICMS: currency;    /// Valor da base de c�lculo do ICMS
    fVL_ICMS: currency;       /// Valor do ICMS
    fCOD_INF: string;         /// C�digo da informa��o complementar (campo 02 do Registro 0450)
    fVL_PIS: currency;        /// Valor do PIS
    fVL_COFINS: currency;     /// Valor da COFINS
    fCOD_CTA: string;         /// C�digo da conta anal�tica cont�bil debitada/creditada
  public
    property IND_OPER: string read FIND_OPER write FIND_OPER;
    property IND_EMIT: string read FIND_EMIT write FIND_EMIT;
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property COD_MOD: string read FCOD_MOD write FCOD_MOD;
    property COD_SIT: string read FCOD_SIT write FCOD_SIT;
    property SER: string read FSER write FSER;
    property SUB: string read FSUB write FSUB;
    property NUM_DOC: string read FNUM_DOC write FNUM_DOC;
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    property DT_A_P: TDateTime read FDT_A_P write FDT_A_P;
    property VL_DOC: currency read FVL_DOC write FVL_DOC;
    property VL_DESC: currency read FVL_DESC write FVL_DESC;
    property VL_SERV: currency read FVL_SERV write FVL_SERV;
    property VL_SERV_NT: currency read FVL_SERV_NT write FVL_SERV_NT;
    property VL_TERC: currency read FVL_TERC write FVL_TERC;
    property VL_DA: currency read FVL_DA write FVL_DA;
    property VL_BC_ICMS: currency read FVL_BC_ICMS write FVL_BC_ICMS;
    property VL_ICMS: currency read FVL_ICMS write FVL_ICMS;
    property COD_INF: string read FCOD_INF write FCOD_INF;
    property VL_PIS: currency read FVL_PIS write FVL_PIS;
    property VL_COFINS: currency read FVL_COFINS write FVL_COFINS;
    property COD_CTA: string read FCOD_CTA write FCOD_CTA;
  end;

  /// Registro D500 - Lista

  TRegistroD500List = class(TList)
  private
    function GetItem(Index: Integer): TRegistroD500; /// GetItem
    procedure SetItem(Index: Integer; const Value: TRegistroD500); /// SetItem
  public
    destructor Destroy; override;
    function New: TRegistroD500;
    property Items[Index: Integer]: TRegistroD500 read GetItem write SetItem;
  end;

  /// Registro D990 - ENCERRAMENTO DO BLOCO D

  TRegistroD990 = class(TPersistent)
  private
    fQTD_LIN_D: Integer; /// Quantidade total de linhas do Bloco D
  public
    property QTD_LIN_D: Integer read fQTD_LIN_D write fQTD_LIN_D;
  end;

implementation

{ TRegistroD001 }

{ TRegistroD100List }

destructor TRegistroD100List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD100List.GetItem(Index: Integer): TRegistroD100;
begin
  Result := Items[Index];
end;

function TRegistroD100List.New: TRegistroD100;
begin
  Result := TRegistroD100.Create;
  Add(Result);
end;

procedure TRegistroD100List.SetItem(Index: Integer; const Value: TRegistroD100);
begin
  Put(Index, Value);
end;

{ TRegistroD110List }

destructor TRegistroD110List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD110List.GetItem(Index: Integer): TRegistroD110;
begin
  Result := Items[Index];
end;

function TRegistroD110List.New: TRegistroD110;
begin
  Result := TRegistroD110.Create;
  Add(Result);
end;

procedure TRegistroD110List.SetItem(Index: Integer; const Value: TRegistroD110);
begin
  Put(Index, Value);
end;

{ TRegistroD120List }

destructor TRegistroD120List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD120List.GetItem(Index: Integer): TRegistroD120;
begin
  Result := Items[Index];
end;

function TRegistroD120List.New: TRegistroD120;
begin
  Result := TRegistroD120.Create;
  Add(Result);
end;

procedure TRegistroD120List.SetItem(Index: Integer; const Value: TRegistroD120);
begin
  Put(Index, Value);
end;

{ TRegistroD130List }

destructor TRegistroD130List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD130List.GetItem(Index: Integer): TRegistroD130;
begin
  Result := Items[Index];
end;

function TRegistroD130List.New: TRegistroD130;
begin
  Result := TRegistroD130.Create;
  Add(Result);
end;

procedure TRegistroD130List.SetItem(Index: Integer; const Value: TRegistroD130);
begin
  Put(Index, Value);
end;

{ TRegistroD140List }

destructor TRegistroD140List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD140List.GetItem(Index: Integer): TRegistroD140;
begin
  Result := Items[Index];
end;

function TRegistroD140List.New: TRegistroD140;
begin
  Result := TRegistroD140.Create;
  Add(Result);
end;

procedure TRegistroD140List.SetItem(Index: Integer; const Value: TRegistroD140);
begin
  Put(Index, Value);
end;

{ TRegistroD150List }

destructor TRegistroD150List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD150List.GetItem(Index: Integer): TRegistroD150;
begin
  Result := Items[Index];
end;

function TRegistroD150List.New: TRegistroD150;
begin
  Result := TRegistroD150.Create;
  Add(Result);
end;

procedure TRegistroD150List.SetItem(Index: Integer; const Value: TRegistroD150);
begin
  Put(Index, Value);
end;

{ TRegistroD160List }

destructor TRegistroD160List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD160List.GetItem(Index: Integer): TRegistroD160;
begin
  Result := Items[Index];
end;

function TRegistroD160List.New: TRegistroD160;
begin
  Result := TRegistroD160.Create;
  Add(Result);
end;

procedure TRegistroD160List.SetItem(Index: Integer; const Value: TRegistroD160);
begin
  Put(Index, Value);
end;

{ TRegistroD161List }

destructor TRegistroD161List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD161List.GetItem(Index: Integer): TRegistroD161;
begin
  Result := Items[Index];
end;

function TRegistroD161List.New: TRegistroD161;
begin
  Result := TRegistroD161.Create;
  Add(Result);
end;

procedure TRegistroD161List.SetItem(Index: Integer; const Value: TRegistroD161);
begin
  Put(Index, Value);
end;

{ TRegistroD170List }

destructor TRegistroD170List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD170List.GetItem(Index: Integer): TRegistroD170;
begin
  Result := Items[Index];
end;

function TRegistroD170List.New: TRegistroD170;
begin
  Result := TRegistroD170.Create;
  Add(Result);
end;

procedure TRegistroD170List.SetItem(Index: Integer; const Value: TRegistroD170);
begin
  Put(Index, Value);
end;

{ TRegistroD180List }

destructor TRegistroD180List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD180List.GetItem(Index: Integer): TRegistroD180;
begin
  Result := Items[Index];
end;

function TRegistroD180List.New: TRegistroD180;
begin
  Result := TRegistroD180.Create;
  Add(Result);
end;

procedure TRegistroD180List.SetItem(Index: Integer; const Value: TRegistroD180);
begin
  Put(Index, Value);
end;

{ TRegistroD190List }

destructor TRegistroD190List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD190List.GetItem(Index: Integer): TRegistroD190;
begin
  Result := Items[Index];
end;

function TRegistroD190List.New: TRegistroD190;
begin
  Result := TRegistroD190.Create;
  Add(Result);
end;

procedure TRegistroD190List.SetItem(Index: Integer; const Value: TRegistroD190);
begin
  Put(Index, Value);
end;

{ TRegistroD300List }

destructor TRegistroD300List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD300List.GetItem(Index: Integer): TRegistroD300;
begin
  Result := Items[Index];
end;

function TRegistroD300List.New: TRegistroD300;
begin
  Result := TRegistroD300.Create;
  Add(Result);
end;

procedure TRegistroD300List.SetItem(Index: Integer; const Value: TRegistroD300);
begin
  Put(Index, Value);
end;

{ TRegistroD301List }

destructor TRegistroD301List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD301List.GetItem(Index: Integer): TRegistroD301;
begin
  Result := Items[Index];
end;

function TRegistroD301List.New: TRegistroD301;
begin
  Result := TRegistroD301.Create;
  Add(Result);
end;

procedure TRegistroD301List.SetItem(Index: Integer; const Value: TRegistroD301);
begin
  Put(Index, Value);
end;

{ TRegistroD310List }

destructor TRegistroD310List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD310List.GetItem(Index: Integer): TRegistroD310;
begin
  Result := Items[Index];
end;

function TRegistroD310List.New: TRegistroD310;
begin
  Result := TRegistroD310.Create;
  Add(Result);
end;

procedure TRegistroD310List.SetItem(Index: Integer; const Value: TRegistroD310);
begin
  Put(Index, Value);
end;

{ TRegistroD350List }

destructor TRegistroD350List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD350List.GetItem(Index: Integer): TRegistroD350;
begin
  Result := Items[Index];
end;

function TRegistroD350List.New: TRegistroD350;
begin
  Result := TRegistroD350.Create;
  Add(Result);
end;

procedure TRegistroD350List.SetItem(Index: Integer; const Value: TRegistroD350);
begin
  Put(Index, Value);
end;

{ TRegistroD355List }

destructor TRegistroD355List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD355List.GetItem(Index: Integer): TRegistroD355;
begin
  Result := Items[Index];
end;

function TRegistroD355List.New: TRegistroD355;
begin
  Result := TRegistroD355.Create;
  Add(Result);
end;

procedure TRegistroD355List.SetItem(Index: Integer; const Value: TRegistroD355);
begin
  Put(Index, Value);
end;

{ TRegistroD360List }

destructor TRegistroD360List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD360List.GetItem(Index: Integer): TRegistroD360;
begin
  Result := Items[Index];
end;

function TRegistroD360List.New: TRegistroD360;
begin
  Result := TRegistroD360.Create;
  Add(Result);
end;

procedure TRegistroD360List.SetItem(Index: Integer; const Value: TRegistroD360);
begin
  Put(Index, Value);
end;

{ TRegistroD370List }

destructor TRegistroD370List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD370List.GetItem(Index: Integer): TRegistroD370;
begin
  Result := Items[Index];
end;

function TRegistroD370List.New: TRegistroD370;
begin
  Result := TRegistroD370.Create;
  Add(Result);
end;

procedure TRegistroD370List.SetItem(Index: Integer; const Value: TRegistroD370);
begin
  Put(Index, Value);
end;

{ TRegistroD390List }

destructor TRegistroD390List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD390List.GetItem(Index: Integer): TRegistroD390;
begin
  Result := Items[Index];
end;

function TRegistroD390List.New: TRegistroD390;
begin
  Result := TRegistroD390.Create;
  Add(Result);
end;

procedure TRegistroD390List.SetItem(Index: Integer; const Value: TRegistroD390);
begin
  Put(Index, Value);
end;

{ TRegistroD400List }

destructor TRegistroD400List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD400List.GetItem(Index: Integer): TRegistroD400;
begin
  Result := Items[Index];
end;

function TRegistroD400List.New: TRegistroD400;
begin
  Result := TRegistroD400.Create;
  Add(Result);
end;

procedure TRegistroD400List.SetItem(Index: Integer; const Value: TRegistroD400);
begin
  Put(Index, Value);
end;

{ TRegistroD410List }

destructor TRegistroD410List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD410List.GetItem(Index: Integer): TRegistroD410;
begin
  Result := Items[Index];
end;

function TRegistroD410List.New: TRegistroD410;
begin
  Result := TRegistroD410.Create;
  Add(Result);
end;

procedure TRegistroD410List.SetItem(Index: Integer; const Value: TRegistroD410);
begin
  Put(Index, Value);
end;

{ TRegistroD411List }

destructor TRegistroD411List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD411List.GetItem(Index: Integer): TRegistroD411;
begin
  Result := Items[Index];
end;

function TRegistroD411List.New: TRegistroD411;
begin
  Result := TRegistroD411.Create;
  Add(Result);
end;

procedure TRegistroD411List.SetItem(Index: Integer; const Value: TRegistroD411);
begin
  Put(Index, Value);
end;

{ TRegistroD420List }

destructor TRegistroD420List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD420List.GetItem(Index: Integer): TRegistroD420;
begin
  Result := Items[Index];
end;

function TRegistroD420List.New: TRegistroD420;
begin
  Result := TRegistroD420.Create;
  Add(Result);
end;

procedure TRegistroD420List.SetItem(Index: Integer; const Value: TRegistroD420);
begin
  Put(Index, Value);
end;

{ TRegistroD500List }

destructor TRegistroD500List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistroD500List.GetItem(Index: Integer): TRegistroD500;
begin
  Result := Items[Index];
end;

function TRegistroD500List.New: TRegistroD500;
begin
  Result := TRegistroD500.Create;
  Add(Result);
end;

procedure TRegistroD500List.SetItem(Index: Integer; const Value: TRegistroD500);
begin
  Put(Index, Value);
end;

end.
