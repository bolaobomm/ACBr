{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:   Juliana Rodrigues Prado                       }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
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
|* 02/10/2009: Andr� Ferreira de Moraes,  Daniel Sim�es de Almeida
|*  - Esbo�o das Classes
|*
|* 01/04/2010: Juliana Rodrigues Prado Tamizou,  Daniel Sim�es de Almeida
|*  - Primeira Versao ACBrBoleto
|*  Componente desenvolvido usando como base os projetos GBBoleto, RLBoleto,
|*  FreeBoleto, OpenBoleto, JFMBoleto e outras dicas encontradas na internet
******************************************************************************}
{$I ACBr.inc}

unit ACBrBoleto;

interface
uses ACBrBase,  {Units da ACBr}
     {$IFDEF FPC}
       LResources,
     {$ENDIF}
     SysUtils, ACBrValidador,
     {$IFDEF COMPILER6_UP} Types {$ELSE} Windows {$ENDIF}
     ,Contnrs, Classes;

type
  TACBrTitulo = class;
  TACBrBoletoFCClass = class;
  TACBrCedente = class;
  TACBrBanco  = class;
  TACBrBoleto = class;

  { TACBrBancoClass }

  TACBrBancoClass = class
  private

  protected
    fpNumero: Integer;
    fpDigito: Integer;
    fpNome:   String;
    fpModulo: TACBrCalcDigito;
    fpAOwner: TACBrBanco;
    fpTamanhoMaximoNossoNum: Integer;
    function CalcularFatorVencimento(const DataVencimento: TDateTime): String; virtual;
    function CalcularDigitoCodigoBarras(const CodigoBarras: String): String; virtual;
  public
    Constructor create(AOwner: TACBrBanco);
    Destructor Destroy;

    property ACBrBanco : TACBrBanco      read fpAOwner;
    property Numero    : Integer         read fpNumero;
    property Digito    : Integer         read fpDigito;
    property Nome      : String          read fpNome;
    Property Modulo    : TACBrCalcDigito read fpModulo;
    property TamanhoMaximoNossoNum: Integer    read fpTamanhoMaximoNossoNum;

    function CalcularDigitoVerificador(const ACBrTitulo : TACBrTitulo): String; virtual;

    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; virtual;
    function MontarLinhaDigitavel(const CodigoBarras: String): String; virtual;

    function GerarRegistroHeader(NumeroRemessa : Integer): String;    Virtual; abstract;
    function GerarRegistroTransacao(ACBrTitulo : TACBrTitulo): String; Virtual; abstract;
    function GerarRegistroTrailler(ARemessa:TStringList): String;  Virtual; abstract;

    function CalcularNomeArquivoRemessa(const DirArquivo: String): String; Virtual;
  end;

  TACBrTipoBanco = (banNaoDefinido,banBradesco,banItau);

  { TACBrBanco }

  TACBrBanco = class(TComponent)
  private
    fACBrBoleto        : TACBrBoleto;
    fTipoBanco         : TACBrTipoBanco;
    fBancoClass        : TACBrBancoClass;
    function GetNome   : String;
    function GetNumero : Integer;
    function GetDigito : Integer;
    function GetTamanhoMaximoNossoNum : Integer;
    procedure SetTipoBanco ( const AValue: TACBrTipoBanco );
  public
    constructor Create( AOwner : TComponent); override;

    property ACBrBoleto : TACBrBoleto     read fACBrBoleto;
    property BancoClass : TACBrBancoClass read fBancoClass ;
    property Numero     : Integer         read GetNumero;
    property Digito     : Integer         read GetDigito;
    property Nome       : String          read GetNome;
    property TamanhoMaximoNossoNum :Integer read GetTamanhoMaximoNossoNum;

    function CalcularDigitoVerificador(const ACBrTitulo : TACBrTitulo): String;

    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String;
    function MontarLinhaDigitavel(const CodigoBarras: String): String;

    function GerarRegistroHeader(NumeroRemessa : Integer): String;
    function GerarRegistroTransacao(ACBrTitulo : TACBrTitulo): String;
    function GerarRegistroTrailler(ARemessa:TStringList): String;

    function CalcularNomeArquivoRemessa(const DirArquivo: String): String;
  published
    property TipoBanco : TACBrTipoBanco read fTipoBanco write SetTipoBanco default banNaoDefinido;
  end;

  TACBrTipoBoleto = (tbCliEmite,tbBancoEmite,tbBancoReemite,tbBancoNaoReemite);

  { TACBrCedente }

  TACBrCedente = class(TComponent)
  private
     fCodigoCedente: String;
    fNomeCedente   : String;
    fAgencia       : String;
    fAgenciaDigito : String;
    fConta         : String;
    fContaDigito   : String;
    fModalidade    : String;
    fConvenio      : String;
    fTipoBoleto    : TACBrTipoBoleto;
  public
    constructor Create( AOwner : TComponent ) ; override ;
    destructor Destroy; override;
  published
    property Nome         : String read fNomeCedente   write fNomeCedente;
    property CodigoCedente: String read fCodigoCedente write fCodigoCedente;
    property Agencia      : String read fAgencia       write fAgencia;
    property AgenciaDigito: String read fAgenciaDigito write fAgenciaDigito;
    property Conta        : String read fConta         write fConta;
    property ContaDigito  : String read fContaDigito   write fContaDigito;
    property Modalidade   : String read fModalidade    write fModalidade;
    property Convenio     : String read fConvenio      write fConvenio;
    property TipoBoleto   : TACBrTipoBoleto read fTipoBoleto    write fTipoBoleto default tbCliEmite ;
  end;

  TACBrPessoa = (pFisica,pJuridica,pOutras);

  TACBrSacado = class
  private
    fTipoPessoa  : TACBrPessoa;
    fNomeSacado  : String;
    fCNPJCPF     : String;
    fAvalista    : String;
    fLogradouro  : String;
    fNumero      : String;
    fComplemento : String;
    fBairro      : String;
    fCidade      : String;
    fUF          : String;
    fCEP         : String;
    fEmail       : String;
    fFone        : String;
  public
    property Pessoa      : TACBrPessoa read fTipoPessoa  write fTipoPessoa;
    property NomeSacado  : String  read fNomeSacado  write fNomeSacado;
    property CNPJCPF     : String  read fCNPJCPF     write fCNPJCPF;
    property Avalista    : String  read fAvalista    write fAvalista;
    property Logradouro  : String  read fLogradouro  write fLogradouro;
    property Numero      : String  read fNumero      write fNumero;
    property Complemento : String  read fComplemento write fComplemento;
    property Bairro      : String  read fBairro      write fBairro;
    property Cidade      : String  read fCidade      write fCidade;
    property UF          : String  read fUF          write fUF;
    property CEP         : String  read fCEP         write fCEP;
    property Email       : String  read fEmail       write fEmail;
    property Fone        : String  read fFone        write fFone;
  end;

  {Tipos de ocorr�ncias permitidas no arquivos remessa / retorno}
  TACBrTipoOcorrencia =
  (
    {Ocorr�ncias para arquivo remessa}
    toRemessaRegistrar,
    toRemessaBaixar,
    toRemessaDebitarEmConta,
    toRemessaConcederAbatimento,
    toRemessaCancelarAbatimento,
    toRemessaConcederDesconto,
    toRemessaCancelarDesconto,
    toRemessaAlterarVencimento,
    toRemessaProtestar,
    toRemessaCancelarIntrucaoProtestoBaixa,
    toRemessaCancelarInstrucaoProtesto,
    toRemessaDispensarJuros,
    toRemessaAlterarNomeEnderecoSacado,
    toRemessaAlterarNumeroControle,
    toRemessaOutrasOcorrencias,

    {Ocorr�ncias para arquivo retorno}
    toRetornoRegistroConfirmado,
    toRetornoRegistroRecusado,
    toRetornoComandoRecusado,
    toRetornoLiquidado,
    toRetornoLiquidadoEmCartorio,
    toRetornoLiquidadoParcialmente,
    toRetornoLiquidadoSaldoRestante,
    toRetornoLiquidadoSemRegistro,
    toRetornoLiquidadoPorConta,
    toRetornoBaixaSolicitada,
    toRetornoBaixado,
    toRetornoBaixadoPorDevolucao,
    toRetornoBaixadoFrancoPagamento,
    toRetornoBaixaPorProtesto,
    toRetornoRecebimentoInstrucaoBaixar,
    toRetornoBaixaOuLiquidacaoEstornada,
    toRetornoTituloEmSer,
    toRetornoRecebimentoInstrucaoConcederAbatimento,
    toRetornoAbatimentoConcedido,
    toRetornoRecebimentoInstrucaoCancelarAbatimento,
    toRetornoAbatimentoCancelado,
    toRetornoRecebimentoInstrucaoConcederDesconto,
    toRetornoDescontoConcedido,
    toRetornoRecebimentoInstrucaoCancelarDesconto,
    toRetornoDescontoCancelado,
    toRetornoRecebimentoInstrucaoAlterarDados,
    toRetornoDadosAlterados,
    toRetornoRecebimentoInstrucaoAlterarVencimento,
    toRetornoVencimentoAlterado,
    toRetornoAlteracaoDadosNovaEntrada,
    toRetornoAlteracaoDadosBaixa,
    toRetornoRecebimentoInstrucaoProtestar,
    toRetornoProtestado,
    toRetornoRecebimentoInstrucaoSustarProtesto,
    toRetornoProtestoSustado,
    toRetornoInstrucaoProtestoRejeitadaSustadaOuPendente,
    toRetornoDebitoEmConta,
    toRetornoRecebimentoInstrucaoAlterarNomeSacado,
    toRetornoNomeSacadoAlterado,
    toRetornoRecebimentoInstrucaoAlterarEnderecoSacado,
    toRetornoEnderecoSacadoAlterado,
    toRetornoEncaminhadoACartorio,
    toRetornoRetiradoDeCartorio,
    toRetornoRecebimentoInstrucaoDispensarJuros,
    toRetornoJurosDispensados,
    toRetornoManutencaoTituloVencido,
    toRetornoRecebimentoInstrucaoAlterarTipoCobranca,
    toRetornoTipoCobrancaAlterado,
    toRetornoDespesasProtesto,
    toRetornoDespesasSustacaoProtesto,
    toRetornoDebitoCustasAntecipadas,
    toRetornoCustasCartorioDistribuidor,
    toRetornoCustasEdital,
    toRetornoProtestoOuSustacaoEstornado,
    toRetornoDebitoTarifas,
    toRetornoAcertoDepositaria,
    toRetornoOutrasOcorrencias
  );

  { TACBrTitulo }

  TACBrTitulo = class
  private
    fInstrucao1        : String;
    fInstrucao2        : String;
    fLocalPagamento    : String;
    fPercentualMulta   : Double;
    fSeuNumero         : String;
    fVencimento        : TDateTime;
    fDataDocumento     : TDateTime;
    fNumeroDocumento   : String;
    fEspecieDoc        : String;
    fAceite            : String;
    fDataProcessamento : TDateTime;
    fNossoNumero       : String;
    fUsoBanco          : String;
    fCarteira          : String;
    fEspecieMod        : String;
    fValorDocumento    : Currency;
    fMensagem          : TStrings;
    fInstrucoes        : TStrings;
    fSacado            : TACBrSacado;

    fTipoOcorrencia                 : TACBrTipoOcorrencia;
    fOcorrenciaOriginal             : String;
    fDescricaoOcorrenciaOriginal    : String;
    fMotivoRejeicaoComando          : String;
    fDescricaoMotivoRejeicaoComando : String;

    fDataOcorrencia       : TDateTime;
    fDataCredito          : TDateTime;
    fDataAbatimento       : TDateTime;
    fDataDesconto         : TDateTime;
    fDataMoraJuros        : TDateTime;
    fDataProtesto         : TDateTime;
    fDataBaixa            : TDateTime;
    fValorDespesaCobranca : Currency;
    fValorAbatimento      : Currency;
    fValorDesconto        : Currency;
    fValorMoraJuros       : Currency;
    fValorIOF             : Currency;
    fValorOutrasDespesas  : Currency;
    fValorOutrosCreditos  : Currency;
    fValorRecebido        : Currency;
    fReferencia           : String;
    fVersao               : String;
    fACBrBoleto           : TACBrBoleto;

    procedure SetNossoNumero ( const AValue: String ) ;
   public
     constructor Create(ACBrBoleto:TACBrBoleto);
     destructor Destroy; override;

     property ACBrBoleto        : TACBrBoleto read fACBrBoleto;
     property LocalPagamento    : String      read fLocalPagamento    write fLocalPagamento;
     property Vencimento        : TDateTime   read fVencimento        write fVencimento;
     property DataDocumento     : TDateTime   read fDataDocumento     write fDataDocumento;
     property NumeroDocumento   : String      read fNumeroDocumento   write fNumeroDocumento ;
     property EspecieDoc        : String      read fEspecieDoc        write fEspecieDoc;
     property Aceite            : String      read fAceite            write fAceite;
     property DataProcessamento : TDateTime   read fDataProcessamento write fDataProcessamento;
     property NossoNumero       : String      read fNossoNumero       write SetNossoNumero;
     property UsoBanco          : String      read fUsoBanco          write fUsoBanco;
     property Carteira          : String      read fCarteira          write fCarteira;
     property EspecieMod        : String      read fEspecieMod        write fEspecieMod;
     property ValorDocumento    : Currency    read fValorDocumento    write fValorDocumento;
     property Mensagem          : TStrings    read fMensagem          write fMensagem;
     property Instrucao1        : String      read fInstrucao1        write fInstrucao1;
     property Instrucao2        : String      read fInstrucao2        write fInstrucao2;
     property Sacado            : TACBrSacado read fSacado            write fSacado;

     property TipoOcorrencia                 : TACBrTipoOcorrencia read fTipoOcorrencia  write fTipoOcorrencia default toRemessaRegistrar ;
     property OcorrenciaOriginal             : String    read fOcorrenciaOriginal  write fOcorrenciaOriginal;
     property DescricaoOcorrenciaOriginal    : String    read fDescricaoOcorrenciaOriginal  write fDescricaoOcorrenciaOriginal;
     property MotivoRejeicaoComando          : String    read fMotivoRejeicaoComando  write fMotivoRejeicaoComando;
     property DescricaoMotivoRejeicaoComando : String    read fDescricaoMotivoRejeicaoComando  write fDescricaoMotivoRejeicaoComando;
     property DataOcorrencia                 : TDateTime read fDataOcorrencia  write fDataOcorrencia;
     property DataCredito                    : TDateTime read fDataCredito  write fDataCredito;
     property DataAbatimento                 : TDateTime read fDataAbatimento  write fDataAbatimento;
     property DataDesconto                   : TDateTime read fDataDesconto  write fDataDesconto;
     property DataMoraJuros                  : TDateTime read fDataMoraJuros  write fDataMoraJuros;
     property DataProtesto                   : TDateTime read fDataProtesto  write fDataProtesto;
     property DataBaixa                      : TDateTime read fDataBaixa  write fDataBaixa;

     property ValorDespesaCobranca : Currency read fValorDespesaCobranca  write fValorDespesaCobranca;
     property ValorAbatimento      : Currency read fValorAbatimento  write fValorAbatimento;
     property ValorDesconto        : Currency read fValorDesconto  write fValorDesconto;
     property ValorMoraJuros       : Currency read fValorMoraJuros  write fValorMoraJuros;
     property ValorIOF             : Currency read fValorIOF  write fValorIOF;
     property ValorOutrasDespesas  : Currency read fValorOutrasDespesas  write fValorOutrasDespesas;
     property ValorOutrosCreditos  : Currency read fValorOutrosCreditos  write fValorOutrosCreditos;
     property ValorRecebido        : Currency read fValorRecebido  write fValorRecebido;
     property Referencia           : String   read fReferencia  write fReferencia;
     property Versao               : String   read fVersao  write fVersao;
     property SeuNumero            : String   read fSeuNumero write fSeuNumero;
     property PercentualMulta      : Double   read fPercentualMulta write fPercentualMulta;
   end;

  { TListadeBoletos }
  TListadeBoletos = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrTitulo);
    function  GetObject (Index: Integer): TACBrTitulo;
    procedure Insert (Index: Integer; Obj: TACBrTitulo);
  public
    function Add (Obj: TACBrTitulo): Integer;
    property Objects [Index: Integer]: TACBrTitulo
      read GetObject write SetObject; default;
  end;

TACBrBolLayOut = (lPadrao, lCarne, lFatura) ;

{ TACBrBoleto }
TACBrBoleto = class( TACBrComponent )
  private
    fBanco: TACBrBanco;
    fACBrBoletoFC: TACBrBoletoFCClass;
    fDirArqRemessa: String;
    fImprimirMensagemPadrao: boolean;
    fListadeBoletos : TListadeBoletos;
    fCedente        : TACBrCedente;
    fNomeArqRemessa: String;
    procedure SetACBrBoletoFC(const Value: TACBrBoletoFCClass);
    procedure SetDirArqRemessa(const AValue: String);
    procedure SetNomeArqRemessa(const AValue: String);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ListadeBoletos : TListadeBoletos read fListadeBoletos write fListadeBoletos ;

    function CriarTituloNaLista: TACBrTitulo;

    procedure Imprimir;

    procedure AdicionarMensagensPadroes(Titulo : TACBrTitulo; AStringList: TStrings);

    procedure GerarRemessa(NumeroRemessa : Integer);
  published
    property Cedente        : TACBrCedente     read fCedente                write fCedente ;
    property Banco          : TACBrBanco       read fBanco                  write fBanco;
    property NomeArqRemessa : String           read fNomeArqRemessa         write SetNomeArqRemessa;
    property DirArqRemessa  : String           read fDirArqRemessa          write SetDirArqRemessa;
    property ImprimirMensagemPadrao : Boolean  read fImprimirMensagemPadrao write fImprimirMensagemPadrao default True;
    property ACBrBoletoFC : TACBrBoletoFCClass read fACBrBoletoFC           write SetACBrBoletoFC;
  end;

{TACBrBoletoFCClass}
TACBrBoletoFCFiltro = (fiNenhum, fiPDF, fiHTML, fiRich ) ;

TACBrBoletoFCClass = class(TACBrComponent)
  private
    fDirLogo        : String;
    fFiltro: TACBrBoletoFCFiltro;
    fLayOut         : TACBrBolLayOut;
    fMostrarPreview : Boolean;
    fMostrarSetup: Boolean;
    fNomeArquivo: String;
    fNumCopias      : Integer;
    fSoftwareHouse  : String;
    function GetArqLogo: String;
    function GetDirLogo: String;
    procedure SetACBrBoleto(const Value: TACBrBoleto);
    procedure SetDirLogo(const AValue: String);
  protected
    fACBrBoleto : TACBrBoleto;
    procedure SetNumCopias(AValue: Integer);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    Constructor Create(AOwner: TComponent); override;
    procedure Imprimir; virtual;

    property ArquivoLogo    : String read GetArqLogo;
  published
    property ACBrBoleto     : TACBrBoleto     read fACBrBoleto     write SetACBrBoleto ;
    property LayOut         : TACBrBolLayOut  read fLayOut         write fLayOut         default lPadrao;
    property DirLogo        : String          read GetDirLogo      write SetDirLogo;
    property MostrarPreview : Boolean         read fMostrarPreview write fMostrarPreview default True ;
    property MostrarSetup   : Boolean         read fMostrarSetup   write fMostrarSetup   default True ;
    property NumCopias      : Integer         read fNumCopias      write SetNumCopias    default 1;
    property Filtro         : TACBrBoletoFCFiltro read fFiltro     write fFiltro         default fiNenhum ;
    property NomeArquivo    : String          read fNomeArquivo    write fNomeArquivo ;
    property SoftwareHouse  : String          read fSoftwareHouse  write fSoftwareHouse;
  end;

procedure Register;

implementation

Uses ACBrUtil, ACBrBancoBradesco, Forms,
     {$IFDEF COMPILER6_UP} StrUtils {$ELSE} ACBrD5{$ENDIF},
     Math;

{$IFNDEF FPC}
   {$R ACBrBoleto.dcr}
{$ENDIF}

procedure Register;
begin
   RegisterComponents('ACBr', [TACBrBoleto]);
end;

{ TACBrCedente }

constructor TACBrCedente.Create( AOwner : TComponent );
begin
  inherited Create(AOwner);

  fNomeCedente   := '';
  fAgencia       := '';
  fAgenciaDigito := '';
  fConta         := '';
  fContaDigito   := '';
  fModalidade    := '';
  fConvenio      := '';
  fTipoBoleto    := tbCliEmite;
end;

destructor TACBrCedente.Destroy;
begin
  inherited;
end;

procedure TACBrTitulo.SetNossoNumero ( const AValue: String ) ;
var
   Tam: Integer;
begin
   Tam := ACBrBoleto.Banco.TamanhoMaximoNossoNum;
   if Length(trim(AValue)) > Tam then
      raise Exception.Create('Tamanho M�ximo do Nosso N�mero � '+ IntToStr(Tam)+ '.');

   fNossoNumero := padR(trim(AValue),Tam,'0');
end;

{ TACBrTitulo }

constructor TACBrTitulo.Create(ACBrBoleto:TACBrBoleto);
begin
  inherited Create;

  fACBrBoleto        := ACBrBoleto;
  fLocalPagamento    := '';
  fVencimento        := 0;
  fDataDocumento     := 0;
  fNumeroDocumento   := '';
  fEspecieDoc        := '';
  fAceite            := '';
  fDataProcessamento := 0;
  fNossoNumero       := '';
  fUsoBanco          := '';
  fCarteira          := '';
  fEspecieMod        := '';
  fValorDocumento    := 0;
  fMensagem          := TStringList.Create;
  fInstrucoes        := TStringList.Create;
  fSacado            := TACBrSacado.Create;
  fTipoOcorrencia                 := toRemessaRegistrar;
  fOcorrenciaOriginal             := '';
  fDescricaoOcorrenciaOriginal    := '';
  fMotivoRejeicaoComando          := '';
  fDescricaoMotivoRejeicaoComando := '';

  fDataOcorrencia       := 0;
  fDataCredito          := 0;
  fDataAbatimento       := 0;
  fDataDesconto         := 0;
  fDataMoraJuros        := 0;
  fDataProtesto         := 0;
  fDataBaixa            := 0;
  fValorDespesaCobranca := 0;
  fValorAbatimento      := 0;
  fValorDesconto        := 0;
  fValorMoraJuros       := 0;
  fValorIOF             := 0;
  fValorOutrasDespesas  := 0;
  fValorOutrosCreditos  := 0;
  fValorRecebido        := 0;
  fReferencia           := '';
  fVersao               := '';
end;

destructor TACBrTitulo.Destroy;
begin
  fMensagem.Free;
  fSacado.Free;
  fInstrucoes.Free;
  inherited;
end;

procedure TACBrBoleto.SetACBrBoletoFC ( const Value: TACBrBoletoFCClass ) ;
Var OldValue: TACBrBoletoFCClass;
begin
  if Value <> fACBrBoletoFC then
  begin
     if Assigned(fACBrBoletoFC) then
        fACBrBoletoFC.RemoveFreeNotification(Self);

     OldValue      := fACBrBoletoFC ;   // Usa outra variavel para evitar Loop Infinito
     fACBrBoletoFC := Value;            // na remo��o da associa��o dos componentes

     if Assigned(OldValue) then
        if Assigned(OldValue.ACBrBoleto) then
           OldValue.ACBrBoleto := nil ;

     if Value <> nil then
     begin
        Value.FreeNotification(self);
        Value.ACBrBoleto := self ;
     end ;
  end ;

end;

procedure TACBrBoleto.SetDirArqRemessa(const AValue: String);
begin
  fDirArqRemessa := PathWithDelim( AValue );
end;

procedure TACBrBoleto.SetNomeArqRemessa(const AValue: String);
var
  APath : AnsiString;
begin
  if fNomeArqRemessa = AValue then
     exit;

  fNomeArqRemessa := ExtractFileName( AValue );
  APath           := ExtractFilePath( AValue );

  if APath <> '' then
     DirArqRemessa := APath;
end;

procedure TACBrBoleto.Notification ( AComponent: TComponent;
   Operation: TOperation ) ;
begin
   inherited Notification ( AComponent, Operation ) ;

   if (Operation = opRemove) and (fACBrBoletoFC <> nil) and (AComponent is TACBrBoletoFCClass) then
     fACBrBoletoFC := nil ;
end;

{ TACBrBoleto }

constructor TACBrBoleto.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fACBrBoletoFC           := nil;
  fImprimirMensagemPadrao := True;

  fListadeBoletos := TListadeBoletos.Create(true);

  fCedente      := TACBrCedente.Create(self);
  fCedente.Name := 'Cedente';
  {$IFDEF COMPILER6_UP}
   fCedente.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}

  fBanco := TACBrBanco.Create(self);
  fBanco.Name := 'Banco';
  {$IFDEF COMPILER6_UP}
   fBanco.SetSubComponent(True);   // Ajustando como SubComponente para aparecer no ObjectInspector
  {$ENDIF}
end;

destructor TACBrBoleto.Destroy;
begin
  fListadeBoletos.Free;
  fCedente.Free;
  fBanco.Free;

  inherited;
end;

function TACBrBoleto.CriarTituloNaLista: TACBrTitulo;
var
   I : Integer;
begin
   I      := fListadeBoletos.Add(TACBrTitulo.Create(self));
   Result := fListadeBoletos[I];
end;

Procedure TACBrBoleto.Imprimir;
begin
  if not Assigned(ACBrBoletoFC) then
     raise Exception.Create( 'Nenhum componente "ACBrBoletoFC" associado' ) ;

  ACBrBoletoFC.Imprimir;
end;

Procedure TACBrBoleto.AdicionarMensagensPadroes( Titulo : TACBrTitulo; AStringList: TStrings );
begin
   if not ImprimirMensagemPadrao  then
      exit;

   with Titulo do
   begin
      if DataProtesto <> 0 then
         AStringList.Add('Protestar em ' + FormatDateTime('dd/mm/yyyy',DataProtesto));

      if ValorAbatimento <> 0 then
      begin
         if DataAbatimento <> 0 then
            AStringList.Add( 'Conceder abatimento de ' +
                             FormatCurr('R$ #,##0.00',ValorAbatimento) +
                             ' para pagamento ate ' + FormatDateTime('dd/mm/yyyy',DataAbatimento))
         else
            AStringList.Add( 'Conceder abatimento de ' +
                             FormatCurr('R$ #,##0.00',ValorAbatimento) +
                             ' para pagamento ate ' + FormatDateTime('dd/mm/yyyy',Vencimento));
      end;

      if ValorDesconto <> 0 then
      begin
         if DataDesconto <> 0 then
            AStringList.Add( 'Conceder desconto de '                       +
                             FormatCurr('R$ #,##0.00',ValorDesconto)       +
                             ' por dia de antecipa��o para pagamento at� ' +
                             FormatDateTime('dd/mm/yyyy',DataDesconto))
         else
            AStringList.Add( 'Conceder desconto de '                 +
                             FormatCurr('R$ #,##0.00',ValorDesconto) +
                             ' por dia de antecipa�ao');
      end;

      if ValorMoraJuros <> 0 then
      begin
         if DataMoraJuros <> 0 then
            AStringList.Add( 'Cobrar juros de '                               +
                             FormatCurr('R$ #,##0.00',ValorMoraJuros)         +
                             ' por dia de atraso para pagamento a partir de ' +
                             FormatDateTime('dd/mm/yyyy',DataMoraJuros))
         else
            AStringList.Add( 'Cobrar juros de '                       +
                             FormatCurr('R$ #,##0.00',ValorMoraJuros) +
                             ' por dia de atraso');
      end;
   end;
end;

{ TListadeBoletos }

procedure TListadeBoletos.SetObject ( Index: Integer; Item: TACBrTitulo ) ;
begin
   inherited SetItem (Index, Item) ;
end;

function TListadeBoletos.GetObject ( Index: Integer ) : TACBrTitulo;
begin
   Result := inherited GetItem(Index) as TACBrTitulo ;
end;

procedure TListadeBoletos.Insert ( Index: Integer; Obj: TACBrTitulo ) ;
begin
   inherited Insert(Index, Obj);
end;

function TListadeBoletos.Add ( Obj: TACBrTitulo ) : Integer;
begin
   Result := inherited Add(Obj) ;
end;

procedure TACBrBanco.SetTipoBanco ( const AValue: TACBrTipoBanco ) ;
begin
   if fTipoBanco = AValue then
      exit;

   fBancoClass.Free;

   case AValue of
      banBradesco : fBancoClass := TACBrBancoBradesco.create(Self);
      banItau     : fBancoClass := TACBrBancoClass.create(Self);
   else
      fBancoClass := TACBrBancoClass.create(Self);
   end;

   fTipoBanco := AValue;
end;

function TACBrBanco.GetNome: String;
begin
   Result := ACBrStr(fBancoClass.Nome);
end;

function TACBrBanco.GetNumero: Integer;
begin
   Result := fBancoClass.Numero;
end;

function TACBrBanco.GetDigito: Integer;
begin
   Result := fBancoClass.Digito;
end;

function TACBrBanco.GetTamanhoMaximoNossoNum: Integer;
begin
   Result := BancoClass.TamanhoMaximoNossoNum;
end;

{ TACBrBanco }

constructor TACBrBanco.Create ( AOwner: TComponent ) ;
begin
   inherited Create ( AOwner ) ;

   if not (AOwner is TACBrBoleto) then
      raise Exception.Create('Aowner deve ser do tipo TACBrBoleto');

   fACBrBoleto := TACBrBoleto(AOwner);
   fTipoBanco  := banNaoDefinido;

   fBancoClass := TACBrBancoClass.create(Self);
end;

function TACBrBanco.CalcularDigitoVerificador ( const ACBrTitulo: TACBrTitulo
   ) : String;
begin
   Result:=  BancoClass.CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBanco.MontarCodigoBarras ( const ACBrTitulo: TACBrTitulo) : String;
begin
   Result:= BancoClass.MontarCodigoBarras(ACBrTitulo);
end;

function TACBrBanco.MontarLinhaDigitavel ( const CodigoBarras:String) : String;
begin
   Result:= BancoClass.MontarLinhaDigitavel(CodigoBarras);
end;

function TACBrBanco.GerarRegistroHeader(NumeroRemessa: Integer): String;
begin
  Result :=  BancoClass.GerarRegistroHeader( NumeroRemessa );
end;

function TACBrBanco.GerarRegistroTransacao(ACBrTitulo: TACBrTitulo): String;
begin
  Result := BancoClass.GerarRegistroTransacao( ACBrTitulo );
end;

function TACBrBanco.GerarRegistroTrailler(ARemessa: TStringList): String;
begin
  Result := BancoClass.GerarRegistroTrailler( ARemessa );
end;

function TACBrBanco.CalcularNomeArquivoRemessa(const DirArquivo: String ): String;
begin
  BancoClass.CalcularNomeArquivoRemessa( DirArquivo );
end;


{ TACBrBancoClass }

function TACBrBancoClass.CalcularDigitoVerificador(const ACBrTitulo :TACBrTitulo ): String;
begin
   Result:= '';
end;

function TACBrBancoClass.CalcularFatorVencimento(const DataVencimento: TDatetime) : String;
begin
   Result := IntToStr( Trunc(DataVencimento - EncodeDate(1997,10,07)) );
end;

function TACBrBancoClass.CalcularDigitoCodigoBarras (
   const CodigoBarras: String ) : String;
begin
   Modulo.CalculoPadrao;
   Modulo.Calcular;

   Result:= IntToStr(Modulo.DigitoFinal);
end;

function TACBrBancoClass.CalcularNomeArquivoRemessa ( const DirArquivo: String) : String;
var
  Sequencia :Integer;
  Diretorio, NomeFixo, NomeArq: String;
begin
   Sequencia := 0;

   with ACBrBanco.ACBrBoleto do
   begin
      if DirArqRemessa = '' then
      begin
         Diretorio := ExtractFilePath(Application.ExeName)+'remessa'+PathDelim;

         if not DirectoryExists(Diretorio) then
            CreateDir(Diretorio);

         DirArqRemessa := Diretorio;
      end;

      if NomeArqRemessa = '' then
       begin
         NomeFixo := DirArqRemessa + 'cb' + FormatDateTime( 'ddmm', Now );

         repeat
            Inc( Sequencia );
            NomeArq := NomeFixo + IntToStrZero( Sequencia, 2 ) + '.rem'
         until not FileExists( NomeArq ) ;

         Result := NomeArq;
       end
      else
         Result := DirArqRemessa + NomeArqRemessa ;
   end;
end;

function TACBrBancoClass.MontarCodigoBarras ( const ACBrTitulo: TACBrTitulo) : String;
begin
   Result:= '';
end;

function TACBrBancoClass.MontarLinhaDigitavel (const CodigoBarras: String): String;
var
  Campo1, Campo2, Campo3, Campo4, Campo5: String;
begin
   fpModulo.FormulaDigito        := frModulo10;
   fpModulo.MultiplicadorInicial := 1;
   fpModulo.MultiplicadorFinal   := 2;
   fpModulo.MultiplicadorAtual   := 2;


  {Campo 1(C�digo Banco,Tipo de Moeda,5 primeiro digitos do Campo Livre) }
   fpModulo.Documento := IntToStr(fpNumero)+'9'+Copy(CodigoBarras,20,5);
   fpModulo.Calcular;

   Campo1 := copy( fpModulo.Documento, 1, 5) + '.' +
             copy( fpModulo.Documento, 6, 4) +
             IntToStr( fpModulo.DigitoFinal );

  {Campo 2(6� a 15� posi��es do campo Livre)}
   fpModulo.Documento := copy( CodigoBarras, 25, 10);
   fpModulo.Calcular;

   Campo2 := Copy( fpModulo.Documento, 1, 5) + '.' +
             Copy( fpModulo.Documento, 6, 5) +
             IntToStr( fpModulo.DigitoFinal );

  {Campo 3 (16� a 25� posi��es do campo Livre)}
   fpModulo.Documento := copy( CodigoBarras, 35, 10);
   fpModulo.Calcular;

   Campo3 := Copy( fpModulo.Documento, 1, 5) + '.' +
             Copy( fpModulo.Documento, 6, 5) +
             IntToStr( fpModulo.DigitoFinal );

  {Campo 4 (Digito Verificador Nosso Numero)}
   Campo4 := Copy( CodigoBarras, 5, 1);

  {Campo 5 (Fator de Vencimento e Valor do Documento)}
   Campo5 := Copy( CodigoBarras, 6, 14);

   Result := Campo1+' '+Campo2+' '+Campo3+' '+Campo4+' '+Campo5;
end;

procedure TACBrBoleto.GerarRemessa( NumeroRemessa : Integer );
var
   SLRemessa   : TStringList;
   ContTitulos : Integer;
   NomeArq     : String ;
begin
   if ListadeBoletos.Count < 1 then
      raise Exception.Create(ACBrStr('Lista de Boletos est� vazia'));

   if Trim( NomeArqRemessa ) = '' then
      NomeArq := Banco.CalcularNomeArquivoRemessa( DirArqRemessa )
   else
      NomeArq := DirArqRemessa + NomeArqRemessa;

   SLRemessa := TStringList.Create;
   try
      SLRemessa.Add( Banco.GerarRegistroHeader( NumeroRemessa ) );

      for ContTitulos:= 0 to ListadeBoletos.Count-1 do
          SLRemessa.Add( Banco.GerarRegistroTransacao( ListadeBoletos[ContTitulos] ) );

      SLRemessa.Add( Banco.GerarRegistroTrailler( SLRemessa ) );

      SLRemessa.SaveToFile( NomeArq );
   finally
      SLRemessa.Free;
   end;
end;

{ TACBrBancoClass }

constructor TACBrBancoClass.create(AOwner: TACBrBanco);
begin
   inherited create;

   fpAOwner := AOwner;
   fpNumero := 0;
   fpDigito := 0;
   fpNome   := 'N�o definido';
   fpTamanhoMaximoNossoNum := 10;
   fpModulo := TACBrCalcDigito.Create;
end;

destructor TACBrBancoClass.Destroy;
begin
   fpModulo.Free;
   Inherited Destroy;
end;

{ TACBrBoletoFCClass }

constructor TACBrBoletoFCClass.Create ( AOwner: TComponent ) ;
begin
   inherited Create ( AOwner ) ;

   fACBrBoleto     := nil;
   fLayOut         := lPadrao;
   fNumCopias      := 1;
   fMostrarPreview := True;
   fMostrarSetup   := True;
   fFiltro         := fiNenhum;
   fNomeArquivo    := '' ;
end;

procedure TACBrBoletoFCClass.Notification ( AComponent: TComponent;
   Operation: TOperation ) ;
begin
   inherited Notification ( AComponent, Operation ) ;

   if (Operation = opRemove) and (fACBrBoleto <> nil) and (AComponent is TACBrBoleto) then
      fACBrBoleto := nil ;
end;

procedure TACBrBoletoFCClass.SetACBrBoleto ( const Value: TACBrBoleto ) ;
  Var OldValue : TACBrBoleto ;
begin
  if Value <> fACBrBoleto then
  begin
     if Assigned(fACBrBoleto) then
        fACBrBoleto.RemoveFreeNotification(Self);

     OldValue    := fACBrBoleto ;   // Usa outra variavel para evitar Loop Infinito
     fACBrBoleto := Value;          // na remo��o da associa��o dos componentes

     if Assigned(OldValue) then
        if Assigned(OldValue.ACBrBoletoFC) then
           OldValue.ACBrBoletoFC := nil ;

     if Value <> nil then
     begin
        Value.FreeNotification(self);
        Value.ACBrBoletoFC := self ;
     end ;
  end ;

end;

procedure TACBrBoletoFCClass.SetDirLogo(const AValue: String);
begin
  fDirLogo := PathWithDelim( AValue );
end;

function TACBrBoletoFCClass.GetArqLogo: String;
begin
   Result := DirLogo + IntToStrZero( ACBrBoleto.Banco.Numero, 3)+'.jpg';
end;

function TACBrBoletoFCClass.GetDirLogo: String;
begin
  if fDirLogo = '' then
     Result := '.' + PathDelim + 'logos' + PathDelim
  else
     Result := fDirLogo;
end;

procedure TACBrBoletoFCClass.SetNumCopias ( AValue: Integer ) ;
begin
  fNumCopias := max( 1, Avalue);
end;

procedure TACBrBoletoFCClass.Imprimir;
begin
   if not Assigned(fACBrBoleto) then
      raise Exception.Create(ACBrStr('Componente n�o est� associado a ACBrBoleto'));

   if fACBrBoleto.ListadeBoletos.Count < 1 then
      raise Exception.Create(ACBrStr('Lista de Boletos est� vazia'));
end;

{$ifdef FPC}
initialization
   {$I ACBrBoleto.lrs}
{$endif}

end.

