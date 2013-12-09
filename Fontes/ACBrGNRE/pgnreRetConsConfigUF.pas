unit pgnreRetConsConfigUF;

interface

uses SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnLeitor, pgnreConversao,
  pgnreRetReceita, ACBrUtil;

type

  TTConfigUf = class(TPersistent)
  private
    FAmbiente: TpcnTipoAmbiente;
    FLeitor: TLeitor;
    FUf: string;
    Fcodigo: Integer;
    Fdescricao: string;
    FexigeUfFavorecida: string;
    FexigeReceita: string;
    FexigeContribuinteEmitente: string;
    FexigeDataVencimento: string;
    FexigeConvenio: string;
    FexigeDataPagamento: string;
    FInfReceita: TRetReceita;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Ambiente: TpcnTipoAmbiente read FAmbiente write FAmbiente;
    property Leitor: TLeitor read FLeitor write FLeitor;
    property Uf: string read FUf write FUf;
    property codigo: Integer read Fcodigo write Fcodigo;
    property descricao: string read Fdescricao write Fdescricao;
    property exigeUfFavorecida: string read FexigeUfFavorecida write FexigeUfFavorecida;
    property exigeReceita: string read FexigeReceita write FexigeReceita;
    property exigeContribuinteEmitente: string read FexigeContribuinteEmitente write FexigeContribuinteEmitente;
    property exigeDataVencimento: string read FexigeDataVencimento write FexigeDataVencimento;
    property exigeConvenio: string read FexigeConvenio write FexigeConvenio;
    property exigeDataPagamento: string read FexigeDataPagamento write FexigeDataPagamento;
    property InfReceita: TRetReceita read FInfReceita write FInfReceita;
  end;

implementation

{ TTConfigUf }

constructor TTConfigUf.Create;
begin
  FLeitor := TLeitor.Create;
  InfReceita := TRetReceita.Create;
end;

destructor TTConfigUf.Destroy;
begin
  FLeitor.Free;
  InfReceita.Free;
  inherited;
end;

function TTConfigUf.LerXml: boolean;
var
  ok: Boolean;
begin
  Result := False;
  try
    Leitor.Grupo := Leitor.Arquivo;

    if Leitor.rExtrai(1, 'TConfigUf') <> '' then
    begin
      (*1*)FAmbiente                    := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'ambiente'));
      (*2*)FUf                          := Leitor.rCampo(tcStr, 'Uf');
      (*4*)Fcodigo                      := Leitor.rCampo(tcInt, 'codigo');
      (*5*)Fdescricao                   := Leitor.rCampo(tcStr, 'descricao');
      (*6*)FexigeUfFavorecida           := SeparaDados(Leitor.Grupo, 'exigeUfFavorecida');
      (*7*)FexigeReceita                := SeparaDados(Leitor.Grupo, 'exigeReceita');
      (*43*)FexigeContribuinteEmitente  := SeparaDados(Leitor.Grupo, 'exigeContribuinteEmitente');
      (*44*)FexigeDataVencimento        := SeparaDados(Leitor.Grupo, 'exigeDataVencimento');
      (*45*)FexigeConvenio              := SeparaDados(Leitor.Grupo, 'exigeConvenio');
      (*45*)FexigeDataPagamento         := SeparaDados(Leitor.Grupo, 'exigeDataPagamento');

      if SameText(FexigeReceita, 'S') then
      begin
        if Leitor.rExtrai(2, 'receitas') <> '' then
        begin
          InfReceita.Leitor.Arquivo := Leitor.Grupo;
          InfReceita.LerXml;
        end;
      end;

      Result := True;
    end;
  except
    Result := false;
  end;
end;


end.
