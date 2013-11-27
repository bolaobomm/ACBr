{******************************************************************************}
{ Projeto: Componente ACBrCTe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Conhecimen-}
{ to de Transporte eletr�nico - CTe - http://www.cte.fazenda.gov.br            }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
******************************************************************************}

{$I ACBr.inc}

unit ACBrCTeDAEventoQR;

// Aten��o todos os comiters
// Quando enviar os fontes referentes ao DAEvento favor alterar
// a data e o nome da linha abaixo.
// �ltima libera��o:
// 26/11/2013 por Italo Jurisato Junior

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls,
  {$IFDEF QReport_PDF}
     QRPDFFilt, QRPrntr,
  {$ENDIF}
  ACBrCTeQRCodeBar, pcteCTe, ACBrCTe, ACBrCTeUtil, Printers, pcnConversao,
  pcteEnvEventoCTe;

type

  TfrmCTeDAEventoQR = class(TForm)
    QRCTeEvento: TQuickRep;
    procedure FormDestroy(Sender: TObject);
  private

  protected
    //BarCode : TBarCode128c;
    FACBrCTe            : TACBrCTe;
    FCTe                : TCTe;
    FEventoCTe          : TInfEventoCollectionItem;
    FLogo               : String;
    FNumCopias          : Integer;
    FSistema            : String;
    FUsuario            : String;
    FMostrarPreview     : Boolean;
    FMargemSuperior     : Double;
    FMargemInferior     : Double;
    FMargemEsquerda     : Double;
    FMargemDireita      : Double;
    FImpressora         : String;

    procedure SetBarCodeImage(ACode: string; QRImage: TQRImage);
  public
    class procedure Imprimir(AEventoCTe: TInfEventoCollectionItem;
                             ALogo: String = '';
                             ANumCopias: Integer = 1;
                             ASistema: String = '';
                             AUsuario: String = '';
                             AMostrarPreview: Boolean = True;
                             AMargemSuperior: Double = 0.7;
                             AMargemInferior: Double = 0.7;
                             AMargemEsquerda: Double = 0.7;
                             AMargemDireita: Double = 0.7;
                             AImpressora: String = '';
                             ACTe: TCTe = nil);

    class procedure SavePDF(AEventoCTe: TInfEventoCollectionItem;
                            ALogo: String = '';
                            AFile: String = '';
                            ASistema: String = '';
                            AUsuario: String = '';
                            AMargemSuperior: Double = 0.7;
                            AMargemInferior: Double = 0.7;
                            AMargemEsquerda: Double = 0.7;
                            AMargemDireita: Double = 0.7;
                            ACTe: TCTe = nil);
  end;

implementation

uses
  MaskUtils;

var
  Printer: TPrinter;

{$R *.dfm}

class procedure TfrmCTeDAEventoQR.Imprimir(AEventoCTe: TInfEventoCollectionItem;
                                        ALogo: String = '';
                                        ANumCopias: Integer = 1;
                                        ASistema: String = '';
                                        AUsuario: String = '';
                                        AMostrarPreview: Boolean = True;
                                        AMargemSuperior: Double = 0.7;
                                        AMargemInferior: Double = 0.7;
                                        AMargemEsquerda: Double = 0.7;
                                        AMargemDireita: Double = 0.7;
                                        AImpressora: String = '';
                                        ACTe: TCTe = nil);
begin
  with Create ( nil ) do
     try
        FEventoCTe      := AEventoCTe;
        FLogo           := ALogo;
        FNumCopias      := ANumCopias;
        FSistema        := ASistema;
        FUsuario        := AUsuario;
        FMostrarPreview := AMostrarPreview;
        FMargemSuperior := AMargemSuperior;
        FMargemInferior := AMargemInferior;
        FMargemEsquerda := AMargemEsquerda;
        FMargemDireita  := AMargemDireita;
        FImpressora     := AImpressora;

        if ACTe <> nil then
         FCTe := ACTe;

        Printer := TPrinter.Create;

        if FImpressora > '' then
          QRCTeEvento.PrinterSettings.PrinterIndex := Printer.Printers.IndexOf(FImpressora);

        if AMostrarPreview then
         begin
           QRCTeEvento.PrinterSettings.Copies := FNumCopias;

         {$IFDEF QReport_PDF}
           QRCTeEvento.PrevShowSearch      := False;
           QRCTeEvento.PrevShowThumbs      := False;
           QRCTeEvento.PreviewInitialState := wsMaximized;
           QRCTeEvento.PrevInitialZoom     := qrZoomToWidth;

           // Incluido por Italo em 14/02/2012
           // QRCTeEvento.PreviewDefaultSaveType := stPDF;
           // Incluido por Italo em 16/02/2012
           QRExportFilterLibrary.AddFilter(TQRPDFDocumentFilter);
         {$ENDIF}

           QRCTeEvento.Prepare;
//           FTotalPages := QRCTeEvento.QRPrinter.PageCount;
           QRCTeEvento.Preview;
           // Incluido por Italo em 11/04/2013
           // Segundo o Rodrigo Chiva resolveu o problema de travamento
           // ap�s o fechamento do Preview
           Application.ProcessMessages;
         end else
         begin
           FMostrarPreview := True;
           QRCTeEvento.PrinterSettings.Copies := FNumCopias;
           QRCTeEvento.Prepare;
//           FTotalPages := QRCTeEvento.QRPrinter.PageCount;
           QRCTeEvento.Print;
         end;
     finally
        // Incluido por Rodrigo Fernandes em 17/06/2013
        // QRCTeEvento.QRPrinter.Free;
        // QRCTeEvento.QRPrinter:=nil;

        // Incluido por Italo em 21/08/2013
        QRCTeEvento.Free;
        QRCTeEvento := nil;

        // Incluido por Rodrigo Fernandes em 11/03/2013
        // Liberando o objeto Printer da memoria
        Printer.Free;
        Free;
     end;
end;

class procedure TfrmCTeDAEventoQR.SavePDF(AEventoCTe: TInfEventoCollectionItem;
                                       ALogo: String = '';
                                       AFile: String = '';
                                       ASistema: String = '';
                                       AUsuario: String = '';
                                       AMargemSuperior: Double = 0.7;
                                       AMargemInferior: Double = 0.7;
                                       AMargemEsquerda: Double = 0.7;
                                       AMargemDireita: Double = 0.7;
                                       ACTe: TCTe = nil);
{$IFDEF QReport_PDF}
 var
  qf : TQRPDFDocumentFilter;
  i  : Integer;
{$ENDIF}
begin
{$IFDEF QReport_PDF}
  with Create ( nil ) do
     try
        FEventoCTe      := AEventoCTe;
        FLogo           := ALogo;
        FSistema        := ASistema;
        FUsuario        := AUsuario;
        FMargemSuperior := AMargemSuperior;
        FMargemInferior := AMargemInferior;
        FMargemEsquerda := AMargemEsquerda;
        FMargemDireita  := AMargemDireita;

        if ACTe <> nil then
          FCTe := ACTe;

        for i := 0 to ComponentCount -1 do
          begin
            if (Components[i] is TQRShape) and (TQRShape(Components[i]).Shape = qrsRoundRect) then
              begin
                TQRShape(Components[i]).Shape := qrsRectangle;
                TQRShape(Components[i]).Pen.Width := 1;
              end;
          end;

        FMostrarPreview := True;
        QRCTeEvento.Prepare;
        // Incluido por Italo em 27/08/2013
//        FTotalPages := QRCTeEvento.QRPrinter.PageCount;

        qf := TQRPDFDocumentFilter.Create(AFile);
        qf.CompressionOn := False;
        QRCTeEvento.QRPrinter.ExportToFilter( qf );
        qf.Free;
     finally
        Free;
     end;
{$ENDIF}
end;

procedure TfrmCTeDAEventoQR.SetBarCodeImage(ACode: string; QRImage: TQRImage);
var
  b : TBarCode128c;
begin
  b := TBarCode128c.Create;
  //      Width  := QRImage.Width;
  b.Code := ACode;
  b.PaintCodeToCanvas(ACode, QRImage.Canvas, QRImage.ClientRect);
  b.free;
end;

// Incluido por Rodrigo Fernandes em 11/03/2013
procedure TfrmCTeDAEventoQR.FormDestroy(Sender: TObject);
begin
  QRCTeEvento.QRPrinter.Free;
  QRCTeEvento.Free;
end;

end.

