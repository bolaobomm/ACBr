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

unit ACBrBancoBrasil;

interface

uses
  Classes, SysUtils, ACBrBoleto,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrBancoBrasil}

  TACBrBancoBrasil = class(TACBrBancoClass)
   protected
     function CalcularTamMaximoNossoNumero(const Carteira : String): Integer; override;
   private
    function FormataNossoNumero(const ACBrTitulo :TACBrTitulo): String;
   public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String; override;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function MontarCampoCodigoCedente(const ACBrTitulo: TACBrTitulo): String; override;
    function MontarCampoNossoNumero(const ACBrTitulo :TACBrTitulo): String; override;
    function GerarRegistroHeader240(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler240(ARemessa : TStringList): String;  override;
    procedure GerarRegistroHeader400(NumeroRemessa : Integer; aRemessa:TStringList); override;
    procedure GerarRegistroTransacao400(ACBrTitulo : TACBrTitulo; aRemessa: TStringList); override;
    procedure GerarRegistroTrailler400(ARemessa : TStringList);  override;
    function TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia) : String; override;
    function CodOcorrenciaToTipo(const CodOcorrencia:Integer): TACBrTipoOcorrencia; override;
    function TipoOCorrenciaToCod(const TipoOcorrencia: TACBrTipoOcorrencia):String; override;
    Procedure LerRetorno240(ARetorno:TStringList); override;
    procedure LerRetorno400(ARetorno: TStringList); override;
    function CodMotivoRejeicaoToDescricao(
      const TipoOcorrencia: TACBrTipoOcorrencia; CodMotivo: Integer): String;
   end;

implementation

uses ACBrUtil, StrUtils, Variants;

constructor TACBrBancoBrasil.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 9;
   fpNome   := 'Banco do Brasil';
   fpNumero := 001;
   fpTamanhoMaximoNossoNum := 0;
   fpTamanhoConta   := 12;
   fpTamanhoAgencia := 4;
   fpTamanhoCarteira:= 2;

end;

function TACBrBancoBrasil.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
begin
   Result := '0';

   Modulo.CalculoPadrao;
   Modulo.MultiplicadorFinal   := 2;
   Modulo.MultiplicadorInicial := 9;
   Modulo.Documento := FormataNossoNumero(ACBrTitulo);
   Modulo.Calcular;

   if Modulo.ModuloFinal >= 10 then
      Result:= 'X'
   else
      Result:= IntToStr(Modulo.ModuloFinal);
end;

function TACBrBancoBrasil.CalcularTamMaximoNossoNumero(
  const Carteira: String): Integer;
var
  wCarteira   : String;
  wTamConvenio: Integer;
begin
   Result := 10;

   if (ACBrBanco.ACBrBoleto.Cedente.Convenio = '') then
      raise Exception.Create(ACBrStr('Banco do Brasil requer que a Conv�nio do Cedente '+
                                     'seja informado.'));

   if (Carteira = '') then
      raise Exception.Create(ACBrStr('Banco do Brasil requer que a carteira seja '+
                                     'informada antes do Nosso N�mero.'));

   wCarteira:= Trim(Carteira);
   wTamConvenio:= Length(Trim(ACBrBanco.ACBrBoleto.Cedente.Convenio));

   if (wCarteira = '18') and (wTamConvenio = 6) then
      Result := 17
   else if (wTamConvenio <= 4) then
      Result := 7
   else if (wTamConvenio > 4) and (wTamConvenio <= 6) then
      Result := 5
   else if (wTamConvenio = 7) then
      Result := 10;
end;

function TACBrBancoBrasil.FormataNossoNumero(const ACBrTitulo :TACBrTitulo): String;
var
  ANossoNumero, AConvenio : string;
  aCarteira: LongInt;
begin
   with ACBrTitulo do
   begin
      AConvenio := ACBrBoleto.Cedente.Convenio;
      ANossoNumero := IntToStr(StrToInt(OnlyNumber(NossoNumero)));
      aCarteira    := StrToIntDef(copy(Carteira,0,fpTamanhoCarteira),0);
      
       
      if (ACBrTitulo.Carteira = '18') and (Length(AConvenio) = 6) then
         ANossoNumero := padR(ANossoNumero, 17, '0')
      else if Length(AConvenio) <= 4 then
          ANossoNumero := padR(AConvenio, 4, '0') + padR(ANossoNumero, 7, '0')
      else if (Length(AConvenio) > 4) and (Length(AConvenio) <= 6) then
          ANossoNumero := padR(AConvenio, 6, '0') + padR(ANossoNumero, 5, '0')
      else if (Length(AConvenio) = 7) and (ACBrTitulo.Carteira = '11') then
          ANossoNumero := padR('0', 7, '0') + padR(ANossoNumero, 10, '0')
      else if (Length(AConvenio) = 7) and ((ACBrTitulo.Carteira <> '11')) then
          ANossoNumero := padR(AConvenio, 7, '0') + padR(ANossoNumero, 10, '0');

   end;
   Result := ANossoNumero;
end;


function TACBrBancoBrasil.MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras :String;
  ANossoNumero, AConvenio: string;
begin
    AConvenio := ACBrTitulo.ACBrBoleto.Cedente.Convenio;
    ANossoNumero := FormataNossoNumero(ACBrTitulo);

    {Codigo de Barras}
    with ACBrTitulo.ACBrBoleto do
    begin
      FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);

      if ((ACBrTitulo.Carteira = '18') or (ACBrTitulo.Carteira = '16')) and
         (Length(AConvenio) = 6) then
       begin
        CodigoBarras := IntToStrZero(Banco.Numero, 3) +
                        '9' +
                        FatorVencimento +
                        IntToStrZero(Round(ACBrTitulo.ValorDocumento * 100), 10) +
                        AConvenio + ANossoNumero + '21';
       end
      else
       begin
         CodigoBarras := IntToStrZero(Banco.Numero, 3) +
                         '9' +
                         FatorVencimento +
                         IntToStrZero(Round(ACBrTitulo.ValorDocumento * 100), 10) +
                         IfThen((Length(AConvenio) = 7), '000000', '') +
                         ANossoNumero +
                         IfThen((Length(AConvenio) < 7), padR(OnlyNumber(Cedente.Agencia), 4, '0'), '') +
                         IfThen((Length(AConvenio) < 7), IntToStrZero(StrToIntDef(OnlyNumber(Cedente.Conta),0),8), '') +
                         ACBrTitulo.Carteira;
      end;

      DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
    end;


    Result:= copy( CodigoBarras, 1, 4) + DigitoCodBarras + copy( CodigoBarras, 5, 44) ;
end;

function TACBrBancoBrasil.MontarCampoCodigoCedente (
   const ACBrTitulo: TACBrTitulo ) : String;
begin
   Result := ACBrTitulo.ACBrBoleto.Cedente.Agencia+'-'+
             ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito+'/'+
             IntToStrZero(StrToIntDef(ACBrTitulo.ACBrBoleto.Cedente.Conta,0),8)+'-'+
             ACBrTitulo.ACBrBoleto.Cedente.ContaDigito;
end;

function TACBrBancoBrasil.MontarCampoNossoNumero (const ACBrTitulo: TACBrTitulo ) : String;
var ANossoNumero : string;
begin
    ANossoNumero := FormataNossoNumero(ACBrTitulo);
    if (Length(ACBrBanco.ACBrBoleto.Cedente.Convenio) = 7) or
       ((Length(ACBrBanco.ACBrBoleto.Cedente.Convenio) = 6) and
        (Length(ANossoNumero) = 17) and
       ((StrToInt(copy(ACBrTitulo.Carteira,0,fpTamanhoCarteira))= 16) or
        (StrToInt(copy(ACBrTitulo.Carteira,0,fpTamanhoCarteira))= 18))) then   
       Result:= ANossoNumero
    else
       Result := ANossoNumero + '-' + CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBancoBrasil.GerarRegistroHeader240(NumeroRemessa : Integer): String;
var
  ATipoInscricao,CNPJCIC: string;
  aAgencia: String;
  aConta: String;
  aModalidade: String;
begin

   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      case TipoInscricao of
         pFisica  : ATipoInscricao := '1';
         pJuridica: ATipoInscricao := '2';
         else
          ATipoInscricao := '1';
      end;

      CNPJCIC := OnlyNumber(CNPJCPF);

      aAgencia:= IntToStrZero(StrToIntDef(OnlyNumber(Agencia),0),5);
      aConta  := IntToStrZero(StrToIntDef(OnlyNumber(Conta),0),12);
      aModalidade := IntToStrZero(StrToIntDef(trim(Modalidade),0),3);

          { GERAR REGISTRO-HEADER DO ARQUIVO }

      Result:= IntToStrZero(ACBrBanco.Numero, 3)               + //1 a 3 - C�digo do banco
               '0000'                                          + //4 a 7 - Lote de servi�o
               '0'                                             + //8 - Tipo de registro - Registro header de arquivo
               padL('', 9, ' ')                                + //9 a 17 Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                                  + //18 - Tipo de inscri��o do cedente
               padR(CNPJCIC, 14, '0')                          + //19 a 32 -N�mero de inscri��o do cedente
               padR(Convenio, 9, '0') + '0014'                 + //33 a 45 - C�digo do conv�nio no banco [ Alterado conforme instru��es da CSO Bras�lia ] 27-07-09
               ACBrBanco.ACBrBoleto.ListadeBoletos[0].Carteira + //46 a 47 - Carteira
               aModalidade+'  '                                + //48 a 52 - Variacao Carteira
               aAgencia                                        + //53 a 57 - C�digo da ag�ncia do cedente
               padL(AgenciaDigito, 1 , '0')                    + //58 - D�gito da ag�ncia do cedente
               aConta                                          + //59 a 70 - N�mero da conta do cedente
               padL(ContaDigito, 1, '0')                       + //71 - D�gito da conta do cedente
               ' '                                             + //72 - D�gito verificador da ag�ncia / conta
               TiraAcentos(UpperCase(padL(Nome, 30, ' ')))     + //73 a 102 - Nome do cedente
               padL('BANCO DO BRASIL', 30, ' ')                + //103 a 132 - Nome do banco
               padL('', 10, ' ')                               + //133 a 142 - Uso exclusivo FEBRABAN/CNAB
               '1'                                             + //143 - C�digo de Remessa (1) / Retorno (2)
               FormatDateTime('ddmmyyyy', Now)                 + //144 a 151 - Data do de gera��o do arquivo
               FormatDateTime('hhmmss', Now)                   + //152 a 157 - Hora de gera��o do arquivo
               padR(IntToStr(NumeroRemessa), 6, '0')           + //158 a 163 - N�mero seq�encial do arquivo
               '030'                                           + //164 a 166 - N�mero da vers�o do layout do arquivo
               padL('',  5, '0')                               + //167 a 171 - Densidade de grava��o do arquivo (BPI)
               padL('', 20, ' ')                               + // 172 a 191 - Uso reservado do banco
               padL('', 20, '0')                               + // 192 a 211 - Uso reservado da empresa
               padL('', 11, ' ')                               + // 212 a 222 - 11 brancos
               'CSP'                                           + // 223 a 225 - 'CSP'
               padL('',  3, '0')                               + // 226 a 228 - Uso exclusivo de Vans
               padL('',  2, ' ')                               + // 229 a 230 - Tipo de servico
               padL('', 10, ' ');                                //231 a 240 - titulo em carteira de cobranca

          { GERAR REGISTRO HEADER DO LOTE }

      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)               + //1 a 3 - C�digo do banco
               '0001'                                          + //4 a 7 - Lote de servi�o
               '1'                                             + //8 - Tipo de registro - Registro header de arquivo
               'R'                                             + //9 - Tipo de opera��o: R (Remessa) ou T (Retorno)
               '01'                                            + //10 a 11 - Tipo de servi�o: 01 (Cobran�a)
               '00'                                            + //12 a 13 - Forma de lan�amento: preencher com ZEROS no caso de cobran�a
               '020'                                           + //14 a 16 - N�mero da vers�o do layout do lote
               ' '                                             + //17 - Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                                  + //18 - Tipo de inscri��o do cedente
               padR(CNPJCIC, 15, '0')                          + //19 a 32 -N�mero de inscri��o do cedente
               padR(Convenio, 9, '0') + '0014'                 + //33 a 45 - C�digo do conv�nio no banco [ Alterado conforme instru��es da CSO Bras�lia ] 27-07-09
               ACBrBanco.ACBrBoleto.ListadeBoletos[0].Carteira + //46 a 47 - Carteira
               aModalidade+'  '                                + //48 a 52 - Variacao Carteira
               aAgencia                                        + //53 a 57 - C�digo da ag�ncia do cedente
               padL(AgenciaDigito, 1 , '0')                    + //58 - D�gito da ag�ncia do cedente
               aConta                                          + //59 a 70 - N�mero da conta do cedente
               padL(ContaDigito, 1, '0')                       + //71 - D�gito da conta do cedente
               ' '                                             + //72 - D�gito verificador da ag�ncia / conta
               padL(Nome, 30, ' ')                             + //73 a 102 - Nome do cedente
               padL('', 40, ' ')                               + //104 a 143 - Mensagem 1 para todos os boletos do lote
               padL('', 40, ' ')                               + //144 a 183 - Mensagem 2 para todos os boletos do lote
               padR(IntToStr(NumeroRemessa), 8, '0')           + //184 a 191 - N�mero do arquivo
               FormatDateTime('ddmmyyyy', Now)                 + //192 a 199 - Data de gera��o do arquivo
               padL('', 8, '0')                                + //200 a 207 - Data do cr�dito - S� para arquivo retorno
               padL('', 33, ' ');                                //208 a 240 - Uso exclusivo FEBRABAN/CNAB
   end;
end;

function TACBrBancoBrasil.GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String;
var
   ATipoInscricao, ATipoOcorrencia, ATipoBoleto: String;
   ADataMoraJuros, ADataDesconto, ANossoNumero : String;
   ATipoAceite, aAgencia, aConta, aDV          : String;
   ACaracTitulo: Char;
begin
   with ACBrTitulo do
   begin
      ANossoNumero := FormataNossoNumero(ACBrTitulo);
      
      if (Length(ACBrBanco.ACBrBoleto.Cedente.Convenio) = 7) or
         ((Length(ACBrBanco.ACBrBoleto.Cedente.Convenio) = 6) and
         (Length(ANossoNumero) = 17) and
         ((StrToInt(copy(ACBrTitulo.Carteira,0,fpTamanhoCarteira))= 16) or
          (StrToInt(copy(ACBrTitulo.Carteira,0,fpTamanhoCarteira))= 18))) then   
         aDV:= ''
      else
         aDV:= CalcularDigitoVerificador(ACBrTitulo);

      

      aAgencia:= IntToStrZero(StrToIntDef(OnlyNumber(ACBrBoleto.Cedente.Agencia),0),5);
      aConta  := IntToStrZero(StrToIntDef(OnlyNumber(ACBrBoleto.Cedente.Conta),0),12);

      {SEGMENTO P}

      {Pegando tipo de pessoa do Cendente}
      case ACBrBoleto.Cedente.TipoInscricao of
         pFisica  : ATipoInscricao := '1';
         pJuridica: ATipoInscricao := '2';
      end;

      {Pegando o Tipo de Ocorrencia}
      case OcorrenciaOriginal.Tipo of
         toRemessaBaixar                    : ATipoOcorrencia := '02';
         toRemessaConcederAbatimento        : ATipoOcorrencia := '04';
         toRemessaCancelarAbatimento        : ATipoOcorrencia := '05';
         toRemessaAlterarVencimento         : ATipoOcorrencia := '06';
         toRemessaConcederDesconto          : ATipoOcorrencia := '07';
         toRemessaCancelarDesconto          : ATipoOcorrencia := '08';
         toRemessaProtestar                 : ATipoOcorrencia := '09';
         toRemessaCancelarInstrucaoProtesto : ATipoOcorrencia := '10';
         toRemessaAlterarNomeEnderecoSacado : ATipoOcorrencia := '12';
         toRemessaDispensarJuros            : ATipoOcorrencia := '31';
      else
         ATipoOcorrencia := '01';
      end;

      { Pegando o tipo de EspecieDoc }
      if EspecieDoc = 'DM' then
         EspecieDoc   := '02'
      else if EspecieDoc = 'RC' then
         EspecieDoc   := '17'
      else if EspecieDoc = 'NP' then
         EspecieDoc   := '12'
      else if EspecieDoc = 'NS' then
         EspecieDoc   := '16'
      else if EspecieDoc = 'ND' then
         EspecieDoc   := '19'
      else if EspecieDoc = 'DS' then
         EspecieDoc   := '04'
      else
         EspecieDoc := EspecieDoc;



      { Pegando o Aceite do Titulo }
      case Aceite of
         atSim :  ATipoAceite := 'A';
         atNao :  ATipoAceite := 'N';
      end;

      {Pegando Tipo de Boleto} //Quem emite e quem distribui o boleto?
      case ACBrBoleto.Cedente.ResponEmissao of
         tbCliEmite        : ATipoBoleto := '2' + '2';
         tbBancoEmite      : ATipoBoleto := '1' + '1';
         tbBancoReemite    : ATipoBoleto := '4' + '1';
         tbBancoNaoReemite : ATipoBoleto := '5' + '2';
      end;


      
      case ACBrBoleto.Cedente.CaracTitulo of
        tcSimples     : ACaracTitulo  := '1';
        tcVinculada   : ACaracTitulo  := '2';
        tcCaucionada  : ACaracTitulo  := '3';
        tcDescontada  : ACaracTitulo  := '4';
        tcVendor      : ACaracTitulo  := '5';
      end;


      
  
      {Mora Juros}
      if (ValorMoraJuros > 0) then
       begin
         if (DataMoraJuros <> Null) then
            ADataMoraJuros := FormatDateTime('ddmmyyyy', DataMoraJuros)
         else
            ADataMoraJuros := padL('', 8, '0');
       end
      else
         ADataMoraJuros := padL('', 8, '0');

      {Descontos}
      if (ValorDesconto > 0) then
       begin
         if (DataDesconto <> Null) then
            ADataDesconto := FormatDateTime('ddmmyyyy', DataDesconto)
         else
            ADataDesconto := padL('', 8, '0');
       end
      else
         ADataDesconto := padL('', 8, '0');

      {SEGMENTO P}
      Result:= IntToStrZero(ACBrBanco.Numero, 3)                                         + //1 a 3 - C�digo do banco
               '0001'                                                                    + //4 a 7 - Lote de servi�o
               '3'                                                                       + //8 - Tipo do registro: Registro detalhe
               IntToStrZero((3 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo)) + 1 , 5) + //9 a 13 - N�mero seq�encial do registro no lote - Cada t�tulo tem 2 registros (P e Q)
               'P'                                                                       + //14 - C�digo do segmento do registro detalhe
               ' '                                                                       + //15 - Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                                           + //16 a 17 - C�digo de movimento
               aAgencia                                                                  + //18 a 22 - Ag�ncia mantenedora da conta
               padL(ACBrBoleto.Cedente.AgenciaDigito, 1 , '0')                           + //23 -D�gito verificador da ag�ncia
               aConta                                                                    + //24 a 35 - N�mero da conta corrente
               padL(ACBrBoleto.Cedente.ContaDigito, 1, '0')                              + //36 - D�gito verificador da conta
               ' '                                                                       + //37 - D�gito verificador da ag�ncia / conta
               padL(ANossoNumero+aDV, 20, ' ')                                           + //38 a 57 - Nosso n�mero - identifica��o do t�tulo no banco
               IfThen(StrToIntDef(Carteira,0) = 17,'7','1')                              + //58 - Cobran�a Simples
               '1'                                                                       + //59 - Forma de cadastramento do t�tulo no banco: com cadastramento
               ACaracTitulo                                                              + //60 - Tipo de documento: Tradicional
               ATipoBoleto                                                               + //61 a 62 - Quem emite e quem distribui o boleto?
               padL(NumeroDocumento, 15, ' ')                                            + //63 a 77 - N�mero que identifica o t�tulo na empresa [ Alterado conforme instru��es da CSO Bras�lia ] {27-07-09}
               FormatDateTime('ddmmyyyy', Vencimento)                                    + //78 a 85 - Data de vencimento do t�tulo
               IntToStrZero( round( ValorDocumento * 100), 15)                           + //86 a 100 - Valor nominal do t�tulo
               '000000'                                                                  + //101 a 105 - Ag�ncia cobradora + Digito. Se ficar em branco, a caixa determina automaticamente pelo CEP do sacado
               padL(EspecieDoc,2)                                                        + //107 a 108 - Esp�cie do documento
               ATipoAceite                                                               + //109 - Identifica��o de t�tulo Aceito / N�o aceito
               FormatDateTime('ddmmyyyy', DataDocumento)                                 + //110 a 117 - Data da emiss�o do documento
               IfThen(ValorMoraJuros > 0, '1', '3')                                      + //118 - C�digo de juros de mora: Valor por dia
               ADataMoraJuros                                                            + //119 a 126 - Data a partir da qual ser�o cobrados juros

               IfThen(ValorMoraJuros > 0, IntToStrZero( round(ValorMoraJuros * 100), 15),
                    padL('', 15, '0'))                                                   + //127 a 141 - Valor de juros de mora por dia

               IfThen(ValorDesconto > 0, IfThen(DataDesconto > 0, '1','3'), '0')         + //142 - C�digo de desconto: 1 - Valor fixo at� a data informada 4-Desconto por dia de antecipacao 0 - Sem desconto

               IfThen(ValorDesconto > 0,
                  IfThen(DataDesconto > 0, ADataDesconto,'00000000'), '00000000')        + //143 a 150 - Data do desconto

               IfThen(ValorDesconto > 0, IntToStrZero( round(ValorDesconto * 100), 15),
               padL('', 15, '0'))                                                        + //151 a 165 - Valor do desconto por dia
               IntToStrZero( round(ValorIOF * 100), 15)                                  + //166 a 180 - Valor do IOF a ser recolhido
               IntToStrZero( round(ValorAbatimento * 100), 15)                           + //181 a 195 - Valor do abatimento
               padL(SeuNumero, 25, ' ')                                                  + //196 a 220 - Identifica��o do t�tulo na empresa
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento),
                      IfThen((DaySpan(Vencimento, DataProtesto) > 5), '1', '2'), '3')       + //221 - C�digo de protesto: Protestar em XX dias corridos
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento),
                    padR(IntToStr(DaysBetween(DataProtesto, Vencimento)), 2, '0'), '00') + //222 a 223 - Prazo para protesto (em dias corridos)
               '0'                                                                       + //224 - Campo n�o tratado pelo BB [ Alterado conforme instru��es da CSO Bras�lia ] {27-07-09}
               '000'                                                                     + //225 a 227 - Campo n�o tratado pelo BB [ Alterado conforme instru��es da CSO Bras�lia ] {27-07-09}
               '09'                                                                      + //228 a 229 - C�digo da moeda: Real
               padL('', 10 , '0')                                                        + //230 a 239 - Uso exclusivo FEBRABAN/CNAB
               ' ';                                                                        //240 - Uso exclusivo FEBRABAN/CNAB

      {SEGMENTO Q}
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                                        + //C�digo do banco
               '0001'                                                                   + //N�mero do lote
               '3'                                                                      + //Tipo do registro: Registro detalhe
               IntToStrZero((3 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo)) + 2 ,5) + //N�mero seq�encial do registro no lote - Cada t�tulo tem 2 registros (P e Q)
               'Q'                                                                      + //C�digo do segmento do registro detalhe
               ' '                                                                      + //Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                                          + //Tipo Ocorrencia
                   {Dados do sacado}
               IfThen(Sacado.Pessoa = pJuridica,'2','1')                                + //Tipo inscricao
               padR(OnlyNumber(Sacado.CNPJCPF), 15, '0')                                +
               padL(Sacado.NomeSacado, 40, ' ')                                         +
               padL(Sacado.Logradouro +' '+ Sacado.Numero +' '+ Sacado.Complemento , 40, ' ') +
               padL(Sacado.Bairro, 15, ' ')                                             +
               padR(OnlyNumber(Sacado.CEP), 8, '0')                                     +
               padL(Sacado.Cidade, 15, ' ')                                             +
               padL(Sacado.UF, 2, ' ')                                                  +
                        {Dados do sacador/avalista}
               '0'                                                                      + //Tipo de inscri��o: N�o informado
               padL('', 15, '0')                                                        + //N�mero de inscri��o
               padL('', 40, ' ')                                                        + //Nome do sacador/avalista
               padL('', 3, '0')                                                         + //Uso exclusivo FEBRABAN/CNAB
               padL('',20, ' ')                                                         + //Uso exclusivo FEBRABAN/CNAB
               padL('', 8, ' ');                                                          //Uso exclusivo FEBRABAN/CNAB

      {SEGMENTO R}
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                                       + // 1 - 3 C�digo do banco
               '0001'                                                                  + // 4 - 7 N�mero do lote
               '3'                                                                     + // 8 - 8 Tipo do registro: Registro detalhe
               IntToStrZero((3 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+ 3 ,5) + // 9 - 13 N�mero seq�encial do registro no lote - Cada t�tulo tem 2 registros (P e Q)
               'R'                                                                     + // 14 - 14 C�digo do segmento do registro detalhe
               ' '                                                                     + // 15 - 15 Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                                         + // 16 - 17 Tipo Ocorrencia
               padR('', 48, '0')                                                       + // 18 - 65 Brancos (N�o definido pelo FEBRAN)
               IfThen((PercentualMulta <> null) and (PercentualMulta > 0), '1', '0')   + // 66 - 66 1-Cobrar Multa / 0-N�o cobrar multa
               IfThen((PercentualMulta <> null) and (PercentualMulta > 0),
                  FormatDateTime('ddmmyyyy', DataMoraJuros), '00000000')               + // 67 - 74 Se cobrar informe a data para iniciar a cobran�a ou informe zeros se n�o cobrar
               IfThen(PercentualMulta > 0, IntToStrZero(round(PercentualMulta * 100), 15),
                    padL('', 15, '0'))                                                 + // 75 - 89 Percentual de multa. Informar zeros se n�o cobrar
                    padL('',110,' ')                                                   + // 90 - 199
                    padL('',8,'0')                                                     + // 200 - 207
               padR('', 33, ' ');                                                        // 208 - 240 Brancos (N�o definido pelo FEBRAN)


      end; 
end;

function TACBrBancoBrasil.GerarRegistroTrailler240( ARemessa : TStringList ): String;
begin
   {REGISTRO TRAILER DO LOTE}
   Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //C�digo do banco
            '0001'                                                     + //N�mero do lote
            '5'                                                        + //Tipo do registro: Registro trailer do lote
            Space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB
            //IntToStrZero(ARemessa.Count-1, 6)                        + //Quantidade de Registro da Remessa
            IntToStrZero((3 * ARemessa.Count-1), 6)                    + //Quantidade de Registro da Remessa
            padL('', 6, '0')                                           + //Quantidade t�tulos em cobran�a
            padL('',17, '0')                                           + //Valor dos t�tulos em carteiras}
            padL('', 6, '0')                                           + //Quantidade t�tulos em cobran�a
            padL('',17, '0')                                           + //Valor dos t�tulos em carteiras}
            padL('', 6, '0')                                           + //Quantidade t�tulos em cobran�a
            padL('',17, '0')                                           + //Valor dos t�tulos em carteiras}
            padL('', 6, '0')                                           + //Quantidade t�tulos em cobran�a
            padL('',17, '0')                                           + //Valor dos t�tulos em carteiras}
            Space(8)                                                   + //Uso exclusivo FEBRABAN/CNAB}
            padL('',117,' ')                                           ;

   {GERAR REGISTRO TRAILER DO ARQUIVO}
   Result:= Result + #13#10 +
            IntToStrZero(ACBrBanco.Numero, 3)                          + //C�digo do banco
            '9999'                                                     + //Lote de servi�o
            '9'                                                        + //Tipo do registro: Registro trailer do arquivo
            space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB}
            '000001'                                                   + //Quantidade de lotes do arquivo}
            IntToStrZero(((ARemessa.Count-1)* 3)+4, 6)                 + //Quantidade de registros do arquivo, inclusive este registro que est� sendo criado agora}
            space(6)                                                   + //Uso exclusivo FEBRABAN/CNAB}
            space(205);                                                  //Uso exclusivo FEBRABAN/CNAB}
end;


procedure TACBrBancoBrasil.GerarRegistroHeader400(NumeroRemessa: Integer; aRemessa:TStringList);
var
  TamConvenioMaior6 :Boolean;
  aAgencia, aConta  :String;
  wLinha: String;
begin

   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      TamConvenioMaior6:= Length(trim(Convenio)) > 6;
      aAgencia:= IntToStrZero(StrToIntDef(OnlyNumber(Agencia),0),4);
      aConta  := IntToStrZero(StrToIntDef(OnlyNumber(Conta),0),8);

      wLinha:= '0'                            + // ID do Registro
               '1'                            + // ID do Arquivo( 1 - Remessa)
               'REMESSA'                      + // Literal de Remessa
               '01'                           + // C�digo do Tipo de Servi�o
               padL( 'COBRANCA', 15 )         + // Descri��o do tipo de servi�o
               aAgencia                       + // Prefixo da ag�ncia/ onde esta cadastrado o convenente lider do cedente
               padL( AgenciaDigito, 1, ' ')   + // DV-prefixo da agencia
               aConta                         + // Codigo do cedente/nr. da conta corrente que est� cadastro o convenio lider do cedente
               padL( ContaDigito, 1, ' ');      // DV-c�digo do cedente


      if TamConvenioMaior6 then
         wLinha:= wLinha + '000000'                         // Complemento
      else
         wLinha:= wLinha + padR(trim(Convenio),6,'0');      //Convenio;

      wLinha:= wLinha + padL( Nome, 30)                      + // Nome da Empresa
               IntToStrZero( Numero, 3)                      + // C�digo do Banco
               padL('BANCO DO BRASIL', 15)                   + // Nome do Banco(BANCO DO BRASIL)
               FormatDateTime('ddmmyy',Now)                  + // Data de gera��o do arquivo
               IntToStrZero(NumeroRemessa,7);                  // Numero Remessa

      if TamConvenioMaior6 then
         wLinha:= wLinha + Space(22)                                     + // Nr. Sequencial de Remessa + brancos
                  padR(trim(ACBrBanco.ACBrBoleto.Cedente.Convenio),7,'0')+ //Nr. Convenio
                  space(258)                                               //Brancos
      else
         wLinha:= wLinha + Space(287);

      wLinha:= wLinha + IntToStrZero(1,6); // Nr. Sequencial do registro-informar 000001

      aRemessa.Text:= aRemessa.Text + UpperCase(wLinha);
   end;
end;

procedure TACBrBancoBrasil.GerarRegistroTransacao400(ACBrTitulo: TACBrTitulo; aRemessa: TStringList);
var
  ANossoNumero, ADigitoNossoNumero :String;
  ATipoOcorrencia, AInstrucao      :String;
  ATipoSacado, ATipoCendente       :String;
  ATipoAceite, ATipoEspecieDoc     :String;
  AMensagem, DiasProtesto          :String;
  aDataDesconto, aAgencia, aConta  :String;
  aModalidade :String;
  NumRegT, NumRegM, incNumReg      :Integer;
  ATipoBoleto                      :Char;
  TamConvenioMaior6                :Boolean;
  wLinha: String;

begin

   with ACBrTitulo do
   begin
       if ((strtoint(Carteira)= 11) or (strtoint(Carteira)= 31) or (strtoint(Carteira)= 51)) or
          (((strtoint(Carteira)= 12) or (strtoint(Carteira)= 15) or (strtoint(Carteira)= 17))
           and (ACBrBoleto.Cedente.ResponEmissao <> tbCliEmite)) then
        begin
           ANossoNumero       := '00000000000000000000';
           ADigitoNossoNumero := '';
        end
       else
        begin
           ANossoNumero := FormataNossoNumero(ACBrTitulo);
           ADigitoNossoNumero := CalcularDigitoVerificador(ACBrTitulo);
        end;
      
    
      TamConvenioMaior6:= Length(trim(ACBrBoleto.Cedente.Convenio)) > 6;
      aAgencia:= IntToStrZero(StrToIntDef(OnlyNumber(ACBrBoleto.Cedente.Agencia),0),4);
      aConta  := IntToStrZero(StrToIntDef(OnlyNumber(ACBrBoleto.Cedente.Conta),0),8);
      aModalidade := IntToStrZero(StrToIntDef(trim(ACBrBoleto.Cedente.Modalidade),0),3);

      {Pegando C�digo da Ocorrencia}
      case OcorrenciaOriginal.Tipo of
         toRemessaBaixar                         : ATipoOcorrencia := '02'; {Pedido de Baixa}
         toRemessaConcederAbatimento             : ATipoOcorrencia := '04'; {Concess�o de Abatimento}
         toRemessaCancelarAbatimento             : ATipoOcorrencia := '05'; {Cancelamento de Abatimento concedido}
         toRemessaAlterarVencimento              : ATipoOcorrencia := '06'; {Altera��o de vencimento}
         toRemessaAlterarNumeroControle          : ATipoOcorrencia := '08'; {Altera��o de seu n�mero}
         toRemessaProtestar                      : ATipoOcorrencia := '09'; {Pedido de protesto}
         toRemessaCancelarInstrucaoProtestoBaixa : ATipoOcorrencia := '10'; {Sustar protesto e baixar}
         toRemessaCancelarInstrucaoProtesto      : ATipoOcorrencia := '10'; {Sustar protesto e manter na carteira}
         toRemessaOutrasOcorrencias              : ATipoOcorrencia := '31'; {Altera��o de Outros Dados}
      else
         ATipoOcorrencia := '01';                                      {Remessa}
      end;

      { Pegando o Aceite do Titulo }
      case Aceite of
         atSim :  ATipoAceite := 'A';
         atNao :  ATipoAceite := 'N';
      end;

      { Pegando o tipo de EspecieDoc }
      if EspecieDoc = 'DM' then
         ATipoEspecieDoc   := '01'
      else if EspecieDoc = 'NP' then
         ATipoEspecieDoc   := '02'
      else if EspecieDoc = 'NS' then
         ATipoEspecieDoc   := '03'
      else if EspecieDoc = 'ND' then
         ATipoEspecieDoc   := '13'
      else if EspecieDoc = 'RC' then
         ATipoEspecieDoc   := '05';

      {Pegando Tipo de Boleto}
      case ACBrBoleto.Cedente.ResponEmissao of
         tbCliEmite : ATipoBoleto := '2';
      else
         ATipoBoleto := '1';
      end;

      {Pegando campo Intru��es}
      if (DataProtesto > 0) and (DataProtesto > Vencimento) then
       begin
         if (trim(Instrucao1) = '') or (trim(Instrucao1) = '06') then
            AInstrucao := '06'+ padR(trim(Instrucao2),2,'0')
         else if(trim(Instrucao2) = '') or (trim(Instrucao2) = '06') then
            AInstrucao := padR(trim(Instrucao2),2,'0')+ '06';

         DiasProtesto:=  IntToStrZero(DaysBetween(DataProtesto,Vencimento),2);
       end
      else
       begin
         AInstrucao := padR(trim(Instrucao1),2,'0') + padR(trim(Instrucao2),2,'0');
         DiasProtesto:= '00';
      end;

      aDataDesconto:= '000000';

      if ValorDesconto > 0 then
      begin
         if DataDesconto > EncodeDate(2000,01,01) then
            aDataDesconto := FormatDateTime('ddmmyy',DataDesconto)
         else
            aDataDesconto := '777777';
      end;


      {Pegando Tipo de Sacado}
      case Sacado.Pessoa of
         pFisica   : ATipoSacado := '01';
         pJuridica : ATipoSacado := '02';
      else
         ATipoSacado := '00';
      end;

      {Pegando Tipo de Cedente}
      case ACBrBoleto.Cedente.TipoInscricao of
         pFisica   : ATipoCendente := '01';
         pJuridica : ATipoCendente := '02';
      end;

      AMensagem   := '';
      if Mensagem.Text <> '' then
         AMensagem   := Mensagem.Strings[0];


      with ACBrBoleto do
      begin
         if TamConvenioMaior6 then
            wLinha:= '7'
         else
            wLinha:= '1';

         wLinha:= wLinha                                                  + // ID Registro
                  ATipoCendente + padR(OnlyNumber(Cedente.CNPJCPF),14,'0')+ // Tipo de inscri��o da empresa 01-CPF / 02-CNPJ  + Inscri��o da empresa
                  aAgencia                                                + // Prefixo da agencia
                  padL( Cedente.AgenciaDigito, 1)                         + // DV-prefixo da agencia
                  aConta                                                  + // C�digo do cendete/nr. conta corrente da empresa
                  padL( Cedente.ContaDigito, 1);                            // DV-c�digo do cedente

         if TamConvenioMaior6 then
            wLinha:= wLinha + padR( trim(Cedente.Convenio), 7)              // N�mero do convenio
         else
            wLinha:= wLinha + padR( trim(Cedente.Convenio), 6);             // N�mero do convenio

         wLinha:= wLinha + padL( SeuNumero, 25 );                           // Numero de Controle do Participante

         if TamConvenioMaior6 then
            wLinha:= wLinha + padR( ANossoNumero, 17, '0')                  // Nosso numero
         else
            wLinha:= wLinha + padR( ANossoNumero,11)+ ADigitoNossoNumero;


         wLinha:= wLinha +
                  '0000' + Space(7) + aModalidade;                          // Zeros + Brancos + Prefixo do titulo + Varia��o da carteira

         if TamConvenioMaior6  then
            wLinha:= wLinha + IntToStrZero(0,7)                             // Zero + Zeros + Zero + Zeros
         else
            wLinha:= wLinha + IntToStrZero(0,13);

         wLinha:= wLinha +
                  '     '                                                 + // Tipo de cobran�a
                  Carteira                                                + // Carteira
                  ATipoOcorrencia                                         + // Ocorr�ncia "Comando"
                  padL( NumeroDocumento, 10, ' ')                         + // Seu Numero - Nr. titulo dado pelo cedente
                  FormatDateTime( 'ddmmyy', Vencimento )                  + // Data de vencimento
                  IntToStrZero( Round( ValorDocumento * 100 ), 13)        + // Valor do titulo
                  '001' + '0000' + ' '                                    + // Numero do Banco - 001 + Prefixo da agencia cobradora + DV-pref. agencia cobradora
                  padR(ATipoEspecieDoc, 2, '0') + ATipoAceite             + // Especie de titulo + Aceite
                  FormatDateTime( 'ddmmyy', DataDocumento )               + // Data de Emiss�o
                  AInstrucao                                              + // 1� e 2� instru��o codificada
                  IntToStrZero( round(ValorMoraJuros * 100 ), 13)         + // Juros de mora por dia
                  aDataDesconto                                           + // Data limite para concessao de desconto
                  IntToStrZero( round( ValorDesconto * 100), 13)          + // Valor do desconto
                  IntToStrZero( round( ValorIOF * 100 ), 13)              + // Valor do IOF
                  IntToStrZero( round( ValorAbatimento * 100 ), 13)       + // Valor do abatimento permitido
                  ATipoSacado + padR(OnlyNumber(Sacado.CNPJCPF),14,'0')   + // Tipo de inscricao do sacado + CNPJ ou CPF do sacado
                  padL( Sacado.NomeSacado, 37) + '   '                    + // Nome do sacado + Brancos
                  padL(trim(Sacado.Logradouro) + ', ' +
                       trim(Sacado.Numero) + ' '+ trim(Sacado.Bairro),
                       52)                                                + // Endere�o do sacado
                  padR( OnlyNumber(Sacado.CEP), 8 )                       + // CEP do endere�o do sacado
                  padL( trim(Sacado.Cidade), 15)                          + // Cidade do sacado
                  padL( Sacado.UF, 2 )                                    + // UF da cidade do sacado
                  padL( AMensagem, 40)                                    + // Observa��es
                  DiasProtesto + ' '                                      + // N�mero de dias para protesto + Branco
                  IntToStrZero( aRemessa.Count + 1{NumRegT}, 6 );


         wLinha:= wLinha + sLineBreak                              +
                  '5'                                              + //Tipo Registro
                  '99'                                             + //Tipo de Servi�o (Cobran�a de Multa)
                  IfThen(PercentualMulta > 0, '2','9')             + //Cod. Multa 2- Percentual 9-Sem Multa
                  IfThen(PercentualMulta > 0,
                         FormatDateTime('ddmmyy', DataMoraJuros),
                                        '000000')                  + //Data Multa
                  IntToStrZero( round( PercentualMulta * 100), 12) + //Perc. Multa
                  Space(372)                                       + //Brancos
                  IntToStrZero(aRemessa.Count + 2 {NumRegM},6);

         aRemessa.Text := aRemessa.Text + UpperCase(wLinha);
      end;
   end;
end;

procedure TACBrBancoBrasil.GerarRegistroTrailler400(
  ARemessa: TStringList);
var
  wLinha: String;
begin
   wLinha := '9' + Space(393)                     + // ID Registro
             IntToStrZero(ARemessa.Count + 1 {(ARemessa.Count * 2)}, 6);  // Contador de Registros

   ARemessa.Text:= ARemessa.Text + UpperCase(wLinha);
end;

procedure TACBrBancoBrasil.LerRetorno240(ARetorno: TStringList);
var
  Titulo: TACBrTitulo;
  TempData, Linha, rCedente, rCNPJCPF: String;
  ContLinha : Integer;
  idxMotivo: Integer;
begin
   ContLinha := 0;

   // informa��o do Header
   // Verifica se o arquivo pertence ao banco
   if StrToIntDef(copy(ARetorno.Strings[0], 1, 3),-1) <> Numero then
      raise Exception.create(ACBrStr(ACBrBanco.ACBrBoleto.NomeArqRetorno +
            'n�o' + '� um arquivo de retorno do ' + Nome));

   ACBrBanco.ACBrBoleto.DataArquivo := StringToDateTimeDef(Copy(ARetorno[0],144,2)+'/'+
                                                           Copy(ARetorno[0],146,2)+'/'+
                                                           Copy(ARetorno[0],148,4),0, 'DD/MM/YYYY' );

   ACBrBanco.ACBrBoleto.NumeroArquivo := StrToIntDef(Copy(ARetorno[0],158,6),0);

   rCedente := trim(copy(ARetorno[0], 73, 30));
   rCNPJCPF := OnlyNumber( copy(ARetorno[0], 19, 14) );

   with ACBrBanco.ACBrBoleto do
   begin
      if (not LeCedenteRetorno) and (rCNPJCPF <> OnlyNumber(Cedente.CNPJCPF)) then
        raise Exception.create(ACBrStr('CNPJ\CPF do arquivo inv�lido'));

      Cedente.Nome := rCedente;
      Cedente.CNPJCPF := rCNPJCPF;

      case StrToIntDef(copy(ARetorno[0], 18, 1), 0) of
        01:
          Cedente.TipoInscricao := pFisica;
        else
          Cedente.TipoInscricao := pJuridica;
      end;

      ACBrBanco.ACBrBoleto.ListadeBoletos.Clear;
   end;

   ACBrBanco.TamanhoMaximoNossoNum := 20;  

   for ContLinha := 1 to ARetorno.Count - 2 do
   begin
      Linha := ARetorno[ContLinha];

      if copy(Linha, 8, 1) <> '3' then // verifica se o registro (linha) � um registro detalhe (segmento J)
        Continue;

      if copy(Linha, 14, 1) = 'T' then // se for segmento T cria um novo titulo
         Titulo := ACBrBanco.ACBrBoleto.CriarTituloNaLista;

      with Titulo do
      begin

         {OcorrenciaOriginal.Tipo := CodOcorrenciaToTipo
         (StrToIntDef(copy(Linha, 214, 2), 0));

         MotivoLinha := 214;
         for i := 0 to 3 do
         begin
         MotivoRejeicaoComando.Add(IfThen(copy(Linha, MotivoLinha, 2) = '  ',
         '00', copy(Linha, MotivoLinha, 2)));

         if MotivoRejeicaoComando[i] <> '00' then
         begin
         CodOCorrencia := StrToIntDef(MotivoRejeicaoComando[i], 0);
         DescricaoMotivoRejeicaoComando.Add(CodMotivoRejeicaoToDescricao
         (OcorrenciaOriginal.Tipo, CodOCorrencia));
         end;

         MotivoLinha := MotivoLinha + 2;
         end; }

         { Esp�cie do documento }
         { if Trim(Copy(Linha,174,2)) = '' then
          EspecieDoc := '99'
          else
          case StrToInt(Copy(Linha,174,2)) of
          01 : EspecieDoc := 'DM';
          02 : EspecieDoc := 'NP';
          03 : EspecieDoc := 'NS';
          04 : EspecieDoc := 'ME';
          05 : EspecieDoc := 'RC';
          06 : EspecieDoc := 'CT';
          07 : EspecieDoc := 'CS';
          08 : EspecieDoc := 'DS';
          09 : EspecieDoc := 'LC';
          13 : EspecieDoc := 'ND';
          15 : EspecieDoc := 'DD';
          16 : EspecieDoc := 'EC';
          17 : EspecieDoc := 'PS';
          99 : EspecieDoc := 'DV';
          else
          EspecieDoc := 'DV';
          end;
          }
         if copy(Linha, 14, 1) = 'T' then
         begin
           SeuNumero := copy(Linha, 106, 25);
           NumeroDocumento := copy(Linha, 59, 15);
           Carteira := copy(Linha, 58, 1);

           TempData := copy(Linha, 74, 2) + '/'+copy(Linha, 76, 2)+'/'+copy(Linha, 78, 4);
           if TempData<>'00/00/0000' then
               Vencimento := StringToDateTimeDef(TempData, 0, 'DDMMYY');

           ValorDocumento := StrToFloatDef(copy(Linha, 82, 15), 0) / 100;

           NossoNumero := copy(Linha, 38, 20);
           ValorDespesaCobranca := StrToFloatDef(copy(Linha, 199, 15), 0) / 100;

           OcorrenciaOriginal.Tipo := CodOcorrenciaToTipo(StrToIntDef(copy(Linha, 16, 2), 0));

           IdxMotivo := 214;

           while (IdxMotivo < 223) do
           begin
             if (trim(Copy(Linha, IdxMotivo, 2)) <> '') then begin
               MotivoRejeicaoComando.Add(Copy(Linha, IdxMotivo, 2));
               DescricaoMotivoRejeicaoComando.Add(CodMotivoRejeicaoToDescricao(OcorrenciaOriginal.Tipo, StrToIntDef(Copy(Linha, IdxMotivo, 2), 0)));
             end;
             Inc(IdxMotivo, 2);
           end;
           
         end
         else // segmento U
         begin
            ValorIOF := StrToFloatDef(copy(Linha, 63, 15), 0) / 100;
            ValorAbatimento := StrToFloatDef(copy(Linha, 48, 15), 0) / 100;
            ValorDesconto := StrToFloatDef(copy(Linha, 33, 15), 0) / 100;
            ValorMoraJuros := StrToFloatDef(copy(Linha, 18, 15), 0) / 100;
            ValorOutrosCreditos := StrToFloatDef(copy(Linha, 108, 15), 0) / 100;
            ValorRecebido := StrToFloatDef(copy(Linha, 78, 15), 0) / 100;
            TempData := copy(Linha, 138, 2)+'/'+copy(Linha, 140, 2)+'/'+copy(Linha, 142, 4);
            if TempData<>'00/00/0000' then
                DataOcorrencia := StringToDateTimeDef(TempData, 0, 'DDMMYY');
            TempData := copy(Linha, 146, 2)+'/'+copy(Linha, 148, 2)+'/'+copy(Linha, 150, 4);
            if TempData<>'00/00/0000' then            
                DataCredito := StringToDateTimeDef(TempData, 0, 'DDMMYYYY');
         end;
      end;
   end;

   ACBrBanco.TamanhoMaximoNossoNum := 10;
end;

function TACBrBancoBrasil.TipoOCorrenciaToCod (
   const TipoOcorrencia: TACBrTipoOcorrencia ) : String;
begin
   case TipoOcorrencia of
      toRetornoRegistroConfirmado                         : Result := '02';
      toRetornoRegistroRecusado                           : Result := '03';
      toRetornoLiquidado                                  : Result := '06';
      toRetornoBaixado                                    : Result := '09';
      toRetornoBaixadoInstAgencia                         : Result := '10';
      toRetornoTituloEmSer                                : Result := '11';
      toRetornoRecebimentoInstrucaoConcederAbatimento     : Result := '12';
      toRetornoRecebimentoInstrucaoCancelarAbatimento     : Result := '13';
      toRetornoRecebimentoInstrucaoAlterarVencimento      : Result := '14';
      toRetornoLiquidadoEmCartorio                        : Result := '15';
      toRetornoLiquidadoSemRegistro                       : Result := '17';
      toRetornoRecebimentoInstrucaoProtestar              : Result := '19';
      toRetornoRecebimentoInstrucaoSustarProtesto         : Result := '20';
      toRetornoAcertoControleParticipante                 : Result := '21';
      toRetornoEnderecoSacadoAlterado                     : Result := '22';
      toRetornoEncaminhadoACartorio                       : Result := '23';
      toRetornoRetiradoDeCartorio                         : Result := '24';
      toRetornoProtestado                                 : Result := '25';
      toRetornoRecebimentoInstrucaoAlterarDados           : Result := '27';
      toRetornoDebitoTarifas                              : Result := '28';
      toRetornoOcorrenciasdoSacado                        : Result := '29';
      toRetornoAlteracaoDadosRejeitados                   : Result := '30';
      toRetornoRecebimentoInstrucaoConcederDesconto       : Result := '36';
      toRetornoRecebimentoInstrucaoCancelarDesconto       : Result := '37';
      toRetornoProtestoOuSustacaoEstornado                : Result := '43';
      toRetornoBaixaOuLiquidacaoEstornada                 : Result := '44';
      toRetornoDadosAlterados                             : Result := '45';
   else
      Result:= '02';
   end;
end;

function TACBrBancoBrasil.TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia): String;
var
 CodOcorrencia: Integer;
begin

  CodOcorrencia := StrToIntDef(TipoOCorrenciaToCod(TipoOcorrencia),0);

  Case CodOcorrencia of
    02: Result := '02-Entrada Confirmada';
    03: Result := '03-Entrada Rejeitada';
    04: Result := '04-Transfer�ncia de Carteira/Entrada';
    05: Result := '05-Transfer�ncia de Carteira/Baixa';
    06: Result := '06-Liquida��o';
    07: Result := '07-Confirma��o do Recebimento da Instru��o de Desconto';
    08: Result := '08-Confirma��o do Recebimento do Cancelamento do Desconto';
    09: Result := '09-Baixa';
    10: Result := '10-Baixa Solicitada';
    11: Result := '11-T�tulos em Carteira (Em Ser)';
    12: Result := '12-Confirma��o Recebimento Instru��o de Abatimento';
    13: Result := '13-Confirma��o Recebimento Instru��o de Cancelamento Abatimento';
    14: Result := '14-Confirma��o Recebimento Instru��o Altera��o de Vencimento';
    15: Result := '15-Franco de Pagamento';
    17: Result := '17-Liquida��o Ap�s Baixa ou Liquida��o T�tulo N�o Registrado';
    19: Result := '19-Confirma��o Recebimento Instru��o de Protesto';
    20: Result := '20-Confirma��o Recebimento Instru��o de Susta��o/Cancelamento de Protesto';
    21: Result := '21-Altera��o do Nome do Sacado';
    22: Result := '22-Altera��o do Endere�o do Sacado';
    23: Result := '23-Remessa a Cart�rio (Aponte em Cart�rio)';
    24: Result := '24-Retirada de Cart�rio e Manuten��o em Carteira';
    25: Result := '25-Protestado e Baixado (Baixa por Ter Sido Protestado)';
    26: Result := '26-Instru��o Rejeitada';
    27: Result := '27-Confirma��o do Pedido de Altera��o de Outros Dados';
    28: Result := '28-D�bito de Tarifas/Custas';
    29: Result := '29-Ocorr�ncias do Sacado';
    30: Result := '30-Altera��o de Dados Rejeitada';
    33: Result := '33-Confirma��o da Altera��o dos Dados do Rateio de Cr�dito';
    34: Result := '34-Confirma��o do Cancelamento dos Dados do Rateio de Cr�dito';
    35: Result := '35-Confirma��o do Desagendamento do D�bito Autom�tico';
    36: Result := '36-Confirma��o de envio de e-mail/SMS';
    37: Result := '37-Envio de e-mail/SMS rejeitado';
    38: Result := '38-Confirma��o de altera��o do Prazo Limite de Recebimento (a data deve ser informada no campo 28.3.p)';
    39: Result := '39-Confirma��o de Dispensa de Prazo Limite de Recebimento';
    40: Result := '40-Confirma��o da altera��o do n�mero do t�tulo dado pelo cedente';
    41: Result := '41-Confirma��o da altera��o do n�mero controle do Participante';
    42: Result := '42-Confirma��o da altera��o dos dados do Sacado';
    43: Result := '43-Confirma��o da altera��o dos dados do Sacador/Avalista';
    44: Result := '44-T�tulo pago com cheque devolvido';
    45: Result := '45-T�tulo pago com cheque compensado';
    46: Result := '46-Instru��o para cancelar protesto confirmada';
    47: Result := '47-Instru��o para protesto para fins falimentares confirmada';
    48: Result := '48-Confirma��o de instru��o de transfer�ncia de carteira/modalidade de cobran�a';
    49: Result := '49-Altera��o de contrato de cobran�a';
    50: Result := '50-T�tulo pago com cheque pendente de liquida��o';
    51: Result := '51-T�tulo DDA reconhecido pelo sacado';
    52: Result := '52-T�tulo DDA n�o reconhecido pelo sacado';
    53: Result := '53-T�tulo DDA recusado pela CIP';
    54: Result := '54-Confirma��o da Instru��o de Baixa de T�tulo Negativado sem Protesto';
  end;
end;

function TACBrBancoBrasil.CodOcorrenciaToTipo(const CodOcorrencia:
   Integer ) : TACBrTipoOcorrencia;
begin
  Case CodOcorrencia of
    2 : Result := toRetornoRegistroConfirmado;
    3 : Result := toRetornoRegistroRecusado;
    6 : Result := toRetornoLiquidado;
    9 : Result := toRetornoBaixado;
    10: Result := toRetornoBaixadoInstAgencia;
    11: Result := toRetornoTituloEmSer;
    12: Result := toRetornoRecebimentoInstrucaoConcederAbatimento;
    13: Result := toRetornoRecebimentoInstrucaoCancelarAbatimento;
    14: Result := toRetornoRecebimentoInstrucaoAlterarVencimento;
    15: Result := toRetornoLiquidadoEmCartorio;
    17: Result := toRetornoLiquidadoSemRegistro;
    19: Result := toRetornoRecebimentoInstrucaoProtestar;
    20: Result := toRetornoRecebimentoInstrucaoSustarProtesto;
    22: Result := toRetornoEnderecoSacadoAlterado;
    23: Result := toRetornoEncaminhadoACartorio;
    24: Result := toRetornoRetiradoDeCartorio;
    25: Result := toRetornoProtestado;
    26: Result := toRetornoInstrucaoRejeitada;
    27: Result := toRetornoRecebimentoInstrucaoAlterarDados;
    28: Result := toRetornoDebitoTarifas;
    29: Result := toRetornoOcorrenciasdoSacado;
    30: Result := toRetornoAlteracaoDadosRejeitados;
    36: Result := toRetornoRecebimentoInstrucaoConcederDesconto;
    37: Result := toRetornoRecebimentoInstrucaoCancelarDesconto;
    43: Result := toRetornoProtestoOuSustacaoEstornado;
    44: Result := toRetornoBaixaOuLiquidacaoEstornada;
    45: Result := toRetornoDadosAlterados;
  else
    Result := toRetornoOutrasOcorrencias;
  end;
end;

function TACBrBancoBrasil.CodMotivoRejeicaoToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia; CodMotivo: Integer): String;
begin
  Case TipoOcorrencia of
    //Associados aos c�digos de movimento 02, 03, 26 e 30...
    toRetornoRegistroConfirmado, toRetornoRegistroRecusado, toRetornoInstrucaoRejeitada, toRetornoAlteracaoDadosRejeitados:
      Case CodMotivo of
        01: Result :='01-C�digo do Banco Inv�lido';
        02: Result :='02-C�digo do Registro Detalhe Inv�lido';
        03: Result :='03-C�digo do Segmento Inv�lido';
        04: Result :='04-C�digo de Movimento N�o Permitido para Carteira';
        05: Result :='05-C�digo de Movimento Inv�lido';
        06: Result :='06-Tipo/N�mero de Inscri��o do Cedente Inv�lidos';
        07: Result :='07-Ag�ncia/Conta/DV Inv�lido';
        08: Result :='08-Nosso N�mero Inv�lido';
        09: Result :='09-Nosso N�mero Duplicado';
        10: Result :='10-Carteira Inv�lida';
        11: Result :='11-Forma de Cadastramento do T�tulo Inv�lido';
        12: Result :='12-Tipo de Documento Inv�lido';
        13: Result :='13-Identifica��o da Emiss�o do Bloqueto Inv�lida';
        14: Result :='14-Identifica��o da Distribui��o do Bloqueto Inv�lida';
        15: Result :='15-Caracter�sticas da Cobran�a Incompat�veis';
        16: Result :='16-Data de Vencimento Inv�lida';
        17: Result :='17-Data de Vencimento Anterior a Data de Emiss�o';
        18: Result :='18-Vencimento Fora do Prazo de Opera��o';
        19: Result :='19-T�tulo a Cargo de Bancos Correspondentes com Vencimento Inferior a XX Dias';
        20: Result :='20-Valor do T�tulo Inv�lido';
        21: Result :='21-Esp�cie do T�tulo Inv�lida';
        22: Result :='22-Esp�cie do T�tulo N�o Permitida para a Carteira';
        23: Result :='23-Aceite Inv�lido';
        24: Result :='24-Data da Emiss�o Inv�lida';
        25: Result :='25-Data da Emiss�o Posterior a Data de Entrada';
        26: Result :='26-C�digo de Juros de Mora Inv�lido';
        27: Result :='27-Valor/Taxa de Juros de Mora Inv�lido';
        28: Result :='28-C�digo do Desconto Inv�lido';
        29: Result :='29-Valor do Desconto Maior ou Igual ao Valor do T�tulo';
        30: Result :='30-Desconto a Conceder N�o Confere';
        31: Result :='31-Concess�o de Desconto - J� Existe Desconto Anterior';
        32: Result :='32-Valor do IOF Inv�lido';
        33: Result :='33-Valor do Abatimento Inv�lido';
        34: Result :='34-Valor do Abatimento Maior ou Igual ao Valor do T�tulo';
        35: Result :='35-Valor a Conceder N�o Confere';
        36: Result :='36-Concess�o de Abatimento - J� Existe Abatimento Anterior';
        37: Result :='37-C�digo para Protesto Inv�lido';
        38: Result :='38-Prazo para Protesto Inv�lido';
        39: Result :='39-Pedido de Protesto N�o Permitido para o T�tulo';
        40: Result :='40-T�tulo com Ordem de Protesto Emitida';
        41: Result :='41-Pedido de Cancelamento/Susta��o para T�tulos sem Instru��o de Protesto';
        42: Result :='42-C�digo para Baixa/Devolu��o Inv�lido';
        43: Result :='43-Prazo para Baixa/Devolu��o Inv�lido';
        44: Result :='44-C�digo da Moeda Inv�lido';
        45: Result :='45-Nome do Sacado N�o Informado';
        46: Result :='46-Tipo/N�mero de Inscri��o do Sacado Inv�lidos';
        47: Result :='47-Endere�o do Sacado N�o Informado';
        48: Result :='48-CEP Inv�lido';
        49: Result :='49-CEP Sem Pra�a de Cobran�a (N�o Localizado)';
        50: Result :='50-CEP Referente a um Banco Correspondente';
        51: Result :='51-CEP incompat�vel com a Unidade da Federa��o';
        52: Result :='52-Unidade da Federa��o Inv�lida';
        53: Result :='53-Tipo/N�mero de Inscri��o do Sacador/Avalista Inv�lidos';
        54: Result :='54-Sacador/Avalista N�o Informado';
        55: Result :='55-Nosso n�mero no Banco Correspondente N�o Informado';
        56: Result :='56-C�digo do Banco Correspondente N�o Informado';
        57: Result :='57-C�digo da Multa Inv�lido';
        58: Result :='58-Data da Multa Inv�lida';
        59: Result :='59-Valor/Percentual da Multa Inv�lido';
        60: Result :='60-Movimento para T�tulo N�o Cadastrado';
        61: Result :='61-Altera��o da Ag�ncia Cobradora/DV Inv�lida';
        62: Result :='62-Tipo de Impress�o Inv�lido';
        63: Result :='63-Entrada para T�tulo j� Cadastrado';
        64: Result :='64-N�mero da Linha Inv�lido';
        65: Result :='65-C�digo do Banco para D�bito Inv�lido';
        66: Result :='66-Ag�ncia/Conta/DV para D�bito Inv�lido';
        67: Result :='67-Dados para D�bito incompat�vel com a Identifica��o da Emiss�o do Bloqueto';
        68: Result :='68-D�bito Autom�tico Agendado';
        69: Result :='69-D�bito N�o Agendado - Erro nos Dados da Remessa';
        70: Result :='70-D�bito N�o Agendado - Sacado N�o Consta do Cadastro de Autorizante';
        71: Result :='71-D�bito N�o Agendado - Cedente N�o Autorizado pelo Sacado';
        72: Result :='72-D�bito N�o Agendado - Cedente N�o Participa da Modalidade D�bito Autom�tico';
        73: Result :='73-D�bito N�o Agendado - C�digo de Moeda Diferente de Real (R$)';
        74: Result :='74-D�bito N�o Agendado - Data Vencimento Inv�lida';
        75: Result :='75-D�bito N�o Agendado, Conforme seu Pedido, T�tulo N�o Registrado';
        76: Result :='76-D�bito N�o Agendado, Tipo/Num. Inscri��o do Debitado, Inv�lido';
        77: Result :='77-Transfer�ncia para Desconto N�o Permitida para a Carteira do T�tulo';
        78: Result :='78-Data Inferior ou Igual ao Vencimento para D�bito Autom�tico';
        79: Result :='79-Data Juros de Mora Inv�lido';
        80: Result :='80-Data do Desconto Inv�lida';
        81: Result :='81-Tentativas de D�bito Esgotadas - Baixado';
        82: Result :='82-Tentativas de D�bito Esgotadas - Pendente';
        83: Result :='83-Limite Excedido';
        84: Result :='84-N�mero Autoriza��o Inexistente';
        85: Result :='85-T�tulo com Pagamento Vinculado';
        86: Result :='86-Seu N�mero Inv�lido';
        87: Result :='87-e-mail/SMS enviado';
        88: Result :='88-e-mail Lido';
        89: Result :='89-e-mail/SMS devolvido - endere�o de e-mail ou n�mero do celular incorreto';
        90: Result :='90-e-mail devolvido - caixa postal cheia';
        91: Result :='91-e-mail/n�mero do celular do sacado n�o informado';
        92: Result :='92-Sacado optante por Bloqueto Eletr�nico - e-mail n�o enviado';
        93: Result :='93-C�digo para emiss�o de bloqueto n�o permite envio de e-mail';
        94: Result :='94-C�digo da Carteira inv�lido para envio e-mail';
        95: Result :='95-Contrato n�o permite o envio de e-mail';
        96: Result :='96-N�mero de contrato inv�lido';
        97: Result :='97-Rejei��o da altera��o do prazo limite de recebimento (a data deve ser informada no campo 28.3.p)';
        98: Result :='98-Rejei��o de dispensa de prazo limite de recebimento';
        99: Result :='99-Rejei��o da altera��o do n�mero do t�tulo dado pelo cedente';
      end;
    //Associados ao c�digo de movimento 28...
    toRetornoDebitoTarifas:
      Case CodMotivo of
        01: Result := '01-Tarifa de Extrato de Posi��o';
        02: Result := '02-Tarifa de Manuten��o de T�tulo Vencido';
        03: Result := '03-Tarifa de Susta��o';
        04: Result := '04-Tarifa de Protesto';
        05: Result := '05-Tarifa de Outras Instru��es';
        06: Result := '06-Tarifa de Outras Ocorr�ncias';
        07: Result := '07-Tarifa de Envio de Duplicata ao Sacado';
        08: Result := '08-Custas de Protesto';
        09: Result := '09-Custas de Susta��o de Protesto';
        10: Result := '10-Custas de Cart�rio Distribuidor';
        11: Result := '11-Custas de Edital';
        12: Result := '12-Tarifa Sobre Devolu��o de T�tulo Vencido';
        13: Result := '13-Tarifa Sobre Registro Cobrada na Baixa/Liquida��o';
        14: Result := '14-Tarifa Sobre Reapresenta��o Autom�tica';
        15: Result := '15-Tarifa Sobre Rateio de Cr�dito';
        16: Result := '16-Tarifa Sobre Informa��es Via Fax';
        17: Result := '17-Tarifa Sobre Prorroga��o de Vencimento';
        18: Result := '18-Tarifa Sobre Altera��o de Abatimento/Desconto';
        19: Result := '19-Tarifa Sobre Arquivo mensal (Em Ser)';
        20: Result := '20-Tarifa Sobre Emiss�o de Bloqueto Pr�-Emitido pelo Banco';
      end;
    //Associados aos c�digos de movimento 06, 09 e 17...
    toRetornoLiquidado, toRetornoBaixado, toRetornoLiquidadoSemRegistro:
      Case CodMotivo of
        01: Result := '01-Por Saldo';
        02: Result := '02-Por Conta';
        03: Result := '03-Liquida��o no Guich� de Caixa em Dinheiro';
        04: Result := '04-Compensa��o Eletr�nica';
        05: Result := '05-Compensa��o Convencional';
        06: Result := '06-Por Meio Eletr�nico';
        07: Result := '07-Ap�s Feriado Local';
        08: Result := '08-Em Cart�rio';
        09: Result := '09-Comandada Banco';
        10: Result := '10-Comandada Cliente Arquivo';
        11: Result := '11-Comandada Cliente On-line';
        12: Result := '12-Decurso Prazo - Cliente';
        13: Result := '13-Decurso Prazo - Banco';
        14: Result := '14-Protestado';
        15: Result := '15-T�tulo Exclu�do';
        30: Result := '30-Liquida��o no Guich� de Caixa em Cheque';
        31: Result := '31-Liquida��o em banco correspondente';
        32: Result := '32-Liquida��o Terminal de Auto-Atendimento';
        33: Result := '33-Liquida��o na Internet (Home banking)';
        34: Result := '34-Liquidado Office Banking';
        35: Result := '35-Liquidado Correspondente em Dinheiro';
        36: Result := '36-Liquidado Correspondente em Cheque';
        37: Result := '37-Liquidado por meio de Central de Atendimento (Telefone)';
      end;
  end;
end;




procedure TACBrBancoBrasil.LerRetorno400(ARetorno: TStringList);
var
  Titulo : TACBrTitulo;
  ContLinha, CodOcorrencia, CodMotivo, i, MotivoLinha : Integer;
  CodMotivo_19, rAgencia, rDigitoAgencia, rConta, rDigitoConta, rCodigoCedente,
  Linha, rCedente, rCNPJCPF:String;
begin
   fpTamanhoMaximoNossoNum := 20;
   ContLinha := 0;

   if StrToIntDef(copy(ARetorno.Strings[0],77,3),-1) <> Numero then
      raise Exception.Create(ACBrStr(ACBrBanco.ACBrBoleto.NomeArqRetorno +
                             'n�o � um arquivo de retorno do '+ Nome));

   rCedente      := trim(Copy(ARetorno[0],47,30));
   rAgencia      := trim(Copy(ARetorno[0],27,4));
   rDigitoAgencia:= Copy(ARetorno[0],31,1);
   rConta        := trim(Copy(ARetorno[1],32,8));
   rDigitoConta  := Copy(ARetorno[0],40,1);
   
   rCodigoCedente:= Copy(ARetorno[0],150,7);


   ACBrBanco.ACBrBoleto.NumeroArquivo := StrToIntDef(Copy(ARetorno[0],101,7),0);

   ACBrBanco.ACBrBoleto.DataArquivo   := StringToDateTimeDef(Copy(ARetorno[0],95,2)+'/'+
                                                             Copy(ARetorno[0],97,2)+'/'+
                                                             Copy(ARetorno[0],99,2),0, 'DD/MM/YY' );

   case StrToIntDef(Copy(ARetorno[1],2,2),0) of
      11: rCNPJCPF := Copy(ARetorno[1],7,11);
      14: rCNPJCPF := Copy(ARetorno[1],4,14);
   else
     rCNPJCPF := Copy(ARetorno[1],4,14);
   end;


   with ACBrBanco.ACBrBoleto do
   begin
      if (not LeCedenteRetorno) and ((rAgencia <> OnlyNumber(Cedente.Agencia)) or
          (rConta <> OnlyNumber(Cedente.Conta))) then
         raise Exception.Create(ACBrStr('Agencia\Conta do arquivo inv�lido'));

      Cedente.Nome         := rCedente;
      If Copy(rCNPJCPF,1,10) <> '0000000000'
         Then Cedente.CNPJCPF      := rCNPJCPF;
      Cedente.Agencia      := rAgencia;
      Cedente.AgenciaDigito:= rDigitoAgencia;
      Cedente.Conta        := rConta;
      Cedente.ContaDigito  := rDigitoConta;
      Cedente.CodigoCedente:= rCodigoCedente;

      case StrToIntDef(Copy(ARetorno[1],2,2),0) of
         11: Cedente.TipoInscricao:= pFisica;
         else
            Cedente.TipoInscricao:= pJuridica;
      end;
      ACBrBanco.ACBrBoleto.ListadeBoletos.Clear;
   end;

   ACBrBanco.TamanhoMaximoNossoNum := 20;

   for ContLinha := 1 to ARetorno.Count - 2 do
   begin
      Linha := ARetorno[ContLinha] ;

      if (Copy(Linha,1,1) <> '7') and (Copy(Linha,1,1) <> '1') then
         Continue;

      Titulo := ACBrBanco.ACBrBoleto.CriarTituloNaLista;

      with Titulo do
      begin
         SeuNumero                   := copy(Linha,39,25);
         NumeroDocumento             := copy(Linha,117,10);
         OcorrenciaOriginal.Tipo     := CodOcorrenciaToTipo(StrToIntDef(
                                        copy(Linha,109,2),0));

         CodOcorrencia := StrToInt(IfThen(copy(Linha,109,2) = '00','00',copy(Linha,109,2)));

         if(CodOcorrencia = 3)then
         begin
           CodMotivo:= StrToInt(IfThen(copy(Linha,MotivoLinha,2) = '00','00',copy(Linha,87,2)));
           MotivoRejeicaoComando.Add(copy(Linha,87,2));
           DescricaoMotivoRejeicaoComando.Add(CodMotivoRejeicaoToDescricao(OcorrenciaOriginal.Tipo,CodMotivo));
         end;

         DataOcorrencia := StringToDateTimeDef( Copy(Linha,111,2)+'/'+
                                                Copy(Linha,113,2)+'/'+
                                                Copy(Linha,115,2),0, 'DD/MM/YY' );

         Vencimento := StringToDateTimeDef( Copy(Linha,147,2)+'/'+
                                            Copy(Linha,149,2)+'/'+
                                            Copy(Linha,151,2),0, 'DD/MM/YY' );

         ValorDocumento       := StrToFloatDef(Copy(Linha,153,13),0)/100;
         ValorIOF             := StrToFloatDef(Copy(Linha,215,13),0)/100;
         ValorAbatimento      := StrToFloatDef(Copy(Linha,228,13),0)/100;
         ValorDesconto        := StrToFloatDef(Copy(Linha,241,13),0)/100;
         ValorRecebido        := StrToFloatDef(Copy(Linha,254,13),0)/100;
         ValorMoraJuros       := StrToFloatDef(Copy(Linha,267,13),0)/100;
         ValorOutrosCreditos  := StrToFloatDef(Copy(Linha,280,13),0)/100;
         NossoNumero          := Copy(Linha,64,17);
         Carteira             := Copy(Linha,92,3);
//         ValorDespesaCobranca := StrToFloatDef(Copy(Linha,176,13),0)/100;
         ValorOutrasDespesas  := StrToFloatDef(Copy(Linha,189,13),0)/100;

         if StrToIntDef(Copy(Linha,296,6),0) <> 0 then
            DataCredito:= StringToDateTimeDef( Copy(Linha,176,2)+'/'+
                                               Copy(Linha,178,2)+'/'+
                                               Copy(Linha,180,2),0, 'DD/MM/YY' );
      end;
   end;

   fpTamanhoMaximoNossoNum := 10;
end;



end.
