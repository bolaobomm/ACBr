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
|* 09/03/2009: Dulcemar P.Zilli
|*  - Correcao impress�o informa��es IPI
|* 11/03/2008: Dulcemar P.Zilli
|*  - Inclus�o Observa��es Fisco
|* 11/03/2008: Dulcemar P.Zilli
|*  - Inclus�o totais ISSQN
|* 23/06/2009: Jo�o H. Souza
|*  - Altera��es diversas
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFeDANFERave;

interface

uses Forms, SysUtils, Classes, RpDefine, RVClass, RVProj, RVCsBars,
  ACBrNFeDANFEClass, ACBrNFeDANFERaveDM, pcnNFe, pcnConversao;

type
  TACBrNFeDANFERave = class( TACBrNFeDANFEClass )
   private
    dmDanfe : TdmACBrNFeRave;
    FRaveFile: String;
   public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE : TNFe = nil); override ;
    procedure ImprimirDANFEPDF(NFE : TNFe = nil); override ;
  published
    property RavFile : String read FRaveFile write FRaveFile ;
  end;

implementation

uses ACBrNFe, ACBrNFeUtil, ACBrUtil, StrUtils, Dialogs;

constructor TACBrNFeDANFERave.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
  dmDanfe := TdmACBrNFeRave.Create(Self);
  FRaveFile := '' ;
end;

destructor TACBrNFeDANFERave.Destroy;
begin

  dmDanfe.Free;
  inherited Destroy ;
end;

procedure TACBrNFeDANFERave.ImprimirDANFE(NFE : TNFe = nil);
var
 i : Integer;
 MyPage: TRavePage;
 MyBarcode: TRaveCode128BarCode;
begin
  if FRaveFile = '' then
      raise Exception.Create(' Arquivo de Relat�rio nao informado.') ;

  if not FilesExists(FRaveFile) then
     raise Exception.Create('Arquivo '+FRaveFile+' Nao encontrado');

  RPDefine.DataID := IntToStr(Application.Handle);  // Evita msg de erro;...
     
  dmDanfe.RvProject.ProjectFile := FRaveFile ; //ExtractFileDir(application.ExeName)+'\Report\NotaFiscalEletronica.rav';

  dmDanfe.RvSystem1.DoNativeOutput := True;
  if MostrarPreview then
   begin
     dmDanfe.RvSystem1.DefaultDest    := rdPreview;
     dmDanfe.RvSystem1.SystemSetups:=dmDanfe.RvSystem1.SystemSetups + [ssAllowSetup];
   end
  else
   begin
     dmDanfe.RvSystem1.DefaultDest    := rdPrinter;
     dmDanfe.RvSystem1.SystemSetups:=dmDanfe.RvSystem1.SystemSetups - [ssAllowSetup];     
   end;
  dmDanfe.RvSystem1.RenderObject   := nil;
  dmDanfe.RvSystem1.OutputFileName := '';
  dmDanfe.RvProject.Engine := dmDanfe.RvSystem1;
  dmDanfe.RvSystem1.TitlePreview:='Visualizar DANFE';
  dmDanfe.RvSystem1.TitleSetup:='Configura��es';
  dmDanfe.RvSystem1.TitleStatus:='Status da Impress�o';
  dmDanfe.RvSystem1.SystemFiler.StatusFormat:='Gerando p�gina %p';
  dmDanfe.RvSystem1.SystemFiler.StreamMode:=smTempFile;
  dmDanfe.RvSystem1.SystemOptions:=[soShowStatus,soAllowPrintFromPreview,soPreviewModal];
  dmDanfe.RvSystem1.SystemPreview.FormState:=wsMaximized;
  dmDanfe.RvSystem1.SystemPreview.ZoomFactor:=100;
  dmDanfe.RvSystem1.SystemPrinter.Copies:=NumCopias;
  dmDanfe.RvSystem1.SystemPrinter.LinesPerInch:=8;
  dmDanfe.RvSystem1.SystemPrinter.StatusFormat:='Imprimindo p�gina %p';
  dmDanfe.RvSystem1.SystemPrinter.Title:='NFe - Impress�o do DANFE';
  dmDanfe.RvSystem1.SystemPrinter.Units:=unMM;
  dmDanfe.RvSystem1.SystemPrinter.UnitsFactor:=25.4;

  if Length(Impressora) > 0 then
     dmDanfe.RvSystem1.BaseReport.SelectPrinter(Impressora);
  if NFE = nil then
   begin
     for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count-1 do
      begin
        dmDanfe.NFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe;
        //exibir c�digo barras de contigencia
        dmDanfe.RvProject.Open;
        With dmDanfe.RvProject.ProjMan do
        begin
           MyPage := FindRaveComponent('GlobalDANFE',nil) as TRavePage;
           MyBarcode := FindRaveComponent('BarCode_Contigencia',MyPage) as TRaveCode128BarCode;
           if (dmDanfe.NFe.Ide.tpEmis = teNormal) and (MyBarcode <> nil) then
              MyBarCode.Left := 30;
        end;
        dmDanfe.RvProject.ExecuteReport('DANFE1');
        dmDanfe.RvProject.Close;
      end;
   end
  else
   begin
     dmDanfe.NFe := NFE;
     //exibir c�digo barras de contigencia
     dmDanfe.RvProject.Open;
     With dmDanfe.RvProject.ProjMan do
     begin
        MyPage := FindRaveComponent('GlobalDANFE',nil) as TRavePage;
        MyBarcode := FindRaveComponent('BarCode_Contigencia',MyPage) as TRaveCode128BarCode;
        if dmDanfe.NFe.Ide.tpEmis = teNormal then
           MyBarCode.Left := 30;
     end;
     dmDanfe.RvProject.ExecuteReport('DANFE1');
     dmDanfe.RvProject.Close;
   end;

end;

procedure TACBrNFeDANFERave.ImprimirDANFEPDF(NFE : TNFe = nil);
var
 i : Integer;
 MyPage: TRavePage;
 MyBarcode: TRaveCode128BarCode;
begin
  dmDanfe.RvSystem1.DefaultDest := rdFile;
  dmDanfe.RvSystem1.DoNativeOutput:=false;
  dmDanfe.RvSystem1.RenderObject:= dmDanfe.RvRenderPDF1;
  dmDanfe.RvSystem1.SystemSetups:=dmDanfe.RvSystem1.SystemSetups - [ssAllowSetup];
  dmDanfe.RvProject.Engine := dmDanfe.RvSystem1;
  dmDanfe.RvRenderPDF1.EmbedFonts:=False;
  dmDanfe.RvRenderPDF1.ImageQuality:=90;
  dmDanfe.RvRenderPDF1.MetafileDPI:=300;
  dmDanfe.RvRenderPDF1.UseCompression:=False;
  dmDanfe.RvRenderPDF1.Active:=True;

  if NFE = nil then
   begin
     for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count-1 do
      begin
        dmDanfe.NFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe;
        dmDanfe.RvSystem1.OutputFileName := PathWithDelim(FPathArquivos)+dmDanfe.NFe.infNFe.ID+'.pdf';
        //exibir c�digo barras de contigencia
        dmDanfe.RvProject.Open;
        With dmDanfe.RvProject.ProjMan do
        begin
           MyPage := FindRaveComponent('GlobalDANFE',nil) as TRavePage;
           MyBarcode := FindRaveComponent('BarCode_Contigencia',MyPage) as TRaveCode128BarCode;
           if dmDanfe.NFe.Ide.tpEmis = teNormal then
              MyBarCode.Left := 30;
        end;
        dmDanfe.RvProject.ExecuteReport('DANFE1');
        dmDanfe.RvProject.Close;
      end;
   end
  else
   begin
     dmDanfe.NFe := NFE;
     dmDanfe.RvSystem1.OutputFileName := PathWithDelim(FPathArquivos)+dmDanfe.NFe.infNFe.ID+'.pdf';
     //exibir c�digo barras de contigencia
     dmDanfe.RvProject.Open;
     With dmDanfe.RvProject.ProjMan do
     begin
        MyPage := FindRaveComponent('GlobalDANFE',nil) as TRavePage;
        MyBarcode := FindRaveComponent('BarCode_Contigencia',MyPage) as TRaveCode128BarCode;
        if dmDanfe.NFe.Ide.tpEmis = teNormal then
           MyBarCode.Left := 30;
     end;
     dmDanfe.RvProject.ExecuteReport('DANFE1');
     dmDanfe.RvProject.Close;
   end;

  dmDanfe.RvRenderPDF1.Active:=False;   
end;


end.
