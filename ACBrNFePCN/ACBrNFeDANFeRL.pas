{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Nota Fiscal}
{ eletr�nica - NFe - http://www.nfe.fazenda.gov.br                          }
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
|* 16/12/2008: Wemerson Souto
|*  - Doa��o do componente para o Projeto ACBr
|* 20/08/2009: Caique Rodrigues
|*  - Doa��o units para gera��o do Danfe via QuickReport
|* 20/11/2009: Peterson de Cerqueira Matos
|*             E-mail: peterson161@yahoo.com - Tel: (11) 7197-1474 / 8059-4055
|*  - Componente e Units do QuickReport clonados
|*    e transformados em FORTES REPORT
|* 27/01/2010: Peterson de Cerqueira Matos
|*  - Acr�scimo dos par�metros "ALarguraCodProd" nas Class procedures
|*    "Imprimir" e "SavePDF"
|* 05/02/2010: Peterson de Cerqueira Matos
|*  - Acr�scimo dos par�metros "FEmail", "FResumoCanhoto", "FFax", "FNumCopias",
|*    "FSsitema", "FSite", "FUsuario" nas Class procedures
|*    "Imprimir" e "SavePDF"
|* 11/02/2010: Peterson de Cerqueira Matos
|*  - Corre��o na exibi��o do 'Preview' para modo 'MODAL'
******************************************************************************}
{$I ACBr.inc}
unit ACBrNFeDANFeRL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RLReport, pcnNFe, ACBrNFe, RLFilters;
type
  TfrlDANFeRL = class(TForm)
    RLNFe: TRLReport;

  private
    { Private declarations }
  protected
    FACBrNFe: TACBrNFe;
    FNFe: TNFe;
    FLogo: String;
    FMarcaDagua: String;
    FLarguraCodProd: Integer;
    FEmail: String;
    FResumoCanhoto: Boolean;
    FFax: String;
    FNumCopias: Integer;
    FSsitema: String;
    FSite: String;
    FUsuario: String;
    AfterPreview : boolean ;
    ChangedPos : boolean ;
    FSemValorFiscal : boolean ;
    procedure qrlSemValorFiscalPrint(sender: TObject; var Value: String);
  public
    { Public declarations }
    class procedure Imprimir(ANFe: TNFe; ALogo: String = '';
                    AMarcaDagua: String = ''; ALarguraCodProd: Integer = 52;
                    AEmail: String = ''; AResumoCanhoto: Boolean = False;
                    AFax: String = ''; ANumCopias: Integer = 1;
                    ASistema: String = ''; ASite: String = '';
                    AUsuario: String = '' ; APreview : Boolean = True);

    class procedure SavePDF(ANFe: TNFe; ALogo: String = '';
                    AMarcaDagua: String = ''; ALarguraCodProd: Integer = 52;
                    AEmail: String = ''; AResumoCanhoto: Boolean = False;
                    AFax: String = ''; ANumCopias: Integer = 1;
                    ASistema: String = ''; ASite: String = '';
                    AUsuario: String = ''; AFile: String = '';
                    APreview : Boolean = True);
  end;

implementation

uses MaskUtils;
var iCopias: Integer;

{$R *.dfm}

class procedure TfrlDANFeRL.Imprimir(ANFe: TNFe; ALogo: String = '';
                    AMarcaDagua: String = ''; ALarguraCodProd: Integer = 52;
                    AEmail: String = ''; AResumoCanhoto: Boolean = False;
                    AFax: String = ''; ANumCopias: Integer = 1;
                    ASistema: String = ''; ASite: String = '';
                    AUsuario: String = '' ; APreview : Boolean = True);
begin
  with Create ( nil ) do
    try
      FNFe := ANFe;
      FLogo := ALogo;
      FMarcaDagua := AMarcaDagua;
      FLarguraCodProd := ALarguraCodProd;
      FEmail := AEmail;
      FResumoCanhoto := AResumoCanhoto;
      FFax := AFax;
      FNumCopias := ANumCopias;
      FSsitema := ASistema;
      FSite := ASite;
      FUsuario := AUsuario;
      for iCopias := 1 to FNumCopias do
        begin
          if APreview then
            RLNFe.Preview
          else
            begin
              AfterPreview := True ;
              RLNFe.Print ;
            end;
        end;
    finally
      Free ;
    end ;
end;

class procedure TfrlDANFeRL.SavePDF(ANFe: TNFe; ALogo: String = '';
                    AMarcaDagua: String = ''; ALarguraCodProd: Integer = 52;
                    AEmail: String = ''; AResumoCanhoto: Boolean = False;
                    AFax: String = ''; ANumCopias: Integer = 1;
                    ASistema: String = ''; ASite: String = '';
                    AUsuario: String = '' ; AFile: String = '';
                    APreview : Boolean = True);
begin
  with Create ( nil ) do
    try
      FNFe := ANFe;
      FLogo := ALogo;
      FMarcaDagua := AMarcaDagua;
      FLarguraCodProd := ALarguraCodProd;
      FEmail := AEmail;
      FResumoCanhoto := AResumoCanhoto;
      FFax := AFax;
      FNumCopias := ANumCopias;
      FSsitema := ASistema;
      FSite := ASite;
      FUsuario := AUsuario;
      RLNFe.SaveToFile(AFile);
    finally
      Free ;
    end ;
end;

procedure TfrlDANFeRL.qrlSemValorFiscalPrint(sender: TObject;
  var Value: String);
begin
  inherited;
  if FSemValorFiscal then
     Value := '' ;
end;

end.
