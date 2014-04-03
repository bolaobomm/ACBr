unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, DBClient, StdCtrls, Buttons, ExtCtrls, ACBrBase,
  ACBrSocket, ACBrTabelasSped, typinfo;

type
  TForm1 = class(TForm)
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    ClientDataSet1Id: TStringField;
    ClientDataSet1Pacote: TStringField;
    ClientDataSet1Tipo: TStringField;
    ClientDataSet1Desc: TStringField;
    ClientDataSet1Versao: TStringField;
    ClientDataSet1DtCriacao: TDateField;
    ClientDataSet1DtVersao: TDateField;
    ClientDataSet1Hash: TStringField;
    Panel1: TPanel;
    BtnListar: TBitBtn;
    BtnDow: TBitBtn;
    BtnDowT: TBitBtn;
    ACBrTabelasSped1: TACBrTabelasSped;
    ComboBox1: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure BtnListarClick(Sender: TObject);
    procedure BtnDowClick(Sender: TObject);
    procedure BtnDowTClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1       : TForm1;
  bId, bversao: string;

implementation

{$R *.dfm}

procedure TForm1.BtnDowClick(Sender: TObject);
begin
  ACBrTabelasSped1.CodSistema := TACBrCodSistema(ComboBox1.ItemIndex);

  bId     := ClientDataSet1.FieldByName('Id').AsString;
  bversao := ClientDataSet1.FieldByName('Versao').AsString;

  if ACBrTabelasSped1.Download(bId, bversao, bId + bversao + '.txt') then
    MessageDlg('Download comcluido com sucesso', mtInformation, [mbOK], 0)
  else
    MessageDlg('Falha ao efetuar o download', mtError, [mbOK], 0);
end;

procedure TForm1.BtnDowTClick(Sender: TObject);
var
  Ok, Ok1: boolean;
begin
  ACBrTabelasSped1.CodSistema := TACBrCodSistema(ComboBox1.ItemIndex);
  Ok                          := True;
  ClientDataSet1.First;
  while not ClientDataSet1.EOF do
  begin
    bId     := ClientDataSet1.FieldByName('Id').AsString;
    bversao := ClientDataSet1.FieldByName('Versao').AsString;
    Ok1     := ACBrTabelasSped1.Download(bId, bversao, bId + bversao + '.txt');

    if Ok1 = False then
      Ok := False;

    ClientDataSet1.Next;
    Application.ProcessMessages;
  end;
  if Ok = True then
    MessageDlg('Download comcluido com sucesso', mtInformation, [mbOK], 0)
  else
    MessageDlg('Falha ao efetuar o download', mtError, [mbOK], 0);
end;

procedure TForm1.BtnListarClick(Sender: TObject);
var
  I: integer;
begin
  ClientDataSet1.EmptyDataSet;
  ACBrTabelasSped1.CodSistema := TACBrCodSistema(ComboBox1.ItemIndex);
  ACBrTabelasSped1.ListarTabelas;
  for I := 0 to ACBrTabelasSped1.Tabelas.Count - 1 do
  begin
    ClientDataSet1.Append;

    ClientDataSet1Id.Value        := ACBrTabelasSped1.Tabelas[I].Id;
    ClientDataSet1Pacote.Value    := ACBrTabelasSped1.Tabelas[I].Pacote;
    ClientDataSet1Tipo.Value      := ACBrTabelasSped1.Tabelas[I].Tipo;
    ClientDataSet1Desc.Value      := ACBrTabelasSped1.Tabelas[I].Desc;
    ClientDataSet1Versao.Value    := ACBrTabelasSped1.Tabelas[I].Versao;
    ClientDataSet1DtCriacao.Value := ACBrTabelasSped1.Tabelas[I].DtCriacao;
    ClientDataSet1DtVersao.Value  := ACBrTabelasSped1.Tabelas[I].DtVersao;
    ClientDataSet1Hash.Value      := ACBrTabelasSped1.Tabelas[I].Hash;

    ClientDataSet1.Post;
    Application.ProcessMessages;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
Var
  I: TACBrCodSistema;
begin
  ComboBox1.Items.Clear;
  For I := Low(TACBrCodSistema) to High(TACBrCodSistema) do
    ComboBox1.Items.Add(GetEnumName(TypeInfo(TACBrCodSistema), integer(I)));
  ComboBox1.ItemIndex := 0;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ClientDataSet1.CreateDataSet;
end;

end.
