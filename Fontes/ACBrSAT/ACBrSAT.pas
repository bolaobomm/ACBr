{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2013 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: André Ferreira de Moraes                        }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
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

{$I ACBr.inc}

unit ACBrSAT;

interface

uses
  Classes, SysUtils, pcnCFe, pcnCFeCanc, ACBrSATClass,
  ACBrSATExtratoClass, synacode
  {$IFNDEF NOGUI}
    {$IFDEF FPC} ,LResources {$ENDIF}
  {$ENDIF};

type
   { TACBrSAT }

   TACBrSAT = class( TComponent )
   private
     fsCFe : TCFe ;
     fsCFeCanc : TCFeCanc ;
     fsnumeroSessao : Integer ;
     fsOnGetcodigoDeAtivacao : TACBrSATGetChave ;
     fsOnGetsignAC : TACBrSATGetChave ;
     fsOnLog : TACBrSATDoLog ;
     fsPathDLL : String ;
     fsResposta : TACBrSATResposta ;
     fsRespostaComando : String ;
     fsSATClass : TACBrSATClass ;
     fsExtrato : TACBrSATExtratoClass;

     fsArqLOG: String;
     fsComandoLog: String;
     fsInicializado : Boolean ;
     fsModelo : TACBrSATModelo ;
     fsConfig : TACBrSATConfig ;

     function CodificarPaginaDeCodigoSAT(ATexto: String): AnsiString;
     function DecodificarPaginaDeCodigoSAT(ATexto: AnsiString): String;

     function GetAbout : String;
     function GetcodigoDeAtivacao : AnsiString ;
     function GetModeloStrClass : String ;
     function GetNomeDLL : String ;
     function GetsignAC : AnsiString ;
     procedure SetAbout(const Value: String);{%h-}
     procedure SetInicializado(AValue : Boolean) ;
     procedure SetModelo(AValue : TACBrSATModelo) ;
     procedure SetPathDLL(AValue : string) ;

     procedure IniciaComando ;
     function FinalizaComando(AResult: String): String;

     procedure GravaLog(AString : AnsiString ) ;
     procedure SetExtrato(const Value: TACBrSATExtratoClass);
   protected
     procedure Notification(AComponent: TComponent; Operation: TOperation); override;
   public
     property SAT : TACBrSATClass read fsSATClass ;

     constructor Create( AOwner : TComponent ) ; override;
     destructor Destroy ; override;

     Procedure Inicializar;
     Procedure DesInicializar;
     property Inicializado : Boolean read fsInicializado write SetInicializado ;
     procedure VerificaInicializado ;

     Property ModeloStr : String  read GetModeloStrClass;
     Property NomeDLL   : String  read GetNomeDLL;

     property numeroSessao : Integer read fsnumeroSessao write fsnumeroSessao;
     function GerarnumeroSessao : Integer ;

     property codigoDeAtivacao : AnsiString read GetcodigoDeAtivacao ;
     property signAC           : AnsiString read GetsignAC ;

     property RespostaComando: String read fsRespostaComando ;

     property CFe : TCFe read fsCFe ;
     property CFeCanc : TCFeCanc read fsCFeCanc ;
     property Resposta : TACBrSATResposta read fsResposta;

     procedure InicializaCFe( ACFe : TCFe = nil );

     procedure DoLog(AString : String ) ;

     function AssociarAssinatura( CNPJvalue, assinaturaCNPJs : AnsiString ): String ;
     function AtivarSAT(subComando : Integer ; CNPJ : String ; cUF : Integer
       ) : String ;
     function AtualizarSoftwareSAT : String ;
     function BloquearSAT : String ;
     procedure CFe2CFeCanc;
     function CancelarUltimaVenda :String ; overload;
     function CancelarUltimaVenda( chave, dadosCancelamento : AnsiString ) :
       String ; overload;
     function ComunicarCertificadoICPBRASIL( certificado : AnsiString ) :
       String ;
     function ConfigurarInterfaceDeRede( dadosConfiguracao : AnsiString ) :
       String ;
     function ConsultarNumeroSessao( cNumeroDeSessao : Integer) : String ;
     function ConsultarSAT : String ;
     function ConsultarStatusOperacional : String ;
     function DesbloquearSAT : String ;
     function DesligarSAT : String ;
     function EnviarDadosVenda : String ; overload;
     function EnviarDadosVenda( dadosVenda : AnsiString ) : String ; overload;
     function ExtrairLogs : String ;
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

     property PathDLL: string read fsPathDLL write SetPathDLL;

     property About : String read GetAbout write SetAbout stored False ;
     property ArqLOG : String read fsArqLOG write fsArqLOG ;
     property OnLog : TACBrSATDoLog read fsOnLog write fsOnLog;

     property Config : TACBrSATConfig read fsConfig write fsConfig;

     property OnGetcodigoDeAtivacao : TACBrSATGetChave read fsOnGetcodigoDeAtivacao
        write fsOnGetcodigoDeAtivacao;
     property OnGetsignAC : TACBrSATGetChave read fsOnGetsignAC write fsOnGetsignAC;

   end;

procedure Register;

implementation

Uses ACBrUtil, ACBrSATDinamico_cdecl, ACBrSATExtratoESCPOS;

{$IFNDEF FPC}
   {$R ACBrSAT.dcr}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrSAT,TACBrSATExtratoESCPOS]);
end;

{ TACBrSAT }

constructor TACBrSAT.Create(AOwner : TComponent) ;
begin
  inherited Create(AOwner) ;

  fsnumeroSessao    := 0;
  fsPathDLL         := '';
  fsArqLOG          := '' ;
  fsComandoLog      := '';
  fsRespostaComando := '';

  fsOnGetcodigoDeAtivacao := nil;
  fsOnGetsignAC           := nil;
  fsOnLog                 := nil;

  fsConfig  := TACBrSATConfig.Create;
  fsCFe     := TCFe.Create;
  fsCFeCanc := TCFeCanc.Create;
  fsResposta:= TACBrSATResposta.Create;
end ;

destructor TACBrSAT.Destroy ;
begin
  fsConfig.Free;
  fsCFe.Free;
  fsCFeCanc.Free;
  fsResposta.Free;

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
  AStr := '   '+FormatDateTime('hh:nn:ss:zzz',now) +
          ' - numeroSessao: '+IntToStr(numeroSessao) ;
  if fsRespostaComando <> '' then
     AStr := AStr + ' - Resposta:'+fsRespostaComando;

  Resposta.RetornoStr := fsRespostaComando;

  DoLog( AStr );
end ;

procedure TACBrSAT.DoLog(AString : String) ;
begin
  GravaLog(AString);

  if Assigned( fsOnLog ) then
    fsOnLog( AString );
end ;

procedure TACBrSAT.GravaLog(AString : AnsiString) ;
begin
  if (ArqLOG = '') then
    exit;

  WriteToTXT( ArqLOG, AString );
end ;

function TACBrSAT.GerarnumeroSessao : Integer ;
begin
  fsnumeroSessao := Random(999999);
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

function TACBrSAT.AtivarSAT(subComando : Integer ; CNPJ : String ;
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
  if CFeCanc.infCFe.chCanc = '' then
     CFe2CFeCanc;

  dadosCancelamento := CFeCanc.GetXMLString( true ); // True = Gera apenas as TAGs da aplicação

  Result := CancelarUltimaVenda( CFeCanc.infCFe.chCanc, dadosCancelamento);
end ;


function TACBrSAT.CancelarUltimaVenda(chave, dadosCancelamento : AnsiString
  ) : String ;
var
  XMLRecebido: String;
begin
  fsComandoLog := 'CancelarUltimaVenda( '+chave+', '+dadosCancelamento+' )';
  if Trim(chave) = '' then
     raise EACBrSATErro.Create('Parâmetro: "chave" não informado');
  if Trim(dadosCancelamento) = '' then
     raise EACBrSATErro.Create('Parâmetro: "dadosCancelamento" não informado');

  IniciaComando;
  Result := FinalizaComando( fsSATClass.CancelarUltimaVenda(chave, dadosCancelamento) ) ;

  if fsResposta.codigoDeRetorno = 7000 then
  begin
     XMLRecebido := DecodeBase64(fsResposta.RetornoLst[6]);
     CFeCanc.AsXMLString := XMLRecebido;
     //DEBUG
     //WriteToTXT('c:\temp\CancRec.xml',XMLRecebido,False,False);
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
end ;

function TACBrSAT.ConsultarSAT : String ;
begin
  fsComandoLog := 'ConsultarSAT';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.ConsultarSAT );
end ;

function TACBrSAT.ConsultarStatusOperacional : String ;
begin
  fsComandoLog := 'ConsultarStatusOperacional';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.ConsultarStatusOperacional ) ;
end ;

function TACBrSAT.DesbloquearSAT : String ;
begin
  fsComandoLog := 'DesbloquearSAT';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.DesbloquearSAT );
end ;

function TACBrSAT.DesligarSAT : String ;
begin
  fsComandoLog := 'DesligarSAT';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.DesligarSAT );
end ;

function TACBrSAT.EnviarDadosVenda: String;
begin
  Result := EnviarDadosVenda( CFe.GetXMLString( True ) );  // True = Gera apenas as TAGs da aplicação
end;

function TACBrSAT.EnviarDadosVenda(dadosVenda : AnsiString) : String ;
var
  XMLRecebido: String;
begin
  fsComandoLog := 'EnviarDadosVenda( '+dadosVenda+' )';
  if Trim(dadosVenda) = '' then
     raise EACBrSATErro.Create('Parâmetro: "dadosVenda" não informado');

  IniciaComando;
  Result := FinalizaComando( fsSATClass.EnviarDadosVenda( Trim(dadosVenda) ) );

  if fsResposta.codigoDeRetorno = 6000 then
  begin
     XMLRecebido := DecodeBase64(fsResposta.RetornoLst[6]);
     CFe.AsXMLString := XMLRecebido;
     //DEBUG
     //WriteToTXT('c:\temp\VendaRec.xml',XMLRecebido,False,False);
  end;
end ;

function TACBrSAT.ExtrairLogs : String ;
begin
  fsComandoLog := 'ExtrairLogs';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.ExtrairLogs );
end ;

function TACBrSAT.TesteFimAFim(dadosVenda : AnsiString) : String ;
begin
  fsComandoLog := 'TesteFimAFim(' +dadosVenda+' )';
  IniciaComando;
  Result := FinalizaComando( fsSATClass.TesteFimAFim( dadosVenda ) );
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

function TACBrSAT.GetNomeDLL : String ;
begin
  Result := fsSATClass.NomeDLL;
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
     raise EACBrSATErro.Create( ACBrStr(cACBrSATSetModeloException));

  wArqLOG := ArqLOG ;

  FreeAndNil( fsSATClass ) ;

  { Instanciando uma nova classe de acordo com AValue }
  case AValue of
    satDinamico_cdecl : fsSATClass := TACBrSATDinamico_cdecl.Create( Self ) ;
  else
    fsSATClass := TACBrSATClass.Create( Self ) ;
  end;

  { Passando propriedades da Classe anterior para a Nova Classe }
  ArqLOG := wArqLOG ;

  fsModelo := AValue;
end ;

procedure TACBrSAT.SetPathDLL(AValue : string) ;
begin
  if fsPathDLL = AValue then Exit ;
  fsPathDLL := PathWithDelim( Trim(AValue) ) ;
end ;

procedure TACBrSAT.SetExtrato(const Value: TACBrSATExtratoClass);
Var
  OldValue: TACBrSATExtratoClass ;
begin
  if Value <> fsExtrato then
  begin
     if Assigned(fsExtrato) then
        fsExtrato.RemoveFreeNotification(Self);

     OldValue  := fsExtrato ;   // Usa outra variavel para evitar Loop Infinito
     fsExtrato := Value;    // na remoção da associação dos componentes

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

procedure TACBrSAT.CFe2CFeCanc;
begin
  CFeCanc.Clear;
  CFeCanc.infCFe.chCanc   := 'CFe'+CFe.infCFe.ID;
  CFeCanc.infCFe.dEmi     := CFe.ide.dEmi;
  CFeCanc.infCFe.hEmi     := CFe.ide.hEmi;
  CFeCanc.ide.CNPJ        := CFe.ide.CNPJ;
  CFeCanc.ide.signAC      := CFe.ide.signAC;
  CFeCanc.ide.numeroCaixa := CFe.ide.numeroCaixa;
  CFeCanc.Dest.CNPJCPF    := CFe.Dest.CNPJCPF;
end;

procedure TACBrSAT.ImprimirExtrato;
begin
   if not Assigned(Extrato) then
      raise Exception.Create( ACBrStr('Nenhum componente "ACBrSATExtrato" associado' ) ) ;

   Extrato.ImprimirExtrato;
end;

procedure TACBrSAT.ImprimirExtratoCancelamento;
begin
   if not Assigned(Extrato) then
      raise Exception.Create( ACBrStr('Nenhum componente "ACBrSATExtrato" associado' ) ) ;

   Extrato.ImprimirExtratoCancelamento;
end;

procedure TACBrSAT.ImprimirExtratoResumido;
begin
   if not Assigned(Extrato) then
      raise Exception.Create( ACBrStr('Nenhum componente "ACBrSATExtrato" associado' ) ) ;

   Extrato.ImprimirExtratoResumido;
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

{$IFDEF FPC}
{$IFNDEF NOGUI}
initialization
   {$I ACBrSAT.lrs}
{$ENDIF}
{$ENDIF}

end.

