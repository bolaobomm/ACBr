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

unit ACBrSMSClass;

interface

uses
  ACBrDevice, ACBrECF, Classes, SysUtils;

const
  FALHA_INICIALIZACAO = 'N�o foi poss�vel inicializar o envio da mensagem.';
  FALHA_SINCARD_SINCRONIZADO = 'Sincard n�o sincronizado com a rede celular.';
  FALHA_NUMERO_TELEFONE = 'Falha ao definir o n�mero de telefone do destinat�rio.';
  FALHA_ENVIAR_MENSAGEM = 'N�o foi poss�vel enviar a mensagem de texto.';
  FALHA_INDICE_MENSAGEM = 'Indice retornado inv�lido, mensagem n�o foi enviada.';

type
  EACBrSMSException = class(Exception);

  TACBrSMSModelo = (modNenhum, modDaruma, modZTE, modGenerico);
  TACBrSMSSincronismo = (sinErro, sinSincronizado, sinNaoSincronizado, sinBucandoRede);
  TACBrSMSSinCard = (sin1, sin2);
  TACBrSMSFiltro = (fltTudo, fltLidas, fltNaoLidas);

  TACBrSMSClass = class
  private
    fpRecebeConfirmacao: Boolean;
    fpSinCard: TACBrSMSSinCard;
    fpQuebraMensagens: Boolean;
    fpATTimeOut: Integer;
    procedure SetAtivo(const Value: Boolean);
  protected
    fpDevice: TACBrDevice;
    fpAtivo: Boolean;
    fpUltimaResposta: AnsiString;
    fpAtResult: Boolean;
    fpBandejasSimCard: Integer;
  public
    constructor Create(AOwner: TComponent);
    Destructor Destroy; override;

    procedure Ativar; virtual;
    procedure Desativar; virtual;

    procedure EnviarComando(Cmd: AnsiString);
    procedure EnviarBuffer(Cmd: AnsiString);

    function EmLinha: Boolean; virtual;
    function IMEI: AnsiString; virtual;
    function NivelSinal: Double; virtual;
    function Operadora: AnsiString; virtual;
    function Fabricante: AnsiString; virtual;
    function ModeloModem: AnsiString; virtual;
    function Firmware: AnsiString; virtual;
    function EstadoSincronismo: TACBrSMSSincronismo; virtual;

    procedure TrocarBandeja(const ASinCard: TACBrSMSSinCard); virtual;
    procedure EnviarSMS(const ATelefone, AMensagem: AnsiString;
      var AIndice: String); virtual;
    procedure ListarMensagens(const AFiltro: TACBrSMSFiltro;
      const APath: AnsiString); virtual;

    property Ativo: Boolean read fpAtivo write SetAtivo;
    property SinCard: TACBrSMSSinCard read fpSinCard write fpSinCard;
    property ATTimeOut: Integer read fpATTimeOut write fpATTimeOut;
    property ATResult: Boolean read fpATResult write fpATResult;
    property RecebeConfirmacao: Boolean read fpRecebeConfirmacao write fpRecebeConfirmacao;
    property QuebraMensagens: Boolean read fpQuebraMensagens write fpQuebraMensagens;
    property BandejasSimCard: Integer read fpBandejasSimCard;
    property UltimaResposta: AnsiString read fpUltimaResposta write fpUltimaResposta;
  end;

implementation

uses
  ACBrSMS, ACBrUtil;

{ TACBrSMSClass }

constructor TACBrSMSClass.Create(AOwner: TComponent);
begin
  fpDevice := (AOwner as TACBrSMS).Device;
  fpDevice.SetDefaultValues;
  fpDevice.TimeOut := 10000;
  fpDevice.Serial.AtTimeout := 10000;

  fpAtivo := False;
  fpSinCard := sin1;
  fpRecebeConfirmacao := False;
  fpQuebraMensagens := False;
  fpATResult := False;
  fpATTimeout := 10000;
  fpBandejasSimCard := 1;
  fpUltimaResposta := AnsiString(EmptyStr);
end;

destructor TACBrSMSClass.Destroy;
begin
  if Assigned(fpDevice) then
    fpDevice := nil;

  inherited Destroy;
end;

function TACBrSMSClass.EmLinha: Boolean;
begin
  Result := False;
end;

procedure TACBrSMSClass.EnviarSMS(const ATelefone, AMensagem: AnsiString;
  var AIndice: String);
begin
  raise EACBrSMSException.Create('ENVIAR SMS n�o implementado.');
end;

function TACBrSMSClass.EstadoSincronismo: TACBrSMSSincronismo;
begin
  raise EACBrSMSException.Create('ESTADO SINCRONISMO n�o implementado.');
end;

function TACBrSMSClass.Fabricante: AnsiString;
begin
  raise EACBrSMSException.Create('FABRICANTE n�o implementado.');
end;

function TACBrSMSClass.IMEI: AnsiString;
begin
  raise EACBrSMSException.Create('IMEI n�o implementado.');
end;

procedure TACBrSMSClass.ListarMensagens(const AFiltro: TACBrSMSFiltro;
  const APath: AnsiString);
begin
  raise EACBrSMSException.Create('Listar mensagens n�o implementado.');
end;

function TACBrSMSClass.ModeloModem: AnsiString;
begin
  raise EACBrSMSException.Create('MODELO MODEM n�o implementado.');
end;

function TACBrSMSClass.NivelSinal: Double;
begin
  raise EACBrSMSException.Create('Nivel de Sinal n�o implementado.');
end;

function TACBrSMSClass.Operadora: AnsiString;
begin
  raise EACBrSMSException.Create('Retorno de Operadora n�o implementado.');
end;

function TACBrSMSClass.Firmware: AnsiString;
begin
  raise EACBrSMSException.Create('REVISAO n�o implementado.');
end;

procedure TACBrSMSClass.SetAtivo(const Value: Boolean);
begin
  if Value then
    Ativar
  else
    Desativar;
end;

procedure TACBrSMSClass.TrocarBandeja(const ASinCard: TACBrSMSSinCard);
begin
  raise EACBrSMSException.Create('Trocar Bandeja n�o implementado.');
end;

procedure TACBrSMSClass.EnviarComando(Cmd: AnsiString);
var
  sRet: AnsiString;
begin
  fpUltimaResposta := '';
  fpAtResult := False;

  fpDevice.Serial.Purge;
  fpDevice.Serial.SendString(Cmd + sLineBreak);

  repeat
    sRet := fpDevice.Serial.Recvstring(fpATTimeOut);

    if sRet <> Cmd then
      fpUltimaResposta := fpUltimaResposta + sRet + sLineBreak;

    if sRet = 'ERROR' then
      break;
    if sRet = 'NO CARRIER' then
      break;
    if sRet = 'BUSY' then
      break;
    if sRet = 'NO DIALTONE' then
      break;

    if (sRet = 'OK') or
       (sRet = '>') or
       (Pos('CONNECT', String(sRet)) = 1) then
    begin
      fpAtResult := True;
      break;
    end;
  until fpDevice.Serial.LastError <> 0;

  fpUltimaResposta := Trim(fpUltimaResposta);
end;

procedure TACBrSMSClass.EnviarBuffer(Cmd: AnsiString);
var
  bRec: Integer;
begin
  fpDevice.Serial.Purge;
  ATResult := False;

  Cmd := Cmd + sLineBreak;
  bRec := fpDevice.Serial.SendBuffer(Pointer(Cmd), Length(Cmd));

  if bRec = Length(Cmd) then
  begin
    Sleep(500);
    fpUltimaResposta := Trim(fpDevice.Serial.RecvPacket(fpDevice.Serial.AtTimeout));
    AtResult := True;
  end
  else
    raise EACBrSMSException.Create('Falha ao enviar buffer de comando para o modem.');
end;

procedure TACBrSMSClass.Ativar;
begin
  if fpAtivo then
    exit;

  if fpDevice.Porta <> '' then
    fpDevice.Ativar;

  fpAtivo := True;
end;

procedure TACBrSMSClass.Desativar;
begin
  if not fpAtivo then
    exit;

  if fpDevice.Porta <> '' then
     fpDevice.Desativar;

  fpAtivo := False;
end;

end.
