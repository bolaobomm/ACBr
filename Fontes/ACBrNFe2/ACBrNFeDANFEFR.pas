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
|* 11/08/2010: Itamar Luiz Bermond
|*  - Inicio do desenvolvimento
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFeDANFEFR;

interface

uses Forms, SysUtils, Classes, Graphics, ACBrNFeDANFEClass, ACBrNFeDANFEFRDM,
  pcnNFe, pcnConversao, frxClass;

type
  TACBrNFeDANFEFR = class( TACBrNFeDANFEClass )
   private
    FdmDanfe: TdmACBrNFeFR;
    FFastFile: String;
    FEspessuraBorda: Integer;
    function GetPreparedReport: TfrxReport;
   public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE: TNFe = nil); override;
    procedure ImprimirDANFEPDF(NFE: TNFe = nil); override;
    procedure PrepareReport(NFE: TNFe = nil);
  published
    property FastFile: String read FFastFile write FFastFile ;
    property dmDanfe: TdmACBrNFeFR read FdmDanfe write FdmDanfe;
    property EspessuraBorda: Integer read FEspessuraBorda write FEspessuraBorda;
    property PreparedReport: TfrxReport read GetPreparedReport;
  end;

implementation

uses ACBrNFe, ACBrNFeUtil, ACBrUtil, StrUtils, Dialogs;

constructor TACBrNFeDANFEFR.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
  FdmDanfe := TdmACBrNFeFR.Create(Self);
  FFastFile := '' ;
  FEspessuraBorda := 1;
end;

destructor TACBrNFeDANFEFR.Destroy;
begin
  dmDanfe.Free;
  inherited Destroy ;
end;

function TACBrNFeDANFEFR.GetPreparedReport: TfrxReport;
begin
  Result := dmDanfe.frxReport;
end;

procedure TACBrNFeDANFEFR.ImprimirDANFE(NFE: TNFe);
begin
  PrepareReport(NFE);
  dmDanfe.frxReport.ShowPreparedReport;
end;

procedure TACBrNFeDANFEFR.ImprimirDANFEPDF(NFE: TNFe);
begin
  PrepareReport(NFE);
  dmDanfe.frxReport.Export(dmDanfe.frxPDFExport);
end;

procedure TACBrNFeDANFEFR.PrepareReport(NFE: TNFe);
var
  i: Integer;
begin
  if FFastFile <> '' then
    dmDanfe.frxReport.LoadFromFile(FFastFile);

  if NFE = nil then
  begin
    for i := 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count - 1 do
    begin
      dmDanfe.NFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe;
      dmDanfe.CarregaDados;

      if (i > 0) then
        dmDanfe.frxReport.PrepareReport(False)
      else
        dmDanfe.frxReport.PrepareReport;

    end;
  end else
  begin
    dmDanfe.NFe := NFE;
    dmDanfe.CarregaDados;

    dmDanfe.frxReport.PrepareReport;
  end;
end;

end.
