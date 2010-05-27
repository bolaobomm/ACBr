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
  {$IFDEF COMPILER6_UP} dateutils {$ELSE} ACBrD5 {$ENDIF};

type
  { TACBrBancoBrasil}

  TACBrBancoBrasil = class(TACBrBancoClass)
   protected
   public
    Constructor create(AOwner: TACBrBanco);
    function CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String; override ;
    function MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroHeader(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler(ARemessa : TStringList): String;  override;
   end;

implementation

uses ACBrUtil, StrUtils, Variants;

constructor TACBrBancoBrasil.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 9;
   fpNome   := 'Banco Brasil';
   fpTamanhoMaximoNossoNum := 11;
end;

function TACBrBancoBrasil.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
begin
   Result := '0';

   Modulo.CalculoPadrao;
   Modulo.MultiplicadorFinal := 7;
   Modulo.Documento := ACBrTitulo.Carteira + ACBrTitulo.NossoNumero;
   Modulo.Calcular;

   if Modulo.DigitoFinal = 0 then
      Result:= 'P'
   else
      Result:= IntToStr(Modulo.DigitoFinal);
end;

function TACBrBancoBrasil.MontarCodigoBarras(const ACBrTitulo : TACBrTitulo): String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras :String;
  ANossoNumero, AConvenio : string;
begin
    AConvenio := ACBrTitulo.ACBrBoleto.Cedente.Convenio;
    with ACBrTitulo do
    begin

        if (ACBrTitulo.Carteira = '16') or (ACBrTitulo.Carteira = '17') or (ACBrTitulo.Carteira = '18') then
        begin
          if     Length(AConvenio) <= 4 then
                 ANossoNumero := padL(AConvenio, 4, '0') + padL(NossoNumero, 7, '0')

          else if (Length(AConvenio) > 4) and (Length(AConvenio) <= 6) then
                 ANossoNumero := padL(AConvenio, 6, '0') + padL(NossoNumero, 5, '0')

          else if Length(AConvenio) = 7 then
                 ANossoNumero := padL(AConvenio, 7, '0') + padL(NossoNumero, 10, '0');
        end else ANossoNumero := padL(NossoNumero, 11, '0');
    end;

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

function TACBrBancoBrasil.GerarRegistroHeader(NumeroRemessa : Integer): String;
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

      Result:= IntToStrZero(ACBrBanco.Numero, 3)       + //1 a 3 - C�digo do banco
               '0000'                                  + //4 a 7 - Lote de servi�o
               '0'                                     + //8 - Tipo de registro - Registro header de arquivo
               padL('', 9, ' ')                        + //9 a 17 Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                           + //18 - Tipo de inscri��o do cedente
               padL(CNPJCPF, 14, '0')                  + //19 a 32 -N�mero de inscri��o do cedente
               padL(CodigoCedente, 18, '0') + '  '     + //33 a 52 - C�digo do conv�nio no banco [ Alterado conforme instru��es da CSO Bras�lia ] 27-07-09
               padL(Agencia, 5, '0')                   + //53 a 57 - C�digo da ag�ncia do cedente
               padL(AgenciaDigito, 1 , '0')            + //58 - D�gito da ag�ncia do cedente
               padL(Conta, 12, '0')                    + //59 a 70 - N�mero da conta do cedente
               padL(ContaDigito, 1, '0')               + //71 - D�gito da conta do cedente
               ' '                                     + //72 - D�gito verificador da ag�ncia / conta
               padR(Nome, 30, ' ')                     + //73 a 102 - Nome do cedente
               padR('BANCO DO BRASIL', 30, ' ')        + //103 a 132 - Nome do banco
               padL('', 10, ' ')                       + //133 a 142 - Uso exclusivo FEBRABAN/CNAB
               '1'                                     + //143 - C�digo de Remessa (1) / Retorno (2)
               FormatDateTime('ddmmyyyy', Now)         + //144 a 151 - Data do de gera��o do arquivo
               FormatDateTime('hhmmss', Now)           + //152 a 157 - Hora de gera��o do arquivo
               padL(IntToStr(NumeroRemessa), 6, '0')   + //158 a 163 - N�mero seq�encial do arquivo
               '030'                                   + //164 a 166 - N�mero da vers�o do layout do arquivo
               padL('',  5, '0')                       + //167 a 171 - Densidade de grava��o do arquivo (BPI)
               padL('', 20, '0')                       + // 172 a 191 - Uso reservado do banco
               padL('', 20, '0')                       + // 192 a 211 - Uso reservado da empresa
               padL('', 11, '0')                       + // 212 a 222 - 11 brancos
               'CSP'                                   + // 223 a 225 - 'CSP'
               padL('',  3, '0')                       + // 226 a 228 - Uso exclusivo de Vans
               padL('',  2, '0')                       + // 229 a 230 - Tipo de servico
               padL('', 10, '0');                        //231 a 240 - titulo em carteira de cobranca

          { GERAR REGISTRO HEADER DO LOTE }

      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)       + //1 a 3 - C�digo do banco
               '0001'                                  + //4 a 7 - Lote de servi�o
               '1'                                     + //8 - Tipo de registro - Registro header de arquivo
               'R'                                     + //9 - Tipo de opera��o: R (Remessa) ou T (Retorno)
               '01'                                    + //10 a 11 - Tipo de servi�o: 01 (Cobran�a)
               '00'                                    + //12 a 13 - Forma de lan�amento: preencher com ZEROS no caso de cobran�a
               '020'                                   + //14 a 16 - N�mero da vers�o do layout do lote
               ' '                                     + //17 - Uso exclusivo FEBRABAN/CNAB
               ATipoInscricao                          + //18 - Tipo de inscri��o do cedente
               padL(CNPJCPF, 14, '0')                  + //19 a 32 -N�mero de inscri��o do cedente
               padL(CodigoCedente, 18, '0') + '  '     + //33 a 52 - C�digo do conv�nio no banco [ Alterado conforme instru��es da CSO Bras�lia ] 27-07-09
               padL(Agencia, 5, '0')                   + //53 a 57 - C�digo da ag�ncia do cedente
               padL(AgenciaDigito, 1 , '0')            + //58 - D�gito da ag�ncia do cedente
               padL(Conta, 12, '0')                    + //59 a 70 - N�mero da conta do cedente
               padL(ContaDigito, 1, '0')               + //71 - D�gito da conta do cedente
               ' '                                     + //72 - D�gito verificador da ag�ncia / conta
               padR(Nome, 30, ' ')                     + //73 a 102 - Nome do cedente
               padL('', 40, ' ')                       + //104 a 143 - Mensagem 1 para todos os boletos do lote
               padL('', 40, ' ')                       + //144 a 183 - Mensagem 2 para todos os boletos do lote
               padL(IntToStr(NumeroRemessa), 8, '0')   + //184 a 191 - N�mero do arquivo
               FormatDateTime('ddmmyyyy', Now)         + //192 a 199 - Data de gera��o do arquivo
               padL('', 8, '0')                        + //200 a 207 - Data do cr�dito - S� para arquivo retorno
               padL('', 33, ' ');                        //208 a 240 - Uso exclusivo FEBRABAN/CNAB
   end;
end;

function TACBrBancoBrasil.GerarRegistroTransacao(ACBrTitulo : TACBrTitulo): String;
var ATipoInscricao, ATipoOcorrencia, ATipoBoleto, ADataMoraJuros,
    ADataDesconto  : string;
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
            toRemessaConcederDesconto          : ATipoOcorrencia := '07';
            toRemessaCancelarDesconto          : ATipoOcorrencia := '08';
            toRemessaProtestar                 : ATipoOcorrencia := '09';
            toRemessaCancelarInstrucaoProtesto : ATipoOcorrencia := '10';
            toRemessaAlterarNomeEnderecoSacado : ATipoOcorrencia := '12';
            toRemessaDispensarJuros            : ATipoOcorrencia := '31';
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
               padL(ACBrBoleto.Cedente.Agencia, 5, '0')                   + //18 a 22 - Ag�ncia mantenedora da conta
               padL(ACBrBoleto.Cedente.AgenciaDigito, 1 , '0')            + //23 -D�gito verificador da ag�ncia
               padL(ACBrBoleto.Cedente.Conta, 12, '0')                    + //24 a 35 - N�mero da conta corrente
               padL(ACBrBoleto.Cedente.ContaDigito, 1, '0')               + //36 - D�gito verificador da conta
               ' '                                                        + //37 - D�gito verificador da ag�ncia / conta
               padR(NossoNumero, 20, '0')                                 + //38 a 57 - Nosso n�mero - identifica��o do t�tulo no banco
               '1'                                                        + //58 - Cobran�a Simples
               '1'                                                        + //59 - Forma de cadastramento do t�tulo no banco: com cadastramento
               '1'                                                        + //60 - Tipo de documento: Tradicional
               ATipoBoleto                                                + //61 a 62 - Quem emite e quem distribui o boleto?
               padL(NumeroDocumento, 10, '0') + '00000'                   + //63 a 72 - N�mero que identifica o t�tulo na empresa [ Alterado conforme instru��es da CSO Bras�lia ] {27-07-09}
               FormatDateTime('ddmmyyyy', Vencimento)                     + //78 a 85 - Data de vencimento do t�tulo
               IntToStrZero( round( ValorDocumento * 100), 13)            + //86 a 100 - Valor nominal do t�tulo
               padL('', 5, '0')                                           + //101 a 105 - Ag�ncia cobradora. Se ficar em branco, a caixa determina automaticamente pelo CEP do sacado
               ' '                                                        + //106 - D�gito da ag�ncia cobradora
               EspecieDoc                                                 + //107 a 108 - Esp�cie do documento
               IfThen(Aceite = 'S', 'A', 'N')                             + //109 - Identifica��o de t�tulo Aceito / N�o aceito
               FormatDateTime('ddmmyyyy', DataDocumento)                  + //110 a 117 - Data da emiss�o do documento
               IfThen(ValorMoraJuros > 0, '1', '0')                       + //118 - C�digo de juros de mora: Valor por dia
               ADataMoraJuros                                             + //119 a 126 - Data a partir da qual ser�o cobrados juros

               IfThen(ValorMoraJuros > 0, IntToStrZero( round(ValorMoraJuros * 100), 15),
                    padL('', 15, '0'))                                    + //127 a 141 - Valor de juros de mora por dia

               IfThen(ValorDesconto > 0, '1', '0')                        + //142 - C�digo de desconto: Valor fixo at� a data informada
               ADataDesconto                                              + //143 a 150 - Data do desconto

               IfThen(ValorDesconto > 0, IntToStrZero( round(ValorDesconto * 100), 15),
               padL('', 15, '0'))                                         + //151 a 165 - Valor do desconto por dia
               IntToStrZero( round(ValorIOF * 100), 15)                   + //166 a 180 - Valor do IOF a ser recolhido
               IntToStrZero( round(ValorAbatimento * 100), 13)            + //181 a 195 - Valor do abatimento
               padL(SeuNumero, 25, ' ')                                   + //196 a 220 - Identifica��o do t�tulo na empresa
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento), '1', '3') + //221 - C�digo de protesto: Protestar em XX dias corridos
               IfThen((DataProtesto <> null) and (DataProtesto > Vencimento),
                    padL(IntToStr(DaysBetween(DataProtesto, Vencimento)), 2, '0'), '00') + //222 a 223 - Prazo para protesto (em dias corridos)
               ' '                                                        + //224 - Campo n�o tratado pelo BB [ Alterado conforme instru��es da CSO Bras�lia ] {27-07-09}
               '   '                                                      + //225 a 227 - Campo n�o tratado pelo BB [ Alterado conforme instru��es da CSO Bras�lia ] {27-07-09}
               '09'                                                       + //228 a 229 - C�digo da moeda: Real 
               padL('', 10 , ' ')                                         + //230 a 239 - Uso exclusivo FEBRABAN/CNAB
               ' ';                                                         //240 - Uso exclusivo FEBRABAN/CNAB

         {SEGMENTO Q}
      Result:= Result + #13#10 +
               IntToStrZero(ACBrBanco.Numero, 3)                          + //C�digo do banco
               '0001'                                                     + //N�mero do lote
               '3'                                                        + //Tipo do registro: Registro detalhe
               IntToStrZero((2 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo))+ 2 ,5) + //N�mero seq�encial do registro no lote - Cada t�tulo tem 2 registros (P e Q)
               'Q'                                                        + //C�digo do segmento do registro detalhe
               ' '                                                        + //Uso exclusivo FEBRABAN/CNAB: Branco
                        {Dados do sacado}
               ATipoInscricao                                             + //Tipo inscricao
               padL(Sacado.CNPJCPF, 15, '0')                              +
               padL(Sacado.NomeSacado, 40, ' ')                                 +
               padL(Sacado.Logradouro +' '+ Sacado.Numero +' '+ Sacado.Complemento , 40, ' ') +
               padL(Sacado.Bairro, 15, ' ')                               +
               padR(Sacado.CEP, 8, '0')                                   +
               padR(Sacado.Cidade, 15, ' ')                               +
               padL(Sacado.UF, 2, ' ')                                    +
                        {Dados do sacador/avalista}
               '0'                                                        + //Tipo de inscri��o: N�o informado
               padL('', 15, '0')                                          + //N�mero de inscri��o
               padL('', 40, ' ')                                          + //Nome do sacador/avalista
               padL('', 3, ' ')                                           + //Uso exclusivo FEBRABAN/CNAB
               padL('',20, ' ')                                           + //Uso exclusivo FEBRABAN/CNAB
               padL('', 8, ' ');                                            //Uso exclusivo FEBRABAN/CNAB
      end; 
end;

function TACBrBancoBrasil.GerarRegistroTrailler( ARemessa : TStringList ): String;
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
