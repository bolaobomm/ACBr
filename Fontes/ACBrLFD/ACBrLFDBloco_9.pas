{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009  Juliana Tamizou                       }
{                                                                              }
{ Colaboradores nesse arquivo: Isaque Pinheiro                                 }
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
|* 26/01/2013: Nilson Sergio
|*  - Cria��o e distribui��o da Primeira Versao
*******************************************************************************}

unit ACBrLFDBloco_9;

interface

uses
  SysUtils, Classes, DateUtils, ACBrLFDBlocos;

type

  /// Registro 9001 - Abertura do Bloco 9

  { TRegistro9001 }

  TRegistro9001 = class(TOpenBlocos)
  private
  public
  end;

  /// Registro 9900 - Registros do Arquivo Digital

  { TRegistro9900 }

  TRegistro9900 = class
  private
    FREG_BLC: String; /// Registro que ser� totalizado no pr�ximo campo
    FQTD_REG_BLC: Integer; /// Total de registros do tipo informado no campo anterior
  public
    property REG_BLC: String read FREG_BLC write FREG_BLC;
    property QTD_REG_BLC: Integer read FQTD_REG_BLC write FQTD_REG_BLC;
  end;

  /// Registro 9900 - Lista

  { TRegistro9900List }

  TRegistro9900List = class(TACBrLFDRegistros)
  private
    function GetItem(Index: Integer): TRegistro9900;
    procedure SetItem(Index: Integer; const Value: TRegistro9900);
  public
    function New: TRegistro9900; overload;
    //function New(AREG_BLC: String; AQTD_REG_BLC: Integer): TRegistro9900; overload;
    property Items[Index: Integer]: TRegistro9900 read GetItem write SetItem;
  end;

  /// Registro 9990 - Encerramento do Bloco 9

  { TRegistro9990 }

  TRegistro9990 = class
  private
    fQTD_LIN_9: Integer;
  public
    property QTD_LIN_9: Integer read fQTD_LIN_9 write fQTD_LIN_9;
  end;

  /// Registro 9999 - Encerramento, Controle e Assinaturas do Arquivo Digital

  { TRegistro9999 }

  TRegistro9999 = class
  private
    fQTD_LIN: Integer;
  public
    property QTD_LIN: Integer read fQTD_LIN write fQTD_LIN;
  end;

implementation

{ TRegistro9900List }

function TRegistro9900List.GetItem(Index: Integer): TRegistro9900;
begin
  Result := TRegistro9900(Get(Index));
end;

function TRegistro9900List.New: TRegistro9900;
begin
  Result := TRegistro9900.Create;
  Add(Result);
end;

{function TRegistro9900List.New(AREG_BLC: String; AQTD_REG_BLC: Integer): TRegistro9900;
begin
  {if AQTD_REG_BLC > 0 then
    with New do
    begin
      REG_BLC := REG_BLC;
      QTD_REG_BLC := AQTD_REG_BLC;
    end;}
end;  }

procedure TRegistro9900List.SetItem(Index: Integer; const Value: TRegistro9900);
begin
  Put(Index, Value);
end;

end.
