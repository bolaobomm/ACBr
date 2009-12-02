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

unit ACBrECDBloco_I_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrBloco_I;

type
  /// TBLOCO_I -
  TBLOCO_I = class(TACBrSPED)
  private
    FRegistroI001: TRegistroI001;      /// BLOCO I - RegistroI001
    FRegistroI010: TRegistroI010;      /// BLOCO I - RegistroI010
    FRegistroI990: TRegistroI990;      /// BLOCO I - RegistroI990
  public
    constructor Create(AOwner: TComponent); override; /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function WriteRegistroI001: AnsiString;
    function WriteRegistroI010: AnsiString;
    function WriteRegistroI990: AnsiString;

    property RegistroI001: TRegistroI001 read FRegistroI001 write FRegistroI001;
    property RegistroI010: TRegistroI010 read FRegistroI010 write FRegistroI010;
    property RegistroI990: TRegistroI990 read FRegistroI990 write FRegistroI990;
  end;

implementation

{ TBLOCO_I }

constructor TBLOCO_I.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRegistroI001 := TRegistroI001.Create;
  FRegistroI010 := TRegistroI010.Create;
  FRegistroI990 := TRegistroI990.Create;

  FRegistroI990.QTD_LIN_I := 0;
end;

destructor TBLOCO_I.Destroy;
begin
  FRegistroI001.Free;
  FRegistroI010.Free;
  FRegistroI990.Free;
  inherited;
end;

procedure TBLOCO_I.LimpaRegistros;
begin

  FRegistroI990.QTD_LIN_I := 0;
end;

function TBLOCO_I.WriteRegistroI001: AnsiString;
begin
  Result := '';

  if Assigned(RegistroI001) then
  begin
     with RegistroI001 do
     begin
       ///
       Result := LFill('I001') +
                 Delimitador +
                 #13#10;
       ///
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
end;

function TBLOCO_I.WriteRegistroI010: AnsiString;
begin
  Result := '';

  if Assigned(RegistroI010) then
  begin
     with RegistroI010 do
     begin
       ///
       Result := LFill('I010') +
                 Delimitador +
                 #13#10;
       ///
       RegistroI990.QTD_LIN_I := RegistroI990.QTD_LIN_I + 1;
     end;
  end;
end;

function TBLOCO_I.WriteRegistroI990: AnsiString;
begin
  Result := '';

  if Assigned(RegistroI990) then
  begin
     with RegistroI990 do
     begin
       QTD_LIN_I := QTD_LIN_I + 1;
       ///
       Result := LFill('I990') +
                 LFill(QTD_LIN_I,0) +
                 Delimitador +
                 #13#10;
     end;
  end;
end;

end.
