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
*******************************************************************************}

unit ACBrFContBloco_M;

interface

uses
  SysUtils, Classes, Contnrs, DateUtils, ACBrFContBlocos;

type
  /// Registro M001 - ABERTURA DO BLOCO M

  TRegistroM001 = class(TOpenBlocos)
  private
  public
  end;

  ///Registro M020 - QUALIFICA��O DA PESSOA JUR�DICA E RETIFICA��O

  TRegistroM020 = class
  private
    fQUALI_PJ        : String;    /// Qualifica��o da Pessoa Jur�dica.
    fTIPO_ESCRIT     : String;    /// Tipo de Escritura��o: 0-Original, 1-Retificadora
    fNRO_REC_ANTERIOR: String;    /// N�mero do recibo da escritura��o anterior a ser retificada.
  public
    property QUALI_PJ: String read fQUALI_PJ write fQUALI_PJ;
    property TIPO_ESCRIT: String read fTIPO_ESCRIT write fTIPO_ESCRIT;
    property NRO_REC_ANTERIOR: String read fNRO_REC_ANTERIOR write fNRO_REC_ANTERIOR;
  end;

  /// Registro M030 � IDENTIFICA��O DO PER�ODO DE APURA��O

  TRegistroM030 = class
  private
    fIND_PER        : String;    /// Per�odo Apura��o
    fIND_CALC_ESTIM : String;    /// N�o preencher
    fFORM_TRIB_TRI  : String;    /// N�o preencher
    fVL_LUC_LIQ     : Currency;  /// Resultado do Per�odo - Valor do lucro l�quido (ou do preju�zo) cont�bil do per�odo
    fIND_LUC_LIQ    : String;    /// Situa��o do Resultado do Per�odo
  public
    property IND_PER        : String read fIND_PER        write fIND_PER;
    property IND_CALC_ESTIM : String read fIND_CALC_ESTIM write fIND_CALC_ESTIM;
    property FORM_TRIB_TRI  : String read fFORM_TRIB_TRI  write fFORM_TRIB_TRI;
    property VL_LUC_LIQ     : Currency read fVL_LUC_LIQ     write fVL_LUC_LIQ;
    property IND_LUC_LIQ    : String read fIND_LUC_LIQ    write fIND_LUC_LIQ;
  end;

  /// Registro M030 - Lista

  TRegistroM030List = class(TObjectList)
  private
    function GetItem(Index: Integer): TRegistroM030;
    procedure SetItem(Index: Integer; const Value: TRegistroM030);
  public
    function New: TRegistroM030;
    property Items[Index: Integer]: TRegistroM030 read GetItem write SetItem;
  end;

  /// Registro M990 - ENCERRAMENTO DO BLOCO M

  TRegistroM990 = class
  private
    fQTD_LIN_M: Integer;    /// Quantidade total de linhas do Bloco M
  public
    property QTD_LIN_M: Integer read FQTD_LIN_M write FQTD_LIN_M;
  end;

implementation

{ TRegistroM030List }

function TRegistroM030List.GetItem(Index: Integer): TRegistroM030;
begin
  Result := TRegistroM030(Inherited Items[Index]);
end;

function TRegistroM030List.New: TRegistroM030;
begin
  Result := TRegistroM030.Create;
  Add(Result);
end;

procedure TRegistroM030List.SetItem(Index: Integer; const Value: TRegistroM030);
begin
  Put(Index, Value);
end;

end.
