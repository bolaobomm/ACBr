{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009   http://www.produsys.com.br/          }
{                                                                              }
{ Colaboradores nesse arquivo:  Juliana Rodrigues Prado, Daniel Simoes Almeida }
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
|* 01/04/2010: Juliana Rodrigues Prado Tamizou
|*  - Adapta��o do Boleto do Projeto RLBoleto  ( http://www.produsys.com.br/ )
******************************************************************************}
{$I ACBr.inc}

unit ACBRBoletoFCFortesFr;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs, RLReport, RLBarcode,
  RLPDFFilter, RLHTMLFilter, RLRichFilter, RLPrintDialog, RLMetaFile, ACBrBoleto
  {$IFDEF FPC}
    ,LResources, StdCtrls
  {$ENDIF}
 {$IFDEF VER150}
   ,Variants
 {$ELSE}
  {$IFDEF VER140}
    ,Variants, RLSaveDialog, RLFilters, RLPDFFilter
  {$ENDIF}
 {$ENDIF}
  ;

const
  CACBrBoletoFCFortes_Versao = '0.0.6a' ;

type

  { TACBRBoletoFCFortesFr }
  TACBrBoletoFCFortes = class(TACBrBoletoFCClass)
  private
    { Private declarations }
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); override;

    procedure Imprimir; override;
    procedure GerarPDF; override;
  end;

  TACBRBoletoFCFortesFr = class(TForm)
    imgCodigoBarra: TRLBarcode;
    LayoutBoleto: TRLReport;
    RLBand1: TRLBand;
    RLDraw29: TRLDraw;
    RLDraw39: TRLDraw;
    RLDraw38: TRLDraw;
    RLDraw37: TRLDraw;
    RLDraw34: TRLDraw;
    RLDraw28: TRLDraw;
    RLDraw27: TRLDraw;
    RLDraw26: TRLDraw;
    RLDraw25: TRLDraw;
    RLDraw24: TRLDraw;
    RLDraw21: TRLDraw;
    RLDraw23: TRLDraw;
    RLDraw22: TRLDraw;
    RLDraw20: TRLDraw;
    RLDraw19: TRLDraw;
    RLDraw18: TRLDraw;
    RLDraw17: TRLDraw;
    RLDraw16: TRLDraw;
    imgBanco2: TRLImage;
    RLHTMLFilter1: TRLHTMLFilter;
    RLPDFFilter1: TRLPDFFilter;
    RLPrintDialogSetup1: TRLPrintDialogSetup;
    txtNumeroBanco2: TRLLabel;
    RLLabel67: TRLLabel;
    RLLabel68: TRLLabel;
    lblLocalPagto: TRLLabel;
    RLLabel69: TRLLabel;
    txtNomeCedente2: TRLLabel;
    RLLabel70: TRLLabel;
    txtDataDocumento2: TRLLabel;
    RLLabel71: TRLLabel;
    txtNumeroDocumento2: TRLLabel;
    RLLabel72: TRLLabel;
    txtEspecieDoc2: TRLLabel;
    RLLabel73: TRLLabel;
    txtAceite2: TRLLabel;
    RLLabel74: TRLLabel;
    txtDataProcessamento2: TRLLabel;
    txtUsoBanco2: TRLLabel;
    RLLabel75: TRLLabel;
    txtCarteira2: TRLLabel;
    RLLabel76: TRLLabel;
    RLLabel77: TRLLabel;
    txtEspecie2: TRLLabel;
    RLLabel78: TRLLabel;
    txtQuantidade2: TRLLabel;
    RLLabel79: TRLLabel;
    txtValorMoeda2: TRLLabel;
    RLLabel80: TRLLabel;
    txtInstrucoes2: TRLMemo;
    RLLabel81: TRLLabel;
    txtDataVencimento2: TRLLabel;
    RLLabel82: TRLLabel;
    txtCodigoCedente2: TRLLabel;
    RLLabel83: TRLLabel;
    txtNossoNumero2: TRLLabel;
    RLLabel84: TRLLabel;
    txtValorDocumento2: TRLLabel;
    RLLabel85: TRLLabel;
    txtDesconto2: TRLLabel;
    RLLabel86: TRLLabel;
    txtMoraMulta2: TRLLabel;
    RLLabel87: TRLLabel;
    txtValorCobrado2: TRLLabel;
    RLLabel88: TRLLabel;
    txtNomeSacado2: TRLLabel;
    txtEnderecoSacado2: TRLLabel;
    txtCidadeSacado2: TRLLabel;
    RLLabel89: TRLLabel;
    txtCpfCnpjSacado2: TRLLabel;
    RLLabel90: TRLLabel;
    txtCodigoBaixa2: TRLLabel;
    RLMemo2: TRLMemo;
    RLLabel91: TRLLabel;
    RLLabel93: TRLLabel;
    RLLabel98: TRLLabel;
    RLLabel102: TRLLabel;
    txtSacadorAvalista2: TRLLabel;
    txtReferencia2: TRLLabel;
    RLBand2: TRLBand;
    RLDraw50: TRLDraw;
    RLDraw49: TRLDraw;
    RLDraw48: TRLDraw;
    RLDraw47: TRLDraw;
    RLDraw46: TRLDraw;
    RLDraw45: TRLDraw;
    RLDraw44: TRLDraw;
    RLDraw43: TRLDraw;
    RLDraw42: TRLDraw;
    RLDraw41: TRLDraw;
    RLDraw40: TRLDraw;
    RLDraw36: TRLDraw;
    RLDraw35: TRLDraw;
    RLDraw33: TRLDraw;
    imgBanco3: TRLImage;
    RLDraw81: TRLDraw;
    txtLinhaDigitavel: TRLLabel;
    RLDraw82: TRLDraw;
    txtNumeroBanco3: TRLLabel;
    RLLabel145: TRLLabel;
    txtLocalPagamento3: TRLLabel;
    txtDataVencimento3: TRLLabel;
    RLLabel146: TRLLabel;
    RLDraw83: TRLDraw;
    RLLabel147: TRLLabel;
    txtNomeCedente3: TRLLabel;
    RLLabel148: TRLLabel;
    txtCodigoCedente3: TRLLabel;
    RLLabel149: TRLLabel;
    txtDataDocumento3: TRLLabel;
    RLLabel150: TRLLabel;
    txtNumeroDocumento3: TRLLabel;
    RLLabel151: TRLLabel;
    txtEspecieDoc3: TRLLabel;
    RLLabel152: TRLLabel;
    txtAceite3: TRLLabel;
    RLLabel153: TRLLabel;
    txtDataProcessamento3: TRLLabel;
    RLLabel154: TRLLabel;
    txtNossoNumero3: TRLLabel;
    RLLabel155: TRLLabel;
    txtUsoBanco3: TRLLabel;
    RLLabel156: TRLLabel;
    txtCarteira3: TRLLabel;
    RLLabel157: TRLLabel;
    txtEspecie3: TRLLabel;
    RLLabel158: TRLLabel;
    txtQuantidade3: TRLLabel;
    RLLabel159: TRLLabel;
    txtValorMoeda3: TRLLabel;
    RLLabel160: TRLLabel;
    txtValorDocumento3: TRLLabel;
    RLLabel161: TRLLabel;
    txtInstrucoes3: TRLMemo;
    RLLabel162: TRLLabel;
    txtDesconto3: TRLLabel;
    RLLabel163: TRLLabel;
    txtMoraMulta3: TRLLabel;
    RLLabel164: TRLLabel;
    txtValorCobrado3: TRLLabel;
    RLLabel165: TRLLabel;
    txtNomeSacado3: TRLLabel;
    RLLabel166: TRLLabel;
    txtCpfCnpjSacado3: TRLLabel;
    txtEnderecoSacado3: TRLLabel;
    RLLabel167: TRLLabel;
    txtCidadeSacado3: TRLLabel;
    txtCodigoBaixa3: TRLLabel;
    RLLabel168: TRLLabel;
    RLLabel170: TRLLabel;
    RLLabel175: TRLLabel;
    txtSacadorAvalista3: TRLLabel;
    txtReferencia3: TRLLabel;
    txtSwHouse: TRLAngleLabel;
    procedure FormCreate(Sender: TObject);
    procedure LayoutBoletoBeforePrint(Sender: TObject; var PrintIt: boolean);
    procedure LayoutBoletoDataCount(Sender: TObject; var DataCount: integer);
    procedure LayoutBoletoDataRecord(Sender: TObject; RecNo: integer;
       CopyNo: integer; var Eof: boolean; var RecordAction: TRLRecordAction);
    procedure RLBand1BeforePrint(Sender: TObject; var PrintIt: boolean);
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: boolean);
  private
     fBoletoFC: TACBrBoletoFCFortes;
     fIndice: Integer;
     function GetACBrTitulo: TACBrTitulo;
    { Private declarations }
  public
    { Public declarations }
    property Indice   : Integer read fIndice ;
    property BoletoFC : TACBrBoletoFCFortes read fBoletoFC ;
    property Titulo   : TACBrTitulo read GetACBrTitulo ;
  end;

var
  ACBRBoletoFCFortesForm: TACBRBoletoFCFortesFr;

procedure Register;

implementation

Uses RLFilters, RLConsts, ACBrUtil ;

{$ifdef FPC}
  {$R *.lfm}
{$else}
  {$R *.dfm}
  {$R ACBrBoletoFCFortes.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr',[TACBrBoletoFCFortes]);
end;

{ TACBrBoletoFCFortes }

constructor TACBrBoletoFCFortes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fpAbout := 'ACBRBoletoFCFortes ver: '+CACBrBoletoFCFortes_Versao;
end;

procedure TACBrBoletoFCFortes.Imprimir;

var
  frACBrBoletoFortes : TACBRBoletoFCFortesFr;
  RLFiltro : TRLCustomSaveFilter;
begin
  inherited Imprimir;    // Executa verifica��es padroes

  frACBrBoletoFortes := TACBRBoletoFCFortesFr.Create(Self);
  try
     with frACBrBoletoFortes do
     begin
        LoadPortugueseStrings;
        RLPrintDialogSetup1.Copies := NumCopias ;
        LayoutBoleto.PrintDialog   := MostrarSetup;

        if Filtro = fiNenhum then
         begin
           if MostrarPreview then
              LayoutBoleto.PreviewModal
           else
              LayoutBoleto.Print;
         end
        else
         begin
            if LayoutBoleto.Prepare then
            begin
               case Filtro of
                 fiPDF  : RLFiltro := RLPDFFilter1;
                 fiHTML : RLFiltro := RLHTMLFilter1;
               end ;

               try
                 {$IFDEF FPC}
                  RLFiltro.Copies   := NumCopias ;
                 {$ENDIF}
                 RLFiltro.FileName := NomeArquivo ;
                 RLFiltro.Pages    := LayoutBoleto.Pages ;

                 {$IFDEF FPC}
                  RLFiltro.Run;
                 {$ENDIF}
              finally
                 RLFiltro := nil ;
               end;
            end;
         end;
     end;
  finally
     frACBrBoletoFortes.Free ;
  end;
end;

procedure TACBrBoletoFCFortes.GerarPDF;
var
   frACBrBoletoFortes   : TACBRBoletoFCFortesFr;
   FiltroAntigo         : TACBrBoletoFCFiltro;
   MostrarPreviewAntigo : Boolean;
   MostrarSetupAntigo   : Boolean;
begin
   inherited GerarPDF;

   FiltroAntigo         := Filtro;
   MostrarPreviewAntigo := MostrarPreview;
   MostrarSetupAntigo   := MostrarSetup;

   Filtro:= fiPDF;
   MostrarPreview := false;
   MostrarSetup   := false;

   Imprimir;

   Filtro := FiltroAntigo;
   MostrarPreview := MostrarSetupAntigo;
   MostrarSetup   := MostrarSetupAntigo;
end;

{ TACBRBoletoFCFortesFr }

procedure TACBRBoletoFCFortesFr.FormCreate(Sender: TObject);
begin
   fIndice   := 0 ;
   fBoletoFC := TACBrBoletoFCFortes(Owner) ;  // Link para o Pai
end;

function TACBRBoletoFCFortesFr.GetACBrTitulo: TACBrTitulo;
begin
   Result := fBoletoFC.ACBrBoleto.ListadeBoletos[ fIndice ] ;
end;

procedure TACBRBoletoFCFortesFr.LayoutBoletoBeforePrint(Sender: TObject;
   var PrintIt: boolean);
begin
   fIndice := 0 ;
   txtSwHouse.Caption := BoletoFC.SoftwareHouse ;
end;

procedure TACBRBoletoFCFortesFr.LayoutBoletoDataCount(Sender: TObject;
   var DataCount: integer);
begin
   DataCount := fBoletoFC.ACBrBoleto.ListadeBoletos.Count ;
end;

procedure TACBRBoletoFCFortesFr.LayoutBoletoDataRecord(Sender: TObject;
   RecNo: integer; CopyNo: integer; var Eof: boolean;
   var RecordAction: TRLRecordAction);
begin
   fIndice := RecNo - 1 ;

   Eof := (RecNo > fBoletoFC.ACBrBoleto.ListadeBoletos.Count) ;
   RecordAction := raUseIt ;
end;

procedure TACBRBoletoFCFortesFr.RLBand1BeforePrint(Sender: TObject;
   var PrintIt: boolean);
Var
   DigNossoNum : String;
begin
   with fBoletoFC.ACBrBoleto do
   begin
      DigNossoNum    := Banco.CalcularDigitoVerificador( Titulo );

      fBoletoFC.CarregaLogo( imgBanco2.Picture, Banco.Numero );
      txtNumeroBanco2.Caption         := IntToStrZero(Banco.Numero, 3)+ '-' +
                                         IntToStrZero(Banco.Digito, 1);
      lblLocalPagto.Caption           := Titulo.LocalPagamento;
      txtDataVencimento2.Caption      := FormatDateTime('dd/mm/yyyy', Titulo.Vencimento);
      txtNomeCedente2.Caption         := Cedente.Nome;
      txtCodigoCedente2.Caption       := Cedente.Agencia+'/'+ Cedente.Conta;
      txtDataDocumento2.Caption       := FormatDateTime('dd/mm/yyyy', Titulo.DataDocumento);
      txtNumeroDocumento2.Caption     := Titulo.NumeroDocumento;
      txtEspecieDoc2.Caption          := Titulo.EspecieDoc;
      txtAceite2.Caption              := Titulo.Aceite;
      txtDataProcessamento2.Caption   := FormatDateTime('dd/mm/yyyy',Now);
      txtNossoNumero2.Caption         := Titulo.NossoNumero + DigNossoNum;
      txtUsoBanco2.Caption            := Titulo.UsoBanco;
      txtCarteira2.Caption            := Titulo.Carteira;
      txtEspecie2.Caption             := 'R$';
      txtValorDocumento2.Caption      := FormatFloat('###,###,##0.00',Titulo.ValorDocumento);
      txtNomeSacado2.Caption          := Titulo.Sacado.NomeSacado;
      txtEnderecoSacado2.Caption      := Titulo.Sacado.Logradouro + ' '+
                                         Titulo.Sacado.Numero + Titulo.Sacado.Complemento;
      txtCidadeSacado2.Caption        := Titulo.Sacado.CEP + ' '+Titulo.Sacado.Cidade +
                                         ' '+Titulo.Sacado.UF;
      txtCpfCnpjSacado2.Caption       := Titulo.Sacado.CNPJCPF;
      txtInstrucoes2.Lines.Text       := Titulo.Mensagem.Text;
   end;
end;

procedure TACBRBoletoFCFortesFr.RLBand2BeforePrint(Sender: TObject;
   var PrintIt: boolean);
Var
  CodBarras, LinhaDigitavel : String;
begin
  with fBoletoFC.ACBrBoleto do
  begin
     CodBarras      := Banco.MontarCodigoBarras( Titulo );
     LinhaDigitavel := Banco.MontarLinhaDigitavel( CodBarras );

     imgBanco3.Picture.Assign(imgBanco2.Picture);
     txtNumeroBanco3.Caption         := txtNumeroBanco2.Caption;
     txtLocalPagamento3.Caption      := lblLocalPagto.Caption;
     txtDataVencimento3.Caption      := txtDataVencimento2.Caption;
     txtNomeCedente3.Caption         := txtNomeCedente2.Caption;
     txtCodigoCedente3.Caption       := txtCodigoCedente2.Caption;
     txtDataDocumento3.Caption       := txtDataDocumento2.Caption;
     txtNumeroDocumento3.Caption     := txtNumeroDocumento2.Caption;
     txtEspecie3.Caption             := txtEspecie2.Caption;
     txtAceite3.Caption              := txtAceite2.Caption;
     txtDataProcessamento3.Caption   := txtDataProcessamento2.Caption;
     txtNossoNumero3.Caption         := txtNossoNumero2.Caption;
     txtUsoBanco3.Caption            := txtUsoBanco2.Caption;
     txtCarteira3.Caption            := txtCarteira2.Caption;
     txtEspecieDoc3.Caption          := txtEspecieDoc2.Caption;
     txtValorDocumento3.Caption      := txtValorDocumento2.Caption;
     txtEnderecoSacado3.Caption      := txtEnderecoSacado2.Caption;
     txtCidadeSacado3.Caption        := txtCidadeSacado2.Caption;
     txtCpfCnpjSacado3.Caption       := txtCpfCnpjSacado2.Caption;

     imgCodigoBarra.Caption          := CodBarras;
     txtLinhaDigitavel.Caption       := LinhaDigitavel;
     txtInstrucoes3.Lines.Text       := txtInstrucoes2.Lines.Text;
   end;
end;

{$ifdef FPC}
initialization
   {$I ACBrBoletoFCFortes.lrs}
{$endif}

end.

