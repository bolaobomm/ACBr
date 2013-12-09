unit pgnreRetPeriodoApuracao;

interface

uses SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnLeitor, pgnreConversao, pgnreConfigUF;

type
  TRetInfPeriodoApuracaoCollection = class;
  TRetInfPeriodoApuracaoCollectionItem = class;
  TRetPeriodoApuracao = class;

  TRetInfPeriodoApuracaoCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TRetInfPeriodoApuracaoCollectionItem;
    procedure SetItem(Index: Integer; Value: TRetInfPeriodoApuracaoCollectionItem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TRetInfPeriodoApuracaoCollectionItem;
    property Items[Index: Integer]: TRetInfPeriodoApuracaoCollectionItem read GetItem write SetItem; default;
  end;

  TRetInfPeriodoApuracaoCollectionItem = class(TCollectionItem)
  private
    FRetPeriodoApuracao: TRetInfPeriodoApuracao;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property RetPeriodoApuracao: TRetInfPeriodoApuracao read FRetPeriodoApuracao write FRetPeriodoApuracao;
  end;

  TRetPeriodoApuracao = class(TPersistent)
  private
    FLeitor: TLeitor;
    FretPeriodoApuracao: TRetInfPeriodoApuracaoCollection;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: Boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property retPeriodoApuracao: TRetInfPeriodoApuracaoCollection read FretPeriodoApuracao write FretPeriodoApuracao;
  end;

implementation

{ TRetInfPeriodoApuracaoCollection }

function TRetInfPeriodoApuracaoCollection.Add: TRetInfPeriodoApuracaoCollectionItem;
begin
  Result := TRetInfPeriodoApuracaoCollectionItem(inherited Add);
  Result.Create;
end;

constructor TRetInfPeriodoApuracaoCollection.Create(AOwner: TPersistent);
begin
  inherited Create(TRetInfPeriodoApuracaoCollectionItem);
end;

function TRetInfPeriodoApuracaoCollection.GetItem(
  Index: Integer): TRetInfPeriodoApuracaoCollectionItem;
begin
  Result := TRetInfPeriodoApuracaoCollectionItem(inherited GetItem(Index));
end;

procedure TRetInfPeriodoApuracaoCollection.SetItem(Index: Integer;
  Value: TRetInfPeriodoApuracaoCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TRetInfPeriodoApuracaoCollectionItem }

constructor TRetInfPeriodoApuracaoCollectionItem.Create;
begin
  FRetPeriodoApuracao := TRetInfPeriodoApuracao.Create;
end;

destructor TRetInfPeriodoApuracaoCollectionItem.Destroy;
begin
  FRetPeriodoApuracao.Free;
  inherited;
end;


{ TRetPeriodoApuracao }

constructor TRetPeriodoApuracao.Create;
begin
  FLeitor := TLeitor.Create;
  FretPeriodoApuracao := TRetInfPeriodoApuracaoCollection.Create(Self);
end;

destructor TRetPeriodoApuracao.Destroy;
begin
  FLeitor.Free;
  FretPeriodoApuracao.Free;
  inherited;
end;

function TRetPeriodoApuracao.LerXml: Boolean;
var i: Integer;
begin
  Result := False;
  try
    i := 0;
    if Leitor.rExtrai(1, 'periodosApuracao') <> '' then
    begin
      while Leitor.rExtrai(2, 'periodoApuracao', '', i + 1) <> '' do
      begin
        retPeriodoApuracao.Add;
        retPeriodoApuracao.Items[i].RetPeriodoApuracao.codigo    := Leitor.rCampo(tcInt, 'codigo');
        retPeriodoApuracao.Items[i].RetPeriodoApuracao.descricao := Leitor.rCampo(tcStr, 'descricao');
        inc(i);
      end;

      if i = 0
       then retPeriodoApuracao.Add;

      Result := True;
    end;
  except
    Result := false;
  end;
end;

end.
