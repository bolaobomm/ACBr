unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ACBrCotacao, ACBrBase, ACBrSocket;

type

  TfrmPrincipal = class(TForm)
    GroupBox1: TGroupBox;
    btnAtualizarMostrar: TButton;
    ACBrCotacao1: TACBrCotacao;
    btnProcurarSimbolo: TButton;
    ListBox1: TListBox;
    procedure btnAtualizarMostrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnProcurarSimboloClick(Sender: TObject);
  private

  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnAtualizarMostrarClick(Sender: TObject);
var
  I: Integer;
begin
  ListBox1.Items.BeginUpdate;
  try
    ListBox1.Clear;

    ACBrCotacao1.AtualizarTabela;
    for I := 0 to ACBrCotacao1.Tabela.Count - 1 do
    begin
      ListBox1.Items.Add(
        Format('%s  %3.3d  %s  %s  %-20s  %5.5d  %-50s  %10.2f  %10.2f  %10.2f  %10.2f', [
          DateToStr(ACBrCotacao1.Tabela[I].DataCotacao),
          ACBrCotacao1.Tabela[I].CodigoMoeda,
          ACBrCotacao1.Tabela[I].Tipo,
          ACBrCotacao1.Tabela[I].Moeda,
          ACBrCotacao1.Tabela[I].Nome,
          ACBrCotacao1.Tabela[I].CodPais,
          ACBrCotacao1.Tabela[I].Pais,
          ACBrCotacao1.Tabela[I].TaxaCompra,
          ACBrCotacao1.Tabela[I].TaxaVenda,
          ACBrCotacao1.Tabela[I].ParidadeCompra,
          ACBrCotacao1.Tabela[I].ParidadeVenda
        ])
      );
    end;
  finally
    ListBox1.Items.EndUpdate;
  end;
end;

procedure TfrmPrincipal.btnProcurarSimboloClick(Sender: TObject);
var
  Simbolo: String;
  Item: TACBrCotacaoItem;
begin
  if ACBrCotacao1.Tabela.Count = 0 then
  begin
    if Application.MessageBox('Deseja atualizar a tabela de cotações?', 'Atualizar', MB_ICONQUESTION + MB_YESNO) = ID_YES then
      ACBrCotacao1.AtualizarTabela
    else
      raise Exception.Create('Antes de continuar atualize a tabela de cotações!');
  end;

  Simbolo := AnsiUpperCase(Trim(InputBox('Procurar', 'Informe o código da moeda:', '')));
  if Simbolo <> '' then
  begin
    Item := ACBrCotacao1.Procurar(Simbolo);

    if Item <> nil then
    begin
      ShowMessage(
        'Data Cotacao: ' + DateToStr(Item.DataCotacao) + sLineBreak +
        'Codigo Moeda: ' + IntToStr(Item.CodigoMoeda) + sLineBreak +
        'Tipo: ' + Item.Tipo + sLineBreak +
        'Moeda: ' + Item.Moeda + sLineBreak +
        'Nome: ' + Item.Nome + sLineBreak +
        'Cod Pais: ' + IntToStr(Item.CodPais) + sLineBreak +
        'Pais: ' + Item.Pais + sLineBreak +
        'Taxa Compra: ' + FloatToStr(Item.TaxaCompra) + sLineBreak +
        'Taxa Venda: ' + FloatToStr(Item.TaxaVenda) + sLineBreak +
        'Paridade Compra: ' + FloatToStr(Item.ParidadeCompra) + sLineBreak +
        'Paridade Venda: ' + FloatToStr(Item.ParidadeVenda)
      );
    end
    else
      raise Exception.Create('Não foi encontrado nenhuma cotação para a moeda informada!');
  end;
  
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
end;

end.
