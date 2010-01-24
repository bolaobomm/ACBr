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

unit ACBrPAF_P_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrUtilTXT, ACBrPAFRegistros, ACBrPAF_P;

type
  /// TPAF_P -
  TPAF_P = class(TACBrTXT)
  private
    FRegistroP1: TRegistroP1;       /// RegistroP1
    FRegistroP2: TRegistroP2List;   /// Lista de RegistroP2
    FRegistroP9: TRegistroP9;       /// RegistroP9
  protected
  public
    constructor Create(AOwner: TComponent);/// Create
    destructor Destroy; override; /// Destroy

    function WriteRegistroP1: string;
    function WriteRegistroP2: string;
    function WriteRegistroP9: string;

    property RegistroP1: TRegistroP1 read FRegistroP1 write FRegistroP1;
    property RegistroP2: TRegistroP2List read FRegistroP2 write FRegistroP2;
    property RegistroP9: TRegistroP9 read FRegistroP9 write FRegistroP9;
  end;

implementation

uses ACBrSPEDUtils;

{ TPAF_P }

constructor TPAF_P.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRegistroP1 := TRegistroP1.Create;
  FRegistroP2 := TRegistroP2List.Create;
  FRegistroP9 := TRegistroP9.Create;

  FRegistroP9.TOT_REG := 0;
end;

destructor TPAF_P.Destroy;
begin
  FRegistroP1.Free;
  FRegistroP2.Free;
  FRegistroP9.Free;
  inherited;
end;

function TPAF_P.WriteRegistroP1: string;
begin
   if Assigned(RegistroP1) then
   begin
      with RegistroP1 do
      begin
        Check(funChecaCNPJ(CNPJ), '(P1) ESTABELECIMENTO: O CNPJ "%s" digitado � inv�lido!', [CNPJ]);
        Check(funChecaIE(IE, UF), '(P1) ESTABELECIMENTO: A Inscri��o Estadual "%s" digitada � inv�lida!', [IE]);
        ///
        Result := LFill('P1') +
                  LFill(CNPJ, 14) +
                  RFill(IE, 14) +
                  RFill(IM, 14) +
                  RFill(RAZAOSOCIAL, 50) +
                  #13#10;
      end;
      ///
      RegistroP9.TOT_REG := RegistroP9.TOT_REG + 1;
   end;
end;

function TPAF_P.WriteRegistroP2: string;
var
intFor: integer;
strRegistroP2: string;
begin
  strRegistroP2 := '';

  if Assigned(RegistroP2) then
  begin
     for intFor := 0 to RegistroP2.Count - 1 do
     begin
        with RegistroP2.Items[intFor] do
        begin
          Check(funChecaCNPJ(RegistroP1.CNPJ), '(P2) ESTOQUE: O CNPJ "%s" digitado � inv�lido!', [RegistroP1.CNPJ]);
          ///
          strRegistroP2 := strRegistroP2 + LFill('P2') +
                                           LFill(RegistroP1.CNPJ, 14) +
                                           RFill(COD_MERC_SERV, 14) +
                                           RFill(DESC_MERC_SERV, 50) +
                                           RFill(UN_MED, 6) +
                                           RFill(IAT, 6) +
                                           RFill(IPPT, 6) +
                                           RFill(ST, 6) +
                                           LFill(ALIQ, 4) +
                                           LFill(VL_UNIT, 12, 2) +
                                           #13#10;
        end;
        ///
        RegistroP9.TOT_REG := RegistroP9.TOT_REG + 1;
     end;
     Result := strRegistroP2;
  end;
end;

function TPAF_P.WriteRegistroP9: string;
begin
   if Assigned(RegistroP9) then
   begin
      with RegistroP9 do
      begin
        Check(funChecaCNPJ(RegistroP1.CNPJ),            '(P9) TOTALIZA��O: O CNPJ "%s" digitado � inv�lido!', [RegistroP1.CNPJ]);
        Check(funChecaIE(RegistroP1.IE, RegistroP1.UF), '(P9) TOTALIZA��O: A Inscri��o Estadual "%s" digitada � inv�lida!', [RegistroP1.IE]);
        ///
        Result := LFill('P9') +
                  LFill(RegistroP1.CNPJ) +
                  LFill(RegistroP1.IE) +
                  LFill(TOT_REG, 6, 0) +
                  #13#10;
      end;
   end;
end;

end.
