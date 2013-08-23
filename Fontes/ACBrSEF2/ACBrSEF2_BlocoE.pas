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
|*  - Distribuição da Primeira Versao
*******************************************************************************}

unit ACBrSEF2_BlocoE;

interface

Uses Classes, Contnrs, SysUtils, ACBrSEF2Conversao;

type
  TRegistroSEFE003List = class;
  TRegistroSEFE020List = class;
  TRegistroSEFE025List = class;
  TRegistroSEFE050List = class;
  TRegistroSEFE055List = class;
  TRegistroSEFE060List = class;
  TRegistroSEFE065List = class;
  TRegistroSEFE080List = class;
  TRegistroSEFE085List = class;
  TRegistroSEFE300List = class;
  TRegistroSEFE305List = class;

 //LINHA E001: ABERTURA DO BLOCO E
  TRegistroSEFE001 = class(TOpenBlocos)
  private
    fIND_DAD: TSEFIIIndicadorConteudo;
    fRegistroE003: TRegistroSEFE003List;
    fRegistroE020: TRegistroSEFE020List;
    fRegistroE050: TRegistroSEFE050List;
    fRegistroE060: TRegistroSEFE060List;
    fRegistroE080: TRegistroSEFE080List;
    fRegistroE300: TRegistroSEFE300List;
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy
    property IND_DAD : TSEFIIIndicadorConteudo  read fIND_DAD write fIND_DAD;
    property RegistroE003: TRegistroSEFE003List read fRegistroE003 write fRegistroE003;
    property RegistroE020: TRegistroSEFE020List read fRegistroE020 write fRegistroE020;
    property RegistroE050: TRegistroSEFE050List read fRegistroE050 write fRegistroE050;
    property RegistroE060: TRegistroSEFE060List read fRegistroE060 write fRegistroE060;
    property RegistroE080: TRegistroSEFE080List read fRegistroE080 write fRegistroE080;
    property RegistroE300: TRegistroSEFE300List read fRegistroE300 write fRegistroE300;
  end;

  TRegistroSEFE003 = class
  private
    fUF       : String;
    fLIN_MON  : String;
    fCAMPO_INI: Integer;
    fQTD_CAMPO: Integer;
  public
    constructor Create(AOwner: TRegistroSEFE001); virtual; /// Create
    property UF        : String  read	fUF        write fUF;        // Sigla da unidade da Federação do domicílio fiscal do contribuinte	C	2	-
    property LIN_MON   : String  read	fLIN_MON   write fLIN_MON;   // Texto fixo contendo: "E025"; "E055"; "E065"; "E085"; "E310"; "E350"
    property CAMPO_INI : Integer read fCAMPO_INI write fCAMPO_INI; // Texto fixo contendo "16", para LIN_NOM = "E025"; "09", para LIN_NOM = "E055"; "10", para LIN_NOM = "E065"; "06", para LIN_NOM = "E085"; "11", para LIN_NOM = "E105"; "10", para LIN_NOM = "E310"; "10", para LIN_NOM = "E350"
    property QTD_CAMPO : Integer read	fQTD_CAMPO write fQTD_CAMPO; // Texto fixo contendo "2", para LIN_NOM = "E025"; "1", para LIN_NOM = "E055"; "1", para LIN_NOM = "E065"; "1", para LIN_NOM = "E085"; "1", para LIN_NOM = "E105"; "1", para LIN_NOM = "E310"; "1", para LIN_NOM = "E350"
  end;

  TRegistroSEFE003List = class(TACBrSEFIIRegistros)
  private
    function GetItem(Index: Integer): TRegistroSEFE003;
    procedure SetItem(Index: Integer; const Value: TRegistroSEFE003);
  public
    function New(AOwner: TRegistroSEFE001): TRegistroSEFE003;
    property Items[Index: Integer]: TRegistroSEFE003 read GetItem write SetItem;
  end;

 //LINHA E020: LANÇAMENTO - NOTA FISCAL (CÓDIGO 01), NOTA FISCAL DE PRODUTOR (CÓDIGO 04) E NOTA FISCAL ELETRÔNICA (CÓDIGO 55)
  TRegistroSEFE020 = class
  private
    fCOD_PART    : Integer;
    fNUM_DOC     : Integer;
    fCOD_NAT     : Integer;
    fSER         : String;
    fCHV_NFE     : String;
    fCOP         : String;
    fNUM_LCTO    : String;
    fCOD_INF_OBS : String;
    fDT_EMIS     : TDateTime;
    fDT_DOC      : TDateTime;
    fVL_CONT     : Double;
    fVL_OP_ISS   : Double;
    fVL_BC_ICMS  : Double;
    fVL_ICMS     : Double;
    fVL_ICMS_ST  : Double;
    fVL_ST_E     : Double;
    fVL_ST_S     : Double;
    fVL_AT       : Double;
    fVL_ISNT_ICMS: Double;
    fVL_OUT_ICMS : Double;
    fVL_BC_IPI   : Double;
    fVL_IPI      : Double;
    fVL_ISNT_IPI : Double;
    fVL_OUT_IPI  : Double;
    fIND_PGTO    : TIndicePagamento;
    fCOD_SIT     : TCodigoSituacao;
    fIND_OPER    : TIndiceOperacao;
    fIND_EMIT    : TIndiceEmissao;
    fCOD_MOD     : TSEFIIDocFiscalReferenciado;
    fRegistroE025: TRegistroSEFE025List;

    function GetCOP: String;
  public
    constructor Create(AOwner: TRegistroSEFE001); virtual;
    destructor Destroy; override;

    property IND_OPER   : TIndiceOperacao  read	fIND_OPER write fIND_OPER;           //Indicador de operação: 0- Entrada ou aquisição1- Saída ou prestação
    property IND_EMIT   : TIndiceEmissao   read	fIND_EMIT write fIND_EMIT;           // Indicador do emitente do documento fiscal: 0- Emissão própria 1- Emissão por terceiros
    property COD_MOD    : TSEFIIDocFiscalReferenciado read	fCOD_MOD write fCOD_MOD; // Código do modelo do documento fiscal, conforme a tabela indicada no item 4.1.1
    property COD_SIT    : TCodigoSituacao  read	fCOD_SIT  write fCOD_SIT;            // Código da situação do lançamento, conforme a tabela indicada no item 4.1.3
    property IND_PGTO   : TIndicePagamento read	fIND_PGTO write fIND_PGTO;           // Indicador do pagamento: 0- Operação à vista 1- Operação a prazo 2- Operação não onerosa
    property COD_PART   : Integer	read  fCOD_PART     write fCOD_PART;               // Código do participante (campo 02 da Linha 0150): - do emitente do documento ou do remetente das mercadorias, no caso de entradas - do adquirente, no caso de saídas
    property COD_NAT    : Integer read	fCOD_NAT      write fCOD_NAT;                // Código da natureza da operação ou prestação (campo 02 da Linha 0400)
    property NUM_DOC    : Integer read	fNUM_DOC      write fNUM_DOC;                // Número do documento fiscal
    property SER        : String  read	fSER          write fSER;                    // Série do documento fiscal
    property CHV_NFE    : String  read	fCHV_NFE      write fCHV_NFE;                // Chave de acesso da Nota Fiscal Eletrônica (NF-e, modelo 55)
    property COP        : String  read	GetCOP        write fCOP;                    // Código da classe da operação ou prestação, conforme a tabela indicada no item 4.2.2.1
    property NUM_LCTO   : String  read	fNUM_LCTO     write fNUM_LCTO;               // Número ou código de identificação única do lançamento contábil
    property COD_INF_OBS: String  read	fCOD_INF_OBS  write fCOD_INF_OBS;            // Código de referência à observação (campo 02 da Linha 0450)
    property DT_EMIS    : TDateTime read	fDT_EMIS    write fDT_EMIS;                // DATA DE EMISSAO
    property DT_DOC     : TDateTime read	fDT_DOC     write fDT_DOC;                 // Na entrada ou aquisição: data da entrada da mercadoria, da aquisição do serviço ou do desembaraço aduaneiro; na saída ou prestação: data da emissão do documento fiscal
    property VL_CONT    : Double  read	fVL_CONT      write fVL_CONT;                // Valor contábil (valor do documento)
    property VL_OP_ISS  : Double  read	fVL_OP_ISS    write fVL_OP_ISS;              // Valor da operação tributado pelo ISS
    property VL_BC_ICMS : Double  read	fVL_BC_ICMS   write fVL_BC_ICMS;             // Valor da base de cálculo do ICMS
    property VL_ICMS    : Double  read	fVL_ICMS      write fVL_ICMS;                // Valor do ICMS creditado/debitado
    property VL_ICMS_ST : Double  read	fVL_ICMS_ST   write fVL_ICMS_ST;             // Valor original do ICMS da substituição tributária registrado no documento
    property VL_ST_E    : Double  read	fVL_ST_E      write fVL_ST_E;                // Valor do ICMS da substituição tributária creditado: - devido pelo alienante na operação de entrada, registrado em documento de emissão própria - retido pelo alienante na operação de entrada, registrado em documento emitido por terceiro
    property VL_ST_S    : Double  read	fVL_ST_S      write fVL_ST_S;                // Valor do ICMS da substituição tributária devido pelo alienante: - registrado na operação de saída interna - registrado na operação de saída interestadual
    property VL_AT       : Double read	fVL_AT        write fVL_AT;                  // Valor do ICMS creditado na operação de entrada: - relativamente à antecipação tributária do diferencial de alíquotas na operação de aquisição de mercadorias - relativamente à antecipação tributária do diferencial de alíquotas na operação de aquisição de material para ativo fixo - relativamente à antecipação tributária do diferencial de alíquotas na operação de aquisição de material para uso ou consumo - relativamente à antecipação tributária conforme definições da legislação específica (descrever em observações)
    property VL_ISNT_ICMS: Double read	fVL_ISNT_ICMS write fVL_ISNT_ICMS;           // Valor das operações isentas ou não-tributadas pelo ICMS
    property VL_OUT_ICMS: Double  read	fVL_OUT_ICMS  write fVL_OUT_ICMS;            // Valor das outras operações do ICMS
    property VL_BC_IPI  : Double  read	fVL_BC_IPI    write fVL_BC_IPI;              // Valor da base de cálculo do IPI
    property VL_IPI     : Double  read	fVL_IPI       write fVL_IPI;                 // Valor do IPI creditado/debitado
    property VL_ISNT_IPI: Double  read	fVL_ISNT_IPI  write fVL_ISNT_IPI;            // Valor das operações isentas ou não-tributadas pelo IPI
    property VL_OUT_IPI : Double  read	fVL_OUT_IPI   write fVL_OUT_IPI;             // Valor das outras operações do IPI

    property RegistroE025: TRegistroSEFE025List read fRegistroE025 write fRegistroE025;
  end;

  TRegistroSEFE020List = class(TACBrSEFIIRegistros)
  private
    function GetItem(Index: Integer): TRegistroSEFE020;
    procedure SetItem(Index: Integer; const Value: TRegistroSEFE020);
  public
    function New(AOwner: TRegistroSEFE001): TRegistroSEFE020;
    property Itens[Index: Integer]: TRegistroSEFE020 read GetItem write SetItem;
  end;

  TRegistroSEFE025 = class
  private
    fVL_CONT_P     : Double;
    fVL_OP_ISS_P   : Double ;
    fVL_BC_ICMS_P  : Double;
    fALIQ_ICMS     : Double;
    fVL_ICMS_P     : Double;
    fVL_BC_ST_P    : Double;
    fVL_ICMS_ST_P  : Double;
    fVL_OUT_ICMS_P : Double;
    fVL_BC_IPI_P   : Double;
    fVL_IPI_P      : Double;
    fVL_ISNT_IPI_P : Double;
    fVL_OUT_IPI_P  : Double;
    fVL_ISNT_ICMS_P: Double;
    fCFOP          : Integer;
    fIND_PETR      : Integer;
    fIND_IMUN      : Integer;
  public
    constructor Create(AOwner: TRegistroSEFE020); virtual; /// Create
    property VL_CONT_P     : Double  read	fVL_CONT_P      write fVL_CONT_P;      // Valor (CFOP/Alíquota)
    property VL_OP_ISS_P   : Double  read	fVL_OP_ISS_P    write fVL_OP_ISS_P;    // Valor da operação tributado pelo ISS, rateado por CFOP e alíquota
    property VL_BC_ICMS_P  : Double  read	fVL_BC_ICMS_P   write fVL_BC_ICMS_P;   // Código do modelo do documento fiscal, conforme a tabela indicada no item 4.1.1
    property ALIQ_ICMS     : Double  read	fALIQ_ICMS      write fALIQ_ICMS;      // Alíquota do ICMS
    property VL_ICMS_P     : Double  read	fVL_ICMS_P      write fVL_ICMS_P;      // Valor do ICMS consolidado por CFOP e alíquota
    property VL_BC_ST_P    : Double  read	fVL_BC_ST_P     write fVL_BC_ST_P;     // Valor da base de cálculo do ICMS  da substituição tributária consolidado por CFOP e alíquota
    property VL_ICMS_ST_P  : Double  read	fVL_ICMS_ST_P   write fVL_ICMS_ST_P;   // Valor das operações isentas ou não-tributadas pelo ICMS, rateado por CFOP e alíquota
    property VL_ISNT_ICMS_P: Double  read fVL_ISNT_ICMS_P write fVL_ISNT_ICMS_P;
    property VL_OUT_ICMS_P : Double  read	fVL_OUT_ICMS_P  write fVL_OUT_ICMS_P;  // Valor das outras operações do ICMS, rateado por CFOP e alíquota
    property VL_BC_IPI_P   : Double  read	fVL_BC_IPI_P    write fVL_BC_IPI_P;    // Valor da base de cálculo do IPI, rateado por CFOP e alíquota
    property VL_IPI_P      : Double  read	fVL_IPI_P       write fVL_IPI_P;       // Valor do IPI, rateado por CFOP e alíquota
    property VL_ISNT_IPI_P : Double  read	fVL_ISNT_IPI_P  write fVL_ISNT_IPI_P;  // Valor das operações isentas ou não-tributadas pelo IPI, rateado por CFOP e alíquota
    property VL_OUT_IPI_P  : Double  read	fVL_OUT_IPI_P   write fVL_OUT_IPI_P;   // Valor das outras operações do IPI, rateado por CFOP e alíquota
    property CFOP          : Integer read fCFOP           write fCFOP;           // Código Fiscal de Operações e Prestações, conforme a tabela externa indicada no item 3.3.1
    property IND_PETR      : Integer read	fIND_PETR       write fIND_PETR;       // Indicador da operação: 0- Sem envolver combustível ou lubrificante 1- Envolvendo combustível ou lubrificante derivado de petróleo 2- Envolvendo combustível ou lubrificante não-derivado de petróleo
    property IND_IMUN      : Integer read	fIND_IMUN       write fIND_IMUN;       // Indicador da operação: 0- Sem envolver item imune do ICMS ou IPI  1- Envolvendo livro, jornal, periódico ou com o papel destinado à impressão destes (imunes do ICMS e do IPI) 2- Envolvendo mineral (imune do IPI)
  end;

  TRegistroSEFE025List = class(TACBrSEFIIRegistros)
  private
    function GetNotas(Index: Integer): TRegistroSEFE025;
    procedure SetNotas(Index: Integer; const Value: TRegistroSEFE025);
  public
    function New(AOwner: TRegistroSEFE020): TRegistroSEFE025;
    property notas[Index: Integer]: TRegistroSEFE025 read Getnotas write SetNotas;
  end;

  //  LINHA E050: LANÇAMENTO - NOTA FISCAL DE VENDA A CONSUMIDOR (CÓDIGO 02)
  TRegistroSEFE050 = class
  private
    fCOD_MOD     : String;
    fSER         : String;
    fNUM_LCTO    : String;
    fCOD_INF_OBS : String;
    fQTD_CANC    : Integer;
    fSUB         : Integer;
    fNUM_DOC_INI : Integer;
    fNUM_DOC_FIN : Integer;
    fDT_DOC      : Integer;
    fCOP         : Integer;
    fVL_CONT     : Double;
    fVL_BC_ICMS  : Double;
    fVL_ICMS     : Double;
    fVL_ISNT_ICMS: Double;
    fVL_OUT_ICMS : Double;
    fRegistroE055: TRegistroSEFE055List;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property COD_MOD     : String  read fCOD_MOD      write fCOD_MOD;      // Código do modelo do documento fiscal, conforme a tabela indicada no item 4.1.1
    property SER         : String	read fSER          write fSER;          // Série do documento fiscal
    property COD_INF_OBS : String  read fCOD_INF_OBS  write fCOD_INF_OBS;  // Código de referência à observação (campo 02 da Linha 0450)
    property NUM_LCTO    : String  read fNUM_LCTO     write fNUM_LCTO;     // Número ou código de identificação única do lançamento contábil
    property QTD_CANC    : Integer read fQTD_CANC     write fQTD_CANC;     // Quantidade de documentos cancelados
    property SUB         : Integer read fSUB          write fSUB;          // Subsérie dos documentos fiscais
    property NUM_DOC_INI : Integer read fNUM_DOC_INI  write fNUM_DOC_INI;  // Número do primeiro documento fiscal emitido no dia
    property NUM_DOC_FIN : Integer read fNUM_DOC_FIN  write fNUM_DOC_FIN;  // Número do último documento fiscal emitido no dia
    property DT_DOC      : Integer read fDT_DOC       write fDT_DOC;       // Data da emissão dos documentos fiscais
    property COP         : Integer read fCOP          write fCOP;          // Código da classe da operação ou prestação, conforme a tabela indicada no item 4.2.2.1
    property VL_CONT     : Double  read fVL_CONT      write fVL_CONT;      // Valor contábil (valor dos documentos)
    property VL_BC_ICMS  : Double  read fVL_BC_ICMS   write fVL_BC_ICMS;   // Valor da base de cálculo do ICMS
    property VL_ICMS     : Double  read fVL_ICMS      write fVL_ICMS;      // Valor do ICMS debitado
    property VL_ISNT_ICMS: Double  read fVL_ISNT_ICMS write fVL_ISNT_ICMS; // Valor das operações isentas ou não-tributadas pelo ICMS
    property VL_OUT_ICMS : Double  read fVL_OUT_ICMS  write fVL_OUT_ICMS;  // Valor das outras operações do ICMS

    property RegistroE055: TRegistroSEFE055List read FRegistroE055 write FRegistroE055;
  end;

  TRegistroSEFE050List = class(TACBrSEFIIRegistros)
  private
    function GetNotas(Index: Integer): TRegistroSEFE050;
    procedure SetNotas(Index: Integer; const Value: TRegistroSEFE050);
  public
    function New(AOwner: TRegistroSEFE001): TRegistroSEFE050;
    property notas[Index: Integer]: TRegistroSEFE050 read Getnotas write SetNotas;
  end;

  //LINHA E055: DETALHE - VALORES PARCIAIS
  TRegistroSEFE055 = class
  private
    fVL_CONT_P     : Double;
    fVL_BC_ICMS_P  : Double;
    fALIQ_ICMS     : Double;
    fVL_ICMS_P     : Double;
    fVL_ISNT_ICMS_P: Double;
    fVL_OUT_ICMS_P : Double;
    fCFOP          : Integer;
    fIND_IMUN      : Integer;
  public
    property VL_CONT_P     : Double  read	FVL_CONT_P      write FVL_CONT_P;      // Valor contábil, rateado por CFOP e alíquota
    property VL_BC_ICMS_P  : Double	 read FVL_BC_ICMS_P   write FVL_BC_ICMS_P;   // Valor da base de cálculo do ICMS consolidado por CFOP e alíquota
    property ALIQ_ICMS     : Double  read	FALIQ_ICMS      write FALIQ_ICMS;      // Alíquota do ICMS
    property VL_ICMS_P     : Double  read	FVL_ICMS_P      write FVL_ICMS_P;      // Valor do ICMS referente ao CFOP e à alíquota
    property VL_ISNT_ICMS_P: Double  read	FVL_ISNT_ICMS_P write FVL_ISNT_ICMS_P; // Valor das operações isentas ou não-tributadas pelo ICMS, rateado por CFOP e alíquota
    property VL_OUT_ICMS_P : Double  read	FVL_OUT_ICMS_P  write FVL_OUT_ICMS_P;  // Valor das outras operações do ICMS, rateado por CFOP e alíquota
    property CFOP          : Integer read	FCFOP           write FCFOP;           // Código Fiscal de Operações e Prestações preponderante no dia, conforme a tabela externa indicada no item 3.3.1
    property IND_IMUN      : Integer read	FIND_IMUN       write FIND_IMUN;       // Indicador da operação: 0- Sem envolver item imune do ICMS ou IPI 1- Envolvendo livro, jornal, periódico ou com o papel destinado à impressão destes (imunes do ICMS e do IPI) 2- Envolvendo mineral (imune do IPI)
  end;

  TRegistroSEFE055List = class(TACBrSEFIIRegistros)
  private
    function GetNotas(Index: Integer): TRegistroSEFE055;
    procedure SetNotas(Index: Integer; const Value: TRegistroSEFE055);
  public
    function New(AOwner: TRegistroSEFE050): TRegistroSEFE055;
    property notas[Index: Integer]: TRegistroSEFE055 read Getnotas write SetNotas;
  end;

  //LINHA E060: LANÇAMENTO - REDUÇÃO Z/ICMS
  TRegistroSEFE060 = class
  private
    fCOD_MOD     : TSEFIIDocFiscalReferenciado;
    fECF_FAB     : String;
    fCOD_INF_OBS : String;
    fECF_CX      : Integer;
    FCRO         : Integer;
    FCRZ         : Integer;
    FDT_DOC      : TDateTime;
    fNUM_DOC_INI : Integer;
    fNUM_DOC_FIN : Integer;
    fGT_INI      : Double;
    fGT_FIN      : Double;
    fVL_BRT      : Double;
    fVL_CANC_ICMS: Double;
    fVL_DESC_ICMS: Double;
    fVL_ACMO_ICMS: Double;
    fVL_OP_ISS   : Double;
    fVL_LIQ      : Double;
    fVL_BC_ICMS  : Double;
    fVL_ICMS     : Double;
    fVL_ISN      : Double;
    fVL_NT       : Double;
    fVL_ST       : Double;
    fRegistroE065: TRegistroSEFE065List;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property COD_MOD     : TSEFIIDocFiscalReferenciado read fCOD_MOD write fCOD_MOD;   //Código do modelo do documento fiscal, conforme a tabela indicada no item 4.1.1
    property COD_INF_OBS : String    read	fCOD_INF_OBS  write fCOD_INF_OBS;  // Observação
    property ECF_FAB     : String	  read  fECF_FAB      write fECF_FAB;      // Número de série de fabricação do ECF
    property ECF_CX      : Integer   read	fECF_CX       write fECF_CX;       // Número do caixa (número de ordem seqüencial do ECF)
    property CRO         : Integer   read	fCRO          write fCRO;          // Posição do Contador de Reinício de Operação
    property CRZ         : Integer   read	fCRZ          write fCRZ;          // Posição do Contador de Redução Z
    property DT_DOC      : TDateTime read	fDT_DOC       write fDT_DOC;       // Data das operações a que se refere a Redução Z
    property NUM_DOC_INI : Integer   read	fNUM_DOC_INI  write fNUM_DOC_INI;  // Número do primeiro cupom fiscal (CCF, CVC ou CBP) emitido no dia
    property NUM_DOC_FIN : Integer   read	fNUM_DOC_FIN  write fNUM_DOC_FIN;  // Número do último cupom fiscal (CCF, CVC ou CBP) emitido no dia
    property GT_INI      : Double    read	fGT_INI       write fGT_INI;       // Valor do Grande Total inicial
    property GT_FIN      : Double    read	fGT_FIN       write fGT_FIN;       // Valor do Grande Total final
    property VL_BRT      : Double    read	fVL_BRT       write fVL_BRT;       // Valor da venda bruta
    property VL_CANC_ICMS: Double    read	fVL_CANC_ICMS write fVL_CANC_ICMS; // Valor dos cancelamentos referentes ao ICMS
    property VL_DESC_ICMS: Double    read	fVL_DESC_ICMS write fVL_DESC_ICMS; // Valor dos descontos registrados nas operações sujeitas ao ICMS
    property VL_ACMO_ICMS: Double    read	fVL_ACMO_ICMS write fVL_ACMO_ICMS; // Valor dos acréscimos referentes ao ICMS
    property VL_OP_ISS   : Double    read	fVL_OP_ISS    write fVL_OP_ISS;    // Valor das operações tributado pelo ISS
    property VL_LIQ      : Double    read	fVL_LIQ       write fVL_LIQ;       // Valor da venda líquida
    property VL_BC_ICMS  : Double    read	fVL_BC_ICMS   write fVL_BC_ICMS;   // Valor da base de cálculo do ICMS
    property VL_ICMS     : Double    read	fVL_ICMS      write fVL_ICMS;      // Valor do ICMS debitado
    property VL_ISN      : Double    read	fVL_ISN       write fVL_ISN;       // Valor das operações isentas
    property VL_NT       : Double    read	fVL_NT        write fVL_NT;        // Valor das operações não-tributadas pelo ICMS
    property VL_ST       : Double    read	fVL_ST        write fVL_ST;        // Valor das operações com mercadorias adquiridas com substituição tributária do ICMS

    property RegistroE065: TRegistroSEFE065List read fRegistroE065 write fRegistroE065;
  end;


  TRegistroSEFE060List = class(TACBrSEFIIRegistros)
  private
    function GetNotas(Index: Integer): TRegistroSEFE060;
    procedure SetNotas(Index: Integer; const Value: TRegistroSEFE060);
  public
    function New(AOwner: TRegistroSEFE001): TRegistroSEFE060;
    property notas[Index: Integer]: TRegistroSEFE060 read Getnotas write SetNotas;
  end;

  //LINHA E065: DETALHE - VALORES PARCIAIS
  TRegistroSEFE065 = class
  private
    fCFOP        : Integer;
    fIND_IMUN    : Integer;
    fVL_BC_ICMS_P: Double;
    fALIQ_ICMS   : Double;
    fVL_ICMS_P   : Double;
  public
    property CFOP        : Integer read	fCFOP         write fCFOP;         // Código Fiscal de Operações e Prestações preponderante no dia, conforme a tabela externa indicada no item 3.3.1
    property IND_IMUN    : Integer read	fIND_IMUN     write fIND_IMUN;     // Indicador da operação: 0- Sem envolver item imune do ICMS ou IPI 1- Envolvendo livro, jornal, periódico ou com o papel destinado à impressão destes (imunes do ICMS e do IPI) 2- Envolvendo mineral (imune do IPI)
    property VL_BC_ICMS_P: Double	 read fVL_BC_ICMS_P write fVL_BC_ICMS_P; // Valor da base de cálculo do ICMS consolidado por CFOP e alíquota
    property ALIQ_ICMS   : Double  read	fALIQ_ICMS    write fALIQ_ICMS;    // Alíquota do ICMS
    property VL_ICMS_P   : Double  read	fVL_ICMS_P    write fVL_ICMS_P;    // Valor do ICMS referente ao CFOP e à alíquota
  end;

  TRegistroSEFE065List = class(TACBrSEFIIRegistros)
  private
    function GetNotas(Index: Integer): TRegistroSEFE065;
    procedure SetNotas(Index: Integer; const Value: TRegistroSEFE065);
  public
    function New(AOwner: TRegistroSEFE060): TRegistroSEFE065;
    property notas[Index: Integer]: TRegistroSEFE065 read Getnotas write SetNotas;
  end;

  //LINHA E080: LANÇAMENTO - MAPA-RESUMO DE ECF/ICMS
  TRegistroSEFE080 = class
  private
    fCOD_MOD     : String;
    fNUM_LCTO    : String;
    fCOP         : Integer;
    fIND_TOT     : Integer;
    fNUM_MR      : Integer;
    fIND_OBS     : Integer;
    fDT_DOC      : TDateTime;
    fVL_BRT      : Double;
    fVL_CANC_ICMS: Double;
    fVL_DESC_ICMS: Double;
    fVL_ACMO_ICMS: Double;
    fVL_OP_ISS   : Double;
    fVL_CONT     : Double;
    fVL_BC_ICMS  : Double;
    fVL_ICMS     : Double;
    fVL_ISNT_ICMS: Double;
    fVL_ST       : Double;
    fRegistroE085: TRegistroSEFE085List;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property COD_MOD     : String    read	FCOD_MOD      write FCOD_MOD;       // Código do modelo do documento fiscal, conforme a tabela indicada no item 4.1.1
    property NUM_LCTO    : String    read	FNUM_LCTO     write FNUM_LCTO;      // Observação
    property IND_TOT     : Integer   read	FIND_TOT      write FIND_TOT;       // Indicador de totalização: 0- Total do dia 1- Total do mês
    property NUM_MR      : Integer	 read  FNUM_MR      write FNUM_MR;        // Número de ordem do mapa resumo, correspondente ao dia do mês em que ocorreram as vendas (ou correspondente ao mês em houve a totalização)
    property COP         : Integer   read	FCOP          write FCOP;           // Código da classe da operação ou prestação, conforme a tabela indicada no item 4.2.2.1
    property IND_OBS     : Integer   read	FIND_OBS      write FIND_OBS;       // Indicador de observações do Mapa-resumo ECF: 0- Lançamento sem observação 1- Lançamento com observação
    property DT_DOC      : TDateTime read	FDT_DOC       write FDT_DOC;        // Data do resumo das vendas por ECF
    property VL_BRT      : Double    read	FVL_BRT       write FVL_BRT;        // Valor da venda bruta
    property VL_CANC_ICMS: Double    read	FVL_CANC_ICMS write FVL_CANC_ICMS;  // Valor dos cancelamentos referentes ao ICMS
    property VL_DESC_ICMS: Double    read	FVL_DESC_ICMS write FVL_DESC_ICMS;  // Valor dos descontos registrados nas operações sujeitas ao ICMS
    property VL_ACMO_ICMS: Double    read	FVL_ACMO_ICMS write FVL_ACMO_ICMS;  // Valor dos acréscimos referentes ao ICMS
    property VL_OP_ISS   : Double    read	FVL_OP_ISS    write FVL_OP_ISS;     // Valor das operações tributado pelo ISS
    property VL_CONT     : Double    read	FVL_CONT      write FVL_CONT;       // Valor da venda líquida
    property VL_BC_ICMS  : Double    read	FVL_BC_ICMS   write FVL_BC_ICMS;    // Valor da base de cálculo do ICMS
    property VL_ICMS     : Double    read	FVL_ICMS      write FVL_ICMS;       // Valor do ICMS debitado
    property VL_ISNT_ICMS: Double    read	FVL_ISNT_ICMS write FVL_ISNT_ICMS;  // Valor das operações isentas ou não-tributadas pelo ICMS
    property VL_ST       : Double    read	FVL_ST        write FVL_ST;         // Valor das operações com mercadorias adquiridas com substituição tributária do ICMS

    property RegistroE085: TRegistroSEFE085List read FRegistroE085 write FRegistroE085;
  end;

  TRegistroSEFE080List = class(TACBrSEFIIRegistros)
  private
    function GetNotas(Index: Integer): TRegistroSEFE080;
    procedure SetNotas(Index: Integer; const Value: TRegistroSEFE080);
  public
    function New(AOwner: TRegistroSEFE001): TRegistroSEFE080;
    property notas[Index: Integer]: TRegistroSEFE080 read Getnotas write SetNotas;
  end;

  TRegistroSEFE085 = class
  private
    fVL_CONT_P     : Double;
    fVL_OP_ISS_P   : Double;
    fVL_BC_ICMS_P  : Double;
    fALIQ_ICMS     : Double;
    fVL_ICMS_P     : Double;
    fVL_ISNT_ICMS_P: Double;
    fVL_ST_P       : Double;
    fIND_IMUN      : Integer;
    fCFOP          : Integer;
  public
    property VL_CONT_P     : Double  read	 FVL_CONT_P      write FVL_CONT_P;      // Código Fiscal de Operações e Prestações preponderante no dia, conforme a tabela externa indicada no item 3.3.1
    property VL_OP_ISS_P   : Double	 read  FVL_OP_ISS_P    write FVL_OP_ISS_P;    // Parcela por CFOP e alíquota correspondente ao valor das operações tributado pelo ISS
    property VL_BC_ICMS_P  : Double  read	 FVL_BC_ICMS_P   write FVL_BC_ICMS_P;   // Valor do ICMS referente ao CFOP e à alíquota
    property ALIQ_ICMS     : Double  read	 FALIQ_ICMS      write FALIQ_ICMS;      // Alíquota do ICMS
    property VL_ICMS_P     : Double  read	 FVL_ICMS_P      write FVL_ICMS_P;      // Valor do ICMS referente ao CFOP e à alíquota
    property VL_ISNT_ICMS_P: Double  read	 FVL_ISNT_ICMS_P write FVL_ISNT_ICMS_P; // Valor do ICMS referente ao CFOP e à alíquota
    property VL_ST_P       : Double  read	 FVL_ST_P        write FVL_ST_P;        // Valor das operações com mercadorias adquiridas com substituição tributária do ICMS, rateado por CFOP e alíquota
    property IND_IMUN      : Integer read	 FIND_IMUN       write FIND_IMUN;       // Indicador da operação: 0- Sem envolver item imune do ICMS ou IPI 1- Envolvendo livro, jornal, periódico ou com o papel destinado à impressão destes (imunes do ICMS e do IPI) 2- Envolvendo mineral (imune do IPI)
    property CFOP          : Integer read	 FCFOP           write FCFOP;           // Código Fiscal de Operações e Prestações preponderante, conforme a tabela externa indicada no item 3.3.1
  end;

  TRegistroSEFE085List = class(TACBrSEFIIRegistros)
  private
    function GetNotas(Index: Integer): TRegistroSEFE085;
    procedure SetNotas(Index: Integer; const Value: TRegistroSEFE085);
  public
    function New(AOwner: TRegistroSEFE080): TRegistroSEFE085;
    property notas[Index: Integer]: TRegistroSEFE085 read Getnotas write SetNotas;
  end;

  //LINHA E300: APURAÇÃO DO ICMS
  TRegistroSEFE300 = class
  private
    fDT_INI : Integer;
    fDT_FIN : Integer;
    fRegistroE305: TRegistroSEFE305List;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property DT_INI : Integer read	fDT_INI write fDT_INI;
    property DT_FIN : Integer read fDT_FIN write fDT_FIN;
    property RegistroE305: TRegistroSEFE305List read fRegistroE305 write fRegistroE305;
  end;

  TRegistroSEFE300List = class(TACBrSEFIIRegistros)
  private
    function GetNotas(Index: Integer): TRegistroSEFE300;
    procedure SetNotas(Index: Integer; const Value: TRegistroSEFE300);
  public
    function New(AOwner: TRegistroSEFE001): TRegistroSEFE300;
    property notas[Index: Integer]: TRegistroSEFE300 read Getnotas write SetNotas;
  end;


  TRegistroSEFE305 = class
  private
    fIND_MRO     : Integer;
    fIND_OPER    : Integer;
    fDT_DOC      : Integer;
    fQTD_LCTO    : Integer;
    fCOP         : String;
    fNUM_LCTO    : String;
    fVL_CONT     : Double;
    fVL_OP_ISS   : Double;
    fVL_BC_ICMS  : Double;
    fVL_ICMS     : Double;
    fVL_ST       : Double;
    fVL_ST_ENT   : Double;
    fVL_ST_FNT   : Double;
    fVL_ST_UF    : Double;
    fVL_ST_OE    : Double;
    fVL_AT       : Double;
    fVL_ISNT_ICMS: Double;
    fVL_OUT_ICMS : Double;
    fVL_BC_IPI   : Double;
    fVL_IPI      : Double;
    fVL_ISNT_IPI : Double;
    fVL_OUT_IPI  : Double;
  public
    property IND_MRO     : Integer read	fIND_MRO      write fIND_MRO;      // Indicador do resumo: 0- Total diário por COP 1- Total por COP  2- Total diário
    property IND_OPER    : Integer read	fIND_OPER     write fIND_OPER;     // Indicador de operação: 0- Entrada ou aquisição 1- Saída ou prestação
    property DT_DOC      : Integer read fDT_DOC       write fDT_DOC;       // Data dos documentos
    property QTD_LCTO    : Integer read	fQTD_LCTO     write fQTD_LCTO;     // Quantidade de lançamentos com repercussão por tipo de resumo
    property COP         : String  read	fCOP          write fCOP;          // Código da classe da operação ou prestação, conforme a tabela indicada no item 4.2.2.1
    property NUM_LCTO    : String  read	fNUM_LCTO     write fNUM_LCTO;     // Número ou código de identificação única do lançamento contábil
    property VL_CONT     : Double  read	fVL_CONT      write fVL_CONT;      // Valor da venda líquida
    property VL_OP_ISS   : Double  read	fVL_OP_ISS    write fVL_OP_ISS;    // Valor das operações tributado pelo ISS
    property VL_BC_ICMS  : Double  read	fVL_BC_ICMS   write fVL_BC_ICMS;   // Valor da base de cálculo do ICMS
    property VL_ICMS     : Double  read	fVL_ICMS      write fVL_ICMS;      // Valor do ICMS debitado
    property VL_ST       : Double  read	fVL_ST        write fVL_ST;        // Valor das operações com mercadorias adquiridas com substituição tributária do ICMS
    property VL_ST_ENT   : Double  read	fVL_ST_ENT    write fVL_ST_ENT;    // Valor total do ICMS da substituição tributária pelas entradas, creditado e devido pelo alienante nas operações de entrada, registrado em documentos de emissão própria
    property VL_ST_FNT   : Double  read	fVL_ST_FNT    write fVL_ST_FNT;    // Valor total do ICMS da substituição tributária devido pelo alienante, registrado nas operações de saídas internas
    property VL_ST_UF    : Double  read	fVL_ST_UF     write fVL_ST_UF;     // Valor total do ICMS da substituição tributária devido pelo alienante, registrado nas operações de saídas internas
    property VL_ST_OE    : Double  read	fVL_ST_OE     write fVL_ST_OE;     // Valor total do ICMS da substituição tributária devido pelo alienante, registrado nas operações de saídas interestaduais
    property VL_AT       : Double  read	fVL_AT        write fVL_AT;        // Valor total do ICMS da antecipação tributária creditado
    property VL_ISNT_ICMS: Double  read	fVL_ISNT_ICMS write fVL_ISNT_ICMS; // Valor total das operações isentas ou não-tributadas pelo ICMS
    property VL_OUT_ICMS : Double  read	fVL_OUT_ICMS  write fVL_OUT_ICMS;  // Valor total das outras operações do ICMS
    property VL_BC_IPI   : Double  read	fVL_BC_IPI    write fVL_BC_IPI;    // Valor total da base de cálculo do IPI
    property VL_IPI      : Double  read	fVL_IPI       write fVL_IPI;       // Valor total do IPI creditado/debitado
    property VL_ISNT_IPI : Double  read	fVL_ISNT_IPI  write fVL_ISNT_IPI;  // Valor total das operações isentas ou não-tributadas pelo IPI
    property VL_OUT_IPI  : Double  read	fVL_OUT_IPI   write fVL_OUT_IPI ;  // Valor total das outras operações do IPI
  end;

  TRegistroSEFE305List = class(TACBrSEFIIRegistros)
  private
    function GetNotas(Index: Integer): TRegistroSEFE305;
    procedure SetNotas(Index: Integer; const Value: TRegistroSEFE305);
  public
    function New(AOwner: TRegistroSEFE300): TRegistroSEFE305;
    property notas[Index: Integer]: TRegistroSEFE305 read Getnotas write SetNotas;
  end;


  { TRegistroSEFE990 }

  /// Registro E990 - Encerramento do Bloco E
  TRegistroSEFE990 = class
  private
    fQTD_LIN_E: Integer;
  public
    property QTD_LIN_E: Integer read fQTD_LIN_E write fQTD_LIN_E;
  end;

implementation

constructor TRegistroSEFE020.Create(AOwner: TRegistroSEFE001);
begin
  FRegistroE025 := TRegistroSEFE025List.Create;
end;

destructor TRegistroSEFE020.Destroy;
begin
   FRegistroE025.Free;
   inherited Destroy;
end;

function TRegistroSEFE020.GetCOP: String;
begin
  Case StrToInt(fCOP) of
    0    : Result := 'OP00';
    1101 : Result := 'EA10';
    1102 : Result := 'EA10';
    1111 : Result := 'EA10';
    1113 : Result := 'EA10';
    1116 : Result := 'EA10';
    1117 : Result := 'EA10';
    1118 : Result := 'EA10';
    1120 : Result := 'EA10';
    1121 : Result := 'EA10';
    1122 : Result := 'EA10';
    1124 : Result := 'EA30';
    1125 : Result := 'EA30';
    1126 : Result := 'EA10';
    1128 : Result := 'EA10';
    1151 : Result := 'EA60';
    1152 : Result := 'EA60';
    1153 : Result := 'EA60';
    1154 : Result := 'EA60';
    1201 : Result := 'EA20';
    1202 : Result := 'EA20';
    1203 : Result := 'EA20';
    1204 : Result := 'EA20';
    1205 : Result := 'EA80';
    1206 : Result := 'EA80';
    1207 : Result := 'EA80';
    1208 : Result := 'EA60';
    1209 : Result := 'EA60';
    1251 : Result := 'EA10';
    1252 : Result := 'EA10';
    1253 : Result := 'EA10';
    1254 : Result := 'EA10';
    1255 : Result := 'EA10';
    1256 : Result := 'EA10';
    1257 : Result := 'EA10';
    1301 : Result := 'EA70';
    1302 : Result := 'EA70';
    1303 : Result := 'EA70';
    1304 : Result := 'EA70';
    1305 : Result := 'EA70';
    1306 : Result := 'EA70';
    1351 : Result := 'EA70';
    1352 : Result := 'EA70';
    1353 : Result := 'EA70';
    1354 : Result := 'EA70';
    1355 : Result := 'EA70';
    1356 : Result := 'EA70';
    1360 : Result := 'EA70';
    1401 : Result := 'EA10';
    1403 : Result := 'EA10';
    1406 : Result := 'EA10';
    1407 : Result := 'EA10';
    1408 : Result := 'EA60';
    1409 : Result := 'EA60';
    1410 : Result := 'EA20';
    1411 : Result := 'EA20';
    1414 : Result := 'EA30';
    1415 : Result := 'EA30';
    1451 : Result := 'EA30';
    1452 : Result := 'EA30';
    1501 : Result := 'EA50';
    1503 : Result := 'EA40';
    1504 : Result := 'EA40';
    1505 : Result := 'EA40';
    1506 : Result := 'EA40';
    1551 : Result := 'EA10';
    1552 : Result := 'EA60';
    1553 : Result := 'EA20';
    1554 : Result := 'EA30';
    1555 : Result := 'EA50';
    1556 : Result := 'EA10';
    1557 : Result := 'EA60';
    1601 : Result := 'EA90';
    1602 : Result := 'EA90';
    1603 : Result := 'EA91';
    1604 : Result := 'EA90';
    1605 : Result := 'EA90';
    1651 : Result := 'EA10';
    1652 : Result := 'EA10';
    1653 : Result := 'EA10';
    1658 : Result := 'EA60';
    1659 : Result := 'EA60';
    1660 : Result := 'EA20';
    1661 : Result := 'EA20';
    1662 : Result := 'EA20';
    1663 : Result := 'EA50';
    1664 : Result := 'EA30';
    1901 : Result := 'EA50';
    1902 : Result := 'EA30';
    1903 : Result := 'EA30';
    1904 : Result := 'EA30';
    1905 : Result := 'EA50';
    1906 : Result := 'EA30';
    1907 : Result := 'EA30';
    1908 : Result := 'EA50';
    1909 : Result := 'EA30';
    1910 : Result := 'EA50';
    1911 : Result := 'EA50';
    1912 : Result := 'EA50';
    1913 : Result := 'EA30';
    1914 : Result := 'EA30';
    1915 : Result := 'EA50';
    1916 : Result := 'EA30';
    1917 : Result := 'EA50';
    1918 : Result := 'EA30';
    1919 : Result := 'EA30';
    1920 : Result := 'EA50';
    1921 : Result := 'EA30';
    1922 : Result := 'EA90';
    1923 : Result := 'EA50';
    1924 : Result := 'EA50';
    1925 : Result := 'EA30';
    1926 : Result := 'EA65';
    1931 : Result := 'EA90';
    1932 : Result := 'EA70';
    1933 : Result := 'EA10';
    1934 : Result := 'EA50';
    1949 : Result := 'EA99';
    2101 : Result := 'EA10';
    2102 : Result := 'EA10';
    2111 : Result := 'EA10';
    2113 : Result := 'EA10';
    2116 : Result := 'EA10';
    2117 : Result := 'EA10';
    2118 : Result := 'EA10';
    2120 : Result := 'EA10';
    2121 : Result := 'EA10';
    2122 : Result := 'EA10';
    2124 : Result := 'EA30';
    2125 : Result := 'EA30';
    2126 : Result := 'EA10';
    2128 : Result := 'EA10';
    2151 : Result := 'EA60';
    2152 : Result := 'EA60';
    2153 : Result := 'EA60';
    2154 : Result := 'EA60';
    2201 : Result := 'EA20';
    2202 : Result := 'EA20';
    2203 : Result := 'EA20';
    2204 : Result := 'EA20';
    2205 : Result := 'EA80';
    2206 : Result := 'EA80';
    2207 : Result := 'EA80';
    2208 : Result := 'EA60';
    2209 : Result := 'EA60';
    2251 : Result := 'EA10';
    2252 : Result := 'EA10';
    2253 : Result := 'EA10';
    2254 : Result := 'EA10';
    2255 : Result := 'EA10';
    2256 : Result := 'EA10';
    2257 : Result := 'EA10';
    2301 : Result := 'EA70';
    2302 : Result := 'EA70';
    2303 : Result := 'EA70';
    2304 : Result := 'EA70';
    2305 : Result := 'EA70';
    2306 : Result := 'EA70';
    2351 : Result := 'EA70';
    2352 : Result := 'EA70';
    2353 : Result := 'EA70';
    2354 : Result := 'EA70';
    2355 : Result := 'EA70';
    2356 : Result := 'EA70';
    2401 : Result := 'EA10';
    2403 : Result := 'EA10';
    2406 : Result := 'EA10';
    2407 : Result := 'EA10';
    2408 : Result := 'EA60';
    2409 : Result := 'EA60';
    2410 : Result := 'EA20';
    2411 : Result := 'EA20';
    2414 : Result := 'EA30';
    2415 : Result := 'EA30';
    2501 : Result := 'EA50';
    2503 : Result := 'EA40';
    2504 : Result := 'EA40';
    2505 : Result := 'EA40';
    2506 : Result := 'EA40';
    2551 : Result := 'EA10';
    2552 : Result := 'EA60';
    2553 : Result := 'EA20';
    2554 : Result := 'EA30';
    2555 : Result := 'EA50';
    2556 : Result := 'EA10';
    2557 : Result := 'EA60';
    2603 : Result := 'EA91';
    2651 : Result := 'EA10';
    2652 : Result := 'EA10';
    2653 : Result := 'EA10';
    2658 : Result := 'EA60';
    2659 : Result := 'EA60';
    2660 : Result := 'EA20';
    2661 : Result := 'EA20';
    2662 : Result := 'EA20';
    2663 : Result := 'EA50';
    2664 : Result := 'EA30';
    2901 : Result := 'EA50';
    2902 : Result := 'EA30';
    2903 : Result := 'EA30';
    2904 : Result := 'EA30';
    2905 : Result := 'EA50';
    2906 : Result := 'EA30';
    2907 : Result := 'EA30';
    2908 : Result := 'EA50';
    2909 : Result := 'EA30';
    2910 : Result := 'EA50';
    2911 : Result := 'EA50';
    2912 : Result := 'EA50';
    2913 : Result := 'EA30';
    2914 : Result := 'EA30';
    2915 : Result := 'EA50';
    2916 : Result := 'EA30';
    2917 : Result := 'EA50';
    2918 : Result := 'EA40';
    2919 : Result := 'EA30';
    2920 : Result := 'EA50';
    2921 : Result := 'EA30';
    2922 : Result := 'EA90';
    2923 : Result := 'EA50';
    2924 : Result := 'EA50';
    2925 : Result := 'EA30';
    2931 : Result := 'EA90';
    2932 : Result := 'EA70';
    2933 : Result := 'EA10';
    2934 : Result := 'EA50';
    2949 : Result := 'EA99';
    3101 : Result := 'EA10';
    3102 : Result := 'EA10';
    3126 : Result := 'EA10';
    3127 : Result := 'EA10';
    3128 : Result := 'EA10';
    3201 : Result := 'EA20';
    3202 : Result := 'EA20';
    3205 : Result := 'EA80';
    3206 : Result := 'EA80';
    3207 : Result := 'EA80';
    3211 : Result := 'EA20';
    3251 : Result := 'EA10';
    3301 : Result := 'EA70';
    3351 : Result := 'EA70';
    3352 : Result := 'EA70';
    3353 : Result := 'EA70';
    3354 : Result := 'EA70';
    3355 : Result := 'EA70';
    3356 : Result := 'EA70';
    3503 : Result := 'EA40';
    3551 : Result := 'EA10';
    3553 : Result := 'EA20';
    3556 : Result := 'EA10';
    3651 : Result := 'EA10';
    3652 : Result := 'EA10';
    3653 : Result := 'EA10';
    3930 : Result := 'EA50';
    3949 : Result := 'EA99';
    5101 : Result := 'SP10';
    5102 : Result := 'SP10';
    5103 : Result := 'SP10';
    5104 : Result := 'SP10';
    5105 : Result := 'SP10';
    5106 : Result := 'SP10';
    5109 : Result := 'SP10';
    5110 : Result := 'SP10';
    5111 : Result := 'SP10';
    5112 : Result := 'SP10';
    5113 : Result := 'SP10';
    5114 : Result := 'SP10';
    5115 : Result := 'SP10';
    5116 : Result := 'SP10';
    5117 : Result := 'SP10';
    5118 : Result := 'SP10';
    5119 : Result := 'SP10';
    5120 : Result := 'SP10';
    5122 : Result := 'SP10';
    5123 : Result := 'SP10';
    5124 : Result := 'SP50';
    5125 : Result := 'SP50';
    5151 : Result := 'SP60';
    5152 : Result := 'SP60';
    5153 : Result := 'SP60';
    5155 : Result := 'SP60';
    5156 : Result := 'SP60';
    5201 : Result := 'SP20';
    5202 : Result := 'SP20';
    5205 : Result := 'SP80';
    5206 : Result := 'SP80';
    5207 : Result := 'SP80';
    5208 : Result := 'SP60';
    5209 : Result := 'SP60';
    5210 : Result := 'SP20';
    5251 : Result := 'SP10';
    5252 : Result := 'SP10';
    5253 : Result := 'SP10';
    5254 : Result := 'SP10';
    5255 : Result := 'SP10';
    5256 : Result := 'SP10';
    5257 : Result := 'SP10';
    5258 : Result := 'SP10';
    5301 : Result := 'SP70';
    5302 : Result := 'SP70';
    5303 : Result := 'SP70';
    5304 : Result := 'SP70';
    5305 : Result := 'SP70';
    5306 : Result := 'SP70';
    5307 : Result := 'SP70';
    5351 : Result := 'SP70';
    5352 : Result := 'SP70';
    5353 : Result := 'SP70';
    5354 : Result := 'SP70';
    5355 : Result := 'SP70';
    5356 : Result := 'SP70';
    5357 : Result := 'SP70';
    5359 : Result := 'SP70';
    5360 : Result := 'SP70';
    5401 : Result := 'SP10';
    5402 : Result := 'SP10';
    5403 : Result := 'SP10';
    5405 : Result := 'SP10';
    5408 : Result := 'SP60';
    5409 : Result := 'SP60';
    5410 : Result := 'SP20';
    5411 : Result := 'SP20';
    5412 : Result := 'SP20';
    5413 : Result := 'SP20';
    5414 : Result := 'SP30';
    5415 : Result := 'SP30';
    5451 : Result := 'SP30';
    5501 : Result := 'SP30';
    5502 : Result := 'SP30';
    5503 : Result := 'SP50';
    5504 : Result := 'SP30';
    5505 : Result := 'SP30';
    5551 : Result := 'SP10';
    5552 : Result := 'SP60';
    5553 : Result := 'SP20';
    5554 : Result := 'SP30';
    5555 : Result := 'SP50';
    5556 : Result := 'SP20';
    5557 : Result := 'SP60';
    5601 : Result := 'SP90';
    5602 : Result := 'SP90';
    5603 : Result := 'SP91';
    5605 : Result := 'SP90';
    5606 : Result := 'SP90';
    5651 : Result := 'SP10';
    5652 : Result := 'SP10';
    5653 : Result := 'SP10';
    5654 : Result := 'SP10';
    5655 : Result := 'SP10';
    5656 : Result := 'SP10';
    5657 : Result := 'SP30';
    5658 : Result := 'SP60';
    5659 : Result := 'SP60';
    5660 : Result := 'SP20';
    5661 : Result := 'SP20';
    5662 : Result := 'SP20';
    5663 : Result := 'SP30';
    5664 : Result := 'SP50';
    5665 : Result := 'SP50';
    5666 : Result := 'SP30';
    5667 : Result := 'SP10';
    5901 : Result := 'SP30';
    5902 : Result := 'SP50';
    5903 : Result := 'SP50';
    5904 : Result := 'SP30';
    5905 : Result := 'SP30';
    5906 : Result := 'SP50';
    5907 : Result := 'SP50';
    5908 : Result := 'SP30';
    5909 : Result := 'SP50';
    5910 : Result := 'SP30';
    5911 : Result := 'SP30';
    5912 : Result := 'SP30';
    5913 : Result := 'SP50';
    5914 : Result := 'SP30';
    5915 : Result := 'SP30';
    5916 : Result := 'SP50';
    5917 : Result := 'SP30';
    5918 : Result := 'SP50';
    5919 : Result := 'SP50';
    5920 : Result := 'SP30';
    5921 : Result := 'SP50';
    5922 : Result := 'SP90';
    5923 : Result := 'SP30';
    5924 : Result := 'SP30';
    5925 : Result := 'SP50';
    5926 : Result := 'SP65';
    5927 : Result := 'SP65';
    5928 : Result := 'SP65';
    5929 : Result := 'SP90';
    5931 : Result := 'SP90';
    5932 : Result := 'SP70';
    5933 : Result := 'SP10';
    5934 : Result := 'SP30';
    5949 : Result := 'SP99';
    6101 : Result := 'SP10';
    6102 : Result := 'SP10';
    6103 : Result := 'SP10';
    6104 : Result := 'SP10';
    6105 : Result := 'SP10';
    6106 : Result := 'SP10';
    6107 : Result := 'SP10';
    6108 : Result := 'SP10';
    6109 : Result := 'SP10';
    6110 : Result := 'SP10';
    6111 : Result := 'SP10';
    6112 : Result := 'SP10';
    6113 : Result := 'SP10';
    6114 : Result := 'SP10';
    6115 : Result := 'SP10';
    6116 : Result := 'SP10';
    6117 : Result := 'SP10';
    6118 : Result := 'SP10';
    6119 : Result := 'SP10';
    6120 : Result := 'SP10';
    6122 : Result := 'SP10';
    6123 : Result := 'SP10';
    6124 : Result := 'SP50';
    6125 : Result := 'SP50';
    6151 : Result := 'SP60';
    6152 : Result := 'SP60';
    6153 : Result := 'SP60';
    6155 : Result := 'SP60';
    6156 : Result := 'SP60';
    6201 : Result := 'SP20';
    6202 : Result := 'SP20';
    6205 : Result := 'SP80';
    6206 : Result := 'SP80';
    6207 : Result := 'SP80';
    6208 : Result := 'SP50';
    6209 : Result := 'SP50';
    6210 : Result := 'SP20';
    6251 : Result := 'SP10';
    6252 : Result := 'SP10';
    6253 : Result := 'SP10';
    6254 : Result := 'SP10';
    6255 : Result := 'SP10';
    6256 : Result := 'SP10';
    6257 : Result := 'SP10';
    6258 : Result := 'SP10';
    6301 : Result := 'SP70';
    6302 : Result := 'SP70';
    6303 : Result := 'SP70';
    6304 : Result := 'SP70';
    6305 : Result := 'SP70';
    6306 : Result := 'SP70';
    6307 : Result := 'SP70';
    6351 : Result := 'SP70';
    6352 : Result := 'SP70';
    6353 : Result := 'SP70';
    6354 : Result := 'SP70';
    6355 : Result := 'SP70';
    6356 : Result := 'SP70';
    6357 : Result := 'SP70';
    6359 : Result := 'SP70';
    6360 : Result := 'SP70';
    6401 : Result := 'SP10';
    6402 : Result := 'SP10';
    6403 : Result := 'SP10';
    6404 : Result := 'SP10';
    6408 : Result := 'SP60';
    6409 : Result := 'SP60';
    6410 : Result := 'SP20';
    6411 : Result := 'SP20';
    6412 : Result := 'SP20';
    6413 : Result := 'SP20';
    6414 : Result := 'SP30';
    6415 : Result := 'SP30';
    6501 : Result := 'SP30';
    6502 : Result := 'SP30';
    6503 : Result := 'SP50';
    6504 : Result := 'SP30';
    6505 : Result := 'SP30';
    6551 : Result := 'SP10';
    6552 : Result := 'SP60';
    6553 : Result := 'SP20';
    6554 : Result := 'SP30';
    6555 : Result := 'SP50';
    6556 : Result := 'SP20';
    6557 : Result := 'SP60';
    6603 : Result := 'SP91';
    6651 : Result := 'SP10';
    6652 : Result := 'SP10';
    6653 : Result := 'SP10';
    6654 : Result := 'SP10';
    6655 : Result := 'SP10';
    6656 : Result := 'SP10';
    6657 : Result := 'SP30';
    6658 : Result := 'SP60';
    6659 : Result := 'SP60';
    6660 : Result := 'SP20';
    6661 : Result := 'SP20';
    6662 : Result := 'SP20';
    6663 : Result := 'SP30';
    6664 : Result := 'SP50';
    6665 : Result := 'SP50';
    6666 : Result := 'SP30';
    6667 : Result := 'SP10';
    6901 : Result := 'SP30';
    6902 : Result := 'SP50';
    6903 : Result := 'SP50';
    6904 : Result := 'SP30';
    6905 : Result := 'SP30';
    6906 : Result := 'SP50';
    6907 : Result := 'SP50';
    6908 : Result := 'SP30';
    6909 : Result := 'SP50';
    6910 : Result := 'SP30';
    6911 : Result := 'SP30';
    6912 : Result := 'SP30';
    6913 : Result := 'SP50';
    6914 : Result := 'SP30';
    6915 : Result := 'SP30';
    6916 : Result := 'SP50';
    6917 : Result := 'SP30';
    6918 : Result := 'SP50';
    6919 : Result := 'SP50';
    6920 : Result := 'SP30';
    6921 : Result := 'SP50';
    6922 : Result := 'SP90';
    6923 : Result := 'SP30';
    6924 : Result := 'SP30';
    6925 : Result := 'SP50';
    6929 : Result := 'SP90';
    6931 : Result := 'SP90';
    6932 : Result := 'SP70';
    6933 : Result := 'SP10';
    6934 : Result := 'SP30';
    6949 : Result := 'SP99';
    7101 : Result := 'SP10';
    7102 : Result := 'SP10';
    7105 : Result := 'SP10';
    7106 : Result := 'SP10';
    7127 : Result := 'SP10';
    7201 : Result := 'SP20';
    7202 : Result := 'SP20';
    7205 : Result := 'SP80';
    7206 : Result := 'SP80';
    7207 : Result := 'SP80';
    7210 : Result := 'SP20';
    7211 : Result := 'SP20';
    7251 : Result := 'SP10';
    7301 : Result := 'SP70';
    7358 : Result := 'SP70';
    7501 : Result := 'SP10';
    7551 : Result := 'SP10';
    7553 : Result := 'SP20';
    7556 : Result := 'SP20';
    7651 : Result := 'SP10';
    7654 : Result := 'SP10';
    7667 : Result := 'SP10';
    7930 : Result := 'SP20';
    7949 : Result := 'SP99';
  end;
end;

procedure TRegistroSEFE003List.SetItem(Index: Integer;
  const Value: TRegistroSEFE003);
begin
  Put(Index, Value);
end;

procedure TRegistroSEFE020List.SetItem(Index: Integer;
  const Value: TRegistroSEFE020);
begin
  Put(Index, Value);
end;

procedure TRegistroSEFE025List.SetNotas(Index: Integer;
  const Value: TRegistroSEFE025);
begin
  Put(Index, Value);
end;

procedure TRegistroSEFE050List.SetNotas(Index: Integer;
  const Value: TRegistroSEFE050);
begin
  Put(Index, Value);
end;

procedure TRegistroSEFE055List.SetNotas(Index: Integer;
  const Value: TRegistroSEFE055);
begin
  Put(Index, Value);
end;

procedure TRegistroSEFE060List.SetNotas(Index: Integer;
  const Value: TRegistroSEFE060);
begin
  Put(Index, Value);
end;

procedure TRegistroSEFE065List.SetNotas(Index: Integer;
  const Value: TRegistroSEFE065);
begin
  Put(Index, Value);
end;

procedure TRegistroSEFE080List.SetNotas(Index: Integer;
  const Value: TRegistroSEFE080);
begin
  Put(Index, Value);
end;

procedure TRegistroSEFE085List.SetNotas(Index: Integer;
  const Value: TRegistroSEFE085);
begin
  Put(Index, Value);
end;

procedure TRegistroSEFE300List.SetNotas(Index: Integer;
  const Value: TRegistroSEFE300);
begin
  Put(Index, Value);
end;

procedure TRegistroSEFE305List.SetNotas(Index: Integer;
  const Value: TRegistroSEFE305);
begin
  Put(Index, Value);
end;

function TRegistroSEFE003List.GetItem(Index: Integer): TRegistroSEFE003;
begin
  Result := TRegistroSEFE003(Get(Index));
end;

function TRegistroSEFE020List.GetItem(Index: Integer): TRegistroSEFE020;
begin
  Result := TRegistroSEFE020(Get(Index));
end;

function TRegistroSEFE025List.GetNotas(Index: Integer): TRegistroSEFE025;
begin
  Result := TRegistroSEFE025(Get(Index));
end;

function TRegistroSEFE050List.GetNotas(Index: Integer): TRegistroSEFE050;
begin
  Result := TRegistroSEFE050(Get(Index));
end;

function TRegistroSEFE055List.GetNotas(Index: Integer): TRegistroSEFE055;
begin
  Result := TRegistroSEFE055(Get(Index));
end;

function TRegistroSEFE060List.GetNotas(Index: Integer): TRegistroSEFE060;
begin
  Result := TRegistroSEFE060(Get(Index));
end;

function TRegistroSEFE065List.GetNotas(Index: Integer): TRegistroSEFE065;
begin
  Result := TRegistroSEFE065(Get(Index));
end;

function TRegistroSEFE080List.GetNotas(Index: Integer): TRegistroSEFE080;
begin
  Result := TRegistroSEFE080(Get(Index));
end;

function TRegistroSEFE085List.GetNotas(Index: Integer): TRegistroSEFE085;
begin
  Result := TRegistroSEFE085(Get(Index));
end;

function TRegistroSEFE300List.GetNotas(Index: Integer): TRegistroSEFE300;
begin
  Result := TRegistroSEFE300(Get(Index));
end;

function TRegistroSEFE305List.GetNotas(Index: Integer): TRegistroSEFE305;
begin
  Result := TRegistroSEFE305(Get(Index));
end;


function TRegistroSEFE003List.New(AOwner: TRegistroSEFE001): TRegistroSEFE003;
begin
   Result := TRegistroSEFE003.create(AOwner);
   Add(Result);
end;

function TRegistroSEFE020List.New(AOwner: TRegistroSEFE001): TRegistroSEFE020;
begin
   Result := TRegistroSEFE020.Create(AOwner);
   Add(Result);
end;

function TRegistroSEFE050List.New(AOwner: TRegistroSEFE001): TRegistroSEFE050;
begin
   Result := TRegistroSEFE050.Create;
   Add(Result);
end;

function TRegistroSEFE055List.New(AOwner: TRegistroSEFE050): TRegistroSEFE055;
begin
   Result := TRegistroSEFE055.Create;
   Add(Result);
end;

function TRegistroSEFE060List.New(AOwner: TRegistroSEFE001): TRegistroSEFE060;
begin
   Result := TRegistroSEFE060.Create;
   Add(Result);
end;

function TRegistroSEFE080List.New(AOwner: TRegistroSEFE001): TRegistroSEFE080;
begin
   Result := TRegistroSEFE080.Create;
   Add(Result);
end;

function TRegistroSEFE085List.New(AOwner: TRegistroSEFE080): TRegistroSEFE085;
begin
   Result := TRegistroSEFE085.Create;
   Add(Result);
end;

function TRegistroSEFE300List.New(AOwner: TRegistroSEFE001): TRegistroSEFE300;
begin
   Result := TRegistroSEFE300.Create;
   Add(Result);
end;

function TRegistroSEFE305List.New(AOwner: TRegistroSEFE300): TRegistroSEFE305;
begin
   Result := TRegistroSEFE305.Create;
   Add(Result);
end;

{ TRegistroSEFE060 }

constructor TRegistroSEFE060.Create;
begin
   FRegistroE065 := TRegistroSEFE065List.Create;
end;

destructor TRegistroSEFE060.Destroy;
begin
   FRegistroE065.Free;
   inherited Destroy;
end;

{ TRegistroSEFE001 }

constructor TRegistroSEFE001.Create;
begin
   fRegistroE003 := TRegistroSEFE003List.Create;
   fRegistroE020 := TRegistroSEFE020List.Create;
   fRegistroE050 := TRegistroSEFE050List.Create;
   fRegistroE060 := TRegistroSEFE060List.Create;
   fRegistroE080 := TRegistroSEFE080List.Create;
   fRegistroE300 := TRegistroSEFE300List.Create;
   IND_MOV := icSemConteudo;
end;

destructor TRegistroSEFE001.Destroy;
begin
   fRegistroE003.Free;
   fRegistroE020.Free;
   fRegistroE050.Free;
   fRegistroE060.Free;
   fRegistroE080.Free;
   fRegistroE300.Free;
   inherited;
end;

function TRegistroSEFE025List.New(AOwner: TRegistroSEFE020): TRegistroSEFE025;
begin
   Result := TRegistroSEFE025.Create(AOwner);
   Add(Result);
end;

{ TRegistroSEFE050 }

constructor TRegistroSEFE050.Create;
begin
   FRegistroE055 := TRegistroSEFE055List.Create;
end;

destructor TRegistroSEFE050.Destroy;
begin
   FRegistroE055.Free;
   inherited Destroy;
end;

function TRegistroSEFE065List.New(AOwner: TRegistroSEFE060): TRegistroSEFE065;
begin
   Result := TRegistroSEFE065.Create;
   Add(Result);
end;

{ TRegistroSEFE080 }

constructor TRegistroSEFE080.Create;
begin
   FRegistroE085 := TRegistroSEFE085List.Create;
end;

destructor TRegistroSEFE080.Destroy;
begin
   FRegistroE085.Free;
   inherited Destroy;
end;

{ TRegistroSEFE300 }

constructor TRegistroSEFE300.Create;
begin
   FRegistroE305 := TRegistroSEFE305List.Create;
end;

destructor TRegistroSEFE300.Destroy;
begin
   FRegistroE305.Free;
   inherited Destroy;
end;

{ TRegistroSEFE025 }

constructor TRegistroSEFE025.Create(AOwner: TRegistroSEFE020);
begin

end;

{ TRegistroSEFE003 }

constructor TRegistroSEFE003.Create(AOwner: TRegistroSEFE001);
begin

end;

end.

