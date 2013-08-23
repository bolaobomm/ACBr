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
unit ACBrSEF2_Bloco0;

interface

Uses SysUtils, Contnrs, Classes ,ACBrSEF2Conversao;

type

  TRegistroSEF0001 = class;
  TRegistroSEF0205List = class;
  TRegistroSEF0400List = class;
  TRegistroSEF0450List = class;
  TRegistroSEF0460List = class;
  TRegistroSEF0465List = class;
  TRegistroSEF0470List = class;

 //LINHA 0000: ABERTURA DO ARQUIVO DIGITAL E IDENTIFICAÇÃO DO CONTRIBUINTE
  TRegistroSEF0000 = class
  private
    fNIRE: String;
    fCPF : String;
    fIE  : String;
    fUF  : String;
    fIM  : String;
    fCNPJ: String;
    fPAIS: String;

    fCOD_MUN  : String;
    fSUFRAMA  : String;
    fNOME_EMPR: String;
    fFANTASIA : String;

    fDT_INI: TDateTime;
    fDT_FIN: TDateTime;

    fCOD_FIN: TSEFIICodFinalidade;
    fCOD_CTD: TSEFIIConteudArquivo;
    fCOD_VER: TSEFIIVersaoLeiaute;
  public
    property DT_INI    : TDateTime	read fDT_INI write fDT_INI;            //Data inicial das informações contidas no arquivo	N	8	-
    property DT_FIN    : TDateTime	read fDT_FIN write fDT_FIN;            //Data final das informações contidas no arquivo	N	8	-
    property CNPJ : String read	fCNPJ write fCNPJ;                         //CNPJ do contribuinte (vedado informar CPF)	N	14	-
    property UF   : String read	fUF   write fUF;                           //Sigla da unidade da Federação do domicílio fiscal do contribuinte	C	2	-
    property IE   : String read	fIE   write fIE;                           //Inscrição estadual do contribuinte	C	-	-
    property IM   : String read	fIM   write fIM;                           //Inscrição municipal do contribuinte	C	-	-
    property CPF  : String read fCPF  write fCPF;                          //CPF do contribuinte (vedado informar CNPJ)	N	11	-
    property PAIS : String read	fPAIS write fPAIS;
    property NIRE	: String read fNIRE write fNIRE;                         //Número de Identificação do Registro de Empresas da Junta Comercial	N	11	-
    property NOME_EMPR: String	read FNOME_EMPR write FNOME_EMPR;          //Nome empresarial do contribuinte	C	-	-
    property FANTASIA : String read FFANTASIA write FFANTASIA;             //Nome de fantasia associado ao nome empresarial	C	-	-
    property COD_MUN  : String	read FCOD_MUN  write FCOD_MUN;             //Código do município do domicílio fiscal do contribuinte, conforme a tabela externa indicada no item 3.3.1	N	7	-
    property SUFRAMA  : String	read FSUFRAMA  write FSUFRAMA;             //Inscrição do contribuinte na Suframa	C	9	-
    property COD_VER : TSEFIIVersaoLeiaute read FCOD_VER write FCOD_VER; 	 //Código da versão do leiaute, de acordo com o item 3.1.1	N	4	-
    property COD_FIN : TSEFIICodFinalidade read	FCOD_FIN write FCOD_FIN;   //Código da finalidade do arquivo, conforme a tabela indicada no item 3.2.1	N	1	-
    property COD_CTD : TSEFIIConteudArquivo	read FCOD_CTD write FCOD_CTD;  //Código do conteúdo do arquivo, conforme a tabela indicada no item 3.2.2	N	2	-
  end;

  TRegistroSEF0005 = class
  private
    fCPF_RESP : String;
    fCEP      : String;
    fCEP_CP   : String;
    fCP       : String;
    fNUM      : String;
    fENDERECO : String;
    fCOMPL    : String;
    fBAIRRO   : String;
    fNOME_RESP: String;
    fEMAIL    : String;
    fFAX      : String;
    fFONE     : String;
    fCOD_ASSIN : TSEFIIQualiAssinante;
  public
    constructor Create(AOwner: TRegistroSEF0001); virtual; /// Create
    property NOME_RESP : String	read FNOME_RESP write fNOME_RESP;  // Nome do responsável	C	-
    property CPF_RESP  : String read fCPF_RESP  write fCPF_RESP;   // CPF do responsável	N	11
    property CEP       : String read fCEP       write fCEP;        // Código de Endereçamento Postal	N	8
    property NUM       : String	read fNUM       write fNUM;        // Número do imóvel	C	-
    property COMPL     : String	read fCOMPL     write fCOMPL;      // Dados complementares do endereço	C	-
    property BAIRRO    : String	read fBAIRRO    write fBAIRRO;     // Bairro em que o imóvel está situado	C	-
    property CEP_CP    : String read fCEP_CP    write fCEP_CP;     // Código de Endereçamento Postal da caixa postal	N	8
    property CP        : String read fCP        write fCP;         //	Caixa postal	N	-
    property FONE      : String	read fFONE      write fFONE;       // Número do telefone	C	-
    property FAX       : String	read fFAX       write fFAX;        // Número do fax	C	-
    property EMAIL     : String	read fEMAIL     write fEMAIL;      // Endereço do correio eletrônico	C	-
    property ENDERECO  : String	read fENDERECO  write fENDERECO;   // Endereço do imóvel	C	-
    property COD_ASSIN : TSEFIIQualiAssinante	read fCOD_ASSIN write fCOD_ASSIN; // Código de qualificação do assinante, conforme a tabela externa indicada no item 3.3.1	N	3
  end;

  //LINHA 0025: BENEFÍCIO FISCAL
  TRegistroSEF0025 = class
  private
    fCOD_BF_ICMS: TSEFIIBeniFiscalICMS;
    fCOD_BF_ISS : String;
  public
    constructor Create(AOwner: TRegistroSEF0001); virtual; /// Create
    property COD_BF_ICMS: TSEFIIBeniFiscalICMS read fCOD_BF_ICMS write fCOD_BF_ICMS;	// Código do benefício fiscal do ICMS, conforme a tabela indicada no item 6.1.1
    property COD_BF_ISS : String read fCOD_BF_ISS write fCOD_BF_ISS;	                // Código do benefício fiscal do ISS, conforme a tabela indicada no item 6.1.2
  end;

  //LINHA 0030: PERFIL DO CONTRIBUINTE
  TRegistroSEF0030 = class
  private
    fIND_ARQ : TIndicadorDocArquivo;
    fIND_ED  : TIndicadorDados;
    fIND_EC  : TIndicadorEscrContabil;
    fPRF_ISS : TIndicadorExigeEscrImposto;
    fPRF_LMC : TIndicadorExigeDiversas;
    fPRF_RI  : TIndicadorExigeDiversas;
    fPRF_RIDF: TIndicadorExigeDiversas;
    fPRF_RUDF: TIndicadorExigeDiversas;
    fPRF_RV  : TIndicadorExigeDiversas;
    fIND_ICMS: TIndicadorExigeDiversas;
    fIND_IPI : TIndicadorExigeDiversas;
    fIND_ISS : TIndicadorExigeDiversas;
    fIND_RT  : TIndicadorExigeDiversas;
    fIND_ST  : TIndicadorExigeDiversas;
    fIND_AT  : TIndicadorExigeDiversas;
    fPRF_ICMS: TIndicadorExigeEscrImposto;
    fIND_RI  : TIndicadorExigeDiversas;
  public
    constructor Create(AOwner: TRegistroSEF0001); virtual; /// Create
    property IND_ED   : TIndicadorDados         read fIND_ED   write fIND_ED;
    property IND_ARQ  : TIndicadorDocArquivo    read fIND_ARQ  write fIND_ARQ;
    property PRF_RIDF : TIndicadorExigeDiversas read fPRF_RIDF write fPRF_RIDF;
    property PRF_RUDF : TIndicadorExigeDiversas read fPRF_RUDF write fPRF_RUDF;
    property PRF_LMC  : TIndicadorExigeDiversas read fPRF_LMC  write fPRF_LMC;
    property PRF_RV   : TIndicadorExigeDiversas read fPRF_RV   write fPRF_RV;
    property PRF_RI   : TIndicadorExigeDiversas read fPRF_RI   write fPRF_RI;
    property IND_EC   : TIndicadorEscrContabil  read fIND_EC   write fIND_EC;
    property IND_ISS  : TIndicadorExigeDiversas read fIND_ISS  write fIND_ISS;
    property IND_RT   : TIndicadorExigeDiversas read fIND_RT   write fIND_RT;
    property IND_ICMS : TIndicadorExigeDiversas read fIND_ICMS write fIND_ICMS;
    property IND_ST   : TIndicadorExigeDiversas read fIND_ST   write fIND_ST;
    property IND_AT   : TIndicadorExigeDiversas read fIND_AT   write fIND_AT;
    property IND_IPI  : TIndicadorExigeDiversas read fIND_IPI  write fIND_IPI;
    property IND_RI   : TIndicadorExigeDiversas read fIND_RI   write fIND_RI;
    property PRF_ISS  : TIndicadorExigeEscrImposto read fPRF_ISS  write fPRF_ISS;
    property PRF_ICMS : TIndicadorExigeEscrImposto read fPRF_ICMS write fPRF_ICMS;
  end;

  //LINHA 0100: CONTABILISTA
  TRegistroSEF0100 = Class
  private
    fCEP_CP   : Integer;
    fCOD_MUN  : Integer;
    fCP       : Integer;
    fCEP      : String;
    fCPF      : String;
    fUF       : String;
    fNOME     : String;
    fENDERECO : String;
    fCOMPL    : String;
    fNUM      : String;
    fBAIRRO   : String;
    fFAX      : String;
    fEMAIL    : String;
    fCRC      : String;
    fFONE     : String;
    fCNPJ     : String;
    fCOD_ASSIN: TSEFIIQualiAssinante;
  public
    constructor Create(AOwner: TRegistroSEF0001); virtual; /// Create
    property NOME    : String  read fNOME     write fNOME;     // Nome do contabilista/escritório de contabilidade	C
    property CNPJ    : String  read fCNPJ     write	fCNPJ;     // CNPJ do escritório de contabilidade	N
    property CPF     : String  read fCPF	    write fCPF;      // CPF do contabilista	N
    property CRC     : String  read fCRC	    write fCRC;      // CRC do contabilista	C
    property CEP     : String  read fCEP	    write fCEP;      // Código de Endereçamento Postal	N
    property NUM     : String  read fNUM	    write fNUM;      // Número do imóvel	C
    property COMPL   : String  read fCOMPL    write fCOMPL;    // Dados complementares do endereço	C
    property BAIRRO  : String  read fBAIRRO   write fBAIRRO;   // Bairro em que o imóvel está situado	C
    property UF      : String  read fUF	      write fUF;       // Sigla da unidade da Federação do endereço do contabilista/escritório de contabilidade	C
    property CEP_CP  : Integer read fCEP_CP   write fCEP_CP;   // Código de Endereçamento Postal da caixa postal	N
    property CP	     : Integer read fCP       write fCP;       // Caixa postal	N
    property FONE    : String  read fFONE	    write fFONE;     // Número do telefone	C
    property FAX     : String  read fFAX	    write fFAX;      // Número do fax	C
    property EMAIL   : String  read fEMAIL    write fEMAIL;    // Endereço do correio eletrônico	C
    property ENDERECO: String  read fENDERECO	write fENDERECO; // Endereço do imóvel	C
    property COD_MUN : Integer read fCOD_MUN  write	fCOD_MUN;  // Código do município, conforme a tabela externa indicada no item 3.3.1	N
    property COD_ASSIN : TSEFIIQualiAssinante read fCOD_ASSIN	write FCOD_ASSIN; // Código de qualificação do assinante, conforme a tabela externa indicada no item 3.3.1	N
  end;

  ///LINHA 0150: TABELA DE CADASTRO DO PARTICIPANTE
  TRegistroSEF0150 = class
  private
    fCOD_PAIS: String;
    fCPF     : String;
    fSUFRAMA : String;
    fIE      : String;
    fIM      : String;
    fCNPJ    : String;
    fUF      : String;
    fNOME    : String;
    fIE_ST   : String;
    fCOD_PART: String;
    fCOD_MUN : Integer;
  public
    constructor Create(AOwner: TRegistroSEF0001); virtual; /// Create
    property COD_PART: String  read fCOD_PART write fCOD_PART;  // Código próprio de identificação do participante no arquivo	C
    property NOME    : String  read fNOME	    write fNOME;      // Nome pessoal ou empresarial do participante	C
    property COD_PAIS: String  read fCOD_PAIS write fCOD_PAIS;  // Código do país do participante, conforme a tabela externa indicada no item 3.3.1	N
    property CNPJ    : String  read fCNPJ     write fCNPJ;	    // CNPJ do participante	N
    property CPF     : String  read fCPF      write fCPF;	      // CPF do participante	N
    property UF      : String  read fUF       write fUF;       	// Sigla da unidade da Federação do participante	C
    property IE      : String  read fIE       write fIE;	      // Inscrição estadual do participante	C
    property IE_ST   : String  read fIE_ST    write fIE_ST;	    // Inscrição estadual do participante emitente contribuinte-substituto na unidade da Federação do destinatário substituído	C
    property COD_MUN : Integer read fCOD_MUN  write fCOD_MUN;	  // Código do município, conforme a tabela externa indicada no item 3.3.1	N
    property IM      : String  read fIM       write fIM;	      // Inscrição municipal do participante	C
    property SUFRAMA : String  read fSUFRAMA  write fSUFRAMA;	  // Número de inscrição do participante na Suframa	C
  end;

  // Registro 0150 - Lista
  TRegistroSEF0150List = class(TACBrSEFIIRegistros)
  private
    function GetItem(Index: Integer): TRegistroSEF0150;
    procedure SetItem(Index: Integer; const Value: TRegistroSEF0150);
  public
    function New(AOwner: TRegistroSEF0001): TRegistroSEF0150;
    property Items[Index: Integer]: TRegistroSEF0150 read GetItem write SetItem;
  end;

  TRegistroSEF0200 = class
  private
    FCOD_ITEM    : String;
    FDESCR_ITEM  : String;
    FCOD_GEN     : String;
    FCOD_LST     : String;
    FRegistro0205: TRegistroSEF0205List;
  public
    constructor Create(AOwner: TRegistroSEF0001); virtual; /// Create
    destructor Destroy; override; /// Destroy
    property COD_ITEM    : String  read fCOD_ITEM   write fCOD_ITEM;
    property DESCR_ITEM  : String  read fDESCR_ITEM write fDESCR_ITEM;
    property COD_GEN     : String  read fCOD_GEN    write fCOD_GEN;
    property COD_LST     : String  read fCOD_LST    write fCOD_LST;
    property Registro0205: TRegistroSEF0205List read FRegistro0205 write FRegistro0205;
  end;

  // Registro 0200 - Lista
  TRegistroSEF0200List = class(TACBrSEFIIRegistros)
  private
    function GetItem(Index: Integer): TRegistroSEF0200;
    procedure SetItem(Index: Integer; const Value: TRegistroSEF0200);
  public
    function New(AOwner: TRegistroSEF0001): TRegistroSEF0200;
    property Items[Index: Integer]: TRegistroSEF0200 read GetItem write SetItem;
  end;

  //LINHA 0001: ABERTURA DO BLOCO 0
  TRegistroSEF0001 = class(TOpenBlocos)
  private
    fRegistro0005: TRegistroSEF0005;
    fRegistro0025: TRegistroSEF0025;
    fRegistro0030: TRegistroSEF0030;
    fRegistro0100: TRegistroSEF0100;
    fRegistro0150: TRegistroSEF0150List;
    fRegistro0200: TRegistroSEF0200List;
    fRegistro0400: TRegistroSEF0400List;
  public
    constructor Create; virtual; /// Create
    destructor Destroy; override; /// Destroy
    property Registro005 : TRegistroSEF0005 read fRegistro0005 write fRegistro0005;
    property Registro025 : TRegistroSEF0025 read fRegistro0025 write fRegistro0025;
    property Registro030 : TRegistroSEF0030 read fRegistro0030 write fRegistro0030;
    property Registro0100: TRegistroSEF0100 read fRegistro0100 write fRegistro0100;
    property Registro0150: TRegistroSEF0150List read fRegistro0150 write fRegistro0150;
    property Registro0200: TRegistroSEF0200List read fRegistro0200 write fRegistro0200;
    property Registro0400: TRegistroSEF0400List read fRegistro0400 write fRegistro0400;
  end;

  TRegistroSEF0205 = class
  private
    fCOD_ITEM_ANT  : Integer;
    fDESCR_ITEM_ANT: Integer;

    fDT_INI: TDateTime;
    fDT_FIN: TDateTime;
  public
    constructor Create(AOwner: TRegistroSEF0200); virtual; /// Create
    property COD_ITEM_ANT   : Integer read fCOD_ITEM_ANT   write fCOD_ITEM_ANT;
    property DESCR_ITEM_ANT : Integer read FDESCR_ITEM_ANT write fDESCR_ITEM_ANT;
    property DT_INI : TDateTime read fDT_INI write fDT_INI;
    property DT_FIN : TDateTime read fDT_FIN write fDT_FIN;
  end;

  // Registro 0205 - Lista
  TRegistroSEF0205List = class(TACBrSEFIIRegistros)
  private
    function GetItem(Index: Integer): TRegistroSEF0205;
    procedure SetItem(Index: Integer; const Value: TRegistroSEF0205);
  public
    function New(AOwner: TRegistroSEF0200): TRegistroSEF0205;
    property Items[Index: Integer]: TRegistroSEF0205 read GetItem write SetItem;
  end;

  //REGISTRO 0400: TABELA DE NATUREZA DA OPERAÇÃO/PRESTAÇÃO
  TRegistroSEF0400 = class
  private
    fCOD_NAT     : String; //Código da natureza da operação/prestação
    fDESCR_NAT   : String;
    fCFOP        : String;
    fRegistro0450: TRegistroSEF0450List;

    function GetCFOP: String;
  public
    constructor Create(AOwner: TRegistroSEF0001); virtual; /// Create
    destructor Destroy; override; /// Destroy
    property COD_NAT     : String read fCOD_NAT   write fCOD_NAT;
    property DESCR_NAT   : String read fDESCR_NAT write fDESCR_NAT;
    property CFOP        : String read GetCFOP    write fCFOP;
    property Registro0450: TRegistroSEF0450List read fRegistro0450 write fRegistro0450;
  end;

  // Registro 0400 - Lista
  TRegistroSEF0400List = class(TACBrSEFIIRegistros)
  private
    function GetItem(Index: Integer): TRegistroSEF0400;
    procedure SetItem(Index: Integer; const Value: TRegistroSEF0400);
  public
    function New(AOwner: TRegistroSEF0001): TRegistroSEF0400;
    property Items[Index: Integer]: TRegistroSEF0400 read GetItem write SetItem;
  end;

  //LINHA 0450: TABELA DE INFORMAÇÕES COMPLEMENTARES/REGISTRO DE OBSERVAÇÕES
  TRegistroSEF0450 = class
  private
    fCOD_INF : String; //Código da informação complementar do documento fiscal.
    fTXT     : String;
    fRegistro0460: TRegistroSEF0460List;
    fRegistro0465: TRegistroSEF0465List;
    fRegistro0470: TRegistroSEF0470List;
  public
    constructor Create(AOwner: TRegistroSEF0400); virtual; /// Create
    property COD_INF : String read fCOD_INF write fCOD_INF;
    property TXT     : String read fTXT     write fTXT;
    property Registro0460: TRegistroSEF0460List read fRegistro0460 write fRegistro0460;
    property Registro0465: TRegistroSEF0465List read fRegistro0465 write fRegistro0465;
    property Registro0470: TRegistroSEF0470List read fRegistro0470 write fRegistro0470;
  end;

  // Registro 0450 - Lista
  TRegistroSEF0450List = class(TACBrSEFIIRegistros)
  private
    function GetItem(Index: Integer): TRegistroSEF0450;
    procedure SetItem(Index: Integer; const Value: TRegistroSEF0450);
  public
    function New(AOwner: TRegistroSEF0400): TRegistroSEF0450;
    property Items[Index: Integer]: TRegistroSEF0450 read GetItem write SetItem;
  end;

  TRegistroSEF0460 = class
  private
    fVL_MOR  : Currency;
    fVL_PGTO : Currency;
    fVL_DESC : Currency;
    fVL_DA   : Currency;
    fVL_JRS  : Currency;
    fVL_MUL  : Currency;
    fCOD_MUN : Integer;
    fPER_REF : Integer;
    fDESCR_DA: String;
    fNUM_DA  : String;
    fUF      : String;
    fAUT_BCO : String;
    fDT_PGTO : TDateTime;
    fDT_VCTO : TDateTime;
    fIND_DA  : TSEFIIIndicadorDocArregadacao;
  public
    constructor Create(AOwner: TRegistroSEF0450); virtual; /// Create
    property AIND_DA	: TSEFIIIndicadorDocArregadacao read fIND_DA write FIND_DA; // "Indicador do documento de arrecadação:
    property DESCR_DA : String    read fDESCR_DA write fDESCR_DA;                 // Descrição complementar do documento de arrecadação	C
    property UF       : String    read fUF       write fUF;	                      // Unidade da Federação de destino do pagamento	C
    property COD_MUN  : Integer   read fCOD_MUN  write fCOD_MUN;	               	// Código do município de destino do pagamento, conforme a tabela externa indicada no item 3.3.1	N
    property PER_REF  : Integer   read fPER_REF  write fPER_REF;		              // Período fiscal de referência	N
    property NUM_DA   : String    read fNUM_DA   write fNUM_DA;	                  // Número do documento de arrecadação	C
    property VL_DA    : Currency  read fVL_DA    write fVL_DA;                   	// Valor do documento de arrecadação	N
    property DT_VCTO  : TDateTime read fDT_VCTO  write fDT_VCTO;               		// Data de vencimento do documento de arrecadação	N
    property VL_DESC  : Currency  read fVL_DESC  write fVL_DESC;                  // Valor dos descontos	N
    property VL_MOR   : Currency  read fVL_MOR   write fVL_MOR;	                  // Valor da multa de mora	N
    property VL_JRS   : Currency  read fVL_JRS   write fVL_JRS;	                  // Valor dos juros	N
    property VL_MUL   : Currency  read fVL_MUL   write fVL_MUL;	                  // Valor das multas	N
    property VL_PGTO  : Currency  read fVL_PGTO  write fVL_PGTO;	                // Valor do pagamento	N
    property DT_PGTO  : TDateTime read fDT_PGTO  write fDT_PGTO;		              // Data de pagamento do documento de arrecadação	N
    property AUT_BCO  : String    read fAUT_BCO  write fAUT_BCO;	                // Código da autenticação bancária 	C
  end;

  // Registro 0460 - Lista
  TRegistroSEF0460List = class(TACBrSEFIIRegistros)
  private
    function GetItem(Index: Integer): TRegistroSEF0460;
    procedure SetItem(Index: Integer; const Value: TRegistroSEF0460);
  public
    function New(AOwner: TRegistroSEF0450): TRegistroSEF0460;
    property Items[Index: Integer]: TRegistroSEF0460 read GetItem write SetItem;
  end;

  //LINHA 0465: DOCUMENTO FISCAL REFERENCIADO
  TRegistroSEF0465 = class
  private
    fVL_RT      : Currency;
    fVL_ISS     : Currency;
    fVL_DOC     : Currency;
    fVL_IPI     : Currency;
    fVL_ICMS_ST : Currency;
    fVOL        : Currency;
    fVL_ICMS    : Currency;
    fVL_AT      : Currency;
    fIE         : String;
    fNUM_DOC    : String;
    fCHV_NFE_CTE: String;
    fFIND_EMIT  : String;
    fCOD_MUN    : String;
    fCPF        : String;
    fCOD_MOD    : String;
    fIM         : String;
    fCNPJ       : String;
    fCOD_SIT    : String;
    fFIND_OPER  : String;
    fSER        : String;
    fSUB        : String;
    fUF         : String;
    fDT_DOC     : TDateTime;
  public
    constructor Create(AOwner: TRegistroSEF0450); virtual; /// Create
    property IND_OPER    : String	read FFIND_OPER   write FFIND_OPER;    // "Indicador de operação:0- Entrada ou aquisição1- Saída ou prestação"
    property IND_EMIT    : String read FFIND_EMIT   write FFIND_EMIT;  	 // "Indicador de emitente:0- Emissão própria1- Emissão por terceiros"
    property CNPJ        : String read FCNPJ        write FCNPJ;         //	CNPJ : String do contribuinte
    property CPF         : String read FCPF         write FCPF;	         // CPF do contribuinte
    property UF          : String read FUF          write FUF;           // Sigla da unidade da Federação do contribuinte
    property IE          : String read FIE          write FIE;	         // Inscrição estadual do contribuinte
    property COD_MUN     : String	read FCOD_MUN     write FCOD_MUN;      // Código do município do contribuinte, conforme a tabela externa indicada no item 3.3.1
    property IM          : String read FIM          write FIM;	         // Inscrição municipal do contribuinte
    property COD_MOD     : String	read FCOD_MOD     write FCOD_MOD;      // Código do documento fiscal, conforme a tabela indicada no item 4.1.1 ou no item 4.1.2
    property COD_SIT     : String	read FCOD_SIT     write FCOD_SIT;      // Código da situação do documento fiscal, conforme a tabela indicada no item 4.1.3
    property SER         : String	read FSER         write FSER;          // Série do documento fiscal
    property SUB         : String	read FSUB         write FSUB;          // Subsérie do documento fiscal
    property CHV_NFE_CTE : String	read FCHV_NFE_CTE write FCHV_NFE_CTE;  // Chave de acesso da NF-e/CT-e (somente para os documentos código 55 ou 57)
    property NUM_DOC     : String	read FNUM_DOC     write FNUM_DOC;      // Número do documento fiscal
    property DT_DOC      : TDateTime read FDT_DOC     write FDT_DOC;     // Na entrada ou aquisição: data da entrada da mercadoria, da aquisição do serviço, do desembaraço aduaneiro ou do lançamento no livro correspondente; na saída ou prestação: data da emissão do documento fiscal, da saída da mercadoria ou do lançamento no livro correspondente
    property VL_DOC      : Currency  read FVL_DOC     write FVL_DOC;	   // Valor do documento fiscal
    property VL_ISS      : Currency  read FVL_ISS     write FVL_ISS;	   // Valor do ISS
    property VL_RT       : Currency  read FVL_RT      write FVL_RT;	     // Valor do ISS retido
    property VL_ICMS     : Currency	 read FVL_ICMS    write FVL_ICMS;    // Valor do ICMS
    property VL_ICMS_ST  : Currency  read FVL_ICMS_ST write FVL_ICMS_ST; // Valor do ICMS da substituição tributária
    property VL_AT       : Currency	 read FVL_AT      write FVL_AT;      // Valor do ICMS da antecipação tributária, nas entradas
    property VL_IPI      : Currency  read FVL_IPI     write FVL_IPI;	   // Valor do IPI
    property VOL         : Currency  read FVOL        write FVOL;	       // Volume transportado
  end;

  // Registro 0465 - Lista
  TRegistroSEF0465List = class(TACBrSEFIIRegistros)
  private
    function GetItem(Index: Integer): TRegistroSEF0465;
    procedure SetItem(Index: Integer; const Value: TRegistroSEF0465);
  public
    function New(AOwner: TRegistroSEF0450): TRegistroSEF0465;
    property Items[Index: Integer]: TRegistroSEF0465 read GetItem write SetItem;
  end;

  // LINHA 0470: CUPOM FISCAL REFERENCIADO
  TRegistroSEF0470 = class
  private
    fVL_DOC : Currency;
    fVL_ISS : Currency;
    fVL_ICMS: Currency;
    fCRO    : Integer;
    fNUM_DOC: Integer;
    fCRZ    : Integer;
    fECF_CX : Integer;
    fECF_FAB: String;
    fDT_DOC : TDateTime;
    fCOD_MOD: TSEFIIDocFiscalReferenciado;
  public
    constructor Create(AOwner: TRegistroSEF0450); virtual; /// Create
    property COD_MOD : TSEFIIDocFiscalReferenciado read fCOD_MOD write fCOD_MOD;
    property ECF_FAB : String    read fECF_FAB write fECF_FAB;
    property ECF_CX  : Integer   read fECF_CX  write fECF_CX;
    property CRO     : Integer   read fCRO     write fCRO;
    property CRZ     : Integer   read fCRZ     write fCRZ;
    property NUM_DOC : Integer   read fNUM_DOC write fNUM_DOC;
    property DT_DOC  : TDateTime read fDT_DOC  write fDT_DOC;
    property VL_DOC  : Currency  read fVL_DOC  write fVL_DOC;
    property VL_ISS  : Currency  read fVL_ISS  write fVL_ISS;
    property VL_ICMS : Currency  read fVL_ICMS write fVL_ICMS;
  end;

  // Registro 0470 - Lista
  TRegistroSEF0470List = class(TACBrSEFIIRegistros)
  private
    function GetItem(Index: Integer): TRegistroSEF0470;
    procedure SetItem(Index: Integer; const Value: TRegistroSEF0470);
  public
    function New(AOwner: TRegistroSEF0450): TRegistroSEF0470;
    property Items[Index: Integer]: TRegistroSEF0470 read GetItem write SetItem;
  end;

  /// Registro 0990 - ENCERRAMENTO DO BLOCO 0

  TRegistroSEF0990 = class
  private
    fQTD_LIN_0: Integer; /// Quantidade total de linhas do Bloco 0
  public
    property QTD_LIN_0: Integer read fQTD_LIN_0 write fQTD_LIN_0;
  end;

implementation

{ TRegistroSEF001 }

constructor TRegistroSEF0001.Create;
begin
   FRegistro0005 := TRegistroSEF0005.Create(self);
   FRegistro0025 := TRegistroSEF0025.Create(self);
   FRegistro0030 := TRegistroSEF0030.Create(self);
   FRegistro0100 := TRegistroSEF0100.Create(self);
   FRegistro0150 := TRegistroSEF0150List.Create;
   FRegistro0200 := TRegistroSEF0200List.Create;
   fRegistro0400 := TRegistroSEF0400List.Create;

   IND_MOV := icContConteudo;
end;

destructor TRegistroSEF0001.Destroy;
begin
   FRegistro0005.Free;
   FRegistro0025.Free;
   FRegistro0030.Free;
   FRegistro0100.Free;
   FRegistro0150.Free;
   FRegistro0200.Free;
   fRegistro0400.Free;
   inherited;
end;

{ TRegistroSEF005 }

constructor TRegistroSEF0005.Create(AOwner: TRegistroSEF0001);
begin

end;

{ TRegistroSEF0025 }

constructor TRegistroSEF0025.Create(AOwner: TRegistroSEF0001);
begin

end;

{ TRegistroSEF0100 }

constructor TRegistroSEF0100.Create(AOwner: TRegistroSEF0001);
begin

end;

{ TRegistroSEF0150List }

function TRegistroSEF0150List.GetItem(Index: Integer): TRegistroSEF0150;
begin
  Result := TRegistroSEF0150(Get(Index));
end;

function TRegistroSEF0150List.New(AOwner: TRegistroSEF0001): TRegistroSEF0150;
begin
  Result := TRegistroSEF0150.create(AOwner);
  Add(Result);
end;

procedure TRegistroSEF0150List.SetItem(Index: Integer;
  const Value: TRegistroSEF0150);
begin
  Put(Index, Value);
end;

{ TRegistroSEF0400 }

constructor TRegistroSEF0400.Create(AOwner: TRegistroSEF0001);
begin
   FRegistro0450 := TRegistroSEF0450List.Create;
end;

destructor TRegistroSEF0400.Destroy;
begin
   FRegistro0450.Free;
   inherited;
end;

function TRegistroSEF0400.GetCFOP: STRING;
begin
  Case StrToInt(FCFOP) of
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

{ TRegistroSEF0400List }

function TRegistroSEF0400List.GetItem(Index: Integer): TRegistroSEF0400;
begin
  Result := TRegistroSEF0400(Get(Index));
end;

function TRegistroSEF0400List.New(AOwner: TRegistroSEF0001): TRegistroSEF0400;
begin
  Result := TRegistroSEF0400.create(AOwner);
  Add(Result);
end;

procedure TRegistroSEF0400List.SetItem(Index: Integer;
  const Value: TRegistroSEF0400);
begin
  Put(Index, Value);
end;

{ TRegistroSEF0450List }

function TRegistroSEF0450List.GetItem(Index: Integer): TRegistroSEF0450;
begin
  Result := TRegistroSEF0450(Get(Index));
end;

function TRegistroSEF0450List.New(AOwner: TRegistroSEF0400): TRegistroSEF0450;
begin
  Result := TRegistroSEF0450.Create(AOwner);
  Add(Result);
end;

procedure TRegistroSEF0450List.SetItem(Index: Integer;
  const Value: TRegistroSEF0450);
begin
  Put(Index, Value);
end;

{ TRegistroSEF0460List }

function TRegistroSEF0460List.GetItem(Index: Integer): TRegistroSEF0460;
begin
  Result := TRegistroSEF0460(Get(Index));
end;

function TRegistroSEF0460List.New(AOwner: TRegistroSEF0450): TRegistroSEF0460;
begin
  Result := TRegistroSEF0460.Create(AOwner);
  Add(Result);
end;

procedure TRegistroSEF0460List.SetItem(Index: Integer;
  const Value: TRegistroSEF0460);
begin
  Put(Index, Value);
end;

{ TRegistroSEF0465 }

constructor TRegistroSEF0465.Create(AOwner: TRegistroSEF0450);
begin

end;

{ TRegistroSEF0465List }

function TRegistroSEF0465List.GetItem(Index: Integer): TRegistroSEF0465;
begin
  Result := TRegistroSEF0465(Get(Index));
end;

function TRegistroSEF0465List.New(AOwner: TRegistroSEF0450): TRegistroSEF0465;
begin
  Result := TRegistroSEF0465.Create(AOwner);
  Add(Result);
end;

procedure TRegistroSEF0465List.SetItem(Index: Integer;
  const Value: TRegistroSEF0465);
begin
  Put(Index, Value);
end;

{ TRegistroSEF0470List }

function TRegistroSEF0470List.GetItem(Index: Integer): TRegistroSEF0470;
begin
  Result := TRegistroSEF0470(Get(Index));
end;

function TRegistroSEF0470List.New(AOwner: TRegistroSEF0450): TRegistroSEF0470;
begin
  Result := TRegistroSEF0470.Create(AOwner);
  Add(Result);
end;

procedure TRegistroSEF0470List.SetItem(Index: Integer;
  const Value: TRegistroSEF0470);
begin
  Put(Index, Value);
end;

{ TRegistroSEF0200 }

constructor TRegistroSEF0200.Create(AOwner: TRegistroSEF0001);
begin
   FRegistro0205 := TRegistroSEF0205List.Create;
end;

destructor TRegistroSEF0200.Destroy;
begin
   FRegistro0205.Free;
   inherited;
end;

{ TRegistroSEF0200List }

function TRegistroSEF0200List.GetItem(Index: Integer): TRegistroSEF0200;
begin
  Result := TRegistroSEF0200(Get(Index));
end;

function TRegistroSEF0200List.New(AOwner: TRegistroSEF0001): TRegistroSEF0200;
begin
  Result := TRegistroSEF0200.create(AOwner);
  Add(Result);
end;

procedure TRegistroSEF0200List.SetItem(Index: Integer;
  const Value: TRegistroSEF0200);
begin
  Put(Index, Value);
end;

{ TRegistroSEF0205 }

{ TRegistroSEF0205List }

function TRegistroSEF0205List.GetItem(Index: Integer): TRegistroSEF0205;
begin
  Result := TRegistroSEF0205(Get(Index));
end;

function TRegistroSEF0205List.New(AOwner: TRegistroSEF0200): TRegistroSEF0205;
begin
  Result := TRegistroSEF0205.create(AOwner);
  Add(Result);
end;

procedure TRegistroSEF0205List.SetItem(Index: Integer;
  const Value: TRegistroSEF0205);
begin
  Put(Index, Value);
end;

{ TRegistroSEF0030 }

constructor TRegistroSEF0030.Create(AOwner: TRegistroSEF0001);
begin

end;

{ TRegistroSEF0150 }

constructor TRegistroSEF0150.Create(AOwner: TRegistroSEF0001);
begin

end;

{ TRegistroSEF0205 }

constructor TRegistroSEF0205.Create(AOwner: TRegistroSEF0200);
begin

end;

{ TRegistroSEF0450 }

constructor TRegistroSEF0450.Create(AOwner: TRegistroSEF0400);
begin
   FRegistro0460 := TRegistroSEF0460List.Create;
   FRegistro0465 := TRegistroSEF0465List.Create;
   FRegistro0470 := TRegistroSEF0470List.Create;
end;

{ TRegistroSEF0460 }

constructor TRegistroSEF0460.Create(AOwner: TRegistroSEF0450);
begin

end;

{ TRegistroSEF0470 }

constructor TRegistroSEF0470.Create(AOwner: TRegistroSEF0450);
begin

end;

end.
