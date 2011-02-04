{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }

{ Direitos Autorais Reservados (c) 2009   Isaque Pinheiro                      }

{ Colaboradores nesse arquivo:                                                 }

{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }

{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }

{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }

{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }

{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }

{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 10/04/2009: Isaque Pinheiro
|*  - Cria��o e distribui��o da Primeira Versao
*******************************************************************************}

unit ACBrPAF_N_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrTXTClass, ACBrPAFRegistros,
  ACBrPAF_N;

type
  /// TPAF_N -

  { TPAF_N }

  TPAF_N = class(TACBrTXTClass)
  private
    FRegistroN1: TRegistroN1;       /// FRegistroN1
    FRegistroN2: TRegistroN2;       /// FRegistroN2
    FRegistroN3: TRegistroN3List;   /// FRegistroN3
    FRegistroN9: TRegistroN9;       /// FRegistroN9
  protected
  public
    constructor Create; /// Create
    destructor Destroy; override; /// Destroy

    function WriteRegistroN1: string;
    function WriteRegistroN2: string;
    function WriteRegistroN3: string;
    function WriteRegistroN9: string;

    property RegistroN1: TRegistroN1 read FRegistroN1 write FRegistroN1;
    property RegistroN2: TRegistroN2 read FRegistroN2 write FRegistroN2;
    property RegistroN3: TRegistroN3List read FRegistroN3 write FRegistroN3;
    property RegistroN9: TRegistroN9 read FRegistroN9 write FRegistroN9;
  end;

implementation

uses ACBrSPEDUtils;

{ TPAF_N }

constructor TPAF_N.Create;
begin
  FRegistroN1 := TRegistroN1.Create;
  FRegistroN2 := TRegistroN2.Create;
  FRegistroN3 := TRegistroN3List.Create;
  FRegistroN9 := TRegistroN9.Create;

  FRegistroN9.TOT_REG := 0;
end;

destructor TPAF_N.Destroy;
begin
  FRegistroN1.Free;
  FRegistroN2.Free;
  FRegistroN3.Free;
  FRegistroN9.Free;
  inherited;
end;

function TPAF_N.WriteRegistroN1: string;
begin
  if Assigned(FRegistroN1) then
    begin
    with FRegistroN1 do
      begin
      Check(funChecaCNPJ(CNPJ),
        '(N1) ESTABELECIMENTO: O CNPJ "%s" digitado � inv�lido!', [CNPJ]);
      Check(funChecaIE(IE, UF),
        '(N1) ESTABELECIMENTO: A Inscri��o Estadual "%s" digitada � inv�lida!', [IE]);
      ///
      Result :=
             LFill('N1') +
             LFill(CNPJ, 14) +
             RFill(IE, 14) +
             RFill(IM, 14) +
             RFill(RAZAOSOCIAL, 50) +
             #13#10;
      end;
    end;
end;

function TPAF_N.WriteRegistroN2: string;
begin
  if Assigned(FRegistroN2) then
      begin
      with FRegistroN2 do
        begin
        Result :=
               LFill('N2') +
               LFill(LAUDO, 10) +
               RFill(NOME, 50) +
               RFill(VERSAO, 10) +
               #13#10;
        end;
      end;
end;

function TPAF_N.WriteRegistroN3: string;
var
  intFor: integer;
  strRegistroN3: string;
begin
  strRegistroN3 := '';

  if Assigned(FRegistroN3) then
    begin
    for intFor := 0 to FRegistroN3.Count - 1 do
      begin
      with FRegistroN3.Items[intFor] do
        begin
        strRegistroN3 := strRegistroN3 + LFill('N3') +
                                         LFill(NOME_ARQUIVO, 50) +
                                           LFill(MD5, 32) +
                                         #13#10;
        end;
      ///
      FRegistroN9.TOT_REG := FRegistroN9.TOT_REG +  1;
      end;
    Result := strRegistroN3;
    end;
end;


function TPAF_N.WriteRegistroN9: string;
begin
  if Assigned(FRegistroN9) then
    begin
    with FRegistroN9 do
      begin
           Result :=
           LFill('N9') +
           LFill(FRegistroN1.CNPJ, 14) +
           RFill(FRegistroN1.IE, 14) +
           LFill(TOT_REG, 6, 0) +
           #13#10;
      end;
    end;
end;

end.

