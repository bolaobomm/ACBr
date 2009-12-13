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
  Classes, SysUtils, ACBrTEFDClass
  {$IFDEF VisualCLX}
     ,QControls
  {$ELSE}
     ,Controls
  {$ENDIF}  ;


Const
{$IFDEF LINUX}
  CLIB_CliSiTefLib = 'libclisitef32.so' ;
{$ELSE}
  CLIB_CliSiTefLib = 'CliSiTef32I.dll' ;
{$ENDIF}

type
  TACBrTEFDCliSiTefExibeMenu = procedure( Titulo : String; Opcoes : TStringList;
    var ItemSlecionado : Integer ) of object ;

  TACBrTEFDCliSiTefObtemCampo = procedure( Titulo : String;
    TamanhoMinimo, TamanhoMaximo : Integer ; var Resposta : String ) of object ;

   { TACBrTEFDCliSiTef }

   TACBrTEFDCliSiTef = class( TACBrTEFDClass )
   private
      fCodigoLoja : String;
      fEnderecoIP : String;
      fNumeroTerminal : String;
      fOnExibeMenu : TACBrTEFDCliSiTefExibeMenu;
      fOnObtemCampo : TACBrTEFDCliSiTefObtemCampo;
      fOperador : String;
      fParametrosAdicionais : TStringList;
     xConfiguraIntSiTefInterativoEx : function (
                pEnderecoIP: PChar;
                pCodigoLoja: PChar;
                pNumeroTerminal: PChar;
                ConfiguraResultado: smallint;
                pParametrosAdicionais: PChar): integer; stdcall;

     xIniciaFuncaoSiTefInterativo : function (
                Modalidade: integer;
                pValor: PChar;
                pNumeroCuponFiscal: PChar;
                pDataFiscal: PChar;
                pHorario: PChar;
                pOperador: PChar;
                pRestricoes: PChar ): integer; stdcall;

     xFinalizaTransacaoSiTefInterativo : procedure (
                 smallint: Word;
                 pNumeroCuponFiscal: PChar;
                 pDataFiscal: PChar;
                 pHorario: PChar ); stdcall;

     xContinuaFuncaoSiTefInterativo : function (
                var ProximoComando: Integer;
                var TipoCampo: Integer;
                var TamanhoMinimo: smallint;
                var TamanhoMaximo: smallint;
                pBuffer: PChar;
                TamMaxBuffer: Integer;
                ContinuaNavegacao: Integer ): integer; stdcall;
     procedure AvaliaErro(Sts : Integer);
     procedure LoadDLLFunctions;
   protected
     Function ContinuarRequisicao : Integer ;

   public
     constructor Create( AOwner : TComponent ) ; override;
     destructor Destroy ; override;

     procedure Inicializar ; override;

     procedure AtivarGP ; override;
     procedure VerificaAtivo ; override;

     procedure ATV ; override;
     procedure ADM ; override;

   published
     property EnderecoIP     : String read fEnderecoIP     write fEnderecoIP ;
     property CodigoLoja     : String read fCodigoLoja     write fCodigoLoja ;
     property NumeroTerminal : String read fNumeroTerminal write fNumeroTerminal ;
     property Operador       : String read fOperador       write fOperador ;
     property ParametrosAdicionais : TStringList read fParametrosAdicionais ;

     property OnExibeMenu : TACBrTEFDCliSiTefExibeMenu read fOnExibeMenu
        write fOnExibeMenu ;
     property OnObtemCampo : TACBrTEFDCliSiTefObtemCampo read fOnObtemCampo
        write fOnObtemCampo ;
   end;

implementation

Uses ACBrUtil, dateutils, StrUtils, ACBrTEFD;

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

  fParametrosAdicionais := TStringList.Create;

  xConfiguraIntSiTefInterativoEx    := nil ;
  xIniciaFuncaoSiTefInterativo      := nil ;
  xContinuaFuncaoSiTefInterativo    := nil ;
  xFinalizaTransacaoSiTefInterativo := nil ;
end;

destructor TACBrTEFDCliSiTef.Destroy;
begin
   fParametrosAdicionais.Free ;

   inherited Destroy;
end;

procedure TACBrTEFDCliSiTef.Inicializar;
Var
  Sts : Integer ;
  ParamAdic : String ;
  Erro : String;
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

  inherited Inicializar;
end;

procedure TACBrTEFDCliSiTef.AtivarGP;
begin
   raise Exception.Create( ACBrStr( 'CliSiTef n�o pode ser ativado localmente' )) ;
end;

procedure TACBrTEFDCliSiTef.VerificaAtivo;
begin
   {Nada a Fazer}
end;


procedure TACBrTEFDCliSiTef.AvaliaErro( Sts : Integer );
var
   Erro : String;
begin
   Erro := '' ;
   Case Sts of
         0 : Erro := 'negada pelo autorizador' ;
        -1 : Erro := 'm�dulo n�o inicializado' ;
        -2 : Erro := 'opera��o cancelada pelo operador' ;
        -3 : Erro := 'fornecida uma modalidade inv�lida' ;
        -4 : Erro := 'falta de mem�ria para rodar a fun��o' ;
        -5 : Erro := 'sem comunica��o com o SiTef' ;
        -6 : Erro := 'opera��o cancelada pelo usu�rio' ;
   else
      if Sts < 0 then
         Erro := 'erros detectados internamente pela rotina ('+IntToStr(Sts)+')' ;
   end;

   if Erro <> '' then
      raise EACBrTEFDErro.Create( ACBrStr( Erro ) ) ;
end ;

procedure TACBrTEFDCliSiTef.ATV;
Var
  Sts : Integer ;
  DataStr, HoraStr : String;
begin
   DataStr := FormatDateTime('YYYYMMDD',Now);
   HoraStr := FormatDateTime('HHNNSS',Now);
   GravaLog( 'IniciaFuncaoSiTefInterativo. Modalidade = 111') ;

   Sts := xIniciaFuncaoSiTefInterativo( 111,  // 111 -	Teste de comunica��o com o SiTef
                                 '', '',
                                 PChar(DataStr), PChar(HoraStr),
                                 PChar( fOperador ), '') ;

   if Sts = 10000 then
      Sts := ContinuarRequisicao ;

   if Sts <> 0 then
      AvaliaErro( Sts );
end;

procedure TACBrTEFDCliSiTef.ADM;
Var
  Sts : Integer ;
  DataStr, HoraStr : String;
begin
   DataStr := FormatDateTime('YYYYMMDD',Now);
   HoraStr := FormatDateTime('HHNNSS',Now);

   GravaLog( 'IniciaFuncaoSiTefInterativo. Modalidade = 110') ;

   Sts := xIniciaFuncaoSiTefInterativo( 110,  // 110 - Abre o leque das transa��es Gerenciais
                                 '', '',
                                 PChar(DataStr), PChar(HoraStr),
                                 PChar( fOperador ), '') ;

   if Sts = 10000 then
      Sts := ContinuarRequisicao;

   if (Sts <> 0) then
      AvaliaErro( Sts );
end;

procedure TACBrTEFDCliSiTef.LoadDLLFunctions ;
 procedure CliSiTefFunctionDetect( FuncName: String; var LibPointer: Pointer ) ;
 begin
   if not Assigned( LibPointer )  then
   begin
     if not FunctionDetect( CLIB_CliSiTefLib, FuncName, LibPointer) then
     begin
        LibPointer := NIL ;
        raise Exception.Create( ACBrStr( 'Erro ao carregar a fun��o:'+FuncName+' de: '+CLIB_CliSiTefLib ) ) ;
     end ;
   end ;
 end ;
begin
   CliSiTefFunctionDetect('ConfiguraIntSiTefInterativoEx', @xConfiguraIntSiTefInterativoEx);
   CliSiTefFunctionDetect('IniciaFuncaoSiTefInterativo', @xIniciaFuncaoSiTefInterativo);
   CliSiTefFunctionDetect('ContinuaFuncaoSiTefInterativo', @xContinuaFuncaoSiTefInterativo);
   CliSiTefFunctionDetect('FinalizaTransacaoSiTefInterativo', @xFinalizaTransacaoSiTefInterativo);
end ;

Function TACBrTEFDCliSiTef.ContinuarRequisicao : Integer;
var
  ProximoComando, TipoCampo, Continua, ItemSelecionado: Integer;
  TamanhoMinimo, TamanhoMaximo : SmallInt ;
  Buffer: array [0..20000] of char;
  Erro, Mensagem, Resposta, CaptionMenu : String;
  ItensMenu   : TStringList ;
  Interromper : Boolean ;
begin
   Result         := 0;
   ProximoComando := 0;
   TipoCampo      := 0;
   TamanhoMinimo  := 0;
   TamanhoMaximo  := 0;
   Continua       := 0;

   Erro        := '' ;
   Mensagem    := '' ;
   CaptionMenu := '' ;

   with TACBrTEFD(Owner) do
   begin
      try
         repeat
            Result := xContinuaFuncaoSiTefInterativo( ProximoComando, TipoCampo,
                                                  TamanhoMinimo, TamanhoMaximo,
                                                  Buffer, sizeof(Buffer),
                                                  Continua );

            Mensagem := Trim( Buffer ) ;
            Resposta := '' ;

            GravaLog( 'Sts: '+IntToStr(Result)+
                      ' ProximoComando: '+IntToStr(ProximoComando)+
                      ' TipoCampo: '+IntToStr(TipoCampo)+
                      ' Buffer: '+Mensagem ) ;

            if Result = 10000 then
            begin
              case ProximoComando of
                 0: ;// TODO: Est� devolvendo um valor para, se desejado, ser armazenado pela automa��o;

                 1 : DoExibeMsg( opmExibirMsgOperador, Mensagem ) ;

                 2 : DoExibeMsg( opmExibirMsgCliente, Mensagem ) ;

                 3 :
                   begin
                     DoExibeMsg( opmExibirMsgOperador, Mensagem ) ;
                     DoExibeMsg( opmExibirMsgCliente, Mensagem ) ;
                   end ;

                 4 : CaptionMenu := Mensagem ;

                 11 : DoExibeMsg( opmRemoverMsgOperador, '' ) ;

                 12 : DoExibeMsg( opmRemoverMsgCliente, '' ) ;

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
                     ItensMenu := TStringList.Create;
                     try
                        ItemSelecionado := -1 ;
                        ItensMenu.Text  := StringReplace( Mensagem, ';',
                                                         sLineBreak, [rfReplaceAll] ) ;

                        OnExibeMenu( CaptionMenu, ItensMenu, ItemSelecionado ) ;

                        if (ItemSelecionado >= 0) and (ItemSelecionado < ItensMenu.Count) then
                           Resposta := copy( ItensMenu[ItemSelecionado], 1,
                                             pos(':',ItensMenu[ItemSelecionado])-1 )
                        else
                           Continua := -1 ;
                     finally
                        ItensMenu.Free ;
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
                     OnObtemCampo( Mensagem, TamanhoMinimo, TamanhoMaximo, Resposta ) ;
                     if Resposta = '-1' then
                        Continua := -1 ;
                   end;
              end;
            end;

            if Resposta <> '' then
               StrPCopy(Buffer, Resposta);

         until Result <> 10000;
      finally
        DoExibeMsg( opmRemoverMsgOperador, '' ) ;
        DoExibeMsg( opmRemoverMsgCliente, '' ) ;
      end;
   end ;
end;

end.


