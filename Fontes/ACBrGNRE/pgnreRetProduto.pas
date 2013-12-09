unit pgnreRetProduto;

interface

uses SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnLeitor, pgnreConversao, pgnreConfigUF;

type
  TRetInfProdutoCollection = class;
  TRetInfProdutoCollectionItem = class;
  TRetProduto = class;

  TRetInfProdutoCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TRetInfProdutoCollectionItem;
    procedure SetItem(Index: Integer; Value: TRetInfProdutoCollectionItem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TRetInfProdutoCollectionItem;
    property Items[Index: Integer]: TRetInfProdutoCollectionItem read GetItem write SetItem; default;
  end;

  TRetInfProdutoCollectionItem = class(TCollectionItem)
  private
    FRetProduto: TRetInfProduto;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property RetProduto: TRetInfProduto read FRetProduto write FRetProduto;
  end;

  TRetProduto = class(TPersistent)
  private
    FLeitor: TLeitor;
    FretProduto: TRetInfProdutoCollection;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: Boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property retProduto: TRetInfProdutoCollection read FretProduto write FretProduto;
  end;

implementation

{ TRetInfProdutoCollection }

function TRetInfProdutoCollection.Add: TRetInfProdutoCollectionItem;
begin
  Result := TRetInfProdutoCollectionItem(inherited Add);
  Result.Create;
end;

constructor TRetInfProdutoCollection.Create(AOwner: TPersistent);
begin
  inherited Create(TRetInfProdutoCollectionItem);
end;

function TRetInfProdutoCollection.GetItem(
  Index: Integer): TRetInfProdutoCollectionItem;
begin
  Result := TRetInfProdutoCollectionItem(inherited GetItem(Index));
end;

procedure TRetInfProdutoCollection.SetItem(Index: Integer;
  Value: TRetInfProdutoCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TRetInfProdutoCollectionItem }

constructor TRetInfProdutoCollectionItem.Create;
begin
  FRetProduto := TRetInfProduto.Create;
end;

destructor TRetInfProdutoCollectionItem.Destroy;
begin
  FRetProduto.Free;
  inherited;
end;

{ TRetProduto }

constructor TRetProduto.Create;
begin
  FLeitor := TLeitor.Create;
  FretProduto := TRetInfProdutoCollection.Create(Self);
end;

destructor TRetProduto.Destroy;
begin
  FLeitor.Free;
  FretProduto.Free;
  inherited;
end;

function TRetProduto.LerXml: Boolean;
var i: Integer;
begin
  Result := False;
  try
    i := 0;
    if Leitor.rExtrai(1, 'produtos') <> '' then
    begin
      while Leitor.rExtrai(2, 'produto', '', i + 1) <> '' do
      begin
        retProduto.Add;
        retProduto.Items[i].RetProduto.codigo    := Leitor.rCampo(tcInt, 'codigo');
        retProduto.Items[i].RetProduto.descricao := Leitor.rCampo(tcStr, 'descricao');
        inc(i);
      end;

      if i = 0
       then retProduto.Add;

      Result := True;
    end;
  except
    Result := false;
  end;
end;

end.
 