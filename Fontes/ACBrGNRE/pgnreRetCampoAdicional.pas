unit pgnreRetCampoAdicional;

interface

uses SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnLeitor, pgnreConversao, pgnreConfigUF, ACBrUtil;

type
  TRetInfCampoAdicionalCollection = class;
  TRetInfCampoAdicionalCollectionItem = class;
  TRetCampoAdicional = class;

  TRetInfCampoAdicionalCollection = class(TCollection)
  private
    function GetItem(Index: Integer): TRetInfCampoAdicionalCollectionItem;
    procedure SetItem(Index: Integer; Value: TRetInfCampoAdicionalCollectionItem);
  public
    constructor Create(AOwner: TPersistent);
    function Add: TRetInfCampoAdicionalCollectionItem;
    property Items[Index: Integer]: TRetInfCampoAdicionalCollectionItem read GetItem write SetItem; default;
  end;

  TRetInfCampoAdicionalCollectionItem = class(TCollectionItem)
  private
    FRetCampoAdicional: TRetInfCampoAdicional;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  published
    property RetCampoAdicional: TRetInfCampoAdicional read FRetCampoAdicional write FRetCampoAdicional;
  end;

  TRetCampoAdicional = class(TPersistent)
  private
    FLeitor: TLeitor;
    FretCampoAdicional: TRetInfCampoAdicionalCollection;
  public
    constructor Create;
    destructor Destroy; override;
    function LerXml: Boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property retCampoAdicional: TRetInfCampoAdicionalCollection read FretCampoAdicional write FretCampoAdicional;
  end;

implementation

{ TRetInfCamposAdicionaisCollection }

function TRetInfCampoAdicionalCollection.Add: TRetInfCampoAdicionalCollectionItem;
begin
  Result := TRetInfCampoAdicionalCollectionItem(inherited Add);
  Result.Create;
end;

constructor TRetInfCampoAdicionalCollection.Create(AOwner: TPersistent);
begin
  inherited Create(TRetInfCampoAdicionalCollectionItem);
end;

function TRetInfCampoAdicionalCollection.GetItem(
  Index: Integer): TRetInfCampoAdicionalCollectionItem;
begin
  Result := TRetInfCampoAdicionalCollectionItem(inherited GetItem(Index));
end;

procedure TRetInfCampoAdicionalCollection.SetItem(Index: Integer;
  Value: TRetInfCampoAdicionalCollectionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TRetInfCamposAdicionaisCollectionItem }

constructor TRetInfCampoAdicionalCollectionItem.Create;
begin
  FRetCampoAdicional := TRetInfCampoAdicional.Create;
end;

destructor TRetInfCampoAdicionalCollectionItem.Destroy;
begin
  FRetCampoAdicional.Free;
  inherited;
end;

{ TRetCampoAdicional }

constructor TRetCampoAdicional.Create;
begin
  FLeitor := TLeitor.Create;
  FretCampoAdicional := TRetInfCampoAdicionalCollection.Create(Self);
end;

destructor TRetCampoAdicional.Destroy;
begin
  FLeitor.Free;
  FretCampoAdicional.Free;
  inherited;
end;

function TRetCampoAdicional.LerXml: Boolean;
var i: Integer;
begin
  Result := False;
  try
    i := 0;
    if Leitor.rExtrai(1, 'camposAdicionais') <> '' then
    begin
      while Leitor.rExtrai(2, 'campoAdicional', '', i + 1) <> '' do
      begin
        retCampoAdicional.Add;
        retCampoAdicional.Items[i].RetCampoAdicional.obrigatorio    := Leitor.rCampo(tcStr, 'obrigatorio');
        retCampoAdicional.Items[i].RetCampoAdicional.codigo         := StrToInt(SeparaDados(Leitor.Grupo, 'codigo'));
        retCampoAdicional.Items[i].RetCampoAdicional.tipo           := SeparaDados(Leitor.Grupo, 'tipo');
        retCampoAdicional.Items[i].RetCampoAdicional.tamanho        := Leitor.rCampo(tcInt, 'tamanho');
        retCampoAdicional.Items[i].RetCampoAdicional.casasDecimais  := Leitor.rCampo(tcInt, 'casasDecimais');
        retCampoAdicional.Items[i].RetCampoAdicional.titulo         := Leitor.rCampo(tcStr, 'titulo');
        inc(i);
      end;

      if i = 0
       then retCampoAdicional.Add;

      Result := True;
    end;
  except
    Result := false;
  end;
end;

end.
