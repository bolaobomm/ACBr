unit pgnreRetTipoDocumentoOrigem;

interface

uses SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnLeitor, pgnreConversao, pgnreConfigUF;

type
  TRetInfTipoDocumentoOrigemCollection = class;
  TRetInfTipoDocumentoOrigemCollectionItem = class;
  TRetTipoDocumentoOrigem = class;

  TRetInfTipoDocumentoOrigemCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TRetInfTipoDocumentoOrigemCollectionItem;
    procedure SetItem(Index: Integer; Value: TRetInfTipoDocumentoOrigemCollectionItem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TRetInfTipoDocumentoOrigemCollectionItem;
    property Items[Index: Integer]: TRetInfTipoDocumentoOrigemCollectionItem read GetItem write SetItem; default;
  end;

  TRetInfTipoDocumentoOrigemCollectionItem = class(TCollectionItem)
  private
    FRetTipoDocumentoOrigem: TRetInfTipoDocumentoOrigem;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property RetTipoDocumentoOrigem: TRetInfTipoDocumentoOrigem read FRetTipoDocumentoOrigem write FRetTipoDocumentoOrigem;
  end;

  TRetTipoDocumentoOrigem = class(TPersistent)
  private
    FLeitor: TLeitor;
    FretTipoDocumentoOrigem: TRetInfTipoDocumentoOrigemCollection;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: Boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property retTipoDocumentoOrigem: TRetInfTipoDocumentoOrigemCollection read FretTipoDocumentoOrigem write FretTipoDocumentoOrigem;
  end;

implementation

{ TRetInfTipoDocumentoOrigemCollection }

function TRetInfTipoDocumentoOrigemCollection.Add: TRetInfTipoDocumentoOrigemCollectionItem;
begin
  Result := TRetInfTipoDocumentoOrigemCollectionItem(inherited Add);
  Result.Create;
end;

constructor TRetInfTipoDocumentoOrigemCollection.Create(
  AOwner: TPersistent);
begin
  inherited Create(TRetInfTipoDocumentoOrigemCollectionItem);
end;

function TRetInfTipoDocumentoOrigemCollection.GetItem(
  Index: Integer): TRetInfTipoDocumentoOrigemCollectionItem;
begin
  Result := TRetInfTipoDocumentoOrigemCollectionItem(inherited GetItem(Index));
end;

procedure TRetInfTipoDocumentoOrigemCollection.SetItem(Index: Integer;
  Value: TRetInfTipoDocumentoOrigemCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TRetInfTipoDocumentoOrigemCollectionItem }

constructor TRetInfTipoDocumentoOrigemCollectionItem.Create;
begin
  FRetTipoDocumentoOrigem := TRetInfTipoDocumentoOrigem.Create;
end;

destructor TRetInfTipoDocumentoOrigemCollectionItem.Destroy;
begin
  FRetTipoDocumentoOrigem.Free;
  inherited;
end;

{ TRetTipoDocumentoOrigem }

constructor TRetTipoDocumentoOrigem.Create;
begin
  FLeitor := TLeitor.Create;
  FretTipoDocumentoOrigem := TRetInfTipoDocumentoOrigemCollection.Create(Self);
end;

destructor TRetTipoDocumentoOrigem.Destroy;
begin
  FLeitor.Free;
  FretTipoDocumentoOrigem.Free;
  inherited;
end;

function TRetTipoDocumentoOrigem.LerXml: Boolean;
var i: Integer;
begin
  Result := False;
  try
    i := 0;
    if Leitor.rExtrai(1, 'tiposDocumentosOrigem') <> '' then
    begin
      while Leitor.rExtrai(2, 'tipoDocumentoOrigem', '', i + 1) <> '' do
      begin
        retTipoDocumentoOrigem.Add;
        retTipoDocumentoOrigem.Items[i].RetTipoDocumentoOrigem.codigo    := Leitor.rCampo(tcInt, 'codigo');
        retTipoDocumentoOrigem.Items[i].RetTipoDocumentoOrigem.descricao := Leitor.rCampo(tcStr, 'descricao');
        inc(i);
      end;

      if i = 0
       then retTipoDocumentoOrigem.Add;

      Result := True;
    end;
  except
    Result := false;
  end;
end;

end.
 