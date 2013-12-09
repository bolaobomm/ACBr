unit pgnreRetDetalhamentoReceita;

interface

uses SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnLeitor, pgnreConversao, pgnreConfigUF;

type
  TRetInfDetalhamentoReceitaCollection = class;
  TRetInfDetalhamentoReceitaCollectionItem = class;
  TRetDetalhamentoReceita = class;

  TRetInfDetalhamentoReceitaCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TRetInfDetalhamentoReceitaCollectionItem;
    procedure SetItem(Index: Integer; Value: TRetInfDetalhamentoReceitaCollectionItem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TRetInfDetalhamentoReceitaCollectionItem;
    property Items[Index: Integer]: TRetInfDetalhamentoReceitaCollectionItem read GetItem write SetItem; default;
  end;

  TRetInfDetalhamentoReceitaCollectionItem = class(TCollectionItem)
  private
    FRetDetalhamentoReceita: TRetInfDetalhamentoReceita;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property RetDetalhamentoReceita: TRetInfDetalhamentoReceita read FRetDetalhamentoReceita write FRetDetalhamentoReceita;
  end;

  TRetDetalhamentoReceita = class(TPersistent)
  private
    FLeitor: TLeitor;
    FretDetalhamentoReceita: TRetInfDetalhamentoReceitaCollection;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: Boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property retDetalhamentoReceita: TRetInfDetalhamentoReceitaCollection read FretDetalhamentoReceita write FretDetalhamentoReceita;
  end;

implementation

{ TRetDetalhamentoReceitaCollection }

function TRetInfDetalhamentoReceitaCollection.Add: TRetInfDetalhamentoReceitaCollectionItem;
begin
  Result := TRetInfDetalhamentoReceitaCollectionItem(inherited Add);
  Result.Create;
end;

constructor TRetInfDetalhamentoReceitaCollection.Create(AOwner: TPersistent);
begin
  inherited Create(TRetInfDetalhamentoReceitaCollectionItem);
end;

function TRetInfDetalhamentoReceitaCollection.GetItem(
  Index: Integer): TRetInfDetalhamentoReceitaCollectionItem;
begin
  Result := TRetInfDetalhamentoReceitaCollectionItem(inherited GetItem(Index));
end;

procedure TRetInfDetalhamentoReceitaCollection.SetItem(Index: Integer;
  Value: TRetInfDetalhamentoReceitaCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TRetDetalhamentoReceitaCollectionItem }

constructor TRetInfDetalhamentoReceitaCollectionItem.Create;
begin
  FRetDetalhamentoReceita := TRetInfDetalhamentoReceita.Create;
end;

destructor TRetInfDetalhamentoReceitaCollectionItem.Destroy;
begin
  FRetDetalhamentoReceita.Free;
  inherited;
end;

{ TRetDetalhamentosReceita }

constructor TRetDetalhamentoReceita.Create;
begin
  FLeitor := TLeitor.Create;
  FretDetalhamentoReceita := TRetInfDetalhamentoReceitaCollection.Create(Self);
end;

destructor TRetDetalhamentoReceita.Destroy;
begin
  FLeitor.Free;
  FretDetalhamentoReceita.Free;
  inherited;
end;

function TRetDetalhamentoReceita.LerXml: Boolean;
var i: Integer;
begin
  Result := False;
  try
    i := 0;
    if Leitor.rExtrai(1, 'detalhamentosReceita') <> '' then
    begin
      while Leitor.rExtrai(2, 'detalhamentoReceita', '', i + 1) <> '' do
      begin
        retDetalhamentoReceita.Add;
        retDetalhamentoReceita.Items[i].RetDetalhamentoReceita.codigo    := Leitor.rCampo(tcInt, 'codigo');
        retDetalhamentoReceita.Items[i].RetDetalhamentoReceita.descricao := Leitor.rCampo(tcStr, 'descricao');
        inc(i);
      end;

      if i = 0
       then retDetalhamentoReceita.Add;

      Result := True;       
    end;
  except
    Result := false;
  end;
end;

end.
 