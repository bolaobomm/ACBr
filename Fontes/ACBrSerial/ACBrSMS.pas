{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Alexandre Rocha Lima e Marcondes                }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{ Esse arquivo usa a classe  SynaSer   Copyright (c)2001-2003, Lukas Gebauer   }
{  Project : Ararat Synapse     (Found at URL: http://www.ararat.cz/synapse/)  }
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

{$I ACBr.inc}

unit ACBrSMS;

interface

uses
  ACBrBase, ACBrConsts, ACBrDevice, ACBrSMSClass,
  SysUtils , Classes
 {$IFNDEF CONSOLE}
    {$IFDEF VisualCLX}, QControls, QForms, QDialogs, QGraphics, QStdCtrls{$ENDIF}
    {$IFDEF VCL}, Controls, Forms, Dialogs, Graphics, StdCtrls {$ENDIF}
 {$ENDIF} ;

type
  TACBrSMS = class(TACBrComponent)
  private
    fsAtivo: Boolean;
    fsDevice: TACBrDevice;
    fsSMS: TACBrSMSClass;
    fsModelo: TACBrSMSModelo;

    procedure SetAtivo(const Value: Boolean);
    procedure SetModelo(const Value: TACBrSMSModelo);
    procedure SetRecebeConfirmacao(const Value: Boolean);
    procedure SetSinCard(const Value: TACBrSMSSinCard);
    function GetRecebeConfirmacao: Boolean;
    function GetSinCard: TACBrSMSSinCard;
    function GetUltimaReposta: AnsiString;
    procedure TestaAtivo;
    procedure TestaEmLinha;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Ativar;
    procedure Desativar;

    function EmLinha: Boolean;
    function IMEI: AnsiString;
    function NivelSinal: Double;
    function Operadora: AnsiString;
    function Fabricante: AnsiString;
    function ModeloModem: AnsiString;
    function Firmware: AnsiString;

    procedure TrocarBandeja(const ASinCard: TACBrSMSSinCard);
    procedure EnviarSMS(const ATelefone, AMensagem: AnsiString;
      var AIndice: Integer);
    procedure ListarMensagens(const AFiltro: TACBrSMSFiltro;
      const APath: AnsiString);
  published
    property Ativo: Boolean read fsAtivo write SetAtivo;
    property Device: TACBrDevice read fsDevice;
    property SMS: TACBrSMSClass read fsSMS;
    property Modelo: TACBrSMSModelo read fsModelo write SetModelo;
    property SinCard: TACBrSMSSinCard read GetSinCard write SetSinCard;
    property RecebeConfirmacao: Boolean read GetRecebeConfirmacao write SetRecebeConfirmacao;
    property UltimaResposta: AnsiString read GetUltimaReposta;
  end;

implementation

uses
  ACBrUtil, ACBrSMSDaruma, ACBrSMSZTE, ACBrSMSGenerico;

{ TACBrSMS }

constructor TACBrSMS.Create(AOwner: TComponent);
begin
  inherited create(AOwner);

  fsDevice := TACBrDevice.Create(Self);
  fsDevice.Name := 'ACBrDevice' ;
  {$IFDEF COMPILER6_UP}
  fsDevice.SetSubComponent( true );
  {$ENDIF}
  fsDevice.Porta := 'COM1';
  fsDevice.HandShake := hsNenhum;

  fsModelo := modNenhum;
  fsSMS  := TACBrSMSClass.Create(Self);
end;

destructor TACBrSMS.Destroy;
begin
  if Assigned(fsDevice) then
    FreeAndNil(fsSMS);

  if Assigned(fsDevice) then
    FreeAndNil(fsDevice);

  inherited Destroy;
end;

procedure TACBrSMS.TestaAtivo;
begin
  if not Ativo then
    raise EACBrSMSException.Create('Comunica��o ainda n�o foi ativada.');
end;

procedure TACBrSMS.TestaEmLinha;
begin
  if not EmLinha then
    raise EACBrSMSException.Create('SMS n�o est� em linha.');
end;

procedure TACBrSMS.TrocarBandeja(const ASinCard: TACBrSMSSinCard);
begin
  TestaAtivo;
  fsSMS.TrocarBandeja(ASinCard);
  SetSinCard(ASinCard);
end;

function TACBrSMS.EmLinha: Boolean;
begin
  TestaAtivo;
  Result := fsSMS.EmLinha;
end;

procedure TACBrSMS.EnviarSMS(const ATelefone, AMensagem: AnsiString;
  var AIndice: Integer);
begin
  if Length(AMensagem) > 160 then
    raise EACBrSMSException.Create('A quantidade m�xima permitida de caracteres por mensagem de texto � de 160 caractes.');

  TestaAtivo;
  fsSMS.EnviarSMS(ATelefone, AMensagem, AIndice);
end;

function TACBrSMS.Fabricante: AnsiString;
begin
  TestaAtivo;
  Result := fsSMS.Fabricante;
end;

function TACBrSMS.GetRecebeConfirmacao: Boolean;
begin
  Result := fsSMS.RecebeConfirmacao;
end;

function TACBrSMS.GetSinCard: TACBrSMSSinCard;
begin
  Result := fsSMS.SinCard;
end;

function TACBrSMS.GetUltimaReposta: AnsiString;
begin
  Result := fsSMS.UltimaResposta;
end;

function TACBrSMS.IMEI: AnsiString;
begin
  TestaAtivo;
  Result := fsSMS.IMEI;
end;

procedure TACBrSMS.ListarMensagens(const AFiltro: TACBrSMSFiltro;
  const APath: AnsiString);
begin
  TestaAtivo;
  fsSMS.ListarMensagens(AFiltro, APath);
end;

function TACBrSMS.ModeloModem: AnsiString;
begin
  TestaAtivo;
  Result := fsSMS.ModeloModem;
end;

function TACBrSMS.NivelSinal: Double;
begin
  TestaAtivo;
  Result := fsSMS.NivelSinal;
end;

function TACBrSMS.Operadora: AnsiString;
begin
  TestaAtivo;
  Result := fsSMS.Operadora;
end;

function TACBrSMS.Firmware: AnsiString;
begin
  TestaAtivo;
  Result := fsSMS.Firmware;
end;

procedure TACBrSMS.SetModelo(const Value: TACBrSMSModelo);
begin
  if fsModelo = Value then
    Exit;

  if fsAtivo then
    raise EACBrSMSException.Create(ACBrStr('N�o � poss�vel mudar o Modelo com ACBrSMS Ativo'));

  FreeAndNil(fsSMS);
  case Value of
    modDaruma: fsSMS := TACBrSMSDaruma.Create(Self);
    modZTE: fsSMS := TACBrSMSZTE.Create(Self);
    modGenerico: fsSMS := TACBrSMSGenerico.Create(Self);
  else
    fsSMS := TACBrSMSClass.create(Self);
  end;

  fsModelo := Value;
end;

procedure TACBrSMS.SetRecebeConfirmacao(const Value: Boolean);
begin
  fsSMS.RecebeConfirmacao := Value;
end;

procedure TACBrSMS.SetSinCard(const Value: TACBrSMSSinCard);
begin
  fsSMS.SinCard := Value;
end;

procedure TACBrSMS.SetAtivo(const Value: Boolean);
begin
  if Value then
    Ativar
  else
    Desativar;
end;

procedure TACBrSMS.Ativar;
begin
  if fsAtivo then
    Exit;

  if fsModelo = modNenhum then
    raise EACBrSMSException.Create(ACBrStr('Modelo n�o definido'));

  fsSMS.Ativar;
  fsAtivo := True;
end;

procedure TACBrSMS.Desativar;
begin
  if not fsAtivo then
    Exit;

  fsSMS.Desativar;
  fsAtivo := False;
end;

end.
