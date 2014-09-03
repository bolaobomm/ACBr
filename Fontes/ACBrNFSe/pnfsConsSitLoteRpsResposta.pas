{******************************************************************************}
{ Projeto: Componente ACBrNFSe                                                 }
{  Biblioteca multiplataforma de componentes Delphi                            }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{$I ACBr.inc}

unit pnfsConsSitLoteRpsResposta;

interface

uses
  SysUtils, Classes,
  pcnAuxiliar, pcnConversao, pcnLeitor, pnfsConversao, pnfsNFSe, ACBrNFSeUtil;

type

 TMsgRetornoSitCollection = class;
 TMsgRetornoSitCollectionItem = class;

 TInfSit = class(TPersistent)
  private
    FNumeroLote: string;
    FSituacao: string;
    FMsgRetorno : TMsgRetornoSitCollection;
    procedure SetMsgRetorno(Value: TMsgRetornoSitCollection);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    property NumeroLote: string                   read FNumeroLote write FNumeroLote;
    property Situacao: string                     read FSituacao   write FSituacao;
    property MsgRetorno: TMsgRetornoSitCollection read FMsgRetorno write SetMsgRetorno;
  end;

 TMsgRetornoSitCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TMsgRetornoSitCollectionItem;
    procedure SetItem(Index: Integer; Value: TMsgRetornoSitCollectionItem);
  public
    constructor Create(AOwner: TInfSit);
    function Add: TMsgRetornoSitCollectionItem;
    property Items[Index: Integer]: TMsgRetornoSitCollectionItem read GetItem write SetItem; default;
  end;

 TMsgRetornoSitCollectionItem = class(TCollectionItem)
  private
    FCodigo : String;
    FMensagem : String;
    FCorrecao : String;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property Codigo: string   read FCodigo   write FCodigo;
    property Mensagem: string read FMensagem write FMensagem;
    property Correcao: string read FCorrecao write FCorrecao;
  end;

 TretSitLote = class(TPersistent)
  private
    FLeitor: TLeitor;
    FInfSit: TInfSit;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: boolean;
    function LerXML_provedorEquiplano: Boolean;
  published
    property Leitor: TLeitor  read FLeitor   write FLeitor;
    property InfSit: TInfSit  read FInfSit   write FInfSit;
  end;

implementation

{ TInfSit }

constructor TInfSit.Create;
begin
  FMsgRetorno := TMsgRetornoSitCollection.Create(Self);
end;

destructor TInfSit.Destroy;
begin
  FMsgRetorno.Free;

  inherited;
end;

procedure TInfSit.SetMsgRetorno(Value: TMsgRetornoSitCollection);
begin
  FMsgRetorno.Assign(Value);
end;

{ TMsgRetornoSitCollection }

function TMsgRetornoSitCollection.Add: TMsgRetornoSitCollectionItem;
begin
  Result := TMsgRetornoSitCollectionItem(inherited Add);
  Result.create;
end;

constructor TMsgRetornoSitCollection.Create(AOwner: TInfSit);
begin
  inherited Create(TMsgRetornoSitCollectionItem);
end;

function TMsgRetornoSitCollection.GetItem(
  Index: Integer): TMsgRetornoSitCollectionItem;
begin
  Result := TMsgRetornoSitCollectionItem(inherited GetItem(Index));
end;

procedure TMsgRetornoSitCollection.SetItem(Index: Integer;
  Value: TMsgRetornoSitCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TMsgRetornoSitCollectionItem }

constructor TMsgRetornoSitCollectionItem.Create;
begin

end;

destructor TMsgRetornoSitCollectionItem.Destroy;
begin

  inherited;
end;

{ TretSitLote }

constructor TretSitLote.Create;
begin
  FLeitor := TLeitor.Create;
  FInfSit := TInfSit.Create;
end;

destructor TretSitLote.Destroy;
begin
  FLeitor.Free;
  FInfSit.Free;
  inherited;
end;

function TretSitLote.LerXml: boolean;
var
  i: Integer;
begin
  result := True;

  try
    // Incluido por Ricardo Miranda em 14/03/2013
    Leitor.Arquivo := NotaUtil.RetirarPrefixos(Leitor.Arquivo);
    Leitor.Arquivo := StringReplace(Leitor.Arquivo, ' xmlns=""', '', [rfReplaceAll]);
    Leitor.Grupo   := Leitor.Arquivo;

    // Alterado por Akai - L. Massao Aihara 31/10/2013
    if (leitor.rExtrai(1, 'ConsultarSituacaoLoteRpsResposta') <> '') or
       (leitor.rExtrai(1, 'Consultarsituacaoloterpsresposta') <> '') or
       (leitor.rExtrai(1, 'ConsultarLoteRpsResposta') <> '') or
       (leitor.rExtrai(1, 'ConsultarSituacaoLoteRpsResult') <> '') then
    begin
      InfSit.FNumeroLote := Leitor.rCampo(tcStr, 'NumeroLote');
      InfSit.FSituacao   := Leitor.rCampo(tcStr, 'Situacao');

      // FSituacao: 1 = Não Recebido
      //            2 = Não Processado
      //            3 = Processado com Erro
      //            4 = Processado com Sucesso

      // Ler a Lista de Mensagens
      if leitor.rExtrai(2, 'ListaMensagemRetorno') <> '' then
      begin
        i := 0;
        while Leitor.rExtrai(3, 'MensagemRetorno', '', i + 1) <> '' do
        begin
          InfSit.FMsgRetorno.Add;
          InfSit.FMsgRetorno[i].FCodigo   := Leitor.rCampo(tcStr, 'Codigo');
          InfSit.FMsgRetorno[i].FMensagem := Leitor.rCampo(tcStr, 'Mensagem');
          InfSit.FMsgRetorno[i].FCorrecao := Leitor.rCampo(tcStr, 'Correcao');

          inc(i);
        end;
      end;

    end;

    i := 0;
    while (Leitor.rExtrai(1, 'Fault', '', i + 1) <> '') do
     begin
       InfSit.FMsgRetorno.Add;
       InfSit.FMsgRetorno[i].FCodigo   := Leitor.rCampo(tcStr, 'faultcode');
       InfSit.FMsgRetorno[i].FMensagem := Leitor.rCampo(tcStr, 'faultstring');
       InfSit.FMsgRetorno[i].FCorrecao := '';

       inc(i);
     end;
  except
    result := False;
  end;
end;

function TretSitLote.LerXML_provedorEquiplano: Boolean;
var
  i: Integer;
begin
  try
    // Incluido por Ricardo Miranda em 14/03/2013
    Leitor.Arquivo := NotaUtil.RetirarPrefixos(Leitor.Arquivo);
    Leitor.Arquivo := StringReplace(Leitor.Arquivo, ' xmlns=""', '', [rfReplaceAll]);
    Leitor.Grupo   := Leitor.Arquivo;

    InfSit.FNumeroLote := Leitor.rCampo(tcStr, 'nrLoteRps');
    InfSit.FSituacao   := Leitor.rCampo(tcStr, 'stLote');
		//1 - Aguardando processamento
		//2 - Não Processado, lote com erro
		//3 - Processado com sucesso
		//4 - Processado com avisos

    if leitor.rExtrai(1, 'mensagemRetorno') <> '' then
      begin
        i := 0;
        if (leitor.rExtrai(2, 'listaErros') <> '') then
          begin
            while Leitor.rExtrai(3, 'erro', '', i + 1) <> '' do
              begin
                InfSit.FMsgRetorno.Add;
                InfSit.FMsgRetorno[i].FCodigo   := Leitor.rCampo(tcStr, 'cdMensagem');
                InfSit.FMsgRetorno[i].FMensagem := Leitor.rCampo(tcStr, 'dsMensagem');
                InfSit.FMsgRetorno[i].FCorrecao := Leitor.rCampo(tcStr, 'dsCorrecao');

                inc(i);
              end;
          end;

        if (leitor.rExtrai(2, 'listaAlertas') <> '') then
          begin
            while Leitor.rExtrai(3, 'alerta', '', i + 1) <> '' do
              begin
                InfSit.FMsgRetorno.Add;
                InfSit.FMsgRetorno[i].FCodigo   := Leitor.rCampo(tcStr, 'cdMensagem');
                InfSit.FMsgRetorno[i].FMensagem := Leitor.rCampo(tcStr, 'dsMensagem');
                InfSit.FMsgRetorno[i].FCorrecao := Leitor.rCampo(tcStr, 'dsCorrecao');

                inc(i);
              end;
          end;
      end;

    result := True;
  except
    result := False;
  end;
end;

end.

