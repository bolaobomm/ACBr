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

  TACBrIBPTaxTabela = (tabNCM, tabNBS);

  TACBrIBPTaxErroImportacao = procedure(const ALinha: String; const AErro: String) of object;

  TACBrIBPTaxRegistro = class
  private
    FTabela: TACBrIBPTaxTabela;
    FExcecao: String;
    FNCM: string;
    FDescricao: string;
    FEstadual: Double;
    FFederalNacional: Double;
    FFederalImportado: Double;
    FMunicipal: Double;
  public
    property NCM: string read FNCM write FNCM;
    property Descricao: string read FDescricao write FDescricao;
    property Excecao: String read FExcecao write FExcecao;
    property Tabela: TACBrIBPTaxTabela read FTabela write FTabela;
    property FederalNacional: Double read FFederalNacional write FFederalNacional;
    property FederalImportado: Double read FFederalImportado write FFederalImportado;
    property Estadual: Double read FEstadual write FEstadual;
    property Municipal: Double read FMunicipal write FMunicipal;
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
    FChaveArquivo: String;
    FVersaoArquivo: String;
    FURLDownload: String;
    FItens: TACBrIBPTaxRegistros;
    FVigenciaFim: TDateTime;
    FVigenciaInicio: TDateTime;
    FFonte: String;
    FOnErroImportacao: TACBrIBPTaxErroImportacao;
    procedure ExportarCSV(const AArquivo: String);
    procedure ExportarDSV(const AArquivo: String);
    procedure ExportarHTML(const AArquivo: String);
    procedure ExportarXML(const AArquivo: String);
    procedure ExportarTXT(const AArquivo: String);
    function PopularItens: Integer;
    procedure EventoErroImportacao(const Alinha, AErro: String);
  public
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;

    function DownloadTabela: Boolean;

    function AbrirTabela(const AFileName: TFileName): Boolean; overload;
    function AbrirTabela(const AConteudoArquivo: TStream): Boolean; overload;
    function AbrirTabela(const AConteudoArquivo: TStringList): Boolean; overload;
    procedure Exportar(const AArquivo: String; ATipo: TACBrIBPTaxExporta); overload;
    procedure Exportar(const AArquivo, ADelimitador: String; const AQuoted: Boolean); overload;
    function Procurar(const ACodigo: String; var ex, descricao: String;
      var tabela: Integer; var aliqFedNac, aliqFedImp, aliqEstadual,
      aliqMunicipal: Double ; const BuscaParcial: Boolean = False): Boolean;

    property Itens: TACBrIBPTaxRegistros read FItens;
  published
    property OnErroImportacao: TACBrIBPTaxErroImportacao read FOnErroImportacao write FOnErroImportacao;
    property Fonte: String read FFonte;
    property VersaoArquivo: String read FVersaoArquivo;
    property ChaveArquivo: String read FChaveArquivo;
    property VigenciaInicio: TDateTime read FVigenciaInicio;
    property VigenciaFim: TDateTime read FVigenciaFim;
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
  FFonte := '';
  FVigenciaInicio := 0;
  FVigenciaFim := 0;
  FOnErroImportacao := nil;
end;

destructor TACBrIBPTax.Destroy;
begin
  FItens.Free;
  FArquivo.Free;
  inherited;
end;

function TACBrIBPTax.PopularItens: Integer;
var
  Item: TStringList;
  I: Integer;
begin
  if Arquivo.Count <= 0 then
    raise EACBrIBPTax.Create('Arquivo de itens n�o foi baixado!');

  FVersaoArquivo := '';
  Itens.Clear;

  Item := TStringList.Create;
  try
    // primeira linha contem os cabecalhos de campo e vers�o do arquivo
    // segunda linha possui os dados do primeiro item e outros dados
    QuebrarLinha(Arquivo.Strings[1], Item);
    if Item.Count = 13 then
    begin
      FVigenciaInicio := StrToDateDef(Item.Strings[8], 0.0);
      FVigenciaFim    := StrToDateDef(Item.Strings[9], 0.0);
      FChaveArquivo   := Item.Strings[10];
      FVersaoArquivo  := Item.Strings[11];
      FFonte          := Item.Strings[12];
    end;

    // proximas linhas contem os registros
    for I := 1 to Arquivo.Count - 1 do
    begin
      QuebrarLinha(Arquivo.Strings[I], Item);
      if Item.Count = 13 then
      begin
        try
          // codigo;ex;tabela;descricao;aliqNac;aliqImp;0.0.2
          with Itens.New do
          begin
            NCM           := Item.Strings[0];
            Excecao       := Item.Strings[1];
            Tabela        := TACBrIBPTaxTabela(StrToInt(Trim(Item.Strings[2]))) ;
            Descricao     := Item.Strings[3];

            FederalNacional  := StringToFloatDef(Item.Strings[4], 0.00);
            FederalImportado := StringToFloatDef(Item.Strings[5], 0.00);
            Estadual         := StringToFloatDef(Item.Strings[6], 0.00);
            Municipal        := StringToFloatDef(Item.Strings[7], 0.00);
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

  Result := Itens.Count;
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
  // se foi passado nome do arquivo abrir do arquivo
  if Trim(AFileName) <> '' then
  begin
    if not FileExists(AFileName) then
      raise EACBrIBPTax.CreateFmt('Arquivo informado "%s" n�o encontrando!', [AFileName])
    else
      Arquivo.LoadFromFile(AFileName);

    PopularItens;
  end
  else
  begin
    // se n�o foi passado fazer o downloda da tabela utilizando o endere�o web informado
    if Arquivo.Count <= 0 then
    begin
      if Trim(URLDownload) = EmptyStr then
        raise EACBrIBPTax.Create('URL para download da tabela IBPT n�o foi informada!');

      DownloadTabela;
    end;
  end;

  Result := Itens.Count > 0;
end;

function TACBrIBPTax.AbrirTabela(const AConteudoArquivo: TStream): Boolean;
begin
  Arquivo.Clear;
  Arquivo.LoadFromStream(AConteudoArquivo);

  Result := PopularItens > 0;
end;

function TACBrIBPTax.AbrirTabela(const AConteudoArquivo: TStringList): Boolean;
begin
  if Assigned(AConteudoArquivo) then
  begin
    Arquivo.Clear;
    Arquivo.Text := AConteudoArquivo.Text;
  end
  else
    raise EFilerError.Create('TStringList n�o pode ser vazio!');

  Result := PopularItens > 0;
end;

function TACBrIBPTax.Procurar(const ACodigo: String; var ex, descricao: String;
  var tabela: Integer; var aliqFedNac, aliqFedImp, aliqEstadual, aliqMunicipal: Double ;
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
      Igual := Pos(Trim(ACodigo), Trim(Itens[I].NCM)) > 0
    else
      Igual := SameText(Trim(ACodigo), Trim(Itens[I].NCM));

    if Igual Then
    begin
     ex            := Itens[I].Excecao;
     descricao     := Itens[I].Descricao;
     tabela        := Integer(Itens[I].Tabela);
     aliqFedNac    := Itens[I].FederalNacional;
     aliqFedImp    := Itens[I].FederalImportado;
     aliqEstadual  := Itens[I].Estadual;
     aliqMunicipal := Itens[I].Municipal;

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
      AddQuoted(FloatToString(Itens[I].FederalNacional)) + ADelimitador +
      AddQuoted(FloatToString(Itens[I].FederalImportado)) + ADelimitador +
      AddQuoted(FloatToString(Itens[I].Estadual)) + ADelimitador +
      AddQuoted(FloatToString(Itens[I].Municipal)) + ADelimitador +
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
      PadR(FloatToString(Itens[I].FederalNacional * 100), 4, '0') +
      PadR(FloatToString(Itens[I].FederalImportado * 100), 4, '0') +
      PadR(FloatToString(Itens[I].Estadual * 100), 4, '0') +
      PadR(FloatToString(Itens[I].Municipal * 100), 4, '0') +
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
      AddAspasDuplas(FloatToString(Itens[I].FederalNacional)) + ',' +
      AddAspasDuplas(FloatToString(Itens[I].FederalImportado)) + ',' +
      AddAspasDuplas(FloatToString(Itens[I].Estadual)) + ',' +
      AddAspasDuplas(FloatToString(Itens[I].Municipal)) + ',' +
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
        '<aliqFedNac>' + FloatToString(Itens[I].FederalNacional) + '</aliqFedNac>' +
        '<aliqFedImp>' + FloatToString(Itens[I].FederalImportado) + '</aliqFedImp>' +
        '<aliqEst>' + FloatToString(Itens[I].Estadual) + '</aliqEst>' +
        '<aliqMun>' + FloatToString(Itens[I].Municipal) + '</aliqMun>' +
        '<descricao>' + ACBrUtil.ParseText(Itens[I].Descricao, False, False) + '</descricao>' +
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
    '          <th>Aliq. Federal Nacional</th>' + slineBreak +
    '          <th>Aliq. Federal Importado</th>' + slineBreak +
    '          <th>Aliq. Estadual</th>' + slineBreak +
    '          <th>Aliq. Municipal</th>' + slineBreak +
    '          <th>Descri��o</th>' + slineBreak +
		'        </tr>' + slineBreak;

  for I := 0 to Itens.Count - 1 do
  begin
    Texto := Texto +
      '<tr>' + slineBreak +
        '<td>' + Itens[I].NCM + '</td>' + slineBreak +
        '<td>' + Itens[I].Excecao + '</td>' + slineBreak +
        '<td>' + IntToStr(Integer(Itens[I].Tabela)) + '</td>' + slineBreak +
        '<td>' + FloatToStr(Itens[I].FederalNacional) + '</td>' + slineBreak +
        '<td>' + FloatToStr(Itens[I].FederalImportado) + '</td>' + slineBreak +
        '<td>' + FloatToStr(Itens[I].Estadual) + '</td>' + slineBreak +
        '<td>' + FloatToStr(Itens[I].Municipal) + '</td>' + slineBreak +
        '<td>' + ACBrUtil.ParseText(Itens[I].Descricao, False, False) + '</td>' + slineBreak +
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
