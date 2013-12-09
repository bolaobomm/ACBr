unit pgnreConsResLoteGNRE;

interface

uses
  SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnGerador;

type
  TConsResLoteGNRE = class(TPersistent)
  private
    FGerador: TGerador;
    Fambiente: TpcnTipoAmbiente;
    FnumeroRecibo: string;
  public
    constructor Create;
    destructor Destroy; override;
    function GerarXML: boolean;
  published
    property Gerador: TGerador read FGerador write FGerador;
    property ambiente: TpcnTipoAmbiente read Fambiente write Fambiente;
    property numeroRecibo: string read FnumeroRecibo write FnumeroRecibo;
  end;

implementation

{ TConsResLoteGNRE }

constructor TConsResLoteGNRE.Create;
begin
  FGerador := TGerador.Create;
end;

destructor TConsResLoteGNRE.Destroy;
begin
  FGerador.Free;
  inherited;
end;

function TConsResLoteGNRE.GerarXML: boolean;
begin
  Gerador.ArquivoFormatoXML := '';

  Gerador.wGrupo('TConsLote_GNRE ' + NAME_SPACE_GNRE);
  Gerador.wCampo(tcStr, '', 'ambiente  ', 001, 001, 1, tpAmbToStr(FAmbiente), DSC_TPAMB);
  Gerador.wCampo(tcStr, '', 'numeroRecibo   ', 010, 010, 1, FnumeroRecibo, DSC_NREC);
  Gerador.wGrupo('/TConsLote_GNRE');

  Result := (Gerador.ListaDeAlertas.Count = 0);
end;

end.
 