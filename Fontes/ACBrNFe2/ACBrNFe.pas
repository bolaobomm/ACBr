{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Nota Fiscal}
{ eletr�nica - NFe - http://www.nfe.fazenda.gov.br                          }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
|* 16/12/2008: Wemerson Souto
|*  - Doa��o do componente para o Projeto ACBr
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFe;

interface

uses
  Classes, Sysutils,
  pcnNFe, pcnConversao, pcnCCeNFe, pcnRetCCeNFe,
  pcnEnvEventoNFe, pcnRetEnvEventoNFe, // Incluido por Italo em 09/04/2012
  pcnDownloadNFe,                      // Incluido por Italo em 18/07/2012
  {$IFDEF CLX} QDialogs,{$ELSE} Dialogs,{$ENDIF}
  ACBrNFeNotasFiscais,
  ACBrNFeConfiguracoes,
  ACBrNFeWebServices, ACBrNFeUtil,
  ACBrNFeDANFEClass;

const
  ACBRNFE_VERSAO = '0.4.0a';

type
  TACBrNFeAboutInfo = (ACBrNFeAbout);

  EACBrNFeException = class(Exception);

  // Evento para gerar log das mensagens do Componente
  TACBrNFeLog = procedure(const Mensagem : String) of object ;

  {Carta de Corre��o}
  TCartaCorrecao = Class(TComponent)
  private
    FCCe : TCCeNFe;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property CCe   : TCCeNFe  read FCCe      write FCCe;
  end;

  // Incluido por Italo em 09/04/2012
  {EnvEventoNFe}
  TEnvEventoNFe = Class(TComponent)
  private
    FEnvEventoNFe : TEventoNFe;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property EnvEventoNFe : TEventoNFe read FEnvEventoNFe write FEnvEventoNFe;
  end;

  // Incluido por Italo em 18/07/2012
  {Download}
  TDownload = Class(TComponent)
  private
    FDownload : TDownloadNFe;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Download : TDownloadNFe read FDownload write FDownload;
  end;

  TACBrNFe = class(TComponent)
  private
    fsAbout: TACBrNFeAboutInfo;
    FDANFE : TACBrNFeDANFEClass;
    FNotasFiscais: TNotasFiscais;
    FCartaCorrecao: TCartaCorrecao;
    FEnvEvento: TEnvEventoNFe; // Incluido por Italo em 09/04/2012
    FDownloadNFe: TDownload;  // Incluido por Italo em 18/07/2012
    FWebServices: TWebServices;
    FConfiguracoes: TConfiguracoes;
    FStatus : TStatusACBrNFe;
    FOnStatusChange: TNotifyEvent;
    FOnGerarLog : TACBrNFeLog;
    procedure SetDANFE(const Value: TACBrNFeDANFEClass);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Enviar(ALote: Integer; Imprimir:Boolean = True): Boolean; overload;
    function Enviar(ALote: String; Imprimir:Boolean = True): Boolean; overload;
    function Cancelamento(AJustificativa:WideString): Boolean;
    function Consultar: Boolean;
    function EnviarCartaCorrecao(idLote : Integer): Boolean;
    function EnviarEventoNFe(idLote : Integer): Boolean;  // Incluido por Italo em 09/04/2012
    // Incluido por Italo em 17/07/2012
    function ConsultaNFeDest(CNPJ: String;
                             IndNFe: TpcnIndicadorNFe;
                             IndEmi: TpcnIndicadorEmissor;
                             ultNSU: String): Boolean;
    // Incluido por Italo em 18/07/2012
    function Download: Boolean;
    property WebServices: TWebServices read FWebServices write FWebServices;
    property NotasFiscais: TNotasFiscais read FNotasFiscais write FNotasFiscais;
    property CartaCorrecao: TCartaCorrecao read FCartaCorrecao write FCartaCorrecao;
    property EnvEvento: TEnvEventoNFe read FEnvEvento write FEnvEvento; // Incluido por Italo em 09/04/2012
    property DownloadNFe: TDownload read FDownloadNFe write FDownloadNFe; // Incluido por Italo em 18/07/2012
    property Status: TStatusACBrNFe read FStatus;
    procedure SetStatus( const stNewStatus : TStatusACBrNFe );
  published
    property Configuracoes: TConfiguracoes read FConfiguracoes write FConfiguracoes;
    property OnStatusChange: TNotifyEvent read FOnStatusChange write FOnStatusChange;
    property DANFE: TACBrNFeDANFEClass read FDANFE write SetDANFE ;
    property AboutACBrNFe : TACBrNFeAboutInfo read fsAbout write fsAbout
                          stored false ;
    property OnGerarLog : TACBrNFeLog read FOnGerarLog write FOnGerarLog ;
  end;

procedure ACBrAboutDialog ;

implementation

procedure ACBrAboutDialog ;
var Msg : String ;
begin
    Msg := 'Componente ACBrNFe2'+#10+
           'Vers�o: '+ACBRNFE_VERSAO+#10+#10+
           'Automa��o Comercial Brasil'+#10+#10+
           'http://acbr.sourceforge.net'+#10+#10+
           'Projeto Cooperar - PCN'+#10+#10+
           'http://www.projetocooperar.org/pcn/';
     MessageDlg(Msg ,mtInformation ,[mbOk],0) ;
end;

{ TACBrNFe }

constructor TACBrNFe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FConfiguracoes     := TConfiguracoes.Create( self );
  FConfiguracoes.Name:= 'Configuracoes' ;
  {$IFDEF COMPILER6_UP}
   FConfiguracoes.SetSubComponent( true );{ para gravar no DFM/XFM }
  {$ENDIF}

  FNotasFiscais      := TNotasFiscais.Create(Self,NotaFiscal);
  FNotasFiscais.Configuracoes := FConfiguracoes;
  FCartaCorrecao     := TCartaCorrecao.Create(Self);
  FEnvEvento         := TEnvEventoNFe.Create(Self); // Incluido por Italo em 09/04/2012
  FDownloadNFe       := TDownload.Create(Self);  // Incluido por Italo em 18/07/2012
  FWebServices       := TWebServices.Create(Self);

  if FConfiguracoes.WebServices.Tentativas <= 0 then
     FConfiguracoes.WebServices.Tentativas := 5;
  {$IFDEF ACBrNFeOpenSSL}
    if FConfiguracoes.Geral.IniFinXMLSECAutomatico then
      NotaUtil.InitXmlSec ;
  {$ENDIF}
  FOnGerarLog := nil ;
end;

destructor TACBrNFe.Destroy;
begin
  FConfiguracoes.Free;
  FNotasFiscais.Free;
  FCartaCorrecao.Free;
  FEnvEvento.Free; // Incluido por Italo em 09/04/2012
  FDownloadNFe.Free; // Incluido por Italo em 18/07/2012
  FWebServices.Free;
  {$IFDEF ACBrNFeOpenSSL}
    if FConfiguracoes.Geral.IniFinXMLSECAutomatico then
      NotaUtil.ShutDownXmlSec ;
  {$ENDIF}
  inherited;
end;

procedure TACBrNFe.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDANFE <> nil) and (AComponent is TACBrNFeDANFEClass) then
     FDANFE := nil ;
end;

procedure TACBrNFe.SetDANFE(const Value: TACBrNFeDANFEClass);
 Var OldValue: TACBrNFeDANFEClass ;
begin
  if Value <> FDANFE then
  begin
     if Assigned(FDANFE) then
        FDANFE.RemoveFreeNotification(Self);

     OldValue  := FDANFE ;   // Usa outra variavel para evitar Loop Infinito
     FDANFE    := Value;    // na remo��o da associa��o dos componentes

     if Assigned(OldValue) then
        if Assigned(OldValue.ACBrNFe) then
           OldValue.ACBrNFe := nil ;

     if Value <> nil then
     begin
        Value.FreeNotification(self);
        Value.ACBrNFe := self ;
     end ;
  end ;
end;

procedure TACBrNFe.SetStatus( const stNewStatus : TStatusACBrNFe );
begin
  if ( stNewStatus <> FStatus ) then
  begin
    FStatus := stNewStatus;
    if Assigned(fOnStatusChange) then
      FOnStatusChange(Self);
  end;
end;

function TACBrNFe.Cancelamento(
  AJustificativa: WideString): Boolean;
var
  i : Integer;
begin
  if Self.NotasFiscais.Count = 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhuma Nota Fiscal Eletr�nica Informada!');
      raise EACBrNFeException.Create('Nenhuma Nota Fiscal Eletr�nica Informada!');
   end;

  for i:= 0 to self.NotasFiscais.Count-1 do
  begin
    WebServices.Cancelamento.NFeChave := copy(self.NotasFiscais.Items[i].NFe.infNFe.ID, (length(self.NotasFiscais.Items[i].NFe.infNFe.ID)-44)+1, 44);
    WebServices.Consulta.NFeChave := WebServices.Cancelamento.NFeChave;
    WebServices.Cancela(AJustificativa);
  end;

  Result := true;
end;

function TACBrNFe.Consultar: Boolean;
var
  i : Integer;
begin
  if Self.NotasFiscais.Count = 0 then
   begin
     if Assigned(Self.OnGerarLog) then
        Self.OnGerarLog('ERRO: Nenhuma Nota Fiscal Eletr�nica Informada!');
     raise EACBrNFeException.Create('Nenhuma Nota Fiscal Eletr�nica Informada!');
   end;

  for i := 0 to Self.NotasFiscais.Count-1 do
  begin
    WebServices.Consulta.NFeChave := copy(self.NotasFiscais.Items[i].NFe.infNFe.ID, (length(self.NotasFiscais.Items[i].NFe.infNFe.ID)-44)+1, 44);
    WebServices.Consulta.Executar;
  end;
  Result := True;

end;

function TACBrNFe.Enviar(ALote: Integer; Imprimir:Boolean = True): Boolean;
begin
  Result := Enviar(IntToStr(ALote),Imprimir);
end;

function TACBrNFe.Enviar(ALote: String; Imprimir: Boolean): Boolean;
var
  i: Integer;
begin
  if NotasFiscais.Count <= 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhuma NF-e adicionada ao Lote');
      raise EACBrNFeException.Create('ERRO: Nenhuma NF-e adicionada ao Lote');
     exit;
   end;

  if NotasFiscais.Count > 50 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Conjunto de NF-e transmitidas (m�ximo de 50 NF-e) excedido. Quantidade atual: '+IntToStr(NotasFiscais.Count));
      raise EACBrNFeException.Create('ERRO: Conjunto de NF-e transmitidas (m�ximo de 50 NF-e) excedido. Quantidade atual: '+IntToStr(NotasFiscais.Count));
     exit;
   end;
  NotasFiscais.Assinar;
  NotasFiscais.Valida;

  Result := WebServices.Envia(ALote);

  if DANFE <> nil then
  begin
     for i:= 0 to NotasFiscais.Count-1 do
     begin
       if NotasFiscais.Items[i].Confirmada and Imprimir then
       begin
          NotasFiscais.Items[i].Imprimir;
          if (DANFE.ClassName='TACBrNFeDANFERaveCB') then
            Break;
       end;
     end;
  end;
end;

function TACBrNFe.EnviarCartaCorrecao(idLote: Integer): Boolean;
begin
  if CartaCorrecao.CCe.Evento.Count <= 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhuma CC-e adicionada ao Lote');
      raise EACBrNFeException.Create('ERRO: Nenhuma CC-e adicionada ao Lote');
     exit;
   end;

  if CartaCorrecao.CCe.Evento.Count > 20 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Conjunto de Eventos transmitidos (m�ximo de 20) excedido. Quantidade atual: '+IntToStr(CartaCorrecao.CCe.Evento.Count));
      raise EACBrNFeException.Create('ERRO: Conjunto de Eventos transmitidos (m�ximo de 20) excedido. Quantidade atual: '+IntToStr(CartaCorrecao.CCe.Evento.Count));
     exit;
   end;

  WebServices.CartaCorrecao.idLote := idLote;
  //if not(WebServices.CartaCorrecao.Executar) then
  // Altera��o realizada por Italo em 30/08/2011 conforme sugest�o do Wilson
  Result := WebServices.CartaCorrecao.Executar;
  if not Result then
  begin
    if Assigned(Self.OnGerarLog) then
      Self.OnGerarLog(WebServices.CartaCorrecao.Msg);
    raise EACBrNFeException.Create(WebServices.CartaCorrecao.Msg);
  end;
end;

// Incluido por Italo em 09/04/2012
function TACBrNFe.EnviarEventoNFe(idLote: Integer): Boolean;
var
  i: integer;
begin
  if EnvEvento.EnvEventoNFe.Evento.Count <= 0 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Nenhum Evento adicionado ao Lote');
      raise EACBrNFeException.Create('ERRO: Nenhum Evento adicionado ao Lote');
     exit;
   end;

  if EnvEvento.EnvEventoNFe.Evento.Count > 20 then
   begin
      if Assigned(Self.OnGerarLog) then
         Self.OnGerarLog('ERRO: Conjunto de Eventos transmitidos (m�ximo de 20) excedido. Quantidade atual: '+IntToStr(EnvEvento.EnvEventoNFe.Evento.Count));
      raise EACBrNFeException.Create('ERRO: Conjunto de Eventos transmitidos (m�ximo de 20) excedido. Quantidade atual: '+IntToStr(EnvEvento.EnvEventoNFe.Evento.Count));
     exit;
   end;

  WebServices.EnvEvento.idLote := idLote;

  {Atribuir nSeqEvento, CNPJ, Chave e/ou Protocolo quando n�o especificar}
  for i:= 0 to EnvEvento.EnvEventoNFe.Evento.Count -1 do
  begin
    try
      if EnvEvento.EnvEventoNFe.Evento.Items[i].InfEvento.nSeqEvento = 0 then
        EnvEvento.EnvEventoNFe.Evento.Items[i].infEvento.nSeqEvento := 1;
      if trim(EnvEvento.EnvEventoNFe.Evento.Items[i].InfEvento.CNPJ) = '' then
        EnvEvento.EnvEventoNFe.Evento.Items[i].InfEvento.CNPJ := self.NotasFiscais.Items[i].NFe.Emit.CNPJCPF;
      if trim(EnvEvento.EnvEventoNFe.Evento.Items[i].InfEvento.chNfe) = '' then
        EnvEvento.EnvEventoNFe.Evento.Items[i].InfEvento.chNfe := copy(self.NotasFiscais.Items[i].NFe.infNFe.ID, (length(self.NotasFiscais.Items[i].NFe.infNFe.ID)-44)+1, 44);
      if trim(EnvEvento.EnvEventoNFe.Evento.Items[i].infEvento.detEvento.nProt) = '' then
      begin
        if EnvEvento.EnvEventoNFe.Evento.Items[i].infEvento.tpEvento = teCancelamento then
          EnvEvento.EnvEventoNFe.Evento.Items[i].infEvento.detEvento.nProt := self.NotasFiscais.Items[i].NFe.procNFe.nProt;
      end;
    except
    end;
  end;
  {**}

  Result := WebServices.EnvEvento.Executar;
  if not Result then
  begin
    if Assigned(Self.OnGerarLog) then
      Self.OnGerarLog(WebServices.EnvEvento.Msg);
    raise EACBrNFeException.Create(WebServices.EnvEvento.Msg);
  end;
end;

// Incluido por Italo em 17/07/2012
function TACBrNFe.ConsultaNFeDest(CNPJ: String; IndNFe: TpcnIndicadorNFe;
  IndEmi: TpcnIndicadorEmissor; ultNSU: String): Boolean;
begin
  WebServices.ConsNFeDest.CNPJ   := CNPJ;
  WebServices.ConsNFeDest.indNFe := IndNFe;
  WebServices.ConsNFeDest.indEmi := IndEmi;
  WebServices.ConsNFeDest.ultNSU := ultNSU;

  Result := WebServices.ConsNFeDest.Executar;
  if not Result then
  begin
    if Assigned(Self.OnGerarLog) then
      Self.OnGerarLog(WebServices.ConsNFeDest.Msg);
    raise EACBrNFeException.Create(WebServices.ConsNFeDest.Msg);
  end;
end;

// Incluido por Italo em 18/07/2012
function TACBrNFe.Download: Boolean;
begin
  Result := WebServices.DownloadNFe.Executar;
  if not Result then
  begin
    if Assigned(Self.OnGerarLog) then
      Self.OnGerarLog(WebServices.DownloadNFe.Msg);
    raise EACBrNFeException.Create(WebServices.DownloadNFe.Msg);
  end;
end;

{ TCartaCorrecao }
constructor TCartaCorrecao.Create(AOwner: TComponent);
begin
  inherited;
  FCCe := TCCeNFe.Create;
end;

destructor TCartaCorrecao.Destroy;
begin
  FCCe.Free;
  inherited;
end;

{ TEnvEventoNFe }
// Incluido por Italo em 09/04/2012
constructor TEnvEventoNFe.Create(AOwner: TComponent);
begin
  inherited;
  FEnvEventoNFe := TEventoNFe.Create;
end;

destructor TEnvEventoNFe.Destroy;
begin
  FEnvEventoNFe.Free;
  inherited;
end;

{ TDownload }
// Incluido por Italo em 18/07/2012

constructor TDownload.Create(AOwner: TComponent);
begin
  inherited;
  FDownload := TDownloadNFe.Create;
end;

destructor TDownload.Destroy;
begin
  FDownload.Free;
  inherited;
end;

end.
