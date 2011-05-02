{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Andr� Ferreira de Moraes               }
{                                       Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
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
|* 02/05/2011 Isaque Pinheiro
|*  - Primeira Versao ACBrInStore
******************************************************************************}

{$I ACBr.inc}

unit ACBrInStore;

interface

uses
  SysUtils, Classes, ACBrBase;

type
  TACBrInStore = class(TACBrComponent)
  private
    { Private declarations }
    fPrefixo: String;
    fPeso: Double;
    fTotal: Double;
    fCodigo: String;
    fDV: String;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Desmembrar(sCodificacao, sCodigoEtiqueta: string);

    property Prefixo: String read fPrefixo;
    property Codigo: String read fCodigo;
    property Peso: Double read fPeso;
    property Total: Double read fTotal;
    property DV: String read fDV;
  published
    { Published declarations }
  end;

implementation

{ TACBrInStore }

constructor TACBrInStore.Create(AOwner: TComponent);
begin
   inherited Create( AOwner );
end;

destructor TACBrInStore.Destroy;
begin

  inherited;
end;

procedure TACBrInStore.Desmembrar(sCodificacao, sCodigoEtiqueta: string);
var
// Vari�veis de posi��o
pCodigo: Integer;
pTotal: Integer;
pPeso: Integer;
// Vari�veis de tamanho
tCodigo: Integer;
tTotal: Integer;
tPeso: Integer;
// Digito verificador
iFor: Integer;
begin
   if Length(sCodificacao) < 13 then
      raise Exception.Create('Estrutura inv�lida!');

   if Length(sCodigoEtiqueta) < 13 then
      raise Exception.Create('C�digo inv�lido!');

   // Limpa fields
   fPrefixo := '';
   fCodigo  := '';
   fPeso    := 0;
   fTotal   := 0;
   fDV      := '';

   // Vari�veis de posi��o
   pCodigo := Pos('C', sCodificacao);
   pPeso   := Pos('P', sCodificacao);
   pTotal  := Pos('T', sCodificacao);
   // Vari�veis de tamanho
   tCodigo := 0;
   tTotal  := 0;
   tPeso   := 0;

   for iFor := 1 to Length(sCodificacao) do
   begin
      if sCodificacao[iFor] = 'C' then
         Inc(tCodigo)
      else
      if sCodificacao[iFor] = 'P' then
         Inc(tPeso)
      else
      if sCodificacao[iFor] = 'T' then
         Inc(tTotal);
   end;
   // Desmembrar os campos
   // Profixo
   fPrefixo := Copy(sCodigoEtiqueta, 1, pCodigo -1);

   // C�digo
   if pCodigo > 0 then
      fCodigo := Copy(sCodigoEtiqueta, pCodigo, tCodigo);

   // Peso
   if pPeso > 0 then
   begin
      fPeso := StrToCurrDef( Copy(sCodigoEtiqueta, pPeso, tPeso), 0);
      fPeso := fPeso / 100;
   end;

   // C�digo
   if pTotal > 0 then
   begin
      fTotal := StrToCurrDef( Copy(sCodigoEtiqueta, pTotal, tTotal), 0);
      fTotal := fTotal / 100;
   end;

   fDV := Copy(sCodigoEtiqueta, Length(sCodigoEtiqueta), 1);
end;

end.
