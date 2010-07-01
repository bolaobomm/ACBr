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

{$I ACBr.inc}

unit ACBrBancoBradesco;

interface

uses
  Classes, SysUtils,ACBrBoleto,
  {$IFDEF COMPILER6_UP} dateutils {$ELSE} ACBrD5 {$ENDIF};

type

  { TACBrBancoBradesco }

  TACBrBancoBradesco = class(TACBrBancoClass)
  private
  protected
  public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo:TACBrTitulo): String; override;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function MontarCampoNossoNumero(const ACBrTitulo :TACBrTitulo): String; override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; override;
    function GerarRegistroHeader400(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao400(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler400(ARemessa:TStringList): String;  override;
    function LerRetorno400(ARetorno:TStringList): Boolean;  override;

    function VerificaOcorrenciaOriginal(const CodOcorrencia: String) : String; override;
    function VerificaTipoOcorrenciaOriginal(const CodOcorrencia:Integer): TACBrTipoOcorrencia; override;
    function VerificaMotivoRejeicao(const CodMotivo:Integer): String; override;
  end;

implementation

uses ACBrUtil, StrUtils;

{ TACBrBancoBradesco }

constructor TACBrBancoBradesco.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 2;
   fpNome   := 'Bradesco';
   fpTamanhoMaximoNossoNum := 11;
end;

function TACBrBancoBradesco.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
begin
   Modulo.CalculoPadrao;
   Modulo.MultiplicadorFinal := 7;
   Modulo.Documento := ACBrTitulo.Carteira + ACBrTitulo.NossoNumero;
   Modulo.Calcular;

   if Modulo.ModuloFinal = 1 then
      Result:= 'P'
   else
      Result:= IntToStr(Modulo.DigitoFinal);
end;

function TACBrBancoBradesco.MontarCodigoBarras ( const ACBrTitulo: TACBrTitulo) : String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras:String;
  DigitoNum: Integer;
begin
   with ACBrTitulo.ACBrBoleto do
   begin
      FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);

      CodigoBarras := IntToStr( Numero )+'9'+ FatorVencimento +
                      IntToStrZero(Round(ACBrTitulo.ValorDocumento*100),10) +
                      padR(Cedente.Agencia,4,'0') +
                      ACBrTitulo.Carteira +
                      ACBrTitulo.NossoNumero +
                      padR(Cedente.Conta,7,'0') + '0';

      DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
   end;

   Result:= IntToStr(Numero) + '9'+ DigitoCodBarras + Copy(CodigoBarras,5,39);
end;

function TACBrBancoBradesco.MontarCampoNossoNumero (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result:= ACBrTitulo.Carteira+'/'+ACBrTitulo.NossoNumero+'-'+CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBancoBradesco.MontarCampoCodigoCedente (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result := ACBrTitulo.ACBrBoleto.Cedente.Agencia+'-'+
             ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito+'/'+
             ACBrTitulo.ACBrBoleto.Cedente.Conta+'-'+
             ACBrTitulo.ACBrBoleto.Cedente.ContaDigito;
end;

function TACBrBancoBradesco.GerarRegistroHeader400(NumeroRemessa : Integer): String;
begin
   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      Result:= '0'                                        + // ID do Registro
               '1'                                        + // ID do Arquivo( 1 - Remessa)
               'REMESSA'                                  + // Literal de Remessa
               '01'                                       + // C�digo do Tipo de Servi�o
               padL( 'COBRANCA', 15 )                     + // Descri��o do tipo de servi�o
               padR( CodigoCedente, 20, '0')              + // Codigo da Empresa no Banco
               padL( Nome, 30)                                 + // Nome da Empresa
               IntToStr( Numero )+ padL('BRADESCO', 15)        + // C�digo e Nome do Banco(237 - Bradesco)
               FormatDateTime('ddmmyy',Now)  + Space(08)+'MX'  + // Data de gera��o do arquivo + brancos
               IntToStrZero(NumeroRemessa,7) + Space(277) + // Nr. Sequencial de Remessa + brancos
               IntToStrZero(1,6);                           // Nr. Sequencial de Remessa + brancos + Contador

      Result:= UpperCase(Result);
   end;
end;

function TACBrBancoBradesco.GerarRegistroTransacao400(ACBrTitulo :TACBrTitulo): String;
var
  DigitoNossoNumero,
  Ocorrencia,
  Protesto,
  TipoSacado: String;
  TipoBoleto: Char;
begin

   with ACBrTitulo do
   begin
      DigitoNossoNumero := CalcularDigitoVerificador(ACBrTitulo);

      {Pegando C�digo da Ocorrencia}
      case TipoOcorrencia of
         toRemessaBaixar                        : Ocorrencia := '02'; {Pedido de Baixa}
         toRemessaConcederAbatimento            : Ocorrencia := '04'; {Concess�o de Abatimento}
         toRemessaCancelarAbatimento            : Ocorrencia := '05'; {Cancelamento de Abatimento concedido}
         toRemessaAlterarVencimento             : Ocorrencia := '06'; {Altera��o de vencimento}
         toRemessaAlterarNumeroControle         : Ocorrencia := '08'; {Altera��o de seu n�mero}
         toRemessaProtestar                     : Ocorrencia := '09'; {Pedido de protesto}
         toRemessaCancelarIntrucaoProtestoBaixa : Ocorrencia := '18'; {Sustar protesto e baixar}
         toRemessaCancelarInstrucaoProtesto     : Ocorrencia := '19'; {Sustar protesto e manter na carteira}
         toRemessaOutrasOcorrencias             : Ocorrencia := '31'; {Altera��o de Outros Dados}
      else
         Ocorrencia := '01';                                          {Remessa}
      end;

      {Pegando Tipo de Boleto}
      case ACBrBoleto.Cedente.TipoBoleto of
         tbCliEmite : TipoBoleto := '2';
      else
         TipoBoleto := '1';
      end;

      
      {Pegando campo Intru��es}
      if (DataProtesto > 0) and (DataProtesto > Vencimento) then
          Protesto := '06' + IntToStrZero(DaysBetween(DataProtesto,Vencimento),2)
      else if Ocorrencia = '31' then
         Protesto := '9999'
      else
         Protesto := Instrucao1+Instrucao2;

      {Pegando Tipo de Sacado}
      case Sacado.Pessoa of
         pFisica   : TipoSacado := '01';
         pJuridica : TipoSacado := '02';
      else
         TipoSacado := '99';
      end;

      with ACBrBoleto do
      begin
         Result:= '1'                                                     +  // ID Registro
                  StringOfChar( '0', 19)                                  +  // Dados p/ D�bito Autom�tico
                  '0'+ padR( Carteira, 3, '0')                            +
                  padR( Cedente.Agencia, 5, '0')                          +
                  padR( Cedente.Conta, 7, '0')                            +
                  Cedente.ContaDigito                                     +
                  padL( SeuNumero,25,' ') +'000'                          +  // Numero de Controle do Participante
                  IfThen( PercentualMulta > 0, '2', '0')                  +  // Indica se exite Multa ou n�o
                  IntToStrZero( round( PercentualMulta * 100 ), 4)        +  // Percentual de Multa formatado com 2 casas decimais
                  NossoNumero + DigitoNossoNumero                         +
                  IntToStrZero( round( ValorDesconto * 100), 10)          +
                  TipoBoleto + 'N' + Space(10)                            +  // Tipo Boleto(Quem emite) + 'N'= Nao registrar p/ D�bito autom�tico
                  ' ' + '0' + '  ' + Ocorrencia                           +  // Ind. Rateio de Credito + Aviso de Debito Aut. + Ocorr�ncia
                  padL( NumeroDocumento,  10)                             +
                  FormatDateTime( 'ddmmyy', Vencimento)                   +
                  IntToStrZero( Round( ValorDocumento * 100 ), 13)        +
                  StringOfChar('0',8) + padl(EspecieDoc,2) + 'N'                  +  // Zeros + Especie do documento + Idntifica��o(valor fixo N)
                  FormatDateTime( 'ddmmyy', DataDocumento )               +  // Data de Emiss�o
                  Protesto                                                +
                  IntToStrZero( round(ValorMoraJuros * 100 ), 13)         +
                  IfThen(DataDesconto < EncodeDate(2000,01,01),'000000',FormatDateTime( 'ddmmyy', DataDesconto)) +
                  IntToStrZero( round( ValorDesconto * 100 ), 13)         +
                  IntToStrZero( round( ValorIOF * 100 ), 13)              +
                  IntToStrZero( round( ValorAbatimento * 100 ), 13)       +
                  TipoSacado + padR(Sacado.CNPJCPF,14,'0')                +
                  padL( Sacado.NomeSacado, 40, ' ')                       +
                  padL( Sacado.Logradouro + Sacado.Numero              +
                           Sacado.Bairro + Sacado.Cidade + Sacado.UF, 40) +
                  space(12) + padL( Sacado.CEP, 8 )                       +
                  padl( Mensagem.Text, 60 )                               +
                  IntToStrZero( ListadeBoletos.IndexOf(ACBrTitulo)+2, 6 );

         Result:= UpperCase(Result);
      end;
   end;
end;

function TACBrBancoBradesco.GerarRegistroTrailler400( ARemessa:TStringList ): String;
begin
   Result:= '9' + Space(393)                     + // ID Registro
            IntToStrZero( ARemessa.Count + 1, 6);  // Contador de Registros
   Result:= UpperCase(Result);
end;

function TACBrBancoBradesco.LerRetorno400 ( ARetorno: TStringList ) : Boolean;
var
  ContLinha: Integer;
  Titulo   : TACBrTitulo;
begin
   Result:= False;
   ContLinha := 0;

   if StrToInt(copy(ARetorno.Strings[0],77,3)) <> Numero then
      raise Exception.Create(ACBrStr(ACBrBanco.ACBrBoleto.NomeArqRetorno + 'nao' +
                             '� um arquivo de retorno do '+ Nome));

   Titulo:=   ACBrBanco.ACBrBoleto.CriarTituloNaLista;

   try
     for ContLinha := 1 to ARetorno.Count - 2 do
     begin
         if Copy(ARetorno[ContLinha],1,1)<> '1' then
            Continue;

         with Titulo do
         begin
            SeuNumero                      := copy(ARetorno.Strings[ContLinha],38,25);
            NumeroDocumento                := copy(ARetorno.Strings[ContLinha],117,10);
            OcorrenciaOriginal             := copy(ARetorno.Strings[ContLinha],109,2);
            DescricaoOcorrenciaOriginal    := VerificaOcorrenciaOriginal(OcorrenciaOriginal);
            TipoOcorrencia                 := VerificaTipoOcorrenciaOriginal(StrToIntDef(OcorrenciaOriginal,0));
            MotivoRejeicaoComando          := copy(ARetorno.Strings[ContLinha],319,2);
            MotivoRejeicaoComando          := IfThen(MotivoRejeicaoComando = '00',
                                              '',MotivoRejeicaoComando );
            DescricaoMotivoRejeicaoComando := IfThen(MotivoRejeicaoComando = '00',
                                              '',VerificaMotivoRejeicao(StrToIntDef(MotivoRejeicaoComando,0)));
            DataOcorrencia := EncodeDate(strtoint('20'+copy(ARetorno.Strings[ContLinha],115,2)),
                                         strtoint(Copy(ARetorno.Strings[ContLinha],113,2)),
                                         strtoint(Copy(ARetorno.Strings[ContLinha],111,2)));

            Vencimento := EncodeDate(strtoint('20'+copy(ARetorno[ContLinha],151,2)),
                                     strtoint(Copy(ARetorno.Strings[ContLinha],149,2)),
                                     strtoint(Copy(ARetorno.Strings[ContLinha],147,2)));

            ValorDocumento       := StrToFloatDef(Copy(ARetorno.Strings[ContLinha],153,13),0)/100;
            ValorIOF             := StrToFloatDef(Copy(ARetorno.Strings[ContLinha],215,13),0)/100;
            ValorAbatimento      := StrToFloatDef(Copy(ARetorno.Strings[ContLinha],228,13),0)/100;
            ValorDesconto        := StrToFloatDef(Copy(ARetorno.Strings[ContLinha],241,13),0)/100;
            ValorMoraJuros       := StrToFloatDef(Copy(ARetorno.Strings[ContLinha],267,13),0)/100;
            ValorOutrosCreditos  := StrToFloatDef(Copy(ARetorno.Strings[ContLinha],280,13),0)/100;
            ValorRecebido        := StrToFloatDef(Copy(ARetorno.Strings[ContLinha],254,13),0)/100;
            NossoNumero          := Copy(ARetorno.Strings[ContLinha],71,11);
            Carteira             := Copy(ARetorno.Strings[ContLinha],22,3);
            ValorDespesaCobranca := StrToFloatDef(Copy(ARetorno.Strings[ContLinha],176,13),0)/100;
            ValorOutrasDespesas  := StrToFloatDef(Copy(ARetorno.Strings[ContLinha],189,13),0)/100;

            if padR(Copy(ARetorno.Strings[ContLinha],296,6),6,'0') <> '000000' then
               DataCredito:= EncodeDate(strtoint('20'+Copy(ARetorno.Strings[ContLinha],300,2)),
                                        strtoint(copy(ARetorno.Strings[ContLinha],298,2)),
                                        strtoint(Copy(ARetorno.Strings[ContLinha],296,2)));
         end;
     end;
     Result:= True;
   finally
      Titulo.Free;
   end;
end;

function TACBrBancoBradesco.VerificaOcorrenciaOriginal(const CodOcorrencia: String): String;
begin
  if trim(CodOcorrencia) = '' then
  begin
    Result:='';
    Exit;
  end;
  case StrToInt(CodOcorrencia) of
    02: Result:='02-Entrada Confirmada' ;
    03: Result:='03-Entrada Rejeitada' ;
    06: Result:='06-Liquida��o normal' ;
    09: Result:='09-Baixado Automaticamente via Arquivo' ;
    10: Result:='10-Baixado conforme instru��es da Ag�ncia' ;
    11: Result:='11-Em Ser - Arquivo de T�tulos pendentes' ;
    12: Result:='12-Abatimento Concedido' ;
    13: Result:='13-Abatimento Cancelado' ;
    14: Result:='14-Vencimento Alterado' ;
    15: Result:='15-Liquida��o em Cart�rio' ;
    17: Result:='17-Liquida��o ap�s baixa ou T�tulo n�o registrado' ;
    18: Result:='18-Acerto de Deposit�ria' ;
    19: Result:='19-Confirma��o Recebimento Instru��o de Protesto' ;
    20: Result:='20-Confirma��o Recebimento Instru��o Susta��o de Protesto' ;
    21: Result:='21-Acerto do Controle do Participante' ;
    23: Result:='22-Entrada do T�tulo em Cart�rio' ;
    24: Result:='23-Entrada rejeitada por CEP Irregular' ;
    27: Result:='27-Baixa Rejeitada' ;
    28: Result:='28-D�bito de tarifas/custas' ;
    30: Result:='30-Altera��o de Outros Dados Rejeitados' ;
    32: Result:='32-Instru��o Rejeitada' ;
    33: Result:='33-Confirma��o Pedido Altera��o Outros Dados' ;
    34: Result:='34-Retirado de Cart�rio e Manuten��o Carteira' ;
    35: Result:='35-Desagendamento do d�bito autom�tico' ;
    68: Result:='68-Acerto dos dados do rateio de Cr�dito' ;
    69: Result:='69-Cancelamento dos dados do rateio' ;
  end;
end;

function TACBrBancoBradesco.VerificaTipoOcorrenciaOriginal (
   const CodOcorrencia: Integer ) : TACBrTipoOcorrencia;
begin
   case CodOcorrencia of
      02: Result := toRetornoRegistroConfirmado;
      03: Result := toRetornoRegistroRecusado;
      06: Result := toRetornoLiquidado;
      09: Result := toRetornoBaixado;
      10: Result := toRetornoBaixado;
      11: Result := toRetornoTituloEmSer;
      12: Result := toRetornoAbatimentoConcedido;
      13: Result := toRetornoAbatimentoCancelado;
      14: Result := toRetornoVencimentoAlterado;
      15: Result := toRetornoLiquidadoEmCartorio;
      16: Result := toRetornoLiquidado;
      17: Result := toRetornoLiquidadoSemRegistro;
      18: Result := toRetornoAcertoDepositaria;
      19: Result := toRetornoRecebimentoInstrucaoProtestar;
      20: Result := toRetornoRecebimentoInstrucaoSustarProtesto;
      21: Result := toRetornoDadosAlterados;
      22: Result := toRetornoRecebimentoInstrucaoAlterarDados;
      23: Result := toRetornoEncaminhadoACartorio;
      24: Result := toRetornoRegistroRecusado;
      27: Result := toRetornoComandoRecusado;
      28: Result := toRetornoDebitoTarifas;
      30: Result := toRetornoComandoRecusado;
      32: Result := toRetornoComandoRecusado;
      33: Result := toRetornoRecebimentoInstrucaoAlterarDados;
      34: Result := toRetornoRetiradoDeCartorio;
      99: Result := toRetornoRegistroRecusado;
   else
      Result := toRetornoOutrasOcorrencias;
   end;
end;

function TACBrBancoBradesco.VerificaMotivoRejeicao ( const CodMotivo: Integer
   ) : String;
begin
   case CodMotivo of
      00 : Result := '00-Ocorrencia aceita';
      04 : Result := '04-Tarifa de protesto';
      08 : Result := '08-Tarifa de protesto';
      14 : Result := '14-T�tulo protestado';
      15 : Result := '15-T�tulo pago com cheque';
      16 : Result := '16-T�tulo baixado pelo Banco por decurso Prazo';
      17 : Result := '17-Data de vencimento anterior a data de emiss�o';
      20 : Result := '20-T�tulo baixado e transferido para desconto';
      21 : Result := '21-Esp�cie do T�tulo inv�lido';
      24 : Result := '24-Data da emiss�o inv�lida';
      38 : Result := '38-Prazo para protesto inv�lido';
      39 : Result := '39-Pedido para protesto n�o permitido para t�tulo';
      43 : Result := '43-Prazo para baixa e devolu��o inv�lido';
      45 : Result := '45-Nome do Sacado inv�lido';
      46 : Result := '46-Tipo/num. de inscri��o do Sacado inv�lidos';
      47 : Result := '47-Endere�o do Sacado n�o informado';
      48 : Result := '48-CEP irregular';
      50 : Result := '50-CEP referente a Banco correspondente';
      53 : Result := '53-N� de inscri��o do Sacador/avalista inv�lidos (CPF/CNPJ)';
      54 : Result := '54-Sacador/avalista n�o informado';
      63 : Result := '63-Titulo j� cadastrado';
      67 : Result := '67-D�bito autom�tico agendado';
      68 : Result := '68-D�bito n�o agendado - erro nos dados de remessa';
      69 : Result := '69-D�bito n�o agendado - Sacado n�o consta no cadastro de autorizante';
      70 : Result := '70-D�bito n�o agendado - Cedente n�o autorizado pelo Sacado';
      71 : Result := '71-D�bito n�o agendado - Cedente n�o participa da modalidade de d�bito autom�tico';
      72 : Result := '72-D�bito n�o agendado - C�digo de moeda diferente de R$';
      73 : Result := '73-D�bito n�o agendado - Data de vencimento inv�lida';
      75 : Result := '75-D�bito n�o agendado - Tipo do n�mero de inscri��o do sacado debitado inv�lido';
      86 : Result := '86-Seu n�mero do documento inv�lido'
   else
      Result:= IntToStr(CodMotivo)+'-Outros motivos';
   end;
end;

end.

