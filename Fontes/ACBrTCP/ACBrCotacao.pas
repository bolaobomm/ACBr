{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                       R�gys Silveira                         }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{ Esse arquivo usa a classe  SynaSer   Copyright (c)2001-2003, Lukas Gebauer   }
{  Project : Ararat Synapse     (Found at URL: http://www.ararat.cz/synapse/)  }
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
|* 15/07/2013: Primeira Versao
|*    R�gys Borges da Silveira
|*
|* mais informa��es
|* http://www4.bcb.gov.br/pec/taxas/batch/cotacaomoedas.asp
|* http://www4.bcb.gov.br/pec/taxas/batch/tabmoedas.asp
******************************************************************************}

{$I ACBr.inc}

unit ACBrCotacao;

interface

uses
  ACBrSocket, ACBrUtil,
  Windows, SysUtils, Variants, Classes, Contnrs;

type
  EACBrCotacao = class(Exception);

  TACBrCotacaoItem = class
  private
    FTaxaVenda: Real;
    FDataCotacao: TDateTime;
    FTaxaCompra: Real;
    FMoeda: String;
    FParidadeVenda: Real;
    FCodPais: integer;
    FParidadeCompra: Real;
    FCodigoMoeda: Integer;
    FNome: String;
    FTipo: String;
    FPais: String;
  public
    property DataCotacao: TDateTime read FDataCotacao     write FDataCotacao;
    property CodigoMoeda: Integer   read FCodigoMoeda     write FCodigoMoeda;
    property Tipo: String           read FTipo            write FTipo;
    property Moeda: String          read FMoeda           write FMoeda;
    property Nome: String           read FNome            write FNome;
    property CodPais: integer       read FCodPais         write FCodPais;
    property Pais: String           read FPais            write FPais;
    property TaxaCompra: Real       read FTaxaCompra      write FTaxaCompra;
    property TaxaVenda: Real        read FTaxaVenda       write FTaxaVenda;
    property ParidadeCompra: Real   read FParidadeCompra  write FParidadeCompra;
    property ParidadeVenda: Real    read FParidadeVenda   write FParidadeVenda;

  end;

  TACBrCotacaoItens = class(TObjectList)
  private
    function GetItem(Index: integer): TACBrCotacaoItem;
    procedure SetItem(Index: integer; const Value: TACBrCotacaoItem);
  public
    function New: TACBrCotacaoItem;
    property Items[Index: integer]: TACBrCotacaoItem read GetItem write SetItem; default;
  end;

  TACBrCotacao = class(TACBrHTTP)
  private
    FTabela: TACBrCotacaoItens;
    function GetURLTabela: String;
    function GetURLMoedas: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AtualizarTabela;
    function Procurar(const ASimbolo: String): TACBrCotacaoItem;
  published
    property Tabela: TACBrCotacaoItens read FTabela write FTabela;
  end;

implementation

{ TACBrCotacaoItens }

function TACBrCotacaoItens.GetItem(Index: integer): TACBrCotacaoItem;
begin
  Result := TACBrCotacaoItem(inherited Items[Index]);
end;

function TACBrCotacaoItens.New: TACBrCotacaoItem;
begin
  Result := TACBrCotacaoItem.Create;
  Add(Result);
end;

procedure TACBrCotacaoItens.SetItem(Index: integer;
  const Value: TACBrCotacaoItem);
begin
  Put(Index, Value);
end;

{ TACBrCotacao }

constructor TACBrCotacao.Create(AOwner: TComponent);
begin
  inherited;
  FTabela := TACBrCotacaoItens.Create;
  FTabela.Clear;
end;

destructor TACBrCotacao.Destroy;
begin
  FTabela.Free;
  inherited;
end;

function TACBrCotacao.GetURLMoedas: String;
var
  StrTmp: String;
  PosCp: Integer;
begin
  Self.HTTPGet('http://www4.bcb.gov.br/pec/taxas/batch/tabmoedas.asp');
  StrTmp := Self.RespHTTP.Text;

  PosCp := Pos('http://www4.bcb.gov.br/Download/fechamento/', StrTmp);
  StrTmp := Copy(StrTmp, PosCp, Length(StrTmp) - PosCp);

  PosCp := Pos('.csv', strTmp) + 3;
  StrTmp := Copy(StrTmp, 0, PosCp);

  Result := StrTmp;
end;

function TACBrCotacao.GetURLTabela: String;
var
  StrTmp: String;
  PosCp: Integer;
begin
  Self.HTTPGet('http://www4.bcb.gov.br/pec/taxas/batch/cotacaomoedas.asp');
  StrTmp := Self.RespHTTP.Text;

  PosCp := Pos('http://www4.bcb.gov.br/Download/fechamento/', StrTmp);
  StrTmp := Copy(StrTmp, PosCp, Length(StrTmp) - PosCp);

  PosCp := Pos('.csv', strTmp) + 3;
  StrTmp := Copy(StrTmp, 0, PosCp);

  Result := StrTmp;
end;

function TACBrCotacao.Procurar(const ASimbolo: String): TACBrCotacaoItem;
var
  I: Integer;
begin
  for I := 0 to Tabela.Count - 1 do
  begin
    if Tabela[I].Moeda = ASimbolo then
    begin
      Result := Tabela[I];
      Exit;
    end;
  end;
end;

procedure TACBrCotacao.AtualizarTabela;
var
  ItemCotacao: TStringList;
  ItemMoeda: TStringList;
  ArqCotacao: TStringList;
  ArqMoedas: TStringList;
  I: Integer;
  LinhaMoeda: String;

  function GetLinhaMoeda(CodMoeda: String): String;
  var
    I: Integer;
  begin
    for I := 0 to ArqMoedas.Count - 1 do
    begin
      if CodMoeda = Copy(ArqMoedas[I], 0, 3)  then
      begin
        Result := ArqMoedas[I];
        Exit;
      end;
    end;
  end;

begin
  ArqCotacao  := TStringList.Create;
  ArqMoedas   := TStringList.Create;
  ItemCotacao := TStringList.Create;
  ItemMoeda   := TStringList.Create;
  try
    // baixar .csv com dados da cota��o
    HTTPGet(GetURLTabela);
    ArqCotacao.Clear;
    ArqCotacao.Text := RespHTTP.Text;

    // baixar .csv com dados das moedas
    HTTPGet(GetURLMoedas);
    ArqMoedas.Clear;
    ArqMoedas.Text := RespHTTP.Text;

    // varrer a tabela preenchendo o componente
    Tabela.Clear;
    for I := 0 to ArqCotacao.Count - 1 do
    begin
      QuebrarLinha(ArqCotacao[I], ItemCotacao);

      if ItemCotacao.Count = 8 then
      begin
        // buscar os dados da moeda para a cota��o atual
        LinhaMoeda := GetLinhaMoeda(ItemCotacao[1]);
        QuebrarLinha(LinhaMoeda, ItemMoeda);

        // adicionar nova cota��o a lista
        with Tabela.New do
        begin
          // dados da cota��o
          DataCotacao    := StrToDate(ItemCotacao[0]);
          CodigoMoeda    := StrToInt(ItemCotacao[1]);
          Tipo           := ItemCotacao[2];
          Moeda          := ItemCotacao[3];
          TaxaCompra     := StrToFloat(ItemCotacao[4]);
          TaxaVenda      := StrToFloat(ItemCotacao[5]);
          ParidadeCompra := StrToFloat(ItemCotacao[6]);
          ParidadeVenda  := StrToFloat(ItemCotacao[7]);

          // dados da moeda
          if ItemMoeda.Count = 7 then
          begin
            Nome        := ItemMoeda[1];
            CodPais     := StrToInt(ItemMoeda[3]);
            Pais        := ItemMoeda[4];
          end;
        end;
      end;
    end;
  finally
    ArqCotacao.Free;
    ArqMoedas.Free;
    ItemCotacao.Free;
    ItemMoeda.Free;
  end;
end;

end.
