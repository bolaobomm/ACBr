unit frmCalculoSedex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Mask, ACBrBase, ACBrSocket, ACBrSedex,
  TypInfo, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    EditCEPOrigem: TEdit;
    EditCEPDestino: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditPeso: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    EditComprimento: TEdit;
    Label5: TLabel;
    EditLargura: TEdit;
    Label6: TLabel;
    EditAltura: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    EditDiametro: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    cbFormato: TComboBox;
    cbMaoPropria: TComboBox;
    Label14: TLabel;
    cbAvisoReceb: TComboBox;
    Panel2: TPanel;
    retValorFrete: TEdit;
    retValorMaoPropria: TEdit;
    retPrzEntrega: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    btnConsultar: TButton;
    retEntregaSabado: TEdit;
    retEntregaDomiciliar: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    retValorAvisoReceb: TEdit;
    lblValorAvisoReceb: TLabel;
    retValorDeclarado: TEdit;
    Label18: TLabel;
    Image1: TImage;
    cbServico: TComboBox;
    Label19: TLabel;
    retCodigoServico: TEdit;
    EditValorDeclarado: TEdit;
    ACBrSedex1: TACBrSedex;
    EdtContrato: TEdit;
    EdtSenha: TEdit;
    Label20: TLabel;
    Label21: TLabel;
    procedure btnConsultarClick(Sender: TObject);
  private
  public
  end;

function IfThen(AValue: Boolean; const ATrue: string; AFalse: string = ''): string; overload;

var
  Form1: TForm1;
  nValorFrete: Currency;
  tempDir: String;

implementation

{$R *.dfm}

function IfThen(AValue: Boolean; const ATrue: string; AFalse: string = ''): string;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

procedure TForm1.btnConsultarClick(Sender: TObject);
begin
ACBrSedex1.CodContrato := EdtContrato.Text;
ACBrSedex1.Senha := EdtSenha.Text;
ACBrSedex1.CepOrigem := EditCEPOrigem.Text;
ACBrSedex1.CepDestino := EditCEPDestino.Text;
ACBrSedex1.Peso := StrToFloatDef(EditPeso.Text,0);
ACBrSedex1.Formato := TACBrTpFormato(cbFormato.ItemIndex);
ACBrSedex1.MaoPropria := TACBrMaoPropria(cbMaoPropria.ItemIndex);
ACBrSedex1.AvisoRecebimento := TACBrAvisoRecebimento(cbAvisoReceb.ItemIndex);
ACBrSedex1.Comprimento := StrToFloatDef(EditComprimento.Text,0);
ACBrSedex1.Largura := StrToFloatDef(EditLargura.Text,0);
ACBrSedex1.Altura := StrToFloatDef(EditAltura.Text,0);
ACBrSedex1.Servico := TACBrTpServico(cbAvisoReceb.ItemIndex);
ACBrSedex1.Diametro := StrToFloatDef(EditDiametro.Text,0);
ACBrSedex1.ValorDeclarado := StrToFloatDef(EditValorDeclarado.Text,0);

 if Not ACBrSedex1.Consultar  then
  MessageDlg('Não Foi Possivel Fazer a Consulta:'+sLineBreak+
   IntToStr(ACBrSedex1.retErro)+' - '+ACBrSedex1.retMsgErro, mtError, [mbOK], 0)
 Else
 Begin
 retCodigoServico.Text := ACBrSedex1.retCodigoServico;
 retValorFrete.Text := FloatToStr(ACBrSedex1.retValor);
 retValorMaoPropria.Text := FloatToStr(ACBrSedex1.retValorMaoPropria);
 retValorAvisoReceb.Text := FloatToStr(ACBrSedex1.retValorAvisoRecebimento);
 retValorDeclarado.Text := FloatToStr(ACBrSedex1.retValorValorDeclarado);
 retEntregaDomiciliar.Text := ACBrSedex1.retEntregaDomiciliar;
 retEntregaSabado.Text := ACBrSedex1.retEntregaSabado;
 retPrzEntrega.Text := IntToStr(ACBrSedex1.retPrazoEntrega);
 End;
end;

end.
