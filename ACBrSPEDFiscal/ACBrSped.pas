{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009   Isaque Pinheiro                      }
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
|* 10/04/2009: Isaque Pinheiro
|*  - Cria��o e distribui��o da Primeira Versao
*******************************************************************************}

unit ACBrSped;

interface

uses SysUtils, Classes, DateUtils;

type
  TErrorEvent = procedure(const MsnError: string) of object;

  TACBrSPED = class(TComponent)
  private
    FOnError: TErrorEvent;
    FDelimitador: string;  /// Caracter delimitador de campos
    FCurMascara: string;      /// Mascara para valores tipo currency
    FDT_INI: TDateTime;    /// Data inicial das informa��es contidas no arquivo
    FDT_FIN: TDateTime;    /// Data final das informa��es contidas no arquivo

    function GetOnError: TErrorEvent;  /// M�todo GetError
    procedure SetOnError(const Value: TErrorEvent); /// M�todo SetError
    procedure AssignError(MsnError: String); /// M�todo do evento OnError
  protected
    function GetDT_FIN: TDateTime; virtual;
    function GetDT_INI: TDateTime; virtual;
    function GetDelimitador: string; virtual;
    function GetCurMascara: string; virtual;
    procedure SetDT_FIN(const Value: TDateTime); virtual;
    procedure SetDT_INI(const Value: TDateTime); virtual;
    procedure SetDelimitador(const Value: string); virtual;
    procedure SetCurMascara(const Value: string); virtual;
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy

    function RFill(Value: string; Size: Integer = 0; Caracter: Char = ' '): string; overload;
    function LFill(Value: string; Size: Integer = 0; Caracter: Char = '0'): string; overload;
    function LFill(Value: Currency; Size: Integer; Decimal: Integer = 2; Caracter: Char = '0'): string; overload;
    function LFill(Value: Integer; Size: Integer; Caracter: Char = '0'): string; overload;
    function LFill(Value: TDateTime; Mask: string = 'ddmmyyyy'): string; overload;
    ///
    procedure Check(Condicao: Boolean; const Msg: string); overload;
    procedure Check(Condicao: Boolean; Msg: string; Fmt: array of const); overload;
    ///
    property DT_INI: TDateTime read GetDT_INI write SetDT_INI;
    property DT_FIN: TDateTime read GetDT_FIN write SetDT_FIN;
    property Delimitador: string read GetDelimitador write SetDelimitador;
    property CurMascara: string read GetCurMascara write SetCurMascara;
    property OnError: TErrorEvent read GetOnError write SetOnError;
  end;

implementation

(* TACBrSPED *)

procedure TACBrSPED.Check(Condicao: Boolean; const Msg: string);
begin
  if not Condicao then AssignError(Msg);
end;

procedure TACBrSPED.Check(Condicao: Boolean; Msg: string; Fmt: array of const);
begin
  Check(Condicao, Format(Msg, Fmt));
end;

constructor TACBrSPED.Create(AOwner: TComponent);
begin
  inherited;
  FDelimitador := '|';
  FCurMascara  := '#0.00';
end;

destructor TACBrSPED.Destroy;
begin

  inherited;
end;

function TACBrSPED.RFill(Value: string; Size: Integer = 0; Caracter: Char = ' '): string;
begin
  if (Size > 0) and (Length(Value) > Size) then
     Result := Copy(Value, 1, Size)
  else
     Result := Value + StringOfChar(Caracter, Size - Length(Value));
  //
  Result := FDelimitador + Result;
end;

function TACBrSPED.LFill(Value: string; Size: Integer = 0; Caracter: Char = '0'): string;
begin
  if (Size > 0) and (Length(Value) > Size) then
     Result := Copy(Value, 1, Size)
  else
     Result := StringOfChar(Caracter, Size - length(Value)) + Value;
  //
  Result := FDelimitador + Result;
end;

function TACBrSPED.LFill(Value: Currency; Size: Integer; Decimal: Integer = 2; Caracter: Char = '0'): string;
var
intFor, intP: Integer;
begin
  intP := 1;
  for intFor := 1 to Decimal do
  begin
     intP := intP * 10;
  end;
  if FCurMascara <> '' then
     Result := FDelimitador + FormatCurr(FCurMascara, Value)
  else
     Result := LFill(Trunc(Value * intP), Size, Caracter);
end;

function TACBrSPED.LFill(Value: Integer; Size: Integer; Caracter: Char = '0'): string;
begin
  Result := LFill(IntToStr(Value), Size, Caracter);
end;

function TACBrSPED.LFill(Value: TDateTime; Mask: string = 'ddmmyyyy'): string;
begin
  Result := FormatDateTime(Mask, Value);
  Result := FDelimitador + Result;
end;

function TACBrSPED.GetCurMascara: string;
begin
   Result := FCurMascara;
end;

function TACBrSPED.GetDelimitador: string;
begin
   Result := FDelimitador;
end;

function TACBrSPED.GetDT_FIN: TDateTime;
begin
   Result := FDT_FIN;
end;

function TACBrSPED.GetDT_INI: TDateTime;
begin
   Result := FDT_INI;
end;

function TACBrSPED.GetOnError: TErrorEvent;
begin
  Result := FOnError;
end;

procedure TACBrSPED.SetCurMascara(const Value: string);
begin
   FCurMascara := Value;
end;

procedure TACBrSPED.SetDelimitador(const Value: string);
begin
   FDelimitador := Value;
end;

procedure TACBrSPED.SetDT_FIN(const Value: TDateTime);
begin
  FDT_FIN := Value;
end;

procedure TACBrSPED.SetDT_INI(const Value: TDateTime);
begin
  FDT_INI := Value;
end;

procedure TACBrSPED.SetOnError(const Value: TErrorEvent);
begin
  FOnError := Value;
end;

procedure TACBrSPED.AssignError(MsnError: String);
begin
  if Assigned(FOnError) then FOnError(MsnError);
end;

end.
