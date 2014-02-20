{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2012   Isaque Pinheiro                      }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 15/04/2012: Isaque Pinheiro
|*  - Criação e distribuição da Primeira Versao
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
