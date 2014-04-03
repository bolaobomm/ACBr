{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2014 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{ Esse arquivo usa a classe  SynaSer   Copyright (c)2001-2003, Lukas Gebauer   }
{  Project : Ararat Synapse     (Found at URL: http://www.ararat.cz/synapse/)  }
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

{******************************************************************************}
{******************************************************************************
|* Historico
|*
******************************************************************************}

{$I ACBr.inc}

unit ACBrTabelasSped;

interface

uses
  Classes, SysUtils, contnrs, ACBrSocket, ACBrDownload, ACBrUtil;

type
  TACBrCodSistema = (csSpedFiscal, csSpedPisCofins, csSpedContabil);

  EACBrTabelasSpedxception = class(Exception);

  { TACBrTabelasSpedTabela }

  TACBrTabelasSpedTabela = class
  private
    fId: string;
    fPacote: string;
    fTipo: string;
    fDesc: string;
    fVersao: string;
    fDtCriacao: TdateTime;
    fDtVersao: TdateTime;
    fHash: string;

  public
    property Id: string read fId write fId;
    property Pacote: string read fPacote write fPacote;
    property Tipo: string read fTipo write fTipo;
    property Desc: string read fDesc write fDesc;
    property Versao: string read fVersao write fVersao;
    property DtCriacao: TdateTime read fDtCriacao write fDtCriacao;
    property DtVersao: TdateTime read fDtVersao write fDtVersao;
    property Hash: string read fHash write fHash;
  end;

  { Lista de Objetos do tipo TACBrCEPEndereco }

  { TACBrTabelasSpedTabelas }

  TACBrTabelasSpedTabelas = class(TObjectList)
  protected
    procedure SetObject(Index: integer; Item: TACBrTabelasSpedTabela);
    function GetObject(Index: integer): TACBrTabelasSpedTabela;
  public
    function Add(Obj: TACBrTabelasSpedTabela): integer;
    function New: TACBrTabelasSpedTabela;
    property Objects[Index: integer]: TACBrTabelasSpedTabela read GetObject write SetObject; default;
  end;

  { TACBrTabelasSped}

  TACBrTabelasSped = class(TACBrHTTP)
  private
    fCodSistema: TACBrCodSistema;
    fTabelas: TACBrTabelasSpedTabelas;

    procedure SetCodSistema(const AValue: TACBrCodSistema);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ListarTabelas;
    function Download(const aId, aVersao, aDestino: string): boolean;
    property Tabelas: TACBrTabelasSpedTabelas read fTabelas write fTabelas;
  published
    property CodSistema: TACBrCodSistema read fCodSistema write SetCodSistema default csSpedFiscal;

  end;

var
  UrlDownload: string;
  Listou: boolean;

implementation

uses strutils, Math, synacode;

constructor TACBrTabelasSped.Create(AOwner: TComponent);
begin
  inherited;
  fTabelas := TACBrTabelasSpedTabelas.Create;
  fTabelas.Clear;
  fCodSistema := csSpedFiscal;
  Listou := False;
end;

procedure TACBrTabelasSpedTabelas.SetObject(Index: integer; Item: TACBrTabelasSpedTabela);
begin
  inherited SetItem(Index, Item);
end;

function TACBrTabelasSpedTabelas.GetObject(Index: integer): TACBrTabelasSpedTabela;
begin
  Result := inherited GetItem(Index) as TACBrTabelasSpedTabela;
end;

function TACBrTabelasSpedTabelas.New: TACBrTabelasSpedTabela;
begin
  Result := TACBrTabelasSpedTabela.Create;
  Add(Result);
end;

function TACBrTabelasSpedTabelas.Add(Obj: TACBrTabelasSpedTabela): integer;
begin
  Result := inherited Add(Obj);
end;

destructor TACBrTabelasSped.Destroy;
begin
  fTabelas.Free;
  inherited Destroy;
end;

procedure TACBrTabelasSped.SetCodSistema(const AValue: TACBrCodSistema);
begin
  if FCodSistema = AValue then
    exit;
  FCodSistema := AValue;
end;

procedure TACBrTabelasSped.ListarTabelas;
var
  UrlConsulta, CodSis, Buffer, pct, dt: string;
  SL1: TStringList;
  i: integer;

  function CopyDeAte(Texto, TextIni, TextFim: string): string;
  var
    ContIni, ContFim: integer;
  begin
    Result := '';
    if (Pos(TextFim, Texto) <> 0) and (Pos(TextIni, Texto) <> 0) then
    begin
      ContIni := Pos(TextIni, Texto) + Length(TextIni);
      ContFim := Pos(TextFim, Texto);
      Result := Copy(Texto, ContIni, ContFim - ContIni);
    end;
  end;

begin
  Listou := False;
  UrlConsulta := 'http://www.sped.fazenda.gov.br/spedtabelas/WsConsulta/WsConsulta.asmx/consultarVersoesTabelasExternas?codigoSistema=';
  if fCodSistema = csSpedFiscal then
    CodSis := 'spedfiscal'
  else
  if fCodSistema = csSpedPisCofins then
    CodSis := 'spedPiscofins'
  else
  if fCodSistema = csSpedContabil then
    CodSis := 'spedcontabil';

  try
    Self.HTTPGet(UrlConsulta + CodSis);
  except
    on E: Exception do
    begin
      raise EACBrTabelasSpedxception.Create('Erro ao consultar tabelas' + #13#10 + E.Message);
    end;
  end;

  Buffer := Self.RespHTTP.Text;
  urldownload := LerTagXML(Buffer, 'urlDownloadArquivo');
  Buffer := LerTagXML(Buffer, 'metadadosXml');
  Buffer := StringReplace(Buffer, '&lt;', '<', [rfReplaceAll]);
  Buffer := StringReplace(Buffer, '&gt;', '>' + sLineBreak, [rfReplaceAll]);

  try
    sl1 := TStringList.Create;
    sl1.Text := LerTagXML(Buffer, 'pacotes');
    for i := 0 to sl1.Count - 1 do
    begin
      if Pos('pacote cod', sl1[i]) > 0 then
      begin
        pct := CopyDeAte(sl1[i], 'desc="', '">');
      end;
      if Pos('</tabelas>', sl1[i]) > 0 then
      begin
        pct := '';
      end;
      if Pos('tabela id', sl1[i]) > 0 then
      begin
        Listou := True;
        with Tabelas.New do
        begin
          Id := CopyDeAte(sl1[i], 'id="', '" tipo');
          Tipo := CopyDeAte(sl1[i], 'tipo="', '" desc');
          Pacote := pct;
          Desc := CopyDeAte(sl1[i], 'desc="', '" versao');
          Versao := CopyDeAte(sl1[i], 'versao="', '" dtCriacao');
          dt := OnlyNumber(CopyDeAte(sl1[i], 'dtCriacao="', '" dtVersao'));
          DtCriacao := StoD(dt);
          dt := OnlyNumber(CopyDeAte(sl1[i], 'dtVersao="', '" hash'));
          DtVersao := StoD(dt);
          Hash := CopyDeAte(sl1[i], 'hash="', '" />');
        end;
      end;
    end;
  finally
    sl1.Free;
  end;
end;

function TACBrTabelasSped.Download(const aId, aVersao, aDestino: string): boolean;
var
  Dow: TACBrDownload;
begin
  Result := False;
  if not Listou then
    raise EACBrTabelasSpedxception.Create('Falta listar as tabelas');

  if Trim(aId) = '' then
    raise EACBrTabelasSpedxception.Create('Informe a Id');

  if Trim(aVersao) = '' then
    raise EACBrTabelasSpedxception.Create('Informe a Versão');

  if ExtractFileName(aDestino) = '' then
    raise EACBrTabelasSpedxception.Create('Informe o Destino com o nome do arquivo');

  try
    Dow := TACBrDownload.Create(nil);
    Dow.Protocolo := protHTTP;
    Dow.DownloadUrl := UrlDownload + '?idTabela=' + aId + '&versao=' + aVersao;
    Dow.DownloadNomeArq := aDestino;
    try
      Dow.StartDownload;
      Result := True;
    except
      Result := False;
    end;
  finally
    Dow.Free;
  end;
end;

end.
