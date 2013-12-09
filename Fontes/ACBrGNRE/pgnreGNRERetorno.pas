unit pgnreGNRERetorno;

interface

uses SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnLeitor, pgnreConversao, pgnreRetConsResLoteGNRE;

type
  TGNRERetorno = class(TPersistent)
  private
    FIdentificador: Integer;
    FSequencialGuia: Integer;
    FSituacaoGuia: string;
    FUFFavorecida: string;
    FCodReceita: Integer;
    FTipoDocEmitente: Integer;
    FDocEmitente: string;
    FRazaoSocialEmitente: string;
    FEnderecoEmitente: string;
    FMunicipioEmitente: string;
    FUFEmitente: string;
    FCEPEmitente: string;
    FTelefoneEmitente: string;
    FTipoDocDestinatario: Integer;
    FDocDestinatario: string;
    FMunicipioDestinatario: string;
    FProduto: string;
    FNumDocOrigem: string;
    FConvenio: string;
    FInfoComplementares: string;
    FDataVencimento: string;
    FDataLimitePagamento: string;
    FPeriodoReferencia: string;
    FMesAnoReferencia: string;
    FParcela: Integer;
    FValorPrincipal: Currency;
    FAtualizacaoMonetaria: Currency;
    FJuros: Currency;
    FMulta: Currency;
    FRepresentacaoNumerica: string;
    FCodigoBarras: string;
    FQtdeVias: Integer;
    FNumeroControle: string;
    FIdentificadorGuia: string;
    FGuiaGeradaContingencia: Integer;
    FReservado: string;
    FInfoCabec: TInfoCabec;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Identificador: Integer read FIdentificador write FIdentificador;
    property SequencialGuia: Integer read FSequencialGuia write FSequencialGuia;
    property SituacaoGuia: string read FSituacaoGuia write FSituacaoGuia;
    property UFFavorecida: string read FUFFavorecida write FUFFavorecida;
    property CodReceita: Integer read FCodReceita write FCodReceita;
    property TipoDocEmitente: Integer read FTipoDocEmitente write FTipoDocEmitente;
    property DocEmitente: string read FDocEmitente write FDocEmitente;
    property RazaoSocialEmitente: string read FRazaoSocialEmitente write FRazaoSocialEmitente;
    property EnderecoEmitente: string read FEnderecoEmitente write FEnderecoEmitente;
    property MunicipioEmitente: string read FMunicipioEmitente write FMunicipioEmitente;
    property UFEmitente: string read FUFEmitente write FUFEmitente;
    property CEPEmitente: string read FCEPEmitente write FCEPEmitente;
    property TelefoneEmitente: string read FTelefoneEmitente write FTelefoneEmitente;
    property TipoDocDestinatario: Integer read FTipoDocDestinatario write FTipoDocDestinatario;
    property DocDestinatario: string read FDocDestinatario write FDocDestinatario;
    property MunicipioDestinatario: string read FMunicipioDestinatario write FMunicipioDestinatario;
    property Produto: string read FProduto write FProduto;
    property NumDocOrigem: string read FNumDocOrigem write FNumDocOrigem;
    property Convenio: string read FConvenio write FConvenio;
    property InfoComplementares: string read FInfoComplementares write FInfoComplementares;
    property DataVencimento: string read FDataVencimento write FDataVencimento;
    property DataLimitePagamento: string read FDataLimitePagamento write FDataLimitePagamento;
    property PeriodoReferencia: string read FPeriodoReferencia write FPeriodoReferencia;
    property MesAnoReferencia: string read FMesAnoReferencia write FMesAnoReferencia;
    property Parcela: Integer read FParcela write FParcela;
    property ValorPrincipal: Currency read FValorPrincipal write FValorPrincipal;
    property AtualizacaoMonetaria: Currency read FAtualizacaoMonetaria write FAtualizacaoMonetaria;
    property Juros: Currency read FJuros write FJuros;
    property Multa: Currency read FMulta write FMulta;
    property RepresentacaoNumerica: string read FRepresentacaoNumerica write FRepresentacaoNumerica;
    property CodigoBarras: string read FCodigoBarras write FCodigoBarras;
    property QtdeVias: Integer read FQtdeVias write FQtdeVias;
    property NumeroControle: string read FNumeroControle write FNumeroControle;
    property IdentificadorGuia: string read FIdentificadorGuia write FIdentificadorGuia;
    property GuiaGeradaContingencia: Integer read FGuiaGeradaContingencia write FGuiaGeradaContingencia;
    property Reservado: string read FReservado write FReservado;
    property InfoCabec: TInfoCabec read FInfoCabec write FInfoCabec;
  end;

implementation

{ TGNRERetorno }

constructor TGNRERetorno.Create;
begin
  inherited Create;
  FIdentificador := 0;
  FSequencialGuia := 0;
  FSituacaoGuia := '';
  FUFFavorecida := '';
  FCodReceita := 0;
  FTipoDocEmitente := 0;
  FDocEmitente := '';
  FRazaoSocialEmitente := '';
  FEnderecoEmitente := '';
  FMunicipioEmitente := '';
  FUFEmitente := '';
  FCEPEmitente := '';
  FTelefoneEmitente := '';
  FTipoDocDestinatario := 0;
  FDocDestinatario := '';
  FMunicipioDestinatario := '';
  FProduto := '';
  FNumDocOrigem := '';
  FConvenio := '';
  FInfoComplementares := '';
  FDataVencimento := '';
  FDataLimitePagamento := '';
  FPeriodoReferencia := '';
  FMesAnoReferencia := '';
  FParcela := 0;
  FValorPrincipal := 0;
  FAtualizacaoMonetaria := 0;
  FJuros := 0;
  FMulta := 0;
  FRepresentacaoNumerica := '';
  FCodigoBarras := '';
  FQtdeVias := 0;
  FNumeroControle := '';
  FIdentificadorGuia := '';
  FGuiaGeradaContingencia := 0;
  FReservado := '';
  FInfoCabec := TInfoCabec.Create;
end;

destructor TGNRERetorno.Destroy;
begin
  FInfoCabec.Free;
  inherited Destroy;
end;

end.
