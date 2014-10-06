{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emissão de Nota Fiscal}
{ eletrônica - NFe - http://www.nfe.fazenda.gov.br                             }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       André Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 16/12/2008: Wemerson Souto
|*  - Doação do componente para o Projeto ACBr
|* 09/04/2012: Italo
|*  - Incluído envio de evento
|* 17/07/2012: Italo
|*  - Incluído Consulta de NFe pelo Destinatário
|* 18/07/2012: Italo
|*  - Incluído Download da NFe
|* 28/09/2012: Italo
|*  - Suporte a NFe 3.0 - NFC-e
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFeWebServices;

interface

uses Classes, SysUtils,
  {$IFDEF CLX} QDialogs,{$ELSE} Dialogs,{$ENDIF}
  {$IFDEF ACBrNFeOpenSSL}
    HTTPSend,
  {$ELSE}
     {$IFDEF SoapHTTP}
     SoapHTTPClient, SOAPHTTPTrans, SOAPConst, JwaWinCrypt, WinInet, ACBrCAPICOM_TLB,
     {$ELSE}
        ACBrHTTPReqResp,
     {$ENDIF}
  {$ENDIF}     
  pcnNFe, pcnNFeW,
  pcnRetConsReciNFe, pcnRetConsCad, pcnAuxiliar, pcnConversao, pcnRetDPEC,
  pcnProcNFe, pcnRetCancNFe, pcnCCeNFe, pcnRetCCeNFe,
  pcnEnvEventoNFe, pcnRetEnvEventoNFe, pcnRetConsSitNFe,
  pcnConsNFeDest, pcnRetConsNFeDest,
  pcnDownloadNFe, pcnRetDownloadNFe,
  pcnAdmCSCNFCe, pcnRetAdmCSCNFCe,
  pcnDistDFeInt, pcnRetDistDFeInt,
  ACBrNFeNotasFiscais,
  ACBrNFeConfiguracoes;

type

  TWebServicesBase = Class
  private
    procedure DoNFeStatusServico;
    procedure DoNFeRecepcao;
    procedure DoNFeRetRecepcao;
    procedure DoNFeRecibo;
    procedure DoNFeConsulta;
    procedure DoNFeCancelamento;
    procedure DoNFeInutilizacao;
    procedure DoNFeConsultaCadastro;
    procedure DoNFeEnvDPEC;
    procedure DoNFeConsultaDPEC;
    procedure DoNFeCartaCorrecao;
    procedure DoNFeEnvEvento;
    procedure DoNFeConsNFeDest;
    procedure DoNFeDownloadNFe;
    procedure DoAdministrarCSCNFCe;
    procedure DoDistribuicaoDFe;
    {$IFDEF ACBrNFeOpenSSL}
       procedure ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
    {$ELSE}
       {$IFDEF SoapHTTP}
          procedure ConfiguraReqResp( ReqResp : THTTPReqResp);
          procedure OnBeforePost(const HTTPReqResp: THTTPReqResp; Data:Pointer);
       {$ELSE}
          procedure ConfiguraReqResp( ReqResp : TACBrHTTPReqResp);
       {$ENDIF}
    {$ENDIF}
     function EnviarDadosWebService(URL, SoapAction, Dados : AnsiString) : String;
  protected
    FCabMsg: WideString;
    FDadosMsg: AnsiString;
    FRetornoWS: AnsiString;
    FRetWS: AnsiString;
    FMsg: AnsiString;
    FURL: WideString;
    FConfiguracoes: TConfiguracoes;
    FACBrNFe : TComponent;
    FPathArqEnv: AnsiString;
    FPathArqResp: AnsiString;

    procedure LoadMsgEntrada;
    procedure LoadURL;
  public
    function Executar: Boolean;virtual;
    constructor Create(AOwner : TComponent); virtual;

    property CabMsg: WideString read FCabMsg;
    property DadosMsg: AnsiString read FDadosMsg;
    property RetornoWS: AnsiString read FRetornoWS;
    property RetWS: AnsiString read FRetWS;
    property Msg: AnsiString read FMsg;
    property PathArqEnv: AnsiString read FPathArqEnv;
    property PathArqResp: AnsiString read FPathArqResp;
  end;

  TNFeStatusServico = Class(TWebServicesBase)
  private
    FtpAmb : TpcnTipoAmbiente;
    FverAplic : String;
    FcStat : Integer;
    FxMotivo : String;
    FcUF : Integer;
    FdhRecbto : TDateTime;
    FTMed : Integer;
    FdhRetorno : TDateTime;
    FxObs :  String;
  public
    function Executar: Boolean; override;
    property tpAmb : TpcnTipoAmbiente read FtpAmb;
    property verAplic : String read FverAplic;
    property cStat : Integer read FcStat;
    property xMotivo : String read FxMotivo;
    property cUF : Integer read FcUF;
    property dhRecbto : TDateTime read FdhRecbto;
    property TMed : Integer read FTMed;
    property dhRetorno : TDateTime read FdhRetorno;
    property xObs :  String read FxObs;
  end;

  TNFeRecepcao = Class(TWebServicesBase)
  private
    FLote: String;
    FRecibo : String;
    FNotasFiscais : TNotasFiscais;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    FdhRecbto: TDateTime;
    FTMed: Integer;
    FSincrono: Boolean;
    function GetLote: String;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais);reintroduce;
    property Recibo: String read FRecibo;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property xMotivo: String read FxMotivo;
    property dhRecbto: TDateTime read FdhRecbto;
    property TMed: Integer read FTMed;
    property Lote: String read GetLote write FLote;
    property Sincrono: Boolean read FSincrono write FSincrono;
  end;

  TNFeRetRecepcao = Class(TWebServicesBase)
  private
    FRecibo: String;
    FProtocolo: String;
    FChaveNFe: String;
    FNotasFiscais: TNotasFiscais;
    FNFeRetorno: TRetConsReciNFe;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FcUF: Integer;
    FxMotivo: String;
    FcMsg: Integer;
    FxMsg: String;
    function Confirma(AInfProt: TProtNFeCollection): Boolean;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent; ANotasFiscais : TNotasFiscais);reintroduce;
    destructor Destroy; override;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property xMotivo: String read FxMotivo;
    property cMsg: Integer read FcMsg;
    property xMsg: String read FxMsg;
    property Recibo: String read FRecibo write FRecibo;
    property Protocolo: String read FProtocolo write FProtocolo;
    property ChaveNFe: String read FChaveNFe write FChaveNFe;
    property NFeRetorno: TRetConsReciNFe read FNFeRetorno write FNFeRetorno;
  end;

  TNFeRecibo = Class(TWebServicesBase)
  private
    FRecibo: String;
    FNFeRetorno: TRetConsReciNFe;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FxMsg: String;
    FcMsg: Integer;
  public
    function Executar: Boolean; override;
    constructor Create(AOwner : TComponent);reintroduce;
    destructor Destroy; override;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property cUF: Integer read FcUF;
    property xMsg: String read FxMsg;
    property cMsg: Integer read FcMsg;
    property Recibo: String read FRecibo write FRecibo;
    property NFeRetorno: TRetConsReciNFe read FNFeRetorno write FNFeRetorno;
  end;

  TNFeConsulta = Class(TWebServicesBase)
  private
    FNFeChave: WideString;
    FProtocolo: WideString;
    FDhRecbto: TDateTime;
    FXMotivo: WideString;
    FTpAmb : TpcnTipoAmbiente;
    FverAplic : String;
    FcStat : Integer;
    FcUF : Integer;
    FprotNFe: TProcNFe;
    FretCancNFe: TRetCancNFe;
    FprocEventoNFe: TRetEventoNFeCollection; {eventos_juaumkiko}
  public
    constructor Create(AOwner : TComponent); reintroduce;
    destructor Destroy; override;

    function Executar: Boolean;override;
    property NFeChave: WideString read FNFeChave write FNFeChave;
    property Protocolo: WideString read FProtocolo write FProtocolo;
    property DhRecbto: TDateTime read FDhRecbto write FDhRecbto;
    property XMotivo: WideString read FXMotivo write FXMotivo;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property cUF: Integer read FcUF;
    property protNFe: TProcNFe read FprotNFe write FprotNFe;
    property retCancNFe: TRetCancNFe read FretCancNFe write FretCancNFe;
    property procEventoNFe: TRetEventoNFeCollection read FprocEventoNFe write FprocEventoNFe;
  end;

  TNFeCancelamento = Class(TWebServicesBase)
  private
    FNFeChave: WideString;
    FProtocolo: WideString;
    FJustificativa: WideString;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FcUF: Integer;
    FDhRecbto: TDateTime;
    FXML_ProcCancNFe: AnsiString;
    procedure SetJustificativa(AValue: WideString);
  public
    function Executar: Boolean;override;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property cUF: Integer read FcUF;
    property DhRecbto: TDateTime read FDhRecbto;
    property NFeChave: WideString read FNFeChave write FNFeChave;
    property Protocolo: WideString read FProtocolo write FProtocolo;
    property Justificativa: WideString read FJustificativa write SetJustificativa;
    property XML_ProcCancNFe: AnsiString read FXML_ProcCancNFe write FXML_ProcCancNFe;
  end;

  TNFeInutilizacao = Class(TWebServicesBase)
  private
    FID: WideString;
    FProtocolo: string;
    FModelo: Integer;
    FSerie: Integer;
    FCNPJ: String;
    FAno: Integer;
    FNumeroInicial: Integer;
    FNumeroFinal: Integer;
    FJustificativa: WideString;
    FTpAmb: TpcnTipoAmbiente;
    FverAplic: String;
    FcStat: Integer;
    FxMotivo : String;
    FcUF: Integer;
    FdhRecbto: TDateTime;
    FXML_ProcInutNFe: AnsiString;
    procedure SetJustificativa(AValue: WideString);
  public
    function Executar: Boolean;override;
    property ID: WideString read FID write FID;
    property Protocolo: String read FProtocolo write FProtocolo;
    property Modelo: Integer read FModelo write FModelo;
    property Serie: Integer read FSerie write FSerie;
    property CNPJ: String read FCNPJ write FCNPJ;
    property Ano: Integer read FAno write FAno;
    property NumeroInicial: Integer read FNumeroInicial write FNumeroInicial;
    property NumeroFinal: Integer read FNumeroFinal write FNumeroFinal;
    property Justificativa: WideString read FJustificativa write SetJustificativa;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo : String read FxMotivo;
    property cUF: Integer read FcUF;
    property dhRecbto: TDateTime read FdhRecbto;
    property XML_ProcInutNFe: AnsiString read FXML_ProcInutNFe write FXML_ProcInutNFe;
  end;

  TNFeConsultaCadastro = Class(TWebServicesBase)
  private
    FverAplic: String;
    FcStat: Integer;
    FxMotivo: String;
    FUF: String;
    FIE: String;
    FCNPJ: String;
    FCPF: String;
    FcUF: Integer;
    FdhCons: TDateTime;
    FRetConsCad : TRetConsCad;
    procedure SetCNPJ(const Value: String);
    procedure SetCPF(const Value: String);
    procedure SetIE(const Value: String);
  public
    function Executar: Boolean;override;
    destructor Destroy; override;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property xMotivo: String read FxMotivo;
    property DhCons: TDateTime read FdhCons;
    property cUF: Integer read FcUF;
    property RetConsCad: TRetConsCad read FRetConsCad;

    property UF:   String read FUF write FUF;
    property IE:   String read FIE write SetIE;
    property CNPJ: String read FCNPJ write SetCNPJ;
    property CPF:  String read FCPF write SetCPF;
  end;

  TNFeEnvDPEC = Class(TWebServicesBase)
  private
    FId: String;
    FverAplic: String;
    FcStat: Integer;
    FTpAmb: TpcnTipoAmbiente;
    FxMotivo: String;
    FdhRegDPEC: TDateTime;
    FnRegDPEC: String;
    FNFeChave: String;
    FXML_ProcDPEC: AnsiString;
  public
    function Executar: Boolean;override;
    property ID: String read FId;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property xMotivo: String read FxMotivo;
    property DhRegDPEC: TDateTime read FdhRegDPEC;
    property nRegDPEC: String read FnRegDPEC;
    property NFeChave: String read FNFeChave;
    property XML_ProcDPEC: AnsiString read FXML_ProcDpec write FXML_ProcDpec;
  end;

  TNFeConsultaDPEC = Class(TWebServicesBase)
  private
    FverAplic: String;
    FcStat: Integer;
    FTpAmb: TpcnTipoAmbiente;
    FxMotivo: String;
    //FretDPEC: TRetDPEC;
    FnRegDPEC: String;
    FNFeChave: String;
    FdhRegDPEC: TDateTime;
    procedure SetNFeChave(const Value: String);
    procedure SetnRegDPEC(const Value: String);
  public
    function Executar: Boolean;override;
    property verAplic: String read FverAplic;
    property cStat: Integer read FcStat;
    property TpAmb: TpcnTipoAmbiente read FTpAmb;
    property xMotivo: String read FxMotivo;
    property dhRegDPEC: TDateTime read FdhRegDPEC;
    //property retDPEC: TRetDPEC read FretDPEC;

    property nRegDPEC: String read FnRegDPEC write SetnRegDPEC;
    property NFeChave: String read FNFeChave write SetNFeChave;
  end;

  {Carta de Correção}
  TNFeCartaCorrecao = Class(TWebServicesBase)
  private
    FidLote: Integer;
    Fversao: String;
    FCCe   : TCCeNFe;
    FcStat: Integer;
    FxMotivo: String;
    FTpAmb: TpcnTipoAmbiente;
    FCCeRetorno: TRetCCeNFe;
  public
    constructor Create(AOwner : TComponent; ACCe : TCCeNFe);reintroduce;
    destructor Destroy; override;
    function Executar: Boolean; override;

    property idLote: Integer               read FidLote      write FidLote;
    property versao: String                read Fversao      write Fversao;
    property cStat: Integer                read FcStat;
    property xMotivo: String               read FxMotivo;
    property TpAmb: TpcnTipoAmbiente       read FTpAmb;
    property CCeRetorno: TRetCCeNFe        read FCCeRetorno;
  end;

  {Enviar Evento}
  TNFeEnvEvento = Class(TWebServicesBase)
  private
    FidLote: Integer;
    Fversao: String;
    FEvento: TEventoNFe;
    FcStat: Integer;
    FxMotivo: String;
    FTpAmb: TpcnTipoAmbiente;
    FEventoRetorno: TRetEventoNFe;
  public
    constructor Create(AOwner : TComponent; AEvento : TEventoNFe);reintroduce;
    destructor Destroy; override;
    function Executar: Boolean; override;

    property idLote: Integer               read FidLote      write FidLote;
    property versao: String                read Fversao      write Fversao;
    property cStat: Integer                read FcStat;
    property xMotivo: String               read FxMotivo;
    property TpAmb: TpcnTipoAmbiente       read FTpAmb;
    property EventoRetorno: TRetEventoNFe  read FEventoRetorno;
  end;

  TNFeConsNFeDest = Class(TWebServicesBase)
  private
    FtpAmb: TpcnTipoAmbiente;
    FCNPJ: String;
    FindEmi: TpcnIndicadorEmissor;
    FindNFe: TpcnIndicadorNFe;
    FultNSU: String;
    FretConsNFeDest: TretConsNFeDest;
  public
    constructor Create(AOwner : TComponent);reintroduce;
    destructor Destroy; override;
    function Executar: Boolean; override;

    property tpAmb: TpcnTipoAmbiente         read FtpAmb;
    property CNPJ: String                    read FCNPJ           write FCNPJ;
    property indNFe: TpcnIndicadorNFe        read FindNFe         write FindNFe;
    property indEmi: TpcnIndicadorEmissor    read FindEmi         write FindEmi;
    property ultNSU: String                  read FultNSU         write FultNSU;
    property retConsNFeDest: TretConsNFeDest read FretConsNFeDest write FretConsNFeDest;
  end;

  TNFeDownloadNFe = Class(TWebServicesBase)
  private
    FtpAmb: TpcnTipoAmbiente;
    FCNPJ: String;
    FDownload: TDownLoadNFe;
    FretDownloadNFe: TretDownloadNFe;
  public
    constructor Create(AOwner : TComponent; ADownload : TDownloadNFe); reintroduce;
    destructor Destroy; override;
    function Executar: Boolean; override;

    property tpAmb: TpcnTipoAmbiente        read FtpAmb;
    property CNPJ: String                   read FCNPJ            write FCNPJ;
    property retDownloadNFe: TretDownloadNFe read FretDownloadNFe write FretDownloadNFe;
  end;

  TAdministrarCSCNFCe = Class(TWebServicesBase)
  private
    FtpAmb: TpcnTipoAmbiente;
    FRaizCNPJ: String;
    FindOp: TpcnIndOperacao;
    FIdCSC: Integer;
    FCodigoCSC: String;
    FretAdmCSCNFCe: TRetAdmCSCNFCe;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;
    function Executar: Boolean; override;

    property tpAmb: TpcnTipoAmbiente       read FtpAmb;
    property RaizCNPJ: String              read FRaizCNPJ      write FRaizCNPJ;
    property indOP: TpcnIndOperacao        read FindOP         write FindOP;
    property idCsc: Integer                read FidCsc         write FidCsc;
    property codigoCsc: String             read FcodigoCsc     write FcodigoCsc;
    property retAdmCSCNFCe: TRetAdmCSCNFCe read FretAdmCSCNFCe write FretAdmCSCNFCe;
  end;

  TDistribuicaoDFe = Class(TWebServicesBase)
  private
    FtpAmb: TpcnTipoAmbiente;
    FcUFAutor: Integer;
    FCNPJCPF: String;
    FultNSU: String;
    FNSU: String;
    FretDistDFeInt: TretDistDFeInt;
  public
    constructor Create(AOwner: TComponent);reintroduce;
    destructor Destroy; override;
    function Executar: Boolean; override;

    property tpAmb: TpcnTipoAmbiente       read FtpAmb;
    property cUFAutor: Integer             read FcUFAutor      write FcUFAutor;
    property CNPJCPF: String               read FCNPJCPF       write FCNPJCPF;
    property ultNSU: String                read FultNSU        write FultNSU;
    property NSU: String                   read FNSU           write FNSU;
    property retDistDFeInt: TretDistDFeInt read FretDistDFeInt write FretDistDFeInt;
  end;  

  TNFeEnvioWebService = Class(TWebServicesBase)
  private
    FXMLEnvio: String;
    FURLEnvio: String;
    FSoapActionEnvio: String;
  public
    function Executar: Boolean; override;
    property XMLEnvio: String read FXMLEnvio write FXMLEnvio;
    property URLEnvio: String read FURLEnvio write FURLEnvio;
    property SoapActionEnvio: String read FSoapActionEnvio write FSoapActionEnvio;
  end;

  TWebServices = Class(TWebServicesBase)
  private
    FACBrNFe : TComponent;
    FStatusServico: TNFeStatusServico;
    FEnviar: TNFeRecepcao;
    FRetorno: TNFeRetRecepcao;
    FRecibo: TNFeRecibo;
    FConsulta: TNFeConsulta;
    FCancelamento: TNFeCancelamento;
    FInutilizacao: TNFeInutilizacao;
    FConsultaCadastro: TNFeConsultaCadastro;
    FEnviaDPEC: TNFeEnvDPEC;
    FConsultaDPEC: TNFeConsultaDPEC;
    FCartaCorrecao: TNFeCartaCorrecao;
    FEnvEvento: TNFeEnvEvento;
    FConsNFeDest: TNFeConsNFeDest;
    FDownloadNFe: TNFeDownloadNFe;
    FAdministrarCSCNFCe: TAdministrarCSCNFCe;
    FDistribuicaoDFe: TDistribuicaoDFe;    
    FEnvioWebService: TNFeEnvioWebService;
  public
    constructor Create(AFNotaFiscalEletronica: TComponent);reintroduce;
    destructor Destroy; override;
    function Envia(ALote: Integer; const ASincrono: Boolean = False): Boolean; overload;
    function Envia(ALote: String; const ASincrono: Boolean = False): Boolean; overload;
    procedure Cancela(AJustificativa: String);
    procedure Inutiliza(CNPJ, AJustificativa: String; Ano, Modelo, Serie, NumeroInicial, NumeroFinal : Integer);
  //published
    property ACBrNFe: TComponent read FACBrNFe write FACBrNFe;
    property StatusServico: TNFeStatusServico read FStatusServico write FStatusServico;
    property Enviar: TNFeRecepcao read FEnviar write FEnviar;
    property Retorno: TNFeRetRecepcao read FRetorno write FRetorno;
    property Recibo: TNFeRecibo read FRecibo write FRecibo;
    property Consulta: TNFeConsulta read FConsulta write FConsulta;
    property Cancelamento: TNFeCancelamento read FCancelamento write FCancelamento;
    property Inutilizacao: TNFeInutilizacao read FInutilizacao write FInutilizacao;
    property ConsultaCadastro: TNFeConsultaCadastro read FConsultaCadastro write FConsultaCadastro;
    property EnviarDPEC: TNFeEnvDPEC read FEnviaDPEC write FEnviaDPEC;
    property ConsultaDPEC: TNFeConsultaDPEC read FConsultaDPEC write FConsultaDPEC;
    property CartaCorrecao: TNFeCartaCorrecao read FCartaCorrecao write FCartaCorrecao;
    property EnvEvento: TNFeEnvEvento read FEnvEvento write FEnvEvento;
    property ConsNFeDest: TNFeConsNFeDest read FConsNFeDest write FConsNFeDest;
    property DownloadNFe: TNFeDownloadNFe read FDownloadNFe write FDownloadNFe;
    property AdministrarCSCNFCe: TAdministrarCSCNFCe read FAdministrarCSCNFCe write FAdministrarCSCNFCe;
    property DistribuicaoDFe: TDistribuicaoDFe       read FDistribuicaoDFe    write FDistribuicaoDFe;    
    property EnvioWebService: TNFeEnvioWebService read FEnvioWebService write FEnvioWebService;
  end;

implementation

uses {$IFDEF ACBrNFeOpenSSL}
        ssl_openssl,
     {$ENDIF}
     ACBrUtil, ACBrNFeUtil, ACBrNFe, ACBrDFeUtil,
     pcnGerador, pcnCabecalho,
     pcnConsStatServ, pcnRetConsStatServ,
     pcnCancNFe, pcnConsSitNFe,
     pcnInutNFe, pcnRetInutNFe,
     pcnRetEnvNFe, pcnConsReciNFe ,
     pcnConsCad,
     pcnNFeR, pcnLeitor,
     pcnEnvDPEC, pcnConsDPEC,  pcnEventoNFe, StrUtils;

{$IFNDEF ACBrNFeOpenSSL}
const
  INTERNET_OPTION_CLIENT_CERT_CONTEXT = 84;
{$ENDIF}

{ TWebServicesBase }
constructor TWebServicesBase.Create(AOwner: TComponent);
begin
  FConfiguracoes := TConfiguracoes( TACBrNFe( AOwner ).Configuracoes );
  FACBrNFe       := TACBrNFe( AOwner );
end;

{$IFDEF ACBrNFeOpenSSL}
procedure TWebServicesBase.ConfiguraHTTP( HTTP : THTTPSend; Action : AnsiString);
begin
  if FileExists(FConfiguracoes.Certificados.Certificado) then
    HTTP.Sock.SSL.PFXfile   := FConfiguracoes.Certificados.Certificado
  else
    HTTP.Sock.SSL.PFX       := FConfiguracoes.Certificados.Certificado;

  HTTP.Sock.SSL.KeyPassword := FConfiguracoes.Certificados.Senha;

  HTTP.ProxyHost  := FConfiguracoes.WebServices.ProxyHost;
  HTTP.ProxyPort  := FConfiguracoes.WebServices.ProxyPort;
  HTTP.ProxyUser  := FConfiguracoes.WebServices.ProxyUser;
  HTTP.ProxyPass  := FConfiguracoes.WebServices.ProxyPass;

//  HTTP.Sock.RaiseExcept := True;

  if (pos('SCERECEPCAORFB',UpperCase(FURL)) <= 0) and
     (pos('SCECONSULTARFB',UpperCase(FURL)) <= 0) then
     HTTP.MimeType := 'application/soap+xml; charset=utf-8'
  else
     HTTP.MimeType := 'text/xml; charset=utf-8';

  HTTP.UserAgent := '';
  HTTP.Protocol := '1.1' ;
  HTTP.AddPortNumberToHost := False;
  HTTP.Headers.Add(Action);
end;

{$ELSE}
{$IFDEF SoapHTTP}
procedure TWebServicesBase.ConfiguraReqResp( ReqResp : THTTPReqResp);
begin
  if FConfiguracoes.WebServices.ProxyHost <> '' then
   begin
     ReqResp.Proxy        := FConfiguracoes.WebServices.ProxyHost+':'+FConfiguracoes.WebServices.ProxyPort;
     ReqResp.UserName     := FConfiguracoes.WebServices.ProxyUser;
     ReqResp.Password     := FConfiguracoes.WebServices.ProxyPass;
   end;
  ReqResp.OnBeforePost := OnBeforePost;
end;

procedure TWebServicesBase.OnBeforePost(const HTTPReqResp: THTTPReqResp;
  Data: Pointer);
var
  Cert         : ICertificate2;
  CertContext  : ICertContext;
  PCertContext : Pointer;
  ContentHeader: string;
begin
  Cert := FConfiguracoes.Certificados.GetCertificado;
  CertContext :=  Cert as ICertContext;
  CertContext.Get_CertContext(Integer(PCertContext));

  if not InternetSetOption(Data, INTERNET_OPTION_CLIENT_CERT_CONTEXT, PCertContext,SizeOf(CERT_CONTEXT)) then
   begin
     if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
        TACBrNFe( FACBrNFe ).OnGerarLog('ERRO: Erro OnBeforePost: ' + IntToStr(GetLastError));
     raise EACBrNFeException.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
   end;

   if trim(FConfiguracoes.WebServices.ProxyUser) <> '' then begin
     if not InternetSetOption(Data, INTERNET_OPTION_PROXY_USERNAME, PChar(FConfiguracoes.WebServices.ProxyUser), Length(FConfiguracoes.WebServices.ProxyUser)) then
       raise EACBrNFeException.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
   end;
   if trim(FConfiguracoes.WebServices.ProxyPass) <> '' then begin
     if not InternetSetOption(Data, INTERNET_OPTION_PROXY_PASSWORD, PChar(FConfiguracoes.WebServices.ProxyPass),Length (FConfiguracoes.WebServices.ProxyPass)) then
       raise EACBrNFeException.Create( 'Erro OnBeforePost: ' + IntToStr(GetLastError) );
   end;

  if (pos('SCERECEPCAORFB',UpperCase(FURL)) <= 0) and
     (pos('SCECONSULTARFB',UpperCase(FURL)) <= 0) then
   begin
     ContentHeader := Format(ContentTypeTemplate, ['application/soap+xml; charset=utf-8']);
     HttpAddRequestHeaders(Data, PChar(ContentHeader), Length(ContentHeader), HTTP_ADDREQ_FLAG_REPLACE);
   end;
  HTTPReqResp.CheckContentType;
//  HTTPReqResp.ConnectTimeout := 20000;
end;
{$ELSE}
procedure TWebServicesBase.ConfiguraReqResp( ReqResp : TACBrHTTPReqResp);
begin
  if FConfiguracoes.WebServices.ProxyHost <> '' then
   begin
     ReqResp.ProxyHost := FConfiguracoes.WebServices.ProxyHost;
     ReqResp.ProxyPort := FConfiguracoes.WebServices.ProxyPort;
     ReqResp.ProxyUser := FConfiguracoes.WebServices.ProxyUser;
     ReqResp.ProxyPass := FConfiguracoes.WebServices.ProxyPass;
   end;

  ReqResp.SetCertificate(FConfiguracoes.Certificados.GetCertificado);

  if (pos('SCERECEPCAORFB',UpperCase(FURL)) <= 0) and
     (pos('SCECONSULTARFB',UpperCase(FURL)) <= 0) then
     ReqResp.MimeType := 'application/soap+xml'
  else
     ReqResp.MimeType := 'text/xml';
end;
{$ENDIF}
{$ENDIF}

function TWebServicesBase.EnviarDadosWebService(URL, SoapAction, Dados : AnsiString) : String;
var
 RetornoWS : String;
  {$IFDEF ACBrNFeOpenSSL}
     HTTP: THTTPSend;
  {$ELSE}
     {$IFDEF SoapHTTP}
        ReqResp: THTTPReqResp;
        Stream: TMemoryStream;
        StrStream: TStringStream;
     {$ELSE}
        ReqResp: TACBrHTTPReqResp;
     {$ENDIF}   
  {$ENDIF}
begin
  {$IFDEF ACBrNFeOpenSSL}
     HTTP := THTTPSend.Create;
  {$ELSE}
     {$IFDEF SoapHTTP}
        ReqResp := THTTPReqResp.Create(nil);
        ConfiguraReqResp( ReqResp );
        ReqResp.URL := URL;
        ReqResp.UseUTF8InHeader := True;
        ReqResp.SoapAction := SoapAction;
     {$ELSE}
        ReqResp := TACBrHTTPReqResp.Create;
        ConfiguraReqResp( ReqResp );
        ReqResp.URL := URL;
        ReqResp.SoapAction := SoapAction;
     {$ENDIF}   
  {$ENDIF}
  try
     {$IFDEF ACBrNFeOpenSSL}
        HTTP.Document.WriteBuffer(Dados[1], Length(Dados));
        ConfiguraHTTP(HTTP,'SOAPAction: "' + SoapAction +'"');
        HTTP.HTTPMethod('POST', URL);
        HTTP.Document.Position := 0;
        SetLength(Dados, HTTP.Document.Size);
        HTTP.Document.ReadBuffer(Dados[1], HTTP.Document.Size);
        RetornoWS := TiraAcentos(ParseText(Dados, True));
     {$ELSE}
         {$IFDEF SoapHTTP}
            Stream := TMemoryStream.Create;
            StrStream := TStringStream.Create('');
            try
               ReqResp.Execute(Dados, Stream);
               StrStream.CopyFrom(Stream, 0);
               RetornoWS := TiraAcentos(ParseText(StrStream.DataString, True));
            finally
               StrStream.Free;
               Stream.Free;
            end;
        {$ELSE}
            ReqResp.Data := Dados;
            RetornoWS := TiraAcentos(ParseText(ReqResp.Execute, True));
        {$ENDIF}
     {$ENDIF}
   finally
     {$IFDEF ACBrNFeOpenSSL}
         HTTP.Free;
     {$ELSE}
        {$IFDEF SoapHTTP}
            ReqResp.Free;
        {$ELSE}
            ReqResp.Free; 
        {$ENDIF}
     {$ENDIF}
   end;

  Result := RetornoWS;
end;

procedure TWebServicesBase.DoNFeCancelamento;
var
  CancNFe: TcancNFe;
  ok : Boolean;
begin
  CancNFe := TcancNFe.Create;
  CancNFe.chNFe   := TNFeCancelamento(Self).NFeChave;
  CancNFe.tpAmb   := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  CancNFe.nProt   := TNFeCancelamento(Self).Protocolo;
  CancNFe.xJust   := TNFeCancelamento(Self).Justificativa;

  FConfiguracoes.Geral.ModeloDF := StrToModeloDF(ok,NotaUtil.ExtraiModeloChaveAcesso(CancNFe.chNFe));

  CancNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                 FConfiguracoes.Geral.VersaoDF,
                                 LayNfeCancelamento);

  CancNFe.GerarXML;

{$IFDEF ACBrNFeOpenSSL}
  if not(NotaUtil.Assinar(CancNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
    begin
      if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
         TACBrNFe( FACBrNFe ).OnGerarLog('ERRO: Falha ao assinar Cancelamento Nota Fiscal Eletrônica '+LineBreak+FMsg);
      raise EACBrNFeException.Create('Falha ao assinar Cancelamento Nota Fiscal Eletrônica '+LineBreak+FMsg);
    end;
{$ELSE}
  if not(NotaUtil.Assinar(CancNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar Cancelamento Nota Fiscal Eletrônica '+LineBreak+FMsg);
       raise EACBrNFeException.Create('Falha ao assinar Cancelamento de Nota Fiscal Eletrônica '+LineBreak+FMsg);
     end;
{$ENDIF}

  if not(NotaUtil.Valida(FDadosMsg, FMsg, TACBrNFe( FACBrNFe ).Configuracoes.Geral.PathSchemas,
                         FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha na validação dos dados do cancelamento '+LineBreak+FMsg);
       raise EACBrNFeException.Create('Falha na validação dos dados do cancelamento '+LineBreak+FMsg);
     end;

  CancNFe.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoNFeCartaCorrecao;
var
  CCeNFe : TCCeNFe;
  i, f : integer;
  Eventos, Evento, Lote, EventosAssinados: AnsiString;
begin
  CCeNFe := TCCeNFe.Create;
  CCeNFe.idLote                         := TNFeCartaCorrecao(Self).idLote;
  for i := 0 to TNFeCartaCorrecao(Self).FCCe.Evento.Count-1 do
   begin
     with CCeNFe.Evento.Add do
      begin
        infEvento.cOrgao               := TNFeCartaCorrecao(Self).FCCe.Evento[i].InfEvento.cOrgao;
        infEvento.tpAmb                := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
        infEvento.CNPJ                 := TNFeCartaCorrecao(Self).FCCe.Evento[i].InfEvento.CNPJ;
        infEvento.chNFe                := TNFeCartaCorrecao(Self).FCCe.Evento[i].InfEvento.chNFe;
        infEvento.dhEvento             := TNFeCartaCorrecao(Self).FCCe.Evento[i].InfEvento.dhEvento;
        infEvento.tpEvento             := TNFeCartaCorrecao(Self).FCCe.Evento[i].InfEvento.tpEvento;
        infEvento.nSeqEvento           := TNFeCartaCorrecao(Self).FCCe.Evento[i].InfEvento.nSeqEvento;
        infEvento.versaoEvento         := TNFeCartaCorrecao(Self).FCCe.Evento[i].InfEvento.versaoEvento;
        infEvento.detEvento.versao     := TNFeCartaCorrecao(Self).FCCe.Evento[i].InfEvento.detEvento.versao;
        infEvento.detEvento.descEvento := TNFeCartaCorrecao(Self).FCCe.Evento[i].InfEvento.detEvento.descEvento;
        infEvento.detEvento.xCorrecao  := TNFeCartaCorrecao(Self).FCCe.Evento[i].InfEvento.detEvento.xCorrecao;
        infEvento.detEvento.xCondUso   := TNFeCartaCorrecao(Self).FCCe.Evento[i].InfEvento.detEvento.xCondUso;
      end;
   end;

  CCeNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                FConfiguracoes.Geral.VersaoDF,
                                LayNfeCCe);

  CCeNFe.GerarXML;

  // Separa os grupos <evento> e coloca na variável Eventos
  i       := Pos( '<evento ', CCeNFe.Gerador.ArquivoFormatoXML );
  Lote    := Copy( CCeNFe.Gerador.ArquivoFormatoXML, 1, i - 1 );
  Eventos := SeparaDados( CCeNFe.Gerador.ArquivoFormatoXML, 'envEvento' );
  i       := Pos( '<evento ', Eventos );
  Eventos := Copy( Eventos, i, length(Eventos) );

  EventosAssinados := '';

  // Realiza a assinatura para cada evento
  while Eventos <> '' do
   begin
    f := Pos( '</evento>', Eventos );

    if f > 0
     then begin
      Evento  := Copy( Eventos, 1, f + 8 );
      Eventos := Copy( Eventos, f + 9, length(Eventos) );

  {$IFDEF ACBrNFeOpenSSL}
      if not(NotaUtil.Assinar(Evento, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
         begin
           if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
              TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
           raise EACBrNFeException.Create('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
         end;
  {$ELSE}
      if not(NotaUtil.Assinar(Evento, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
         begin
           if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
              TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
           raise EACBrNFeException.Create('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
         end;
  {$ENDIF}

      EventosAssinados := EventosAssinados + FDadosMsg;
     end
     else Eventos := '';
   end;

  //Corrigido por João Henrique em 28/09/2012
  //<?xml version="1.0"?> não estava ficando no início do arquivo
  //FDadosMsg := Lote + EventosAssinados + '</envEvento>';
  f := Pos( '?>', EventosAssinados );
  if f <> 0 then
    FDadosMsg := copy(EventosAssinados,1,f+1) +
                 Lote +
                 copy(EventosAssinados,f+2,Length(EventosAssinados)) +
                 '</envEvento>'
  else
    FDadosMsg := Lote + EventosAssinados + '</envEvento>';

(*
  {$IFDEF ACBrNFeOpenSSL}
  if not(NotaUtil.Assinar(CCeNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar Carta de Correção Eletrônica '+LineBreak+FMsg);
       raise EACBrNFeException.Create('Falha ao assinar Carta de Correção Eletrônica '+LineBreak+FMsg);
     end;
  {$ELSE}
  if not(NotaUtil.Assinar(CCeNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar Carta de Correção Eletrônica '+LineBreak+FMsg);
       raise EACBrNFeException.Create('Falha ao assinar Carta de Correção Eletrônica '+LineBreak+FMsg);
     end;
  {$ENDIF}
*)

  if not(NotaUtil.Valida(FDadosMsg, FMsg, TACBrNFe( FACBrNFe ).Configuracoes.Geral.PathSchemas,
                         FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha na validação dos dados da carta de correção '+LineBreak+FMsg);
       raise EACBrNFeException.Create('Falha na validação dos dados da carta de correção '+LineBreak+FMsg);
     end;

  for i := 0 to TNFeCartaCorrecao(Self).FCCe.Evento.Count-1 do
   begin
      TNFeCartaCorrecao(Self).FCCe.Evento[i].InfEvento.id := CCeNFe.Evento[i].InfEvento.id;
   end;
  CCeNFe.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoNFeConsulta;
var
  ConsSitNFe : TConsSitNFe;
  ok : Boolean;
begin
  ConsSitNFe    := TConsSitNFe.Create;
  ConsSitNFe.TpAmb := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsSitNFe.chNFe  := TNFeConsulta(Self).NFeChave;

  FConfiguracoes.Geral.ModeloDF := StrToModeloDF(ok,NotaUtil.ExtraiModeloChaveAcesso(ConsSitNFe.chNFe));

  ConsSitNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                     FConfiguracoes.Geral.VersaoDF,
                                     LayNfeConsulta);

  ConsSitNFe.GerarXML;

  FDadosMsg := ConsSitNFe.Gerador.ArquivoFormatoXML;
  ConsSitNFe.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;  
end;

procedure TWebServicesBase.DoNFeInutilizacao;
var
  InutNFe: TinutNFe;
  ok: boolean;
begin
  InutNFe := TinutNFe.Create;
  InutNFe.tpAmb   := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  InutNFe.cUF     := FConfiguracoes.WebServices.UFCodigo;
  InutNFe.ano     := TNFeInutilizacao(Self).Ano;
  InutNFe.CNPJ    := TNFeInutilizacao(Self).CNPJ;
  InutNFe.modelo  := TNFeInutilizacao(Self).Modelo;
  InutNFe.serie   := TNFeInutilizacao(Self).Serie;
  InutNFe.nNFIni  := TNFeInutilizacao(Self).NumeroInicial;
  InutNFe.nNFFin  := TNFeInutilizacao(Self).NumeroFinal;
  InutNFe.xJust   := TNFeInutilizacao(Self).Justificativa;

 FConfiguracoes.Geral.ModeloDF := StrToModeloDF(ok,IntToStr(InutNFe.modelo));

  InutNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                 FConfiguracoes.Geral.VersaoDF,
                                 LayNfeInutilizacao);

  InutNFe.GerarXML;

{$IFDEF ACBrNFeOpenSSL}
  if not(NotaUtil.Assinar(InutNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar Inutilização Nota Fiscal Eletrônica '+LineBreak+FMsg);
       raise EACBrNFeException.Create('Falha ao assinar Inutilização Nota Fiscal Eletrônica '+LineBreak+FMsg);
     end;
{$ELSE}
  if not(NotaUtil.Assinar(InutNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar Inutilização Nota Fiscal Eletrônica '+LineBreak+FMsg);
       raise EACBrNFeException.Create('Falha ao assinar Inutilização Nota Fiscal Eletrônica '+LineBreak+FMsg);
     end;
{$ENDIF}

  TNFeInutilizacao(Self).ID := InutNFe.ID;

  InutNFe.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoNFeConsultaCadastro;
var
  ConCadNFe: TConsCad;
begin
  ConCadNFe := TConsCad.Create;
  ConCadNFe.UF     := TNFeConsultaCadastro(Self).UF;
  ConCadNFe.IE     := TNFeConsultaCadastro(Self).IE;
  ConCadNFe.CNPJ   := TNFeConsultaCadastro(Self).CNPJ;
  ConCadNFe.CPF    := TNFeConsultaCadastro(Self).CPF;

  ConCadNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                   FConfiguracoes.Geral.VersaoDF,
                                   LayNfeCadastro);

  ConCadNFe.GerarXML;

  FDadosMsg := ConCadNFe.Gerador.ArquivoFormatoXML;

  ConCadNFe.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoNFeEnvDPEC;
var
  EnvDPEC: TEnvDPEC;
  i : Integer;
begin
  EnvDPEC := TEnvDPEC.Create;

  TACBrNFe( FACBrNFe ).NotasFiscais.GerarNFe; //Gera NFe pra pegar a Chave
  if TACBrNFe( FACBrNFe ).Configuracoes.Geral.Salvar then
     TACBrNFe( FACBrNFe ).NotasFiscais.SaveToFile; // Se tiver configurado pra salvar, salva as NFes

  with EnvDPEC.infDPEC do
   begin
     ID := TACBrNFe( FACBrNFe ).NotasFiscais.Items[0].NFe.Emit.CNPJCPF;

     IdeDec.cUF   := TACBrNFe( FACBrNFe ).Configuracoes.WebServices.UFCodigo;
     ideDec.tpAmb := TACBrNFe( FACBrNFe ).Configuracoes.WebServices.Ambiente;
     ideDec.verProc := ACBRNFE_VERSAO;
     ideDec.CNPJ := TACBrNFe( FACBrNFe ).NotasFiscais.Items[0].NFe.Emit.CNPJCPF;
     ideDec.IE   := TACBrNFe( FACBrNFe ).NotasFiscais.Items[0].NFe.Emit.IE;

     for i:= 0 to TACBrNFe( FACBrNFe ).NotasFiscais.Count-1 do
      begin
        with resNFe.Add do
         begin
           chNFe   := StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.infNFe.id,'NFe','',[rfReplaceAll]);
           CNPJCPF := TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.dest.CNPJCPF;
           UF      := TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.dest.enderdEST.UF;
           vNF     := TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Total.ICMSTot.vNF;
           vICMS   := TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Total.ICMSTot.vICMS;
           vST     := TACBrNFe( FACBrNFe ).NotasFiscais.Items[I].NFe.Total.ICMSTot.vST;
         end;
      end;
   end;

  EnvDPEC.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                 FConfiguracoes.Geral.VersaoDF,
                                 LayNfeEnvDPEC);

  EnvDPEC.GerarXML;

{$IFDEF ACBrNFeOpenSSL}
  if not(NotaUtil.Assinar(EnvDPEC.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar DPEC '+LineBreak+FMsg);
       raise EACBrNFeException.Create('Falha ao assinar DPEC '+LineBreak+FMsg);
     end;
{$ELSE}
  if not(NotaUtil.Assinar(EnvDPEC.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar DPEC '+LineBreak+FMsg);
       raise EACBrNFeException.Create('Falha ao assinar DPEC '+LineBreak+FMsg);
     end;
{$ENDIF}
  EnvDPEC.Free ;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoNFeConsultaDPEC;
var
  ConsDPEC: TConsDPEC;
  ok : Boolean;
begin
  ConsDPEC := TConsDPEC.Create;
  ConsDPEC.tpAmb    := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsDPEC.verAplic := NfVersao;
  ConsDPEC.nRegDPEC := TNFeConsultaDPEC(Self).nRegDPEC;
  ConsDPEC.chNFe    := TNFeConsultaDPEC(Self).NFeChave;

  FConfiguracoes.Geral.ModeloDF := StrToModeloDF(ok,NotaUtil.ExtraiModeloChaveAcesso(ConsDPEC.chNFe));

  ConsDPEC.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                 FConfiguracoes.Geral.VersaoDF,
                                 LayNfeConsultaDPEC);

  ConsDPEC.GerarXML;

  FDadosMsg := ConsDPEC.Gerador.ArquivoFormatoXML;

  ConsDPEC.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoNFeRecepcao;
var
  i: Integer;
  vNotas: WideString;
  indSinc, Versao: String;
begin
  if (FConfiguracoes.Geral.ModeloDF = moNFCe) or (FConfiguracoes.Geral.VersaoDF = ve310) then
   begin
    if (TNFeRecepcao(Self).Sincrono) then
       indSinc := '<indSinc>1</indSinc>'
    else
       indSinc := '<indSinc>0</indSinc>';
   end
  else indSinc := '';

  if FConfiguracoes.Geral.VersaoDF = ve310 then
    Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                           FConfiguracoes.Geral.VersaoDF,
                           LayNfeAutorizacao)
  else Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                              FConfiguracoes.Geral.VersaoDF,
                              LayNfeRecepcao);

  vNotas := '';
  for i := 0 to TNFeRecepcao(Self).FNotasFiscais.Count-1 do
    vNotas := vNotas + '<NFe'+RetornarConteudoEntre(TNFeRecepcao(Self).FNotasFiscais.Items[I].XML,'<NFe','</NFe>')+'</NFe>';

  FDadosMsg := '<enviNFe xmlns="http://www.portalfiscal.inf.br/nfe" versao="' + Versao + '">'+
                '<idLote>'+TNFeRecepcao(Self).Lote+'</idLote>'+
                indSinc +
                vNotas +
               '</enviNFe>';

  if Length(FDadosMsg) > (500 * 1024) then
   begin
      if Assigned(TACBrNFe(Self.FACBrNFe).OnGerarLog) then
         TACBrNFe(Self.FACBrNFe).OnGerarLog('ERRO: Tamanho do XML de Dados superior a 500 Kbytes. Tamanho atual: '+FloatToStr(Int(Length(FDadosMsg)/500))+' Kbytes');
      raise EACBrNFeException.Create('ERRO: Tamanho do XML de Dados superior a 500 Kbytes. Tamanho atual: '+FloatToStr(Int(Length(FDadosMsg)/500))+' Kbytes');
      exit;
   end;
end;

procedure TWebServicesBase.DoNFeRetRecepcao;
var
  ConsReciNFe: TConsReciNFe;
begin
  ConsReciNFe   := TConsReciNFe.Create;
  ConsReciNFe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsReciNFe.nRec   := TNFeRetRecepcao(Self).Recibo;

  if FConfiguracoes.Geral.VersaoDF = ve310 then
    ConsReciNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                       FConfiguracoes.Geral.VersaoDF,
                                       LayNfeRetAutorizacao)
  else
    ConsReciNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                       FConfiguracoes.Geral.VersaoDF,
                                       LayNfeRetRecepcao);

  ConsReciNFe.GerarXML;

  FDadosMsg := ConsReciNFe.Gerador.ArquivoFormatoXML;
  ConsReciNFe.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoNFeRecibo;
var
  ConsReciNFe: TConsReciNFe;
begin
  ConsReciNFe   := TConsReciNFe.Create;
  ConsReciNFe.tpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsReciNFe.nRec   := TNFeRecibo(Self).Recibo;

  if FConfiguracoes.Geral.VersaoDF = ve310 then
    ConsReciNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                       FConfiguracoes.Geral.VersaoDF,
                                       LayNfeRetAutorizacao)
  else
    ConsReciNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                       FConfiguracoes.Geral.VersaoDF,
                                       LayNfeRetRecepcao);

  ConsReciNFe.GerarXML;

  FDadosMsg := ConsReciNFe.Gerador.ArquivoFormatoXML;
  ConsReciNFe.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoNFeStatusServico;
var
  ConsStatServ: TConsStatServ;
begin
  ConsStatServ := TConsStatServ.create;
  ConsStatServ.TpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsStatServ.CUF    := FConfiguracoes.WebServices.UFCodigo;

  ConsStatServ.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                      FConfiguracoes.Geral.VersaoDF,
                                      LayNfeStatusServico);

  ConsStatServ.GerarXML;

  FDadosMsg := ConsStatServ.Gerador.ArquivoFormatoXML;
  ConsStatServ.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoNFeEnvEvento;
var
  EventoNFe : TEventoNFe;
  i, f : integer;
  Eventos, Evento, Lote, EventosAssinados: AnsiString;
  CCeCan : Boolean;
begin
  EventoNFe        := TEventoNFe.Create;
  EventoNFe.idLote := TNFeEnvEvento(Self).idLote;
  CCeCan           := False;

  for i := 0 to TNFeEnvEvento(Self).FEvento.Evento.Count-1 do
   begin
     with EventoNFe.Evento.Add do
      begin
        infEvento.tpAmb      := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
        infEvento.CNPJ       := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.CNPJ;
        infEvento.cOrgao     := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.cOrgao;
        infEvento.chNFe      := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.chNFe;
        infEvento.dhEvento   := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.dhEvento;
        infEvento.tpEvento   := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.tpEvento;
        infEvento.nSeqEvento := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.nSeqEvento;

        case InfEvento.tpEvento of
          teCCe:
          begin
            CCeCan := True;
            infEvento.detEvento.xCorrecao := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.xCorrecao;
            infEvento.detEvento.xCondUso  := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.xCondUso;
          end;
          teCancelamento:
          begin
            CCeCan := True;
            infEvento.detEvento.nProt := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.nProt;
            infEvento.detEvento.xJust := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.xJust;
          end;
          teManifDestOperNaoRealizada:
          begin
            infEvento.detEvento.xJust := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.xJust;
          end;
          teEPECNFe:
          begin
            infEvento.detEvento.cOrgaoAutor := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.cOrgaoAutor;
            infEvento.detEvento.tpAutor     := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.tpAutor;
            infEvento.detEvento.verAplic    := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.verAplic;
            infEvento.detEvento.dhEmi       := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.dhEmi;
            infEvento.detEvento.tpNF        := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.tpNF;
            infEvento.detEvento.IE          := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.IE;

            infEvento.detEvento.dest.UF            := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.dest.UF;
            infEvento.detEvento.dest.CNPJCPF       := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.dest.CNPJCPF;
            infEvento.detEvento.dest.idEstrangeiro := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.dest.idEstrangeiro;
            infEvento.detEvento.dest.IE            := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.dest.IE;

            infEvento.detEvento.vNF   := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.vNF;
            infEvento.detEvento.vICMS := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.vICMS;
            infEvento.detEvento.vST   := TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.detEvento.vST;
          end;
        end;
      end;
   end;

  if CCeCan then
    EventoNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                     FConfiguracoes.Geral.VersaoDF,
                                     LayNfeEvento)
  else
    EventoNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                     FConfiguracoes.Geral.VersaoDF,
                                     LayNfeEventoAN);

  EventoNFe.GerarXML;

  // Separa os grupos <evento> e coloca na variável Eventos
  i       := Pos( '<evento ', EventoNFe.Gerador.ArquivoFormatoXML );
  Lote    := Copy( EventoNFe.Gerador.ArquivoFormatoXML, 1, i - 1 );
  Eventos := SeparaDados( EventoNFe.Gerador.ArquivoFormatoXML, 'envEvento' );
  i       := Pos( '<evento ', Eventos );
  Eventos := Copy( Eventos, i, length(Eventos) );

  EventosAssinados := '';

  // Realiza a assinatura para cada evento
  while Eventos <> '' do
   begin
    f := Pos( '</evento>', Eventos );

    if f > 0
     then begin
      Evento  := Copy( Eventos, 1, f + 8 );
      Eventos := Copy( Eventos, f + 9, length(Eventos) );

  {$IFDEF ACBrNFeOpenSSL}
      if not(NotaUtil.Assinar(Evento, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
         begin
           if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
              TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
           raise EACBrNFeException.Create('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
         end;
  {$ELSE}
      if not(NotaUtil.Assinar(Evento, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
         begin
           if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
              TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
           raise EACBrNFeException.Create('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
         end;
  {$ENDIF}

      EventosAssinados := EventosAssinados + FDadosMsg;
     end
     else Eventos := '';
   end;

  //Corrigido por João Henrique em 28/09/2012
  //<?xml version="1.0"?> não estava ficando no início do arquivo
  //FDadosMsg := Lote + EventosAssinados + '</envEvento>';
  f := Pos( '?>', EventosAssinados );
  if f <> 0 then
    FDadosMsg := copy(EventosAssinados,1,f+1) +
                 Lote +
                 copy(EventosAssinados,f+2,Length(EventosAssinados)) +
                 '</envEvento>'
  else
    FDadosMsg := Lote + EventosAssinados + '</envEvento>';

(*
  {$IFDEF ACBrNFeOpenSSL}
  if not(NotaUtil.Assinar(EventoNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.Certificado , TConfiguracoes(FConfiguracoes).Certificados.Senha, FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
       raise EACBrNFeException.Create('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
     end;
  {$ELSE}
  if not(NotaUtil.Assinar(EventoNFe.Gerador.ArquivoFormatoXML, TConfiguracoes(FConfiguracoes).Certificados.GetCertificado , FDadosMsg, FMsg)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
       raise EACBrNFeException.Create('Falha ao assinar o Envio de Evento '+LineBreak+FMsg);
     end;
  {$ENDIF}
*)

  if not(NotaUtil.Valida(FDadosMsg, FMsg, TACBrNFe( FACBrNFe ).Configuracoes.Geral.PathSchemas,
                         FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('Falha na validação dos dados do Envio de Evento '+LineBreak+FMsg);
       raise EACBrNFeException.Create('Falha na validação dos dados do Envio de Evento '+LineBreak+FMsg);
     end;

  for i := 0 to TNFeEnvEvento(Self).FEvento.Evento.Count-1 do
   begin
      TNFeEnvEvento(Self).FEvento.Evento[i].InfEvento.id := EventoNFe.Evento[i].InfEvento.id;
   end;
  EventoNFe.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

function TWebServicesBase.Executar: Boolean;
begin
  Result := False;
  LoadMsgEntrada;
  LoadURL;
end;

procedure TWebServicesBase.LoadMsgEntrada;
begin
  if self is TNFeStatusServico then
    DoNFeStatusServico
  else if self is TNFeRecepcao then
    DoNFeRecepcao
  else if self is TNFeRetRecepcao then
    DoNFeRetRecepcao
  else if self is TNFeRecibo then
    DoNFeRecibo
  else if self is TNFeConsulta then
    DONFeConsulta
  else if self is TNFeCancelamento then
    DONFeCancelamento
  else if self is TNFeInutilizacao then
    DoNFeInutilizacao
  else if self is TNFeConsultaCadastro then
    DoNFeConsultaCadastro
  else if self is TNFeEnvDPEC then
    DoNFeEnvDPEC
  else if self is TNFeConsultaDPEC then
    DoNFeConsultaDPEC
  else if Self is TNFeCartaCorrecao then
    DoNFeCartaCorrecao
  else if Self is TNFeEnvEvento then
    DoNFeEnvEvento
  else if Self is TNFeConsNFeDest then
    DoNFeConsNFeDest
  else if Self is TNFeDownloadNFe then 
    DoNFeDownloadNFe
  else if Self is TAdministrarCSCNFCe then
    DoAdministrarCSCNFCe
  else if Self is TDistribuicaoDFe then
    DoDistribuicaoDFe;
end;

procedure TWebServicesBase.LoadURL;
begin
  if self is TNFeStatusServico then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeStatusServico, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
  else if self is TNFeRecepcao then
  begin
    if FConfiguracoes.Geral.VersaoDF = ve310 then
      FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeAutorizacao, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
    else FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeRecepcao, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF);
  end
  else if (self is TNFeRetRecepcao) or (self is TNFeRecibo) then
  begin
    if FConfiguracoes.Geral.VersaoDF = ve310 then
      FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeRetAutorizacao, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
    else FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeRetRecepcao, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF);
  end
  else if self is TNFeConsulta then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeConsulta, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
  else if self is TNFeCancelamento then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeCancelamento, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
  else if self is TNFeInutilizacao then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeInutilizacao, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
  else if self is TNFeConsultaCadastro then
    FURL  := NotaUtil.GetURL(UFparaCodigo(TNFeConsultaCadastro(Self).UF), FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeCadastro, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
  else if self is TNFeEnvDPEC then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeEnvDPEC, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
  else if self is TNFeConsultaDPEC then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNfeConsultaDPEC, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
  else if self is TNFeCartaCorrecao then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNFeCCe, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
  else if self is TNFeEnvEvento then
  begin
    //Verificação necessária pois somente os eventos de Cancelamento e CCe serão tratados pela SEFAZ do estado
    //os outros eventos como manifestacao de destinatários serão tratados diretamente pela RFB
    if not ((self as TNFeEnvEvento).FEvento.Evento.Items[0].InfEvento.tpEvento
            in [teCCe, teCancelamento]) then
      FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNFeEventoAN, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
    else
      FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNFeEvento, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
  end
  else if self is TNFeConsNFeDest then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNFeConsNFeDest, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
  else if self is TNFeDownloadNFe then
    FURL  := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayNFeDownloadNFe, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
  else if self is TAdministrarCSCNFCe then
    FURL := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayAdministrarCSCNFCe, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
  else if self is TDistribuicaoDFe then
    FURL := NotaUtil.GetURL(FConfiguracoes.WebServices.UFCodigo, FConfiguracoes.WebServices.AmbienteCodigo, FConfiguracoes.Geral.FormaEmissaoCodigo, LayDistDFeInt, FConfiguracoes.Geral.ModeloDF, FConfiguracoes.Geral.VersaoDF)
end;

procedure TWebServicesBase.DoNFeConsNFeDest;
var
  ConsNFeDest: TConsNFeDest;
begin
  ConsNFeDest := TConsNFeDest.create;
  ConsNFeDest.TpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  ConsNFeDest.CNPJ   := TNFeConsNFeDest(Self).CNPJ;
  ConsNFeDest.indNFe := TNFeConsNFeDest(Self).indNFe;
  ConsNFeDest.indEmi := TNFeConsNFeDest(Self).indEmi;
  ConsNFeDest.ultNSU := TNFeConsNFeDest(Self).ultNSU;

  ConsNFeDest.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                     FConfiguracoes.Geral.VersaoDF,
                                     LayNfeConsNFeDest);

  ConsNFeDest.GerarXML;

  FDadosMsg := ConsNFeDest.Gerador.ArquivoFormatoXML;
  ConsNFeDest.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoNFeDownloadNFe;
var
  DownloadNFe: TDownloadNFe;
  i: integer;
begin
  DownloadNFe := TDownloadNFe.create;
  DownloadNFe.TpAmb  := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  DownloadNFe.CNPJ   := TNFeDownloadNFe(Self).FDownload.CNPJ;

  for i := 0 to TNFeDownloadNFe(Self).FDownload.Chaves.Count - 1 do
   begin
     with DownloadNFe.Chaves.Add do
      begin
        chNFe := TNFeDownloadNFe(Self).FDownload.Chaves[i].chNFe;
//        chNFe := TDownloadNFe(Self).Chaves.Items[i].chNFe;
      end;
   end;

  DownloadNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                     FConfiguracoes.Geral.VersaoDF,
                                     LayNfeDownloadNFe);

  DownloadNFe.GerarXML;

  FDadosMsg := DownloadNFe.Gerador.ArquivoFormatoXML;
  DownloadNFe.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<'+ENCODING_UTF8+'>', '', [rfReplaceAll] ) ;
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
end;

procedure TWebServicesBase.DoAdministrarCSCNFCe;
var
  AdmCSCNFCe: TAdmCSCNFCe;
begin
  AdmCSCNFCe := TAdmCSCNFCe.create;
  AdmCSCNFCe.TpAmb     := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  AdmCSCNFCe.RaizCNPJ  := TAdministrarCSCNFCe(Self).RaizCNPJ;
  AdmCSCNFCe.indOP     := TAdministrarCSCNFCe(Self).indOP;
  AdmCSCNFCe.idCsc     := TAdministrarCSCNFCe(Self).idCsc;
  AdmCSCNFCe.codigoCsc := TAdministrarCSCNFCe(Self).codigoCsc;

  AdmCSCNFCe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                    FConfiguracoes.Geral.VersaoDF,
                                    LayAdministrarCSCNFCe);

  AdmCSCNFCe.GerarXML;

  FDadosMsg := AdmCSCNFCe.Gerador.ArquivoFormatoXML;
  AdmCSCNFCe.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<' + ENCODING_UTF8_STD + '>', '', [rfReplaceAll] );
  FDadosMsg := StringReplace( FDadosMsg, '<' + ENCODING_UTF8 + '>', '', [rfReplaceAll] );
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] );
end;

procedure TWebServicesBase.DoDistribuicaoDFe;
var
  DistDFeInt: TDistDFeInt;
begin
  DistDFeInt := TDistDFeInt.create;
  DistDFeInt.TpAmb    := TpcnTipoAmbiente(FConfiguracoes.WebServices.AmbienteCodigo-1);
  DistDFeInt.cUFAutor := TDistribuicaoDFe(Self).FcUFAutor;
  DistDFeInt.CNPJCPF  := TDistribuicaoDFe(Self).CNPJCPF;
  DistDFeInt.ultNSU   := TDistribuicaoDFe(Self).ultNSU;
  DistDFeInt.NSU      := TDistribuicaoDFe(Self).NSU;

  DistDFeInt.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                    FConfiguracoes.Geral.VersaoDF,
                                    LayDistDFeInt);

  DistDFeInt.GerarXML;

  FDadosMsg := DistDFeInt.Gerador.ArquivoFormatoXML;
  DistDFeInt.Free;

  FDadosMsg := StringReplace( FDadosMsg, '<' + ENCODING_UTF8_STD + '>', '', [rfReplaceAll] );
  FDadosMsg := StringReplace( FDadosMsg, '<' + ENCODING_UTF8 + '>', '', [rfReplaceAll] );
  FDadosMsg := StringReplace( FDadosMsg, '<?xml version="1.0"?>', '', [rfReplaceAll] );
end;

{ TWebServices }

procedure TWebServices.Cancela(AJustificativa: String);
begin
//retirado por recomendação do documento disponível em http://www.nfe.fazenda.gov.br/PORTAL/docs/Consumo_Indevido_Aplicacao_Cliente_v1.00.pdf
{  if TACBrNFe( FACBrNFe ).Configuracoes.Geral.FormaEmissao = teNormal then
   begin
     if not(Self.StatusServico.Executar) then
      begin
        if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
           TACBrNFe( FACBrNFe ).OnGerarLog(Self.StatusServico.Msg);
        raise EACBrNFeException.Create(Self.StatusServico.Msg);
      end;
   end;}

  if not(Self.Consulta.Executar) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog(Self.Consulta.Msg);
       raise EACBrNFeException.Create(Self.Consulta.Msg);
     end;

  Self.Cancelamento.NFeChave      := Self.Consulta.FNFeChave;
  Self.Cancelamento.Protocolo     := Self.Consulta.FProtocolo;
  Self.Cancelamento.Justificativa := AJustificativa;
  if not(Self.Cancelamento.Executar) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog(Self.Cancelamento.Msg);
       raise EACBrNFeException.Create(Self.Cancelamento.Msg);
     end;
end;

procedure TWebServices.Inutiliza(CNPJ, AJustificativa: String; Ano, Modelo, Serie, NumeroInicial, NumeroFinal : Integer);
begin
//retirado por recomendação do documento disponível em http://www.nfe.fazenda.gov.br/PORTAL/docs/Consumo_Indevido_Aplicacao_Cliente_v1.00.pdf
{  if TACBrNFe( FACBrNFe ).Configuracoes.Geral.FormaEmissao = teNormal then
   begin
     if not(Self.StatusServico.Executar) then
      begin
        if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
           TACBrNFe( FACBrNFe ).OnGerarLog(Self.StatusServico.Msg);
          raise EACBrNFeException.Create(Self.StatusServico.Msg);
      end;
   end;}
  CNPJ := OnlyNumber(CNPJ);
  if not ValidarCNPJ(CNPJ) then
     raise EACBrNFeException.Create('CNPJ '+CNPJ+' inválido.');

  Self.Inutilizacao.CNPJ   := CNPJ;
  Self.Inutilizacao.Modelo := Modelo;
  Self.Inutilizacao.Serie  := Serie;
  Self.Inutilizacao.Ano    := Ano;
  Self.Inutilizacao.NumeroInicial := NumeroInicial;
  Self.Inutilizacao.NumeroFinal   := NumeroFinal;
  Self.Inutilizacao.Justificativa := AJustificativa;

  if not(Self.Inutilizacao.Executar) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog(Self.Inutilizacao.Msg);
       raise EACBrNFeException.Create(Self.Inutilizacao.Msg);
     end;
end;

constructor TWebServices.Create(AFNotaFiscalEletronica: TComponent);
begin
 inherited Create( AFNotaFiscalEletronica );
  FACBrNFe          := TACBrNFe(AFNotaFiscalEletronica);
  FStatusServico    := TNFeStatusServico.Create(AFNotaFiscalEletronica);
  FEnviar           := TNFeRecepcao.Create(AFNotaFiscalEletronica, TACBrNFe(AFNotaFiscalEletronica).NotasFiscais);
  FRetorno          := TNFeRetRecepcao.Create(AFNotaFiscalEletronica, TACBrNFe(AFNotaFiscalEletronica).NotasFiscais);
  FRecibo           := TNFeRecibo.Create(AFNotaFiscalEletronica);
  FConsulta         := TNFeConsulta.Create(AFNotaFiscalEletronica);
  FCancelamento     := TNFeCancelamento.Create(AFNotaFiscalEletronica);
  FInutilizacao     := TNFeInutilizacao.Create(AFNotaFiscalEletronica);
  FConsultaCadastro := TNFeConsultaCadastro.Create(AFNotaFiscalEletronica);
  FEnviaDPEC        := TNFeEnvDPEC.Create(AFNotaFiscalEletronica);
  FConsultaDPEC     := TNFeConsultaDPEC.Create(AFNotaFiscalEletronica);
  FCartaCorrecao    := TNFeCartaCorrecao.Create(AFNotaFiscalEletronica,TACBrNFe(AFNotaFiscalEletronica).CartaCorrecao.CCe);
  FEnvEvento        := TNFeEnvEvento.Create(AFNotaFiscalEletronica,TACBrNFe(AFNotaFiscalEletronica).EventoNFe);
  FConsNFeDest      := TNFeConsNFeDest.Create(AFNotaFiscalEletronica);
  FDownloadNFe      := TNFeDownloadNFe.Create(AFNotaFiscalEletronica, TACBrNFe(AFNotaFiscalEletronica).DownloadNFe.Download);
  FAdministrarCSCNFCe := TAdministrarCSCNFCe.Create(AFNotaFiscalEletronica);
  FDistribuicaoDFe    := TDistribuicaoDFe.Create(AFNotaFiscalEletronica);  
  FEnvioWebService  := TNFeEnvioWebService.Create(AFNotaFiscalEletronica);
end;

destructor TWebServices.Destroy;
begin
  FStatusServico.Free;
  FEnviar.Free;
  FRetorno.Free;
  FRecibo.Free;
  FConsulta.Free;
  FCancelamento.Free;
  FInutilizacao.Free;
  FConsultaCadastro.Free;
  FEnviaDPEC.Free;
  FConsultaDPEC.Free;
  FCartaCorrecao.Free;
  FEnvEvento.Free;
  FConsNFeDest.Free;
  FDownloadNFe.Free;
  FAdministrarCSCNFCe.Free;
  FDistribuicaoDFe.Free;
  FEnvioWebService.Free;
  inherited;
end;

function TWebServices.Envia(ALote: Integer; const ASincrono: Boolean): Boolean;
begin
  Result := Envia(IntToStr(ALote), ASincrono);
end;

function TWebServices.Envia(ALote: String; const ASincrono: Boolean): Boolean;
begin
//retirado por recomendação do documento disponível em http://www.nfe.fazenda.gov.br/PORTAL/docs/Consumo_Indevido_Aplicacao_Cliente_v1.00.pdf
{  if not(Self.StatusServico.Executar) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog(Self.StatusServico.Msg);
       raise EACBrNFeException.Create(Self.StatusServico.Msg);
     end;      }

  self.Enviar.FLote := ALote;
  self.Enviar.FSincrono := ASincrono;

  if not(Self.Enviar.Executar) then
     begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog(Self.Enviar.Msg);
       raise EACBrNFeException.Create(Self.Enviar.Msg);
     end;

  // Alterado por Augusto Fontana em 09/07/2014.
  // Realizar a consulta do lote quando o envio for assíncrono

  //if (FConfiguracoes.Geral.ModeloDF = moNFe) or (not ASincrono) then
  //if (FConfiguracoes.Geral.ModeloDF = moNFe) and (not ASincrono) then

  // Esta forma será correta caso todas as SEFAZ liberem o acesso
  // Sincrono a Assincrono tanto para a NF-e quanto para a NFC-e.
  if not ASincrono then
   begin
    Self.Retorno.Recibo := Self.Enviar.Recibo;
    if not(Self.Retorno.Executar) then
       begin
         if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
            TACBrNFe( FACBrNFe ).OnGerarLog(Self.Retorno.Msg);
         raise EACBrNFeException.Create(Self.Retorno.Msg);
       end;
   end;

  Result := true;
end;

{ TNFeStatusServico }
function TNFeStatusServico.Executar: Boolean;
var
  NFeRetorno: TRetConsStatServ;
  aMsg, Servico, SoapAction: string;
  Texto : String;
begin
  inherited Executar;

  Result := False;

  // Alterado por Italo em 27/08/2014
  if (FConfiguracoes.Geral.ModeloDF = moNFe) and (FConfiguracoes.Geral.VersaoDF = ve310) and (FConfiguracoes.WebServices.UFCodigo = 29)
   then begin
     Servico    := '"http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico"';
     SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico/NfeStatusServicoNF';
   end
   else begin
     Servico    := '"http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico2"';
     SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeStatusServico2';
   end;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<nfeCabecMsg xmlns=' + Servico + '>';
  Texto := Texto +       '<cUF>' + IntToStr(FConfiguracoes.WebServices.UFCodigo) + '</cUF>';

  Texto := Texto + '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                  FConfiguracoes.Geral.VersaoDF,
                                                  LayNfeStatusServico) +
                   '</versaoDados>';

  Texto := Texto +     '</nfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';

  Texto := Texto +     '<nfeDadosMsg xmlns=' + Servico + '>';
  Texto := Texto +       FDadosMsg;
  Texto := Texto +     '</nfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto +'</soap12:Envelope>';

  try
    TACBrNFe( FACBrNFe ).SetStatus( stNFeStatusServico );

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss', Now) + '-ped-sta.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);
     end;

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss', Now) + '-ped-sta-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, Texto);
     end;

    try
      FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);

      FRetWS := SeparaDados( FRetornoWS,'nfeStatusServicoNF2Result');
      if FRetWS = '' then
         FRetWS := SeparaDados( FRetornoWS,'NfeStatusServicoNFResult');


      NFeRetorno := TRetConsStatServ.Create;
      NFeRetorno.Leitor.Arquivo := FRetWS;
      NFeRetorno.LerXml;

      TACBrNFe( FACBrNFe ).SetStatus( stIdle );
      aMsg := //'Versão Leiaute : '+NFeRetorno.verAplic+LineBreak+
              'Ambiente : '+TpAmbToStr(NFeRetorno.tpAmb)+LineBreak+
              'Versão Aplicativo : '+NFeRetorno.verAplic+LineBreak+
              'Status Código : '+IntToStr(NFeRetorno.cStat)+LineBreak+
              'Status Descrição : '+NFeRetorno.xMotivo+LineBreak+
              'UF : '+CodigoParaUF(NFeRetorno.cUF)+LineBreak+
              'Recebimento : '+DFeUtil.SeSenao(NFeRetorno.DhRecbto = 0, '', DateTimeToStr(NFeRetorno.dhRecbto))+LineBreak+
              'Tempo Médio : '+IntToStr(NFeRetorno.TMed)+LineBreak+
              'Retorno : '+ DFeUtil.SeSenao(NFeRetorno.dhRetorno = 0, '', DateTimeToStr(NFeRetorno.dhRetorno))+LineBreak+
              'Observação : '+NFeRetorno.xObs+LineBreak;
      if FConfiguracoes.WebServices.Visualizar then
        ShowMessage(aMsg);

      if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
         TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

      FtpAmb    := NFeRetorno.tpAmb;
      FverAplic := NFeRetorno.verAplic;
      FcStat    := NFeRetorno.cStat;
      FxMotivo  := NFeRetorno.xMotivo;
      FcUF      := NFeRetorno.cUF;
      FdhRecbto := NFeRetorno.dhRecbto;
      FTMed     := NFeRetorno.TMed;
      FdhRetorno:= NFeRetorno.dhRetorno;
      FxObs     := NFeRetorno.xObs;

      if TACBrNFe( FACBrNFe ).Configuracoes.WebServices.AjustaAguardaConsultaRet then
         TACBrNFe( FACBrNFe ).Configuracoes.WebServices.AguardarConsultaRet := FTMed*1000;

      FMsg   := NFeRetorno.XMotivo+ LineBreak+NFeRetorno.XObs;
      Result := (NFeRetorno.CStat = 107);
      NFeRetorno.Free;

      if FConfiguracoes.Geral.Salvar then
       begin
         FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now)+'-sta.xml';
         FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);
       end;

      if FConfiguracoes.WebServices.Salvar then
       begin
         FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now)+'-sta-soap.xml';
         FConfiguracoes.Geral.Save(FPathArqResp, FRetornoWS);
       end;

    except on E: Exception do
      begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('WebService Consulta Status serviço:'+LineBreak+
                                          '- Inativo ou Inoperante tente novamente.'+LineBreak+
                                          '- '+E.Message);
       raise EACBrNFeException.Create('WebService Consulta Status serviço:'+LineBreak+
                              '- Inativo ou Inoperante tente novamente.'+LineBreak+
                              '- '+E.Message);
      end;
    end;
  finally
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

{ TNFeRecepcao }
constructor TNFeRecepcao.Create(AOwner : TComponent;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);
  FNotasFiscais := ANotasFiscais;
end;

function TNFeRecepcao.Executar: Boolean;
var
  NFeRetorno: TretEnvNFe;
  NFeRetornoSincrono: TRetConsSitNFe;
  chNFe, SoapAction, aMsg: string;
  nfeAutorizacaoLote : boolean;
  Texto : string;
  i: integer;
  AProcNFe: TProcNFe;
begin
  inherited Executar;

  // Alterado por Italo em 05/08/2014
  case FConfiguracoes.Geral.ModeloDF of
   moNFe:  begin
//            if (FConfiguracoes.Geral.VersaoDF = ve310) and not
//               (FConfiguracoes.WebServices.UFCodigo in [23])  then // CE
            if (FConfiguracoes.Geral.VersaoDF = ve310) then
             begin
               SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeAutorizacao';
               nfeAutorizacaoLote := True;
             end
            else
             begin
               SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao2';
               nfeAutorizacaoLote := False;
             end;
           end;
           // Até o momento somente as UF: AC-Acre, AM-Amazonas, MA-Maranhão,
           // MT-Mato Grosso, RN-Rio Grande do Norte, RS-Rio Grande do Sul e
           // SE-Sergipe participam do projeto da NFC-e
   moNFCe: begin
            if (FConfiguracoes.Geral.VersaoDF = ve310) and not
               (FConfiguracoes.WebServices.UFCodigo in [13])  then // AM
             begin
               SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeAutorizacao';
               nfeAutorizacaoLote := True;
             end
            else
             begin
               SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeRecepcao2';
               nfeAutorizacaoLote := False;
             end;
           end;
  end;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<nfeCabecMsg xmlns="'+SoapAction+'">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';

  if nfeAutorizacaoLote then
    Texto := Texto + '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                    FConfiguracoes.Geral.VersaoDF,
                                                    LayNfeAutorizacao) +
                     '</versaoDados>'
  else
    Texto := Texto + '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                    FConfiguracoes.Geral.VersaoDF,
                                                    LayNfeRecepcao) +
                     '</versaoDados>';

  Texto := Texto +     '</nfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<nfeDadosMsg xmlns="'+SoapAction+'">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</nfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto +'</soap12:Envelope>';

//  if assigned(TACBrNFe( FACBrNFe ).WebServices.Retorno.NFeRetorno) then
//     TACBrNFe( FACBrNFe ).WebServices.Retorno.NFeRetorno.Free;

  try
    TACBrNFe( FACBrNFe ).SetStatus( stNFeRecepcao );

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqEnv := Lote+'-env-lot.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);
     end;

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqEnv := Lote+'-env-lot-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, Texto);
     end;

     FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);

     if nfeAutorizacaoLote then
      begin
        FRetWS := SeparaDados( FRetornoWS,'nfeAutorizacaoLoteResult');
        if FRetWS = '' then
          FRetWS := SeparaDados( FRetornoWS,'nfeAutorizacaoResult');
      end
     else
        FRetWS := SeparaDados( FRetornoWS,'nfeRecepcaoLote2Result');


    if ((FConfiguracoes.Geral.ModeloDF = moNFCe) or (FConfiguracoes.Geral.VersaoDF = ve310)) and FSincrono then
     begin
       NFeRetornoSincrono := TRetConsSitNFe.Create;

       if pos('retEnviNFe',FRetWS) > 0 then
          NFeRetornoSincrono.Leitor.Arquivo := StringReplace(FRetWS,'retEnviNFe','retConsSitNFe',[rfReplaceAll,rfIgnoreCase])
       else if pos('retConsReciNFe',FRetWS) > 0 then
          NFeRetornoSincrono.Leitor.Arquivo := StringReplace(FRetWS,'retConsReciNFe','retConsSitNFe',[rfReplaceAll,rfIgnoreCase])
       else
          NFeRetornoSincrono.Leitor.Arquivo := FRetWS;

       NFeRetornoSincrono.LerXml;

       // Consta no Retorno da NFC-e
       FRecibo   := NFeRetornoSincrono.nRec;

       FTpAmb    := NFeRetornoSincrono.TpAmb;
       FverAplic := NFeRetornoSincrono.verAplic;
       FcUF      := NFeRetornoSincrono.cUF;

       // Alterado por Italo em 01/10/2014
       if NFeRetornoSincrono.cStat = 104 then
        begin
          FcStat    := NFeRetornoSincrono.protNFe.cStat;
          FMsg      := NFeRetornoSincrono.protNFe.xMotivo;
          FxMotivo  := NFeRetornoSincrono.protNFe.xMotivo;
          chNFe     := NFeRetornoSincrono.ProtNFe.chNFe;
          FdhRecbto := NFeRetornoSincrono.protNFe.dhRecbto;
        end
        else
        begin
          FcStat    := NFeRetornoSincrono.cStat;
          FMsg      := NFeRetornoSincrono.xMotivo;
          FxMotivo  := NFeRetornoSincrono.xMotivo;
          chNFe     := NFeRetornoSincrono.chNFe;
          FdhRecbto := NFeRetornoSincrono.dhRecbto;
        end;

       TACBrNFe( FACBrNFe ).SetStatus( stIdle );

       // Alterado por Italo em 01/10/2014
       aMsg := 'Ambiente : '+TpAmbToStr(FTpAmb)+LineBreak+
               'Versão Aplicativo : '+FverAplic+LineBreak+
               'Status Código : '+IntToStr(FcStat)+LineBreak+
               'Status Descrição : '+FxMotivo+LineBreak+
               'UF : '+CodigoParaUF(FcUF)+LineBreak+
               'dhRecbto : '+DateTimeToStr(FdhRecbto)+LineBreak+
               'chNFe : '+chNfe+LineBreak;
       (*
       aMsg := 'Ambiente : '+TpAmbToStr(NFeRetornoSincrono.TpAmb)+LineBreak+
               'Versão Aplicativo : '+NFeRetornoSincrono.verAplic+LineBreak+
               'Status Código : '+IntToStr(NFeRetornoSincrono.protNFe.cStat)+LineBreak+
               'Status Descrição : '+NFeRetornoSincrono.protNFe.xMotivo+LineBreak+
               'UF : '+CodigoParaUF(NFeRetornoSincrono.cUF)+LineBreak+
               'dhRecbto : '+DateTimeToStr(NFeRetornoSincrono.dhRecbto)+LineBreak+
               'chNFe : '+NFeRetornoSincrono.chNfe+LineBreak;
       *)
       if FConfiguracoes.WebServices.Visualizar then
          ShowMessage(aMsg);

       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

       // Alterado por Augusto Fontana em 09/07/2014.
       // Verificar se a NF-e foi autorizada com sucesso
//       Result := (NFeRetornoSincrono.cStat = 104) and (NFeRetornoSincrono.protNFe.cStat = 100);
       // Alterado por Italo em 01/10/2014
       Result := (NFeRetornoSincrono.cStat = 104) and (NFeRetornoSincrono.protNFe.cStat in [100, 150]);

       if NFeRetornoSincrono.cStat = 104 then
        begin
          for i:= 0 to TACBrNFe( FACBrNFe ).NotasFiscais.Count-1 do
           begin
             if StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.infNFe.ID,'NFe','',[rfIgnoreCase]) = chNFe then
              begin
                TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].Confirmada           := (NFeRetornoSincrono.protNFe.cStat in [100, 150]);
                TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].Msg                  := NFeRetornoSincrono.protNFe.xMotivo;
                TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.tpAmb    := NFeRetornoSincrono.tpAmb;
                TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.verAplic := NFeRetornoSincrono.verAplic;
                TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.chNFe    := NFeRetornoSincrono.ProtNFe.chNFe;
                TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.dhRecbto := NFeRetornoSincrono.protNFe.dhRecbto;
                TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.nProt    := NFeRetornoSincrono.ProtNFe.nProt;
                TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.digVal   := NFeRetornoSincrono.protNFe.digVal;
                TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.cStat    := NFeRetornoSincrono.protNFe.cStat;
                TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.xMotivo  := NFeRetornoSincrono.protNFe.xMotivo;
                if (FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar) + chNFe + '-nfe.xml')) or
                    DFeUtil.NaoEstaVazio(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq) then
                 begin
                   AProcNFe:=TProcNFe.Create;

                   if DFeUtil.NaoEstaVazio(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq) then
                      AProcNFe.PathNFe:=TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq
                   else
                      AProcNFe.PathNFe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar) + chNFe + '-nfe.xml';

                   AProcNFe.PathRetConsSitNFe  := '';
                   AProcNFe.PathRetConsReciNFe := '';
                   AProcNFe.tpAmb              := NFeRetornoSincrono.protNFe.tpAmb;
                   AProcNFe.verAplic           := NFeRetornoSincrono.protNFe.verAplic;
                   AProcNFe.chNFe              := NFeRetornoSincrono.protNFe.chNFe;
                   AProcNFe.dhRecbto           := NFeRetornoSincrono.protNFe.dhRecbto;
                   AProcNFe.nProt              := NFeRetornoSincrono.protNFe.nProt;
                   AProcNFe.digVal             := NFeRetornoSincrono.protNFe.digVal;
                   AProcNFe.cStat              := NFeRetornoSincrono.protNFe.cStat;
                   AProcNFe.xMotivo            := NFeRetornoSincrono.protNFe.xMotivo;

//                   AProcNFe.PathRetConsSitNFe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar) + chNFe + '-sit.xml';

                   if nfeAutorizacaoLote then
                     AProcNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                     FConfiguracoes.Geral.VersaoDF,
                                                     LayNfeAutorizacao)
                   else
                     AProcNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                     FConfiguracoes.Geral.VersaoDF,
                                                     LayNfeRecepcao);

                   AProcNFe.GerarXML;

                   if DFeUtil.NaoEstaVazio(AProcNFe.Gerador.ArquivoFormatoXML) then
                      AProcNFe.Gerador.SalvarArquivo(AProcNFe.PathNFe);

                   AProcNFe.Free;
                 end;

             if FConfiguracoes.Arquivos.Salvar then
              begin
                if FConfiguracoes.Arquivos.EmissaoPathNFe then
                   TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Ide.dEmi,
                                                                                                                          TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Emit.CNPJCPF))
                                                                                                                          +StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml')
                else
                   TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(Now,
                                                                                                                          TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Emit.CNPJCPF))
                                                                                                                          +StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml')                end;
              end;
          break;
        end;
//        Result :=  Confirma(NFeRetornoS.ProtNFe);
//        FChaveNfe  := NFeRetornoS.ProtNFe.Items[0].chNFe;
//        FProtocolo := NFeRetornoS.ProtNFe.Items[0].nProt;
//        FcStat     := NFeRetornoS.ProtNFe.Items[0].cStat;
//        FMsg       := NFeRetornoS.ProtNFe.Items[0].xMotivo;
//        FxMotivo   := NFeRetornoS.ProtNFe.Items[0].xMotivo;
        end;

      NFeRetornoSincrono.Free;

      if  FConfiguracoes.Geral.Salvar then
       begin
         // Alterado por Italo em 16/04/2014
         if FRecibo <> '' then
           FPathArqResp := FRecibo+'-pro-rec.xml'
         else
           FPathArqResp := Lote+'-pro-lot.xml';

         FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);
       end;

      if  FConfiguracoes.WebServices.Salvar then
       begin
         if FRecibo <> '' then
           FPathArqResp := FRecibo+'-pro-rec-soap.xml'
         else
           FPathArqResp := Lote+'-pro-lot-soap.xml';

         FConfiguracoes.Geral.Save(FPathArqResp, FRetornoWS);
       end;

     end
    else
     begin
       NFeRetorno := TretEnvNFe.Create;
       NFeRetorno.Leitor.Arquivo := FRetWS;
       NFeRetorno.LerXml;

       TACBrNFe( FACBrNFe ).SetStatus( stIdle );
       aMsg := //'Versão Leiaute : '+NFeRetorno.Versao+LineBreak+
               'Ambiente : '+TpAmbToStr(NFeRetorno.TpAmb)+LineBreak+
               'Versão Aplicativo : '+NFeRetorno.verAplic+LineBreak+
               'Status Código : '+IntToStr(NFeRetorno.cStat)+LineBreak+
               'Status Descrição : '+NFeRetorno.xMotivo+LineBreak+
               'UF : '+CodigoParaUF(NFeRetorno.cUF)+LineBreak+
               'Recibo : '+NFeRetorno.infRec.nRec+LineBreak+
               'Recebimento : '+DFeUtil.SeSenao(NFeRetorno.InfRec.dhRecbto = 0, '', DateTimeToStr(NFeRetorno.InfRec.dhRecbto))+LineBreak+
               'Tempo Médio : '+IntToStr(NFeRetorno.InfRec.TMed)+LineBreak;
       if FConfiguracoes.WebServices.Visualizar then
          ShowMessage(aMsg);

       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

       FTpAmb    := NFeRetorno.TpAmb;
       FverAplic := NFeRetorno.verAplic;
       FcStat    := NFeRetorno.cStat;
       FxMotivo  := NFeRetorno.xMotivo;
       FdhRecbto := NFeRetorno.infRec.dhRecbto;
       FTMed     := NFeRetorno.infRec.tMed;
       FcUF      := NFeRetorno.cUF;

       FMsg    := NFeRetorno.xMotivo;
       FRecibo := NFeRetorno.infRec.nRec;
       Result := (NFeRetorno.CStat = 103);

       NFeRetorno.Free;

       if FConfiguracoes.Geral.Salvar then
        begin
          FPathArqResp := Lote+'-rec.xml';
          FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);
        end;

       if FConfiguracoes.WebServices.Salvar then
        begin
          FPathArqResp := Lote+'-rec-soap.xml';
          FConfiguracoes.Geral.Save(FPathArqResp, FRetornoWS);
        end;
     end;


  finally
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

function TNFeRecepcao.GetLote: String;
begin
  Result := Trim(FLote);
end;

{ TNFeRetRecepcao }
function TNFeRetRecepcao.Confirma(AInfProt: TProtNFeCollection): Boolean;
var
  i,j : Integer;
  AProcNFe: TProcNFe;
begin
  Result := False;

  //Setando os retornos das notas fiscais;
  for i:= 0 to AInfProt.Count-1 do
  begin
    for j:= 0 to FNotasFiscais.Count-1 do
    begin
      if AInfProt.Items[i].chNFe = StringReplace(FNotasFiscais.Items[j].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase]) then
       begin
         FNotasFiscais.Items[j].Confirmada := (AInfProt.Items[i].cStat in [100,150]);
         FNotasFiscais.Items[j].Msg        := AInfProt.Items[i].xMotivo;
         FNotasFiscais.Items[j].NFe.procNFe.tpAmb    := AInfProt.Items[i].tpAmb;
         FNotasFiscais.Items[j].NFe.procNFe.verAplic := AInfProt.Items[i].verAplic;
         FNotasFiscais.Items[j].NFe.procNFe.chNFe    := AInfProt.Items[i].chNFe;
         FNotasFiscais.Items[j].NFe.procNFe.dhRecbto := AInfProt.Items[i].dhRecbto;
         FNotasFiscais.Items[j].NFe.procNFe.nProt    := AInfProt.Items[i].nProt;
         FNotasFiscais.Items[j].NFe.procNFe.digVal   := AInfProt.Items[i].digVal;
         FNotasFiscais.Items[j].NFe.procNFe.cStat    := AInfProt.Items[i].cStat;
         FNotasFiscais.Items[j].NFe.procNFe.xMotivo  := AInfProt.Items[i].xMotivo;
         if FConfiguracoes.Geral.Salvar or DFeUtil.NaoEstaVazio(FNotasFiscais.Items[j].NomeArq) then
          begin
            if FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[i].chNFe+'-nfe.xml') and
               FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeRetorno.nRec+'-pro-rec.xml') then
             begin
               AProcNFe:=TProcNFe.Create;
               AProcNFe.PathNFe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[i].chNFe+'-nfe.xml';
               AProcNFe.PathRetConsReciNFe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeRetorno.nRec+'-pro-rec.xml';

               if FConfiguracoes.Geral.VersaoDF = ve310 then
                 AProcNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                 FConfiguracoes.Geral.VersaoDF,
                                                 LayNfeAutorizacao)
               else
                 AProcNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                 FConfiguracoes.Geral.VersaoDF,
                                                 LayNfeRecepcao);

               AProcNFe.GerarXML;

               if DFeUtil.NaoEstaVazio(AProcNFe.Gerador.ArquivoFormatoXML) then
                begin
                  if DFeUtil.NaoEstaVazio(FNotasFiscais.Items[j].NomeArq) then
                     AProcNFe.Gerador.SalvarArquivo(FNotasFiscais.Items[j].NomeArq)
                  else
                     AProcNFe.Gerador.SalvarArquivo(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+AInfProt.Items[i].chNFe+'-nfe.xml');
                end;
               AProcNFe.Free;
             end;
          end;
         if FConfiguracoes.Arquivos.Salvar then
            if FConfiguracoes.Arquivos.EmissaoPathNFe then
               FNotasFiscais.Items[j].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(FNotasFiscais.Items[j].NFe.Ide.dEmi,
                                                                                                  FNotasFiscais.Items[j].NFe.Emit.CNPJCPF))
                                                                                                  +StringReplace(FNotasFiscais.Items[j].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml')
            else
               FNotasFiscais.Items[j].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(now,
                                                                                                  FNotasFiscais.Items[j].NFe.Emit.CNPJCPF))
                                                                                                  +StringReplace(FNotasFiscais.Items[j].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml');

         break;
       end;
    end;
  end;

  //Verificando se existe alguma nota confirmada
  for i:= 0 to FNotasFiscais.Count-1 do
  begin
    if FNotasFiscais.Items[i].Confirmada then
    begin
      Result := True;
      break;
    end;
  end;

  //Verificando se existe alguma nota nao confirmada
  for i:= 0 to FNotasFiscais.Count-1 do
  begin
    if not(FNotasFiscais.Items[i].Confirmada) then
    begin
      FMsg   := 'Nota(s) não confirmadas:'+LineBreak;
      break;
    end;
  end;

  //Montando a mensagem de retorno para as notas nao confirmadas
  for i:= 0 to FNotasFiscais.Count-1 do
  begin
    if not(FNotasFiscais.Items[i].Confirmada) then
      FMsg:= FMsg+IntToStr(FNotasFiscais.Items[i].NFe.Ide.nNF)+'->'+FNotasFiscais.Items[i].Msg+LineBreak;
  end;
end;

constructor TNFeRetRecepcao.Create(AOwner : TComponent;
  ANotasFiscais: TNotasFiscais);
begin
  inherited Create(AOwner);
  FNotasFiscais := ANotasFiscais;
end;

destructor TNFeRetRecepcao.destroy;
begin
   if assigned(FNFeRetorno) then
      FNFeRetorno.Free;
   inherited;
end;

function TNFeRetRecepcao.Executar: Boolean;
  function Processando: Boolean;
  var
    SoapAction, aMsg: string;
    nfeAutorizacaoLote : boolean;
    Texto : String;
  begin

    if assigned(FNFeRetorno) then
       FNFeRetorno.Free;

    // Alterado por Italo em 05/08/2014
    case FConfiguracoes.Geral.ModeloDF of
     moNFe:  begin
//              if (FConfiguracoes.Geral.VersaoDF = ve310) and not
//                 (FConfiguracoes.WebServices.UFCodigo in [23])  then // CE
              if (FConfiguracoes.Geral.VersaoDF = ve310) then
               begin
                 SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetAutorizacao';
                 nfeAutorizacaoLote := True;
               end
              else
               begin
                 SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao2';
                 nfeAutorizacaoLote := False;
               end;
             end;
             // Até o momento somente as UF: AC-Acre, AM-Amazonas, MA-Maranhão,
             // MT-Mato Grosso, RN-Rio Grande do Norte, RS-Rio Grande do Sul e
             // SE-Sergipe participam do projeto da NFC-e
     moNFCe: begin
              if (FConfiguracoes.Geral.VersaoDF = ve310) and not
                 (FConfiguracoes.WebServices.UFCodigo in [13])  then // AM
               begin
                 SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetAutorizacao';
                 nfeAutorizacaoLote := True;
               end
              else
               begin
                 SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao2';
                 nfeAutorizacaoLote := False;
               end;
             end;
    end;

    Texto := '<?xml version="1.0" encoding="utf-8"?>';
    Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
    Texto := Texto +   '<soap12:Header>';
    Texto := Texto +     '<nfeCabecMsg xmlns="'+SoapAction+'">';
    Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';

    if nfeAutorizacaoLote then
      Texto := Texto + '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                      FConfiguracoes.Geral.VersaoDF,
                                                      LayNfeRetAutorizacao) +
                       '</versaoDados>'
    else
      Texto := Texto + '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                      FConfiguracoes.Geral.VersaoDF,
                                                      LayNfeRetRecepcao) +
                       '</versaoDados>';

    Texto := Texto +     '</nfeCabecMsg>';
    Texto := Texto +   '</soap12:Header>';
    Texto := Texto +   '<soap12:Body>';
    Texto := Texto +     '<nfeDadosMsg xmlns="'+SoapAction+'">';
    Texto := Texto + FDadosMsg;
    Texto := Texto +     '</nfeDadosMsg>';
    Texto := Texto +   '</soap12:Body>';
    Texto := Texto +'</soap12:Envelope>';


    FNFeRetorno := TRetConsReciNFe.Create;
    try
      TACBrNFe( FACBrNFe ).SetStatus( stNfeRetRecepcao );

      if FConfiguracoes.Geral.Salvar then
       begin
         FPathArqEnv := Recibo+'-ped-rec.xml';
         FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);
       end;

      if FConfiguracoes.WebServices.Salvar then
       begin
         FPathArqEnv := Recibo+'-ped-rec-soap.xml';
         FConfiguracoes.Geral.Save(FPathArqEnv, Texto);
       end;

      FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);

      if nfeAutorizacaoLote then
       begin
         FRetWS := SeparaDados( FRetornoWS,'nfeRetAutorizacaoResult');
         if FRetWS = '' then
            FRetWS := SeparaDados( FRetornoWS,'nfeRetAutorizacaoLoteResult');
       end
      else
        FRetWS := SeparaDados( FRetornoWS,'nfeRetRecepcao2Result');

      if FConfiguracoes.Geral.Salvar then
       begin
         FPathArqResp := Recibo+'-pro-rec.xml';
         FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);
       end;

      if FConfiguracoes.WebServices.Salvar then
       begin
         FPathArqResp := Recibo+'-pro-rec-soap.xml';
         FConfiguracoes.Geral.Save(FPathArqResp, FRetornoWS);
       end;

      FNFeRetorno.Leitor.Arquivo := FRetWS;
      FNFeRetorno.LerXML;

      TACBrNFe( FACBrNFe ).SetStatus( stIdle );
      aMsg := //'Versão Leiaute : '+FNFeRetorno.Versao+LineBreak+
              'Ambiente : '+TpAmbToStr(FNFeRetorno.TpAmb)+LineBreak+
              'Versão Aplicativo : '+FNFeRetorno.verAplic+LineBreak+
              'Recibo : '+FNFeRetorno.nRec+LineBreak+
              'Status Código : '+IntToStr(FNFeRetorno.cStat)+LineBreak+
              'Status Descrição : '+FNFeRetorno.xMotivo+LineBreak+
              'UF : '+CodigoParaUF(FNFeRetorno.cUF)+LineBreak+
              'cMsg : '+IntToStr(FNFeRetorno.cMsg)+LineBreak+
              'xMsg : '+FNFeRetorno.xMsg+LineBreak;
      if FConfiguracoes.WebServices.Visualizar then
         ShowMessage(aMsg);

      if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
         TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

      FTpAmb    := FNFeRetorno.TpAmb;
      FverAplic := FNFeRetorno.verAplic;
      FcStat    := FNFeRetorno.cStat;
      FcUF      := FNFeRetorno.cUF;
      FMsg      := FNFeRetorno.xMotivo;
      FxMotivo  := FNFeRetorno.xMotivo;
      FcMsg     := FNFeRetorno.cMsg;
      FxMsg     := FNFeRetorno.xMsg;

      Result := FNFeRetorno.CStat = 105;
      if FNFeRetorno.CStat = 104 then
      begin
         FMsg   := FNFeRetorno.ProtNFe.Items[0].xMotivo;
         FxMotivo  := FNFeRetorno.ProtNFe.Items[0].xMotivo;
      end;

    finally
      NotaUtil.ConfAmbiente;
      TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    end;
  end;

var
  vCont: Integer;
begin
  inherited Executar;
  Result := False;

  TACBrNFe( FACBrNFe ).SetStatus( stNfeRetRecepcao );
  Sleep(TACBrNFe( FACBrNFe ).Configuracoes.WebServices.AguardarConsultaRet);
  vCont := 1000;

  while Processando do
  begin
    if TACBrNFe( FACBrNFe ).Configuracoes.WebServices.IntervaloTentativas > 0 then
       sleep(TACBrNFe( FACBrNFe ).Configuracoes.WebServices.IntervaloTentativas)
    else
       sleep(vCont);



    if vCont > (TACBrNFe( FACBrNFe ).Configuracoes.WebServices.Tentativas*1000) then
      break;

    vCont := vCont +1000;
  end;
  TACBrNFe( FACBrNFe ).SetStatus( stIdle );

  if FNFeRetorno.CStat = 104 then
   begin
    Result := Confirma(FNFeRetorno.ProtNFe);
    fChaveNfe  := FNFeRetorno.ProtNFe.Items[0].chNFe;
    fProtocolo := FNFeRetorno.ProtNFe.Items[0].nProt;
    fcStat     := FNFeRetorno.ProtNFe.Items[0].cStat;
   end;
end;

{ TNFeRecibo }
constructor TNFeRecibo.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

destructor TNFeRecibo.destroy;
begin
   if assigned(FNFeRetorno) then
      FNFeRetorno.Free;
  inherited;
end;

function TNFeRecibo.Executar: Boolean;
var
 aMsg, Texto, SoapAction: string;
 nfeAutorizacaoLote : boolean;
begin
  if assigned(FNFeRetorno) then
    FNFeRetorno.Free;

  inherited Executar;

  // Alterado por Italo em 05/08/2014
  case FConfiguracoes.Geral.ModeloDF of
   moNFe:  begin
//            if (FConfiguracoes.Geral.VersaoDF = ve310) and not
//               (FConfiguracoes.WebServices.UFCodigo in [23])  then // CE
            if (FConfiguracoes.Geral.VersaoDF = ve310) then
             begin
               SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetAutorizacao';
               nfeAutorizacaoLote := True;
             end
            else
             begin
               SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao2';
               nfeAutorizacaoLote := False;
             end;
           end;
           // Até o momento somente as UF: AC-Acre, AM-Amazonas, MA-Maranhão,
           // MT-Mato Grosso, RN-Rio Grande do Norte, RS-Rio Grande do Sul e
           // SE-Sergipe participam do projeto da NFC-e
   moNFCe: begin
            if (FConfiguracoes.Geral.VersaoDF = ve310) and not
               (FConfiguracoes.WebServices.UFCodigo in [13])  then // AM
             begin
               SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetAutorizacao';
               nfeAutorizacaoLote := True;
             end
            else
             begin
               SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeRetRecepcao2';
               nfeAutorizacaoLote := False;
             end;
           end;
  end;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<nfeCabecMsg xmlns="' + SoapAction + '">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';

  if nfeAutorizacaoLote then
    Texto := Texto +       '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                          FConfiguracoes.Geral.VersaoDF,
                                                          LayNfeRetAutorizacao) +
                           '</versaoDados>'
  else
    Texto := Texto +       '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                          FConfiguracoes.Geral.VersaoDF,
                                                          LayNfeRetRecepcao) +
                           '</versaoDados>';

  Texto := Texto +     '</nfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<nfeDadosMsg xmlns="' + SoapAction + '">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</nfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto +'</soap12:Envelope>';

 FNFeRetorno := TRetConsReciNFe.Create;
 try
   TACBrNFe( FACBrNFe ).SetStatus( stNfeRetRecepcao );

   if FConfiguracoes.Geral.Salvar then
    begin
      FPathArqEnv := Recibo+'-ped-rec.xml';
      FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);
    end;

   if FConfiguracoes.WebServices.Salvar then
    begin
      FPathArqEnv := Recibo+'-ped-rec-soap.xml';
      FConfiguracoes.Geral.Save(FPathArqEnv, Texto);
    end;

    FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);

    if nfeAutorizacaoLote then
     begin
       FRetWS := SeparaDados( FRetornoWS,'nfeRetAutorizacaoResult');
       if FRetWS = '' then
         FRetWS := SeparaDados( FRetornoWS,'nfeRetAutorizacaoLoteResult');
     end
    else
       FRetWS := SeparaDados( FRetornoWS,'nfeRetRecepcao2Result');

   if FConfiguracoes.Geral.Salvar then
    begin
      FPathArqResp := Recibo+'-pro-rec.xml';
      FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);
    end;

   if FConfiguracoes.WebServices.Salvar then
    begin
      FPathArqResp := Recibo+'-pro-rec-soap.xml';
      FConfiguracoes.Geral.Save(FPathArqResp, FRetornoWS);
    end;

   FNFeRetorno.Leitor.Arquivo := FRetWS;
   FNFeRetorno.LerXML;

   TACBrNFe( FACBrNFe ).SetStatus( stIdle );
   aMsg := //'Versão Leiaute : '+FNFeRetorno.Versao+LineBreak+
           'Ambiente : '+TpAmbToStr(FNFeRetorno.TpAmb)+LineBreak+
           'Versão Aplicativo : '+FNFeRetorno.verAplic+LineBreak+
           'Recibo : '+FNFeRetorno.nRec+LineBreak+
           'Status Código : '+IntToStr(FNFeRetorno.cStat)+LineBreak+
           'Status Descrição : '+FNFeRetorno.ProtNFe.Items[0].xMotivo+LineBreak+
           'UF : '+CodigoParaUF(FNFeRetorno.cUF)+LineBreak;
   if FConfiguracoes.WebServices.Visualizar then
     ShowMessage(aMsg);

   if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
      TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

   FTpAmb    := FNFeRetorno.TpAmb;
   FverAplic := FNFeRetorno.verAplic;
   FcStat    := FNFeRetorno.cStat;
   FxMotivo  := FNFeRetorno.xMotivo;
   FcUF      := FNFeRetorno.cUF;
   FxMsg     := FNFeRetorno.xMsg;
   FcMsg     := FNFeRetorno.cMsg;

   Result := FNFeRetorno.CStat = 104;
   FMsg   := FNFeRetorno.xMotivo;

 finally
   NotaUtil.ConfAmbiente;
   TACBrNFe( FACBrNFe ).SetStatus( stIdle );
 end;
end;

{ TNFeConsulta }
constructor TNFeConsulta.Create(AOwner: TComponent);
begin
  FConfiguracoes := TConfiguracoes( TACBrNFe( AOwner ).Configuracoes );
  FACBrNFe       := TACBrNFe( AOwner );

  FprotNFe:= TProcNFe.Create;
  FretCancNFe:= TRetCancNFe.Create;
  FprocEventoNFe := TRetEventoNFeCollection.Create(AOwner);
end;

destructor TNFeConsulta.Destroy;
begin
  FprotNFe.Free;
  FretCancNFe.Free;
  if Assigned(FprocEventoNFe) then
    FprocEventoNFe.Free;
end;

function TNFeConsulta.Executar: Boolean;
var
  NFeRetorno: TRetConsSitNFe;
  aMsg, aEventos: WideString;
  AProcNFe: TProcNFe;
  i, j: Integer;
  Texto, SoapAction, Metodo, TAGResult: String;
  wAtualiza, NFCancelada: Boolean;
begin
  inherited Executar;

  // Alterações realizadas por Italo em 25/08/2014
  if (FConfiguracoes.WebServices.UFCodigo in [29, 41]) and (FConfiguracoes.Geral.VersaoDF = ve310) then // 29 = BA
  begin
    Metodo    := 'NfeConsulta';
    TAGResult := 'NfeConsultaNFResult';
  end
  else begin
    Metodo    := 'NfeConsulta2';
    TAGResult := 'NfeConsultaNF2Result';
  end;

  SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/' + Metodo;  

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<nfeCabecMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/' + Metodo + '">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';

  Texto := Texto + '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                  FConfiguracoes.Geral.VersaoDF,
                                                  LayNfeConsulta) +
                   '</versaoDados>';

  Texto := Texto +     '</nfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<nfeDadosMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/' + Metodo + '">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</nfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto +'</soap12:Envelope>';

  NFeRetorno := TRetConsSitNFe.Create;
  try
    TACBrNFe( FACBrNFe ).SetStatus( stNfeConsulta );

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqEnv := FNFeChave+'-ped-sit.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);
     end;

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqEnv := FNFeChave+'-ped-sit-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, Texto);
     end;

    FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);
    FRetWS := SeparaDados(FRetornoWS, TAGResult);

    if FConfiguracoes.Geral.Salvar  then
     begin
       FPathArqResp := FNFeChave+'-sit.xml';
       FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);
     end;

    if FConfiguracoes.WebServices.Salvar  then
     begin
       FPathArqResp := FNFeChave+'-sit-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqResp, FRetornoWS);
     end;

    NFeRetorno.Leitor.Arquivo := FRetWS;
    NFeRetorno.LerXML;

    NFCancelada := False;

    if Assigned(NFeRetorno.procEventoNFe) then // Incluido por Leonardo Gregianin em 08/01/2014 - resolver problema de violação de acesso
    if NFeRetorno.procEventoNFe.Count > 0 then
      aEventos := '=====================================================' +
                  LineBreak +
                  '================== Eventos da NF-e ==================' +
                  LineBreak +
                  '====================================================='+
                  LineBreak + '' + LineBreak +
                  'Quantidade total de eventos: ' +
                  IntToStr(NFeRetorno.procEventoNFe.Count);

    // <retConsSitNFe> - Retorno da consulta da situação da NF-e
    // Este é o status oficial da NF-e
    FTpAmb      := NFeRetorno.TpAmb;
    FverAplic   := NFeRetorno.verAplic;
    FcStat      := NFeRetorno.cStat;
    FxMotivo    := NFeRetorno.xMotivo;
    FcUF        := NFeRetorno.cUF;
    FNFeChave   := NFeRetorno.chNFe;

    // Verifica se a nota fiscal está cancelada pelo método antigo. Se estiver,
    // então NFCancelada será True e já atribui Protocolo, Data e Mensagem
    if NFeRetorno.retCancNFe.cStat > 0 then
      begin
        FretCancNFe.tpAmb    := NFeRetorno.retCancNFe.tpAmb;
        FretCancNFe.verAplic := NFeRetorno.retCancNFe.verAplic;
        FretCancNFe.cStat    := NFeRetorno.retCancNFe.cStat;
        FretCancNFe.xMotivo  := NFeRetorno.retCancNFe.xMotivo;
        FretCancNFe.cUF      := NFeRetorno.retCancNFe.cUF;
        FretCancNFe.chNFE    := NFeRetorno.retCancNFe.chNFE;
        FretCancNFe.dhRecbto := NFeRetorno.retCancNFe.dhRecbto;
        FretCancNFe.nProt    := NFeRetorno.retCancNFe.nProt;

        NFCancelada := True;
        FProtocolo  := NFeRetorno.retCancNFe.nProt;
        FDhRecbto   := NFeRetorno.retCancNFe.dhRecbto;
        FMsg        := NFeRetorno.xMotivo;
      end;

    // <protNFe> - Retorno dos dados do ENVIO da NF-e
    // Considerá-los apenas se não existir nenhum evento de cancelamento (110111)
    FprotNFe.PathNFe            := NFeRetorno.protNFe.PathNFe;
    FprotNFe.PathRetConsReciNFe := NFeRetorno.protNFe.PathRetConsReciNFe;
    FprotNFe.PathRetConsSitNFe  := NFeRetorno.protNFe.PathRetConsSitNFe;
    FprotNFe.PathRetConsSitNFe  := NFeRetorno.protNFe.PathRetConsSitNFe;
    FprotNFe.tpAmb              := NFeRetorno.protNFe.tpAmb;
    FprotNFe.verAplic           := NFeRetorno.protNFe.verAplic;
    FprotNFe.chNFe              := NFeRetorno.protNFe.chNFe;
    FprotNFe.dhRecbto           := NFeRetorno.protNFe.dhRecbto;
    FprotNFe.nProt              := NFeRetorno.protNFe.nProt;
    FprotNFe.digVal             := NFeRetorno.protNFe.digVal;
    FprotNFe.cStat              := NFeRetorno.protNFe.cStat;
    FprotNFe.xMotivo            := NFeRetorno.protNFe.xMotivo;

    //{eventos_juaumkiko}
    if Assigned(NFeRetorno.procEventoNFe) then begin // Incluido por Leonardo Gregianin em 08/01/2014 - resolver problema de violação de acesso
    FprocEventoNFe.Clear;
    for I := 0 to NFeRetorno.procEventoNFe.Count -1 do
    begin
      FprocEventoNFe.Add;
      FprocEventoNFe.Items[I].RetEventoNFe.idLote   := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.idLote;
      FprocEventoNFe.Items[I].RetEventoNFe.tpAmb    := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.tpAmb;
      FprocEventoNFe.Items[I].RetEventoNFe.verAplic := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.verAplic;
      FprocEventoNFe.Items[I].RetEventoNFe.cOrgao   := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.cOrgao;
      FprocEventoNFe.Items[I].RetEventoNFe.cStat    := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.cStat;
      FprocEventoNFe.Items[I].RetEventoNFe.xMotivo  := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.xMotivo;
      FprocEventoNFe.Items[I].RetEventoNFe.XML      := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.XML;

      FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.ID := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.ID;
      FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.tpAmb := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.tpAmb;
      FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.CNPJ := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.CNPJ;
      FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.chNFe := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.chNFe;
      FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.dhEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.dhEvento;
      FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.TpEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.TpEvento;
      FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.nSeqEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.nSeqEvento;
      FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.VersaoEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.VersaoEvento;
      FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.xCorrecao := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.xCorrecao;
      FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.xCondUso := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.xCondUso;
      FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.nProt := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.nProt;
      FprocEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.xJust := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.DetEvento.xJust;
      FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Clear;
      for j := 0 to NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Count-1 do
      begin
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Add;
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.Id := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.Id;
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.tpAmb := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.tpAmb;
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.verAplic := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.verAplic;
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.cOrgao := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.cOrgao;
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.cStat := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.cStat;
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.xMotivo := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.xMotivo;
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.chNFe := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.chNFe;
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.tpEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.tpEvento;
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.xEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.xEvento;
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.nSeqEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.nSeqEvento;
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.CNPJDest := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.CNPJDest;
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.emailDest := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.emailDest;
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.dhRegEvento := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.dhRegEvento;
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.nProt := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.nProt;
        FprocEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.XML := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.XML;

        aEventos := aEventos + LineBreak + '' + LineBreak +
                    'Número de sequência: ' + IntToStr(NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.nSeqEvento) + LineBreak +
                    'Código do evento: ' + TpEventoToStr(NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.TpEvento) + LineBreak +
                    'Descrição do evento: ' + NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.InfEvento.DescEvento + LineBreak +
                    'Status do evento: ' + IntToStr(NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.cStat) + LineBreak +
                    'Descrição do status: ' + NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.xMotivo + LineBreak +
                    'Protocolo: ' + NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.nProt + LineBreak +
                    'Data / hora do registro: ' + DateTimeToStr(NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.dhRegEvento);

        if NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.tpEvento = teCancelamento then
          begin
            NFCancelada := True;
            FProtocolo  := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.nProt;
            FDhRecbto   := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.dhRegEvento;
            FMsg        := NFeRetorno.procEventoNFe.Items[I].RetEventoNFe.retEvento.Items[j].RetInfEvento.xMotivo;
          end;
      end;
    end;
    end;

    //FProtocolo  := DFeUtil.SeSenao(DFeUtil.NaoEstaVazio(NFeRetorno.retCancNFe.nProt),NFeRetorno.retCancNFe.nProt,NFeRetorno.protNFe.nProt);
    //FDhRecbto   := DFeUtil.SeSenao(NFeRetorno.retCancNFe.dhRecbto <> 0,NFeRetorno.retCancNFe.dhRecbto,NFeRetorno.protNFe.dhRecbto);
    //FMsg        := NFeRetorno.XMotivo;

    if NFCancelada = False then
      begin
        FProtocolo := NFeRetorno.protNFe.nProt;
        FDhRecbto  := NFeRetorno.protNFe.dhRecbto;
        FMsg       := NFeRetorno.protNFe.xMotivo;
      end;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );

    aMsg := //'Versão Leiaute : '+NFeRetorno.Versao+LineBreak+
            'Identificador : '     + FNFeChave + LineBreak +
            'Ambiente : '          + TpAmbToStr(FTpAmb) + LineBreak +
            'Versão Aplicativo : ' + FverAplic + LineBreak+
            'Status Código : '     + IntToStr(FcStat) + LineBreak+
            'Status Descrição : '  + FXMotivo + LineBreak +
            'UF : '                + CodigoParaUF(FcUF) + LineBreak +
            'Chave Acesso : '      + FNFeChave + LineBreak +
            'Recebimento : '       + DateTimeToStr(FDhRecbto) + LineBreak +
            'Protocolo : '         + FProtocolo + LineBreak +
            'Digest Value : '      + NFeRetorno.protNFe.digVal + LineBreak;

    if Assigned(NFeRetorno.procEventoNFe) then // Incluido por Leonardo Gregianin em 08/01/2014 - resolver problema de violação de acesso
    if NFeRetorno.procEventoNFe.Count > 0 then
      aMsg := aMsg + LineBreak + aEventos;

    if FConfiguracoes.WebServices.Visualizar then
      ShowMessage(aMsg);

    if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
       TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

    Result := (NFeRetorno.CStat in [100,101,110,150,151,155]);

    for i:= 0 to TACBrNFe( FACBrNFe ).NotasFiscais.Count-1 do
     begin
        if StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.infNFe.ID,'NFe','',[rfIgnoreCase]) = FNFeChave then
         begin
            watualiza:=true;
            if ((NFeRetorno.CStat in [101,151,155]) and
                (FConfiguracoes.Geral.AtualizarXMLCancelado=false)) then
               wAtualiza:=False;

            TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].Confirmada := (NFeRetorno.cStat in [100,150]);
            if wAtualiza then
            begin
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].Msg                  := NFeRetorno.xMotivo;
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.tpAmb    := NFeRetorno.tpAmb;
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.verAplic := NFeRetorno.verAplic;
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.chNFe    := NFeRetorno.chNfe;
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.dhRecbto := FDhRecbto;
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.nProt    := FProtocolo;
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.digVal   := NFeRetorno.protNFe.digVal;
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.cStat    := NFeRetorno.cStat;
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.xMotivo  := NFeRetorno.xMotivo;
            end;

            if ((FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeChave+'-nfe.xml') or DFeUtil.NaoEstaVazio(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq))
               and wAtualiza) then
            begin
             AProcNFe:=TProcNFe.Create;
             if DFeUtil.NaoEstaVazio(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq) then
                AProcNFe.PathNFe:=TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq
             else
                AProcNFe.PathNFe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeChave+'-nfe.xml';
             AProcNFe.PathRetConsSitNFe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeChave+'-sit.xml';

             if FConfiguracoes.Geral.VersaoDF = ve310 then
               AProcNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                               FConfiguracoes.Geral.VersaoDF,
                                               LayNfeAutorizacao)
             else
               AProcNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                               FConfiguracoes.Geral.VersaoDF,
                                               LayNfeRecepcao);

             AProcNFe.GerarXML;

             if DFeUtil.NaoEstaVazio(AProcNFe.Gerador.ArquivoFormatoXML) then
                AProcNFe.Gerador.SalvarArquivo(AProcNFe.PathNFe);

             AProcNFe.Free;
            end;

            if FConfiguracoes.Arquivos.Salvar and wAtualiza then
            begin
              if FConfiguracoes.Arquivos.EmissaoPathNFe then
                 TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Ide.dEmi,
                                                                                                                        TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Emit.CNPJCPF))
                                                                                                                        +StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml')
              else
                 TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(now,
                                                                                                                        TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Emit.CNPJCPF))
                                                                                                                        +StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml')

            end;

            break;
         end;
     end;

    //NFeRetorno.Free;

    if (TACBrNFe( FACBrNFe ).NotasFiscais.Count <= 0) then
     begin
       if FConfiguracoes.Geral.Salvar then
        begin
          if FileExists(PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeChave+'-nfe.xml') then
           begin
             AProcNFe:=TProcNFe.Create;
             AProcNFe.PathNFe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeChave+'-nfe.xml';
             AProcNFe.PathRetConsSitNFe:=PathWithDelim(FConfiguracoes.Geral.PathSalvar)+FNFeChave+'-sit.xml';

             if FConfiguracoes.Geral.VersaoDF = ve310 then
               AProcNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                               FConfiguracoes.Geral.VersaoDF,
                                               LayNfeAutorizacao)
             else
               AProcNFe.Versao := GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                               FConfiguracoes.Geral.VersaoDF,
                                               LayNfeRecepcao);

             AProcNFe.GerarXML;

             if DFeUtil.NaoEstaVazio(AProcNFe.Gerador.ArquivoFormatoXML) then
                AProcNFe.Gerador.SalvarArquivo(AProcNFe.PathNFe);

             AProcNFe.Free;
           end;
        end;
     end;
  finally
    NFeRetorno.Free; //(se descomentar essa linha não será possível ler a propriedade ACBrNFe1.WebServices.Consulta.protNFe.nProt)
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

{ TNFeCancelamento }
function TNFeCancelamento.Executar: Boolean;
var
  NFeRetorno: TRetCancNFe;
  aMsg, SoapAction: string;
  i : Integer;
  Texto : String;
  wPROC: TStringList;
begin
  inherited Executar;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<nfeCabecMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeCancelamento2">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';

  Texto := Texto + '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                  FConfiguracoes.Geral.VersaoDF,
                                                  LayNfeCancelamento) +
                   '</versaoDados>';

  Texto := Texto +     '</nfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<nfeDadosMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeCancelamento2">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</nfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto +'</soap12:Envelope>';

  SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeCancelamento2';

  NFeRetorno := TRetCancNFe.Create;
  try
    TACBrNFe( FACBrNFe ).SetStatus( stNfeCancelamento );

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqEnv := FNFeChave+'-ped-can.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);
     end;

     if FConfiguracoes.Arquivos.Salvar then
         FConfiguracoes.Geral.Save(FNFeChave+'-ped-can.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathCan(IfThen(FConfiguracoes.Arquivos.SepararPorCNPJ,NotaUtil.ExtraiCNPJChaveAcesso(TACBrNFe( FACBrNFe ).WebServices.Cancelamento.NFeChave),'')) );

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqEnv := FNFeChave+'-ped-can-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, Texto);
     end;

    FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);
    FRetWS := SeparaDados( FRetornoWS,'nfeCancelamentoNF2Result');

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqResp := FNFeChave+'-can.xml';
       FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);
     end;

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(FNFeChave+'-can.xml', FRetWS, FConfiguracoes.Arquivos.GetPathCan(IfThen(FConfiguracoes.Arquivos.SepararPorCNPJ,NotaUtil.ExtraiCNPJChaveAcesso(TACBrNFe( FACBrNFe ).WebServices.Cancelamento.NFeChave),'')) );

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqResp := FNFeChave+'-can-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqResp, FRetornoWS);
     end;

    NFeRetorno.Leitor.Arquivo := FRetWS;
    NFeRetorno.LerXml;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    aMsg := //'Versão Leiaute : '+NFeRetorno.Versao+LineBreak+
            'Identificador : '+ NFeRetorno.chNFE+LineBreak+
            'Ambiente : '+TpAmbToStr(NFeRetorno.TpAmb)+LineBreak+
            'Versão Aplicativo : '+NFeRetorno.verAplic+LineBreak+
            'Status Código : '+IntToStr(NFeRetorno.cStat)+LineBreak+
            'Status Descrição : '+NFeRetorno.xMotivo+LineBreak+
            'UF : '+CodigoParaUF(NFeRetorno.cUF)+LineBreak+
            'Chave Acesso : '+NFeRetorno.chNFE+LineBreak+
            'Recebimento : '+DFeUtil.SeSenao(NFeRetorno.DhRecbto = 0, '', DateTimeToStr(NFeRetorno.DhRecbto))+LineBreak+
            'Protocolo : '+NFeRetorno.nProt+LineBreak;

    if FConfiguracoes.WebServices.Visualizar then
      ShowMessage(aMsg);

    if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
       TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

    FTpAmb    := NFeRetorno.TpAmb;
    FverAplic := NFeRetorno.verAplic;
    FcStat    := NFeRetorno.cStat;
    FxMotivo  := NFeRetorno.xMotivo;
    FcUF      := NFeRetorno.cUF;
    FDhRecbto := NFeRetorno.dhRecbto;
    Fprotocolo:= NFeRetorno.nProt;

    FMsg   := NFeRetorno.XMotivo;
    Result := (NFeRetorno.CStat in [101,151,155]);

    for i:= 0 to TACBrNFe( FACBrNFe ).NotasFiscais.Count-1 do
     begin
        if StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.infNFe.ID,'NFe','',[rfIgnoreCase]) = NFeRetorno.chNFE then
         begin
           if (FConfiguracoes.Geral.AtualizarXMLCancelado) then
           begin
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].Msg        := NFeRetorno.xMotivo;
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.tpAmb    := NFeRetorno.tpAmb;
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.verAplic := NFeRetorno.verAplic;
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.chNFe    := NFeRetorno.chNFe;
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.dhRecbto := NFeRetorno.dhRecbto;
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.nProt    := NFeRetorno.nProt;
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.cStat    := NFeRetorno.cStat;
              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.procNFe.xMotivo  := NFeRetorno.xMotivo;
           end;

           if FConfiguracoes.Arquivos.Salvar or DFeUtil.NaoEstaVazio(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq) then
            begin
              if ((NFeRetorno.CStat in [101,151,155]) and
                  (FConfiguracoes.Geral.AtualizarXMLCancelado)) then
              begin
                 if DFeUtil.NaoEstaVazio(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq) then
                    TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NomeArq)
                 else
                 begin
                    if FConfiguracoes.Arquivos.EmissaoPathNFe then
                       TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Ide.dEmi,
                                                                                                                              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Emit.CNPJCPF))
                                                                                                                              +StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml')
                    else
                       TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(PathWithDelim(FConfiguracoes.Arquivos.GetPathNFe(now,
                                                                                                                              TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.Emit.CNPJCPF))
                                                                                                                              +StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.InfNFe.Id,'NFe','',[rfIgnoreCase])+'-nfe.xml')

                 end;
              end;
            end;

           break;
         end;
     end;

    //gerar arquivo proc de cancelamento
    if (NFeRetorno.cStat in [101,151,155]) then
    begin
      wProc := TStringList.Create;
      wProc.Add('<?xml version="1.0" encoding="UTF-8" ?>');
//      wProc.Add('<procCancNFe versao="2.00" xmlns="http://www.portalfiscal.inf.br/nfe">');

      wProc.Add('<procCancNFe versao="' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                       FConfiguracoes.Geral.VersaoDF,
                                                       LayNfeCancelamento)+
                               '" xmlns="http://www.portalfiscal.inf.br/nfe">');
      wProc.Add(FDadosMSG);
      wProc.Add(FRetWS);
      wProc.Add('</procCancNFe>');
      FXML_ProcCancNFe:=wProc.Text;
      wProc.Free;
      if FConfiguracoes.Geral.Salvar then
         FConfiguracoes.Geral.Save(FNFeChave+'-ProcCancNFe.xml', FXML_ProcCancNFe);

      if FConfiguracoes.Arquivos.Salvar then
        FConfiguracoes.Geral.Save(FNFeChave+'-ProcCancNFe.xml', FXML_ProcCancNFe, FConfiguracoes.Arquivos.GetPathCan(IfThen(FConfiguracoes.Arquivos.SepararPorCNPJ,NotaUtil.ExtraiCNPJChaveAcesso(TACBrNFe( FACBrNFe ).WebServices.Cancelamento.NFeChave),'')) );
    end;

  finally
    NFeRetorno.Free; //(se descomentar essa linha não será possível ler a propriedade ACBrNFe1.WebServices.Consulta.protNFe)
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

procedure TNFeCancelamento.SetJustificativa(AValue: WideString);
begin
  if DFeUtil.EstaVazio(AValue) then
   begin
     if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
        TACBrNFe( FACBrNFe ).OnGerarLog('ERRO: Informar uma Justificativa para cancelar a Nota Fiscal Eletronica');
     raise EACBrNFeException.Create('Informar uma Justificativa para cancelar a Nota Fiscal Eletronica')
   end
  else
    AValue := DFeUtil.TrataString(AValue);

  if Length(AValue) < 15 then
   begin
     if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
        TACBrNFe( FACBrNFe ).OnGerarLog('ERRO: A Justificativa para Cancelamento da Nota Fiscal Eletronica deve ter no minimo 15 caracteres');
     raise EACBrNFeException.Create('A Justificativa para Cancelamento da Nota Fiscal Eletronica deve ter no minimo 15 caracteres')
   end
  else
    FJustificativa := Trim(AValue);
end;

{ TNFeInutilizacao }
function TNFeInutilizacao.Executar: Boolean;
var
  NFeRetorno: TRetInutNFe;
  aMsg, SoapAction, Servico: String;
  Texto : String;
  wProc  : TStringList ;
begin
  inherited Executar;

  if (FConfiguracoes.WebServices.UFCodigo in [29]) and (FConfiguracoes.Geral.VersaoDF = ve310) then // 29 = BA
  begin
    Servico := 'NfeInutilizacao';
    SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/' + Servico + '/NfeInutilizacao';
  end
  else
  begin
    Servico := 'NfeInutilizacao2';
    SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/' + Servico;
  end;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<nfeCabecMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/' + Servico + '">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';

  Texto := Texto + '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                  FConfiguracoes.Geral.VersaoDF,
                                                  LayNfeInutilizacao) +
                   '</versaoDados>';

  Texto := Texto +     '</nfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<nfeDadosMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/' + Servico + '">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</nfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto +'</soap12:Envelope>';

  NFeRetorno := TRetInutNFe.Create;
  try
    TACBrNFe( FACBrNFe ).SetStatus( stNfeInutilizacao );

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqEnv := StringReplace(FID,'ID','',[rfIgnoreCase])+'-ped-inu.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);
     end;

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(StringReplace(FID,'ID','',[rfIgnoreCase])+'-ped-inu.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathInu(IfThen(FConfiguracoes.Arquivos.SepararPorCNPJ,TACBrNFe( FACBrNFe ).WebServices.Inutilizacao.CNPJ,'')));

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqEnv := StringReplace(FID,'ID','',[rfIgnoreCase])+'-ped-inu-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, Texto);
     end;

    FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);
    FRetWS := SeparaDados( FRetornoWS,'nfeInutilizacaoNF2Result');
    if FRetWS = '' then
      FRetWS := SeparaDados( FRetornoWS,'nfeInutilizacaoNFResult');

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqResp := StringReplace(FID,'ID','',[rfIgnoreCase])+'-inu.xml';
       FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);
     end;

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(StringReplace(FID,'ID','',[rfIgnoreCase])+'-inu.xml', FRetWS, FConfiguracoes.Arquivos.GetPathInu(IfThen(FConfiguracoes.Arquivos.SepararPorCNPJ,TACBrNFe( FACBrNFe ).WebServices.Inutilizacao.CNPJ,'')));

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqResp := StringReplace(FID,'ID','',[rfIgnoreCase])+'-inu-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqResp, FRetornoWS);
     end;

    NFeRetorno.Leitor.Arquivo := FRetWS;
    NFeRetorno.LerXml;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    aMsg := 'Ambiente : '+TpAmbToStr(NFeRetorno.TpAmb)+LineBreak+
            'Versão Aplicativo : '+NFeRetorno.verAplic+LineBreak+
            'Status Código : '+IntToStr(NFeRetorno.cStat)+LineBreak+
            'Status Descrição : '+NFeRetorno.xMotivo+LineBreak+
            'UF : '+CodigoParaUF(NFeRetorno.cUF)+LineBreak+
            'Recebimento : '+DFeUtil.SeSenao(NFeRetorno.DhRecbto = 0, '', DateTimeToStr(NFeRetorno.dhRecbto));
    if FConfiguracoes.WebServices.Visualizar then
      ShowMessage(aMsg);

    if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
       TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

    FTpAmb    := NFeRetorno.TpAmb;
    FverAplic := NFeRetorno.verAplic;
    FcStat    := NFeRetorno.cStat;
    FxMotivo  := NFeRetorno.xMotivo;
    FcUF      := NFeRetorno.cUF ;
    FdhRecbto := NFeRetorno.dhRecbto;
    Fprotocolo:= NFeRetorno.nProt;
    FMsg   := NFeRetorno.XMotivo;
    Result := (NFeRetorno.cStat = 102);

    //gerar arquivo proc de inutilizacao
    if ((NFeRetorno.cStat = 102) or (NFeRetorno.cStat = 563)) then
    begin
      wProc := TStringList.Create;
      wProc.Add('<?xml version="1.0" encoding="UTF-8" ?>');
//      wProc.Add('<ProcInutNFe versao="2.00" xmlns="http://www.portalfiscal.inf.br/nfe">');

      wProc.Add('<ProcInutNFe versao="' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                       FConfiguracoes.Geral.VersaoDF,
                                                       LayNfeInutilizacao) +
                               '" xmlns="http://www.portalfiscal.inf.br/nfe">');

      wProc.Add(FDadosMSG);
      wProc.Add(FRetWS);
      wProc.Add('</ProcInutNFe>');
      FXML_ProcInutNFe:=wProc.Text;
      wProc.Free;
      if FConfiguracoes.Geral.Salvar then
         FConfiguracoes.Geral.Save(StringReplace(FID,'ID','',[rfIgnoreCase])+'-ProcInutNFe.xml', FXML_ProcInutNFe);
      if FConfiguracoes.Arquivos.Salvar then
         FConfiguracoes.Geral.Save(StringReplace(FID,'ID','',[rfIgnoreCase])+'-ProcInutNFe.xml', FXML_ProcInutNFe, FConfiguracoes.Arquivos.GetPathInu(IfThen(FConfiguracoes.Arquivos.SepararPorCNPJ,TACBrNFe( FACBrNFe ).WebServices.Inutilizacao.CNPJ,'')) );
    end;

  finally
    NFeRetorno.Free; //(se descomentar essa linha não será possível ler a propriedade ACBrNFe1.WebServices.Consulta.protNFe)
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

procedure TNFeInutilizacao.SetJustificativa(AValue: WideString);
begin
  if DFeUtil.EstaVazio(AValue) then
   begin
     if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
        TACBrNFe( FACBrNFe ).OnGerarLog('ERRO: Informar uma Justificativa para Inutilização de numeração da Nota Fiscal Eletronica');
     raise EACBrNFeException.Create('Informar uma Justificativa para Inutilização de numeração da Nota Fiscal Eletronica')
   end
  else
    AValue := DFeUtil.TrataString(AValue);

  if Length(Trim(AValue)) < 15 then
   begin
     if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
        TACBrNFe( FACBrNFe ).OnGerarLog('ERRO: A Justificativa para Inutilização de numeração da Nota Fiscal Eletronica deve ter no minimo 15 caracteres');
     raise EACBrNFeException.Create('A Justificativa para Inutilização de numeração da Nota Fiscal Eletronica deve ter no minimo 15 caracteres')
   end
  else
    FJustificativa := Trim(AValue);
end;

{ TNFeConsultaCadastro }
destructor TNFeConsultaCadastro.destroy;
begin
  FRetConsCad.Free;

  inherited;
end;

function TNFeConsultaCadastro.Executar: Boolean;
var
  aMsg, SoapAction : String;
  Texto : String;
begin
  if assigned(FRetConsCad) then
     FreeAndNil(FRetConsCad);

  inherited Executar;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<nfeCabecMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/CadConsultaCadastro2">';
  Texto := Texto +       '<cUF>'+IntToStr(UFparaCodigo(TNFeConsultaCadastro(Self).UF))+'</cUF>';

  Texto := Texto + '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                  FConfiguracoes.Geral.VersaoDF,
                                                  LayNfeCadastro) +
                   '</versaoDados>';

  Texto := Texto +     '</nfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<nfeDadosMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/CadConsultaCadastro2">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</nfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto +'</soap12:Envelope>';

  SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/CadConsultaCadastro2' ;

  try
    TACBrNFe( FACBrNFe ).SetStatus( stNFeCadastro );

    FRetConsCad := TRetConsCad.Create;

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss',Now)+'-ped-cad.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);
     end;

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss',Now)+'-ped-cad-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, Texto);
     end;

    FRetWS := '';
    FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);
    FRetWS := SeparaDados( FRetornoWS,'consultaCadastro2Result');

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now)+'-cad.xml';
       FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);
     end;

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now)+'-cad-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqResp, FRetornoWS);
     end;

    FRetConsCad.Leitor.Arquivo := FRetWS;
    FRetConsCad.LerXml;

    aMsg := 'Versão Aplicativo : '+FRetConsCad.verAplic+LineBreak+
            'Status Código : '+IntToStr(FRetConsCad.cStat)+LineBreak+
            'Status Descrição : '+FRetConsCad.xMotivo+LineBreak+
            'UF : '+CodigoParaUF(FRetConsCad.cUF)+LineBreak+
            'Consulta : '+DateTimeToStr(FRetConsCad.dhCons);

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    if FConfiguracoes.WebServices.Visualizar then
       ShowMessage(aMsg);

    if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
       TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

    FverAplic := FRetConsCad.verAplic;
    FcStat    := FRetConsCad.cStat;
    FxMotivo  := FRetConsCad.xMotivo;
    FdhCons   := FRetConsCad.dhCons;
    FcUF      := FRetConsCad.cUF ;

    FMsg      := FRetConsCad.XMotivo;

   Result := (FRetConsCad.cStat in [111,112]);
  finally
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

procedure TNFeConsultaCadastro.SetCNPJ(const Value: String);
begin
  if DFeUtil.NaoEstaVazio(Value) then
   begin
     FIE   := '';
     FCPF  := '';
   end;
  FCNPJ := Value;
end;

procedure TNFeConsultaCadastro.SetCPF(const Value: String);
begin
  if DFeUtil.NaoEstaVazio(Value) then
   begin
     FIE   := '';
     FCNPJ := '';
   end;
  FCPF  := Value;
end;

procedure TNFeConsultaCadastro.SetIE(const Value: String);
begin
  if DFeUtil.NaoEstaVazio(Value) then
   begin
     FCNPJ := '';
     FCPF  := '';
   end;
  FIE   := Value;
end;

{ TNFeEnvDPEC }
function TNFeEnvDPEC.Executar: Boolean;
var
  Texto : String;
  aMsg, SoapAction : String;
  RetDPEC : TRetDPEC;
  wProc: TStringList;
begin
  inherited Executar;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
  Texto := Texto + '<soap:Header>';
  Texto := Texto +  '<sceCabecMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/SCERecepcaoRFB">';

  Texto := Texto +   '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                 FConfiguracoes.Geral.VersaoDF,
                                 LayNfeEnvDPEC) +
                     '</versaoDados>';

  Texto := Texto +  '</sceCabecMsg>';
  Texto := Texto + '</soap:Header>';
  Texto := Texto + '<soap:Body>';
  Texto := Texto +  '<sceDadosMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/SCERecepcaoRFB">';
  Texto := Texto +    FDadosMsg;
  Texto := Texto +  '</sceDadosMsg>';
  Texto := Texto + '</soap:Body>';
  Texto := Texto + '</soap:Envelope>';

  SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/SCERecepcaoRFB/sceRecepcaoDPEC';

  try
    TACBrNFe( FACBrNFe ).SetStatus( stNFeEnvDPEC );

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss',Now)+'-env-dpec.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);
     end;

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-env-dpec.xml', FDadosMsg, FConfiguracoes.Arquivos.GetPathDPEC);

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss',Now)+'-env-dpec-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, Texto);
     end;

    FRetWS := '';
    FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);
    FRetWS := SeparaDados( FRetornoWS,'sceRecepcaoDPECResult',True);

    RetDPEC := TRetDPEC.Create;
    RetDPEC.Leitor.Arquivo := FRetWS;
    RetDPEC.LerXml;

    aMsg := 'Versão Aplicativo : '+RetDPEC.verAplic+LineBreak+
            'ID : '+RetDPEC.Id+LineBreak+
            'Status Código : '+IntToStr(RetDPEC.cStat)+LineBreak+
            'Status Descrição : '+RetDPEC.xMotivo+LineBreak+
            'Data Registro : '+DateTimeToStr(RetDPEC.dhRegDPEC)+LineBreak+
            'nRegDPEC : '+RetDPEC.nRegDPEC+LineBreak+
            'ChaveNFe : '+RetDPEC.chNFE;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    if FConfiguracoes.WebServices.Visualizar then
       ShowMessage(aMsg);

    if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
       TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

    FverAplic := RetDPEC.verAplic;
    FcStat    := RetDPEC.cStat;
    FxMotivo  := RetDPEC.xMotivo;
    FId       := RetDPEC.Id;
    FTpAmb    := RetDPEC.tpAmb;
    FdhRegDPEC := RetDPEC.dhRegDPEC;
    FnRegDPEC  := RetDPEC.nRegDPEC;
    FNFeChave  := RetDPEC.chNFE;

    FMsg      := RetDPEC.XMotivo;

    Result := (RetDPEC.cStat = 124);

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now)+'-ret-dpec.xml';
       FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);
     end;

    if FConfiguracoes.Arquivos.Salvar then
      FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-ret-dpec.xml', FRetWS, FConfiguracoes.Arquivos.GetPathDPEC);

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now)+'-ret-dpec-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqResp, FRetornoWS);
     end;

    //gerar arquivo proc de DPEC
    if (RetDPEC.cStat = 124) then
    begin
      wProc := TStringList.Create;
      wProc.Add('<?xml version="1.0" encoding="UTF-8" ?>');
      wProc.Add('<procDPEC>');
      wProc.Add(FDadosMSG);
      wProc.Add(FRetWS);
      wProc.Add('</procDPEC>');
      FXML_ProcDPEC:=wProc.Text;
      wProc.Free;
      if FConfiguracoes.Geral.Salvar then
         FConfiguracoes.Geral.Save(FormatDateTime('yyyymmddhhnnss',Now)+'-procdpec.xml', FXML_ProcDPEC);
    end;

    RetDPEC.Free;

  finally
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

{ TNFeConsultaDPEC }
function TNFeConsultaDPEC.Executar: Boolean;
var
  Texto : String;
  aMsg, SoapAction : String;
  FretDPEC: TRetDPEC;
begin
  inherited Executar;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
  Texto := Texto +  '<soap:Header>';
  Texto := Texto +   '<sceCabecMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/SCEConsultaRFB">';

  Texto := Texto +    '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                     FConfiguracoes.Geral.VersaoDF,
                                                     LayNfeConsultaDPEC) +
                      '</versaoDados>';

  Texto := Texto +   '</sceCabecMsg>';
  Texto := Texto +  '</soap:Header>';
  Texto := Texto + '<soap:Body>';
  Texto := Texto + '<sceDadosMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/SCEConsultaRFB">';
  Texto := Texto +   FDadosMsg;
  Texto := Texto + '</sceDadosMsg>';
  Texto := Texto + '</soap:Body>';
  Texto := Texto + '</soap:Envelope>';

  SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/SCEConsultaRFB/sceConsultaDPEC';

  FretDPEC:= TRetDPEC.Create;
  try
    TACBrNFe( FACBrNFe ).SetStatus( stNFeConsultaDPEC );
    //if Assigned(FretDPEC) then
    //   FretDPEC.Free;

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss',Now)+'-cons-dpec.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);
     end;

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss',Now)+'-cons-dpec-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, Texto);
     end;

    FRetWS := '';
    FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);
    FRetWS := SeparaDados( FRetornoWS,'sceConsultaDPECResult',True);

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now)+'-sit-dpec.xml';
       FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);
     end;

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now)+'-sit-dpec-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqResp, FRetornoWS);
     end;

    //FretDPEC := TRetDPEC.Create;
    FretDPEC.Leitor.Arquivo := FRetWS;
    FretDPEC.LerXml;

    aMsg := 'Versão Aplicativo : '+{RetDPEC}FretDPEC.verAplic+LineBreak+
            'ID : '+{RetDPEC}FretDPEC.Id+LineBreak+
            'Status Código : '+IntToStr({RetDPEC}FretDPEC.cStat)+LineBreak+
            'Status Descrição : '+{RetDPEC}FretDPEC.xMotivo+LineBreak+
            'Data Registro : '+DateTimeToStr({RetDPEC}FretDPEC.dhRegDPEC)+LineBreak+
            'nRegDPEC : '+{RetDPEC}FretDPEC.nRegDPEC+LineBreak+
            'ChaveNFe : '+{RetDPEC}FretDPEC.chNFE;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    if FConfiguracoes.WebServices.Visualizar then
       ShowMessage(aMsg);

    if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
       TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

    FverAplic := {RetDPEC}FretDPEC.verAplic;
    FcStat    := {RetDPEC}FretDPEC.cStat;
    FxMotivo  := {RetDPEC}FretDPEC.xMotivo;
    FTpAmb    := {RetDPEC}FretDPEC.tpAmb;
    FnRegDPEC  := {RetDPEC}FretDPEC.nRegDPEC;
    FNFeChave  := {RetDPEC}FretDPEC.chNFE;
    FdhRegDPEC := {RetDPEC}FretDPEC.dhRegDPEC;

    FMsg      := {RetDPEC}FretDPEC.XMotivo;
    Result := ({RetDPEC}FretDPEC.cStat = 125);

  finally
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    FretDPEC.Free;
  end;
end;

procedure TNFeConsultaDPEC.SetNFeChave(const Value: String);
begin
  if DFeUtil.NaoEstaVazio(Value) then
     FnRegDPEC := '';
  FNFeChave := StringReplace(Value,'NFe','',[rfReplaceAll]);
end;

procedure TNFeConsultaDPEC.SetnRegDPEC(const Value: String);
begin
  if DFeUtil.NaoEstaVazio(Value) then
     FNFeChave := '';
  FnRegDPEC := Value;
end;

{ TNFeCartaCorrecao }

constructor TNFeCartaCorrecao.Create(AOwner: TComponent; ACCe: TCCeNFe);
begin
  inherited Create(AOwner);

  FCCe := ACCe;
end;

destructor TNFeCartaCorrecao.Destroy;
begin
  if Assigned(FCCeRetorno) then
     FCCeRetorno.Free;
  inherited;
end;

function TNFeCartaCorrecao.Executar: Boolean;
var
  aMsg, SoapAction, NomeArq: string;
  Texto : String;
  wProc  : TStringList ;
  i,j : integer;
  Leitor : TLeitor;
begin
  FCCe.idLote := idLote;
  if Assigned(FCCeRetorno) then
     FCCeRetorno.Free;

  inherited Executar;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<nfeCabecMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/RecepcaoEvento">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';

  Texto := Texto +       '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                        FConfiguracoes.Geral.VersaoDF,
                                                        LayNfeCCe) +
                         '</versaoDados>';

  Texto := Texto +     '</nfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<nfeDadosMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/RecepcaoEvento">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</nfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto +'</soap12:Envelope>';

  SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/RecepcaoEvento';

  try
    TACBrNFe( FACBrNFe ).SetStatus( stNFeCCe );
    FPathArqEnv := IntToStr(FCCe.idLote)+ '-ped-cce.xml';

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);

    if FConfiguracoes.Arquivos.Salvar then
     begin
       if not FConfiguracoes.Arquivos.SalvarCCeCanEvento then
          FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg, FConfiguracoes.Arquivos.GetPathCCe)
       else
          FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg, FConfiguracoes.Arquivos.GetPathEvento(teCCe));
     end;

    if FConfiguracoes.WebServices.Salvar then
      FConfiguracoes.Geral.Save(IntToStr(FCCe.idLote)+ '-ped-cce-soap.xml', Texto);

    FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);
    FRetWS := SeparaDados( FRetornoWS,'nfeRecepcaoEventoResult');

    FCCeRetorno := TRetCCeNFe.Create;
    FCCeRetorno.Leitor.Arquivo := FRetWS;
    FCCeRetorno.LerXml;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    aMsg := 'Ambiente : '+TpAmbToStr(CCeRetorno.tpAmb)+LineBreak+
            'Versão Aplicativo : '+CCeRetorno.verAplic+LineBreak+
            'Status Código : '+IntToStr(CCeRetorno.cStat)+LineBreak+
            'Status Descrição : '+CCeRetorno.xMotivo+LineBreak+
            'Recebimento : '+DFeUtil.SeSenao(CCeRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento = 0, '', DateTimeToStr(CCeRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento));
    if FConfiguracoes.WebServices.Visualizar then
      ShowMessage(aMsg);

    if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
       TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

    FcStat   := CCeRetorno.cStat;
    FxMotivo := CCeRetorno.xMotivo;
    // Alteração realizada por Italo em 30/08/2011 conforme sugestão do Wilson
    /// Alterado linha abaixo para retornar a mensagem da informação do Evento e não o xMotivo pois o mesmo já
    /// se encontra na classe acima "FxMotivo"
    // FMsg     := CCeRetorno.retEvento.Items[0].RetInfEvento.xMotivo;
    //Alteração desfeita, pois primeiro deve ser visto se o lote foi processado e depois verificar nos eventos qual foi o resultado de cada um.
    FMsg     := CCeRetorno.xMotivo;
    FTpAmb   := CCeRetorno.tpAmb;

    /// Alterado a linha Abaixo para Result=True apenas se o lote foi processado e o evento retornou sucesso e não rejeição.
    // Result   := (CCeRetorno.cStat = 128) and ((CCeRetorno.retEvento.Items[0].RetInfEvento.cStat = 135) or (CCeRetorno.retEvento.Items[0].RetInfEvento.cStat = 136));
    // Desfeito alteração pois um lote pode ter vários eventos e o primeiro ser processado e os demais não. A aplicaçào deve verificar se o lote foi processado e verificar se cada evento foi aceito
    Result   := (CCeRetorno.cStat = 128) or (CCeRetorno.cStat = 135) or (CCeRetorno.cStat = 136);

    FPathArqResp := IntToStr(FCCe.idLote) + '-cce.xml';

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);

    if FConfiguracoes.Arquivos.Salvar then
     begin
       if not FConfiguracoes.Arquivos.SalvarCCeCanEvento then
          FConfiguracoes.Geral.Save(FPathArqResp, FRetWS, FConfiguracoes.Arquivos.GetPathCCe)
       else
          FConfiguracoes.Geral.Save(FPathArqResp, FRetWS, FConfiguracoes.Arquivos.GetPathEvento(teCCe));
     end;

    if FConfiguracoes.WebServices.Salvar then
      FConfiguracoes.Geral.Save(IntToStr(FCCe.idLote) + '-cce-soap.xml', FRetornoWS);

    //gerar arquivo proc de cce
    if Result then
    begin
      Leitor := TLeitor.Create;
      for i:= 0 to FCCe.Evento.Count-1 do
       begin
        for j:= 0 to CCeRetorno.retEvento.Count-1 do
         begin
           if FCCe.Evento.Items[i].InfEvento.chNFe = CCeRetorno.retEvento.Items[j].RetInfEvento.chNFe then
            begin
              wProc := TStringList.Create;
              wProc.Add('<?xml version="1.0" encoding="UTF-8" ?>');

              wProc.Add('<procEventoNFe versao="' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                                 FConfiguracoes.Geral.VersaoDF,
                                                                 LayNfeCCe) +
                                     '" xmlns="http://www.portalfiscal.inf.br/nfe">');
              wProc.Add('<evento versao="' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                          FConfiguracoes.Geral.VersaoDF,
                                                          LayNfeCCe) + '">');

              Leitor.Arquivo := FDadosMSG;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'infEvento', '', i + 1)));
//              wProc.Add('</infEvento>');

              wProc.Add('<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">');
              Leitor.Arquivo := FDadosMSG;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'SignedInfo', '', i + 1)));
//              wProc.Add('</SignedInfo>');
              Leitor.Arquivo := FDadosMSG;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'SignatureValue', '', i + 1)));
//              wProc.Add('</SignatureValue>');
              Leitor.Arquivo := FDadosMSG;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'KeyInfo', '', i + 1)));
//              wProc.Add('</KeyInfo>');
              wProc.Add('</Signature>');

              wProc.Add('</evento>');
              wProc.Add('<retEvento versao="' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                             FConfiguracoes.Geral.VersaoDF,
                                                             LayNfeCCe) + '">');

              Leitor.Arquivo := FRetWS;
              wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'infEvento', '', j + 1)));
//              wProc.Add('</infEvento>');
              wProc.Add('</retEvento>');
              wProc.Add('</procEventoNFe>');

              CCeRetorno.retEvento.Items[j].RetInfEvento.XML:=wProc.Text;

              NomeArq := FCCe.Evento.Items[i].InfEvento.chNFe +
                         '110110' +
//                         IntToStr(FCCe.Evento.Items[i].InfEvento.nSeqEvento) +
                         Format('%.2d', [FCCe.Evento.Items[i].InfEvento.nSeqEvento]) +
                         '-procEventoNFe.xml';

              if FConfiguracoes.Geral.Salvar then
                 FConfiguracoes.Geral.Save(NomeArq, wProc.Text);

              if FConfiguracoes.Arquivos.Salvar then
               begin
                 if not FConfiguracoes.Arquivos.SalvarCCeCanEvento then
                    FConfiguracoes.Geral.Save(NomeArq, wProc.Text, FConfiguracoes.Arquivos.GetPathCCe)
                 else
                    FConfiguracoes.Geral.Save(NomeArq, wProc.Text, FConfiguracoes.Arquivos.GetPathEvento(teCCe));
               end;
              wProc.Free;
              break;
            end;
         end;
       end;
      Leitor.Free;
    end;
  finally
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

{ TNFeEnvEvento }
constructor TNFeEnvEvento.Create(AOwner: TComponent; AEvento: TEventoNFe);
begin
  inherited Create(AOwner);

  FEvento := AEvento;
end;

destructor TNFeEnvEvento.Destroy;
begin
  if Assigned(FEventoRetorno) then
     FEventoRetorno.Free;
  inherited;
end;

function TNFeEnvEvento.Executar: Boolean;
var
  aMsg, SoapAction, NomeArq: string;
  Texto : String;
  wProc  : TStringList ;
  i,j : integer;
  Leitor : TLeitor;
begin
  FEvento.idLote := idLote;
  if Assigned(FEventoRetorno) then begin
     FEventoRetorno.Free;
     FEventoRetorno := nil;
  end;

  inherited Executar;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<nfeCabecMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/RecepcaoEvento">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';

  Texto := Texto +       '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                        FConfiguracoes.Geral.VersaoDF,
                                                        LayNfeEvento) +
                         '</versaoDados>';

  Texto := Texto +     '</nfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<nfeDadosMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/RecepcaoEvento">';
  Texto := Texto +       FDadosMsg;
  Texto := Texto +     '</nfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto +'</soap12:Envelope>';

  SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/RecepcaoEvento';

  try
    TACBrNFe( FACBrNFe ).SetStatus( stNFeEvento );
    FPathArqEnv := IntToStr(FEvento.idLote)+'-ped-evento.xml';

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);

    if FConfiguracoes.Arquivos.Salvar then
     begin
       if (FEvento.Evento.Items[0].InfEvento.tpEvento = teCCe) and not FConfiguracoes.Arquivos.SalvarCCeCanEvento then
          FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg, FConfiguracoes.Arquivos.GetPathCCe)
       else if (FEvento.Evento.Items[0].InfEvento.tpEvento = teCancelamento) and not FConfiguracoes.Arquivos.SalvarCCeCanEvento then
          FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg, FConfiguracoes.Arquivos.GetPathCan)
       else
          FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg, FConfiguracoes.Arquivos.GetPathEvento(FEvento.Evento.Items[0].InfEvento.tpEvento));
     end;

    if FConfiguracoes.WebServices.Salvar then
      FConfiguracoes.Geral.Save(IntToStr(FEvento.idLote)+'-ped-evento-soap.xml', Texto);

    FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);
    FRetWS := SeparaDados( FRetornoWS,'nfeRecepcaoEventoResult');

    FPathArqResp := IntToStr(FEvento.idLote) + '-eve.xml';
    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);

    if FConfiguracoes.WebServices.Salvar then
      FConfiguracoes.Geral.Save(IntToStr(FEvento.idLote) + '-eve-soap.xml', FRetornoWS);

    FEventoRetorno                := TRetEventoNFe.Create;
    FEventoRetorno.Leitor.Arquivo := FRetWS;
    FEventoRetorno.LerXml;

    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
    aMsg := 'Ambiente : '+TpAmbToStr(EventoRetorno.tpAmb)+LineBreak+
            'Versão Aplicativo : '+EventoRetorno.verAplic+LineBreak+
            'Status Código : '+IntToStr(EventoRetorno.cStat)+LineBreak+
            'Status Descrição : '+EventoRetorno.xMotivo+LineBreak;
    if (EventoRetorno.retEvento.Count > 0) then
      aMsg := aMsg + 'Recebimento : '+DFeUtil.SeSenao(EventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento = 0,
                                                       '',
                                                       DateTimeToStr(EventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento));
    if FConfiguracoes.WebServices.Visualizar then
      ShowMessage(aMsg);

    if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
       TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

    FcStat   := EventoRetorno.cStat;
    FxMotivo := EventoRetorno.xMotivo;
    FMsg     := EventoRetorno.xMotivo;
    FTpAmb   := EventoRetorno.tpAmb;
    Result   := (EventoRetorno.cStat = 128) or (EventoRetorno.cStat = 135) or (EventoRetorno.cStat = 136) or (EventoRetorno.cStat = 155);

    FPathArqResp := IntToStr(FEvento.idLote) + '-eve.xml';

    if FConfiguracoes.Geral.Salvar then
      FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);

    if FConfiguracoes.Arquivos.Salvar then
     begin
       if (FEvento.Evento.Items[0].InfEvento.tpEvento = teCCe) and not FConfiguracoes.Arquivos.SalvarCCeCanEvento  then
          FConfiguracoes.Geral.Save(FPathArqResp, FRetWS, FConfiguracoes.Arquivos.GetPathCCe)
       else if (FEvento.Evento.Items[0].InfEvento.tpEvento = teCancelamento) and not FConfiguracoes.Arquivos.SalvarCCeCanEvento  then
          FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg, FConfiguracoes.Arquivos.GetPathCan)
       else
          FConfiguracoes.Geral.Save(FPathArqResp, FRetWS, FConfiguracoes.Arquivos.GetPathEvento(FEvento.Evento.Items[0].InfEvento.tpEvento));
     end;

    //gerar arquivo proc de evento
    if Result then
    begin
      Leitor := TLeitor.Create;
      try
         for i:= 0 to FEvento.Evento.Count-1 do
          begin
           for j:= 0 to EventoRetorno.retEvento.Count-1 do
            begin
              if FEvento.Evento.Items[i].InfEvento.chNFe = EventoRetorno.retEvento.Items[j].RetInfEvento.chNFe then
               begin
                 FEvento.Evento.Items[i].RetInfEvento.nProt       := EventoRetorno.retEvento.Items[j].RetInfEvento.nProt;
                 FEvento.Evento.Items[i].RetInfEvento.dhRegEvento := EventoRetorno.retEvento.Items[j].RetInfEvento.dhRegEvento;
                 FEvento.Evento.Items[i].RetInfEvento.cStat       := EventoRetorno.retEvento.Items[j].RetInfEvento.cStat;
                 FEvento.Evento.Items[i].RetInfEvento.xMotivo     := EventoRetorno.retEvento.Items[j].RetInfEvento.xMotivo;

                 wProc := TStringList.Create;
                 wProc.Add('<?xml version="1.0" encoding="UTF-8" ?>');

                 wProc.Add('<procEventoNFe versao="' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                                    FConfiguracoes.Geral.VersaoDF,
                                                                    LayNfeEvento) +
                                        '" xmlns="http://www.portalfiscal.inf.br/nfe">');
                 wProc.Add('<evento versao="' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                             FConfiguracoes.Geral.VersaoDF,
                                                             LayNfeEvento) + '">');

                 Leitor.Arquivo := FDadosMSG;
                 wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'infEvento', '', i + 1)));
//                 wProc.Add('</infEvento>');

                 wProc.Add('<Signature xmlns="http://www.w3.org/2000/09/xmldsig#">');
                 Leitor.Arquivo := FDadosMSG;
                 wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'SignedInfo', '', i + 1)));
//                 wProc.Add('</SignedInfo>');
                 Leitor.Arquivo := FDadosMSG;
                 wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'SignatureValue', '', i + 1)));
//                 wProc.Add('</SignatureValue>');
                 Leitor.Arquivo := FDadosMSG;
                 wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'KeyInfo', '', i + 1)));
//                 wProc.Add('</KeyInfo>');
                 wProc.Add('</Signature>');

                 wProc.Add('</evento>');
                 wProc.Add('<retEvento versao="' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                                FConfiguracoes.Geral.VersaoDF,
                                                                LayNfeEvento) + '">');

                 Leitor.Arquivo := FRetWS;
                 wProc.Add(UTF8Encode(Leitor.rExtrai(1, 'infEvento', '', j + 1)));
//                 wProc.Add('</infEvento>');
                 wProc.Add('</retEvento>');
                 wProc.Add('</procEventoNFe>');

                 EventoRetorno.retEvento.Items[j].RetInfEvento.XML:=wProc.Text;

//                 NomeArq := FEvento.Evento.Items[i].InfEvento.chNFe +
//                            FEvento.Evento.Items[i].InfEvento.TipoEvento +
//                            IntToStr(FEvento.Evento.Items[i].InfEvento.nSeqEvento) +
//                            '-procEventoNFe.xml';
                 NomeArq := FEvento.Evento.Items[i].InfEvento.chNFe +
                            FEvento.Evento.Items[i].InfEvento.TipoEvento +
                            Format('%.2d', [FEvento.Evento.Items[i].InfEvento.nSeqEvento]) +
                            '-procEventoNFe.xml';

              {   NomeArq := FEvento.Evento.Items[i].InfEvento.id +
                            '-procEventoNFe.xml'; }

                 if FConfiguracoes.Geral.Salvar then
                    FConfiguracoes.Geral.Save(NomeArq, wProc.Text);

                 if FConfiguracoes.Arquivos.Salvar then
                  begin
                    if (FEvento.Evento.Items[0].InfEvento.tpEvento = teCCe) and not FConfiguracoes.Arquivos.SalvarCCeCanEvento  then
                       FConfiguracoes.Geral.Save(NomeArq, wProc.Text, FConfiguracoes.Arquivos.GetPathCCe)
                    else if (FEvento.Evento.Items[0].InfEvento.tpEvento = teCancelamento) and not FConfiguracoes.Arquivos.SalvarCCeCanEvento then
                       FConfiguracoes.Geral.Save(NomeArq, wProc.Text, FConfiguracoes.Arquivos.GetPathCan)
                    else
                       FConfiguracoes.Geral.Save(NomeArq, wProc.Text, FConfiguracoes.Arquivos.GetPathEvento(FEvento.Evento.Items[0].InfEvento.tpEvento));
                  end;
                 wProc.Free;
                 break;
               end;
            end;
          end;
      finally
         Leitor.Free;
      end;   
    end;
  finally
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

{ TNFeConsNFeDest }
constructor TNFeConsNFeDest.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if not Assigned(FretConsNFeDest) then
    FretConsNFeDest := TretConsNFeDest.Create;
end;

destructor TNFeConsNFeDest.Destroy;
begin
  if Assigned(FretConsNFeDest) then
    FretConsNFeDest.Free;
  inherited;
end;

function TNFeConsNFeDest.Executar: Boolean;
var
  aMsg, SoapAction: string;
  Texto : String;
begin
  inherited Executar;

  Result := False;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<nfeCabecMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeConsultaDest">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';

  Texto := Texto +       '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                        FConfiguracoes.Geral.VersaoDF,
                                                        LayNfeConsNFeDest) +
                         '</versaoDados>';

  Texto := Texto +     '</nfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<nfeDadosMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeConsultaDest">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</nfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto +'</soap12:Envelope>';

  SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeConsultaDest/nfeConsultaNFDest';

  // Movido para fora do try por Italo em 16/08/2012
//  if Assigned(FretConsNFeDest)
//   then FretConsNFeDest.Free;
  if Assigned(FretConsNFeDest)
   then FreeAndNil(FretConsNFeDest);

  FretConsNFeDest := TRetConsNFeDest.Create;

  try
    TACBrNFe( FACBrNFe ).SetStatus( stConsNFeDest );

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss',Now)+'-con-nfe-dest.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);
     end;

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss',Now)+'-con-nfe-dest-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, Texto);
     end;

    try
      FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);
      FRetWS := SeparaDados( FRetornoWS,'nfeConsultaNFDestResult');

      FretConsNFeDest.Leitor.Arquivo := FRetWS;
      FretConsNFeDest.LerXml;

      TACBrNFe( FACBrNFe ).SetStatus( stIdle );
      aMsg := 'Versão : '+FretConsNFeDest.versao+LineBreak+
              'Ambiente : '+TpAmbToStr(FretConsNFeDest.tpAmb)+LineBreak+
              'Versão Aplicativo : '+FretConsNFeDest.verAplic+LineBreak+
              'Status Código : '+IntToStr(FretConsNFeDest.cStat)+LineBreak+
              'Status Descrição : '+FretConsNFeDest.xMotivo+LineBreak+
              'Recebimento : '+DFeUtil.SeSenao(FretConsNFeDest.dhResp = 0, '', DateTimeToStr(RetConsNFeDest.dhResp))+LineBreak+
              'Ind. Continuação : '+IndicadorContinuacaoToStr(FretConsNFeDest.indCont)+LineBreak+
              'Último NSU : '+FretConsNFeDest.ultNSU+LineBreak;
              
      if FConfiguracoes.WebServices.Visualizar then
        ShowMessage(aMsg);

      if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
         TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

      Result := (FretConsNFeDest.CStat =137) or (FretConsNFeDest.CStat =138);

      if FConfiguracoes.Geral.Salvar then
       begin
         FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now)+'-nfe-dest.xml';
         FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);
       end;

      if FConfiguracoes.WebServices.Salvar then
       begin
         FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now)+'-nfe-dest-soap.xml';
         FConfiguracoes.Geral.Save(FPathArqResp, FRetornoWS);
       end;

    except on E: Exception do
      begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('WebService Consulta NF-e Destinadas:'+LineBreak+
                                          '- Inativo ou Inoperante tente novamente.'+LineBreak+
                                          '- '+E.Message);
       raise EACBrNFeException.Create('WebService Consulta NF-e Destinadas:'+LineBreak+
                              '- Inativo ou Inoperante tente novamente.'+LineBreak+
                              '- '+E.Message);
      end;
    end;
  finally
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

{ TNFeDownloadNFe }
constructor TNFeDownloadNFe.Create(AOwner: TComponent;
  ADownload: TDownloadNFe);
begin
  inherited Create(AOwner);

 FDownload := ADownload;
end;

destructor TNFeDownloadNFe.Destroy;
begin
  if Assigned(FRetDownloadNFe) then
     FRetDownloadNFe.Free;

  inherited;
end;

function TNFeDownloadNFe.Executar: Boolean;
var
  aMsg, SoapAction: string;
  Texto : String;
  i: Integer;
begin
  inherited Executar;

  Result := False;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<nfeCabecMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeDownloadNF">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';

  Texto := Texto +       '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                        FConfiguracoes.Geral.VersaoDF,
                                                        LayNfeDownloadNFe) +
                         '</versaoDados>';

  Texto := Texto +     '</nfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<nfeDadosMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeDownloadNF">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</nfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto +'</soap12:Envelope>';

  SOAPAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeDownloadNF/nfeDownloadNF';

  if Assigned(FRetDownloadNFe)
   then FreeAndNil(FRetDownloadNFe);

  FRetDownloadNFe := TRetDownloadNFe.Create;

  try
    TACBrNFe( FACBrNFe ).SetStatus( stDownloadNFe );

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss',Now)+'-ped-down-nfe.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);
     end;

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss',Now)+'-ped-down-nfe-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, Texto);
     end;

    try
      FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);
      FRetWS := SeparaDados( FRetornoWS,'nfeDownloadNFResult');

      FRetDownloadNFe.Leitor.Arquivo := FRetWS;
      FRetDownloadNFe.LerXml;

      TACBrNFe( FACBrNFe ).SetStatus( stIdle );

      aMsg := 'Versão : '+FRetDownloadNFe.versao+LineBreak+
              'Ambiente : '+TpAmbToStr(FRetDownloadNFe.tpAmb)+LineBreak+
              'Versão Aplicativo : '+FRetDownloadNFe.verAplic+LineBreak+
              'Status Código : '+IntToStr(FRetDownloadNFe.cStat)+LineBreak+
              'Status Descrição : '+FRetDownloadNFe.xMotivo+LineBreak+
              'Recebimento : '+DFeUtil.SeSenao(FRetDownloadNFe.dhResp = 0, '', DateTimeToStr(FRetDownloadNFe.dhResp))+LineBreak;

      if FConfiguracoes.WebServices.Visualizar then
        ShowMessage(aMsg);

      if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
         TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

      Result := (FRetDownloadNFe.cStat = 139);

      if FConfiguracoes.Geral.Salvar then
       begin
         FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now)+'-down-nfe.xml';
         FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);
       end;

      if FConfiguracoes.WebServices.Salvar then
       begin
         FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now)+'-down-nfe-soap.xml';
         FConfiguracoes.Geral.Save(FPathArqResp, FRetornoWS);
       end;

      for i := 0 to FRetDownloadNFe.retNFe.Count - 1 do
       begin
         if FRetDownloadNFe.retNFe.Items[i].cStat = 140
          then begin
           FPathArqResp := FRetDownloadNFe.retNFe.Items[i].chNFe + '-nfe.xml';
           FConfiguracoes.Geral.Save(FPathArqResp, FRetDownloadNFe.retNFe.Items[i].procNFe);
          end;
       end;

    except on E: Exception do
      begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('WebService Download de NF-e:'+LineBreak+
                                          '- Inativo ou Inoperante tente novamente.'+LineBreak+
                                          '- '+E.Message);
       raise EACBrNFeException.Create('WebService Download de NF-e:'+LineBreak+
                              '- Inativo ou Inoperante tente novamente.'+LineBreak+
                              '- '+E.Message);
      end;
    end;
  finally
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

{ TAdministrarCSCNFCe }

constructor TAdministrarCSCNFCe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if not Assigned(FretAdmCSCNFCe) then
    FretAdmCSCNFCe := TretAdmCSCNFCe.Create;
end;

destructor TAdministrarCSCNFCe.Destroy;
begin
  if Assigned(FretAdmCSCNFCe) then
    FretAdmCSCNFCe.Free;
  inherited;
end;

function TAdministrarCSCNFCe.Executar: Boolean;
var
  aMsg, SoapAction, Texto: String;
begin
  inherited Executar;

  Result := False;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';

  // Corrigir o NameSpace
  Texto := Texto +     '<nfeCabecMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeConsultaDest">';
  Texto := Texto +       '<cUF>' + IntToStr(FConfiguracoes.WebServices.UFCodigo) + '</cUF>';

  Texto := Texto +       '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                        FConfiguracoes.Geral.VersaoDF,
                                                        LayAdministrarCSCNFCe) +
                         '</versaoDados>';

  Texto := Texto +     '</nfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';

  // Corrigir o NameSpace
  Texto := Texto +     '<nfeDadosMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NfeConsultaDest">';
  Texto := Texto +       FDadosMsg;
  Texto := Texto +     '</nfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';


 // Corrigir o SoapAction
  SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NfeConsultaDest/nfeConsultaNFDest';

  if Assigned(FretAdmCSCNFCe)
   then FreeAndNil(FretAdmCSCNFCe);

  FretAdmCSCNFCe := TRetAdmCSCNFCe.Create;

  try
    TACBrNFe( FACBrNFe ).SetStatus( stAdmCSCNFCe );

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss',Now) + '-ped-csc.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);
     end;

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss',Now) + '-ped-csc-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, Texto);
     end;

    try
      FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);
  // Corrigir a TAG que contem o Retorno
      FRetWS := SeparaDados( FRetornoWS,'nfeConsultaNFDestResult');

      FretAdmCSCNFCe.Leitor.Arquivo := FRetWS;
      FretAdmCSCNFCe.LerXml;

      TACBrNFe( FACBrNFe ).SetStatus( stIdle );
      aMsg := 'Ambiente : ' + TpAmbToStr(FretAdmCSCNFCe.tpAmb) + LineBreak +
              'Status Código : ' + IntToStr(FretAdmCSCNFCe.cStat) + LineBreak +
              'Status Descrição : ' + FretAdmCSCNFCe.xMotivo + LineBreak;

      if FConfiguracoes.WebServices.Visualizar then
        ShowMessage(aMsg);

      if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
         TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

      Result := (FretAdmCSCNFCe.CStat in [150, 151, 152, 153]);

      if FConfiguracoes.Geral.Salvar then
       begin
         FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now) + '-csc.xml';
         FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);
       end;

      if FConfiguracoes.WebServices.Salvar then
       begin
         FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now) + '-csc-soap.xml';
         FConfiguracoes.Geral.Save(FPathArqResp, FRetornoWS);
       end;

    except on E: Exception do
      begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('WebService Administrar CSC da NFC-e:' + LineBreak +
                                          '- Inativo ou Inoperante tente novamente.' + LineBreak +
                                          '- ' + E.Message);
       raise EACBrNFeException.Create('WebService Administrar CSC da NFC-e:' + LineBreak +
                              '- Inativo ou Inoperante tente novamente.' + LineBreak +
                              '- ' + E.Message);
      end;
    end;
  finally
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

{ TDistribuicaoDFe }

constructor TDistribuicaoDFe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if not Assigned(FretDistDFeInt) then
    FretDistDFeInt := TretDistDFeInt.Create;
end;

destructor TDistribuicaoDFe.Destroy;
begin
  if Assigned(FretDistDFeInt) then
    FretDistDFeInt.Free;
  inherited;
end;

function TDistribuicaoDFe.Executar: Boolean;
var
  aMsg, SoapAction, Texto: String;
begin
  inherited Executar;

  Result := False;
  (*
  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<nfeCabecMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NFeDistribuicaoDFe">';
  Texto := Texto +       '<cUF>' + IntToStr(FConfiguracoes.WebServices.UFCodigo) + '</cUF>';

  Texto := Texto +       '<versaoDados>' + GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                                        FConfiguracoes.Geral.VersaoDF,
                                                        LayDistDFeInt) +
                         '</versaoDados>';

  Texto := Texto +     '</nfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';

  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<nfeDadosMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NFeDistribuicaoDFe">';
  Texto := Texto +       FDadosMsg;
  Texto := Texto +     '</nfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';
  *)

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<nfeDistDFeInteresse xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NFeDistribuicaoDFe">';
  Texto := Texto +       '<nfeDadosMsg>';
  Texto := Texto +         FDadosMsg;
  Texto := Texto +       '</nfeDadosMsg>';
  Texto := Texto +     '</nfeDistDFeInteresse>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto + '</soap12:Envelope>';

  SoapAction := 'http://www.portalfiscal.inf.br/nfe/wsdl/NFeDistribuicaoDFe/nfeDistDFeInteresse';

  if Assigned(FretDistDFeInt)
   then FreeAndNil(FretDistDFeInt);

  FretDistDFeInt := TRetDistDFeInt.Create;

  try
    TACBrNFe( FACBrNFe ).SetStatus( stDistDFeInt );

    if FConfiguracoes.Geral.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss',Now) + '-con-dist-dfe.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, FDadosMsg);
     end;

    if FConfiguracoes.WebServices.Salvar then
     begin
       FPathArqEnv := FormatDateTime('yyyymmddhhnnss',Now) + '-con-dist-dfe-soap.xml';
       FConfiguracoes.Geral.Save(FPathArqEnv, Texto);
     end;

    try
      FRetornoWS := EnviarDadosWebService(FURL,SoapAction,Texto);
      FRetWS := SeparaDados( FRetornoWS,'nfeDistDFeInteresseResult');

      FretDistDFeInt.Leitor.Arquivo := FRetWS;
      FretDistDFeInt.LerXml;

      TACBrNFe( FACBrNFe ).SetStatus( stIdle );
      aMsg := 'Versão : ' + FretDistDFeInt.versao + LineBreak +
              'Ambiente : ' + TpAmbToStr(FretDistDFeInt.tpAmb) + LineBreak +
              'Versão Aplicativo : ' + FretDistDFeInt.verAplic + LineBreak +
              'Status Código : ' + IntToStr(FretDistDFeInt.cStat) + LineBreak +
              'Status Descrição : ' + FretDistDFeInt.xMotivo + LineBreak +
              'Resposta : ' + DFeUtil.SeSenao(FretDistDFeInt.dhResp = 0, '', DateTimeToStr(RetDistDFeInt.dhResp)) + LineBreak +
              'Último NSU : ' + FretDistDFeInt.ultNSU + LineBreak +
              'Máximo NSU : ' + FretDistDFeInt.maxNSU + LineBreak;

      if FConfiguracoes.WebServices.Visualizar then
        ShowMessage(aMsg);

      if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
         TACBrNFe( FACBrNFe ).OnGerarLog(aMsg);

      Result := (FretDistDFeInt.CStat = 137) or (FretDistDFeInt.CStat = 138);

      if FConfiguracoes.Geral.Salvar then
       begin
         FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now) + '-dist-dfe.xml';
         FConfiguracoes.Geral.Save(FPathArqResp, FRetWS);
       end;

      if FConfiguracoes.WebServices.Salvar then
       begin
         FPathArqResp := FormatDateTime('yyyymmddhhnnss',Now) + '-dist-dfe-soap.xml';
         FConfiguracoes.Geral.Save(FPathArqResp, FRetornoWS);
       end;

    except on E: Exception do
      begin
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('WebService Distribuição de DFe:' + LineBreak +
                                          '- Inativo ou Inoperante tente novamente.' + LineBreak +
                                          '- ' + E.Message);
       raise EACBrNFeException.Create('WebService Distribuição de DFe:' + LineBreak +
                              '- Inativo ou Inoperante tente novamente.' + LineBreak +
                              '- ' + E.Message);
      end;
    end;
  finally
    NotaUtil.ConfAmbiente;
    TACBrNFe( FACBrNFe ).SetStatus( stIdle );
  end;
end;

{ TNFeEnvioWebService }

function TNFeEnvioWebService.Executar: Boolean;
var
  Texto, Versao : String;

  LeitorXML : TLeitor;
begin
  LeitorXML := TLeitor.Create;
  try
     LeitorXML.Arquivo := FXMLEnvio;
     LeitorXML.Grupo := FXMLEnvio;
     Versao := LeitorXML.rAtributo('versao')
  finally
     LeitorXML.Free;
  end;

  FDadosMsg := FXMLEnvio;

  FURL := FURLEnvio;

  Result := True;

  Texto := '<?xml version="1.0" encoding="utf-8"?>';
  Texto := Texto + '<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">';
  Texto := Texto +   '<soap12:Header>';
  Texto := Texto +     '<nfeCabecMsg xmlns="'+FSoapActionEnvio+'">';
  Texto := Texto +       '<cUF>'+IntToStr(FConfiguracoes.WebServices.UFCodigo)+'</cUF>';
  Texto := Texto +       '<versaoDados>'+Versao+'</versaoDados>';
  Texto := Texto +     '</nfeCabecMsg>';
  Texto := Texto +   '</soap12:Header>';
  Texto := Texto +   '<soap12:Body>';
  Texto := Texto +     '<nfeDadosMsg xmlns="'+FSoapActionEnvio+'">';
  Texto := Texto + FDadosMsg;
  Texto := Texto +     '</nfeDadosMsg>';
  Texto := Texto +   '</soap12:Body>';
  Texto := Texto +'</soap12:Envelope>';


  try
    try
      FRetornoWS := EnviarDadosWebService(FURL,FSoapActionEnvio,Texto);
      FRetWS := SeparaDados( FRetornoWS,'soap:Body');

    except on E: Exception do
      begin
       Result := False;
       if Assigned(TACBrNFe( FACBrNFe ).OnGerarLog) then
          TACBrNFe( FACBrNFe ).OnGerarLog('WebService'+LineBreak+
                                          '- Inativo ou Inoperante tente novamente.'+LineBreak+
                                          '- '+E.Message);
       raise EACBrNFeException.Create('WebService'+LineBreak+
                              '- Inativo ou Inoperante tente novamente.'+LineBreak+
                              '- '+E.Message);
      end;
    end;
  finally
    NotaUtil.ConfAmbiente;
  end;
end;

end.
