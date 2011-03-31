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
|* 14/12/2010: Isaque Pinheiro, Paulo Junqueira e Claudio Roberto de Souza
|*  - Cria��o e distribui��o da Primeira Versao
*******************************************************************************}

unit ACBrEPCBloco_0;

interface

uses
  SysUtils, Classes, Contnrs, DateUtils, ACBrEPCBlocos;

type
  TRegistro0100List = class;
  TRegistro0110 = class;
  TRegistro0111 = class;
  TRegistro0140List = class;
  TRegistro0150List = class;
  TRegistro0190List = class;
  TRegistro0200List = class;
  TRegistro0205List = class;
  TRegistro0206 = class;
  TRegistro0208 = class;
  TRegistro0400List = class;
  TRegistro0450List = class;
  TRegistro0500List = class;
  TRegistro0600List = class;

  //REGISTRO 0000: ABERTURA DO ARQUIVO DIGITAL E IDENTIFICA��O DA PESSOA JUR�DICA
  TRegistro0000 = class
  private
    FCOD_VER: TACBrVersaoLeiaute;
    FTIPO_ESCRIT: TACBrTipoEscrituracao;
    FIND_SIT_ESP: TACBrIndicadorSituacaoEspecial;
    FNUM_REC_ANTERIOR: string;
    FDT_INI: TDateTime;
    FDT_FIN: TDateTime;
    FNOME: string;
    FCNPJ: string;
    FUF: string;
    FCOD_MUN: string;
    FSUFRAMA: string;
    FIND_NAT_PJ: TACBrIndicadorNaturezaPJ;
    FIND_ATIV: TACBrIndicadorAtividade;
  public
    property COD_VER: TACBrVersaoLeiaute read FCOD_VER write FCOD_VER;
    property TIPO_ESCRIT: TACBrTipoEscrituracao read FTIPO_ESCRIT write FTIPO_ESCRIT;
    property IND_SIT_ESP: TACBrIndicadorSituacaoEspecial read FIND_SIT_ESP write FIND_SIT_ESP;
    property NUM_REC_ANTERIOR: string read FNUM_REC_ANTERIOR write FNUM_REC_ANTERIOR;
    property DT_INI: TDateTime read FDT_INI write FDT_INI;
    property DT_FIN: TDateTime read FDT_FIN write FDT_FIN;
    property NOME: string read FNOME write FNOME;
    property CNPJ: string read FCNPJ write FCNPJ;
    property UF: string read FUF write FUF;
    property COD_MUN: string read FCOD_MUN write FCOD_MUN;
    property SUFRAMA: string read FSUFRAMA write FSUFRAMA;
    property IND_NAT_PJ: TACBrIndicadorNaturezaPJ read FIND_NAT_PJ write FIND_NAT_PJ;
    property IND_ATIV: TACBrIndicadorAtividade read FIND_ATIV write FIND_ATIV;
  end;

  //REGISTRO 0001: ABERTURA DO BLOCO 0
  TRegistro0001 = class(TOpenBlocos)
  private
    FRegistro0100: TRegistro0100List;
    FRegistro0110: TRegistro0110;
    FRegistro0140: TRegistro0140List;
    FRegistro0500: TRegistro0500List;
    FRegistro0600: TRegistro0600List;
  public
    constructor Create; virtual; // Create
    destructor Destroy; override;// Destroy

    property Registro0100: TRegistro0100List read FRegistro0100 write FRegistro0100;
    property Registro0110: TRegistro0110 read FRegistro0110 write FRegistro0110;
    property Registro0140: TRegistro0140List read FRegistro0140 write FRegistro0140;
    property Registro0500: TRegistro0500List read FRegistro0500 write FRegistro0500;
    property Registro0600: TRegistro0600List read FRegistro0600 write FRegistro0600;
  end;

  //REGISTRO 0100: DADOS DO CONTABILISTA
  TRegistro0100 = class
  private
    FNOME: string;
    FCPF: string;
    FCRC: string;
    FCNPJ: string;
    FCEP: string;
    FEND: string;
    FNUM: string;
    FCOMPL: string;
    FBAIRRO: string;
    FFONE: string;
    FFAX: string;
    FEMAIL: string;
    FCOD_MUN: string;
  public
    property NOME: string read FNOME write FNOME;
    property CPF: string read FCPF write FCPF;
    property CRC: string read FCRC write FCRC;
    property CNPJ: string read FCNPJ write FCNPJ;
    property CEP: string read FCEP write FCEP;
    property ENDERECO: string read FEND write FEND;
    property NUM: string read FNUM write FNUM;
    property COMPL: string read FCOMPL write FCOMPL;
    property BAIRRO: string read FBAIRRO write FBAIRRO;
    property FONE: string read FFONE write FFONE;
    property FAX: string read FFAX write FFAX;
    property EMAIL: string read FEMAIL write FEMAIL;
    property COD_MUN: string read FCOD_MUN write FCOD_MUN;
  end;

  // Registro 0100 - Lista
  TRegistro0100List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro0100;
    procedure SetItem(Index: Integer; const Value: TRegistro0100);
  public
    function New: TRegistro0100;
    property Items[Index: Integer]: TRegistro0100 read GetItem write SetItem;
  end;

  //REGISTRO 0110: REGIMES DE APURA��O DA CONTRIBUI��O SOCIAL E DE APROPRIA��O DE CR�DITO
  TRegistro0110 = class
  private
    FCOD_INC_TRIB: TACBrCodIndIncTributaria;
    FIND_APRO_CRED: TACBrIndAproCred;
    FCOD_TIPO_CONT: TACBrCodIndTipoCon;

    FRegistro0111: TRegistro0111;
  public
    property COD_INC_TRIB: TACBrCodIndIncTributaria read FCOD_INC_TRIB write FCOD_INC_TRIB;
    property IND_APRO_CRED: TACBrIndAproCred read FIND_APRO_CRED write FIND_APRO_CRED;
    property COD_TIPO_CONT: TACBrCodIndTipoCon read FCOD_TIPO_CONT write FCOD_TIPO_CONT;

    property Registro0111: TRegistro0111List read FRegistro0111 write FRegistro0111;
  end;

  //REGISTRO 0111: DE RECEITA BRUTA MENSAL PARA FINS DE RATEIO DE CR�DITOS COMUNS
  TRegistro0111 = class
  private
    FREC_BRU_NCUM_TRIB_MI: currency;
    FREC_BRU_NCUM_NT_MI: currency;
    FREC_BRU_NCUM_EXP: currency;
    FREC_BRU_CUM: currency;
    FREC_BRU_TOTAL: currency;
  public
    property REC_BRU_NCUM_TRIB_MI: currency read FREC_BRU_NCUM_TRIB_MI write FREC_BRU_NCUM_TRIB_MI;
    property REC_BRU_NCUM_NT_MI: currency read FREC_BRU_NCUM_NT_MI write FREC_BRU_NCUM_NT_MI;
    property REC_BRU_NCUM_EXP: currency read FREC_BRU_NCUM_EXP write FREC_BRU_NCUM_EXP;
    property REC_BRU_CUM: currency read FREC_BRU_CUM write FREC_BRU_CUM;
    property REC_BRU_TOTAL: currency read FREC_BRU_TOTAL write FREC_BRU_TOTAL;
  end;

  //REGISTRO 0140: TABELA DE CADASTRO DE ESTABELECIMENTO
  TRegistro0140 = class
  private
    FCOD_EST: string;
    FNOME: string;
    FCNPJ: string;
    FUF: string;
    FIE: string;
    FCOD_MUN: string;
    FIM: string;
    FSUFRAMA: string;

    FRegistro0150: TRegistro0150List;
    FRegistro0190: TRegistro0190List;
    FRegistro0200: TRegistro0200List;
    FRegistro0400: TRegistro0400List;
    FRegistro0450: TRegistro0450List;
  public
    constructor Create; virtual; // Create
    destructor Destroy; override;// Destroy

    property COD_EST: string read FCOD_EST write FCOD_EST;
    property NOME: string read FNOME write FNOME;
    property CNPJ: string read FCNPJ write FCNPJ;
    property UF: string read FUF write FUF;
    property IE: string read FIE write FIE;
    property COD_MUN: string read FCOD_MUN write FCOD_MUN;
    property IM: string read FIM write FIM;
    property SUFRAMA: string read FSUFRAMA write FSUFRAMA;

    property Registro0150: TRegistro0150List read FRegistro0150 write FRegistro0150;
    property Registro0190: TRegistro0190List read FRegistro0190 write FRegistro0190;
    property Registro0200: TRegistro0200List read FRegistro0200 write FRegistro0200;
    property Registro0400: TRegistro0400List read FRegistro0400 write FRegistro0400;
    property Registro0450: TRegistro0450List read FRegistro0450 write FRegistro0450;
  end;

  // Registro 0140 - Lista
  TRegistro0140List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro0140;
    procedure SetItem(Index: Integer; const Value: TRegistro0140);
  public
    function New: TRegistro0140;
    property Items[Index: Integer]: TRegistro0140 read GetItem write SetItem;
  end;

  //REGISTRO 0150: TABELA DE CADASTRO DO PARTICIPANTE
  TRegistro0150 = class
  private
    FCOD_PART: string;
    FNOME: string;
    FCOD_PAIS: string;
    FCNPJ: string;
    FCPF: string;
    FIE: string;
    FCOD_MUN: string;
    FSUFRAMA: string;
    FEND: string;
    FNUM: string;
    FCOMPL: string;
    FBAIRRO: string;
  public
    property COD_PART: string read FCOD_PART write FCOD_PART;
    property NOME: string read FNOME write FNOME;
    property COD_PAIS: string read FCOD_PAIS write FCOD_PAIS;
    property CNPJ: string read FCNPJ write FCNPJ;
    property CPF: string read FCPF write FCPF;
    property IE: string read FIE write FIE;
    property COD_MUN: string read FCOD_MUN write FCOD_MUN;
    property SUFRAMA: string read FSUFRAMA write FSUFRAMA;
    property ENDERECO: string read FEND write FEND;
    property NUM: string read FNUM write FNUM;
    property COMPL: string read FCOMPL write FCOMPL;
    property BAIRRO: string read FBAIRRO write FBAIRRO;
  end;

  // Registro 0150 - Lista
  TRegistro0150List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro0150;
    procedure SetItem(Index: Integer; const Value: TRegistro0150);
  public
    function New: TRegistro0150;
    property Items[Index: Integer]: TRegistro0150 read GetItem write SetItem;
  end;

  //REGISTRO 0190: IDENTIFICA��O DAS UNIDADES DE MEDIDA
  TRegistro0190 = class
  private
    FUNID: string;
    FDESCR: string;
  public
    property UNID: string read FUNID write FUNID;
    property DESCR: string read FDESCR write FDESCR;
  end;

  // Registro 0190 - Lista
  TRegistro0190List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro0190;
    procedure SetItem(Index: Integer; const Value: TRegistro0190);
  public
    function New: TRegistro0190;
    property Items[Index: Integer]: TRegistro0190 read GetItem write SetItem;
  end;

  //REGISTRO 0200: TABELA DE IDENTIFICA��O DO ITEM (PRODUTOS E SERVI�OS)
  TRegistro0200 = class
  private
    FCOD_ITEM: string;
    FDESCR_ITEM: string;
    FCOD_BARRA: string;
    FCOD_ANT_ITEM: string;
    FUNID_INV: string;
    FTIPO_ITEM: TACBrTipoItem;
    FCOD_NCM: string;
    FEX_IPI: string;
    FCOD_GEN: string;
    FCOD_LST: string;
    FALIQ_ICMS: currency;

    FRegistro0205: TRegistro0205List;
    FRegistro0206: TRegistro0206;
    FRegistro0208: TRegistro0208;
  public
    constructor Create; virtual; // Create
    destructor Destroy; override;// Destroy

    property COD_ITEM: string read FCOD_ITEM write FCOD_ITEM;
    property DESCR_ITEM: string read FDESCR_ITEM write FDESCR_ITEM;
    property COD_BARRA: string read FCOD_BARRA write FCOD_BARRA;
    property COD_ANT_ITEM: string read FCOD_ANT_ITEM write FCOD_ANT_ITEM;
    property UNID_INV: string read FUNID_INV write FUNID_INV;
    property TIPO_ITEM: TACBrTipoItem read FTIPO_ITEM write FTIPO_ITEM;
    property COD_NCM: string read FCOD_NCM write FCOD_NCM;
    property EX_IPI: string read FEX_IPI write FEX_IPI;
    property COD_GEN: string read FCOD_GEN write FCOD_GEN;
    property COD_LST: string read FCOD_LST write FCOD_LST;
    property ALIQ_ICMS: currency read FALIQ_ICMS write FALIQ_ICMS;

    property Registro0205: TRegistro0205List read FRegistro0205 write FRegistro0205;
    property Registro0206: TRegistro0206 read FRegistro0206 write FRegistro0206;
    property Registro0208: TRegistro0208 read FRegistro0208 write FRegistro0208;
  end;

  // Registro 0200 - Lista
  TRegistro0200List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro0200;
    procedure SetItem(Index: Integer; const Value: TRegistro0200);
  public
    function New: TRegistro0200;
    property Items[Index: Integer]: TRegistro0200 read GetItem write SetItem;
  end;

  //REGISTRO 0205: ALTERA��O DO ITEM
  TRegistro0205 = class
  private
    FDESCR_ANT_ITEM: string;
    FDT_INI: TDateTime;
    FDT_FIM: TDateTime;
    FCOD_ANT_ITEM: string;
  public
    property DESCR_ANT_ITEM: string read FDESCR_ANT_ITEM write FDESCR_ANT_ITEM;
    property DT_INI: TDateTime read FDT_INI write FDT_INI;
    property DT_FIM: TDateTime read FDT_FIM write FDT_FIM;
    property COD_ANT_ITEM: string read FCOD_ANT_ITEM write FCOD_ANT_ITEM;
  end;

  // Registro 0205 - Lista
  TRegistro0205List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro0205;
    procedure SetItem(Index: Integer; const Value: TRegistro0205);
  public
    function New: TRegistro0205;
    property Items[Index: Integer]: TRegistro0205 read GetItem write SetItem;
  end;

  // REGISTRO 0206: C�DIGO DE PRODUTO CONFORME TABELA ANP (COMBUST�VEIS)
  TRegistro0206 = class
  private
    FCOD_COMB: string;
  public
    property COD_COMB: string read FCOD_COMB write FCOD_COMB;
  end;

  // REGISTRO 0208: C�DIGO DE GRUPOS POR MARCA COMERCIAL - REFRI (BEBIDAS FRIAS).
  TRegistro0208 = class
  private
    FMARCA_COM: string;
    FCOD_TAB: TACBrIndCodIncidencia;
    FCOD_GRU: string;
  public
    property COD_TAB: TACBrIndCodIncidencia read FCOD_TAB write FCOD_TAB;
    property COD_GRU: string read FCOD_GRU write FCOD_GRU;
    property MARCA_COM: string read FMARCA_COM write FMARCA_COM;
  end;

  //REGISTRO 0400: TABELA DE NATUREZA DA OPERA��O/PRESTA��O
  TRegistro0400 = class
  private
    FCOD_NAT: string;
    FDESCR_NAT: string;
  public
    property COD_NAT: string read FCOD_NAT write FCOD_NAT;
    property DESCR_NAT: string read FDESCR_NAT write FDESCR_NAT;
  end;

  // Registro 0400 - Lista
  TRegistro0400List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro0400;
    procedure SetItem(Index: Integer; const Value: TRegistro0400);
  public
    function New: TRegistro0400;
    property Items[Index: Integer]: TRegistro0400 read GetItem write SetItem;
  end;

  //REGISTRO 0450: TABELA DE INFORMA��O COMPLEMENTAR DO DOCUMENTO FISCAL
  TRegistro0450 = class
  private
    FCOD_INF: string;
    FTXT: string;
  public
    property COD_INF: string read FCOD_INF write FCOD_INF;
    property TXT: string read FTXT write FTXT;
  end;

  // Registro 0450 - Lista
  TRegistro0450List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro0450;
    procedure SetItem(Index: Integer; const Value: TRegistro0450);
  public
    function New: TRegistro0450;
    property Items[Index: Integer]: TRegistro0450 read GetItem write SetItem;
  end;

  //REGISTRO 0500: PLANO DE CONTAS CONT�BEIS
  TRegistro0500 = class
  private
    FDT_ALT: TDateTime;
    FCOD_NAT_CC: TACBrNaturezaConta;
    FIND_CTA: string;
    FNIVEL: string;
    FCOD_CTA: TACBrIndCTA;
    FNOME_CTA: string;
    FCOD_CTA_REF: string;
    FCNPJ_EST: string;
  public
    property DT_ALT: TDateTime read FDT_ALT  write FDT_ALT;
    property COD_NAT_CC: TACBrNaturezaConta read FCOD_NAT_CC write FCOD_NAT_CC;
    property IND_CTA: TACBrIndCTA read FIND_CTA  write FIND_CTA ;
    property NIVEL: string read FNIVEL write FNIVEL;
    property COD_CTA : string read FCOD_CTA  write FCOD_CTA ;
    property NOME_CTA : string read FNOME_CTA  write FNOME_CTA ;
    property COD_CTA_REF: string read FCOD_CTA_REF write FCOD_CTA_REF;
    property CNPJ_EST: string read FCNPJ_EST write FCNPJ_EST;
  end;

  // Registro 0500 - Lista
  TRegistro0500List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro0500;
    procedure SetItem(Index: Integer; const Value: TRegistro0500);
  public
    function New: TRegistro0500;
    property Items[Index: Integer]: TRegistro0500 read GetItem write SetItem;
  end;

  //REGISTRO 0600: CENTRO DE CUSTOS
  TRegistro0600 = class
  private
    FDT_ALT: TDateTime;
    FCOD_CCUS: string;
    FCCUS: string;
  public
    property DT_ALT : TDateTime read FDT_ALT  write FDT_ALT ;
    property COD_CCUS : string read FCOD_CCUS  write FCOD_CCUS ;
    property CCUS: string read FCCUS write FCCUS;
  end;

  // Registro 0600 - Lista
  TRegistro0600List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistro0600;
    procedure SetItem(Index: Integer; const Value: TRegistro0600);
  public
    function New: TRegistro0600;
    property Items[Index: Integer]: TRegistro0600 read GetItem write SetItem;
  end;

  //REGISTRO 0990: ENCERRAMENTO DO BLOCO 0
  TRegistro0990 = class
  private
    FQTD_LIN_0: integer;
  public
    property QTD_LIN_0: integer read FQTD_LIN_0 write FQTD_LIN_0;
  end;

implementation

{ TRegistro0001 }

constructor TRegistro0001.Create;
begin
  FRegistro0100 := TRegistro0100List.Create;
  FRegistro0110 := TRegistro0110.Create;
  FRegistro0140 := TRegistro0140List.Create;
  FRegistro0500 := TRegistro0500List.Create;
  FRegistro0600 := TRegistro0600List.Create;
end;

destructor TRegistro0001.Destroy;
begin
  FRegistro0100.Free;
  FRegistro0110.Free;
  FRegistro0140.Free;
  FRegistro0500.Free;
  FRegistro0600.Free;
  inherited;
end;

{ TRegistro0100List }

function TRegistro0100List.GetItem(Index: Integer): TRegistro0100;
begin
  Result := TRegistro0100(Inherited Items[Index]);
end;

function TRegistro0100List.New: TRegistro0100;
begin
  Result := TRegistro0100.Create;
  Add(Result);
end;

procedure TRegistro0100List.SetItem(Index: Integer; const Value: TRegistro0100);
begin
  Put(Index, Value);
end;

{TRegistro0140}

function TRegistro0140List.GetItem(Index: Integer): TRegistro0140;
begin
  Result := TRegistro0140(Inherited Items[Index]);
end;

function TRegistro0140List.New: TRegistro0140;
begin
  Result := TRegistro0140.Create;
  Add(Result);
end;

procedure TRegistro0140List.SetItem(Index: Integer; const Value: TRegistro0140);
begin
  Put(Index, Value);
end;

{ TRegistro0140 }

constructor TRegistro0140.Create;
begin
  FRegistro0150 := TRegistro0150List.Create;
  FRegistro0190 := TRegistro0190List.Create;
  FRegistro0200 := TRegistro0200List.Create;
  FRegistro0400 := TRegistro0400List.Create;
  FRegistro0450 := TRegistro0450List.Create;
end;

destructor TRegistro0140.Destroy;
begin
  FRegistro0150.Free;
  FRegistro0190.Free;
  FRegistro0200.Free;
  FRegistro0400.Free;
  FRegistro0450.Free;
  inherited;
end;

{TRegistro0150}

function TRegistro0150List.GetItem(Index: Integer): TRegistro0150;
begin
  Result := TRegistro0150(Inherited Items[Index]);
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

{TRegistro0190}

function TRegistro0190List.GetItem(Index: Integer): TRegistro0190;
begin
  Result := TRegistro0190(Inherited Items[Index]);
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

{TRegistro0200}

function TRegistro0200List.GetItem(Index: Integer): TRegistro0200;
begin
  Result := TRegistro0200(Inherited Items[Index]);
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

{ TRegistro0200 }

constructor TRegistro0200.Create;
begin
  FRegistro0205 := TRegistro0205List.Create;
  FRegistro0206 := TRegistro0206.Create;
  FRegistro0208 := TRegistro0208.Create;
end;

destructor TRegistro0200.Destroy;
begin
  FRegistro0205.Free;
  FRegistro0206.Free;
  FRegistro0208.Free;
  inherited;
end;

{TRegistro0205}

function TRegistro0205List.GetItem(Index: Integer): TRegistro0205;
begin
  Result := TRegistro0205(Inherited Items[Index]);
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

{TRegistro0400}

function TRegistro0400List.GetItem(Index: Integer): TRegistro0400;
begin
  Result := TRegistro0400(Inherited Items[Index]);
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

{TRegistro0450}

function TRegistro0450List.GetItem(Index: Integer): TRegistro0450;
begin
  Result := TRegistro0450(Inherited Items[Index]);
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

{TRegistro0500}

function TRegistro0500List.GetItem(Index: Integer): TRegistro0500;
begin
  Result := TRegistro0500(Inherited Items[Index]);
end;

function TRegistro0500List.New: TRegistro0500;
begin
  Result := TRegistro0500.Create;
  Add(Result);
end;

procedure TRegistro0500List.SetItem(Index: Integer; const Value: TRegistro0500);
begin
  Put(Index, Value);
end;

{TRegistro0600}

function TRegistro0600List.GetItem(Index: Integer): TRegistro0600;
begin
  Result := TRegistro0600(Inherited Items[Index]);
end;

function TRegistro0600List.New: TRegistro0600;
begin
  Result := TRegistro0600.Create;
  Add(Result);
end;

procedure TRegistro0600List.SetItem(Index: Integer; const Value: TRegistro0600);
begin
  Put(Index, Value);
end;

end.
