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

unit ACBrSEF2_blocoH;

interface
   Uses Classes, Contnrs, SysUtils, ACBrSEF2Conversao;



 //LINHA H001: ABERTURA DO BLOCO H
 type TRegistroSEFH001 = class
  private
    FIND_DAD     : TSEFIIIndicadorConteudo;
    function GetLin: String;
 public
   property LIN : String read GetLin;
   property IND_DAD : TSEFIIIndicadorConteudo  read FIND_DAD write FIND_DAD;
 end;


 type TRegistroSEFH020 = class
  private
    FIND_DT      : INTEGER;
    FDT_INV      : INTEGER;
    FVL_ESTQ     : Double;
    FVL_ICMS_REC : Double;
    FVL_IPI_REC  : Double;
    FVL_PIS_REC  : Double;
    FVL_COFINS_REC :Double;
    FVL_TRIB_NC  : Double;
    FVL_ESTQ_NC  : Double;
    FNUM_LCTO    : STRING;
    FCOD_INF_OBS : STRING;
    function GetLin: String;
 public
   property LIN           : String read GetLin;
   property IND_DT        : INTEGER  read FIND_DT write FIND_DT;//Indicador da data do inventário:
   property DT_INV        : INTEGER  read FDT_INV write FDT_INV;//Data do inventário
   property VL_ESTQ       : Double  read FVL_ESTQ write FVL_ESTQ;//Valor do estoque na data assinalada
   property VL_ICMS_REC   : Double  read FVL_ICMS_REC write FVL_ICMS_REC;//Valor do ICMS a recuperar
   property VL_IPI_REC    : Double  read FVL_IPI_REC write FVL_IPI_REC;//Valor do IPI a recuperar
   property VL_PIS_REC    : Double  read FVL_PIS_REC write FVL_PIS_REC;//Valor do PIS a recuperar
   property VL_COFINS_REC : Double  read FVL_COFINS_REC write FVL_COFINS_REC;//Valor do COFINS a recuperar
   property VL_TRIB_NC    : Double  read FVL_TRIB_NC write FVL_TRIB_NC;//Valor dos tributos não-cumulativos recuperáveis
   property VL_ESTQ_NC    : Double  read FVL_ESTQ_NC write FVL_ESTQ_NC;//Valor do estoque, retirado o valor dos tributos recuperáveis
   property NUM_LCTO      : STRING  read FNUM_LCTO write FNUM_LCTO;//Número ou código de identificação única do lançamento contábil
   property COD_INF_OBS   : STRING  read FCOD_INF_OBS write FCOD_INF_OBS;//Código de referência à observação (campo 02 da Linha 0450)
 end;

   TRegistroSEFh020List = class(TObjectList)

  private
    function GetNotas(Index: Integer): TRegistroSEFH020;
    procedure SetNotas(Index: Integer; const Value: TRegistroSEFH020);
  public
    function New: TRegistroSEFH020;
    property notas[Index: Integer]: TRegistroSEFH020 read Getnotas write SetNotas;
  end;

  // ITENS INVENTARIADOS
 type TRegistroSEFH030 = class
  private
    FIND_POSSE      : INTEGER;
    FCOD_PART       : STRING;
    FIND_ITEM       : INTEGER;
    FCOD_NCM        : Double;
    FCOD_ITEM       : Double;
    FUNID           : STRING;
    FVL_UNIT        : Double;
    FQTD            : Double;
    FVL_ITEM        : Double;
    FVL_ICMS_REC_I  : Double;
    FVL_IPI_REC_I   : Double;
    FVL_PIS_REC_I   : Double;
    FVL_COFINS_REC_I: Double;
    FVL_TRIB_NC_I   : Double;
    FCOD_INF_OBS    : String;
   function GetLin : String;
 public
   property LIN           : String read GetLin;
   property IND_POSSE     : INTEGER  read FIND_POSSE write FIND_POSSE;//Indicador de propriedade/posse do item
   property COD_PART      : STRING  read FCOD_PART write FCOD_PART;//Código do participante (campo 02 da Linha 0150) do proprietário ou possuidor
   property IND_ITEM      : INTEGER  read FIND_ITEM write FIND_ITEM;//Indicador do tipo de item inventariado:
   property COD_NCM       : Double  read FCOD_NCM write FCOD_NCM;//Código da Nomenclatura Comum do Mercosul, conforme a tabela externa indicada no item 3.3.1
   property COD_ITEM      : Double  read FCOD_ITEM write FCOD_ITEM;//Código do item (campo 02 da Linha 0200)
   property UNID          : STRING  read FUNID write FUNID;//UNIDADE DO ITEM
   property VL_UNIT       : Double  read FVL_UNIT write FVL_UNIT;//Valor do UNITARIO
   property QTD           : Double  read FQTD write FQTD;//QUANTIDADE DO ITEM
   property VL_ITEM       : Double  read FVL_ITEM write FVL_ITEM;//Valor do ITEM
   property VL_ICMS_REC_I : Double  read FVL_ICMS_REC_I write FVL_ICMS_REC_I;//Valor do ICMS a recuperar
   property VL_IPI_REC_I  : Double  read FVL_IPI_REC_I write FVL_IPI_REC_I;//Valor do IPI a recuperar
   property VL_PIS_REC_I  : Double  read FVL_PIS_REC_I write FVL_PIS_REC_I;//Valor do PIS a recuperar
   property VL_COFINS_REC_I: Double  read FVL_COFINS_REC_I write FVL_COFINS_REC_I;//Valor do COFINS a recuperar
   property VL_TRIB_NC_I  : Double  read FVL_TRIB_NC_I write FVL_TRIB_NC_I;//Valor dos tributos não-cumulativos recuperáveis
   property COD_INF_OBS   : String  read FCOD_INF_OBS write FCOD_INF_OBS;//Código de referência à observação (campo 02 da Linha 0450)

 end;

   TRegistroSEFh030List = class(TObjectList)

  private
    function GetNotas(Index: Integer): TRegistroSEFH030;
    procedure SetNotas(Index: Integer; const Value: TRegistroSEFH030);
  public
    function New: TRegistroSEFH030;
    property notas[Index: Integer]: TRegistroSEFH030 read Getnotas write SetNotas;
  end;

// SUBTOTAIS POR POSSUIDOR/PROPRIETÁRIO
  type TRegistroSEFH040 = class
  private
    FIND_POSSE     : INTEGER;
    FVL_SUB_POSSE  : Double;
    function GetLin: String;
 public
   property LIN           : String read GetLin;
   property IND_POSSE     : INTEGER  read FIND_POSSE write FIND_POSSE;//Indicador de posse a ser totalizado:
   property VL_SUB_POSSE  : Double  read FVL_SUB_POSSE write FVL_SUB_POSSE;//Valor subtotal por possuidor ou proprietário
 end;

   TRegistroSEFh040List = class(TObjectList)

  private
    function GetNotas(Index: Integer): TRegistroSEFH040;
    procedure SetNotas(Index: Integer; const Value: TRegistroSEFH040);
  public
    function New: TRegistroSEFH040;
    property notas[Index: Integer]: TRegistroSEFH040 read Getnotas write SetNotas;
  end;



  // SUBTOTAIS POR TIPO DE ITEM
  type TRegistroSEFH050 = class
  private
    FIND_POSSE     : INTEGER;
    FVL_SUB_ITEM  : Double;
    function GetLin: String;
 public
   property LIN           : String read GetLin;
   property IND_POSSE     : INTEGER  read FIND_POSSE write FIND_POSSE;//Indicador de posse a ser totalizado:
   property VL_SUB_ITEM   : Double  read FVL_SUB_ITEM write FVL_SUB_ITEM;//Valor subtotal por tipo de item
 end;

   TRegistroSEFh050List = class(TObjectList)

  private
    function GetNotas(Index: Integer): TRegistroSEFH050;
    procedure SetNotas(Index: Integer; const Value: TRegistroSEFH050);
  public
    function New: TRegistroSEFH050;
    property notas[Index: Integer]: TRegistroSEFH050 read Getnotas write SetNotas;
  end;


    // SUBTOTAIS POR NCM
  type TRegistroSEFH060 = class
  private
    FIND_POSSE     : INTEGER;
    FVL_SUB_NCM  : Double;
    function GetLin: String;
 public
   property LIN           : String read GetLin;
   property IND_POSSE     : INTEGER  read FIND_POSSE write FIND_POSSE;//Indicador de posse a ser totalizado:
   property VL_SUB_NCM     : Double  read FVL_SUB_NCM write FVL_SUB_NCM;//Valor subtotal por NCM
 end;

   TRegistroSEFh060List = class(TObjectList)

  private
    function GetNotas(Index: Integer): TRegistroSEFH060;
    procedure SetNotas(Index: Integer; const Value: TRegistroSEFH060);
  public
    function New: TRegistroSEFH060;
    property notas[Index: Integer]: TRegistroSEFH060 read Getnotas write SetNotas;
  end;




implementation

function TRegistroSEFH001.GetLIN: String;
begin
  Result := 'H001';
end;


{ TRegistroSEFH020 }

function TRegistroSEFH020.GetLin: String;
begin
     Result := 'H020';
end;

{ TRegistroSEFh020List }



function TRegistroSEFh020List.GetNotas(Index: Integer): TRegistroSEFH020;
begin
      Result := TRegistroSEFH020(Inherited Items[Index]);
end;

function TRegistroSEFh020List.New: TRegistroSEFH020;
begin
     Result := TRegistroSEFH020.Create;
     Add(Result);
end;

procedure TRegistroSEFh020List.SetNotas(Index: Integer;
  const Value: TRegistroSEFH020);
begin
     Put(Index, Value);
end;

{ TRegistroSEFh030List }
function TRegistroSEFH030.GetLin: String;
begin
     Result := 'H030';
end;


function TRegistroSEFh030List.GetNotas(Index: Integer): TRegistroSEFH030;
begin
      Result := TRegistroSEFH030(Inherited Items[Index]);

end;

function TRegistroSEFh030List.New: TRegistroSEFH030;
begin
       Result := TRegistroSEFH030.Create;
       Add(Result);

end;

procedure TRegistroSEFh030List.SetNotas(Index: Integer;
  const Value: TRegistroSEFH030);
begin
    Put(Index, Value);
end;

{ TRegistroSEFh040List }

function TRegistroSEFH040.GetLin: String;
begin
     Result := 'H040';
end;

function TRegistroSEFh040List.GetNotas(Index: Integer): TRegistroSEFH040;
begin
      Result := TRegistroSEFH040(Inherited Items[Index]);
end;

function TRegistroSEFh040List.New: TRegistroSEFH040;
begin
       Result := TRegistroSEFH040.Create;
       Add(Result);

end;

procedure TRegistroSEFh040List.SetNotas(Index: Integer;
  const Value: TRegistroSEFH040);
begin
    Put(Index, Value);
end;

{ TRegistroSEFh050List }

function TRegistroSEFH050.GetLin: String;
begin
     Result := 'H050';
end;

function TRegistroSEFh050List.GetNotas(Index: Integer): TRegistroSEFH050;
begin
  Result := TRegistroSEFH050(Inherited Items[Index]);
end;

function TRegistroSEFh050List.New: TRegistroSEFH050;
begin
       Result := TRegistroSEFH050.Create;
       Add(Result);

end;

procedure TRegistroSEFh050List.SetNotas(Index: Integer;
  const Value: TRegistroSEFH050);
begin
    Put(Index, Value);
end;

{ TRegistroSEFh060List }

function TRegistroSEFH060.GetLin: String;
begin
     Result := 'H060';
end;
function TRegistroSEFh060List.GetNotas(Index: Integer): TRegistroSEFH060;
begin
         Result := TRegistroSEFH060(Inherited Items[Index]);
end;

function TRegistroSEFh060List.New: TRegistroSEFH060;
begin
       Result := TRegistroSEFH060.Create;
       Add(Result);

end;

procedure TRegistroSEFh060List.SetNotas(Index: Integer;
  const Value: TRegistroSEFH060);
begin
      Put(Index, Value);
end;

end.
