{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2012   Isaque Pinheiro                      }
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
|* 15/04/2012: Isaque Pinheiro
|*  - Cria��o e distribui��o da Primeira Versao
*******************************************************************************}

unit ACBrEPCBloco_C_Events;

interface

uses
  SysUtils, Math, Classes, ACBrSped, ACBrEPCBloco_C_Class;

type
  { TEventsBloco_0 }
  TEventsBloco_C = class(TComponent)
  private
    FOwner: TComponent;

    FOnBeforeWriteRegistroC481: TWriteRegistroC481Event;
    FOnBeforeWriteRegistroC485: TWriteRegistroC485Event;

    function GetOnBeforeWriteRegistroC481: TWriteRegistroC481Event;
    function GetOnBeforeWriteRegistroC485: TWriteRegistroC485Event;
    procedure SetOnBeforeWriteRegistroC481(const Value: TWriteRegistroC481Event);
    procedure SetOnBeforeWriteRegistroC485(const Value: TWriteRegistroC485Event);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property OnBeforeWriteRegistroC481: TWriteRegistroC481Event read GetOnBeforeWriteRegistroC481 write SetOnBeforeWriteRegistroC481;
    property OnBeforeWriteRegistroC485: TWriteRegistroC485Event read GetOnBeforeWriteRegistroC485 write SetOnBeforeWriteRegistroC485;
  end;

implementation

uses ACBrSpedPisCofins;

{ TEventsBloco_0 }

constructor TEventsBloco_C.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   FOwner := AOwner;
end;

destructor TEventsBloco_C.Destroy;
begin
   FOwner := nil;
   inherited Destroy;
end;

function TEventsBloco_C.GetOnBeforeWriteRegistroC481: TWriteRegistroC481Event;
begin
   Result := FOnBeforeWriteRegistroC481;
end;

function TEventsBloco_C.GetOnBeforeWriteRegistroC485: TWriteRegistroC485Event;
begin
   Result := FOnBeforeWriteRegistroC485;
end;

procedure TEventsBloco_C.SetOnBeforeWriteRegistroC481(
  const Value: TWriteRegistroC481Event);
begin
  FOnBeforeWriteRegistroC481 := Value;

  TACBrSPEDPisCofins(FOwner).Bloco_C.OnBeforeWriteRegistroC481 := Value;
end;

procedure TEventsBloco_C.SetOnBeforeWriteRegistroC485(
  const Value: TWriteRegistroC485Event);
begin
  FOnBeforeWriteRegistroC485 := Value;

  TACBrSPEDPisCofins(FOwner).Bloco_C.OnBeforeWriteRegistroC485 := Value;
end;

end.
