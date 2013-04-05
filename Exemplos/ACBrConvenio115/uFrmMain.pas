unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ACBrConvenio115;

type
  TForm3 = class(TForm)
    Button1: TButton;
    ACBrConvenio115: TACBrConvenio115;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  FileCtrl;

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var
  ADir: string;
  OMestre: TACBrConvenio115Mestre;
  ODetalhe: TACBrConvenio115Item;
  I: Integer;
  A: Integer;
begin
// Informações de LayOut, Validador e etc verificar o cabeçalho do arquivo
// ACBrConvenio115.pas

  if not SelectDirectory('Selecione uma pasta para salvar os arquivos', '', ADir, [sdNewFolder, sdNewUI]) then
    Exit;

  with ACBrConvenio115 do
  begin
    SalvarEm := ADir;
    UF := 'MG';
    Serie := '001';
    Ano := 2013;
    Mes := 02;
//  O Responsável não será utilizado, pois é necessário para a geração do arquivo
//  totalizador. Esse arquivo o programa validador cria
//    with Responsavel do
//    begin
//      Nome := 'Jéter Rabelo Ferreira';
//      Cargo := 'Contador';
//      EMail := 'jeter.rabelo@jerasoft.com.br';
//    end;

    for I := 0 to 3 do
    begin
      OMestre := TACBrConvenio115Mestre.Create;
      OMestre.Destinatario.CnpjCpf := '123.456.789-09';
      OMestre.Destinatario.InscricaoEstadual := '1234567890';
      OMestre.Destinatario.RazaoSocial := 'Jéter Rabelo Ferreira';
      OMestre.Destinatario.Logradouro := 'Av. Antonio Carlos';
      OMestre.Destinatario.Numero := '150';
      OMestre.Destinatario.Complemento := '';
      OMestre.Destinatario.CEP := '37730-000';
      OMestre.Destinatario.Bairro := 'Centro';
      OMestre.Destinatario.Municipio := 'Campestre';
      OMestre.Destinatario.UF := 'MG';
      OMestre.Destinatario.Telefone := '3537430000';
      OMestre.Destinatario.CodigoConsumidor := '1001'; // Código do Cliente
      OMestre.TipoAssinante := tac111ResidencialPessoaFisica;
      OMestre.TipoUtilizacao := pc112ProvimentoAcessoInternet;
      OMestre.DataEmissao := StrToDate('01/01/2013');
      OMestre.Modelo := 21;
      OMestre.Serie := '001';
      OMestre.NumeroNF := I + 1;
      OMestre.ValorTotal := 100;
      OMestre.ICMS_BaseCalculo := 0;
      OMestre.ICMS_Valor := 0;
      OMestre.IsentosNaoTributadas := 0;
      OMestre.OutrosValores := 0;
      OMestre.IsentosNaoTributadas := 0;
      OMestre.AnoMesRefencia := '1212'; // AAMM
//      for A := 0 to count -1 do
//      begin
        // Será informado apenas 1 item para exemplo, por isso o comando FOR está comentado
        // Informar todos os detalhes (Items) que compõem a NF (Serviço/Juros e etc)
        ODetalhe := TACBrConvenio115Item.Create;
        ODetalhe.TipoAssinante := tac111ResidencialPessoaFisica;
        ODetalhe.TipoUtilizacao := pc112ProvimentoAcessoInternet;
        ODetalhe.CFOP := '5307';
        ODetalhe.Item := 1;
        ODetalhe.CodigoServico := '1' ;
        ODetalhe.DescricaoServico := 'Provimento de acesso a internet';
        ODetalhe.Unidade := '';
        ODetalhe.ClassificacaoItem := '1001' ; // Verificar tabela 11.5 do convênio
        ODetalhe.QtdeContratada := 0;
        ODetalhe.QtdePrestada := 0;
        ODetalhe.ValorTotal := 100;
        ODetalhe.Desconto := 0;
        ODetalhe.AcrescimosDespAcessorias := 0;
        ODetalhe.ICMSBaseCalculo := 0;
        ODetalhe.ICMSValor := 0;
        ODetalhe.ICMSAliquota := 0;
        ODetalhe.IsentoNaoTributados := 0;
        ODetalhe.OutrosValores := 0;
        ODetalhe.AnoMesApuracao := '1212';
        OMestre.Detalhes.Add(ODetalhe);
//      end;
      Mestre.Add(OMestre);
    end;
    Gerar;
    MessageDlg('Término do processo!', mtInformation, [mbOK], 0);
  end;
end;

end.
