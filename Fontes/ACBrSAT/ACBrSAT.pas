{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2014 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Andr� Ferreira de Moraes                        }
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

{$I ACBr.inc}

unit ACBrSAT;

interface

uses
  Classes, SysUtils, pcnCFe, pcnRede, pcnCFeCanc, ACBrBase, ACBrSATClass,
  ACBrSATExtratoClass, synacode, StrUtils;

const CPREFIXO_CFe = 'CFe';

type
   { TACBrSAT }

   TACBrSAT = class( TACBrComponent )
   private
     fsCFe : TCFe ;
     fsCFeCanc : TCFeCanc ;
     fsnumeroSessao : Integer ;
     fsOnGetcodigoDeAtivacao : TACBrSATGetChave ;
     fsOnGetNumeroSessao: TACBrSATGetNumeroSessao;
     fsOnGetsignAC : TACBrSATGetChave ;
     fsOnGravarLog : TACBrGravarLog ;
     fsNomeDLL : String ;
     fsPrefixoCFe: String;
     fsResposta : TACBrSATResposta ;
     fsRespostaComando : String ;
     fsSATClass : TACBrSATClass ;
     fsExtrato : TACBrSATExtratoClass;

     fsArqLOG: String;
     fsComandoLog: String;
     fsInicializado : Boolean ;
     fsModelo : TACBrSATModelo ;
     fsConfig : TACBrSATConfig ;
     fsRede   : TRede ;
     fsStatus : TACBrSATStatus;

     fsSalvarCFes: Boolean;
     fsPastaCFeCancelamento: String;
     fsPastaCFeVenda: String;

     function CodificarPaginaDeCodigoSAT(ATexto: String): AnsiString;
     function DecodificarPaginaDeCodigoSAT(ATexto: AnsiString): String;

     function GetAbout : String;
     function GetcodigoDeAtivacao : AnsiString ;
     function GetModeloStrClass : String ;
     function GetsignAC : AnsiString ;
     procedure SetAbout(const Value: String);{%h-}
     procedure SetInicializado(AValue : Boolean) ;
     procedure SetModelo(AValue : TACBrSATModelo) ;
     procedure SetNomeDLL(AValue : string) ;

     function GetPastaCFeCancelamento: String;
     function GetPastaCFeVenda: String;
     procedure SetPastaCFeCancelamento(AValue: String);
     procedure SetPastaCFeVenda(AValue: String);

     procedure VerificaInicializado ;
     procedure IniciaComando ;
     function FinalizaComando(AResult: String): String;
     procedure VerificaCondicoesImpressao( EhCancelamento: Boolean = False);

     procedure GravaLog(AString : AnsiString ) ;
     procedure SetExtrato(const Value: TACBrSATExtratoClass);
   protected
     procedure Notification(AComponent: TComponent; Operation: TOperation); override;
   public
     procedure DecodificaRetorno6000;
     property SAT : TACBrSATClass read fsSATClass ;

     constructor Create( AOwner : TComponent ) ; override;
     destructor Destroy ; override;

     Procedure Inicializar;
     Procedure DesInicializar;
     property Inicializado : Boolean read fsInicializado write SetInicializado ;

     Property ModeloStr : String  read GetModeloStrClass;

     property numeroSessao : Integer read fsnumeroSessao write fsnumeroSessao;
     function GerarnumeroSessao : Integer ;

     property codigoDeAtivacao : AnsiString read GetcodigoDeAtivacao ;
     property signAC           : AnsiString read GetsignAC ;

     property RespostaComando: String read fsRespostaComando ;

     property CFe : TCFe read fsCFe ;
     property CFeCanc : TCFeCanc read fsCFeCanc ;

     property Status : TACBrSATStatus read fsStatus;
     property Resposta : TACBrSATResposta read fsResposta;
     property PrefixoCFe: String read fsPrefixoCFe;

     procedure InicializaCFe( ACFe : TCFe = nil );

     procedure DoLog(AString : String ) ;

     function AssociarAssinatura( CNPJvalue, assinaturaCNPJs : AnsiString ): String ;
     function AtivarSAT(subComando : Integer ; CNPJ : AnsiString ; cUF : Integer
       ) : String ;
     function AtualizarSoftwareSAT : String ;
     function BloquearSAT : String ;
     procedure CFe2CFeCanc;
     function CancelarUltimaVenda :String ; overload;
     function CancelarUltimaVenda( chave, dadosCancelamento : AnsiString ) :
       String ; overload;
     function ComunicarCertificadoICPBRASIL( certificado : AnsiString ) :
       String ;
     function ConfigurarInterfaceDeRede( dadosConfiguracao : AnsiString = '') :
       String ;
     function ConsultarNumeroSessao( cNumeroDeSessao : Integer) : String ;
     function ConsultarSAT : String ;
     function ConsultarStatusOperacional : String ;
     function DesbloquearSAT : String ;
     function EnviarDadosVenda : String ; overload;
     function EnviarDadosVenda( dadosVenda : AnsiString ) : String ; overload;
     procedure ExtrairLogs( NomeArquivo : String ); overload;
     procedure ExtrairLogs( AStringList : TStrings ); overload;
     procedure ExtrairLogs( AStream : TStream ); overload;
     function TesteFimAFim( dadosVenda : AnsiString) : String ;
     function TrocarCodigoDeAtivacao(codigoDeAtivacaoOuEmergencia: AnsiString;
       opcao: Integer; novoCodigo: AnsiString): String;

    procedure ImprimirExtrato;
    procedure ImprimirExtratoResumido;
    procedure ImprimirExtratoCancelamento;

   published
     property Modelo : TACBrSATModelo read fsModelo write SetModelo
                 default satNenhum ;

     property Extrato: TACBrSATExtratoClass read fsExtrato write SetExtrato ;

     property NomeDLL: string read fsNomeDLL write SetNomeDLL;

     property About : String read GetAbout write SetAbout stored False ;
     property ArqLOG : String read fsArqLOG write fsArqLOG ;
     property OnGravarLog : TACBrGravarLog read fsOnGravarLog write fsOnGravarLog;

     property Config : TACBrSATConfig read fsConfig write fsConfig;
     property Rede : TRede read fsRede write fsRede;

     property OnGetcodigoDeAtivacao : TACBrSATGetChave read fsOnGetcodigoDeAtivacao
        write fsOnGetcodigoDeAtivacao;
     property OnGetsignAC : TACBrSATGetChave read fsOnGetsignAC write fsOnGetsignAC;
     property OnGetNumeroSessao : TACBrSATGetNumeroSessao read fsOnGetNumeroSessao
        write fsOnGetNumeroSessao;

     property SalvarCFes: Boolean read fsSalvarCFes write fsSalvarCFes default false;
     property PastaCFeVenda: String read GetPastaCFeVenda write SetPastaCFeVenda;
     property PastaCFeCancelamento: String read GetPastaCFeCancelamento
        write SetPastaCFeCancelamento;
   end;

function MensagemCodigoRetorno(CodigoRetorno: Integer): String;
function MotivocStat(cStat: Integer): String;
function MotivoInvalidoVenda(cod: integer): String;
function MotivoInvalidoCancelamento(cod: integer): String;

implementation

Uses ACBrUtil, ACBrSATDinamico_cdecl, ACBrSATDinamico_stdcall, synautil;

function MensagemCodigoRetorno(CodigoRetorno: Integer): String;
var
  Mensagem: String;
begin
  (* Retorna a mensagem de erro do c�digo no parametro CodigoRetorno
       de acordo com a NOTA TECNICA 2013/001 *)
  case (CodigoRetorno) of
    04000: Mensagem := 'Ativado corretamente SAT Ativado com Sucesso.';
    04001: Mensagem := 'Erro na cria��o do certificado processo de ativa��o foi interrompido.';
    04002: Mensagem := 'SEFAZ n�o reconhece este SAT (CNPJ inv�lido) Verificar junto a SEFAZ o CNPJ cadastrado.';
    04003: Mensagem := 'SAT j� ativado SAT dispon�vel para uso.';
    04004: Mensagem := 'SAT com uso cessado SAT bloqueado por cessa��o de uso.';
    04005: Mensagem := 'Erro de comunica��o com a SEFAZ Tentar novamente.';
    04006: Mensagem := 'CSR ICP-BRASIL criado com sucesso Processo de cria��o do CSR para certifica��o ICP-BRASIL com sucesso';
    04007: Mensagem := 'Erro na cria��o do CSR ICP-BRASIL Processo de cria��o do CSR para certifica��o ICP-BRASIL com erro';
    04098: Mensagem := 'SAT em processamento. Tente novamente.';
    04099: Mensagem := 'Erro desconhecido na ativa��o Informar ao administrador.';
    05000: Mensagem := 'Certificado transmitido com Sucesso ';
    05001: Mensagem := 'C�digo de ativa��o inv�lido.';
    05002: Mensagem := 'Erro de comunica��o com a SEFAZ. Tentar novamente.';
    05003: Mensagem := 'Certificado Inv�lido ';
    05098: Mensagem := 'SAT em processamento.';
    05099: Mensagem := 'Erro desconhecido Informar o administrador.';
    06000: Mensagem := 'Emitido com sucesso + conte�do notas. Retorno CF-e-SAT ao AC para conting�ncia.';
    06001: Mensagem := 'C�digo de ativa��o inv�lido.';
    06002: Mensagem := 'SAT ainda n�o ativado. Efetuar ativa��o.';
    06003: Mensagem := 'SAT n�o vinculado ao AC Efetuar vincula��o';
    06004: Mensagem := 'Vincula��o do AC n�o confere Efetuar vincula��o';
    06005: Mensagem := 'Tamanho do CF-e-SAT superior a 1.500KB';
    06006: Mensagem := 'SAT bloqueado pelo contribuinte';
    06007: Mensagem := 'SAT bloqueado pela SEFAZ';
    06008: Mensagem := 'SAT bloqueado por falta de comunica��o';
    06009: Mensagem := 'SAT bloqueado, c�digo de ativa��o incorreto';
    06010: Mensagem := 'Erro de valida��o do conte�do.';
    06098: Mensagem := 'SAT em processamento.';
    06099: Mensagem := 'Erro desconhecido na emiss�o. Informar o administrador.';
    07000: Mensagem := 'Cupom cancelado com sucesso + conte�do CF-eSAT cancelado.';
    07001: Mensagem := 'C�digo ativa��o inv�lido Verificar o c�digo e tentar mais uma vez.';
    07002: Mensagem := 'Cupom inv�lido Informar o administrador.';
    07003: Mensagem := 'SAT bloqueado pelo contribuinte';
    07004: Mensagem := 'SAT bloqueado pela SEFAZ';
    07005: Mensagem := 'SAT bloqueado por falta de comunica��o';
    07006: Mensagem := 'SAT bloqueado, c�digo de ativa��o incorreto';
    07007: Mensagem := 'Erro de valida��o do conte�do';
    07098: Mensagem := 'SAT em processamento.';
    07099: Mensagem := 'Erro desconhecido no cancelamento.';
    08000: Mensagem := 'SAT em opera��o. Verifica se o SAT est� ativo.';
    08098: Mensagem := 'SAT em processamento.';
    08099: Mensagem := 'Erro desconhecido. Informar o administrador.';
    09000: Mensagem := 'Emitido com sucesso Gera e envia um cupom de teste para SEFAZ, para verificar a comunica��o.';
    09001: Mensagem := 'c�digo ativa��o inv�lido Verificar o c�digo e tentar mais uma vez.';
    09002: Mensagem := 'SAT ainda n�o ativado. Efetuar ativa��o ';
    09098: Mensagem := 'SAT em processamento.';
    09099: Mensagem := 'Erro desconhecido Informar o ';
    10000: Mensagem := 'Resposta com Sucesso. Informa��es de status do SAT.';
    10001: Mensagem := 'C�digo de ativa��o inv�lido';
    10098: Mensagem := 'SAT em processamento.';
    10099: Mensagem := 'Erro desconhecido Informar o administrador.';
    11000: Mensagem := 'Emitido com sucesso Retorna o conte�do do CF-ao AC.';
    11001: Mensagem := 'c�digo ativa��o inv�lido Verificar o c�digo e tentar mais uma vez.';
    11002: Mensagem := 'SAT ainda n�o ativado. Efetuar ativa��o.';
    11003: Mensagem := 'Sess�o n�o existe. AC deve executar a sess�o novamente.';
    11098: Mensagem := 'SAT em processamento.';
    11099: Mensagem := 'Erro desconhecido. Informar o administrador.';
    12000: Mensagem := 'Rede Configurada com Sucesso';
    12001: Mensagem := 'c�digo ativa��o inv�lido Verificar o c�digo e tentar mais uma vez.';
    12002: Mensagem := 'Dados fora do padr�o a ser informado Corrigir dados';
    12098: Mensagem := 'SAT em processamento.';
    12099: Mensagem := 'Erro desconhecido Informar o administrador.';
    13000: Mensagem := 'Assinatura do AC';
    13001: Mensagem := 'c�digo ativa��o inv�lido Verificar o c�digo e tentar mais uma vez.';
    13002: Mensagem := 'Erro de comunica��o com a SEFAZ';
    13003: Mensagem := 'Assinatura fora do padr�o informado Corrigir dados';
    13004: Mensagem := 'CNPJ da Software House + CNPJ do emitente assinado no campo �signAC� difere do informado no campo �CNPJvalue� Corrigir dados';
    13098: Mensagem := 'SAT em processamento.';
    13099: Mensagem := 'Erro desconhecido Informar o administrador.';
    14000: Mensagem := 'Software Atualizado com Sucesso ';
    14001: Mensagem := 'C�digo de ativa��o inv�lido.';
    14002: Mensagem := 'Atualiza��o em Andamento';
    14003: Mensagem := 'Erro na atualiza��o N�o foi poss�vel Atualizar o SAT.';
    14004: Mensagem := 'Arquivo de atualiza��o inv�lido';
    14098: Mensagem := 'SAT em processamento.';
    14099: Mensagem := 'Erro desconhecido Informar o administrador.';
    15000: Mensagem := 'Transfer�ncia completa Arquivos de Logs extra�dos';
    15001: Mensagem := 'C�digo de ativa��o inv�lido.';
    15002: Mensagem := 'Transfer�ncia em andamento';
    15098: Mensagem := 'SAT em processamento.';
    15099: Mensagem := 'Erro desconhecido Informar o administrador.';
    16000: Mensagem := 'Equipamento SAT bloqueado com sucesso.';
    16001: Mensagem := 'C�digo de ativa��o inv�lido.';
    16002: Mensagem := 'Equipamento SAT j� est� bloqueado.';
    16003: Mensagem := 'Erro de comunica��o com a SEFAZ';
    16004: Mensagem := 'N�o existe parametriza��o de bloqueio dispon�vel.';
    16098: Mensagem := 'SAT em processamento.';
    16099: Mensagem := 'Erro desconhecido Informar o administrador.';
    17000: Mensagem := 'Equipamento SAT desbloqueado com sucesso.';
    17001: Mensagem := 'C�digo de ativa��o inv�lido.';
    17002: Mensagem := 'SAT bloqueado pelo contribuinte. Verifique configura��es na SEFAZ';
    17003: Mensagem := 'SAT bloqueado pela SEFAZ';
    17004: Mensagem := 'Erro de comunica��o com a SEFAZ';
    17098: Mensagem := 'SAT em processamento.';
    17099: Mensagem := 'Erro desconhecido Informar o administrador.';
    18000: Mensagem := 'C�digo de ativa��o alterado com sucesso.';
    18001: Mensagem := 'C�digo de ativa��o inv�lido.';
    18002: Mensagem := 'C�digo de ativa��o de emerg�ncia Incorreto.';
    18098: Mensagem := 'SAT em processamento.';
    18099: Mensagem := 'Erro desconhecido Informar o administrador.';
  else
    Mensagem := '';
  end;

  Result := ACBrStr(Mensagem);
end;

function MotivocStat(cStat: Integer): String;
var
  xMotivo: String;
begin
  (* Retorna a mensagem de rejei��o do c�digo no parametro
       pCodigo de acordo com a NOTA TECNICA 2013/001 *)

  case (cStat) of
    100: xMotivo := 'CF-e-SAT processado com sucesso';
    101: xMotivo := 'CF-e-SAT de cancelamento processado com sucesso';
    102: xMotivo := 'CF-e-SAT processado � verificar inconsist�ncias';
    103: xMotivo := 'CF-e-SAT de cancelamento processado � verificar inconsist�ncias';
    104: xMotivo := 'N�o Existe Atualiza��o do Software';
    105: xMotivo := 'Lote recebido com sucesso';
    106: xMotivo := 'Lote Processado';
    107: xMotivo := 'Lote em Processamento';
    108: xMotivo := 'Lote n�o localizado';
    109: xMotivo := 'Servi�o em Opera��o';
    110: xMotivo := 'Status SAT recebido com sucesso';
    112: xMotivo := 'Assinatura do AC Registrada';
    113: xMotivo := 'Consulta cadastro com uma ocorr�ncia';
    114: xMotivo := 'Consulta cadastro com mais de uma ocorr�ncia';
    115: xMotivo := 'Solicita��o de dados efetuada com sucesso';
    116: xMotivo := 'Atualiza��o do SB pendente';
    117: xMotivo := 'Solicita��o de Arquivo de Parametriza��o efetuada com sucesso';
    118: xMotivo := 'Logs extra�dos com sucesso';
    119: xMotivo := 'Comandos da SEFAZ pendentes';
    120: xMotivo := 'N�o existem comandos da SEFAZ pendentes';
    121: xMotivo := 'Certificado Digital criado com sucesso';
    122: xMotivo := 'CRT recebido com sucesso';
    123: xMotivo := 'Adiar transmiss�o do lote';
    124: xMotivo := 'Adiar transmiss�o do CF-e';
    125: xMotivo := 'CF-e de teste de produ��o emitido com sucesso';
    126: xMotivo := 'CF-e de teste de ativa��o emitido com sucesso';
    127: xMotivo := 'Erro na emiss�o de CF-e de teste de produ��o';
    128: xMotivo := 'Erro na emiss�o de CF-e de teste de ativa��o';
    129: xMotivo := 'Solicita��es de emiss�o de certificados excedidas. (Somente ocorrer� no ambiente de testes)';
    200: xMotivo := 'Rejei��o: Status do equipamento SAT difere do esperado';
    201: xMotivo := 'Rejei��o: Falha na Verifica��o da Assinatura do N�mero de seguran�a';
    202: xMotivo := 'Rejei��o: Falha no reconhecimento da autoria ou integridade do arquivo digital';
    203: xMotivo := 'Rejei��o: Emissor n�o Autorizado para emiss�o da CF-e-SAT';
    204: xMotivo := 'Rejei��o: Duplicidade de CF-e-SAT';
    205: xMotivo := 'Rejei��o: Equipamento SAT encontra-se Ativo';
    206: xMotivo := 'Rejei��o: Hora de Emiss�o do CF-e-SAT posterior � hora de recebimento.';
    207: xMotivo := 'Rejei��o: CNPJ do emitente inv�lido';
    208: xMotivo := 'Rejei��o: Equipamento SAT encontra-se Desativado';
    209: xMotivo := 'Rejei��o: IE do emitente inv�lida';
    210: xMotivo := 'Rejei��o: Intervalo de tempo entre o CF-e-SAT emitido e a emiss�o do respectivo CF-e-SAT de cancelamento � maior que 30 (trinta) minutos.';
    211: xMotivo := 'Rejei��o: CNPJ n�o corresponde ao informado no processo de transfer�ncia.';
    212: xMotivo := 'Rejei��o: Data de Emiss�o do CF-e-SAT posterior � data de recebimento.';
    213: xMotivo := 'Rejei��o: CNPJ-Base do Emitente difere do CNPJ-Base do Certificado Digital';
    214: xMotivo := 'Rejei��o: Tamanho da mensagem excedeu o limite estabelecido';
    215: xMotivo := 'Rejei��o: Falha no schema XML';
    216: xMotivo := 'Rejei��o: Chave de Acesso difere da cadastrada';
    217: xMotivo := 'Rejei��o: CF-e-SAT n�o consta na base de dados da SEFAZ';
    218: xMotivo := 'Rejei��o: CF-e-SAT j� esta cancelado na base de dados da SEFAZ';
    219: xMotivo := 'Rejei��o: CNPJ n�o corresponde ao informado no processo de declara��o de posse.';
    220: xMotivo := 'Rejei��o: Valor do rateio do desconto sobre subtotal do item (N) inv�lido.';
    221: xMotivo := 'Rejei��o: Aplicativo Comercial n�o vinculado ao SAT';
    222: xMotivo := 'Rejei��o: Assinatura do Aplicativo Comercial inv�lida';
    223: xMotivo := 'Rejei��o: CNPJ do transmissor do lote difere do CNPJ do transmissor da consulta';
    224: xMotivo := 'Rejei��o: CNPJ da Software House inv�lido';
    225: xMotivo := 'Rejei��o: Falha no Schema XML do lote de CFe';
    226: xMotivo := 'Rejei��o: C�digo da UF do Emitente diverge da UF receptora';
    227: xMotivo := 'Rejei��o: Erro na Chave de Acesso - Campo Id � falta a literal CFe';
    228: xMotivo := 'Rejei��o: Valor do rateio do acr�scimo sobre subtotal do item (N) inv�lido.';
    229: xMotivo := 'Rejei��o: IE do emitente n�o informada';
    230: xMotivo := 'Rejei��o: IE do emitente n�o autorizada para uso do SAT';
    231: xMotivo := 'Rejei��o: IE do emitente n�o vinculada ao CNPJ';
    232: xMotivo := 'Rejei��o: CNPJ do destinat�rio do CF-e-SAT de cancelamento diferente daquele do CF-e-SAT a ser cancelado.';
    233: xMotivo := 'Rejei��o: CPF do destinat�rio do CF-e-SAT de cancelamento diferente daquele do CF-e-SAT a ser cancelado.';
    234: xMotivo := 'Alerta: Raz�o Social/Nome do destinat�rio em branco';
    235: xMotivo := 'Rejei��o: CNPJ do destinatario Invalido';
    236: xMotivo := 'Rejei��o: Chave de Acesso com d�gito verificador inv�lido';
    237: xMotivo := 'Rejei��o: CPF do destinatario Invalido';
    238: xMotivo := 'Rejei��o: CNPJ do emitente do CF-e-SAT de cancelamento diferente do CNPJ do CF-e-SAT a ser cancelado.';
    239: xMotivo := 'Rejei��o: Vers�o do arquivo XML n�o suportada';
    240: xMotivo := 'Rejei��o: Valor total do CF-e-SAT de cancelamento diferente do Valor total do CF-e-SAT a ser cancelado.';
    241: xMotivo := 'Rejei��o: diferen�a de transmiss�o e recebimento da mensagem superior a 5 minutos.';
    242: xMotivo := 'Alerta: CFe dentro do lote est�o fora de ordem.';
    243: xMotivo := 'Rejei��o: XML Mal Formado';
    244: xMotivo := 'Rejei��o: CNPJ do Certificado Digital difere do CNPJ da Matriz e do CNPJ do Emitente';
    245: xMotivo := 'Rejei��o: CNPJ Emitente n�o autorizado para uso do SAT';
    246: xMotivo := 'Rejei��o: Campo cUF inexistente no elemento cfeCabecMsg do SOAP Header';
    247: xMotivo := 'Rejei��o: Sigla da UF do Emitente diverge da UF receptora';
    248: xMotivo := 'Rejei��o: UF do Recibo diverge da UF autorizadora';
    249: xMotivo := 'Rejei��o: UF da Chave de Acesso diverge da UF receptora';
    250: xMotivo := 'Rejei��o: UF informada pelo SAT, n�o � atendida pelo Web Service';
    251: xMotivo := 'Rejei��o: Certificado enviado n�o confere com o escolhido na declara��o de posse';
    252: xMotivo := 'Rejei��o: Ambiente informado diverge do Ambiente de recebimento';
    253: xMotivo := 'Rejei��o: Digito Verificador da chave de acesso composta inv�lida';
    254: xMotivo := 'Rejei��o: Elemento cfeCabecMsg inexistente no SOAP Header';
    255: xMotivo := 'Rejei��o: CSR enviado inv�lido';
    256: xMotivo := 'Rejei��o: CRT enviado inv�lido';
    257: xMotivo := 'Rejei��o: N�mero do s�rie do equipamento inv�lido';
    258: xMotivo := 'Rejei��o: Data e/ou hora do envio inv�lida';
    259: xMotivo := 'Rejei��o: Vers�o do leiaute inv�lida';
    260: xMotivo := 'Rejei��o: UF inexistente';
    261: xMotivo := 'Rejei��o: Assinatura digital n�o encontrada';
    262: xMotivo := 'Rejei��o: CNPJ da software house n�o est� ativo';
    263: xMotivo := 'Rejei��o: CNPJ do contribuinte n�o est� ativo';
    264: xMotivo := 'Rejei��o: Base da receita federal est� indispon�vel';
    265: xMotivo := 'Rejei��o: N�mero de s�rie inexistente no cadastro do equipamento';
    266: xMotivo := 'Falha na comunica��o com a AC-SAT';
    267: xMotivo := 'Erro desconhecido na gera��o do certificado pela AC-SAT';
    268: xMotivo := 'Rejei��o: Certificado est� fora da data de validade.';
    269: xMotivo := 'Rejei��o: Tipo de atividade inv�lida';
    270: xMotivo := 'Rejei��o: Chave de acesso do CFe a ser cancelado inv�lido.';
    271: xMotivo := 'Rejei��o: Ambiente informado no CF-e difere do Ambiente de recebimento cadastrado.';
    272: xMotivo := 'Rejei��o: Valor do troco negativo.';
    273: xMotivo := 'Rejei��o: Servi�o Solicitado Inv�lido';
    274: xMotivo := 'Rejei��o: Equipamento n�o possui declara��o de posse';
    275: xMotivo := 'Rejei��o: Status do equipamento diferente de Fabricado';
    276: xMotivo := 'Rejei��o: Diferen�a de dias entre a data de emiss�o e de recep��o maior que o prazo legal';
    277: xMotivo := 'Rejei��o: CNPJ do emitente n�o est� ativo junto � Sefaz na data de emiss�o';
    278: xMotivo := 'Rejei��o: IE do emitente n�o est� ativa junto � Sefaz na data de emiss�o';
    280: xMotivo := 'Rejei��o: Certificado Transmissor Inv�lido';
    281: xMotivo := 'Rejei��o: Certificado Transmissor Data Validade';
    282: xMotivo := 'Rejei��o: Certificado Transmissor sem CNPJ';
    283: xMotivo := 'Rejei��o: Certificado Transmissor - erro Cadeia de Certifica��o';
    284: xMotivo := 'Rejei��o: Certificado Transmissor revogado';
    285: xMotivo := 'Rejei��o: Certificado Transmissor difere ICP-Brasil';
    286: xMotivo := 'Rejei��o: Certificado Transmissor erro no acesso a LCR';
    287: xMotivo := 'Rejei��o: C�digo Munic�pio do FG - ISSQN: d�gito inv�lido. Exceto os c�digos descritos no Anexo 2 que apresentam d�gito inv�lido.';
    288: xMotivo := 'Rejei��o: Data de emiss�o do CF-e-SAT a ser cancelado inv�lida';
    289: xMotivo := 'Rejei��o: C�digo da UF informada diverge da UF solicitada';
    290: xMotivo := 'Rejei��o: Certificado Assinatura inv�lido';
    291: xMotivo := 'Rejei��o: Certificado Assinatura Data Validade';
    292: xMotivo := 'Rejei��o: Certificado Assinatura sem CNPJ';
    293: xMotivo := 'Rejei��o: Certificado Assinatura - erro Cadeia de Certifica��o';
    294: xMotivo := 'Rejei��o: Certificado Assinatura revogado';
    295: xMotivo := 'Rejei��o: Certificado Raiz difere dos V�lidos';
    296: xMotivo := 'Rejei��o: Certificado Assinatura erro no acesso a LCR';
    297: xMotivo := 'Rejei��o: Assinatura difere do calculado';
    298: xMotivo := 'Rejei��o: Assinatura difere do padr�o do Projeto';
    299: xMotivo := 'Rejei��o: Hora de emiss�o do CF-e-SAT a ser cancelado inv�lida';
    402: xMotivo := 'Rejei��o: XML da �rea de dados com codifica��o diferente de UTF-8';
    403: xMotivo := 'Rejei��o: Vers�o do leiaute do CF-e-SAT n�o � v�lida';
    404: xMotivo := 'Rejei��o: Uso de prefixo de namespace n�o permitido';
    405: xMotivo := 'Alerta: Vers�o do leiaute do CF-e-SAT n�o � a mais atual';
    406: xMotivo := 'Rejei��o: Vers�o do Software B�sico do SAT n�o � valida.';
    407: xMotivo := 'Rejei��o: Indicador de CF-e-SAT cancelamento inv�lido (diferente de �C? e �?)';
    408: xMotivo := 'Rejei��o: Valor total do CF-e-SAT maior que o somat�rio dos valores de Meio de Pagamento empregados em seu pagamento.';
    409: xMotivo := 'Rejei��o: Valor total do CF-e-SAT supera o m�ximo permitido no arquivo de Parametriza��o de Uso';
    410: xMotivo := 'Rejei��o: UF informada no campo cUF n�o � atendida pelo Web Service';
    411: xMotivo := 'Rejei��o: Campo versaoDados inexistente no elemento cfeCabecMsg do SOAP Header';
    412: xMotivo := 'Rejei��o: CFe de cancelamento n�o corresponde ao CFe anteriormente gerado';
    420: xMotivo := 'Rejei��o: Cancelamento para CF-e-SAT j� cancelado';
    450: xMotivo := 'Rejei��o: Modelo da CF-e-SAT diferente de 59';
    452: xMotivo := 'Rejei��o: n�mero de s�rie do SAT inv�lido ou n�o autorizado.';
    453: xMotivo := 'Rejei��o: Ambiente de processamento inv�lido (diferente de 1 e 2)';
    454: xMotivo := 'Rejei��o: CNPJ da Software House inv�lido';
    455: xMotivo := 'Rejei��o: Assinatura do Aplicativo Comercial n�o � v�lida.';
    456: xMotivo := 'Rejei��o: C�digo de Regime tribut�rio invalido';
    457: xMotivo := 'Rejei��o: C�digo de Natureza da Opera��o para ISSQN inv�lido';
    458: xMotivo := 'Rejei��o: Raz�o Social/Nome do destinat�rio em branco';
    459: xMotivo := 'Rejei��o: C�digo do produto ou servi�o em branco';
    460: xMotivo := 'Rejei��o: GTIN do item (N) inv�lido';
    461: xMotivo := 'Rejei��o: Descri��o do produto ou servi�o em branco';
    462: xMotivo := 'Rejei��o: CFOP n�o � de opera��o de sa�da prevista para CF-e-SAT';
    463: xMotivo := 'Rejei��o: Unidade comercial do produto ou servi�o em branco';
    464: xMotivo := 'Rejei��o: Quantidade Comercial do item (N) inv�lido';
    465: xMotivo := 'Rejei��o: Valor unit�rio do item (N) inv�lido';
    466: xMotivo := 'Rejei��o: Valor bruto do item (N) difere de quantidade * Valor Unit�rio, considerando regra de arred/trunc.';
    467: xMotivo := 'Rejei��o: Regra de calculo do item (N) inv�lida';
    468: xMotivo := 'Rejei��o: Valor do desconto do item (N) inv�lido';
    469: xMotivo := 'Rejei��o: Valor de outras despesas acess�rias do item (N) inv�lido.';
    470: xMotivo := 'Rejei��o: Valor l�quido do Item do CF-e difere de Valor Bruto de Produtos e Servi�os - desconto + Outras Despesas Acess�rias � rateio do desconto sobre subtotal + rateio do acr�scimo sobre subtotal ';
    471: xMotivo := 'Rejei��o: origem da mercadoria do item (N) inv�lido (difere de 0, 1, 2, 3, 4, 5, 6 e 7)';
    472: xMotivo := 'Rejei��o: CST do Item (N) inv�lido (diferente de 00, 20, 90)';
    473: xMotivo := 'Rejei��o: Al�quota efetiva do ICMS do item (N) inv�lido.';
    474: xMotivo := 'Rejei��o: Valor l�quido do ICMS do Item (N) difere de Valor do Item * Aliquota Efetiva';
    475: xMotivo := 'Rejei��o: CST do Item (N) inv�lido (diferente de 40 e 41 e 50 e 60)';
    476: xMotivo := 'Rejei��o: C�digo de situa��o da opera��o - Simples Nacional - do Item (N) inv�lido (diferente de 102, 300 e 500)';
    477: xMotivo := 'Rejei��o: C�digo de situa��o da opera��o - Simples Nacional - do Item (N) inv�lido (diferente de 900)';
    478: xMotivo := 'Rejei��o: C�digo de Situa��o Tribut�ria do PIS Inv�lido (diferente de 01 e 02)';
    479: xMotivo := 'Rejei��o: Base de c�lculo do PIS do item (N) inv�lido.';
    480: xMotivo := 'Rejei��o: Al�quota do PIS do item (N) inv�lido.';
    481: xMotivo := 'Rejei��o: Valor do PIS do Item (N) difere de Base de Calculo * Aliquota do PIS';
    482: xMotivo := 'Rejei��o: C�digo de Situa��o Tribut�ria do PIS Inv�lido (diferente de 03)';
    483: xMotivo := 'Rejei��o: Qtde Vendida do item (N) inv�lido.';
    484: xMotivo := 'Rejei��o: Al�quota do PIS em R$ do item (N) inv�lido.';
    485: xMotivo := 'Rejei��o: Valor do PIS do Item (N) difere de Qtde Vendida* Aliquota do PIS em R$';
    486: xMotivo := 'Rejei��o: C�digo de Situa��o Tribut�ria do PIS Inv�lido (diferente de 04, 06, 07, 08 e 09)';
    487: xMotivo := 'Rejei��o: C�digo de Situa��o Tribut�ria do PIS inv�lido (diferente de 49)';
    488: xMotivo := 'Rejei��o: C�digo de Situa��o Tribut�ria do PIS Inv�lido (diferente de 99)';
    489: xMotivo := 'Rejei��o: Valor do PIS do Item (N) difere de Qtde Vendida* Aliquota do PIS em R$ e difere de Base de Calculo * Aliquota do PIS';
    490: xMotivo := 'Rejei��o: C�digo de Situa��o Tribut�ria da COFINS Inv�lido (diferente de 01 e 02)';
    491: xMotivo := 'Rejei��o: Base de c�lculo do COFINS do item (N) inv�lido.';
    492: xMotivo := 'Rejei��o: Al�quota da COFINS do item (N) inv�lido.';
    493: xMotivo := 'Rejei��o: Valor da COFINS do Item (N) difere de Base de Calculo * Aliquota da COFINS';
    494: xMotivo := 'Rejei��o: C�digo de Situa��o Tribut�ria da COFINS Inv�lido (diferente de 03)';
    495: xMotivo := 'Rejei��o: Valor do COFINS do Item (N) difere de Qtde Vendida* Aliquota do COFINS em R$ e difere de Base de Calculo * Aliquota do COFINS';
    496: xMotivo := 'Rejei��o: Al�quota da COFINS em R$ do item (N) inv�lido.';
    497: xMotivo := 'Rejei��o: Valor da COFINS do Item (N) difere de Qtde Vendida* Aliquota da COFINS em R$';
    498: xMotivo := 'Rejei��o: C�digo de Situa��o Tribut�ria da COFINS Inv�lido (diferente de 04, 06, 07, 08 e 09)';
    499: xMotivo := 'Rejei��o: C�digo de Situa��o Tribut�ria da COFINS Inv�lido (diferente de 49)';
    500: xMotivo := 'Rejei��o: C�digo de Situa��o Tribut�ria da COFINS Inv�lido (diferente de 99)';
    501: xMotivo := 'Rejei��o: Opera��o com tributa��o de ISSQN sem informar a Inscri��o Municipal';
    502: xMotivo := 'Rejei��o: Erro na Chave de Acesso - Campo Id n�o corresponde � concatena��o dos campos correspondentes';
    503: xMotivo := 'Rejei��o: Valor das dedu��es para o ISSQN do item (N) inv�lido.';
    504: xMotivo := 'Rejei��o: Valor da Base de Calculo do ISSQN do Item (N) difere de Valor do Item - Valor das dedu��es';
    505: xMotivo := 'Rejei��o: Al�quota efetiva do ISSQN do item (N) n�o � maior ou igual a 2,00 (2%) e menor ou igual a 5,00 (5%).';
    506: xMotivo := 'Valor do ISSQN do Item (N) difere de Valor da Base de Calculo do ISSQN * Al�quota Efetiva do ISSQN';
    507: xMotivo := 'Rejei��o: Indicador de rateio para ISSQN inv�lido';
    508: xMotivo := 'Rejei��o: Item da lista de Servi�os do ISSQN do item (N) inv�lido.';
    509: xMotivo := 'Rejei��o: C�digo municipal de Tributa��o do ISSQN do Item (N) em branco.';
    510: xMotivo := 'Rejei��o: C�digo de Natureza da Opera��o para ISSQN inv�lido';
    511: xMotivo := 'Rejei��o: Indicador de Incentivo Fiscal do ISSQN do item (N) inv�lido (diferente de 1 e 2)';
    512: xMotivo := 'Rejei��o: Total do PIS difere do somat�rio do PIS dos itens';
    513: xMotivo := 'Rejei��o: Total do COFINS difere do somat�rio do COFINS dos itens';
    514: xMotivo := 'Rejei��o: Total do PIS-ST difere do somat�rio do PIS-ST dos itens';
    515: xMotivo := 'Rejei��o: Total do COFINS-STdifere do somat�rio do COFINS-ST dos itens';
    516: xMotivo := 'Rejei��o: Total de Outras Despesas Acess�rias difere do somat�rio de Outras Despesas Acess�rias (acr�scimo) dos itens';
    517: xMotivo := 'Rejei��o: Total dos Itens difere do somat�rio do valor l�quido dos itens';
    518: xMotivo := 'Rejei��o: Informado grupo de totais do ISSQN sem informar grupo de valores de ISSQN';
    519: xMotivo := 'Rejei��o: Total da BC do ISSQN difere do somat�rio da BC do ISSQN dos itens';
    520: xMotivo := 'Rejei��o: Total do ISSQN difere do somat�rio do ISSQN dos itens';
    521: xMotivo := 'Rejei��o: Total do PIS sobre servi�os difere do somat�rio do PIS dos itens de servi�os';
    522: xMotivo := 'Rejei��o: Total do COFINS sobre servi�os difere do somat�rio do COFINS dos itens de servi�os';
    523: xMotivo := 'Rejei��o: Total do PIS-ST sobre servi�os difere do somat�rio do PIS-ST dos itens de servi�os';
    524: xMotivo := 'Rejei��o: Total do COFINS-ST sobre servi�os difere do somat�rio do COFINS-ST dos itens de servi�os';
    525: xMotivo := 'Rejei��o: Valor de Desconto sobre total inv�lido.';
    526: xMotivo := 'Rejei��o: Valor de Acr�scimo sobre total inv�lido.';
    527: xMotivo := 'Rejei��o: C�digo do Meio de Pagamento inv�lido';
    528: xMotivo := 'Rejei��o: Valor do Meio de Pagamento inv�lido.';
    529: xMotivo := 'Rejei��o: Valor de desconto sobre subtotal difere do somat�rio dos seus rateios nos itens.';
    530: xMotivo := 'Rejei��o: Opera��o com tributa��o de ISSQN sem informar a Inscri��o Municipal';
    531: xMotivo := 'Rejei��o: Valor de acr�scimo sobre subtotal difere do somat�rio dos seus rateios nos itens.';
    532: xMotivo := 'Rejei��o: Total do ICMS difere do somat�rio dos itens';
    533: xMotivo := 'Rejei��o: Valor aproximado dos tributos do CF-e-SAT � Lei 12741/12 inv�lido';
    534: xMotivo := 'Rejei��o: Valor aproximado dos tributos do Produto ou servi�o � Lei 12741/12 inv�lido.';
    535: xMotivo := 'Rejei��o: c�digo da credenciadora de cart�o de d�bito ou cr�dito inv�lido';
    537: xMotivo := 'Rejei��o: Total do Desconto difere do somat�rio dos itens';
    539: xMotivo := 'Rejei��o: Duplicidade de CF-e-SAT, com diferen�a na Chave de Acesso [99999999999999999999999999999999999999999]';
    540: xMotivo := 'Rejei��o: CNPJ da Software House + CNPJ do emitente assinado no campo �signAC� difere do informado no campo �CNPJvalue� ';
    555: xMotivo := 'Rejei��o: Tipo autorizador do protocolo diverge do �rg�o Autorizador';
    564: xMotivo := 'Rejei��o: Total dos Produtos ou Servi�os difere do somat�rio do valor dos Produtos ou Servi�os dos itens';
    600: xMotivo := 'Servi�o Temporariamente Indispon�vel';
    601: xMotivo := 'CF-e-SAT inid�neo por recep��o fora do prazo';
    602: xMotivo := 'Rejei��o: Status do equipamento n�o permite ativa��o';
    603: xMotivo := 'Arquivo inv�lido';
    604: xMotivo := 'Erro desconhecido na verifica��o de comandos';
    605: xMotivo := 'Tamanho do arquivo inv�lido';
    999: xMotivo := 'Rejei��o: Erro n�o catalogado';
  else
    xMotivo := 'Rejei��o n�o catalogada na nota t�cnica 2013/001.';
  end;

  Result := ACBrStr(xMotivo);
end;

function MotivoInvalidoVenda(cod: integer): String;
begin
  case cod of
    1002 : Result := 'C�digo da UF n�o confere com a Tabela do IBGE'; // | V�lido at� 31/12/2015
    1003 : Result := 'C�digo da UF diferente da UF registrada no SAT';// | V�lido at� 31/12/2015
    1004 : Result := 'Vers�o do leiaute do arquivo de entrada do SAT n�o � v�lida';
    1005 : Result := 'Alerta Vers�o do leiaute do arquivo de entrada do SAT n�o � a mais atual';
    1226 : Result := 'C�digo da UF do Emitente diverge da UF receptora';
    1450 : Result := 'C�digo de modelo de documento fiscal diferente de 59';
    1258 : Result := 'Data/hora inv�lida. Problemas com o rel�gio interno do SAT-CF-e';
    1224 : Result := 'CNPJ da Software House inv�lido';
    1222 : Result := 'Assinatura do Aplicativo Comercial n�o � v�lida';// | V�lido at� 31/12/2015
    1207 : Result := 'CNPJ do emitente inv�lido';
    1203 : Result := 'Emitente n�o autorizado para uso do SAT';
    1229 : Result := 'IE do emitente n�o informada C12 IE n�o corresponde ao Contribuinte de uso do SAT';
    1230 : Result := 'IE do emitente diferente da IE do contribuinte autorizado para uso do SAT';// | Checar com dado recebido na parametriza��o do SAT
    1457 : Result := 'C�digo de Natureza da Opera��o para ISSQN inv�lido';
    1507 : Result := 'Indicador de rateio para ISSQN inv�lido';
    1235 : Result := 'CNPJ do destinat�rio inv�lido';
    1237 : Result := 'CPF do destinat�rio inv�lido';
    1234 : Result := 'Alerta Raz�o Social/Nome do destinat�rio em branco';//| V�lido at� 31/12/2015
    1019 : Result := 'Numera��o dos itens n�o � sequencial crescente';
    1459 : Result := 'C�digo do produto ou servi�o em branco';
    1460 : Result := 'GTIN do item (N) inv�lido | Valida��o do d�gito verificador';
    1461 : Result := 'Descri��o do produto ou servi�o em branco';
    1464 : Result := 'Quantidade Comercial do item (N) inv�lido';
    1465 : Result := 'Valor Unit�rio do item (N) inv�lido';
    1468 : Result := 'Valor do Desconto do item (N) inv�lido';
    1469 : Result := 'Valor de outras despesas acess�rias do item (N) inv�lido';
    1535 : Result := 'c�digo da credenciadora de cart�o de d�bito ou cr�dito inv�lido';
    1220 : Result := 'Valor do rateio do desconto sobre subtotal do item (N) inv�lido';
    1228 : Result := 'Valor do rateio do acr�scimo sobre subtotal do item (N) inv�lido';
    1751 : Result := 'n�o informado c�digo do produto'; //| Nova reda��o, efeitos a partir de 01.01.17.
    1752 : Result := 'c�digo de produto informado fora do padr�o ANP'; //| Nova reda��o, efeitos a partir de 01.01.17.
    1534 : Result := 'Valor aproximado dos tributos do produto negativo';
    1533 : Result := 'Valor aproximado dos tributos do CF-e_SAT negativo';
    1471 : Result := 'Origem da mercadoria do Item (N) inv�lido (diferente de 0, 1, 2, 3, 4, 5, 6, 7, 8)';
    1472 : Result := 'CST do Item (N) inv�lido (diferente de 00, 20, 90)';
    1473 : Result := 'Al�quota efetiva do ICMS do item (N) n�o � maior ou igual a zero';
    1475 : Result := 'CST do Item (N) inv�lido (diferente de 40 e 41 e 50 e 60)';
    1476 : Result := 'C�digo de situa��o da opera��o - Simples Nacional - do Item (N) inv�lido (diferente de 102, 300 e 500)';
    1477 : Result := 'C�digo de situa��o da opera��o - Simples Nacional - do Item (N) inv�lido (diferente de 900)';
    1478 : Result := 'C�digo de Situa��o Tribut�ria do PIS Inv�lido (diferente de 01, 02 e 05)';
    1479 : Result := 'Base de c�lculo do PIS do item (N) inv�lido';
    1480 : Result := 'Al�quota do PIS do item (N) n�o � maior ou igual a zero';
    1482 : Result := 'C�digo de Situa��o Tribut�ria do PIS Inv�lido (diferente de 03)';
    1483 : Result := 'Qtde Vendida do item (N) n�o � maior ou igual a zero';
    1484 : Result := 'Al�quota do PIS em R$ do item (N) n�o � maior ou igual a zero';
    1486 : Result := 'C�digo de Situa��o Tribut�ria do PIS Inv�lido (diferente de 04, 06, 07, 08 e 09)';
    1487 : Result := 'C�digo de Situa��o Tribut�ria do PIS inv�lido (diferente de 49)';
    1488 : Result := 'C�digo de Situa��o Tribut�ria do PIS Inv�lido (diferente de 99)';
    1490 : Result := 'C�digo de Situa��o Tribut�ria da COFINS Inv�lido (diferente de 01, 02 e 05)';
    1491 : Result := 'Base de c�lculo do COFINS do item (N) inv�lido';
    1492 : Result := 'Al�quota da COFINS do item (N) n�o � maior ou igual a zero';
    1494 : Result := 'C�digo de Situa��o Tribut�ria da COFINS Inv�lido (diferente de 03)';
    1496 : Result := 'Al�quota da COFINS em R$ do item (N) n�o � maior ou igual a zero';
    1498 : Result := 'C�digo de Situa��o Tribut�ria da COFINS Inv�lido (diferente de 04, 06, 07, 08 e 09)';
    1499 : Result := 'C�digo de Situa��o Tribut�ria da COFINS Inv�lido (diferente de 49)';
    1500 : Result := 'C�digo de Situa��o Tribut�ria da COFINS Inv�lido (diferente de 99)';
    1501 : Result := 'Opera��o com tributa��o de ISSQN sem informar a Inscri��o Municipal';
    1503 : Result := 'Valor das dedu��es para o ISSQN do item (N) n�o � maior ou igual a zero';
    1505 : Result := 'Al�quota efetiva do ISSQN do item (N) n�o � maior ou igual a 2,00 (2%) e menor ou igual a 5,00 (5%)';
    1287 : Result := 'C�digo Munic�pio do FG - ISSQN: d�gito inv�lido. Exceto os c�digos descritos no Anexo 2 que apresentam d�gito inv�lido';
    1509 : Result := 'C�digo municipal de Tributa��o do ISSQN do Item (N) em branco';
    1510 : Result := 'C�digo de Natureza da Opera��o para ISSQN inv�lido';
    1511 : Result := 'Indicador de Incentivo Fiscal do ISSQN do item (N) inv�lido (diferente de 1 e 2)';
    1527 : Result := 'C�digo do Meio de Pagamento inv�lido';
    1528 : Result := 'Valor do Meio de Pagamento inv�lido';
    1408 : Result := 'Valor total do CF-e-SAT maior que o somat�rio dos valores de Meio de Pagamento empregados em seu pagamento';
    1409 : Result := 'Valor total do CF-e-SAT supera o m�ximo permitido no arquivo de Parametriza��o de Uso';
    1073 : Result := 'Valor de Desconto sobre total n�o � maior ou igual a zero';
    1074 : Result := 'Valor de Acr�scimo sobre total n�o � maior ou igual a zero';
    1084 : Result := 'Erro Formata��o do Certificado n�o � v�lido';
    1085 : Result := 'Erro Assinatura do Aplicativo Comercial n�o confere com o registro do SAT'; //| V�lido at� 31/12/2015
    1998 : Result := 'N�o � poss�vel gerar o cupom com os dados de entrada informados, pois resultam valores negativos';
  else
    Result := 'Erro n�o identificado';
  end;
end;

function MotivoInvalidoCancelamento(cod: integer): String;
begin
  case cod of
    1270 : Result := 'Chave de acesso do CFe a ser cancelado inv�lido';
    1412 : Result := 'CFe de cancelamento n�o corresponde a um CFe emitido nos 30 minutos anteriores ao pedido de cancelamento';
    1258 : Result := 'Data/hora inv�lida. Problemas com o rel�gio interno do SAT-CF-e';
    1210 : Result := 'Intervalo de tempo entre a emiss�o do CF-e a ser cancelado e a emiss�o do respectivo CF-e de cancelamento � maior que 30 (trinta) minutos';
    1454 : Result := 'CNPJ da Software House inv�lido';
    1232 : Result := 'CNPJ do destinat�rio do CF-e de cancelamento diferente daquele do CF-e a ser cancelado';
    1233 : Result := 'CPF do destinat�rio do CF-e de cancelamento diferente daquele do CF-e a ser cancelado';
    1218 : Result := 'Erro Chave de acesso do CF-e-SAT j� consta como cancelado'; //Nova reda��o a partir de 01.01.16
    1999 : Result := 'Erro n�o identificado'; //Implementa��o facultativa at� 31.12.15 e obrigat�ria a partir de 01.01.16.
  else
    Result := 'Erro n�o identificado';
  end;
end;

{ TACBrSAT }

constructor TACBrSAT.Create(AOwner : TComponent) ;
begin
  inherited Create(AOwner) ;

  fsnumeroSessao    := 0;
  fsNomeDLL         := '';
  fsArqLOG          := '' ;
  fsComandoLog      := '';
  fsRespostaComando := '';

  fsOnGetcodigoDeAtivacao := nil;
  fsOnGetsignAC           := nil;
  fsOnGravarLog           := nil;
  fsOnGetNumeroSessao     := nil;

  fsConfig  := TACBrSATConfig.Create;
  fsRede    := TRede.Create;
  fsCFe     := TCFe.Create;
  fsCFeCanc := TCFeCanc.Create;
  fsResposta:= TACBrSATResposta.Create;
  fsStatus  := TACBrSATStatus.Create;
  fsSATClass:= TACBrSATClass.Create( Self ) ;

  fsSalvarCFes           := False;
  fsPastaCFeCancelamento := '';
  fsPastaCFeVenda        := '';
  fsPrefixoCFe           := CPREFIXO_CFe;
end ;

destructor TACBrSAT.Destroy ;
begin
  fsConfig.Free;
  fsRede.Free;
  fsCFe.Free;
  fsCFeCanc.Free;
  fsResposta.Free;
  fsStatus.Free;

  if Assigned( fsSATClass ) then
    FreeAndNil( fsSATClass );

  inherited Destroy ;
end ;

procedure TACBrSAT.Inicializar ;
begin
  if fsInicializado then exit ;

  if fsModelo = satNenhum then
     raise EACBrSATErro.Create( cACBrSATModeloNaoDefinido );

  fsSATClass.Inicializar ;
  Randomize;

  DoLog( 'ACBrSAT.Inicializado');
  fsInicializado := true ;
  fsPrefixoCFe := CPREFIXO_CFe;
end ;

procedure TACBrSAT.DesInicializar ;
begin
  if not fsInicializado then exit ;

  fsSATClass.DesInicializar ;

  DoLog( 'ACBrSAT.DesInicializado');
  fsInicializado := false;
end ;

procedure TACBrSAT.VerificaInicializado ;
begin
  if not Inicializado then
     raise EACBrSATErro.Create( cACBrSATNaoInicializado ) ;
end ;

procedure TACBrSAT.IniciaComando ;
var
  AStr : String ;
begin
  VerificaInicializado;
  GerarnumeroSessao;

  fsRespostaComando := '';
  AStr := '-- '+FormatDateTime('hh:nn:ss:zzz',now) +
          ' - numeroSessao: '+IntToStr(numeroSessao) ;
  if fsComandoLog <> '' then
     AStr := AStr + ' - Comando: '+fsComandoLog;

  DoLog( AStr );
end ;

function TACBrSAT.FinalizaComando( AResult : String ) : String ;
var
  AStr : String ;
begin
  fsRespostaComando := DecodificarPaginaDeCodigoSAT( AResult );
  Result := fsRespostaComando;

  fsComandoLog := '';
  AStr := 'NumeroSessao: '+IntToStr(numeroSessao) ;
  if fsRespostaComando <> '' then
     AStr := AStr + ' - Resposta:'+fsRespostaComando;

  Resposta.RetornoStr := fsRespostaComando;

  DoLog( AStr );
end ;

procedure TACBrSAT.VerificaCondicoesImpressao(EhCancelamento: Boolean);
begin
  if not Assigned(Extrato) then
    raise EACBrSATErro.Create( 'Nenhum componente "ACBrSATExtrato" associado' ) ;

  if EhCancelamento then
  begin
    if (CFeCanc.infCFe.ID = '') and (CFe.infCFe.ID = '') then
      raise EACBrSATErro.Create( 'Nenhum CFeCanc ou CFe carregado na mem�ria' ) ;
  end
  else
  begin
    if (CFe.infCFe.ID = '') then
      raise EACBrSATErro.Create( 'Nenhum CFe carregado na mem�ria' ) ;
  end;
end;

procedure TACBrSAT.DoLog(AString : String) ;
var
  Tratado: Boolean;
begin
  Tratado := False;
  if Assigned( fsOnGravarLog ) then
    fsOnGravarLog( AString, Tratado );

  if not Tratado then
    GravaLog( AString );
end ;

procedure TACBrSAT.GravaLog(AString : AnsiString) ;
begin
  if (ArqLOG = '') then
    exit;

  WriteLog( ArqLOG, ' - '+FormatDateTime('hh:nn:ss:zzz',now) + ' - ' + AString );
end ;

function TACBrSAT.GerarnumeroSessao : Integer ;
begin
  fsnumeroSessao := Random(999999);

  if Assigned( fsOnGetNumeroSessao ) then
     fsOnGetNumeroSessao( fsnumeroSessao ) ;

  Result := fsnumeroSessao;
end ;

procedure TACBrSAT.InicializaCFe(ACFe : TCFe) ;
Var
  wCFe : TCFe ;
begin
  if Assigned( ACFe ) then
    wCFe := ACFe
  else
    wCFe := fsCFe;

  with wCFe do
  begin
    Clear;
    ide.CNPJ              := fsConfig.ide_CNPJ;
    ide.tpAmb             := fsConfig.ide_tpAmb;
    ide.numeroCaixa       := fsConfig.ide_numeroCaixa;
    ide.signAC            := signAC;
    ide.modelo            := 59;
    Emit.CNPJCPF          := fsConfig.emit_CNPJ;
    Emit.IE               := fsConfig.emit_IE;
    Emit.IM               := fsConfig.emit_IM;
    Emit.cRegTrib         := fsConfig.emit_cRegTrib;
    Emit.cRegTribISSQN    := fsConfig.emit_cRegTribISSQN;
    Emit.indRatISSQN      := fsConfig.emit_indRatISSQN;
    infCFe.versaoDadosEnt := fsConfig.infCFe_versaoDadosEnt;
  end ;
end ;

function TACBrSAT.AssociarAssinatura(CNPJvalue, assinaturaCNPJs : AnsiString
  ) : String ;
begin
  fsComandoLog := 'AssociarAssinatura( '+CNPJvalue+', '+assinaturaCNPJs+' )';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.AssociarAssinatura( CNPJvalue, assinaturaCNPJs ) );
end ;

function TACBrSAT.AtivarSAT(subComando : Integer ; CNPJ : AnsiString ;
  cUF : Integer) : String ;
begin
  fsComandoLog := 'AtivarSAT( '+IntToStr(subComando)+', '+CNPJ+', '+IntToStr(cUF)+' )';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.AtivarSAT( subComando, CNPJ, cUF ) );
end ;

function TACBrSAT.AtualizarSoftwareSAT : String ;
begin
  fsComandoLog := 'AtualizarSoftwareSAT';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.AtualizarSoftwareSAT );
end ;

function TACBrSAT.BloquearSAT : String ;
begin
  fsComandoLog := 'BloquearSAT';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.BloquearSAT );
end ;

function TACBrSAT.CancelarUltimaVenda: String ;
var
  dadosCancelamento : string;
begin
  CFe2CFeCanc; // Atualiza para chave carregada para o cancelamento

  dadosCancelamento := CFeCanc.GerarXML( true ); // True = Gera apenas as TAGs da aplica��o

  Result := CancelarUltimaVenda( CFeCanc.infCFe.chCanc, dadosCancelamento);
end ;


function TACBrSAT.CancelarUltimaVenda(chave, dadosCancelamento : AnsiString
  ) : String ;
var
  XMLRecebido, NomeCFe: String;
begin
  fsComandoLog := 'CancelarUltimaVenda( '+chave+', '+dadosCancelamento+' )';

  if Trim(chave) = '' then
     raise EACBrSATErro.Create('Par�metro: "chave" n�o informado');

  if Trim(dadosCancelamento) = '' then
     raise EACBrSATErro.Create('Par�metro: "dadosCancelamento" n�o informado');

  if SalvarCFes then
  begin
    ForceDirectories( PastaCFeCancelamento );
    NomeCFe := PastaCFeCancelamento + PathDelim + chave + '-can-env.xml';
    ForceDirectories(ExtractFilePath(NomeCFe));
    WriteToTXT(NomeCFe, dadosCancelamento, False, False);
  end;

  IniciaComando;
  Result := FinalizaComando( fsSATClass.CancelarUltimaVenda(chave, dadosCancelamento) ) ;

(*
  // Workaround para SAT Kryptus, que usa o prefixo como: "Cfe" ao inves de "CFe"
  if (fsResposta.codigoDeRetorno = 7007) and (LeftStr(chave,3) = CPREFIXO_CFe) then
  begin
    fsPrefixoCFe      := 'Cfe';                      // Ajusta o Prefixo
    ChaveAntiga       := chave;
    chave             := fsPrefixoCFe + copy(chave,4,Length(chave));
    dadosCancelamento := StringReplace( dadosCancelamento, ChaveAntiga, chave, [rfReplaceAll] );
    CancelarUltimaVenda( chave, dadosCancelamento);  // Tenta novamente
    exit;                                            // cai fora por j� tratou na chamada acima
  end;
*)

  if fsResposta.codigoDeRetorno = 7000 then
  begin
     XMLRecebido := DecodeBase64(fsResposta.RetornoLst[6]);
     CFeCanc.AsXMLString := XMLRecebido;

     if SalvarCFes then
     begin
       NomeCFe := PastaCFeCancelamento + PathDelim + chave + '-can.xml';
       ForceDirectories(ExtractFilePath(NomeCFe));
       WriteToTXT(NomeCFe, XMLRecebido, False, False);
     end;
  end;
end ;

function TACBrSAT.ComunicarCertificadoICPBRASIL(certificado : AnsiString
  ) : String ;
begin
  fsComandoLog := 'ComunicarCertificadoICPBRASIL( '+certificado+' )';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.ComunicarCertificadoICPBRASIL( certificado ) );
end ;

function TACBrSAT.ConfigurarInterfaceDeRede(dadosConfiguracao : AnsiString
  ) : String ;
begin
  if dadosConfiguracao = '' then
    dadosConfiguracao := Rede.AsXMLString
  else
    Rede.AsXMLString := dadosConfiguracao;

  fsComandoLog := 'ConfigurarInterfaceDeRede( '+dadosConfiguracao+' )';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.ConfigurarInterfaceDeRede( dadosConfiguracao ) );
end ;

function TACBrSAT.ConsultarNumeroSessao(cNumeroDeSessao : Integer
  ) : String ;
begin
  fsComandoLog := 'ConsultarNumeroSessao( '+IntToStr(cNumeroDeSessao)+' )';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.ConsultarNumeroSessao( cNumeroDeSessao ) );
  DecodificaRetorno6000;
end ;

function TACBrSAT.ConsultarSAT : String ;
begin
  fsComandoLog := 'ConsultarSAT';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.ConsultarSAT );
end ;

function TACBrSAT.ConsultarStatusOperacional : String ;
Var
  ok: Boolean;
  I: Integer;
  AStr: String;
begin
  fsComandoLog := 'ConsultarStatusOperacional';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.ConsultarStatusOperacional ) ;
  ok := True;

  if fsResposta.codigoDeRetorno = 10000 then
  begin
    with fsRede do
    begin
      tipoLan := StrToTipoLan(ok, fsResposta.RetornoLst[06]) ;
      lanIP   := fsResposta.RetornoLst[07];
      lanMask := fsResposta.RetornoLst[09];
      lanGW   := fsResposta.RetornoLst[10];
      lanDNS1 := fsResposta.RetornoLst[11];
      lanDNS2 := fsResposta.RetornoLst[12];
    end;

    with fsStatus do
    begin
      Clear;
      NSERIE         := fsResposta.RetornoLst[05];
      LAN_MAC        := fsResposta.RetornoLst[08];
      STATUS_LAN     := StrToStatusLan(ok, fsResposta.RetornoLst[13]) ;;
      NIVEL_BATERIA  := StrToNivelBateria(ok, fsResposta.RetornoLst[14]) ;;
      MT_TOTAL       := fsResposta.RetornoLst[15];
      MT_USADA       := fsResposta.RetornoLst[16];
      DH_ATUAL       := StoD( fsResposta.RetornoLst[17] );
      VER_SB         := fsResposta.RetornoLst[18];
      VER_LAYOUT     := fsResposta.RetornoLst[19];
      ULTIMO_CFe     := fsResposta.RetornoLst[20];
      LISTA_INICIAL  := fsResposta.RetornoLst[21];

      { Workaround para leitura de Status do Emulador do Fiscl,
        que n�o retorna o campo: LISTA_FINAL }
      I := 22;
      if fsResposta.RetornoLst.Count > 27 then
      begin
        LISTA_FINAL    := fsResposta.RetornoLst[22];
        Inc(I);
      end;
      DH_CFe         := StoD( fsResposta.RetornoLst[I] );
      Inc(I);
      DH_ULTIMA      := StoD( fsResposta.RetornoLst[I] );
      Inc(I);
      CERT_EMISSAO   := StoD( fsResposta.RetornoLst[I] ) ;
      Inc(I);
      CERT_VENCIMENTO:= StoD( fsResposta.RetornoLst[I] ) ;
      Inc(I);
      AStr := fsResposta.RetornoLst[I];
      if StrIsNumber(AStr) then
        ESTADO_OPERACAO := TACBrSATEstadoOperacao( StrToInt(AStr) )
      else
        ESTADO_OPERACAO:= StrToEstadoOperacao(ok, AStr) ;;
    end;
  end;
end ;

function TACBrSAT.DesbloquearSAT : String ;
begin
  fsComandoLog := 'DesbloquearSAT';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.DesbloquearSAT );
end ;

function TACBrSAT.EnviarDadosVenda: String;
begin
  Result := EnviarDadosVenda( CFe.GerarXML( True ) );  // True = Gera apenas as TAGs da aplica��o
end;

function TACBrSAT.EnviarDadosVenda(dadosVenda : AnsiString) : String ;
var
  NomeCFe : String;
begin
  fsComandoLog := 'EnviarDadosVenda( '+dadosVenda+' )';
  if Trim(dadosVenda) = '' then
     raise EACBrSATErro.Create('Par�metro: "dadosVenda" n�o informado');

  IniciaComando;

  if SalvarCFes then
  begin
    ForceDirectories( PastaCFeVenda );
    NomeCFe := PastaCFeVenda + PathDelim +
               FormatDateTime('YYYYMMDDHHNNSS',Now) + '-' +
               IntToStrZero(numeroSessao, 6) + '-cfe-env.xml';
    ForceDirectories(ExtractFilePath(NomeCFe));
    WriteToTXT(NomeCFe, dadosVenda, False, False);
  end;

  Result := FinalizaComando( fsSATClass.EnviarDadosVenda( Trim(dadosVenda) ) );

  DecodificaRetorno6000;
end ;

procedure TACBrSAT.ExtrairLogs(NomeArquivo: String);
var
  SL: TStringList;
begin
  if NomeArquivo = '' then
    raise EACBrSATErro.Create('Nome para Arquivo de Log n�o especificado');

  SL := TStringList.Create;
  try
    SL.Clear;
    ExtrairLogs(SL);
    SL.SaveToFile(NomeArquivo)
  Finally
    SL.Free;
  end;
end ;

procedure TACBrSAT.ExtrairLogs(AStringList: TStrings);
var
  MS: TMemoryStream;
begin
  MS := TMemoryStream.Create;
  try
    MS.Clear;
    ExtrairLogs(MS);
    MS.Seek(0,soBeginning);
    AStringList.LoadFromStream(MS);
  Finally
    MS.Free;
  end;
end;

procedure TACBrSAT.ExtrairLogs(AStream: TStream);
var
  LogBin : AnsiString;
begin
  fsComandoLog := 'ExtrairLogs';
  IniciaComando;
  FinalizaComando( fsSATClass.ExtrairLogs );

  // TODO: Criar verifica��o para os retornos: 15002, e 11098 - SAT em processamento

  // Transformando retorno, de Base64 para ASCII
  if (Resposta.RetornoLst.Count > 5) and
     (Resposta.codigoDeRetorno = 15000) then  // 1500 = Transfer�ncia completa
  begin
    LogBin := DecodeBase64( Resposta.RetornoLst[5] );

    AStream.Size := 0;
    WriteStrToStream(AStream, LogBin);
  end;
end;

function TACBrSAT.TesteFimAFim(dadosVenda : AnsiString) : String ;
var
  XMLRecebido, NomeCFe : String;
begin
  fsComandoLog := 'TesteFimAFim(' +dadosVenda+' )';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.TesteFimAFim( dadosVenda ) );

  if fsResposta.codigoDeRetorno = 9000 then
  begin
     XMLRecebido := DecodeBase64(fsResposta.RetornoLst[5]);
     CFe.AsXMLString := XMLRecebido;

     if SalvarCFes then
     begin
       NomeCFe := PastaCFeVenda + PathDelim + CPREFIXO_CFe + CFe.infCFe.ID + '-teste.xml';
       ForceDirectories(ExtractFilePath(NomeCFe));
       WriteToTXT(NomeCFe, XMLRecebido, False, False);
     end;
  end;
end ;

function TACBrSAT.TrocarCodigoDeAtivacao(codigoDeAtivacaoOuEmergencia: AnsiString;
  opcao: Integer; novoCodigo: AnsiString): String;
begin
  fsComandoLog := 'TrocarCodigoDeAtivacao('+ codigoDeAtivacao+', '+IntToStr(opcao)+
                  ', '+novoCodigo+' )';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.TrocarCodigoDeAtivacao(
                                codigoDeAtivacaoOuEmergencia, opcao, novoCodigo ));
end ;

function TACBrSAT.GetAbout : String ;
begin
  Result := 'ACBrSAT Ver: '+CACBrSAT_Versao;
end ;

function TACBrSAT.GetcodigoDeAtivacao : AnsiString ;
var
  AcodigoDeAtivacao : AnsiString ;
begin
  AcodigoDeAtivacao := '';

  if Assigned( fsOnGetcodigoDeAtivacao ) then
     fsOnGetcodigoDeAtivacao( AcodigoDeAtivacao ) ;

  Result := AcodigoDeAtivacao;
end;

function TACBrSAT.GetModeloStrClass : String ;
begin
   Result := fsSATClass.ModeloStr;
end;

function TACBrSAT.GetsignAC : AnsiString ;
var
  AsignAC : AnsiString ;
begin
  AsignAC := '';

  if Assigned( fsOnGetsignAC ) then
     fsOnGetsignAC( AsignAC ) ;

  Result := AsignAC;
end;

procedure TACBrSAT.SetAbout(const Value : String) ;
begin
  {}
end ;

procedure TACBrSAT.SetInicializado(AValue : Boolean) ;
begin
  if AValue then
    Inicializar
  else
    DesInicializar ;
end ;

procedure TACBrSAT.SetModelo(AValue : TACBrSATModelo) ;
var
  wArqLOG : String ;
begin
  if fsModelo = AValue then exit ;

  if fsInicializado then
     raise EACBrSATErro.Create( cACBrSATSetModeloException );

  wArqLOG := ArqLOG ;

  FreeAndNil( fsSATClass ) ;

  { Instanciando uma nova classe de acordo com AValue }
  case AValue of
    satDinamico_cdecl : fsSATClass := TACBrSATDinamico_cdecl.Create( Self ) ;
    satDinamico_stdcall : fsSATClass := TACBrSATDinamico_stdcall.Create( Self ) ;
  else
    fsSATClass := TACBrSATClass.Create( Self ) ;
  end;

  { Passando propriedades da Classe anterior para a Nova Classe }
  ArqLOG := wArqLOG ;

  fsModelo := AValue;
end ;

procedure TACBrSAT.SetNomeDLL(AValue : string) ;
var
  FileName: String;
begin
  if fsNomeDLL = AValue then Exit ;
  fsNomeDLL := Trim(AValue) ;

  FileName := ExtractFileName( fsNomeDLL );
  if FileName = '' then
    fsNomeDLL := PathWithDelim( fsNomeDLL ) + cLIBSAT;
end ;

function TACBrSAT.GetPastaCFeCancelamento: String;
begin
  if fsPastaCFeCancelamento = '' then
     if not (csDesigning in Self.ComponentState) then
        fsPastaCFeCancelamento := ExtractFilePath( ParamStr(0) ) + 'CFesCancelados' ;

  Result := fsPastaCFeCancelamento ;
end;

function TACBrSAT.GetPastaCFeVenda: String;
begin
  if fsPastaCFeVenda = '' then
     if not (csDesigning in Self.ComponentState) then
        fsPastaCFeVenda := ExtractFilePath( ParamStr(0) ) + 'CFesEnviados' ;

  Result := fsPastaCFeVenda ;
end;

procedure TACBrSAT.SetPastaCFeCancelamento(AValue: String);
begin
  fsPastaCFeCancelamento := PathWithoutDelim( AValue );
end;

procedure TACBrSAT.SetPastaCFeVenda(AValue: String);
begin
  fsPastaCFeVenda := PathWithoutDelim( AValue );
end;

procedure TACBrSAT.SetExtrato(const Value: TACBrSATExtratoClass);
Var
  OldValue: TACBrSATExtratoClass ;
begin
  if Value <> fsExtrato then
  begin
     if Assigned(fsExtrato) then
        fsExtrato.RemoveFreeNotification(Self);

     OldValue  := fsExtrato ;   // Usa outra variavel para evitar Loop Infinito
     fsExtrato := Value;    // na remo��o da associa��o dos componentes

     if Assigned(OldValue) then
        if Assigned(OldValue.ACBrSAT) then
           OldValue.ACBrSAT := nil ;

     if Value <> nil then
     begin
        Value.FreeNotification(self);
        Value.ACBrSAT := self ;
     end ;
  end ;
end;

procedure TACBrSAT.Notification(AComponent : TComponent ; Operation : TOperation
  ) ;
begin
  inherited Notification(AComponent, Operation) ;

  if (Operation = opRemove) and (fsExtrato <> nil) and (AComponent is TACBrSATExtratoClass) then
     fsExtrato := nil ;
end ;

procedure TACBrSAT.DecodificaRetorno6000;
var
  XMLRecebido: String;
  NomeCFe: String;
begin
  if fsResposta.codigoDeRetorno <> 6000 then exit;

  XMLRecebido := DecodeBase64(fsResposta.RetornoLst[6]);
  CFe.AsXMLString := XMLRecebido;

  if SalvarCFes then
  begin
    NomeCFe := PastaCFeVenda + PathDelim + CPREFIXO_CFe + CFe.infCFe.ID + '.xml';
    ForceDirectories(ExtractFilePath(NomeCFe));
    WriteToTXT(NomeCFe, XMLRecebido, False, False);
  end;
end;

procedure TACBrSAT.CFe2CFeCanc;
begin
  CFeCanc.Clear;
  CFeCanc.infCFe.chCanc   := fsPrefixoCFe + CFe.infCFe.ID;
  CFeCanc.infCFe.dEmi     := CFe.ide.dEmi;
  CFeCanc.infCFe.hEmi     := CFe.ide.hEmi;
  CFeCanc.ide.CNPJ        := CFe.ide.CNPJ;
  CFeCanc.ide.signAC      := CFe.ide.signAC;
  CFeCanc.ide.numeroCaixa := CFe.ide.numeroCaixa;
  CFeCanc.Dest.CNPJCPF    := CFe.Dest.CNPJCPF;
end;

procedure TACBrSAT.ImprimirExtrato;
begin
  VerificaCondicoesImpressao;
  Extrato.ImprimirExtrato;
end;

procedure TACBrSAT.ImprimirExtratoResumido;
begin
  VerificaCondicoesImpressao;
  Extrato.ImprimirExtratoResumido;
end;

procedure TACBrSAT.ImprimirExtratoCancelamento;
begin
  VerificaCondicoesImpressao( True );
  Extrato.ImprimirExtratoCancelamento;
end;

function TACBrSAT.CodificarPaginaDeCodigoSAT(ATexto: String): AnsiString;
begin
  if fsConfig.PaginaDeCodigo > 0 then
     Result := TranslateString( ACBrStrToAnsi( ATexto ), fsConfig.PaginaDeCodigo )
  else
     Result := TiraAcentos( ATexto );
end ;

function TACBrSAT.DecodificarPaginaDeCodigoSAT(ATexto : AnsiString
   ) : String ;
begin
  if fsConfig.PaginaDeCodigo > 0 then
     Result := ACBrStr( TranslateString( ATexto, 0, fsConfig.PaginaDeCodigo ) )
  else
     Result := ACBrStr( ATexto ) ;
end ;

end.

