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

unit ACBrBancoItau;

interface

uses
  Classes, SysUtils, ACBrBoleto,
  {$IFDEF COMPILER6_UP} dateutils {$ELSE} ACBrD5 {$ENDIF};

type
  { TACBrBancoItau}

  TACBrBancoItau = class(TACBrBancoClass)
   protected
   public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String; override ;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function MontarCampoNossoNumero ( const ACBrTitulo: TACBrTitulo) : String; override;
    function GerarRegistroHeader(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler(ARemessa : TStringList): String;  override;
   end;

implementation

uses ACBrUtil, StrUtils, Variants;

constructor TACBrBancoItau.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 9;
   fpNome   := 'Banco Itau';
   fpTamanhoMaximoNossoNum := 8
end;

function TACBrBancoItau.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
begin
   Result := '0';

   Modulo.CalculoPadrao;
   Modulo.MultiplicadorFinal := 10;
   Modulo.Documento :=  padL(ACBrTitulo.ACBrBoleto.Cedente.Agencia,4,'0')
    + padL(ACBrTitulo.ACBrBoleto.Cedente.Conta,5,'0') +
    padL(ACBrTitulo.Carteira,3,'0') + ACBrTitulo.NossoNumero;
   Modulo.Calcular;
   Result:= IntToStr(Modulo.DigitoFinal);
end;

function TACBrBancoItau.MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras :String;
  ANossoNumero, AConvenio : string;
begin
    AConvenio := ACBrTitulo.ACBrBoleto.Cedente.Convenio;

    {Codigo de Barras}
    with ACBrTitulo.ACBrBoleto do
    begin
      FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);

      CodigoBarras := IntToStr( Numero ) +
                      '9' +
                      FatorVencimento +
                      IntToStrZero(Round(ACBrTitulo.ValorDocumento * 100), 10) +
                      ANossoNumero +
                      padL(Cedente.Agencia, 4, '0') +
                      padL(Cedente.Conta, 8, '0') +
                      copy(ACBrTitulo.Carteira, 1, 2);

     DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
    end;


    Result:= copy( CodigoBarras, 1, 4) + DigitoCodBarras + copy( CodigoBarras, 6, 44) ;
end;

function TACBrBancoItau.MontarCampoNossoNumero ( const ACBrTitulo: TACBrTitulo
   ) : String;
begin
   Result := inherited MontarCampoNossoNumero ( ACBrTitulo ) ;
end;

function TACBrBancoItau.GerarRegistroHeader(NumeroRemessa : Integer): String;
var
  ATipoInscricao: string;
begin

   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      case TipoInscricao of
         tiPessoaFisica  : ATipoInscricao := '1';
         tiPessoaJuridica: ATipoInscricao := '2';
         tiOutro         : ATipoInscricao := '3';
      end;

          { GERAR REGISTRO-HEADER DO ARQUIVO }

      Result:= IntToStrZero(ACBrBanco.Numero, 3)        + //1 a 3 - C�digo do banco
               '0000'                                   + //4 a 7 - Lote de servi�o
               '0'                                      + //8 - Tipo de registro - Registro header de arquivo
               padL('', 9, ' ')                         + //9 a 17 Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                           + //18 - Tipo de inscri��o do cedente
               padL(CNPJCPF, 14, '0')                   + //19 a 32 -N�mero de inscri��o do cedente
               padL(' ', 20, ' ')                       + // 33 a 52 - Brancos
               '0'                                      + // 53 - Zeros
               padL(Agencia, 4, '0')                    + //54 a 57 - C�digo da ag�ncia do cedente
               ' '                                      + // 58 - Brancos
               '0000000'                                + // 59 a 65 - Zeros
               padL(Conta, 5, '0')                      + // 66 a 70 - N�mero da conta do cedente
               ' '                                      + // 71 - Branco
               padL(ContaDigito, 1, '0')                + // 72 - D�gito da conta do cedente
               padR(Nome, 30, ' ')                      + // 73 a 102 - Nome do cedente
               padR('BANCO ITAU', 30, ' ')              + // 103 a 132 - Nome do banco
               '          '                             + // 133 A 142 - Brancos
               '1'                                      + // 143 - C�digo de Remessa (1) / Retorno (2)
               FormatDateTime('ddmmyyyy', Now)          + // 144 a 151 - Data do de gera��o do arquivo
               FormatDateTime('hhmmss', Now)            + // 152 a 157 - Hora de gera��o do arquivo
               '000000'                                 + // 158 a 163 - N�mero sequencial do arquivo retorno
               '040'                                    + // 164 a 166 - N�mero da vers�o do layout do arquivo
               '00000'                                  + // 167 a 171 - Zeros
               padL(' ', 54, ' ')                       + // 172 a 225 - 54 Brancos
               '000'                                    + // 226 a 228 - zeros
               padL(' ', 12, ' ');                      // 229 a 240 - Brancos

     { GERAR REGISTRO HEADER DO LOTE }

      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)       + //1 a 3 - C�digo do banco
               '0001'                                  + //4 a 7 - Lote de servi�o
               '1'                                     + //8 - Tipo de registro - Registro header de arquivo
               'R'                                     + //9 - Tipo de opera��o: R (Remessa) ou T (Retorno)
               '01'                                    + //10 a 11 - Tipo de servi�o: 01 (Cobran�a)
               '00'                                    + //12 a 13 - Forma de lan�amento: preencher com ZEROS no caso de cobran�a
               '030'                                   + //14 a 16 - N�mero da vers�o do layout do lote
               ' '                                     + //17 - Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                          + //18 - Tipo de inscri��o do cedente
               padL(CNPJCPF, 14, '0')                  + //19 a 33 -N�mero de inscri��o do cedente
               padL(' ', 20, ' ')                      + //34 a 53 - Brancos
               '0'                                     + // 54 - Zeros
               padL(Agencia, 5, '0')                   + //55 a 58 - C�digo da ag�ncia do cedente
               ' '                                     + // 59
               '0000000'                               + // 60 a 66
               padL(Conta, 12, '0')                    + //67 a 71 - N�mero da conta do cedente
               ' '                                     + // 72
               ' '                                     + // 73 - D�gito verificador da ag�ncia / conta
               padR(Nome, 30, ' ')                     + //74 a 103 - Nome do cedente
               padL(' ', 80, ' ')                      + // 104 a 183 - Brancos
               '00000000'                              + // 184 a 191 - N�mero sequ�ncia do arquivo retorno.
            //   padL(IntToStr(NumeroRemessa), 8, '0')   + //184 a 191 - N�mero do arquivo
               FormatDateTime('ddmmyyyy', Now)         + //192 a 199 - Data de gera��o do arquivo
               padL('', 8, '0')                        + //200 a 207 - Data do cr�dito - S� para arquivo retorno
               padL('', 33, ' ');                        //208 a 240 - Uso exclusivo FEBRABAN/CNAB
   end;
end;

function TACBrBancoItau.GerarRegistroTransacao(ACBrTitulo : TACBrTitulo): String;
var ATipoInscricao, ATipoOcorrencia, ATipoBoleto, ADataMoraJuros, 
    ADataDesconto : string;
begin
   with ACBrTitulo do
   begin
         {SEGMENTO P}

         {Pegando tipo de pessoa do Cendente}
         case ACBrBoleto.Cedente.TipoInscricao of
            tiPessoaFisica  : ATipoInscricao := '1';
            tiPessoaJuridica: ATipoInscricao := '2';
            tiOutro         : ATipoInscricao := '9';
         end;

         {Pegando o Tipo de Ocorrencia}
         case TipoOcorrencia of
            toRemessaBaixar                    : ATipoOcorrencia := '02';
            toRemessaConcederAbatimento        : ATipoOcorrencia := '04';
            toRemessaCancelarAbatimento        : ATipoOcorrencia := '05';
            toRemessaAlterarVencimento         : ATipoOcorrencia := '06';
          //  toRemessaConcederDesconto          : ATipoOcorrencia := '07';
          //  toRemessaCancelarDesconto          : ATipoOcorrencia := '08';
            toRemessaSustarProtesto            : ATipoOcorrencia := '18';
            toRemessaCancelarInstrucaoProtesto : ATipoOcorrencia := '10';
          //  toRemessaAlterarNomeEnderecoSacado : ATipoOcorrencia := '12';

          //  toRemessaDispensarJuros            : ATipoOcorrencia := '31';
         else
            ATipoOcorrencia := '01';
         end;

         {Pegando Tipo de Boleto} //Quem emite e quem distribui o boleto?
         case ACBrBoleto.Cedente.TipoBoleto of
              tbCliEmite        : ATipoBoleto := '1' + '1';
              tbBancoEmite      : ATipoBoleto := '2' + '2';
              tbBancoReemite    : ATipoBoleto := '4' + '1';
              tbBancoNaoReemite : ATipoBoleto := '5' + '2';
         end;

         {Mora Juros}
         if (ValorMoraJuros > 0) then
         begin
             if   (DataMoraJuros <> Null) then
                  ADataMoraJuros := FormatDateTime('ddmmyyyy', DataMoraJuros)
             else ADataMoraJuros := padL('', 8, '0');
         end else ADataMoraJuros := padL('', 8, '0');

         {Descontos}
         if (ValorDesconto > 0) then
         begin
            if    (DataDesconto <> Null) then
                  ADataDesconto := FormatDateTime('ddmmyyyy', DataDesconto)
            else  ADataDesconto := padL('', 8, '0');
         end else ADataDesconto := padL('', 8, '0');

      Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //1 a 3 - C�digo do banco
               '0001'                                                     + //4 a 7 - Lote de servi�o
               '3'                                                        + //8 - Tipo do registro: Registro detalhe
               IntToStrZero(ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo)+ 2 ,5) + //9 a 13 - N�mero seq�encial do registro no lote - Cada t�tulo tem 2 registros (P e Q)
               'P'                                                        + //14 - C�digo do segmento do registro detalhe
               ' '                                                        + //15 - Uso exclusivo FEBRABAN/CNAB: Branco
               ATipoOcorrencia                                            + //16 a 17 - C�digo de movimento
               '0'                                                        + // 18
               padL(ACBrBoleto.Cedente.Agencia, 4, '0')                   + //19 a 22 - Ag�ncia mantenedora da conta
               ' '                                                        + // 23
          //     padL(ACBrBoleto.Cedente.AgenciaDigito, 1 , '0')            + //23 -D�gito verificador da ag�ncia
               padL(ACBrBoleto.Cedente.Conta, 12, '0')                    + //24 a 35 - N�mero da conta corrente
               ' '                                                        + // 36
         //      padL(ACBrBoleto.Cedente.ContaDigito, 1, '0')               + //36 - D�gito verificador da conta
               ' '                                                        + //37 - D�gito verificador da ag�ncia / conta
               padR(Carteira, 3, '0')                                     + // 38 a 40 - Carteira
               padR(NossoNumero, 8, '0')                                  + // 41 a 48 - Nosso n�mero - identifica��o do t�tulo no banco
               ' '                                                        + // 49 - D�gito verificador da ag�ncia / conta preencher somente em cobran�a sem registro
               '        '                                                 + // 50 a 57 - Brancos
               padL(NumeroDocumento, 10, '0')                             + // 63 a 72 - N�mero que identifica o t�tulo na empresa [ Alterado conforme instru��es da CSO Bras�lia ] {27-07-09}
               '     '                                                    + // 73 a 77 - Brancos
               FormatDateTime('ddmmyyyy', Vencimento)                     + // 78 a 85 - Data de vencimento do t�tulo
               IntToStrZero( round( ValorDocumento * 100), 13)            + // 86 a 100 - Valor nominal do t�tulo
               '00000'                                                    + // 101 a 105 - Ag�ncia cobradora. // Ficando com Zeros o Ita� definir� a ag�ncia cobradora pelo CEP do sacado
               ' '                                                        + // 106 - D�gito da ag�ncia cobradora
               EspecieDoc                                                 + // 107 a 108 - Esp�cie do documento
               IfThen(Aceite = 'S', 'A', 'N')                             + // 109 - Identifica��o de t�tulo Aceito / N�o aceito
               FormatDateTime('ddmmyyyy', DataDocumento)                  + // 110 a 117 - Data da emiss�o do documento
               '0'                                                        + // 118 - Zeros
               ADataMoraJuros                                             + //119 a 126 - Data a partir da qual ser�o cobrados juros
               IfThen(ValorMoraJuros > 0, IntToStrZero( round(ValorMoraJuros * 100), 15),
                padL('', 15, '0'))                                        + //127 a 141 - Valor de juros de mora por dia
//               ValorMoraJuros                                             + //127 a 141 - Valor de Mora por dia de atraso
               '0'                                                        + // 142 - Zeros
               ADataDesconto                                             + // 143 a 150 - Data limite para desconto
               IfThen(ValorDesconto > 0, IntToStrZero( round(ValorDesconto * 100), 15),
               padL('', 15, '0'))                                         + //151 a 165 - Valor do desconto por dia
               IntToStrZero( round(ValorIOF * 100), 15)                   + //166 a 180 - Valor do IOF a ser recolhido
               IntToStrZero( round(ValorAbatimento * 100), 13)            + //181 a 195 - Valor do abatimento
               padL(SeuNumero, 25, ' ')                                   + //196 a 220 - Identifica��o do t�tulo na empresa
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento), '1', '3') + //221 - C�digo de protesto: Protestar em XX dias corridos
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento),
                    padL(IntToStr(DaysBetween(DataProtesto, Vencimento)), 2, '0'), '00') + //222 a 223 - Prazo para protesto (em dias corridos)
               '0'                                                        + // 224 - C�digo de Baixa
               '00'                                                       + // 225 A 226 - Dias para baixa
               '0000000000000 ';

      {SEGMENTO Q}
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                          + //C�digo do banco
               '0001'                                                     + //N�mero do lote
               '3'                                                        + //Tipo do registro: Registro detalhe
               IntToStrZero((2 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+ 2 ,5) + //N�mero seq�encial do registro no lote - Cada t�tulo tem 2 registros (P e Q)
               'Q'                                                        + //C�digo do segmento do registro detalhe
               ' '                                                        + //Uso exclusivo FEBRABAN/CNAB: Branco
               '01'                                                       + // 16 a 17
                        {Dados do sacado}
               ATipoInscricao                                             + // 18 a 18 Tipo inscricao
               padL(Sacado.CNPJCPF, 15, '0')                              + // 19 a 33
               padL(Sacado.NomeSacado, 40, ' ')                           + // 34 a 63
               '          '                                               + // 64 a 73
               padL(Sacado.Logradouro +' '+ Sacado.Numero +' '+ Sacado.Complemento , 40, ' ') + // 74 a 113
               padL(Sacado.Bairro, 15, ' ')                               +  // 114 a 128
               padR(Sacado.CEP, 8, '0')                                   +  // 129 a 136
               padR(Sacado.Cidade, 15, ' ')                               +  // 137 a 151
               padL(Sacado.UF, 2, ' ')                                    +  // 152 a 153
                        {Dados do sacador/avalista}
               '0'                                                        + //Tipo de inscri��o: N�o informado
               padL('', 15, '0')                                          + //N�mero de inscri��o
               padL('', 30, ' ')                                          + //Nome do sacador/avalista
               padL('', 10, ' ')                                           + //Uso exclusivo FEBRABAN/CNAB
               padL('0',3, '0')                                           + //Uso exclusivo FEBRABAN/CNAB
               padL('', 28, ' ');                                            //Uso exclusivo FEBRABAN/CNAB
      end;
end;

function TACBrBancoItau.GerarRegistroTrailler( ARemessa : TStringList ): String;
begin
          {REGISTRO TRAILER DO LOTE}
      Result:= IntToStrZero(ACBrBanco.Numero, 3)                          + //C�digo do banco
               '0001'                                                     + //N�mero do lote
               '5'                                                        + //Tipo do registro: Registro trailer do lote
               Space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB
               IntToStrZero(ARemessa.Count, 6)                            + //Quantidade de Registro da Remessa
               padL('', 6, '0')                                           + //Quantidade t�tulos em cobran�a
               padL('',17, '0')                                           + //Valor dos t�tulos em carteiras}
               Space(23)                                                  + //Uso exclusivo FEBRABAN/CNAB}
               padL('', 6, '0')                                           + //Quantidade t�tulos em cobran�a
               padL('',17, '0')                                           + //Valor dos t�tulos em carteiras}
               padL('',31, '0')                                           + //Quantidade t�tulos em cobran�a
               padL('',117,'0')                                           ;

          {GERAR REGISTRO TRAILER DO ARQUIVO}
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                          + //C�digo do banco
               '9999'                                                     + //Lote de servi�o
               '9'                                                        + //Tipo do registro: Registro trailer do arquivo
               space(9)                                                   + //Uso exclusivo FEBRABAN/CNAB}
               '000001'                                                   + //Quantidade de lotes do arquivo}
               IntToStrZero(ARemessa.Count, 6)                            + //Quantidade de registros do arquivo, inclusive este registro que est� sendo criado agora}
               space(6)                                                   + //Uso exclusivo FEBRABAN/CNAB}
               space(205);                                                  //Uso exclusivo FEBRABAN/CNAB}

end;

end.
