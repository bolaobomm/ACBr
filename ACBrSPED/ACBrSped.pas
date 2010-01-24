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

uses SysUtils, Classes, DateUtils, ACBrUtilTXT;

type
//  TErrorEvent = procedure(const MsnError: AnsiString) of object;

  TACBrSPED = class(TACBrTXT)
  private
//    FOnError: TErrorEvent;
//    FDelimitador: AnsiString;     /// Caracter delimitador de campos
//    FTrimString: boolean;         /// Retorna a string sem espa�os em branco iniciais e finais
//    FCurMascara: AnsiString;      /// Mascara para valores tipo currency
    FDT_INI: TDateTime;           /// Data inicial das informa��es contidas no arquivo
    FDT_FIN: TDateTime;           /// Data final das informa��es contidas no arquivo

//    function GetOnError: TErrorEvent; /// M�todo do evento OnError
//    procedure SetOnError(const Value: TErrorEvent); /// M�todo SetError
//    procedure AssignError(MsnError: AnsiString);
  protected
    function GetDT_FIN: TDateTime; virtual;
    function GetDT_INI: TDateTime; virtual;
//    function GetDelimitador: AnsiString; virtual;
//    function GetTrimString: boolean; virtual;
//    function GetCurMascara: AnsiString; virtual;
    procedure SetDT_FIN(const Value: TDateTime); virtual;
    procedure SetDT_INI(const Value: TDateTime); virtual;
//    procedure SetDelimitador(const Value: AnsiString); virtual;
//    procedure SetTrimString(const Value: boolean); virtual;
//    procedure SetCurMascara(const Value: AnsiString); virtual;
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy

//    function RFill(Value: AnsiString; Size: Integer = 0; Caracter: Char = ' '): AnsiString; overload;
//    function LFill(Value: AnsiString; Size: Integer = 0; Caracter: Char = '0'): AnsiString; overload;
//    function LFill(Value: Currency; Size: Integer; Decimal: Integer = 2; Nulo: Boolean = false; Caracter: Char = '0'): AnsiString; overload;
//    function LFill(Value: Integer; Size: Integer; Nulo: Boolean = false; Caracter: Char = '0'): AnsiString; overload;
//    function LFill(Value: TDateTime; Mask: AnsiString = 'ddmmyyyy'; Nulo: Boolean = false): AnsiString; overload;
    ///
//    procedure Check(Condicao: Boolean; const Msg: AnsiString); overload;
//    procedure Check(Condicao: Boolean; Msg: AnsiString; Fmt: array of const); overload;
    ///
    property DT_INI: TDateTime read GetDT_INI write SetDT_INI;
    property DT_FIN: TDateTime read GetDT_FIN write SetDT_FIN;
//    property Delimitador: AnsiString read GetDelimitador write SetDelimitador;
//    property TrimString: boolean read GetTrimString write SetTrimString;
//    property CurMascara: AnsiString read GetCurMascara write SetCurMascara;

//    property OnError: TErrorEvent read GetOnError write SetOnError;
  end;

implementation

uses ACBrSpedUtils;

(* TACBrSPED *)
{
procedure TACBrSPED.Check(Condicao: Boolean; const Msg: AnsiString);
begin
  if not Condicao then AssignError(Msg);
end;

procedure TACBrSPED.Check(Condicao: Boolean; Msg: AnsiString; Fmt: array of const);
begin
  Check(Condicao, Format(Msg, Fmt));
end;
}
constructor TACBrSPED.Create(AOwner: TComponent);
begin
  inherited;
//  FDelimitador := '|';
//  FTrimString  := true;
//  FCurMascara  := '#0.00';
end;

destructor TACBrSPED.Destroy;
begin

  inherited;
end;
{
function TACBrSPED.RFill(Value: AnsiString; Size: Integer = 0; Caracter: Char = ' '): AnsiString;
begin
  if (Size > 0) and (Length(Value) > Size) then
     Result := Copy(Value, 1, Size)
  else
     Result := Value + StringOfChar(Caracter, Size - Length(Value));

  /// Se a propriedade TrimString = true, Result retorna sem espa�os em branco
  /// iniciais e finais.
  if FTrimString then
     Result := FDelimitador + Trim(Result)
  else
     Result := FDelimitador + Result;
end;

function TACBrSPED.LFill(Value: AnsiString; Size: Integer = 0; Caracter: Char = '0'): AnsiString;
begin
  if (Size > 0) and (Length(Value) > Size) then
     Result := Copy(Value, 1, Size)
  else
     Result := StringOfChar(Caracter, Size - length(Value)) + Value;

  /// Se a propriedade TrimString = true, Result retorna sem espa�os em branco
  /// iniciais e finais.
  if FTrimString then
     Result := FDelimitador + Trim(Result)
  else
     Result := FDelimitador + Result;
end;

function TACBrSPED.LFill(Value: Currency; Size: Integer; Decimal: Integer = 2; Nulo: Boolean = false; Caracter: Char = '0'): AnsiString;
var
intFor, intP: Integer;
begin
  /// Se o parametro Nulo = true e Value = 0, ser� retornado '|'
  if (Nulo) and (Value = 0) then
  begin
     Result := FDelimitador;
     Exit;
  end;
  intP := 1;
  for intFor := 1 to Decimal do
  begin
     intP := intP * 10;
  end;
  /// Se a propriedade CurMascara <> '' Value ser� formatado com a mascara
  /// existente nessa propriedade.
  if FCurMascara <> '' then
     Result := FDelimitador + FormatCurr(FCurMascara, Value)
  else
     Result := LFill(Trunc(Value * intP), Size, Nulo, Caracter);
end;

function TACBrSPED.LFill(Value: Integer; Size: Integer; Nulo: Boolean = false; Caracter: Char = '0'): AnsiString;
begin
  /// Se o parametro Nulo = true e Value = 0, ser� retornado '|'
  if (Nulo) and (Value = 0) then
  begin
     Result := FDelimitador;
     Exit;
  end;
  Result := LFill(IntToStr(Value), Size, Caracter);
end;

function TACBrSPED.LFill(Value: TDateTime; Mask: AnsiString = 'ddmmyyyy'; Nulo: Boolean = false): AnsiString;
begin
  /// Se o parametro Nulo = true e YearOf(Value) = 1899, ser� retornado '|'
  if (Nulo) and (YearOf(Value) = 1899) then
  begin
     Result := FDelimitador;
     Exit;
  end;
  Result := FDelimitador + FormatDateTime(Mask, Value);
end;

function TACBrSPED.GetCurMascara: AnsiString;
begin
   Result := FCurMascara;
end;

function TACBrSPED.GetDelimitador: AnsiString;
begin
   Result := FDelimitador;
end;
}
function TACBrSPED.GetDT_FIN: TDateTime;
begin
   Result := FDT_FIN;
end;

function TACBrSPED.GetDT_INI: TDateTime;
begin
   Result := FDT_INI;
end;
{
function TACBrSPED.GetOnError: TErrorEvent;
begin
  Result := FOnError;
end;

function TACBrSPED.GetTrimString: boolean;
begin
  Result := FTrimString;
end;

procedure TACBrSPED.SetCurMascara(const Value: AnsiString);
begin
   FCurMascara := Value;
end;

procedure TACBrSPED.SetDelimitador(const Value: AnsiString);
begin
   FDelimitador := Value;
end;
}
procedure TACBrSPED.SetDT_FIN(const Value: TDateTime);
begin
  FDT_FIN := Value;
end;

procedure TACBrSPED.SetDT_INI(const Value: TDateTime);
begin
  FDT_INI := Value;
end;
{
procedure TACBrSPED.SetOnError(const Value: TErrorEvent);
begin
  FOnError := Value;
end;

procedure TACBrSPED.SetTrimString(const Value: boolean);
begin
  FTrimString := Value;
end;

procedure TACBrSPED.AssignError(MsnError: AnsiString);
begin
  if Assigned(FOnError) then FOnError(MsnError);
end;
}
end.
