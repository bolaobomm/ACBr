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
******************************************************************************}
{$I ACBr.inc}
unit ACBrNFeDANFeRLClass;

interface

uses Forms, SysUtils, Classes,
  ACBrNFeDANFEClass, ACBrNFeDANFeRLRetrato, pcnNFe, pcnConversao;

type
  TACBrNFeDANFeRL = class( TACBrNFeDANFEClass )
   private
     FMarcadagua: string;
   public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE : TNFe = nil); override ;
    procedure ImprimirDANFEPDF(NFE : TNFe = nil); override ;
  published
    property MarcadAgua : String read FMarcadagua write FMarcadagua ;
  end;

implementation

uses ACBrNFe, ACBrNFeUtil, ACBrUtil, StrUtils, Dialogs;

constructor TACBrNFeDANFeRL.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
end;

destructor TACBrNFeDANFeRL.Destroy;
begin
  inherited Destroy ;
end;


procedure TACBrNFeDANFeRL.ImprimirDANFE(NFE : TNFe = nil);
var
  i : Integer;
  frlDANFeRLRetrato : TfrlDANFeRLRetrato;
  sLogo: String;
  sMarcaDagua: String;
begin
  frlDANFeRLRetrato := TfrlDANFeRLRetrato.Create(Self);
  sLogo := TACBrNFe(ACBrNFe).DANFE.Logo;
  sMarcaDagua := MarcaDagua;

  if NFE = nil then
   begin
     for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count-1 do
      begin
        frlDANFeRLRetrato.Imprimir(TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe, sLogo, sMarcaDagua);
      end;
   end
  else
     frlDANFeRLRetrato.Imprimir(NFe, sLogo, sMarcaDagua);
  frlDANFeRLRetrato.Free;
end;

procedure TACBrNFeDANFeRL.ImprimirDANFEPDF(NFE : TNFe = nil);
var
  i : Integer;
  frlDANFeRLRetrato : TfrlDANFeRLRetrato;
  sLogo, sMarcaDagua, sFile: String;
begin
  frlDANFeRLRetrato := TfrlDANFeRLRetrato.Create(Self);
  sLogo := TACBrNFe(ACBrNFe).DANFE.Logo;
  sMarcaDagua := MarcaDagua;

  if NFE = nil then
   begin
     for i:= 0 to TACBrNFe(ACBrNFe).NotasFiscais.Count-1 do
      begin
        sFile := TACBrNFe(ACBrNFe).DANFE.PathPDF + Copy(TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe.infNFe.ID, 4, 44) + '-nfe.pdf';
        frlDANFeRLRetrato.SavePDF(TACBrNFe(ACBrNFe).NotasFiscais.Items[i].NFe, sLogo, sMarcaDagua, sFile);
      end;
   end;

  frlDANFeRLRetrato.Free;
end;

end.
