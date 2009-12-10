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
  CLIB_CliSiTefLib = 'clisitef32i.so' ;
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
     procedure LoadDLLFunctions;
   protected
     procedure FinalizarRequisicao ; override;

   public
     constructor Create( AOwner : TComponent ) ; override;
     destructor Destroy ; override;

     procedure Inicializar ; override;

     procedure AtivarGP ; override;

     procedure ATV ; virtual;


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
  Case Sts of
    0 : Erro := '' ;
    1 :	Erro := 'Endere�o IP inv�lido ou n�o resolvido' ;
    2 : Erro := 'C�digo da loja inv�lido' ;
    3 : Erro := 'C�digo de terminal invalido' ;
    6 : Erro := 'Erro na inicializa��o do Tcp/Ip' ;
    7 : Erro := 'Falta de mem�ria' ;
    8 : Erro := 'N�o encontrou a CliSiTef ou ela est� com problemas' ;
   10 : Erro := 'O PinPad n�o est� devidamente configurado no arquivo CliSiTef.ini' ;
  end;

  if Erro <> '' then
     raise Exception.Create( ACBrStr( Erro ) ) ;

  inherited Inicializar;
end;

procedure TACBrTEFDCliSiTef.AtivarGP;
begin
   raise Exception.Create( ACBrStr( 'CliSiTef n�o pode ser ativado localmente' )) ;
end;


procedure TACBrTEFDCliSiTef.ATV;
Var
  Sts : Integer ;
  Erro : String;
begin
   Sts := xIniciaFuncaoSiTefInterativo( 111,  // 111 -	Teste de comunica��o com o SiTef
                                 nil, nil, nil, nil, PChar( fOperador ), nil) ;

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

procedure TACBrTEFDCliSiTef.FinalizarRequisicao;
var
  Sts, ProximoComando, TipoCampo, Continua : Integer;
  TamanhoMinimo, TamanhoMaximo : SmallInt ;
  Buffer: array [0..20000] of char;
  Erro, Mensagem, Resposta, CaptionMenu : String;
begin
   Sts            := 0;
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
      repeat
         Sts:= xContinuaFuncaoSiTefInterativo( ProximoComando, TipoCampo,
                                               TamanhoMinimo, TamanhoMaximo,
                                               Buffer, sizeof(Buffer),
                                               Continua );

         Mensagem := Trim( Buffer ) ;
         Resposta := '' ;

         if Sts = 10000 then
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

(*            21
              Deve apresentar um menu de op��es e permitir que o usu�rio selecione uma delas.
              Na chamada o par�metro Buffer cont�m as op��es no formato
              1:texto;2:texto;...i:Texto;...
              A rotina da aplica��o deve apresentar as op��es da forma que ela desejar
              (n�o sendo necess�rio incluir os �ndices 1,2, ...)
              e ap�s a sele��o feita pelo usu�rio, retornar em Buffer o �ndice i
              escolhido pelo operador (em ASCII)
*)
              22 :
                begin
                  if Mensagem = '' then
                     Mensagem := 'PRESSIONE <ENTER>';
                  DoExibeMsg( opmOK, Mensagem );
                end ;

(*            23 Este comando indica que a rotina est� perguntando para a aplica��o
                 se ele deseja interromper o  processo de coleta de dados ou n�o.
                 Esse c�digo ocorre quando a CliSiTef est� acessando algum perif�rico
                 e permite que a automa��o interrompa esse acesso (por exemplo:
                 aguardando a passagem de um cart�o pela leitora ou a digita��o de
                 senha pelo cliente)

              30 Deve ser lido um campo cujo tamanho est� entre TamMinimo e TamMaximo.
                O campo lido deve ser devolvido em Buffer

            30:
              begin
                FrmColeta.EdtColeta.MaxLength:= TamanhoMaximo;
                FrmColeta.ShowModal;
                StrPCopy (Buffer, CampoColeta);
                Resultado:= 0;
              end;
*)

           end;
         end;

         if Resposta <> '' then
            StrPCopy(Buffer, Resposta);

      until Sts <> 10000;
   end ;

//   EdtResultado.Text:= format ('%d', [Sts]);

//   FinalizaTransacaoSiTefInterativo (1,'12345','20011022','091800');


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
      raise Exception.Create( ACBrStr( Erro ) ) ;
end;


end.


