{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                       R�gys Silveira                         }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
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

{******************************************************************************
|* Historico
|*
|* 15/05/2013: Primeira Versao
|*    R�gys Borges da Silveira
******************************************************************************}

{$I ACBr.inc}

unit ACBrIBPTax;

interface

uses
  {$IFDEF MSWINDOWS} Windows, {$ENDIF}
  Contnrs,  SysUtils, Variants, Classes, ACBrUtil, ACBrSocket;

type
  EACBrIBPTax = class(Exception);

  TACBrIBPTaxExporta = (exTXT, exCSV, exDSV, exXML, exHTML);

  TACBrIBPTaxTabela = (tabNCM, tabNBS, tabLC116);

  TACBrIBPTaxErroImportacao = procedure(const ALinha: String; const AErro: String) of object;

  TACBrIBPTaxRegistro = class
  private
    FTabela: TACBrIBPTaxTabela;
    FExcecao: String;
    FNCM: string;
    FAliqNacional: Double;
    FAliqImportado: Double;
    FDescricao: string;
  public
    property NCM: string read FNCM write FNCM;
    property Descricao: string read FDescricao write FDescricao;
    property Excecao: String read FExcecao write FExcecao;
    property Tabela: TACBrIBPTaxTabela read FTabela write FTabela;
    property AliqNacional: Double read FAliqNacional write FAliqNacional;
    property AliqImportado: Double read FAliqImportado write FAliqImportado;
  end;

  TACBrIBPTaxRegistros = class(TObjectList)
  private
    function GetItem(Index: integer): TACBrIBPTaxRegistro;
    procedure SetItem(Index: integer; const Value: TACBrIBPTaxRegistro);
  public
    function New: TACBrIBPTaxRegistro;
    property Items[Index: integer]: TACBrIBPTaxRegistro read GetItem write SetItem; default;
  end;

  { TACBrIBPTax }

  TACBrIBPTax = class(TACBrHTTP)
  private
    FArquivo: TStringList;
    FVersaoArquivo: String;
    FURLDownload: String;
    FItens: TACBrIBPTaxRegistros;
    FOnErroImportacao: TACBrIBPTaxErroImportacao;
    procedure ExportarCSV(const AArquivo: String);
    procedure ExportarDSV(const AArquivo: String);
    procedure ExportarHTML(const AArquivo: String);
    procedure ExportarXML(const AArquivo: String);
    procedure ExportarTXT(const AArquivo: String);
    procedure PopularItens;
    procedure EventoErroImportacao(const Alinha, AErro: String);
  public
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;

    function DownloadTabela: Boolean;
    function AbrirTabela(const AFileName: TFileName): Boolean;
    procedure Exportar(const AArquivo: String; ATipo: TACBrIBPTaxExporta); overload;
    procedure Exportar(const AArquivo, ADelimitador: String; const AQuoted: Boolean); overload;
    function Procurar(const ACodigo: String; var ex: String;
      var tabela: Integer; var aliqNac, aliqImp: Double ;
      const BuscaParcial: Boolean = False): Boolean;

    property Itens: TACBrIBPTaxRegistros read FItens;
  published
    property OnErroImportacao: TACBrIBPTaxErroImportacao read FOnErroImportacao write FOnErroImportacao;
    property VersaoArquivo : String read FVersaoArquivo ;
    property URLDownload: String read FURLDownload write FURLDownload;
    property Arquivo: TStringList read FArquivo write FArquivo;
  end;

  function TabelaToString(const ATabela: TACBrIBPTaxTabela): String;
  function StringToTabela(const ATabela: String): TACBrIBPTaxTabela;

implementation

uses
  Math, StrUtils;

function TabelaToString(const ATabela: TACBrIBPTaxTabela): String;
begin
  case ATabela of
    tabNCM:   Result := '0';
    tabNBS:   Result := '1';
    tabLC116: Result := '2';
  end;
end;

function StringToTabela(const ATabela: String): TACBrIBPTaxTabela;
begin
  if ATabela = '0' then
    Result := tabNCM
  else
  if ATabela = '1' then
    Result := tabNBS
  else
  if ATabela = '2' then
    Result := tabLC116
  else
    raise EACBrIBPTax.CreateFmt('Tipo de tabela desconhecido "%s".', [ATabela]);
end;

{ TACBrIBPTaxRegistros }

function TACBrIBPTaxRegistros.GetItem(Index: integer): TACBrIBPTaxRegistro;
begin
  Result := TACBrIBPTaxRegistro(inherited Items[Index]);
end;

function TACBrIBPTaxRegistros.New: TACBrIBPTaxRegistro;
begin
  Result := TACBrIBPTaxRegistro.Create;
  Add(Result);
end;

procedure TACBrIBPTaxRegistros.SetItem(Index: integer;
  const Value: TACBrIBPTaxRegistro);
begin
  Put(Index, Value);
end;

{ TACBrIBPTax }

constructor TACBrIBPTax.Create(AOwner: TComponent);
begin
  inherited;

  FItens := TACBrIBPTaxRegistros.Create( True );
  FArquivo := TStringList.Create;
  FURLDownload := '';
  FVersaoArquivo := '';
  FOnErroImportacao := nil;
end;

destructor TACBrIBPTax.Destroy;
begin
  FItens.Free;
  FArquivo.Free;
  inherited;
end;

procedure TACBrIBPTax.PopularItens;
var
  Item: TStringList;
  I: Integer;

  procedure QuebrarLinha(const Alinha: string; const ALista: TStringList);
  var
    P, P1: PChar;
    S: string;
  const
    QuoteChar = '"';
    Delimiter = ';';
  begin
    ALista.BeginUpdate;
    try
      ALista.Clear;
      P := PChar(Alinha);

      while P^ <> #0 do
      begin
        if P^ = QuoteChar then
          S := AnsiExtractQuotedStr(P, QuoteChar)
        else
        begin
          P1 := P;
          while (P^ <> #0) and (P^ <> Delimiter) do
          {$IFDEF MSWINDOWS}
            P := CharNext(P);
          {$ELSE}
            Inc(P);
          {$ENDIF}

          SetString(S, P1, P - P1);
        end;
        ALista.Add(S);

        if P^ = Delimiter then
        begin
          P1 := P;

          {$IFDEF MSWINDOWS}
          if CharNext(P1)^ = #0 then
          {$ELSE}
          Inc(P1);
          if P1^ = #0 then
          {$ENDIF}
            ALista.Add('');

          repeat
            {$IFDEF MSWINDOWS}
            P := CharNext(P);
            {$ELSE}
            Inc(P);
            {$ENDIF}
          until not ((P^ in [#1..' ']));
        end;
      end;
    finally
      ALista.EndUpdate;
    end;
  end;

begin
  if Arquivo.Count <= 0 then
    raise EACBrIBPTax.Create('Arquivo de itens n�o foi baixado!');

  FVersaoArquivo := '';
  Itens.Clear;

  Item := TStringList.Create;
  try
    // primeira linha contem os cabecalhos de campo e vers�o do arquivo
    QuebrarLinha(Arquivo.Strings[0], Item);
    if Item.Count = 7 then
      FVersaoArquivo := Item.Strings[6];

    // proximas linhas contem os registros
    for I := 1 to Arquivo.Count - 1 do
    begin
      QuebrarLinha(Arquivo.Strings[I], Item);
      if Item.Count = 7 then
      begin
        try
          // codigo;ex;tabela;descricao;aliqNac;aliqImp;0.0.2
          with Itens.New do
          begin
            NCM           := Item.Strings[0];
            Excecao       := Item.Strings[1];
            Tabela        := TACBrIBPTaxTabela(StrToInt(Trim(Item.Strings[2])));
            Descricao     := Item.Strings[3];
            AliqNacional  := StringToFloatDef(Item.Strings[4], 0.00);
            AliqImportado := StringToFloatDef(Item.Strings[5], 0.00);
          end;
        except
          on E: Exception do
          begin
            EventoErroImportacao(Arquivo.Strings[I], E.Message);
          end;
        end;
      end
      else
      begin
        EventoErroImportacao(Arquivo.Strings[I], Format('Registro inv�lido, quantidade de colunas "%d" excede o esperado "7"!', [Item.Count]));
      end;
    end;
  finally
    Item.Free;
  end;
end;

function TACBrIBPTax.DownloadTabela: Boolean;
begin

  if Trim(FURLDownload) = '' then
    raise EACBrIBPTax.Create('URL do arquivo .csv n�o foi informado em "URLDownload!"');

  // baixar a tabela
  HTTPGet( FURLDownload );
  FArquivo.Text := RespHTTP.Text;
  Result := True;

  PopularItens;
end;

function TACBrIBPTax.AbrirTabela(const AFileName: TFileName): Boolean;
begin
  if Trim(AFileName) <> '' then
  begin
    Arquivo.LoadFromFile(AFileName);
    PopularItens;
  end
  else
  begin
    if Arquivo.Count <= 0 then
      DownloadTabela;
  end;

  Result := Itens.Count > 0;
end;

function TACBrIBPTax.Procurar(const ACodigo: String; var ex: String;
  var tabela: Integer; var aliqNac, aliqImp: Double ;
  const BuscaParcial: Boolean): Boolean;
var
  I: Integer;
  Igual: Boolean;
begin
  if Itens.Count <= 0 then
    EACBrIBPTax.Create('Tabela de itens ainda n�o foi aberta!');

  Result := False;
  for I := 0 to Itens.Count - 1 do
  begin
    if BuscaParcial then
      Igual := Pos(Trim(ACodigo), Trim(Itens[I].NCM)) > 0 //CompareText(Trim(ACodigo), Trim(Itens[I].NCM)) < 0
    else
      Igual := SameText(Trim(ACodigo), Trim(Itens[I].NCM));

    if Igual Then
     begin
       ex      := Itens[I].Excecao ;
       tabela  := Integer(Itens[I].Tabela) ;
       aliqNac := Itens[I].AliqNacional ;
       aliqImp := Itens[I].AliqImportado ;

       Result := True;
       Exit;
     end;
  end;
end;

procedure TACBrIBPTax.Exportar(const AArquivo: String; ATipo: TACBrIBPTaxExporta);
begin
  if Itens.Count <= 0 then
    EACBrIBPTax.Create('Tabela de itens ainda n�o foi aberta!');

  case ATipo of
    exTXT:  ExportarTXT(AArquivo);
    exCSV:  ExportarCSV(AArquivo);
    exDSV:  ExportarDSV(AArquivo);
    exXML:  ExportarXML(AArquivo);
    exHTML: ExportarHTML(AArquivo);
  end;
end;

procedure TACBrIBPTax.EventoErroImportacao(const Alinha, AErro: String);
begin
  if Assigned(FOnErroImportacao) then
    FOnErroImportacao(Alinha, AErro);
end;

procedure TACBrIBPTax.Exportar(const AArquivo, ADelimitador: String;
  const AQuoted: Boolean);
var
  I: Integer;
  Texto: String;

  function AddQuoted(const AValor: String): String;
  begin
    if AQuoted then
      Result := '"' + AValor + '"'
    else
      Result := AValor
  end;
begin
  if Itens.Count <= 0 then
    EACBrIBPTax.Create('Tabela de itens ainda n�o foi aberta!');

  Texto := '';
  for I := 0 to Itens.Count - 1 do
  begin
    Texto := Texto +
      AddQuoted(Itens[I].NCM) + ADelimitador +
      AddQuoted(Itens[I].Excecao) + ADelimitador +
      AddQuoted(IntToStr(Integer(Itens[I].Tabela))) + ADelimitador +
      AddQuoted(FloatToString(Itens[I].AliqNacional)) + ADelimitador +
      AddQuoted(FloatToString(Itens[I].AliqImportado)) + ADelimitador +
      AddQuoted(Itens[I].Descricao) + ADelimitador +
      sLineBreak;
  end;

  if Trim(Texto) <> '' then
    WriteToTXT(AnsiString(AArquivo), AnsiString(Texto), False, False);
end;

procedure TACBrIBPTax.ExportarTXT(const AArquivo: String);
var
  I: Integer;
  Texto: String;
begin
  if Itens.Count <= 0 then
    EACBrIBPTax.Create('Tabela de itens ainda n�o foi aberta!');

  Texto := '';
  for I := 0 to Itens.Count - 1 do
  begin
    Texto := Texto +
      PadL(Itens[I].NCM, 10) +
      PadL(Itens[I].Excecao, 2) +
      PadL(IntToStr(Integer(Itens[I].Tabela)), 1) +
      PadR(FloatToString(Itens[I].AliqNacional * 100), 4, '0') +
      PadR(FloatToString(Itens[I].AliqImportado * 100), 4, '0') +
      PadL(Itens[I].Descricao, 400) +
      sLineBreak;
  end;

  if Trim(Texto) <> '' then
    WriteToTXT(AnsiString(AArquivo), AnsiString(Texto), False, False);
end;

procedure TACBrIBPTax.ExportarCSV(const AArquivo: String);
begin
  Exportar(AArquivo, ';', True);
end;

procedure TACBrIBPTax.ExportarDSV(const AArquivo: String);
var
  I: Integer;
  Texto: String;

  function AddAspasDuplas(const ATexto: String): String;
  begin
    Result := '"' + ATexto + '"';
  end;

begin
  if Itens.Count <= 0 then
    EACBrIBPTax.Create('Tabela de itens ainda n�o foi aberta!');

  Texto := '';
  for I := 0 to Itens.Count - 1 do
  begin
    Texto := Texto +
      AddAspasDuplas(Itens[I].NCM) + ',' +
      AddAspasDuplas(Itens[I].Excecao) + ',' +
      AddAspasDuplas(IntToStr(Integer(Itens[I].Tabela))) + ',' +
      AddAspasDuplas(FloatToString(Itens[I].AliqNacional)) + ',' +
      AddAspasDuplas(FloatToString(Itens[I].AliqImportado)) + ',' +
      AddAspasDuplas(Itens[I].Descricao) +
      sLineBreak;
  end;

  if Trim(Texto) <> '' then
    WriteToTXT(AnsiString(AArquivo), AnsiString(Texto), False, False);
end;

procedure TACBrIBPTax.ExportarXML(const AArquivo: String);
var
  I: Integer;
  Texto: String;
begin
  if Itens.Count <= 0 then
    EACBrIBPTax.Create('Tabela de itens ainda n�o foi aberta!');

  Texto := '<?xml version="1.0" encoding="ISO-8859-1"?><IBPTax>';
  for I := 0 to Itens.Count - 1 do
  begin
    Texto := Texto +
      '<imposto>' +
        '<ncm>' + Itens[I].NCM + '</ncm>' +
        '<ex>' + Itens[I].Excecao + '</ex>' +
        '<tabela>' + IntToStr(Integer(Itens[I].Tabela)) + '</tabela>' +
        '<aliqNac>' + FloatToString(Itens[I].AliqNacional) + '</aliqNac>' +
        '<aliqImp>' + FloatToString(Itens[I].AliqImportado) + '</aliqImp>' +
        '<descricao>' + Itens[I].Descricao + '</descricao>' +
      '</imposto>';
  end;
  Texto := Texto + '</IBPTax>';

  if Trim(Texto) <> '' then
    WriteToTXT(AnsiString(AArquivo), AnsiString(Texto), False, True);
end;

procedure TACBrIBPTax.ExportarHTML(const AArquivo: String);
var
  I: Integer;
  Texto: String;
begin
  if Itens.Count <= 0 then
    EACBrIBPTax.Create('Tabela de itens ainda n�o foi aberta!');

  Texto :=
    '<html>' + slineBreak +
    '<head>' + slineBreak +
    '    <title>Tabela Imposto no Cupom</title>' + slineBreak +
    '    <style type="text/css">' + slineBreak +
    '        body{font-family: Arial;}' + slineBreak +
    '        th{color:white; font-size:8pt; background-color: black;}' + slineBreak +
		'        tr{font-size:8pt;}' + slineBreak +
    '        tr:nth-child(2n+1) {background-color: #DCDCDC;}' + slineBreak +
    '    </style>' + slineBreak +
    '</head>' + slineBreak +
    '<body>' + slineBreak +
    '    <table>' + slineBreak +
		'        <tr>' + slineBreak +
    '          <th>NCM</th>' + slineBreak +
    '          <th>Exce��o</th>' + slineBreak +
    '          <th>Tabela</th>' + slineBreak +
    '          <th>Aliq. Nacional</th>' + slineBreak +
    '          <th>Aliq. Importado</th>' + slineBreak +
    '          <th>Descri��o</th>' + slineBreak +
		'        </tr>' + slineBreak;

  for I := 0 to Itens.Count - 1 do
  begin
    Texto := Texto +
      '<tr>' + slineBreak +
        '<td>' + Itens[I].NCM + '</td>' + slineBreak +
        '<td>' + Itens[I].Excecao + '</td>' + slineBreak +
        '<td>' + IntToStr(Integer(Itens[I].Tabela)) + '</td>' + slineBreak +
        '<td>' + FloatToStr(Itens[I].AliqNacional) + '</td>' + slineBreak +
        '<td>' + FloatToStr(Itens[I].AliqImportado) + '</td>' + slineBreak +
        '<td>' + Itens[I].Descricao + '</td>' + slineBreak +
      '</tr>' + slineBreak;
  end;

  Texto := Texto +
    '    </table>' + slineBreak +
    '</body>' + slineBreak +
    '</html>' + slineBreak;

  if Trim(Texto) <> '' then
    WriteToTXT(AnsiString(AArquivo), AnsiString(Texto), False, True);
end;

end.
