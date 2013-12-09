unit pgnreRetEnvLoteGNRE;

interface

uses SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnLeitor, pgnreConversao;

type
  TTretLote_GNRE = class
  private
    FAmbiente: TpcnTipoAmbiente;
    FLeitor: TLeitor;
    Fcodigo: Integer;
    Fdescricao: string;
    Fnumero: string;
    FdataHoraRecibo: TDateTime;
    FtempoEstimadoProc: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property Ambiente: TpcnTipoAmbiente read FAmbiente write FAmbiente;
    property numero: string read Fnumero write Fnumero;
    property dataHoraRecibo: TDateTime read FdataHoraRecibo write FdataHoraRecibo;
    property tempoEstimadoProc: Integer read FtempoEstimadoProc write FtempoEstimadoProc;
    property codigo: Integer read Fcodigo write Fcodigo;
    property descricao: string read Fdescricao write Fdescricao;
  end;

implementation

{ TTretLote_GNRE }

constructor TTretLote_GNRE.Create;
begin
  FLeitor := TLeitor.Create;
end;

destructor TTretLote_GNRE.Destroy;
begin
  FLeitor.Free;
  inherited;
end;

function TTretLote_GNRE.LerXml: Boolean;
var
  ok: Boolean;
begin
  Result := False;
  try
    Leitor.Grupo := Leitor.Arquivo;
    if Leitor.rExtrai(1, 'TRetLote_GNRE') <> '' then
    begin
      FAmbiente := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'Ambiente'));
      if Leitor.rExtrai(2, 'situacaoRecepcao') <> '' then
      begin
        Fcodigo    := Leitor.rCampo(tcInt, 'codigo');
        Fdescricao := Leitor.rCampo(tcStr, 'descricao');
      end;

      if Leitor.rExtrai(2, 'recibo') <> '' then
      begin
      //       Grupo recibo - Dados do Recibo do Lote (Só é gerado se o Lote for aceito)
        Fnumero            := Leitor.rCampo(tcInt, 'numero');
        FdataHoraRecibo    := Leitor.rCampo(tcDatHor, 'dataHoraRecibo');
        FtempoEstimadoProc := Leitor.rCampo(tcInt, 'tempoEstimadoProc');
      end;

      Result := True;
    end;
  except
    Result := false;
  end;
end;

end.
