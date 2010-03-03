{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
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
|* 21/11/2009: Daniel Simoes de Almeida
|*  - Primeira Versao: Cria�ao e Distribui�ao da Primeira Versao
******************************************************************************}

{$I ACBr.inc}

unit ACBrTEFDCliSiTef;

interface

uses
  Classes, SysUtils, ACBrTEFDClass, contnrs
  {$IFDEF VisualCLX}
     ,QControls
  {$ELSE}
     ,Controls
  {$ENDIF}  ;


Const
   CACBrTEFD_CliSiTef_Backup = 'ACBr_CliSiTef_Backup.tef' ;

{$IFDEF LINUX}
  CACBrTEFD_CliSiTef_Lib = 'libclisitef.so' ;
{$ELSE}
  CACBrTEFD_CliSiTef_Lib = 'CliSiTef32I.dll' ;
{$ENDIF}

type
  { TACBrTEFDRespCliSiTef }

  TACBrTEFDRespCliSiTef = class( TACBrTEFDResp )
  protected
    function GetTransacaoAprovada : Boolean; override;
  public
    procedure ConteudoToProperty; override;
    procedure GravaInformacao( const Identificacao : Integer;
      const Informacao : AnsiString );
  end;

  TACBrTEFDCliSiTefExibeMenu = procedure( Titulo : String; Opcoes : TStringList;
    var ItemSlecionado : Integer ) of object ;

  TACBrTEFDCliSiTefOperacaoCampo = (tcString, tcDouble, tcCMC7, tcBarCode) ;

  TACBrTEFDCliSiTefObtemCampo = procedure( Titulo : String;
    TamanhoMinimo, TamanhoMaximo : Integer ;
    TipoCampo : Integer; Operacao : TACBrTEFDCliSiTefOperacaoCampo;
    var Resposta : String; var Digitado : Boolean ) of object ;

  { TACBrTEFDCliSiTef }

   TACBrTEFDCliSiTef = class( TACBrTEFDClass )
   private
      fCodigoLoja : String;
      fEnderecoIP : String;
      fNumeroTerminal : String;
      fOnExibeMenu : TACBrTEFDCliSiTefExibeMenu;
      fOnObtemCampo : TACBrTEFDCliSiTefObtemCampo;
      fOperacaoADM : Integer;
      fOperacaoATV : Integer;
      fOperacaoCHQ : Integer;
      fOperacaoCNC : Integer;
      fOperacaoCRT : Integer;
      fOperacaoReImpressao: Integer;
      fOperador : String;
      fParametrosAdicionais : TStringList;
      fRespostas: TStringList;
      fRestricoes : String;
      fDocumentosProcessados : String ;

     xConfiguraIntSiTefInterativoEx : function (
                pEnderecoIP: PChar;
                pCodigoLoja: PChar;
                pNumeroTerminal: PChar;
                ConfiguraResultado: smallint;
                pParametrosAdicionais: PChar): integer;
               {$IFDEF LINUX} cdecl {$ELSE} stdcall {$ENDIF} ;

     xIniciaFuncaoSiTefInterativo : function (
                Modalidade: integer;
                pValor: PChar;
                pNumeroCuponFiscal: PChar;
                pDataFiscal: PChar;
                pHorario: PChar;
                pOperador: PChar;
                pRestricoes: PChar ): integer;
                {$IFDEF LINUX} cdecl {$ELSE} stdcall {$ENDIF} ;


     xFinalizaTransacaoSiTefInterativo : procedure (
                 smallint: Word;
                 pNumeroCuponFiscal: PChar;
                 pDataFiscal: PChar;
                 pHorario: PChar );
                 {$IFDEF LINUX} cdecl {$ELSE} stdcall {$ENDIF} ;


     xContinuaFuncaoSiTefInterativo : function (
                var ProximoComando: Integer;
                var TipoCampo: Integer;
                var TamanhoMinimo: smallint;
                var TamanhoMaximo: smallint;
                pBuffer: PChar;
                TamMaxBuffer: Integer;
                ContinuaNavegacao: Integer ): integer;
                {$IFDEF LINUX} cdecl {$ELSE} stdcall {$ENDIF} ;

     procedure AvaliaErro(Sts : Integer);
     procedure FinalizarTransacao( Confirma : Boolean;
        DocumentoVinculado : String);
     procedure LoadDLLFunctions;
   protected
     procedure SetNumVias(const AValue : Integer); override;

     Function FazerRequisicao( Funcao : Integer; AHeader : String = '';
        Valor : Double = 0; Documento : AnsiString = '';
        ListaRestricoes : AnsiString = '') : Integer ;
     Function ContinuarRequisicao( ImprimirComprovantes : Boolean ) : Integer ;

     procedure ProcessarRespostaPagamento( const IndiceFPG : String;
        const Valor : Double);

   public
     property Respostas : TStringList read fRespostas ;

     constructor Create( AOwner : TComponent ) ; override;
     destructor Destroy ; override;

     procedure Inicializar ; override;

     procedure AtivarGP ; override;
     procedure VerificaAtivo ; override;

     procedure ConfirmarEReimprimirTransacoesPendentes ;

     Procedure ATV ; override;
     Function ADM : Boolean ; override;
     Function CRT( Valor : Double; IndiceFPG_ECF : String;
        DocumentoVinculado : String = ''; Moeda : Integer = 0 ) : Boolean; override;
     Function CHQ( Valor : Double; IndiceFPG_ECF : String;
        DocumentoVinculado : String = ''; CMC7 : String = '';
        TipoPessoa : AnsiChar = 'F'; DocumentoPessoa : String = '';
        DataCheque : TDateTime = 0; Banco   : String = '';
        Agencia    : String = ''; AgenciaDC : String = '';
        Conta      : String = ''; ContaDC   : String = '';
        Cheque     : String = ''; ChequeDC  : String = '';
        Compensacao: String = '' ) : Boolean ; override;
     Procedure NCN(Rede, NSU, Finalizacao : String;
        Valor : Double = 0; DocumentoVinculado : String = ''); override;
     Procedure CNF(Rede, NSU, Finalizacao : String;
        DocumentoVinculado : String = ''); override;
     Function CNC(Rede, NSU : String; DataHoraTransacao : TDateTime;
        Valor : Double) : Boolean; overload; override;

   published
     property EnderecoIP     : String read fEnderecoIP     write fEnderecoIP ;
     property CodigoLoja     : String read fCodigoLoja     write fCodigoLoja ;
     property NumeroTerminal : String read fNumeroTerminal write fNumeroTerminal ;
     property Operador       : String read fOperador       write fOperador ;
     property ParametrosAdicionais : TStringList read fParametrosAdicionais ;
     property Restricoes : String read fRestricoes write fRestricoes ;
     property OperacaoATV : Integer read fOperacaoATV write fOperacaoATV
        default 111 ;
     property OperacaoADM : Integer read fOperacaoADM write fOperacaoADM
        default 110 ;
     property OperacaoCRT : Integer read fOperacaoCRT write fOperacaoCRT
        default 0 ;
     property OperacaoCHQ : Integer read fOperacaoCHQ write fOperacaoCHQ
        default 1 ;
     property OperacaoCNC : Integer read fOperacaoCNC write fOperacaoCNC
        default 200 ;
     property OperacaoReImpressao : Integer read fOperacaoReImpressao
        write fOperacaoReImpressao default 112 ;

     property OnExibeMenu : TACBrTEFDCliSiTefExibeMenu read fOnExibeMenu
        write fOnExibeMenu ;
     property OnObtemCampo : TACBrTEFDCliSiTefObtemCampo read fOnObtemCampo
        write fOnObtemCampo ;
   end;

implementation

Uses ACBrUtil, dateutils, StrUtils, ACBrTEFD, Dialogs, Math;

{ TACBrTEFDRespCliSiTef }

function TACBrTEFDRespCliSiTef.GetTransacaoAprovada : Boolean;
begin
   Result := True ;
end;

procedure TACBrTEFDRespCliSiTef.ConteudoToProperty;
var
   Linha : TACBrTEFDLinha ;
   I     : Integer;
   Parc  : TACBrTEFDRespParcela;
   LinStr: AnsiString ;
begin
// Conteudo.Conteudo.SaveToFile('c:\temp\conteudo.txt') ;

   fpValorTotal := 0 ;
   fpImagemComprovante1aVia.Clear;
   fpImagemComprovante2aVia.Clear;

   for I := 0 to Conteudo.Count - 1 do
   begin
     Linha := Conteudo.Linha[I];

     LinStr := StringToBinaryString( Linha.Informacao.AsString );

     case Linha.Identificacao of
       // TODO: Mapear mais propriedades do CliSiTef //
       105 :
         begin
           fpDataHoraTransacaoComprovante  := Linha.Informacao.AsTimeStampSQL;
           fpDataHoraTransacaoHost         := fpDataHoraTransacaoComprovante ;
         end;
       121 : fpImagemComprovante1aVia.Text := StringReplace( LinStr, #10, sLineBreak, [rfReplaceAll] );
       122 : fpImagemComprovante2aVia.Text := StringReplace( LinStr, #10, sLineBreak, [rfReplaceAll] );
       130 : fpValorTotal                  := fpValorTotal + Linha.Informacao.AsFloat ;
       133 : fpCodigoAutorizacaoTransacao  := Linha.Informacao.AsInteger;
       134 : fpNSU                         := LinStr;
       156 : fpRede                        := LinStr;
       501 : fpTipoPessoa                  := AnsiChar(IfThen(Linha.Informacao.AsInteger = 0,'J','F')[1]);
       502 : fpDocumentoPessoa             := LinStr ;
       505 : fpQtdParcelas                 := Linha.Informacao.AsInteger ;
       //incluido por Evandro
       627 : fpAgencia                     := LinStr;
       628 : fpAgenciaDC                   := LinStr;
       120 : fpAutenticacao                := LinStr;
       626 : fpBanco                       := LinStr;
       613 :
        begin
          fpCheque                         := copy(LinStr, 21, 6);
          fpCMC7                           := LinStr;
        end;
       629 : fpConta                       := LinStr;
       630 : fpContaDC                     := LinStr;
       527 : fpDataPreDatado               := Linha.Informacao.AsDate ;
       //

       899 :  // Tipos de Uso Interno do ACBrTEFD
        begin
          case Linha.Sequencia of
              1 : fpCNFEnviado         := (UpperCase( Linha.Informacao.AsString ) = 'S' );
              2 : fpIndiceFPG_ECF      := Linha.Informacao.AsString ;
              3 : fpOrdemPagamento     := Linha.Informacao.AsInteger ;
            100 : fpHeader             := LinStr;
            101 : fpID                 := Linha.Informacao.AsInteger;
            102 : fpDocumentoVinculado := LinStr;
            103 : fpValorTotal         := fpValorTotal + Linha.Informacao.AsFloat;
          end;
        end;
     end;
   end ;

   fpParcelas.Clear;
   for I := 1 to fpQtdParcelas do
   begin
      Parc := TACBrTEFDRespParcela.create;
      Parc.Vencimento := LeInformacao( 141, I).AsDate ;
      Parc.Valor      := LeInformacao( 142, I).AsFloat ;

      fpParcelas.Add(Parc);
   end;
end;

procedure TACBrTEFDRespCliSiTef.GravaInformacao(const Identificacao : Integer;
   const Informacao : AnsiString);
Var
  Sequencia : Integer ;
begin
  Sequencia := 0 ;

  if (Identificacao in [141,142]) then  // 141 - Data Parcela, 142 - Valor Parcela
  begin
    Sequencia := 1 ;
    while LeInformacao(Identificacao, Sequencia).AsString <> '' do
       Inc( Sequencia ) ;
  end;

  fpConteudo.GravaInformacao( Identificacao, Sequencia,
                              BinaryStringToString(Informacao) ); // Converte #10 para "\x0A"
end;


{ TACBrTEFDClass }

constructor TACBrTEFDCliSiTef.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  ArqReq    := '' ;
  ArqResp   := '' ;
  ArqSTS    := '' ;
  ArqTemp   := '' ;
  GPExeName := '' ;
  fpTipo    := gpCliSiTef;
  Name      := 'CliSiTef' ;

  fEnderecoIP     := '' ;
  fCodigoLoja     := '' ;
  fNumeroTerminal := '' ;
  fOperador       := '' ;
  fRestricoes     := '' ;

  fOperacaoATV         := 111 ; // 111 - Teste de comunica��o com o SiTef
  fOperacaoReImpressao := 112 ; // 112 - Menu Re-impress�o
  fOperacaoADM         := 110 ; // 110 - Abre o leque das transa��es Gerenciais
  fOperacaoCRT         := 0 ;   // A CliSiTef permite que o operador escolha a forma
                                // de pagamento atrav�s de menus
  fOperacaoCHQ         := 1 ;   // Cheque
  fOperacaoCNC         := 200 ; // 200 Cancelamento Normal: Inicia a coleta dos dados
                                // no ponto necess�rio para fazer o cancelamento de uma
                                // transa��o de d�bito ou cr�dito, sem ser necess�rio
                                // passar antes pelo menu de transa��es administrativas
  fDocumentosProcessados := '' ;

  fParametrosAdicionais := TStringList.Create;
  fRespostas            := TStringList.Create;

  xConfiguraIntSiTefInterativoEx    := nil ;
  xIniciaFuncaoSiTefInterativo      := nil ;
  xContinuaFuncaoSiTefInterativo    := nil ;
  xFinalizaTransacaoSiTefInterativo := nil ;

  fOnExibeMenu  := nil ;
  fOnObtemCampo := nil ;

  if Assigned( fpResp ) then
     fpResp.Free ;

  fpResp := TACBrTEFDRespCliSiTef.Create;
  fpResp.TipoGP := Tipo;
end;

destructor TACBrTEFDCliSiTef.Destroy;
begin
   fParametrosAdicionais.Free ;
   fRespostas.Free ;

   inherited Destroy;
end;

procedure TACBrTEFDCliSiTef.LoadDLLFunctions ;
 procedure CliSiTefFunctionDetect( FuncName: String; var LibPointer: Pointer ) ;
 begin
   if not Assigned( LibPointer )  then
   begin
     if not FunctionDetect( CACBrTEFD_CliSiTef_Lib, FuncName, LibPointer) then
     begin
        LibPointer := NIL ;
        raise Exception.Create( ACBrStr( 'Erro ao carregar a fun��o:'+FuncName+
                                         ' de: '+CACBrTEFD_CliSiTef_Lib ) ) ;
     end ;
   end ;
 end ;
begin
   CliSiTefFunctionDetect('ConfiguraIntSiTefInterativoEx', @xConfiguraIntSiTefInterativoEx);
   CliSiTefFunctionDetect('IniciaFuncaoSiTefInterativo', @xIniciaFuncaoSiTefInterativo);
   CliSiTefFunctionDetect('ContinuaFuncaoSiTefInterativo', @xContinuaFuncaoSiTefInterativo);
   CliSiTefFunctionDetect('FinalizaTransacaoSiTefInterativo', @xFinalizaTransacaoSiTefInterativo);
end ;

procedure TACBrTEFDCliSiTef.SetNumVias(const AValue : Integer);
begin
   fpNumVias := 2;
end;

procedure TACBrTEFDCliSiTef.Inicializar;
Var
  Sts : Integer ;
  ParamAdic : String ;
  Erro : String;
  Est  : AnsiChar;
begin
  if Inicializado then exit ;

  if not Assigned( OnExibeMenu ) then
     raise Exception.Create( ACBrStr('Evento "OnExibeMenu" n�o programado' ) ) ;

  if not Assigned( OnObtemCampo ) then
     raise Exception.Create( ACBrStr('Evento "OnObtemCampo" n�o programado' ) ) ;

  LoadDLLFunctions;

  ParamAdic := StringReplace( ParametrosAdicionais.Text, sLineBreak, ';',
                              [rfReplaceAll] ) ;

  Sts := xConfiguraIntSiTefInterativoEx( PChar(fEnderecoIP),
                                         PChar(fCodigoLoja),
                                         PChar(fNumeroTerminal),
                                         0,
                                         PChar(ParamAdic) );
  Erro := '' ;
  Case Sts of
    1 :	Erro := 'Endere�o IP inv�lido ou n�o resolvido' ;
    2 : Erro := 'C�digo da loja inv�lido' ;
    3 : Erro := 'C�digo de terminal invalido' ;
    6 : Erro := 'Erro na inicializa��o do Tcp/Ip' ;
    7 : Erro := 'Falta de mem�ria' ;
    8 : Erro := 'N�o encontrou a CliSiTef ou ela est� com problemas' ;
   10 : Erro := 'O PinPad n�o est� devidamente configurado no arquivo CliSiTef.ini' ;
  end;

  if Erro <> '' then
     raise EACBrTEFDErro.Create( ACBrStr( Erro ) ) ;

  fpInicializado := True ;
  GravaLog( Name +' Inicializado CliSiTEF' );

  Est := TACBrTEFD(Owner).EstadoECF;

  if (Est in ['V','P']) then                    // Cupom Ficou aberto ?? //
     CancelarTransacoesPendentesClass           // SIM, Cancele tudo... //
  else
     ConfirmarEReimprimirTransacoesPendentes ;  // NAO, Cupom Fechado, basta re-imprimir //
end;

procedure TACBrTEFDCliSiTef.AtivarGP;
begin
   raise Exception.Create( ACBrStr( 'CliSiTef n�o pode ser ativado localmente' )) ;
end;

procedure TACBrTEFDCliSiTef.VerificaAtivo;
begin
   {Nada a Fazer}
end;

procedure TACBrTEFDCliSiTef.ConfirmarEReimprimirTransacoesPendentes;
Var
  ArquivosVerficar : TStringList ;
  I, Sts           : Integer;
  ArqMask          : String;
begin
  ArquivosVerficar := TStringList.Create;

  try
     ArquivosVerficar.Clear;

     { Achando Arquivos de Backup deste GP }
     ArqMask := TACBrTEFD(Owner).PathBackup + PathDelim + 'ACBr_' + Self.Name + '_*.tef' ;
     FindFiles( ArqMask, ArquivosVerficar, True );

     { Enviando NCN ou CNC para todos os arquivos encontrados }
     while ArquivosVerficar.Count > 0 do
     begin
        if not FileExists( ArquivosVerficar[ 0 ] ) then
        begin
           ArquivosVerficar.Delete( 0 );
           Continue;
        end;

        Resp.LeArquivo( ArquivosVerficar[ 0 ] );

        try
           if pos(Resp.DocumentoVinculado, fDocumentosProcessados) = 0 then
           begin
              CNF;

              if TACBrTEFD(Owner).DoExibeMsg( opmYesNo,
                                      'Transa��o TEF efetuada.'+sLineBreak+
                                      'Re-Imprimir Ultimo Cupom ?' ) = mrYes then
              begin
                 Sts := FazerRequisicao( fOperacaoReImpressao, 'ADM' ) ;

                 if Sts = 10000 then
                    Sts := ContinuarRequisicao( True ) ;  { True = Imprimir Comprovantes agora }

                 if not ( Sts = 0 ) then
                    AvaliaErro( Sts );
              end;
           end;

           DeleteFile( ArquivosVerficar[ 0 ] );
           ArquivosVerficar.Delete( 0 );
        except
        end;
     end;
  finally
     ArquivosVerficar.Free;
  end;
end;

Procedure TACBrTEFDCliSiTef.ATV ;
var
   Sts : Integer;
begin
  Sts := FazerRequisicao( fOperacaoATV, 'ATV' ) ;

  if Sts = 10000 then
     Sts := ContinuarRequisicao( True ) ;  { True = Imprimir Comprovantes agora }

  if ( Sts <> 0 ) then
     AvaliaErro( Sts );
end;

Function TACBrTEFDCliSiTef.ADM : Boolean;
var
   Sts : Integer;
begin
  Sts := FazerRequisicao( fOperacaoADM, 'ADM' ) ;

  if Sts = 10000 then
     Sts := ContinuarRequisicao( True ) ;  { True = Imprimir Comprovantes agora }

  Result := ( Sts = 0 ) ;

  if not Result then
     AvaliaErro( Sts );
end;

Function TACBrTEFDCliSiTef.CRT( Valor : Double; IndiceFPG_ECF : String;
   DocumentoVinculado : String = ''; Moeda : Integer = 0 ) : Boolean;
var
  Sts : Integer;
  Restr : String ;
begin
  VerificarTransacaoPagamento( Valor );

  Restr := fRestricoes;
  if Restr = '' then
     Restr := '[10]' ;     // 10 - Cheques

  Sts := FazerRequisicao( fOperacaoCRT, 'CRT', Valor, DocumentoVinculado, Restr ) ;

  if Sts = 10000 then
     Sts := ContinuarRequisicao( False ) ;  { False = NAO Imprimir Comprovantes agora }

  Result := ( Sts = 0 ) ;

  if not Result then
     AvaliaErro( Sts )
  else
     ProcessarRespostaPagamento( IndiceFPG_ECF, Valor );
end;

Function TACBrTEFDCliSiTef.CHQ(Valor : Double; IndiceFPG_ECF : String;
   DocumentoVinculado : String; CMC7 : String; TipoPessoa : AnsiChar;
   DocumentoPessoa : String; DataCheque : TDateTime; Banco : String;
   Agencia : String; AgenciaDC : String; Conta : String; ContaDC : String;
   Cheque : String; ChequeDC : String; Compensacao: String) : Boolean ;
var
  Sts : Integer;
  Restr : String ;

  Function FormataCampo( Campo : String; Tamanho : Integer ) : String ;
  begin
    Result := padR( OnlyNumber( Trim( Campo ) ), Tamanho, '0') ;
  end ;

begin
  VerificarTransacaoPagamento( Valor );

  Respostas.Values['501'] := ifthen(TipoPessoa = 'J','1','0');

  if DocumentoPessoa <> '' then
     Respostas.Values['502'] := OnlyNumber(Trim(DocumentoPessoa));

  if DataCheque <> 0  then
     Respostas.Values['506'] := FormatDateTime('DDMMYYYY',DataCheque) ;

  if CMC7 <> '' then
     Respostas.Values['517'] := '1:'+CMC7
  else
     Respostas.Values['517'] := '0:'+FormataCampo(Compensacao,3)+
                                     FormataCampo(Banco,3)+
                                     FormataCampo(Agencia,4)+
                                     FormataCampo(AgenciaDC,1)+
                                     FormataCampo(Conta,10)+
                                     FormataCampo(ContaDC,1)+
                                     FormataCampo(Cheque,6)+
                                     FormataCampo(ChequeDC,1) ;

  Restr := fRestricoes;
  if Restr = '' then
     Restr := '[15;25]' ;  // 15 - Cart�o Credito; 25 - Cartao Debito

  Sts := FazerRequisicao( fOperacaoCHQ, 'CHQ', Valor, DocumentoVinculado, Restr ) ;

  if Sts = 10000 then
     Sts := ContinuarRequisicao( False ) ;  { False = NAO Imprimir Comprovantes agora }

  Result := ( Sts = 0 ) ;

  if not Result then
     AvaliaErro( Sts )
  else
     ProcessarRespostaPagamento( IndiceFPG_ECF, Valor );
end;

Procedure TACBrTEFDCliSiTef.CNF(Rede, NSU, Finalizacao : String;
   DocumentoVinculado : String) ;
Var
   DataStr, HoraStr : String;
begin
  // CliSiTEF n�o usa Rede, NSU e Finalizacao

  FinalizarTransacao( True, DocumentoVinculado );
end;

Function TACBrTEFDCliSiTef.CNC(Rede, NSU : String;
   DataHoraTransacao : TDateTime; Valor : Double) : Boolean;
var
   Sts : Integer;
begin
  Sts := FazerRequisicao( fOperacaoCNC, 'CNC' ) ;

  if Sts = 10000 then
     Sts := ContinuarRequisicao( True ) ;  { True = Imprimir Comprovantes agora }

  Result := ( Sts = 0 ) ;

  if not Result then
     AvaliaErro( Sts );
end;

Procedure TACBrTEFDCliSiTef.NCN(Rede, NSU, Finalizacao : String;
   Valor : Double; DocumentoVinculado : String) ;
begin
  // CliSiTEF n�o usa Rede, NSU, Finalizacao e Valor

  FinalizarTransacao( False, DocumentoVinculado );
end;

Function TACBrTEFDCliSiTef.FazerRequisicao( Funcao : Integer;
   AHeader : String = ''; Valor : Double = 0; Documento : AnsiString = '';
   ListaRestricoes : AnsiString = '') : Integer ;
Var
  ValorStr, DataStr, HoraStr : String;
  ANow : TDateTime ;
begin
   if fpAguardandoResposta then
      raise Exception.Create( ACBrStr( 'Requisi��o anterior n�o concluida' ) ) ;

   Result   := 0 ;
   ANow     := Now ;
   DataStr  := FormatDateTime('YYYYMMDD', ANow );
   HoraStr  := FormatDateTime('HHNNSS', ANow );
   ValorStr := StringReplace( FormatFloat( '0.00', Valor ),
                              DecimalSeparator, ',', [rfReplaceAll]) ;
   fDocumentosProcessados := '' ;

   GravaLog( '*** IniciaFuncaoSiTefInterativo. Modalidade: '+IntToStr(Funcao)+
                                             ' Valor: '     +ValorStr+
                                             ' Documento: ' +Documento+
                                             ' Data: '      +DataStr+
                                             ' Hora: '      +HoraStr+
                                             ' Operador: '  +fOperador+
                                             ' Restricoes: '+ListaRestricoes ) ;

   Result := xIniciaFuncaoSiTefInterativo( Funcao,
                                           PChar( ValorStr ),
                                           PChar( Documento ),
                                           PChar( DataStr ), PChar( HoraStr ),
                                           PChar( fOperador ),
                                           PChar( ListaRestricoes ) ) ;

   { Adiciona Campos j� conhecidos em Resp, para processa-los em
     m�todos que manipulam "RespostasPendentes" (usa c�digos do G.P.)  }
   Resp.Clear;

   with TACBrTEFDRespCliSiTef( Resp ) do
   begin
     fpIDSeq := fpIDSeq + 1 ;
     if Documento = '' then
        Documento := IntToStr(fpIDSeq) ;

     Conteudo.GravaInformacao(899,100, AHeader ) ;
     Conteudo.GravaInformacao(899,101, IntToStr(fpIDSeq) ) ;
     Conteudo.GravaInformacao(899,102, Documento ) ;
     Conteudo.GravaInformacao(899,103, IntToStr(Trunc(SimpleRoundTo( Valor * 100 ,0))) );

     Resp.TipoGP := fpTipo;
   end;
end;

Function TACBrTEFDCliSiTef.ContinuarRequisicao( ImprimirComprovantes : Boolean )
  : Integer;
var
  ProximoComando, TipoCampo, Continua, ItemSelecionado, I: Integer;
  TamanhoMinimo, TamanhoMaximo : SmallInt ;
  Buffer: array [0..20000] of char;
  Mensagem, MensagemOperador, MensagemCliente, Resposta, CaptionMenu,
     ArqBackUp : String;
  SL : TStringList ;
  Interromper, Digitado, GerencialAberto, FechaGerencialAberto, ImpressaoOk,
     HouveImpressao : Boolean ;
  Est : AnsiChar;
begin
   Result           := 0;
   ProximoComando   := 0;
   TipoCampo        := 0;
   TamanhoMinimo    := 0;
   TamanhoMaximo    := 0;
   Continua         := 0;
   Mensagem         := '' ;
   MensagemOperador := '' ;
   MensagemCliente  := '' ;
   CaptionMenu      := '' ;
   GerencialAberto  := False ;
   fpAguardandoResposta := True ;
   ImpressaoOk      := True ;
   HouveImpressao   := False ;
   FechaGerencialAberto := True ;
   ArqBackUp        := '' ;

   with TACBrTEFD(Owner) do
   begin
      try
         repeat
            if not TecladoBloqueado then
               BloquearMouseTeclado( True );

            GravaLog( 'ContinuaFuncaoSiTefInterativo, Chamando: Contina = '+
                      IntToStr(Continua)+' Buffer = '+Resposta ) ;

            Result := xContinuaFuncaoSiTefInterativo( ProximoComando,
                                                      TipoCampo,
                                                      TamanhoMinimo, TamanhoMaximo,
                                                      Buffer, sizeof(Buffer),
                                                      Continua );

            Mensagem := Trim( Buffer ) ;
            Resposta := '' ;

            GravaLog( 'ContinuaFuncaoSiTefInterativo, Retornos: STS = '+IntToStr(Result)+
                      ' ProximoComando = '+IntToStr(ProximoComando)+
                      ' TipoCampo = '+IntToStr(TipoCampo)+
                      ' Buffer = '+Mensagem +
                      ' Tam.Min = '+IntToStr(TamanhoMinimo) +
                      ' Tam.Max = '+IntToStr(TamanhoMaximo)) ;

            if Result = 10000 then
            begin
              if TipoCampo > 0 then
                 Resposta := fRespostas.Values[IntToStr(TipoCampo)];

              case ProximoComando of
                 0 :
                   begin
                     TACBrTEFDRespCliSiTef( Self.Resp ).GravaInformacao( TipoCampo, Mensagem ) ;

                     case TipoCampo of
                        121, 122 :
                          if ImprimirComprovantes then
                          begin
                             { Impress�o de Gerencial, deve ser Sob demanda }
                             if not HouveImpressao then
                             begin
                                HouveImpressao := True ;
                                ArqBackUp      := CopiarResposta;
                             end;

                             SL := TStringList.Create;
                             ImpressaoOk := False ;
                             I := TipoCampo ;
                             try
                                while not ImpressaoOk do
                                begin
                                  try
                                    while I <= TipoCampo do
                                    begin
                                       if FechaGerencialAberto then
                                       begin
                                         Est := EstadoECF;

                                         { Fecha Vinculado ou Gerencial ou Cupom, se ficou algum aberto por Desligamento }
                                         case Est of
                                           'C'      : ComandarECF( opeFechaVinculado );
                                           'G', 'R' : ComandarECF( opeFechaGerencial );
                                           'V', 'P' : ComandarECF( opeCancelaCupom );
                                         end;

                                         GerencialAberto      := False ;
                                         FechaGerencialAberto := False ;

                                         if EstadoECF <> 'L' then
                                           raise EACBrTEFDECF.Create( ACBrStr('ECF n�o est� LIVRE') ) ;
                                       end;

                                       Mensagem := Self.Resp.LeInformacao(I).AsString ;
                                       Mensagem := StringToBinaryString( Mensagem ) ;
                                       if Mensagem <> '' then
                                       begin
                                          SL.Text  := StringReplace( Mensagem, #10, sLineBreak, [rfReplaceAll] ) ;

                                          if not GerencialAberto then
                                           begin
                                             ComandarECF( opeAbreGerencial ) ;
                                             GerencialAberto := True ;
                                           end
                                          else
                                           begin
                                             ComandarECF( opePulaLinhas ) ;
                                             DoExibeMsg( opmDestaqueVia, 'Destaque a 1� Via') ;
                                           end;

                                          ECFImprimeVia( trGerencial, I-120, SL );

                                          ImpressaoOk := True ;
                                       end;

                                       Inc( I ) ;
                                    end;

                                    if (TipoCampo = 122) and GerencialAberto then
                                       ComandarECF( opeFechaGerencial );
                                  except
                                    on EACBrTEFDECF do ImpressaoOk := False ;
                                    else
                                       raise ;
                                  end;

                                  if not ImpressaoOk then
                                  begin
                                    if DoExibeMsg( opmYesNo, 'Impressora n�o responde'+sLineBreak+
                                                             'Tentar novamente ?') <> mrYes then
                                      break ;

                                    I := 121 ;
                                    FechaGerencialAberto := True ;
                                  end;
                                end ;
                             finally
                                if not ImpressaoOk then
                                   Continua := -1 ;

                                SL.Free;
                             end;
                          end ;
                     end;
                   end;

                 1 :
                   begin
                     MensagemOperador := Mensagem;
                     DoExibeMsg( opmExibirMsgOperador, MensagemOperador ) ;
                   end ;

                 2 :
                   begin
                     MensagemCliente := Mensagem;
                     DoExibeMsg( opmExibirMsgCliente, MensagemCliente ) ;
                   end;

                 3 :
                   begin
                     MensagemOperador := Mensagem;
                     MensagemCliente  := Mensagem;
                     DoExibeMsg( opmExibirMsgOperador, MensagemOperador ) ;
                     DoExibeMsg( opmExibirMsgCliente, MensagemCliente ) ;
                   end ;

                 4 : CaptionMenu := Mensagem ;

                 11 :
                   begin
                     MensagemOperador := '' ;
                     DoExibeMsg( opmRemoverMsgOperador, '' ) ;
                   end;

                 12 :
                   begin
                     MensagemCliente := '' ;
                     DoExibeMsg( opmRemoverMsgCliente, '' ) ;
                   end;

                 13 :
                   begin
                     DoExibeMsg( opmRemoverMsgOperador, '' ) ;
                     DoExibeMsg( opmRemoverMsgCliente, '' ) ;
                   end ;

                 14 : CaptionMenu := '' ;
                   {Deve limpar o texto utilizado como cabe�alho na apresenta��o do menu}

                 20 :
                   begin
                     if Mensagem = '' then
                        Mensagem := 'CONFIRMA ?';

                     Resposta := ifThen( (DoExibeMsg( opmYesNo, Mensagem ) = mrYes), '0', '1' ) ;
                     if Resposta = '1' then
                        Continua := -1 ;
                   end ;

                 21 :
                   begin
                     SL := TStringList.Create;
                     try
                        ItemSelecionado := -1 ;
                        SL.Text := StringReplace( Mensagem, ';',
                                                         sLineBreak, [rfReplaceAll] ) ;
                        if TecladoBloqueado then
                           BloquearMouseTeclado(False);

                        OnExibeMenu( CaptionMenu, SL, ItemSelecionado ) ;

                        if (ItemSelecionado >= 0) and (ItemSelecionado < SL.Count) then
                           Resposta := copy( SL[ItemSelecionado], 1,
                                             pos(':',SL[ItemSelecionado])-1 )
                        else
                           Continua := -1 ;
                     finally
                        SL.Free ;
                     end ;
                   end;

                 22 :
                   begin
                     if Mensagem = '' then
                        Mensagem := 'PRESSIONE <ENTER>';

                     DoExibeMsg( opmOK, Mensagem );
                   end ;

                 23 :
                   begin
                     Interromper := False ;
                     OnAguardaResp( '', 0, Interromper ) ;
                     if Interromper then
                        Continua := -1 ;
                   end;

                 30 :
                   begin
                     if TecladoBloqueado then
                        BloquearMouseTeclado(False);

                     Digitado := True ;
                     OnObtemCampo( Mensagem, TamanhoMinimo, TamanhoMaximo,
                                   TipoCampo, tcString, Resposta, Digitado ) ;
                     if not Digitado then
                        Continua := -1 ;
                   end;

                 31 :
                   begin
                     if TecladoBloqueado then
                        BloquearMouseTeclado(False);

                     Digitado := True ;
                     OnObtemCampo( Mensagem, TamanhoMinimo, TamanhoMaximo,
                                   TipoCampo, tcCMC7, Resposta, Digitado ) ;
                     if not Digitado then
                        Continua := -1 ;
                   end;

                 34 :
                   begin
                     if TecladoBloqueado then
                        BloquearMouseTeclado(False);

                     Digitado := True ;
                     OnObtemCampo( Mensagem, TamanhoMinimo, TamanhoMaximo,
                                   TipoCampo, tcDouble, Resposta, Digitado ) ;
                     if (not Digitado) or (StrToFloatDef(Resposta,-1) = -1) then
                        Continua := -1 ;
                   end;

                 35 :
                   begin
                     if TecladoBloqueado then
                        BloquearMouseTeclado(False);

                     Digitado := True ;
                     OnObtemCampo( Mensagem, TamanhoMinimo, TamanhoMaximo,
                                   TipoCampo, tcBarCode, Resposta, Digitado ) ;
                     if not Digitado then
                        Continua := -1 ;
                   end;

              end;
            end
            else
               GravaLog( '*** ContinuaFuncaoSiTefInterativo, Finalizando: STS = '+IntToStr(Result) ) ;

            StrPCopy(Buffer, Resposta);

         until Result <> 10000;
      finally
        if GerencialAberto then
        try
           ComandarECF( opeFechaGerencial );
        except
           ImpressaoOk := False ;
        end;

        if (ArqBackUp <> '') and FileExists( ArqBackUp ) then
           SysUtils.DeleteFile( ArqBackUp );

        if HouveImpressao then
           FinalizarTransacao( ImpressaoOk, Resp.DocumentoVinculado );

        if TecladoBloqueado then
           BloquearMouseTeclado( False );

        { Transfere valore de "Conteudo" para as propriedades }
        TACBrTEFDRespCliSiTef( Self.Resp ).ConteudoToProperty ;

        fpAguardandoResposta := False ;
      end;
   end ;
end;

procedure TACBrTEFDCliSiTef.FinalizarTransacao( Confirma : Boolean;
   DocumentoVinculado : String);
Var
   DataStr, HoraStr : String;
begin
  fRespostas.Clear;

  if pos(DocumentoVinculado, fDocumentosProcessados) > 0 then
     exit ;

  fDocumentosProcessados := fDocumentosProcessados + DocumentoVinculado + '|' ;

  DataStr := FormatDateTime('YYYYMMDD',Now);
  HoraStr := FormatDateTime('HHNNSS',Now);

  GravaLog( '*** FinalizaTransacaoSiTefInterativo. Confirma: '+IfThen(Confirma,'SIM','NAO')+
                                          ' Documento: ' +DocumentoVinculado+
                                          ' Data: '      +DataStr+
                                          ' Hora: '      +HoraStr ) ;

  xFinalizaTransacaoSiTefInterativo( IfThen(Confirma,1,0),
                                     PChar( DocumentoVinculado ),
                                     PChar( DataStr ),
                                     PChar( HoraStr) ) ;

  if not Confirma then
     TACBrTEFD(Owner).DoExibeMsg( opmOK, 'Transa��o n�o efetuada.'+sLineBreak+
                                         'Favor reter o Cupom' );
end;

procedure TACBrTEFDCliSiTef.AvaliaErro( Sts : Integer );
var
   Erro : String;
begin
   Erro := '' ;
   Case Sts of
        -1 : Erro := 'M�dulo n�o inicializado' ;
        -2 : Erro := 'Opera��o cancelada pelo operador' ;
        -3 : Erro := 'Fornecida uma modalidade inv�lida' ;
        -4 : Erro := 'Falta de mem�ria para rodar a fun��o' ;
        -5 : Erro := '' ; // 'Sem comunica��o com o SiTef' ; // Comentado pois SiTEF j� envia a msg de Erro
        -6 : Erro := 'Opera��o cancelada pelo usu�rio' ;
   else
      if Sts < 0 then
         Erro := 'Erros detectados internamente pela rotina ('+IntToStr(Sts)+')'
      else
         Erro := 'Negada pelo autorizador ('+IntToStr(Sts)+')' ;
   end;

   if Erro <> '' then
      TACBrTEFD(Owner).DoExibeMsg( opmOK, Erro );

end ;

procedure TACBrTEFDCliSiTef.ProcessarRespostaPagamento( const IndiceFPG : String;
   const Valor : Double);
var
  ImpressaoOk : Boolean;
  RespostaPendente : TACBrTEFDResp ;
  Imagem : String;
begin
  with TACBrTEFD(Owner) do
  begin
     Self.Resp.IndiceFPG_ECF := IndiceFPG;

     { Cria Arquivo de Backup, contendo Todas as Respostas }
     CopiarResposta ;

     { Cria c�pia do Objeto Resp, e salva no ObjectList "RespostasPendentes" }
     RespostaPendente := TACBrTEFDRespCliSiTef.Create ;
     RespostaPendente.Assign( Resp );
     RespostasPendentes.Add( RespostaPendente );

     if AutoEfetuarPagamento then
     begin
        ImpressaoOk := False ;

        try
           while not ImpressaoOk do
           begin
              try
                 ECFPagamento( IndiceFPG, Valor );
                 RespostaPendente.OrdemPagamento := RespostasPendentes.Count + 1 ;
                 ImpressaoOk := True ;
              except
                 on EACBrTEFDECF do ImpressaoOk := False ;
                 else
                    raise ;
              end;

              if not ImpressaoOk then
              begin
                 if DoExibeMsg( opmYesNo, 'Impressora n�o responde'+sLineBreak+
                                          'Tentar novamente ?') <> mrYes then
                 begin
                    try ComandarECF(opeCancelaCupom); except {Exce��o Muda} end ;
                    break ;
                 end;
              end;
           end;
        finally
           if not ImpressaoOk then
              CancelarTransacoesPendentes;
        end;
     end;

     if RespostasPendentes.SaldoRestante <= 0 then
     begin
        if AutoFinalizarCupom then
        begin
           FinalizarCupom;
           ImprimirTransacoesPendentes;
        end;
     end ;
  end;
end;

end.

