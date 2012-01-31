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

unit ACBrSMSZTE;

interface

uses
  ACBrSMSClass, Classes, SysUtils;

type
  TACBrSMSZTE = class(TACBrSMSClass)
  private

  public
    constructor Create(AOwner: TComponent);

    procedure Ativar; override;

    function EmLinha: Boolean; override;
    function IMEI: AnsiString; override;
    function Operadora: AnsiString; override;
    function NivelSinal: Double; override;
    function Fabricante: AnsiString; override;
    function ModeloModem: AnsiString; override;
    function Firmware: AnsiString; override;

    procedure EnviarSMS(const ATelefone: AnsiString;
      const AMensagem: AnsiString; var AIndice: Integer); override;
    procedure ListarMensagens(const AFiltro: TACBrSMSFiltro;
      const APath: AnsiString); override;
  end;

implementation

uses
  ACBrDevice, ACBrUtil;

{ TACBrSMSZTE }

procedure TACBrSMSZTE.Ativar;
var
  cmd: AnsiString;
begin
  inherited;

  // configura o modem zte
  Cmd := 'AT+ZOPRT=5';

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(cmd));

  if not fpDevice.Serial.ATResult then
    raise EACBrSMSException.Create('N�o foi poss�vel inicializar o modem.');
end;

constructor TACBrSMSZTE.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fpDevice.Baud := 115200;
  fpDevice.TimeOut := 30000;
  fpDevice.HandShake := hsNenhum;
  fpDevice.Serial.AtTimeout := 30000;
end;

function TACBrSMSZTE.EmLinha: Boolean;
var
  Cmd: AnsiString;
begin
  Cmd := 'AT';

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));

  Result := fpDevice.Serial.ATResult;
end;

function TACBrSMSZTE.IMEI: AnsiString;
var
  Cmd: AnsiString;
begin
  Cmd := 'AT+CGSN';

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));

  if fpDevice.Serial.ATResult then
    Result := Trim(Copy(fpUltimaResposta, 1, Pos('OK', fpUltimaResposta) - 1))
  else
    Result := EmptyStr;
end;

procedure TACBrSMSZTE.ListarMensagens(const AFiltro: TACBrSMSFiltro;
  const APath: AnsiString);
var
  cmd: AnsiString;
  Retorno: String;
  I: Integer;
begin
  case AFiltro of
    fltTudo:     cmd := 'AT+CMGL="ALL"';
    fltLidas:    cmd := 'AT+CMGL="REC READ"';
    fltNaoLidas: cmd := 'AT+CMGL="REC UNREAD"';
  end;

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(cmd));

  Retorno := EmptyStr;
  for I := 0 to Length(fpUltimaResposta) - 1 do
  begin
    if not(fpUltimaResposta[I] in [#0, #5, #$18, #$C]) then
      Retorno := Retorno + fpUltimaResposta[I];
  end;

  fpUltimaResposta := Trim(Retorno);
  WriteToTXT(APath, fpUltimaResposta, False, True);
end;

function TACBrSMSZTE.ModeloModem: AnsiString;
var
  Cmd: AnsiString;
begin
  Cmd := 'AT+CGMM';

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));

  if fpDevice.Serial.ATResult then
    Result := Trim(Copy(fpUltimaResposta, 1, Pos('OK', fpUltimaResposta) - 1))
  else
    Result := EmptyStr;
end;

function TACBrSMSZTE.Fabricante: AnsiString;
var
  Cmd: AnsiString;
begin
  Cmd := 'AT+CGMI';

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));

  if fpDevice.Serial.ATResult then
    Result := Trim(Copy(fpUltimaResposta, 1, Pos('OK', fpUltimaResposta) - 1))
  else
    Result := EmptyStr;
end;

function TACBrSMSZTE.Firmware: AnsiString;
var
  Cmd: AnsiString;
begin
  Cmd := 'AT+CGMR';

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));

  if fpDevice.Serial.ATResult then
    Result := Trim(Copy(fpUltimaResposta, 1, Pos('OK', fpUltimaResposta) - 1))
  else
    Result := EmptyStr;
end;

function TACBrSMSZTE.NivelSinal: Double;
var
  Cmd: AnsiString;
  RetCmd: AnsiString;
begin
  Cmd := 'AT+CSQ';

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));

  if fpDevice.Serial.ATResult then
  begin
    RetCmd := AnsiUpperCase(fpUltimaResposta);
    RetCmd := Trim(Copy(RetCmd, 1, Pos('OK', RetCmd) - 1));
    RetCmd := Trim(Copy(RetCmd, pos(':', RetCmd) + 1, Length(RetCmd)));

    Result := StrToFloatDef(String(RetCmd), 0.00);
  end
  else
    Result := 0;
end;

function TACBrSMSZTE.Operadora: AnsiString;
var
  Cmd: AnsiString;
begin
  Cmd := 'AT+COPS?';

  fpDevice.Serial.Purge;
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));

  if fpDevice.Serial.ATResult then
  begin
    Result := Trim(Copy(fpUltimaResposta, 1, Pos('OK', fpUltimaResposta) - 1));
    Result := Copy(Result, Pos('"', Result) + 1, Length(Result));
    Result := Copy(Result, 1, Pos('"', Result) - 1);
  end
  else
    Result := EmptyStr;
end;

procedure TACBrSMSZTE.EnviarSMS(const ATelefone,
  AMensagem: AnsiString; var AIndice: Integer);
var
  Cmd: AnsiString;
  bRec: Integer;
  Ret: AnsiString;
const
  CR = #13;
  CTRL_Z = #26;
begin
  // definir a bandeja da qual ser� enviada a mensagem *************************
  TrocarBandeja(Self.SinCard);

  // definir o modo de envio ***************************************************
  Cmd := 'AT+CMGF=1';
  fpUltimaResposta := Trim(fpDevice.Serial.ATCommand(Cmd));
  if not fpDevice.Serial.ATResult then
    raise EACBrSMSException.Create(FALHA_INICIALIZACAO + sLineBreak + fpUltimaResposta);

  // definir o n�mero de telefone do destinat�rio ******************************
  Cmd := 'AT+CMGS="' + ATelefone + '"' + CR;
  fpDevice.Serial.Purge;
  bRec := fpDevice.Serial.SendBuffer(Pointer(Cmd), Length(Cmd));
  if bRec = Length(Cmd) then
  begin
    Sleep(1000);
    fpUltimaResposta := Trim(fpDevice.Serial.RecvPacket(fpDevice.Serial.AtTimeout));
    if Pos('>', fpUltimaResposta) <= 0 then
      raise EACBrSMSException.Create(FALHA_NUMERO_TELEFONE + sLineBreak + fpUltimaResposta);
  end
  else
    raise EACBrSMSException.Create(FALHA_NUMERO_TELEFONE);

  // Enviar a mensagem *********************************************************
  Cmd := Trim(AMensagem) + CTRL_Z + CR;
  fpUltimaResposta := fpDevice.Serial.ATCommand(Cmd);
  if not fpDevice.Serial.ATResult then
    raise EACBrSMSException.Create(FALHA_ENVIAR_MENSAGEM + sLineBreak + fpUltimaResposta);

  // verificar se foi retornado indice da mensagem
  Ret := fpUltimaResposta;
  if Pos(':', Ret) <= 0 then
    raise EACBrSMSException.Create(FALHA_INDICE_MENSAGEM + sLineBreak + fpUltimaResposta);

  // separar o indice da mensagem
  Ret := Trim(Copy(Ret, Pos(':', Ret) + 1, Length(Ret)));
  Ret := Trim(Copy(Ret, 1, Pos('OK', Ret) - 1));

  AIndice := StrToIntDef(Trim(Ret), -1);
  if AIndice = -1 then
    raise EACBrSMSException.Create(FALHA_INDICE_MENSAGEM + sLineBreak + fpUltimaResposta);
end;

end.
