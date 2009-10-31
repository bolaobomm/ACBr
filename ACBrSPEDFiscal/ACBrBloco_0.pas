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

unit ACBrBloco_0;

interface

uses
  SysUtils, Classes, DateUtils, ACBrBlocos;

type
  /// Registro 0000 - ABERTURA DO ARQUIVO DIGITAL E IDENTIFICA��O DA ENTIDADE

  TRegistro0000 = class(TPersistent)
  private
    fCOD_VER: integer;     /// C�digo da vers�o do leiaute: 100; 101
    fCOD_FIN: integer;     /// C�digo da finalidade do arquivo: 0 - Remessa do arquivo original / 1 - Remessa do arquivo substituto.
    fDT_INI: TDateTime;    /// Data inicial das informa��es contidas no arquivo
    fDT_FIN: TDateTime;    /// Data final das informa��es contidas no arquivo
    fNOME: string;         /// Nome empresarial do contribuinte:
    fCNPJ: string;         /// N�mero de inscri��o do contribuinte:
    fCPF: string;          /// N�mero de inscri��o do contribuinte:
    fUF: string;           /// Sigla da unidade da federa��o:
    fIE: string;           /// Inscri��o Estadual do contribuinte:
    fCOD_MUN: integer;     /// C�digo do munic�pio do domic�lio fiscal:
    fIM: string;           /// Inscri��o Municipal do contribuinte:
    fSUFRAMA: string;      /// N�mero de inscri��o do contribuinte:
    fIND_PERFIL: string;   /// Perfil de apresenta��o do arquivo fiscal: A - Perfil A / B - Perfil B / C - Perfil C
    fIND_ATIV: integer;    /// Indicador de tipo de atividade: 0 - Industrial ou equiparado a industrial; 1 - Outros.
  public
    property COD_VER: integer read FCOD_VER write FCOD_VER;
    property COD_FIN: integer read FCOD_FIN write FCOD_FIN;
    property DT_INI: TDateTime read FDT_INI write FDT_INI;
    property DT_FIN: TDateTime read FDT_FIN write FDT_FIN;
    property NOME: string read FNOME write FNOME;
    property CNPJ: string read FCNPJ write FCNPJ;
    property CPF: string read FCPF write FCPF;
    property UF: string read FUF write FUF;
    property IE: string read FIE write FIE;
    property COD_MUN: integer read FCOD_MUN write FCOD_MUN;
    property IM: string read FIM write FIM;
    property SUFRAMA: string read FSUFRAMA write FSUFRAMA;
    property IND_PERFIL: string read FIND_PERFIL write FIND_PERFIL;
    property IND_ATIV: integer read FIND_ATIV write FIND_ATIV;
  end;

  /// Registro 0001 - ABERTURA DO BLOCO 0

  TRegistro0001 = class(TOpenBlocos)
  private
  public
  end;

  /// Registro 0005 - DADOS COMPLEMENTARES DA ENTIDADE

  TRegistro0005 = class(TPersistent)
  private
    fFANTASIA: string;     /// Nome de fantasia associado:
    fCEP: string;          /// C�digo de Endere�amento Postal:
    fENDERECO: string;     /// Logradouro e endere�o do im�vel:
    fNUM: string;          /// N�mero do im�vel:
    fCOMPL: string;        /// Dados complementares do endere�o:
    fBAIRRO: string;       /// Bairro em que o im�vel est� situado:
    fFONE: string;         /// N�mero do telefone:
    fFAX: string;          /// N�mero do fax:
    fEMAIL: string;        /// Endere�o do correio eletr�nico:
  public
    property FANTASIA: string read fFANTASIA write fFANTASIA;
    property CEP: string read FCEP write FCEP;
    property ENDERECO: string read FENDERECO write FENDERECO;
    property NUM: string read FNUM write FNUM;
    property COMPL: string read FCOMPL write FCOMPL;
    property BAIRRO: string read FBAIRRO write FBAIRRO;
    property FONE: string read FFONE write FFONE;
    property FAX: string read FFAX write FFAX;
    property EMAIL: string read FEMAIL write FEMAIL;
  end;

  /// Registro 0015 - DADOS DO CONTRIBUINTE SUBSTITUTO

  TRegistro0015 = class(TPersistent)
  private
    fUF_ST: string;   /// Sigla da unidade da federa��o:
    fIE_ST: string;   /// Inscri��o Estadual:
  public
    property UF_ST: string read FUF_ST write FUF_ST;
    property IE_ST: string read FIE_ST write FIE_ST;
  end;

  /// Registro 0100 - DADOS DO CONTABILISTA

  TRegistro0100 = class(TPersistent)
  private
    fNOME: string;        /// Nome do contabilista/escrit�rio:
    fCPF: string;         /// N�mero de inscri��o no CPF:
    fCRC: string;         /// N�mero de inscri��o no Conselho Regional:
    fCNPJ: string;        /// CNPJ do escrit�rio de contabilidade, se houver:
    fCEP: string;         /// C�digo de Endere�amento Postal:
    fENDERECO: string;    /// Logradouro e endere�o do im�vel:
    fNUM: string;         /// N�mero do im�vel:
    fCOMPL: string;       /// Dados complementares do endere�o:
    fBAIRRO: string;      /// Bairro em que o im�vel est� situado:
    fFONE: string;        /// N�mero do telefone:
    fFAX: string;         /// N�mero do fax:
    fEMAIL: string;       /// Endere�o do correio eletr�nico:
    fCOD_MUN: integer;    /// C�digo do munic�pio, conforme tabela IBGE:
  public
    property NOME: string read FNOME write FNOME;
    property CPF: string read FCPF write FCPF;
    property CRC: string read FCRC write FCRC;
    property CNPJ: string read FCNPJ write FCNPJ;
    property CEP: string read FCEP write FCEP;
    property ENDERECO: string read FENDERECO write FENDERECO;
    property NUM: string read FNUM write FNUM;
    property COMPL: string read FCOMPL write FCOMPL;
    property BAIRRO: string read FBAIRRO write FBAIRRO;
    property FONE: string read FFONE write FFONE;
    property FAX: string read FFAX write FFAX;
    property EMAIL: string read FEMAIL write FEMAIL;
    property COD_MUN: integer read FCOD_MUN write FCOD_MUN;
  end;

  /// Registro 0150 - TABELA DE CADASTRO DO PARTICIPANTE

  TRegistro0150 = class(TPersistent)
  private
    fCOD_PART: string;    /// C�digo de identifica��o do participante:
    fNOME: string;        /// Nome pessoal ou empresarial:
    fCOD_PAIS: string;    /// C�digo do pa�s do participante:
    fCNPJ: string;        /// CNPJ do participante:
    fCPF: string;         /// CPF do participante na unidade da federa��o do destinat�rio:
    fIE: string;          /// Inscri��o Estadual do participante:
    fCOD_MUN: integer;    /// C�digo do munic�pio:
    fSUFRAMA: string;     /// N�mero de inscri��o na Suframa:
    fENDERECO: string;    /// Logradouro e endere�o do im�vel:
    fNUM: string;         /// N�mero do im�vel:
    fCOMPL: string;       /// Dados complementares do endere�o:
    fBAIRRO: string;      /// Bairro em que o im�vel est� situado:
  public
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property NOME: string read FNOME write FNOME;
    property COD_PAIS: string read FCOD_PAIS write FCOD_PAIS;
    property CNPJ: string read FCNPJ write FCNPJ;
    property CPF: string read FCPF write FCPF;
    property IE: string read FIE write FIE;
    property COD_MUN: integer read FCOD_MUN write FCOD_MUN;
    property SUFRAMA: string read FSUFRAMA write FSUFRAMA;
    property ENDERECO: string read FENDERECO write FENDERECO;
    property NUM: string read FNUM write FNUM;
    property COMPL: string read FCOMPL write FCOMPL;
    property BAIRRO: string read FBAIRRO write FBAIRRO;
  end;

  /// Registro 0150 - Lista

  TRegistro0150List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0150;
    procedure SetItem(Index: Integer; const Value: TRegistro0150);
  public
    destructor Destroy; override;
    function New: TRegistro0150;
    property Items[Index: Integer]: TRegistro0150 read GetItem write SetItem;
  end;

  /// Registro 0175 - ALTERA��O DA TABELA DE CADASTRO DE PARTICIPANTE

  TRegistro0175 = class(TPersistent)
  private
    fDT_ALT: TDateTime;      /// Data de altera��o do cadastro:
    fNR_CAMPO: string;       /// N�mero do campo alterado (Somente campos 03 a 13):
    fCONT_ANT: string;       /// Conte�do anterior do campo:
  public
    property DT_ALT: TDateTime read FDT_ALT write FDT_ALT;
    property NR_CAMPO: string read FNR_CAMPO write FNR_CAMPO;
    property CONT_ANT: string read FCONT_ANT write FCONT_ANT;
  end;

  /// Registro 0175 - Lista

  TRegistro0175List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0175;
    procedure SetItem(Index: Integer; const Value: TRegistro0175);
  public
    destructor Destroy; override;
    function New: TRegistro0175;
    property Items[Index: Integer]: TRegistro0175 read GetItem write SetItem;
  end;

  /// Registro 0190 - IDENTIFICA��O DAS UNIDADES DE MEDIDA

  TRegistro0190 = class(TPersistent)
  private
    fUNID: string;        /// C�digo da unidade de medida:
    fDESCR: string;       /// Descri��o da unidade de medida:
  public
    property UNID: string read FUNID write FUNID;
    property DESCR: string read FDESCR write FDESCR;
  end;

  /// Registro 0190 - Lista

  TRegistro0190List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0190;
    procedure SetItem(Index: Integer; const Value: TRegistro0190);
  public
    destructor Destroy; override;
    function New: TRegistro0190;
    property Items[Index: Integer]: TRegistro0190 read GetItem write SetItem;
  end;

  /// Registro 0200 - TABELA DE IDENTIFICA��O DO ITEM (PRODUTO E SERVI�OS)

  TRegistro0200 = class(TPersistent)
  private
    fCOD_ITEM: string;       /// C�digo do item:
    fDESCR_ITEM: string;     /// Descri��o do item:
    fCOD_BARRA: string;      /// C�digo de barra do produto, se houver:
    fCOD_ANT_ITEM: string;   /// C�digo anterior do item (ultima apresentado):
    fUNID_INV: string;       /// Unidade de medida do estoque:
    fTIPO_ITEM: string;      /// Tipo do item - Atividades Industriais, Comerciais e Servi�os: 00 - Mercadoria para Revenda, 01 - Mat�ria-Prima,  02 - Embalagem, 03 - Produto em Processo, 04 - Produto Acabado, 05 - Subproduto, 06 - Produto Intermedi�rio, 07 - Material de Uso e Consumo, 08 - Ativo Imobilizado, 09 - Servi�os, 10 - Outros insumos, 99 - Outras
    fCOD_NCM: string;        /// C�digo da Nomenclatura Comum do Mercosul:
    fEX_IPI: string;         /// C�digo EX, conforme a TIPI:
    fCOD_GEN: string;        /// C�digo g�nero item, tabela indicada item 4.2.1:
    fCOD_LST: string;        /// C�digo servi�o Anexo I - Lei n�116/03:
    fALIQ_ICMS: string;      /// Al�quota ICMS aplic�vel (opera��es internas):
  public
    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property DESCR_ITEM: string read FDESCR_ITEM write FDESCR_ITEM;
    property COD_BARRA: string read FCOD_BARRA write FCOD_BARRA;
    property COD_ANT_ITEM: string read FCOD_ANT_ITEM write FCOD_ANT_ITEM;
    property UNID_INV: string read FUNID_INV write FUNID_INV;
    property TIPO_ITEM: string read FTIPO_ITEM write FTIPO_ITEM;
    property COD_NCM: string read FCOD_NCM write FCOD_NCM;
    property EX_IPI: string read FEX_IPI write FEX_IPI;
    property COD_GEN: string read FCOD_GEN write FCOD_GEN;
    property COD_LST: string read FCOD_LST write FCOD_LST;
    property ALIQ_ICMS: string read FALIQ_ICMS write FALIQ_ICMS;
  end;

  /// Registro 0200 - Lista

  TRegistro0200List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0200;
    procedure SetItem(Index: Integer; const Value: TRegistro0200);
  public
    destructor Destroy; override;
    function New: TRegistro0200;
    property Items[Index: Integer]: TRegistro0200 read GetItem write SetItem;
  end;

  /// Registro 0205 - C�DIGO ANTERIOR DO ITEM

  TRegistro0205 = class(TPersistent)
  private
    fDESCR_ANT_ITEM: string;    /// Descri��o anterior do item:
    fDT_INI: TDateTime;         /// Data inicial de utiliza��o do c�digo:
    fDT_FIN: TDateTime;         /// Data final de utiliza��o do c�digo:
  public
    property DESCR_ANT_ITEM: string read FDESCR_ANT_ITEM write FDESCR_ANT_ITEM;
    property DT_INI: TDateTime read FDT_INI write FDT_INI;
    property DT_FIN: TDateTime read FDT_FIN write FDT_FIN;
  end;

  /// Registro 0205 - Lista

  TRegistro0205List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0205;
    procedure SetItem(Index: Integer; const Value: TRegistro0205);
  public
    destructor Destroy; override;
    function New: TRegistro0205;
    property Items[Index: Integer]: TRegistro0205 read GetItem write SetItem;
  end;

  /// Registro 0206 - C�DIGO DE PRODUTO CONFORME TABELA ANP (COMBUST�VEIS)

  TRegistro0206 = class(TPersistent)
  private
    fCOD_COMB: string;       /// C�digo do combust�vel, conforme tabela publicada pela ANP:
  public
    property COD_COMB: string read FCOD_COMB write FCOD_COMB;
  end;

  /// Registro 0206 - Lista

  TRegistro0206List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0206;
    procedure SetItem(Index: Integer; const Value: TRegistro0206);
  public
    destructor Destroy; override;
    function New: TRegistro0206;
    property Items[Index: Integer]: TRegistro0206 read GetItem write SetItem;
  end;

  /// Registro 0220 - FATORES DE CONVERS�O DE UNIDADES

  TRegistro0220 = class(TPersistent)
  private
    fUNID_CONV: string;      /// Unidade comercial a ser convertida na unidade de estoque, referida em 0200:
    fFAT_CONV: string;       /// Fator de convers�o:
  public
    property UNID_CONV: string read FUNID_CONV write FUNID_CONV;
    property FAT_CONV: string read FFAT_CONV write FFAT_CONV;
  end;

  /// Registro 0220 - Lista

  TRegistro0220List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0220;
    procedure SetItem(Index: Integer; const Value: TRegistro0220);
  public
    destructor Destroy; override;
    function New: TRegistro0220;
    property Items[Index: Integer]: TRegistro0220 read GetItem write SetItem;
  end;

  /// Registro 0400 - TABELA DE NATUREZA DA OPERA��O/PRESTA��O

  TRegistro0400 = class(TPersistent)
  private
    fCOD_NAT: string;        /// C�digo da natureza:
    fDESCR_NAT: string;      /// Descri��o da natureza:
  public
    property COD_NAT: string read FCOD_NAT write FCOD_NAT;
    property DESCR_NAT: string read FDESCR_NAT write FDESCR_NAT;
  end;

  /// Registro 0400 - Lista

  TRegistro0400List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0400;
    procedure SetItem(Index: Integer; const Value: TRegistro0400);
  public
    destructor Destroy; override;
    function New: TRegistro0400;
    property Items[Index: Integer]: TRegistro0400 read GetItem write SetItem;
  end;

  /// Registro 0450 - TABELA DE INFORMA��O COMPLEMENTAR/OBSERVA��O

  TRegistro0450 = class(TPersistent)
  private
    fCOD_INF: string;     /// C�digo da informa��o complementar do documento fiscal:
    fTXT: string;         /// Texto livre:
  public
    property COD_INF: string read FCOD_INF write FCOD_INF;
    property TXT: string read FTXT write FTXT;
  end;

  /// Registro 0450 - Lista

  TRegistro0450List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0450;
    procedure SetItem(Index: Integer; const Value: TRegistro0450);
  public
    destructor Destroy; override;
    function New: TRegistro0450;
    property Items[Index: Integer]: TRegistro0450 read GetItem write SetItem;
  end;

  /// Registro 0460 - TABELA DE OBSERVA��ES DO LAN�AMENTO FISCAL

  TRegistro0460 = class(TPersistent)
  private
    fCOD_OBS: string;     /// C�digo da Observa��o do lan�amento fiscal:
    fTXT: string;         /// Descri��o da observa��o vinculada ao lan�amento fiscal:
  public
    property COD_OBS: string read FCOD_OBS write FCOD_OBS;
    property TXT: string read FTXT write FTXT;
  end;

  /// Registro 0460 - Lista

  TRegistro0460List = class(TList)
  private
    function GetItem(Index: Integer): TRegistro0460;
    procedure SetItem(Index: Integer; const Value: TRegistro0460);
  public
    destructor Destroy; override;
    function New: TRegistro0460;
    property Items[Index: Integer]: TRegistro0460 read GetItem write SetItem;
  end;

  /// Registro 0990 - ENCERRAMENTO DO BLOCO 0

  TRegistro0990 = class(TPersistent)
  private
    fQTD_LIN_0: Integer; /// Quantidade total de linhas do Bloco 0
  public
    property QTD_LIN_0: Integer read fQTD_LIN_0 write fQTD_LIN_0;
  end;

implementation

(* TRegistro0150List *)

destructor TRegistro0150List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0150List.GetItem(Index: Integer): TRegistro0150;
begin
  Result := Items[Index];
end;

function TRegistro0150List.New: TRegistro0150;
begin
  Result := TRegistro0150.Create;
  Add(Result);
end;

procedure TRegistro0150List.SetItem(Index: Integer; const Value: TRegistro0150);
begin
  Put(Index, Value);
end;

(* TRegistro0175List *)

destructor TRegistro0175List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0175List.GetItem(Index: Integer): TRegistro0175;
begin
  Result := inherited Items[Index];
end;

function TRegistro0175List.New: TRegistro0175;
begin
  Result := TRegistro0175.Create;
  Add(Result);
end;

procedure TRegistro0175List.SetItem(Index: Integer; const Value: TRegistro0175);
begin
  Put(Index, Value);
end;

(* TRegistro0190List *)

destructor TRegistro0190List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0190List.GetItem(Index: Integer): TRegistro0190;
begin
  Result := inherited Items[Index];
end;

function TRegistro0190List.New: TRegistro0190;
begin
  Result := TRegistro0190.Create;
  Add(Result);
end;

procedure TRegistro0190List.SetItem(Index: Integer; const Value: TRegistro0190);
begin
  Put(Index, Value);
end;

(* TRegistro0200List *)

destructor TRegistro0200List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0200List.GetItem(Index: Integer): TRegistro0200;
begin
  Result := inherited Items[Index];
end;

function TRegistro0200List.New: TRegistro0200;
begin
  Result := TRegistro0200.Create;
  Add(Result);
end;

procedure TRegistro0200List.SetItem(Index: Integer; const Value: TRegistro0200);
begin
  Put(Index, Value);
end;

(* TRegistro0205List *)

destructor TRegistro0205List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0205List.GetItem(Index: Integer): TRegistro0205;
begin
  Result := inherited Items[Index];
end;

function TRegistro0205List.New: TRegistro0205;
begin
  Result := TRegistro0205.Create;
  Add(Result);
end;

procedure TRegistro0205List.SetItem(Index: Integer; const Value: TRegistro0205);
begin
  Put(Index, Value);
end;

(* TRegistro0206List *)

destructor TRegistro0206List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0206List.GetItem(Index: Integer): TRegistro0206;
begin
  Result := inherited Items[Index];
end;

function TRegistro0206List.New: TRegistro0206;
begin
  Result := TRegistro0206.Create;
  Add(Result);
end;

procedure TRegistro0206List.SetItem(Index: Integer; const Value: TRegistro0206);
begin
  Put(Index, Value);
end;

(* TRegistro0220List *)

destructor TRegistro0220List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0220List.GetItem(Index: Integer): TRegistro0220;
begin
  Result := inherited Items[Index];
end;

function TRegistro0220List.New: TRegistro0220;
begin
  Result := TRegistro0220.Create;
  Add(Result);
end;

procedure TRegistro0220List.SetItem(Index: Integer; const Value: TRegistro0220);
begin
  Put(Index, Value);
end;

(* TRegistro0400List *)

destructor TRegistro0400List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0400List.GetItem(Index: Integer): TRegistro0400;
begin
  Result := inherited Items[Index];
end;

function TRegistro0400List.New: TRegistro0400;
begin
  Result := TRegistro0400.Create;
  Add(Result);
end;

procedure TRegistro0400List.SetItem(Index: Integer; const Value: TRegistro0400);
begin
  Put(Index, Value);
end;

(* TRegistro0450List *)

destructor TRegistro0450List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0450List.GetItem(Index: Integer): TRegistro0450;
begin
  Result := inherited Items[Index];
end;

function TRegistro0450List.New: TRegistro0450;
begin
  Result := TRegistro0450.Create;
  Add(Result);
end;

procedure TRegistro0450List.SetItem(Index: Integer; const Value: TRegistro0450);
begin
  Put(Index, Value);
end;

(* TRegistro0460List *)

destructor TRegistro0460List.Destroy;
var
intFor: integer;
begin
  for intFor := 0 to Count - 1 do Items[intFor].Free;
  inherited;
end;

function TRegistro0460List.GetItem(Index: Integer): TRegistro0460;
begin
  Result := inherited Items[Index];
end;

function TRegistro0460List.New: TRegistro0460;
begin
  Result := TRegistro0460.Create;
  Add(Result);
end;

procedure TRegistro0460List.SetItem(Index: Integer; const Value: TRegistro0460);
begin
  Put(Index, Value);
end;

end.
