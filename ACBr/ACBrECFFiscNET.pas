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
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 26/06/2006: Daniel Sim�es de Almeida
|* - Primeira Versao: Cria�ao e Distribui�ao da Primeira Versao
|* 28/11/2006: Daniel Sim�es de Almeida
|* - Corrigo bug em SubTotalizaCupom
|* 09/01/2007: Daniel Sim�es de Almeida
|* - Corrigido espacejamento de PulaLinhas ( considerando 1 linha = 30 dots )
|* - Corrigido BUG em M�todo CorrigeEstadoErro, que sempre causava o Reinicio
|*   do ECF
|* - M�todo AbreRelatorioGerencial modificado para cadastrar  Relatorio
|*   Gerencial ( 0 ) caso ele ainda n�o exista
|* 10/01/2007: Daniel Sim�es de Almeida
|* - M�todo VendeItem gerava exce��o quando Desconto era informado
|* - M�todo "LinhaRelatorioGerencial" nao imprimir linhas vazias e em textos
|*   maiores que 492 caracteres poderia haver quebra do lay-out de impressao
|* 01/04/2007:  Daniel Simoes de Almeida
|*  - Implementados m�todos de Cupom N�o Fiscal
|* 24/02/2008:  Fabio Farias
|*  - Compatibilizada com a TermoPrinter
|* 05/02/2009:  Daniel Sim�es de Almeida
|*  - Corrigido m�todo NaoFiscalCompleto, que era cancelado quando Registrador
|*    NaoFiscal era de Saidas (-) ou continha Obs no rodap�
******************************************************************************}

{$I ACBr.inc}

unit ACBrECFFiscNET ;

interface
uses ACBrECFClass, ACBrDevice, ACBrUtil,
     Classes ;

type

TACBrECFFiscNETComando = class
  private
    fsNomeComando : String ;
    fsParams  : TStringList ;
    fsCont    : Byte ;
    fsTimeOut: Integer;

    function GetComando: AnsiString;
    procedure SetNomeComando(const Value: String);
 public
    constructor create ;
    destructor destroy ; override ;

    property NomeComando : String  write SetNomeComando ;
    property TimeOut     : Integer read fsTimeOut write fsTimeOut ;
    property Comando     : AnsiString  read GetComando ;
    property Params      : TStringList read fsParams ;

    Procedure AddParamString(ParamName : String; AString  : AnsiString) ;
    Procedure AddParamInteger(ParamName : String; AInteger : Integer) ;
    Procedure AddParamDouble(ParamName : String; ADouble  : Double) ;
    Procedure AddParamBool(ParamName : String; ABool    : Boolean) ;
    Procedure AddParamDateTime(ParamName : String; ADateTime: TDateTime;Tipo : Char = 'D'  ) ;
 end ;

TACBrECFFiscNETResposta = class
  private
    fsParams  : TStringList ;
    fsCont: Byte;
    fsCodRetorno: Integer;
    fsTamanho: Integer;
    fsResposta : AnsiString ;

    procedure SetResposta(const Value: AnsiString);
 public
    constructor create ;
    destructor destroy ; override ;

    property Resposta   : AnsiString  read fsResposta write SetResposta ;
    property Cont       : Byte        read fsCont;
    property CodRetorno : Integer     read fsCodRetorno ;
    property Params     : TStringList read fsParams ;
    property Tamanho    : Integer     read fsTamanho ;
 end ;

{ Classe filha de TACBrECFClass com implementa�ao para FiscNET }
TACBrECFFiscNET = class( TACBrECFClass )
 private
    fsNumVersao : String ;
    fsNumECF    : String ;
    fsNumLoja   : String ;
    fsArredonda : Integer ;
    fsFiscNETComando: TACBrECFFiscNETComando;
    fsFiscNETResposta: TACBrECFFiscNETResposta;
    fsComandoVendeItem : String ;
    fsComandosImpressao : array[0..9] of AnsiString ;

    xGera_AtoCotepe1704 : function (ComPortOrFileName: AnsiString;
      Modelo: AnsiString; RegFileName: AnsiString; DataReducao: AnsiString): Integer; stdcall;

    procedure LoadDLLFunctions;

    Function PreparaCmd( cmd : AnsiString ) : AnsiString ;
    Function AjustaLeitura( AString : AnsiString ) : AnsiString ;
    function DocumentosToStr(Documentos: TACBrECFTipoDocumentoSet): String;
 protected
    function GetDataHora: TDateTime; override ;
    function GetNumCupom: String; override ;
    function GetNumCCF: String; override ;
    function GetNumECF: String; override ;
    function GetNumLoja: String; override ;
    function GetNumSerie: String; override ;
    function GetNumVersao: String; override ;
    function GetSubTotal: Double; override ;
    function GetTotalPago: Double; override ;

    function GetEstado: TACBrECFEstado; override ;
    function GetGavetaAberta: Boolean; override ;
    function GetPoucoPapel : Boolean; override ;
    function GetHorarioVerao: Boolean; override ;
    function GetChequePronto: Boolean; override ;
    function GetArredonda: Boolean; override ;

    function GetCNPJ: String; override ;
    function GetIE: String; override ;
    function GetIM: String; override ;  //IMS 28/09/2009
    function GetCliche: String; override ;  //IMS 28/09/2009
    function GetUsuarioAtual: String; override ;  //IMS 09/10/2009
    function GetDataHoraSB: TDateTime; override ; //IMS 20/10/2009
    function GetSubModeloECF: String ; override ; //IMS 20/10/2009
    
    function GetDataMovimento: TDateTime; override ;
    function GetGrandeTotal: Double; override ;
    function GetNumCRO: String; override ;
    function GetNumGRG: String; override ;
    function GetNumGNF: String; override ;
    function GetNumCDC: String; override ;    
    function GetNumCRZ: String; override ;
    function GetVendaBruta: Double; override ;
    function GetTotalAcrescimos: Double; override ;
    function GetTotalCancelamentos: Double; override ;
    function GetTotalDescontos: Double; override ;
    function GetTotalSubstituicaoTributaria: Double; override ;
    function GetTotalNaoTributado: Double; override ;
    function GetTotalIsencao: Double; override ;


    function GetTotalAcrescimosISSQN: Double; override;
    function GetTotalCancelamentosISSQN: Double; override;
    function GetTotalDescontosISSQN: Double; override;
    function GetTotalSubstituicaoTributariaISSQN: Double; override;
    function GetTotalIsencaoISSQN: Double; override;
    function GetTotalNaoTributadoISSQN: Double; override;


    function GetNumCOOInicial: String; override ;
    function GetNumUltimoItem: Integer; override ;

    Function VerificaFimLeitura(var Retorno: AnsiString;
       var TempoLimite: TDateTime) : Boolean ; override ;

 public
    Constructor create( AOwner : TComponent  )  ;
    Destructor Destroy  ; override ;

    procedure Ativar ; override ;

    property FiscNETComando : TACBrECFFiscNETComando  read fsFiscNETComando ;
    property FiscNETResposta: TACBrECFFiscNETResposta read fsFiscNETResposta ;

    Function EnviaComando_ECF( cmd : AnsiString = '') : AnsiString ; override ;

    Procedure AbreCupom ; override ;
    Procedure VendeItem( Codigo, Descricao : String; AliquotaECF : String;
       Qtd : Double ; ValorUnitario : Double; ValorDescontoAcrescimo : Double = 0;
       Unidade : String = ''; TipoDescontoAcrescimo : String = '%';
       DescontoAcrescimo : String = 'D' ) ; override ;
    Procedure SubtotalizaCupom( DescontoAcrescimo : Double = 0;
       MensagemRodape : AnsiString  = '' ) ; override ;
    Procedure EfetuaPagamento( CodFormaPagto : String; Valor : Double;
       Observacao : AnsiString = ''; ImprimeVinculado : Boolean = false) ;
       override ;
    Procedure FechaCupom( Observacao : AnsiString = ''; IndiceBMP : Integer = 0) ; override ;
    Procedure CancelaCupom ; override ;
    Procedure CancelaItemVendido( NumItem : Integer ) ; override ;

    { Procedimentos de Cupom N�o Fiscal }
    Procedure AbreNaoFiscal( CPF_CNPJ : String = '') ; override ;
    Procedure RegistraItemNaoFiscal( CodCNF : String; Valor : Double;
       Obs : AnsiString = '') ; override ;
    procedure NaoFiscalCompleto(CodCNF: String; Valor: Double;
      CodFormaPagto: String; Obs: AnsiString; IndiceBMP : Integer = 0); override ;

    Procedure LeituraX ; override ;
    Procedure LeituraXSerial( Linhas : TStringList) ; override ;
    Procedure ReducaoZ(DataHora : TDateTime) ; override ;
    Procedure AbreRelatorioGerencial(Indice: Integer = 0) ; override ;
    Procedure LinhaRelatorioGerencial( Linha : AnsiString; IndiceBMP: Integer = 0 ) ; override ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; override ;
    Procedure LinhaCupomVinculado( Linha : AnsiString ) ; override ;
    Procedure FechaRelatorio ; override ;
    Procedure PulaLinhas( NumLinhas : Integer = 0 ) ; override ;
    Procedure CortaPapel( const CorteParcial : Boolean = false) ; override ;

    Procedure MudaHorarioVerao  ; overload ; override ;
    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ; overload ; override ;
    Procedure CorrigeEstadoErro(Reducao: Boolean = True) ; override ;


    Procedure LeituraMemoriaFiscal( DataInicial, DataFinal : TDateTime;
       Simplificada : Boolean = False ) ; override ;
    Procedure LeituraMemoriaFiscal( ReducaoInicial, ReducaoFinal : Integer;
       Simplificada : Boolean = False ) ; override ;
    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
       Linhas : TStringList; Simplificada : Boolean = False ) ; override ;
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal : Integer;
       Linhas : TStringList; Simplificada : Boolean = False ) ; override ;
    Procedure LeituraMFDSerial( DataInicial, DataFinal : TDateTime;
       Linhas : TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos] ) ; overload ; override ;
    Procedure LeituraMFDSerial( COOInicial, COOFinal : Integer;
       Linhas : TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos] ) ; overload ; override ;

    Procedure ArquivoMFD_DLL( DataInicial, DataFinal : TDateTime;
       NomeArquivo : String; Documentos : TACBrECFTipoDocumentoSet = [docTodos]  ) ; override ;

    Procedure ImprimeCheque(Banco : String; Valor : Double ; Favorecido,
       Cidade : String; Data : TDateTime ;Observacao : String = '') ; override ;
    Procedure CancelaImpressaoCheque ; override ;
    Function LeituraCMC7 : AnsiString ; override ;
    
    Procedure AbreGaveta ; override ;

    procedure CarregaAliquotas ; override ;
    procedure LerTotaisAliquota ; override ;
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ; override ;
    function AchaICMSAliquota( var AliquotaICMS : String ) :
       TACBrECFAliquota ;  override;

    procedure CarregaFormasPagamento ; override ;
    procedure LerTotaisFormaPagamento ; override ;
    Procedure ProgramaFormaPagamento( var Descricao: String;
       PermiteVinculado : Boolean = true; Posicao : String = '' ) ; override ;

    procedure CarregaRelatoriosGerenciais ; override ;
    Procedure ProgramaRelatorioGerencial( var Descricao: String;
       Posicao : String = '') ; override ;
       
    procedure CarregaComprovantesNaoFiscais ; override ;
    procedure LerTotaisComprovanteNaoFiscal ; override ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ; override ;

 end ;

//Constantes usada para DLL do Ato Cotepe 1704
CONST
  ERROS_DLL : Array[1..17] of String =
    ( 'Erro ao executar comando EmiteLeituraX.',
      'Erro ao executar comando EmiteLeituraMF.',
      'Erro ao executar comando EmiteLeituraFitaDetalhe.',
      'Comando Inexistente.',
      'Erro ao obter dados de impress�o.',
      'Erro ao acessar o arquivo.',
      'Erro ao executar comando.Data inv�lida.',
      'N�o existe redu��o executada na data informada.',
      'Modelo n�o permitido.',
      'Comando inv�lido.',
      'Biblioteca n�o foi encontrada.',
      'Sem Sinal de CTS.',
      'Nome do arquivo inv�lido',
      'Intervalo de data n�o permitido',
      'Caminho de origem n�o permitido.',
      'Caminho de destino n�o permitido.',
      'Erro Desconhecido.' ) ;


implementation
Uses ACBrECF,
     {$IFDEF COMPILER6_UP} DateUtils, StrUtils {$ELSE} ACBrD5, SysUtils, SysUtils, Windows{$ENDIF},
     SysUtils,  Math ;

{ -------------------------  TACBrECFFiscNETComando -------------------------- }
constructor TACBrECFFiscNETComando.create;
begin
  inherited create ;

  fsParams := TStringList.create ;
  fsCont   := 0 ;
end;

destructor TACBrECFFiscNETComando.destroy;
begin
  fsParams.Free ;

  inherited destroy ;
end;

procedure TACBrECFFiscNETComando.SetNomeComando(const Value: String);
begin
  if fsCont >= 250 then
     fsCont := 1
  else
     Inc( fsCont ) ;

  fsNomeComando := Trim(Value) ;
  fsTimeOut     := 0 ;
  fsParams.Clear ;
end;

function TACBrECFFiscNETComando.GetComando: AnsiString;
Var I : Integer ;
begin
  Result := '{'+IntToStr(fsCont)+';'+fsNomeComando+';' ;

  For I := 0 to fsParams.Count-1 do
    Result := Result + Trim(fsParams[I]) + ' ';
  Result := Trim(Result) ;

  Result := Result + ';'+IntToStr(Length(Result))+'}' ;
end;

procedure TACBrECFFiscNETComando.AddParamString(ParamName: String;
  AString: AnsiString);
var
  Buf : AnsiString ;
begin
  if AString = '' then exit ;

  AString := StringReplace(AString,'\','\\',[rfReplaceAll]) ;
  AString := StringReplace(AString,'"','\"',[rfReplaceAll]) ;
  { Restaurando caracteres de controle }
  AString := StringReplace(AString,'\\x','\x',[rfReplaceAll]) ;

  Buf := BinaryStringToString(AString);

  fsParams.Add( ParamName + '="' + TrimRight( Buf ) + '"' ) ;
end;

procedure TACBrECFFiscNETComando.AddParamDouble(ParamName: String;
  ADouble: Double);
 Var AFloatStr : String ;
begin
  ADouble   := RoundTo(ADouble,-4) ; // FiscNet aceita no m�ximo 4 casas decimais
  AFloatStr := FloatToStr(ADouble) ;
  // FiscNET sempre usar "," como separador de decimal //
  AFloatStr := StringReplace(AFloatStr,DecimalSeparator,',',[rfReplaceAll]) ;
  fsParams.Add(ParamName + '=' + AFloatStr ) ;
end;

procedure TACBrECFFiscNETComando.AddParamInteger(ParamName: String;
  AInteger: Integer);
begin
  fsParams.Add(ParamName + '=' + IntToStr(AInteger) )
end;

procedure TACBrECFFiscNETComando.AddParamBool(ParamName: String;
  ABool: Boolean);
Var CharBool : Char ;
begin
  if ABool then CharBool := 't' else CharBool := 'f' ;

  fsParams.Add(ParamName + '=' + CharBool )
end;

Procedure TACBrECFFiscNETComando.AddParamDateTime(ParamName : String;
  ADateTime: TDateTime;Tipo : Char = 'D'  ) ;
Var Texto : String ;
begin
  if Tipo in ['T','H'] then
     Texto := FormatDateTime('hh:nn:ss',ADateTime)
  else
     Texto := FormatDateTime('dd/mm/yyyy',ADateTime) ;

  fsParams.Add(ParamName + '=' + '#'+Texto+'#' )
end;

{ ------------------------- TACBrECFFiscNETResposta -------------------------- }

constructor TACBrECFFiscNETResposta.create;
begin
  inherited create ;

  fsParams     := TStringList.create ;
  fsCont       := 0 ;
  fsCodRetorno := 0;
  fsTamanho    := 0;
  fsResposta   := '' ;
end;

destructor TACBrECFFiscNETResposta.destroy;
begin
  fsParams.Free ;
  inherited destroy ;
end;

procedure TACBrECFFiscNETResposta.SetResposta(const Value: AnsiString);
Var Buf : AnsiString ;
    P,I : Integer ;
    Param : AnsiString ;
    CharAposIgual : AnsiChar ;
begin
  fsParams.Clear ;
  fsCont       := 0 ;
  fsCodRetorno := 0;
  fsTamanho    := 0;
  fsResposta   := '' ;

  if Value = '' then exit ;

  fsResposta := Value ;
  Buf        := copy(fsResposta,2,Length(fsResposta)-2) ;  //  Remove "{"  "}"

  P := PosLast(';',Buf) ;
  fsTamanho := StrToIntDef(copy(Buf,P+1,Length(Buf)),0) ;
  Buf       := copy(Buf,1,P-1) ;  // Remove tamanho

  P := pos(';',Buf) ;
  try
     fsCont := StrToInt( copy(Buf,1,(P-1)) ) ;
  except
     raise Exception.Create(ACBrStr('Num.Identifica��o inv�lido')) ;
  end ;
  Buf := copy(Buf,P+1,Length(Buf)) ;  // Remove a Ident.

  P := pos(';',Buf) ;
  try
     fsCodRetorno := StrToInt( copy(Buf,1,(P-1)) ) ;
  except
     raise Exception.Create(ACBrStr('Cod.Retorno inv�lido')) ;
  end ;
  Buf := Trim(copy(Buf,P+1,Length(Buf))) ;  // Remove Retorno

  if Buf = '' then
     exit ;

  Buf := StringReplace(Buf,'\"','\x22',[rfReplaceAll]) ;  // Tira aspas internas
  // Tem Parametros ? //
  P := pos('=',Buf) ;
  while P > 0 do
  begin
     try
        CharAposIgual := Buf[P+1] ;
        case CharAposIgual of
           '#' : P := PosAt('#',Buf,2) ;
           '"' : P := PosAt('"',Buf,2) ;
        else
           P := Pos(' ',Buf) ;
        end ;
     except
        CharAposIgual := ' ';
        P := 0 ;
     end ;

     if P = 0 then
        P := Length(Buf) ;

     Param := Trim(copy(Buf,1,P)) ;
     Buf   := Trim(copy(Buf,P+1,Length(Buf))) ;  // Restante

     if CharAposIgual in ['"','#'] then   // � parametro Texto ou Data/Hora ?
     begin
        I := pos('=',Param) ;
        { removendo as " ou # }
        Param := copy(Param,1,I) + copy(Param,I+2,(Length(Param)-I-2) ) ;

        { Verificando por codigos em Hexa }
        Param := StringToBinaryString(Param);
     end ;

     fsParams.Add(Param) ;

     P := pos('=',Buf) ;
  end ;
end;

{ ----------------------------- TACBrECFFiscNET ----------------------------- }

constructor TACBrECFFiscNET.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fsFiscNETComando   := TACBrECFFiscNETComando.create ;
  fsFiscNETResposta  := TACBrECFFiscNETResposta.create ;

  fpDevice.HandShake := hsRTS_CTS ;
  fpDevice.Baud      := 115200 ;
  fpDevice.Parity    := pEven ;

  (*
     Para funcionar na TermoPrinter use as configura��es abaixo...
     Vc pode programar essas caracteristicas em tempo de execu��o no
     ACBrECF.Device ap�s ajustar o Modelo e antes de Ativar... Exemplo:

     ACBrECF1.Modelo           := ecfFiscNET ;
     ACBrECF1.Device.Baud      := 9600 ;
     ACBrECF1.Device.Parity    := pNone ;
     ACBrECF1.Device.HandShake := hsDTR_DSR ;
     ACBrECF1.Ativar ;
  *)


  { Variaveis internas dessa classe }
  fsNumVersao := '' ;
  fsNumECF    := '' ;
  fsNumLoja   := '' ;
  fsArredonda := -1 ;
  fsComandoVendeItem := '' ;
  fpModeloStr := 'FiscNET' ;
  fpColunas   := 57 ;
  fpMFD       := True ;
  fpTermica   := True ;
  fpIdentificaConsumidorRodape := True ;

  { Criando Lista de String com comandos de Impressao a Remover de Leituras }
  fsComandosImpressao[0]  := #27 + 'E1';
  fsComandosImpressao[1]  := #27 + 'E0';
  fsComandosImpressao[2]  := #27 + 'E';
  fsComandosImpressao[3]  := #27 + 'F';
  fsComandosImpressao[4]  := #27 + '!(';
  fsComandosImpressao[5]  := #27 + '!' + #1 ;
  fsComandosImpressao[6]  := #27 + '!' + #2 ;
  fsComandosImpressao[7]  := #27 + 'W1';
  fsComandosImpressao[8]  := #27 + 'W0';
  fsComandosImpressao[9]  := #30 ;
end;

destructor TACBrECFFiscNET.Destroy;
begin
  fsFiscNETComando.Free ;
  fsFiscNETResposta.Free ;

  inherited Destroy ;
end;

procedure TACBrECFFiscNET.Ativar;
begin
  if not fpDevice.IsSerialPort  then
     raise Exception.Create(ACBrStr('A impressora: '+fpModeloStr+' requer'+sLineBreak+
                            'Porta Serial:  (COM1, COM2, COM3, ...)'));

  inherited Ativar ; { Abre porta serial }

  fsNumVersao := '' ;
  fsNumECF    := '' ;
  fsNumLoja   := '' ;
  fsArredonda := -1 ;
  fsComandoVendeItem := '' ;

  { FiscNET sempre aceita at� 3 decimais na QTD e PrecoUnit }
  fpDecimaisQtd   := 3 ;
  fpDecimaisPreco := 3 ;

  try
     if NumVersao = '' then
        raise EACBrECFNaoInicializado.Create( ACBrStr(
                 'Erro inicializando a impressora '+fpModeloStr ));

     FiscNETComando.NomeComando := 'LeTexto' ;
     FiscNETComando.AddParamString('NomeTexto','Marca') ;
     EnviaComando ;
     fpModeloStr := 'FiscNET: '+ FiscNETResposta.Params.Values['ValorTexto'] ;

     FiscNETComando.NomeComando := 'LeTexto';
     FiscNETComando.AddParamString('NomeTexto','Modelo');
     EnviaComando;
     fpModeloStr := fpModeloStr + ' - ' + FiscNETResposta.Params.Values['ValorTexto'] ;
     // Ajuste de Colunas na ThermoPrinter, por Fabio Farias //
     if FiscNETResposta.Params.Values['ValorTexto']='TPF2001' then
        fpColunas := 40;

  except
     Desativar ;
     raise ;
  end ;
end;


Function TACBrECFFiscNET.EnviaComando_ECF( cmd : AnsiString = '' ) : AnsiString ;
Var ErroMsg : String ;
    OldTimeOut : Integer ;
begin
  if cmd <> '' then
     cmd := PreparaCmd(cmd) ;  // Ajusta e move para FiscNETcomando

  cmd := FiscNETComando.Comando ;

  Result  := '' ;
  ErroMsg := '' ;
  fpComandoEnviado   := '' ;
  fpRespostaComando  := '' ;
  FiscNETResposta.Resposta := '' ;
  OldTimeOut := TimeOut ;
  TimeOut    := max(FiscNETComando.TimeOut, TimeOut) ;

  try
     fpDevice.Serial.DeadlockTimeout := 2000 ; { Timeout p/ Envio }
     fpDevice.Serial.Purge ;                   { Limpa a Porta }

     while fpComandoEnviado = '' do
     begin
        fpDevice.Serial.Purge ;                   { Limpa a Porta }

        if not TransmiteComando( cmd ) then
           continue ;

        fpComandoEnviado := cmd ;
     end ;

     { Chama Rotina da Classe m�e TACBrClass para ler Resposta. Se houver
       falha na leitura LeResposta dispara Exce�ao.
       Resposta fica gravada na v�riavel "fpRespostaComando" }
     LeResposta ;

     Try
        FiscNETResposta.Resposta := fpRespostaComando ;

        ErroMsg := '' ;
        if FiscNETResposta.CodRetorno > 0 then
           ErroMsg := 'Erro: '+IntToStr(FiscNETResposta.CodRetorno) + ' - ' +
                      FiscNETResposta.Params.Values['NomeErro'] + #10 +
                      FiscNETResposta.Params.Values['Circunstancia'] ;
     except
        ErroMsg := 'Resposta do ECF inv�lida' ;
     end ;

     if ErroMsg <> '' then
      begin
        ErroMsg := ACBrStr('Erro retornado pela Impressora: '+fpModeloStr+#10+#10+
                   ErroMsg ) ;
        raise EACBrECFSemResposta.create(ErroMsg) ;
      end
     else
        Sleep( IntervaloAposComando ) ;  { Pequena pausa entre comandos }

  finally
     TimeOut := OldTimeOut ;
  end ;
end;

function TACBrECFFiscNET.PreparaCmd(cmd: AnsiString): AnsiString;
Var P : Integer ;
begin
  P := pos(';',cmd) ;
  if P = 0 then
     P := Length(cmd)+1 ;
  FiscNETComando.NomeComando := copy(cmd,1,P-1) ;
  FiscNETComando.Params.Text := copy(cmd,P+1,Length(cmd)) ;
end;

Function TACBrECFFiscNET.VerificaFimLeitura(var Retorno: AnsiString;
   var TempoLimite: TDateTime) : Boolean ;
begin
  Result := (RightStr(Retorno,1) = '}') and (CountStr(Retorno,';') >= 3) ; 
end;

function TACBrECFFiscNET.GetDataHora: TDateTime;
Var RetCmd : AnsiString ;
    OldShortDateFormat : String ;
begin
  FiscNETComando.NomeComando := 'LeData' ;
  FiscNETComando.AddParamString('NomeData','Data');
  EnviaComando ;
  RetCmd := FiscNETResposta.Params.Values['ValorData'] ;
  RetCmd := StringReplace(RetCmd ,'/',DateSeparator, [rfReplaceAll] );
  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yyyy' ;
     Result := StrToDate( RetCmd ) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;

  try
     FiscNETComando.NomeComando := 'LeHora' ;
     FiscNETComando.AddParamString('NomeHora','Hora');
     EnviaComando ;
     RetCmd := FiscNETResposta.Params.Values['ValorHora'] ;
  except
     if fsNumVersao = '01.00.01' then   // Versao 01.00.01 da TermoPrinter n�o l� hora
        RetCmd := FormatDateTime('hh:mm:ss',Now)
     else
        raise ;
  end ;

  Result := RecodeHour(  Result,StrToInt(copy(RetCmd,1,2))) ;
  Result := RecodeMinute(Result,StrToInt(copy(RetCmd,4,2))) ;
  Result := RecodeSecond(Result,StrToInt(copy(RetCmd,7,2))) ;
end;

function TACBrECFFiscNET.GetNumCupom: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','COO') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetNumCCF: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','CCF') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetNumCRO: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','CRO') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetNumGRG: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','GRG') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetNumGNF: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','GNF') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetNumCDC: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','CDC') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;


function TACBrECFFiscNET.GetNumLoja: String;
begin
  if fsNumLoja = '' then
  begin
     FiscNETComando.NomeComando := 'LeInteiro' ;
     FiscNETComando.AddParamString('NomeInteiro','Loja') ;
     EnviaComando ;

     fsNumLoja := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 3) ;
  end ;

  Result := fsNumLoja ;
end;

function TACBrECFFiscNET.GetNumECF: String;
begin
  if fsNumECF = '' then
  begin
     FiscNETComando.NomeComando := 'LeInteiro' ;
     FiscNETComando.AddParamString('NomeInteiro','ECF') ;
     EnviaComando ;

     fsNumECF := IntToStrZero(  StrToIntDef(
                     FiscNETResposta.Params.Values['ValorInteiro'],0 ), 4) ;
  end ;

  Result := fsNumECF ;
end;

function TACBrECFFiscNET.GetNumSerie: String;
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto','NumeroSerieECF') ;
  EnviaComando ;

  Result := FiscNETResposta.Params.Values['ValorTexto'] ;
end;

function TACBrECFFiscNET.GetNumVersao: String ;
begin
  if fsNumVersao = '' then
  begin
     FiscNETComando.NomeComando := 'LeTexto' ;
     FiscNETComando.AddParamString('NomeTexto','VersaoSW') ;
     EnviaComando ;

     fsNumVersao := FiscNETResposta.Params.Values['ValorTexto'] ;
  end ;

  Result := fsNumVersao ;
end;

function TACBrECFFiscNET.GetTotalPago: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDocValorPago') ;
  EnviaComando ;

  Result := StringToFloatDef(
               RemoveString('.',FiscNETResposta.Params.Values['ValorMoeda']), 0) ;
end;

function TACBrECFFiscNET.GetSubTotal: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDocLiquido') ;
  EnviaComando ;

  Result := StringToFloatDef(
               RemoveString('.',FiscNETResposta.Params.Values['ValorMoeda']), 0) ;
end;


{  Ordem de Retorno do Estado da Impressora
   estNaoInicializada - N�o Inicializada (Nova)
   estDesconhecido    - Desconhecido
   estPagamento       - Cupom Venda Aberto em Pagamento
   estVenda           - Cupom Venda Aberto em Itens
   estNaoFiscal       - Cupom N�o Fiscal Aberto
   estRelatorio       - Cupom Vinculado Aberto | Relat�rio Gerencial Aberto
   estBloqueada       - Impressora Bloqueada para venda
   estRequerZ         - Requer Emiss�o da Redu��o da Z
   estRequerX         - Requer Leitura X
   estLivre           - Livre para vender
}
function TACBrECFFiscNET.GetEstado: TACBrECFEstado;
Var Est, Ind : Integer ;
begin
  Result := fpEstado ;  // Suprimir Warning
  try
    fpEstado := estNaoInicializada ;
    if (not fpAtivo) then
      exit ;

    fpEstado := estDesconhecido ;

    FiscNETComando.NomeComando := 'LeInteiro' ;
    FiscNETComando.AddParamString('NomeInteiro','EstadoFiscal') ;
    EnviaComando ;

    Est := StrToIntDef( FiscNETResposta.Params.Values['ValorInteiro'] ,0) ;

    case Est of
      1      : fpEstado := estLivre ;
      2      : fpEstado := estVenda ;
      4,8,16 : fpEstado := estPagamento ;
      32,64  : fpEstado := estRelatorio ;
      128    : fpEstado := estNaoFiscal ;
    end ;

    if fpEstado in [estDesconhecido, estLivre] then
    begin
      FiscNETComando.NomeComando := 'LeInteiro' ;
      FiscNETComando.AddParamString('NomeInteiro','Indicadores') ;
      EnviaComando ;
      Ind := StrToIntDef( FiscNETResposta.Params.Values['ValorInteiro'] ,0) ;

      if TestBit(Ind,5) then
         fpEstado := estBloqueada

      else if TestBit(Ind,7) then
         fpEstado := estRequerZ

//    else if not TestBit(Ind,6) then
//       fpEstado := estRequerX

    end ;
  finally
    Result := fpEstado ;
  end ;
end;

function TACBrECFFiscNET.GetGavetaAberta: Boolean;
begin
  FiscNETComando.NomeComando := 'LeIndicador' ;
  FiscNETComando.AddParamString('NomeIndicador','SensorGaveta') ;
  EnviaComando ;

  Result := (FiscNETResposta.Params.Values['ValorNumericoIndicador'] = '1');
end;

function TACBrECFFiscNET.GetPoucoPapel: Boolean;
begin
  try
     FiscNETComando.NomeComando := 'LeIndicador' ;
     FiscNETComando.AddParamString('NomeIndicador','SensorPoucoPapel') ;
     EnviaComando ;
     Result := (FiscNETResposta.Params.Values['ValorNumericoIndicador'] = '1');
  except
     if fsNumVersao = '01.00.01' then   // Versao 01.00.01 da TermoPrinter n�o l� SensorPoucoPapel
        Result := False
     else
        raise ;
  end ;
end;

function TACBrECFFiscNET.GetHorarioVerao: Boolean;
begin
  try
     FiscNETComando.NomeComando := 'LeIndicador' ;
     FiscNETComando.AddParamString('NomeIndicador','HorarioVerao') ;
     EnviaComando ;
     Result := (FiscNETResposta.Params.Values['ValorNumericoIndicador'] = '1') ;
  except
     if fsNumVersao = '01.00.01' then   // Versao 01.00.01 da TermoPrinter n�o l� HorarioVerao
        Result := False
     else
        raise ;
  end ;
end;

Procedure TACBrECFFiscNET.LeituraX ;
begin
  FiscNETComando.NomeComando := 'EmiteLeituraX' ;
  FiscNETComando.TimeOut     := 30 ;
  FiscNETComando.AddParamString('Destino','I') ;
  FiscNETComando.AddParamString('Operador',Operador) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.LeituraXSerial(Linhas: TStringList);
Var
  Leitura, RetCmd : AnsiString ;
begin
  with FiscNETComando do
  begin
     NomeComando := 'EmiteLeituraX' ;
     AddParamString('Destino','S') ;
     AddParamString('Operador',Operador) ;
  end ;
  FiscNETComando.TimeOut := 10 ;
  EnviaComando ;
  Sleep(500);

  Leitura := '' ;
  Linhas.Clear ;
  repeat
     FiscNETComando.NomeComando := 'LeImpressao' ;
     EnviaComando ;

     RetCmd  := FiscNETResposta.Params.Values['TextoImpressao'] ;
     Leitura := Leitura + RetCmd ;
     sleep(100) ;
  until (RetCmd = '') ;

  Linhas.Text := AjustaLeitura( Leitura );
end;


Procedure TACBrECFFiscNET.AbreGaveta ;
begin
  FiscNETComando.NomeComando := 'AbreGaveta' ;
  EnviaComando ;
end;

Procedure TACBrECFFiscNET.ReducaoZ(DataHora: TDateTime) ;
begin
  FiscNETComando.NomeComando := 'EmiteReducaoZ' ;
  FiscNETComando.TimeOut     := 900 ;
  if DataHora <> 0 then
     FiscNETComando.AddParamDateTime('Hora',DataHora,'T') ;
  FiscNETComando.AddParamString('Operador',Operador) ;

  try
     EnviaComando ;
  except
     on E : Exception do
     begin
        if (pos('8092',E.Message) <> 0) then   // Erro de Hora fora da faixa ?
           ReducaoZ(0)                         // Tenta sem DataHora
        else
           raise ;
     end ;
  end ;
end;

Procedure TACBrECFFiscNET.MudaHorarioVerao ;
begin
  MudaHorarioVerao( not HorarioVerao ) ;
end;

procedure TACBrECFFiscNET.MudaHorarioVerao(EHorarioVerao: Boolean);
begin
  FiscNETComando.NomeComando := 'AcertaHorarioVerao' ;
  FiscNETComando.AddParamInteger('EntradaHV', IfThen(EHorarioVerao,1,0)) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.AbreCupom ;
begin
  FiscNETComando.NomeComando := 'AbreCupomFiscal' ;
  FiscNETComando.TimeOut     := 10 ;
  FiscNETComando.AddParamString('IdConsumidor',LeftStr(Consumidor.Documento,29)) ;
  if Consumidor.Nome <> '' then
     FiscNETComando.AddParamString('NomeConsumidor',LeftStr(Consumidor.Nome,30)) ;
  if Consumidor.Nome <> '' then
     FiscNETComando.AddParamString('EnderecoConsumidor',LeftStr(Consumidor.Endereco,80)) ;
  EnviaComando ;
  Consumidor.Enviado := True ;
end;

procedure TACBrECFFiscNET.CancelaCupom;
  Var Erro : String ;
      CCD  : Integer ;
begin
  try
     FiscNETComando.NomeComando := 'CancelaCupom' ;
     FiscNETComando.TimeOut     := 30 ;
     FiscNETComando.AddParamString('Operador',Operador) ;
     EnviaComando ;
  except
     on E : Exception do
     begin
        Erro := E.Message ;
        CCD  := StrToIntDef(NumCupom,0) ;

        // 8000 - ErroCMDForaDeSequencia
        // 8086 - ErroCMDCancelamentoInvalido
        // Todos CCD�s vinculados ao cupom devem ser estornados antes da operacao de cancelamento
        while {pos('CCD',Erro) <> 0) and }((pos('8000',Erro) <> 0) or (pos('8086',Erro) <> 0) ) do
        begin
           try
              Erro := '' ;
              FiscNETComando.NomeComando := 'EstornaCreditoDebito' ;
              FiscNETComando.AddParamInteger('COO',CCD) ;
              EnviaComando ;

              Dec(CCD);

              FiscNETComando.NomeComando := 'EncerraDocumento' ;
              FiscNETComando.AddParamString('Operador',Operador) ;
              EnviaComando ;

              FiscNETComando.NomeComando := 'CancelaCupom' ;
              FiscNETComando.AddParamString('Operador',Operador) ;
              EnviaComando ;
           except
              on E : Exception do
                 Erro := E.Message ;
           end ;
        end ;
     end ;
  end ;

  if Erro <> '' then
     raise Exception.create(Erro);
     
  FechaRelatorio ;   { Fecha relatorio se ficou algum aberto (s� por garantia)}
end;

procedure TACBrECFFiscNET.CancelaItemVendido(NumItem: Integer);
begin
  FiscNETComando.NomeComando := 'CancelaItemFiscal' ;
  FiscNETComando.AddParamInteger('NumItem',NumItem) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: AnsiString; ImprimeVinculado: Boolean);
begin
  FiscNETComando.NomeComando := 'PagaCupom' ;
  FiscNETComando.AddParamInteger('CodMeioPagamento', StrToInt(CodFormaPagto)) ;
  FiscNETComando.AddParamString('TextoAdicional',Observacao) ;
  FiscNETComando.AddParamDouble('Valor',Valor) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.FechaCupom(Observacao: AnsiString; IndiceBMP : Integer);
Var Obs : AnsiString ;
begin
  Obs := Observacao ;
  if not Consumidor.Enviado then
  begin
     { Removendo o Consumidor da Observa��o, pois vai usar comando pr�prio }
     Obs := StringReplace(Obs,#10+'CPF/CNPJ consumidor: '+Consumidor.Documento,'',[]) ;
     Obs := StringReplace(Obs,#10+'Nome: '+Consumidor.Nome,'',[]) ;
     Obs := StringReplace(Obs,#10+'Endereco: '+Consumidor.Endereco,'',[]) ;
     try
        { Se tiver Observa��es no rodape, deve enviar antes do consumidor }
        if Obs <> '' then
        begin
           FiscNETComando.NomeComando := 'ImprimeTexto' ;
           FiscNETComando.AddParamString('TextoLivre',Obs);
           EnviaComando ;
           Obs := '' ;
        end ;

        FiscNETComando.NomeComando := 'IdentificaConsumidor' ;
        FiscNETComando.AddParamString('IdConsumidor',LeftStr(Consumidor.Documento,29)) ;
        if Consumidor.Nome <> '' then
           FiscNETComando.AddParamString('NomeConsumidor',LeftStr(Consumidor.Nome,30)) ;
        if Consumidor.Nome <> '' then
           FiscNETComando.AddParamString('EnderecoConsumidor',LeftStr(Consumidor.Endereco,80)) ;
        EnviaComando ;
        Consumidor.Enviado := True ;
     except
//        Obs := Observacao ;
     end ;
  end ;

  FiscNETComando.NomeComando := 'EncerraDocumento' ;
  FiscNETComando.TimeOut     := 5 ;
  FiscNETComando.AddParamString('Operador',Operador) ;
  if Obs <> '' then
     FiscNETComando.AddParamString('TextoPromocional',Obs) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.SubtotalizaCupom(DescontoAcrescimo: Double;
       MensagemRodape : AnsiString);
begin
  if DescontoAcrescimo = 0 then
     exit ;
  FiscNETComando.NomeComando := 'AcresceSubtotal' ;
  FiscNETComando.AddParamBool('Cancelar',False) ;
  FiscNETComando.AddParamDouble('ValorAcrescimo',DescontoAcrescimo) ;
  EnviaComando ;
end;

Procedure TACBrECFFiscNET.VendeItem( Codigo, Descricao : String;
  AliquotaECF : String; Qtd : Double ; ValorUnitario : Double;
  ValorDescontoAcrescimo : Double; Unidade : String;
  TipoDescontoAcrescimo : String; DescontoAcrescimo : String) ;
 Var CodAliq : Integer ;
begin
  Unidade := padL(Unidade,2) ;

  try
     CodAliq := StrToInt(AliquotaECF) ;
  except
     raise EACBrECFCMDInvalido.Create(ACBrStr('Aliquota Inv�lida: '+AliquotaECF));
  end ;

  try
    with FiscNETComando do
    begin
       if fsComandoVendeItem = '' then
          NomeComando := 'VendeItem'
       else
          NomeComando := fsComandoVendeItem ;
          
       AddParamInteger('CodAliquota',CodAliq) ;
       AddParamString('CodProduto',LeftStr(Codigo,48));
       AddParamString('NomeProduto',LeftStr(Descricao,200));
       AddParamDouble('PrecoUnitario',ValorUnitario);
       AddParamDouble('Quantidade',Qtd);
       AddParamString('Unidade',Unidade);
    end ;
    EnviaComando ;
  except
     on E : Exception do
     begin
        if (fsComandoVendeItem = '') and
           (pos('ComandoInexistente',E.Message) > 0) then   // N�o reconheceu o comando
         begin
           fsComandoVendeItem := 'VendaDeItem' ;
           VendeItem( Codigo,Descricao,AliquotaECF,Qtd,ValorUnitario,
                      ValorDescontoAcrescimo,Unidade,TipoDescontoAcrescimo,
                      DescontoAcrescimo );
         end
        else
           raise ;
     end ;
  end ;

  { Se o desconto � maior que zero d� o comando de desconto de item }
  if ValorDescontoAcrescimo > 0 then
  begin
     if DescontoAcrescimo = 'D' then
        ValorDescontoAcrescimo := -ValorDescontoAcrescimo ;

     FiscNETComando.NomeComando := 'AcresceItemFiscal' ;
     if TipoDescontoAcrescimo = '%' then
        FiscNETComando.AddParamDouble('ValorPercentual',ValorDescontoAcrescimo)
     else
        FiscNETComando.AddParamDouble('ValorAcrescimo',ValorDescontoAcrescimo);
     FiscNETComando.AddParamBool('Cancelar',False);
     EnviaComando ;
  end;
end;

procedure TACBrECFFiscNET.CarregaAliquotas;
var
  A        : Integer;
  Aliquota : TACBrECFAliquota ;
  ValAliq  : Double ;
  TipoAliq : Char ;
  Erro     : Boolean ;
begin
  inherited CarregaAliquotas ;   { Cria fpAliquotas }

  { L� as al�quotas cadastradas na impressora }
  A    := 0 ;
  Erro := False ;
  while (A <= 15) and (not Erro) do
  begin
     FiscNETComando.NomeComando := 'LeAliquota' ;
     FiscNETComando.AddParamInteger('CodAliquotaProgramavel',A) ;
     try
        EnviaComando ;

        ValAliq  := StringToFloat(
                         FiscNETResposta.Params.Values['PercentualAliquota'] );
        if UpCase(
            FiscNETResposta.Params.Values['AliquotaICMS'][1]) in ['F','N'] then
           TipoAliq := 'S'
        else
           TipoAliq := 'T' ;
        Aliquota          := TACBrECFAliquota.create ;
        Aliquota.Indice   :=
            FiscNETResposta.Params.Values['CodAliquotaProgramavel'] ;
        Aliquota.Aliquota := ValAliq ;
        Aliquota.Tipo     := TipoAliq ;

        fpAliquotas.Add( Aliquota ) ;
     except
        on E : Exception do
        begin
           Erro := (pos('ErroCMDAliquotaNaoCarregada',E.Message) = 0)
        end ;
     end;

     Inc( A ) ;
  end;

  if Erro then   { "niliza" para tentar carregar novamente no futuro }
  begin
     fpAliquotas.Free ;
     fpAliquotas := nil ;
  end ;
end;

procedure TACBrECFFiscNET.LerTotaisAliquota;
Var A : Integer ;
begin
  if not Assigned( fpAliquotas ) then
     CarregaAliquotas ;

  For A := 0 to Aliquotas.Count-1 do
  begin
     FiscNETComando.NomeComando := 'LeMoeda' ;
     FiscNETComando.AddParamString('NomeDadoMonetario',
                               'TotalDiaValorAliquota['+Trim(Aliquotas[A].indice)+']') ;
     EnviaComando ;

     Aliquotas[A].Total := StringToFloatDef(
        RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda']), 0) ;
  end ;   
end;


procedure TACBrECFFiscNET.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String);
Var AliqECF  : TACBrECFAliquota ;
    Descr    : String ;
begin
  Tipo := UpCase(Tipo) ;
  if not (Tipo in ['T','S']) then
     Tipo := 'T' ;

  if Tipo = 'T' then
     Descr := 'ICMS: '
  else
     Descr := 'ISS: ' ;
  Descr := Descr + FloatToStr(Aliquota)+'%' ;

  with FiscNETComando do
  begin
     NomeComando := 'DefineAliquota' ;
     AddParamBool('AliquotaICMS',(Tipo = 'T')) ;
     AddParamInteger('CodAliquotaProgramavel', StrToIntDef(Posicao,-1) ) ;
     AddParamString('DescricaoAliquota', Descr)  ;
     AddParamDouble('PercentualAliquota',Aliquota);
  end ;
  EnviaComando ;

  { Adicionanodo nova Aliquota no ObjectList }
  if Assigned( fpAliquotas ) then
  begin
     AliqECF          := TACBrECFAliquota.create ;
     AliqECF.Indice   := FiscNETResposta.Params.Values['CodAliquotaProgramavel'] ;
     AliqECF.Aliquota := Aliquota ;
     AliqECF.Tipo     := Tipo ;

     fpAliquotas.Add( AliqECF ) ;
  end ;
end;

function TACBrECFFiscNET.AchaICMSAliquota( var AliquotaICMS: String):
   TACBrECFAliquota;
  Var AliquotaStr : String ;
begin
  AliquotaStr := '' ;
  Result      := nil ;

  if copy(AliquotaICMS,1,2) = 'SF' then
     AliquotaStr := '-11'
  else if copy(AliquotaICMS,1,2) = 'SN' then
     AliquotaStr := '-13'
  else if copy(AliquotaICMS,1,2) = 'SI' then
     AliquotaStr := '-12'
  else
     case AliquotaICMS[1] of
        'F' : AliquotaStr := '-2' ;
        'I' : AliquotaStr := '-3' ;
        'N' : AliquotaStr := '-4' ;
        'T' :
           try
              AliquotaICMS := 'T'+IntToStr(StrToInt(copy(AliquotaICMS,2,2))) ; {Indice}
           except
               raise EACBrECFCMDInvalido.Create(ACBrStr('Aliquota Inv�lida: '+AliquotaICMS));
           end ;
     end ;

  if AliquotaStr = '' then
     Result := inherited AchaICMSAliquota( AliquotaICMS )
  else
     AliquotaICMS := AliquotaStr ;
end;


procedure TACBrECFFiscNET.CarregaFormasPagamento;
  Function SubCarregaFormasPagamento(Indice : Integer) : Boolean ;
    var FPagto : TACBrECFFormaPagamento ;
  begin
     Result := True ;
     FiscNETComando.NomeComando := 'LeMeioPagamento' ;
     FiscNETComando.AddParamInteger('CodMeioPagamentoProgram',Indice) ;
     try
        EnviaComando ;

        FPagto := TACBrECFFormaPagamento.create ;
        FPagto.Indice :=
            FiscNETResposta.Params.Values['CodMeioPagamentoProgram'] ;
        FPagto.Descricao := FiscNETResposta.Params.Values['NomeMeioPagamento'] ;
        FPagto.PermiteVinculado := ( UpCase(
           FiscNETResposta.Params.Values['PermiteVinculado'][1]) in ['T','Y']) ;

        fpFormasPagamentos.Add( FPagto ) ;
     except
        on E : Exception do
        begin
           Result := (pos('ErroCMDFormaPagamentoIndefinida',E.Message) <> 0)
        end ;
     end;
  end ;

Var A    : Integer;
    Erro : Boolean ;
begin
  inherited CarregaFormasPagamento ;   { Cria fpFormasPagamentos }

  Erro :=  not SubCarregaFormasPagamento(-2) ; { Le Forma Padr�o (fixa) -2 = Dinheiro }

  { L� as Formas de Pagamento cadastradas na impressora }
  A := 0 ;
  while (A <= 14) and (not Erro) do
  begin
     Erro := not SubCarregaFormasPagamento(A);
     Inc( A )
  end ;

  if Erro then   { "niliza" para tentar carregar novamente no futuro }
  begin
     fpFormasPagamentos.Free ;
     fpFormasPagamentos := nil ;
  end ;
end;

procedure TACBrECFFiscNET.LerTotaisFormaPagamento;
Var A : Integer ;
begin
  if not Assigned( fpFormasPagamentos ) then
     CarregaFormasPagamento ;

  For A := 0 to FormasPagamento.Count-1 do
  begin
     FiscNETComando.NomeComando := 'LeMoeda' ;
     if A = 0 then
        FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaDinheiro')
     else
        FiscNETComando.AddParamString('NomeDadoMonetario',
                                   'TotalDiaMeioPagamento['+IntToStrZero(A-1,2)+']');
     EnviaComando ;

     FormasPagamento[A].Total := StringToFloatDef(
        RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda']), 0) ;
  end ;
end;

procedure TACBrECFFiscNET.ProgramaFormaPagamento( var Descricao: String;
  PermiteVinculado : Boolean; Posicao : String) ;
var  FPagto: TACBrECFFormaPagamento ;
begin
  with FiscNETComando do
  begin
     NomeComando := 'DefineMeioPagamento' ;
     AddParamInteger('CodMeioPagamentoProgram', StrToIntDef(Posicao,-1) ) ;
     AddParamString('DescricaoMeioPagamento',Descricao) ;
     AddParamString('NomeMeioPagamento',Descricao) ;
     AddParamBool('PermiteVinculado',PermiteVinculado) ;
  end ;
  EnviaComando ;

  { Adicionanodo nova FPG no ObjectList }
  if Assigned( fpFormasPagamentos ) then
  begin
     FPagto := TACBrECFFormaPagamento.create ;
     FPagto.Indice    := FiscNETResposta.Params.Values['CodMeioPagamentoProgram'] ;
     FPagto.Descricao := Descricao ;
     FPagto.PermiteVinculado :=  PermiteVinculado ;

     fpFormasPagamentos.Add( FPagto ) ;
  end ;
end;

procedure TACBrECFFiscNET.CarregaComprovantesNaoFiscais;
Var A    : Integer ;
    CNF  : TACBrECFComprovanteNaoFiscal ;
    Erro : Boolean ;
begin
  inherited CarregaComprovantesNaoFiscais ;

  A    := 0 ;
  Erro := False ;
  while (A <= 14) and (not Erro) do
  begin
     FiscNETComando.NomeComando := 'LeNaoFiscal' ;
     FiscNETComando.AddParamInteger('CodNaoFiscal',A) ;
     try
        EnviaComando ;

        CNF := TACBrECFComprovanteNaoFiscal.create ;

        CNF.Indice    := FiscNETResposta.Params.Values['CodNaoFiscal'] ;
        CNF.Descricao := FiscNETResposta.Params.Values['NomeNaoFiscal'] ;

        fpComprovantesNaoFiscais.Add( CNF ) ;
     except
        on E : Exception do
        begin
           Erro := (pos('ErroCMDNaoFiscalIndefinido',E.Message) = 0)
        end ;
     end;

     Inc( A ) ;
  end ;

  if Erro then   { "niliza" para tentar carregar novamente no futuro }
  begin
     fpComprovantesNaoFiscais.Free ;
     fpComprovantesNaoFiscais := nil ;
  end ;
end;

procedure TACBrECFFiscNET.LerTotaisComprovanteNaoFiscal;
Var A : Integer ;
begin
  if not Assigned( fpComprovantesNaoFiscais ) then
     CarregaComprovantesNaoFiscais ;

  For A := 0 to ComprovantesNaoFiscais.Count-1 do
  begin
     FiscNETComando.NomeComando := 'LeMoeda' ;
     FiscNETComando.AddParamString('NomeDadoMonetario',
                                   'TotalDiaNaoFiscal['+IntToStrZero(A,2)+']');
     EnviaComando ;

     ComprovantesNaoFiscais[A].Total := StringToFloatDef(
        RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda']), 0) ;

     FiscNETComando.NomeComando := 'LeInteiro' ;
     FiscNETComando.AddParamString('NomeInteiro','CON['+IntToStrZero(A,2)+']');
     EnviaComando ;

     ComprovantesNaoFiscais[A].Contador := StrToIntDef(
         FiscNETResposta.Params.Values['ValorInteiro'], 0) ;
  end ;
end;

procedure TACBrECFFiscNET.ProgramaComprovanteNaoFiscal(var Descricao : String;
   Tipo: String; Posicao : String);
Var CNF : TACBrECFComprovanteNaoFiscal ;
begin
  with FiscNETComando do
  begin
     NomeComando := 'DefineNaoFiscal' ;
     AddParamInteger('CodNaoFiscal', StrToIntDef(Posicao,-1) ) ;
     AddParamString('DescricaoNaoFiscal',Descricao) ;
     AddParamString('NomeNaoFiscal',Descricao) ;
     AddParamBool('TipoNaoFiscal',
                  (not (UpCase(PadR(Tipo,1)[1]) in ['-','F','0'])) ) ;
  end ;
  EnviaComando ;

  { Adicionanodo novo CNF no ObjectList }
  if Assigned( fpComprovantesNaoFiscais ) then
  begin
     CNF := TACBrECFComprovanteNaoFiscal.create ;
     CNF.Indice    := FiscNETResposta.Params.Values['CodNaoFiscal'] ;
     CNF.Descricao := Descricao ;

     fpComprovantesNaoFiscais.Add( CNF ) ;
  end ;
end;

procedure TACBrECFFiscNET.AbreRelatorioGerencial(Indice: Integer = 0);
begin
  if Indice = 0 then
  begin
     try
        { Procurando por Relatorio Gerencial na posi��o informada na vari�vel Indice... Se nao achar, programa }
        FiscNETComando.NomeComando := 'LeGerencial' ;
        FiscNETComando.AddParamInteger('CodGerencial', Indice ) ;
        EnviaComando ;
     except
        { Se nao existir,  gera exce��o e nesse caso programa a posicao }
        FiscNETComando.NomeComando := 'DefineGerencial' ;
        FiscNETComando.AddParamInteger('CodGerencial', Indice ) ;
        FiscNETComando.AddParamString('DescricaoGerencial','Relatorio Gerencial') ;
        FiscNETComando.AddParamString('NomeGerencial','Relatorio Gerencial') ;
        EnviaComando ;
     end ;
  end ;

  FiscNETComando.NomeComando := 'AbreGerencial' ;
  FiscNETComando.TimeOut     := 5 ;
  FiscNETComando.AddParamInteger('CodGerencial', Indice ) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.LinhaRelatorioGerencial(Linha: AnsiString; IndiceBMP: Integer);
Var P, Espera : Integer ;
    Buffer : AnsiString ;
    MaxChars : Integer ;
begin
  Linha    := AjustaLinhas( Linha, Colunas );  { Formata as Linhas de acordo com "Coluna" }
  MaxChars := 492 ;  { FiscNet aceita no m�ximo 492 caract. por comando }

  while Length( Linha ) > 0 do
  begin
      P := Length( Linha ) ;
     if P > MaxChars then    { Acha o fim de Linha mais pr�ximo do limite m�ximo }
        P := PosLast(#10, LeftStr(Linha,MaxChars) ) ;

     if P = 0 then
        P := Colunas ;

     Buffer := copy( Linha, 1, P)  ;
     Espera := Trunc( CountStr( Buffer, #10 ) / 4) ;

     AguardaImpressao := (Espera > 3) ;
     FiscNETComando.NomeComando := 'ImprimeTexto' ;
     FiscNETComando.TimeOut     := Espera ;
     FiscNETComando.AddParamString('TextoLivre',Buffer);
     EnviaComando ;

     { ficou apenas um LF sozinho ? }
     if (P = Colunas) and (RightStr( Buffer, 1) <> #10) and
        (copy( Linha, P+1, 1) = #10) then
        P := P + 1 ;

     Linha  := copy( Linha, P+1, Length(Linha) ) ;   // O Restante
  end ;
end;

procedure TACBrECFFiscNET.AbreCupomVinculado(COO, CodFormaPagto,
   CodComprovanteNaoFiscal :  String; Valor : Double ) ;
Var FPG : TACBrECFFormaPagamento ;
begin
  FPG := AchaFPGIndice( CodFormaPagto ) ;

  if FPG = nil then
     raise Exception.create( ACBrStr('Forma de Pagamento: '+CodFormaPagto+
                             ' n�o foi cadastrada.') ) ;

  FiscNETComando.NomeComando := 'AbreCreditoDebito' ;
  FiscNETComando.TimeOut     := 5 ;
  FiscNETComando.AddParamInteger('CodMeioPagamento',
                                 StrToIntDef(CodFormaPagto,0)) ;
  FiscNETComando.AddParamInteger('COO', StrToIntDef(COO,0));
  FiscNETComando.AddParamDouble('Valor',Valor);
  EnviaComando ;
end;

procedure TACBrECFFiscNET.LinhaCupomVinculado(Linha: AnsiString);
begin
  LinhaRelatorioGerencial( Linha );
end;

procedure TACBrECFFiscNET.FechaRelatorio;
begin
  if Estado = estRelatorio then
  begin
     FiscNETComando.NomeComando := 'EncerraDocumento' ;
     FiscNETComando.TimeOut     := 5 ;
     FiscNETComando.AddParamString('Operador',Operador) ;
     EnviaComando ;
  end ;
end;

procedure TACBrECFFiscNET.PulaLinhas(NumLinhas: Integer);
begin
  if NumLinhas = 0 then
     NumLinhas := LinhasEntreCupons ;

  { Alguem sabe quantos Dots tem 1 linha impressa ?? (no manual n�o consta :) )
    Estou considerando que uma Linha tem 30 dots }

  FiscNETComando.NomeComando := 'AvancaPapel' ;
  FiscNETComando.AddParamInteger('Avanco',NumLinhas * 30) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.CortaPapel(const CorteParcial: Boolean);
 Var TipoCorte : Integer ;
begin
// Autor: Nei Jos� Van Lare Junior

  if CorteParcial then
     TipoCorte := 1
  else
     TipoCorte := 0 ;

  FiscNETComando.NomeComando := 'CortaPapel';
  FiscNETComando.AddParamInteger('TipoCorte', TipoCorte);
  EnviaComando;
end;


procedure TACBrECFFiscNET.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal : Integer; Simplificada : Boolean);
begin
  with FiscNETComando do
  begin
     NomeComando := 'EmiteLeituraMF' ;
     AddParamString('Destino','I') ;
     AddParamBool('LeituraSimplificada',Simplificada);
     AddParamString('Operador',Operador) ;
     AddParamInteger('ReducaoFinal',ReducaoFinal) ;
     AddParamInteger('ReducaoInicial',ReducaoInicial) ;
  end ;
  FiscNETComando.TimeOut := 30 + (ReducaoFinal - ReducaoInicial) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.LeituraMemoriaFiscal(DataInicial,
   DataFinal: TDateTime; Simplificada : Boolean);
begin
  with FiscNETComando do
  begin
     NomeComando := 'EmiteLeituraMF' ;
     AddParamDateTime('DataFinal',DataFinal) ;
     AddParamDateTime('DataInicial',DataInicial) ;
     AddParamString('Destino','I') ;
     AddParamBool('LeituraSimplificada',Simplificada);
     AddParamString('Operador',Operador) ;
  end ;
  FiscNETComando.TimeOut := 30 + DaysBetween(DataInicial,DataFinal) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; Linhas : TStringList; Simplificada : Boolean);
Var
  Leitura, RetCmd : AnsiString ;
begin
  with FiscNETComando do
  begin
     NomeComando := 'EmiteLeituraMF' ;
     AddParamString('Destino','S') ;
     AddParamBool('LeituraSimplificada',Simplificada);
     AddParamString('Operador',Operador) ;
     AddParamInteger('ReducaoFinal',ReducaoFinal) ;
     AddParamInteger('ReducaoInicial',ReducaoInicial) ;
  end ;
  FiscNETComando.TimeOut := 30 + (ReducaoFinal - ReducaoInicial) ;
  EnviaComando ;
  Sleep(500);

  Leitura := '' ;
  Linhas.Clear ;
  repeat
     FiscNETComando.NomeComando := 'LeImpressao' ;
     EnviaComando ;

     RetCmd  := FiscNETResposta.Params.Values['TextoImpressao'] ;
     Leitura := Leitura + RetCmd ;
     sleep(100) ;
  until (RetCmd = '') ;

  Linhas.Text := AjustaLeitura( Leitura );
end;

procedure TACBrECFFiscNET.LeituraMemoriaFiscalSerial(DataInicial,
   DataFinal: TDateTime; Linhas : TStringList; Simplificada : Boolean);
Var
  Leitura, RetCmd : AnsiString ;
begin
  with FiscNETComando do
  begin
     NomeComando := 'EmiteLeituraMF' ;
     AddParamDateTime('DataFinal',DataFinal) ;
     AddParamDateTime('DataInicial',DataInicial) ;
     AddParamString('Destino','S') ;
     AddParamBool('LeituraSimplificada',Simplificada);
     AddParamString('Operador',Operador) ;
  end ;
  FiscNETComando.TimeOut := 30 + DaysBetween(DataInicial,DataFinal) ;
  EnviaComando ;
  Sleep(500);

  Leitura := '' ;
  Linhas.Clear ;
  repeat
     FiscNETComando.NomeComando := 'LeImpressao' ;
     EnviaComando ;

     RetCmd := FiscNETResposta.Params.Values['TextoImpressao'] ;
     Leitura := Leitura + RetCmd ;
     sleep(100) ;
  until (RetCmd = '') ;

  Linhas.Text := AjustaLeitura( Leitura );
end;

procedure TACBrECFFiscNET.LeituraMFDSerial(DataInicial,
  DataFinal: TDateTime; Linhas: TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos]);
Var
  Leitura, RetCmd : AnsiString ;
  Doctos : String ;
begin
  Doctos := DocumentosToStr(Documentos) ;

  with FiscNETComando do
  begin
     NomeComando := 'EmiteLeituraFitaDetalhe' ;
     AddParamDateTime('DataFinal',DataFinal);
     AddParamDateTime('DataInicial',DataInicial);
     AddParamString('Destino','S') ;
     if Doctos <> '' then
        AddParamString('TipoDocumento',Doctos);
  end ;
  FiscNETComando.TimeOut := 5 + DaysBetween(DataInicial,DataFinal) ;
  EnviaComando ;
  Sleep(500);

//WriteToTXT('d:\temp\mfd_ret.txt','', False);
  Leitura := '' ;
  repeat
     FiscNETComando.NomeComando := 'LeImpressao' ;
     EnviaComando ;

     RetCmd := FiscNETResposta.Params.Values['TextoImpressao'] ;
//   WriteToTXT('d:\temp\mfd_ret.txt',RetCmd, True);
     Leitura := Leitura + RetCmd ;
     sleep(100) ;
  until (RetCmd = '') ;

  Linhas.Text := AjustaLeitura( Leitura );
//WriteToTXT('d:\temp\mfd_limpo.txt',Linhas.Text, False);
end;

procedure TACBrECFFiscNET.LeituraMFDSerial(COOInicial,
  COOFinal: Integer; Linhas: TStringList; Documentos : TACBrECFTipoDocumentoSet = [docTodos]);
Var
  Leitura, RetCmd : AnsiString ;
  Doctos : String ;
begin
  Doctos := DocumentosToStr(Documentos) ;

  with FiscNETComando do
  begin
     NomeComando := 'EmiteLeituraFitaDetalhe' ;
     AddParamInteger('COOFinal',COOFinal);
     AddParamInteger('COOInicial',COOInicial);
     AddParamString('Destino','S') ;
     if Doctos <> '' then
        AddParamString('TipoDocumento',Doctos);
  end ;
  FiscNETComando.TimeOut := 5 + (COOFinal - COOInicial) ;
  EnviaComando ;
  Sleep(400);

  Leitura := '' ;
  Linhas.Clear ;
  repeat
     FiscNETComando.NomeComando := 'LeImpressao' ;
     EnviaComando ;

     RetCmd := FiscNETResposta.Params.Values['TextoImpressao'] ;
     Leitura := Leitura + RetCmd ;
     sleep(100) ;
  until (RetCmd = '') ;

  Linhas.Text := AjustaLeitura( Leitura ) ;
end;

Function TACBrECFFiscNET.DocumentosToStr(Documentos : TACBrECFTipoDocumentoSet) : String ;
begin
  Result := '' ;
  if (docTodos in Documentos) then
     exit ;

  if docLX              in Documentos then Result := Result + '1,' ;
  if docRZ              in Documentos then Result := Result + '2,' ;
  if docCF              in Documentos then Result := Result + '3,' ;
  if docCNF             in Documentos then Result := Result + '4,5,6,'
  else
   begin
     if docSuprimento   in Documentos then Result := Result + '5,' ;
     if docSangria      in Documentos then Result := Result + '6,' ;
   end ;
  if docCFCancelamento  in Documentos then Result := Result + '7,8,' ;
  if docCNFCancelamento in Documentos then Result := Result + '9,' ;
  if docCupomAdicional  in Documentos then Result := Result + '10,' ;
  if docLMF             in Documentos then Result := Result + '11,' ;
  if docCCD             in Documentos then Result := Result + '12,13,14,' ;
  if docRG              in Documentos then Result := Result + '15,' ;
  if docEstornoPagto    in Documentos then Result := Result + '16,' ;
  if docEstornoCCD      in Documentos then Result := Result + '17,' ;

  Result := copy(Result,1,Length(Result)-1) ; // Remove a ultima Virgula
end ;

Function TACBrECFFiscNET.AjustaLeitura( AString : AnsiString ) : AnsiString ;
Var
  A, Cols : Integer ;
begin
  { Detectando o n�mero de Colunas (n�o encontrei registrador no ECF que
    retorne o Numero de Colunas) }
  A := pos(StringOfChar('-',40), AString ) ;
  if A < 1 then
     Cols := Colunas
  else
   begin
     Cols := 40 ;
     while copy(AString,A+Cols,1) = '-' do
        Inc( Cols ) ;
   end ;

  { Remove caracteres de Impressao }
  Result := RemoveStrings( AString, fsComandosImpressao ) ;

  { Ajusta o Tamanho das Colunas }
  Result := AjustaLinhas( Result, Cols ) ;
end;


procedure TACBrECFFiscNET.CorrigeEstadoErro(Reducao: Boolean);
begin
  inherited CorrigeEstadoErro(Reducao) ;

  if Estado <> estLivre then
     try
        FiscNETComando.NomeComando := 'ReinicializaEquipamento' ;
        EnviaComando ;
        sleep(200) ;
     except
     end ;
end;

procedure TACBrECFFiscNET.CancelaImpressaoCheque;
begin
  FiscNETComando.NomeComando := 'ChancelaCheque' ;
  EnviaComando ;
end;

function TACBrECFFiscNET.GetChequePronto: Boolean;
begin
  FiscNETComando.NomeComando := 'LeIndicador' ;
  FiscNETComando.AddParamString('NomeIndicador','SensorCheque') ;
  EnviaComando ;

  Result := (FiscNETResposta.Params.Values['ValorNumericoIndicador'] = '1')
end;

procedure TACBrECFFiscNET.ImprimeCheque(Banco: String; Valor: Double;
  Favorecido, Cidade: String; Data: TDateTime; Observacao: String);
begin
   { N�o implementado pois NAO encontrei uma tabela com as cordenadas de
     impress�o para cada Banco }

 {14;ImprimeCheque;Cidade="Tatui" Data=#01/03/07# Favorecido="Daniel Simoes de Almeida" HPosAno=1 HPosCidade=2 HPosDia=3 HPosExtensoLinha1=4 HPosExtensoLinha2=5 HPosFavorecido=6 HPosMes=7 HPosMsgLinha1=8 HPosMsgLinha2=9 HPosMsgLinha3=10 HPosValor=11 MensagemDocLinha1="Msg DOC Linha 1" MensagemDocLinha2="Msg DOC Linha 1" MensagemDocLinha3="Msg DOC Linha 1" TempoEspera=10 Valor=100,00 VPosCidade=12 VPosExtensoLinha1=13 VPosExtensoLinha2=14 VPosFavorecido=15 VPosMsgLinha1=16 VPosMsgLinha2=17 VPosMsgLinha3=18 VPosValor=19;522}
end;

Function TACBrECFFiscNET.LeituraCMC7 : AnsiString ;      // Por: Jos� Edvandro M�ximo
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto', 'CMC7Documento') ;
  AguardaImpressao := True;
  EnviaComando ;
  sleep(500);
  
  Result := FiscNETResposta.Params.Values['ValorTexto'] ;
end;

function TACBrECFFiscNET.GetCNPJ: String;
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto','CNPJ') ;
  EnviaComando ;

  Result := FiscNETResposta.Params.Values['ValorTexto'] ;
end;

function TACBrECFFiscNET.GetIE: String;
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto','IE') ;
  EnviaComando ;

  Result := FiscNETResposta.Params.Values['ValorTexto'] ;
end;

//IMS 28/09/2009
function TACBrECFFiscNET.GetIM: String;
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto','IM') ;
  EnviaComando ;

  Result := FiscNETResposta.Params.Values['ValorTexto'] ;
end;

function TACBrECFFiscNET.GetCliche: String;
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto','Cliche') ;
  EnviaComando ;

  Result := FiscNETResposta.Params.Values['ValorTexto'] ;
end;
//IMS 09/10/2009
function TACBrECFFiscNET.GetUsuarioAtual: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','ContadorProprietarios') ;
  EnviaComando ;

  Result := FiscNETResposta.Params.Values['ValorInteiro'] ;
end;
//IMS 20/10/2009
function TACBrECFFiscNET.GetDataHoraSB: TDateTime;
 {Atualmente n�o tem informa��es de como pegar a hora por comando direto,
tem que utilizar a mesma forma que a Bemateh realizar a partir da LMF  a
ser implementado.}
begin
  Result := now ; //'01/01/95 00:00:00' ;
end;
function TACBrECFFiscNET.GetSubModeloECF: String;
begin
  FiscNETComando.NomeComando := 'LeTexto' ;
  FiscNETComando.AddParamString('NomeTexto','Modelo') ;
  EnviaComando ;

  Result := FiscNETResposta.Params.Values['ValorTexto'] ;
end;
//IMS

function TACBrECFFiscNET.GetDataMovimento: TDateTime;
// Autor: Nei Jos� Van Lare Junior
Var RetCmd : AnsiString ;
    OldShortDateFormat : String ;
    bDiaAberto, bDiaFechado: boolean;
    sParam: String;
begin
   FiscNETComando.TimeOut := 15;
   FiscNETComando.NomeComando := 'LeIndicador' ;
   FiscNETComando.AddParamString('NomeIndicador','DiaAberto');
   EnviaComando ;
   bDiaAberto := FiscNETResposta.Params.Values['ValorTextoIndicador'] = '1';

   FiscNETComando.NomeComando := 'LeIndicador' ;
   FiscNETComando.AddParamString('NomeIndicador','DiaFechado');
   EnviaComando ;
   bDiaFechado := FiscNETResposta.Params.Values['ValorTextoIndicador'] = '1';

   if not (bDiaAberto or bDiaFechado) then
      sParam := 'Data'
   else
      sParam := 'DataAbertura';

  FiscNETComando.NomeComando := 'LeData' ;
  FiscNETComando.AddParamString('NomeData', sParam);
  EnviaComando ;
  RetCmd := FiscNETResposta.Params.Values['ValorData'] ;
  RetCmd := StringReplace(RetCmd ,'/',DateSeparator, [rfReplaceAll] );
  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yyyy' ;
     Result := StrToDate( RetCmd ) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;
end;

function TACBrECFFiscNET.GetGrandeTotal: Double;
// Autor: Nei Jos� Van Lare Junior
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','GT') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.',FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetNumCRZ: String;
// Autor: Nei Jos� Van Lare Junior
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','CRZ') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetTotalAcrescimos: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaAcrescimos') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.',FiscNETResposta.Params.Values['ValorMoeda']), 0) ;
end;

function TACBrECFFiscNET.GetTotalAcrescimosISSQN: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaAcrescimosISSQN') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.',FiscNETResposta.Params.Values['ValorMoeda']), 0) ;
end;



function TACBrECFFiscNET.GetTotalCancelamentos: Double;
// Autor: Nei Jos� Van Lare Junior
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaCancelamentosIcms') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetTotalCancelamentosISSQN: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaCancelamentosISSQN') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;



function TACBrECFFiscNET.GetTotalDescontos: Double;
// Autor: Nei Jos� Van Lare Junior
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaDescontos') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;


function TACBrECFFiscNET.GetTotalDescontosISSQN: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaDescontosISSQN') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;




function TACBrECFFiscNET.GetTotalSubstituicaoTributaria: Double;
// Autor: Nei Jos� Van Lare Junior
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaSubstituicaoTributariaICMS') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetTotalSubstituicaoTributariaISSQN: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaSubstituicaoTributariaISSQN') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;


function TACBrECFFiscNET.GetTotalIsencao: Double;
// Autor: Nei Jos� Van Lare Junior
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaIsencaoICMS') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetTotalIsencaoISSQN: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaIsencaoISSQN') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;


function TACBrECFFiscNET.GetTotalNaoTributado: Double;
// Autor: Nei Jos� Van Lare Junior
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaNaoTributadoICMS') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetTotalNaoTributadoISSQN: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaNaoTributadoISSQN') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;




function TACBrECFFiscNET.GetVendaBruta: Double;
begin
  FiscNETComando.NomeComando := 'LeMoeda' ;
  FiscNETComando.AddParamString('NomeDadoMonetario','TotalDiaVendaBruta') ;
  EnviaComando ;

  Result := StringToFloatDef(
     RemoveString('.', FiscNETResposta.Params.Values['ValorMoeda'] ), 0) ;
end;

function TACBrECFFiscNET.GetNumCOOInicial: String;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','COOInicioDia') ;
  EnviaComando ;

  Result := IntToStrZero(  StrToIntDef(
                  FiscNETResposta.Params.Values['ValorInteiro'],0 ), 6) ;
end;

function TACBrECFFiscNET.GetNumUltimoItem: Integer;
begin
  FiscNETComando.NomeComando := 'LeInteiro' ;
  FiscNETComando.AddParamString('NomeInteiro','ContadorDocUltimoItemVendido') ;
  EnviaComando ;

  Result := StrToIntDef( FiscNETResposta.Params.Values['ValorInteiro'],0 ) ;
end;

procedure TACBrECFFiscNET.AbreNaoFiscal(CPF_CNPJ: String);
begin
  FiscNETComando.NomeComando := 'AbreCupomNaoFiscal' ;
  FiscNETComando.TimeOut     := 5 ;
  FiscNETComando.AddParamString('IdConsumidor',CPF_CNPJ) ;
  EnviaComando ;
end;

procedure TACBrECFFiscNET.RegistraItemNaoFiscal(CodCNF: String;
  Valor: Double; Obs: AnsiString);
begin
  FiscNETComando.NomeComando := 'EmiteItemNaoFiscal' ;
  FiscNETComando.TimeOut     := 5 ;
  FiscNETComando.AddParamInteger('CodNaoFiscal',StrToInt(CodCNF) ) ;
  FiscNETComando.AddParamDouble('Valor',Valor) ;
  EnviaComando ;
end;

function TACBrECFFiscNET.GetArredonda: Boolean;
begin
  if fsArredonda < 0 then
  begin
     try
        FiscNETComando.NomeComando := 'LeInteiro' ;
        FiscNETComando.AddParamString('NomeInteiro','Arredondamento') ;
        EnviaComando ;

        fsArredonda :=  StrToIntDef( FiscNETResposta.Params.Values['ValorInteiro'],0 ) ;
     except
        on E : Exception do
        begin
           // Erro: 11011 - ErroProtNomeRegistrador Parametro NomeInteiro contem nome de registrador inexistente
           if (pos('ErroProtNomeRegistrador',E.Message) = 0) then
              raise ;
           fsArredonda := 1 ;  // N�o tem o comando, assume Truncamento
        end ;
     end ;
  end ;

  { Os valores v�lidos s�o: 0 para arredondamento segundo ABNT,
                            1 para truncamento e
                            2 para arredondamento para cima  }
  Result := (fsArredonda = 0) or (fsArredonda = 2) ;
end;

procedure TACBrECFFiscNET.NaoFiscalCompleto(CodCNF: String; Valor: Double;
  CodFormaPagto: String; Obs: AnsiString; IndiceBMP : Integer);
begin
  { Chama rotinas da classe Pai (fpOwner) para atualizar os Memos }
  with TACBrECF(fpOwner) do
  begin
     AbreNaoFiscal ;
     try
        RegistraItemNaoFiscal(CodCNF, Valor);
        try
           SubtotalizaNaoFiscal(0);
           EfetuaPagamentoNaoFiscal(CodFormaPagto, Valor );
        except
        end ;

        try
           FechaNaoFiscal( Obs );
        except
           FechaNaoFiscal        // Tenta sem Obs
        end ;
     except
        try
           CancelaNaoFiscal
        except
        end;

        raise ;
     end ;
  end ;
end;

procedure TACBrECFFiscNET.CarregaRelatoriosGerenciais;
begin
  inherited;

end;

procedure TACBrECFFiscNET.ProgramaRelatorioGerencial(var Descricao: String;
  Posicao: String);
begin
  inherited;

end;

procedure TACBrECFFiscNET.LoadDLLFunctions;
Var
  LIB_FiscNet, Marca : String ;

 procedure FiscNetFunctionDetect( LibName, FuncName: String; var LibPointer: Pointer ) ;
 begin
   if not Assigned( LibPointer )  then
   begin
     if not FunctionDetect( LibName, FuncName, LibPointer) then
     begin
        LibPointer := NIL ;
        raise Exception.Create( ACBrStr( 'Erro ao carregar a fun��o:'+FuncName+' de: '+LibName ) ) ;
     end ;
   end ;
 end ;
begin
  FiscNETComando.NomeComando := 'LeTexto';
  FiscNETComando.AddParamString('NomeTexto','Marca');
  EnviaComando;
  Marca := FiscNETResposta.Params.Values['ValorTexto'] ;
  Marca := LowerCase(Trim(Marca)) ;

  if pos(Marca, 'dataregis|termoprinter') > 0 then
   begin
     LIB_FiscNet := 'DLLG2_Gerador.dll' ;
     FiscNetFunctionDetect(LIB_FiscNet, 'Gera_AtoCotepe1704',@xGera_AtoCotepe1704 );
   end
  else
     raise Exception.Create( ACBrStr( 'Interface ACBrECF -> '+Marca+' ainda n�o Implementada') ) ;

end;

procedure TACBrECFFiscNET.ArquivoMFD_DLL(DataInicial, DataFinal: TDateTime;
  NomeArquivo: String; Documentos: TACBrECFTipoDocumentoSet);
Var
  iRet: Integer;
  PortaSerial, Modelo, DataStr, Erro: String;
  OldAtivo : Boolean ;
begin
  LoadDLLFunctions;

  FiscNETComando.NomeComando := 'LeTexto';
  FiscNETComando.AddParamString('NomeTexto','Modelo');
  EnviaComando;
  Modelo := FiscNETResposta.Params.Values['ValorTexto'] ;
//Modelo := '3202DT' ;
  PortaSerial := fpDevice.Porta ;

  OldAtivo := Ativo ;
  try
     Ativo := False ;

     DataStr := FormatDateTime('dd/mm/yyyy',DataInicial) ;

     iRet := xGera_AtoCotepe1704( PChar(PortaSerial), PChar(Modelo),
                                  PChar(NomeArquivo), PChar(DataStr) );

     if (-iRet >= Low(ERROS_DLL)) and (-iRet <= High(ERROS_DLL)) then
        Erro := ERROS_DLL[ -iRet ] ;

     if iRet <> 0 then
        raise Exception.Create( ACBrStr( 'Erro ao executar Gera_AtoCotepe1704.'+sLineBreak+
                                         'Cod.: '+IntToStr(iRet) + ' - ' + Erro )) ;
  finally
    Ativo := OldAtivo ;
  end ;

  if not FileExists( NomeArquivo ) then
     raise Exception.Create( ACBrStr( 'Erro na execu��o de Gera_AtoCotepe1704.'+sLineBreak+
                            'Arquivo: "'+NomeArquivo + '" n�o gerado' ))
end;

end.
