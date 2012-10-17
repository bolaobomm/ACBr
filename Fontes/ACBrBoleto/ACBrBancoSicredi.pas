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

unit ACBrBancoSicredi;

interface

uses
  Classes, SysUtils,ACBrBoleto,
  {$IFDEF COMPILER6_UP} dateutils {$ELSE} ACBrD5 {$ENDIF};

type

  { TACBrBancoSicredi }

  TACBrBancoSicredi = class(TACBrBancoClass)
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
    procedure LerRetorno400(ARetorno: TStringList); override;

    function GerarRegistroHeader240(NumeroRemessa : Integer): String; override;
    function GerarRegistroTransacao240(ACBrTitulo : TACBrTitulo): String; override;
    function GerarRegistroTrailler240(ARemessa:TStringList): String;  override;
    procedure LerRetorno240(ARetorno: TStringList); override;

    function TipoOcorrenciaToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia): String; override;
    function CodOcorrenciaToTipo(const CodOcorrencia:Integer): TACBrTipoOcorrencia; override;
    function TipoOCorrenciaToCod(const TipoOcorrencia: TACBrTipoOcorrencia): String; override;
    function CodMotivoRejeicaoToDescricao(const TipoOcorrencia: TACBrTipoOcorrencia;CodMotivo:Integer): String; override;
  end;

implementation

uses ACBrUtil, StrUtils;

{ TACBrBancoSicredi }


constructor TACBrBancoSicredi.create(AOwner: TACBrBanco);
begin
   inherited create(AOwner);
   fpDigito := 10;
   fpNome   := 'Sicredi';
   fpNumero:= 748;
   fpTamanhoMaximoNossoNum := 8;
   fpTamanhoAgencia := 4;
   fpTamanhoConta   := 5;
   fpTamanhoCarteira:= 1;
end;

function TACBrBancoSicredi.CalcularDigitoVerificador(const ACBrTitulo: TACBrTitulo ): String;
begin
   Modulo.CalculoPadrao;
   Modulo.Documento := ACBrTitulo.ACBrBoleto.Cedente.Agencia +
                       ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito +
                       ACBrTitulo.ACBrBoleto.Cedente.CodigoCedente +
                       ACBrTitulo.NossoNumero;
   Modulo.Calcular;

   if (Modulo.DigitoFinal > 9) then
         result := '0'
      else
         Result := IntToStr(Modulo.DigitoFinal);
end;

function TACBrBancoSicredi.MontarCodigoBarras ( const ACBrTitulo: TACBrTitulo) : String;
var
  CodigoBarras, FatorVencimento, DigitoCodBarras, CampoLivre, Modalidade:String;
  DigitoNum: Integer;
begin
   with ACBrTitulo.ACBrBoleto do
   begin
      FatorVencimento := CalcularFatorVencimento(ACBrTitulo.Vencimento);
      Modalidade := IfThen(Cedente.Modalidade='','1',Cedente.Modalidade);

      { Monta o campo livre }
      CampoLivre :=   Modalidade                            + { 1-Sem registro ou 3-Com registro. Por enquanto vou deixar 1 mais tenho que tratar menhor essa informa��o }
                      '1'                                   + { 1-Carteira simples }
                      padR(ACBrTitulo.NossoNumero,8,'0')    + { Nosso n�mero }
                      CalcularDigitoVerificador(ACBrTitulo) + { D�gito verificador do nosso n�mero }
                      Cedente.Agencia                       + { C�digo ag�ncia (cooperativa) }
                      padR(Cedente.AgenciaDigito,2,'0')     + { D�gito da ag�ncia (posto da cooperativa) }
                      Cedente.Conta                         + { C�digo cedente = N�mero da conta }
                      '1'                                   + { Filler - zero. Obs: Ser� 1 quando o valor do documento for diferente se zero }
                      '0';                                    { Filler - zero }
      { Calcula o d�gito do campo livre }
      Modulo.CalculoPadrao;
      Modulo.MultiplicadorFinal := 9;
      Modulo.Documento := CampoLivre;
      Modulo.Calcular;
      CampoLivre := CampoLivre + IntToStr(Modulo.DigitoFinal);

      { Monta o c�digo de barras }
      CodigoBarras := IntToStr( Numero )                                     + { C�digo do banco 748 }
                      '9'                                                    + { Fixo '9' }
                      FatorVencimento                                        + { Fator de vencimento, n�o obrigat�rio }
                      IntToStrZero(Round(ACBrTitulo.ValorDocumento*100),10)  + { valor do documento }
                      CampoLivre;                                              { Campo Livre }



      DigitoCodBarras := CalcularDigitoCodigoBarras(CodigoBarras);
      DigitoNum := StrToIntDef(DigitoCodBarras,0);

      if (DigitoNum = 0) or (DigitoNum > 9) then
          DigitoCodBarras:= '1';
   end;

   Result:= IntToStr(Numero) + '9'+ DigitoCodBarras + Copy(CodigoBarras,5,39);
end;

function TACBrBancoSicredi.MontarCampoNossoNumero (const ACBrTitulo: TACBrTitulo ) : String;
begin
   ACBrTitulo.NossoNumero:=FormatDateTime('yy',date)+'2'+copy(ACBrTitulo.NossoNumero,4,6);
   Result:= copy(ACBrTitulo.NossoNumero,1,2)+'/'+copy(ACBrTitulo.NossoNumero,3,6)+'-'+CalcularDigitoVerificador(ACBrTitulo);
end;

function TACBrBancoSicredi.MontarCampoCodigoCedente (const ACBrTitulo: TACBrTitulo ) : String;
begin
   ACBrTitulo.ACBrBoleto.Cedente.Conta:= IntToStrZero(StrToInt64(ACBrTitulo.ACBrBoleto.Cedente.Conta), fpTamanhoConta );
   Result := ACBrTitulo.ACBrBoleto.Cedente.Agencia+'.'+
             ACBrTitulo.ACBrBoleto.Cedente.AgenciaDigito+'.'+
             ACBrTitulo.ACBrBoleto.Cedente.Conta;
end;

function TACBrBancoSicredi.GerarRegistroHeader400(NumeroRemessa : Integer): String;
begin
   with ACBrBanco.ACBrBoleto.Cedente do
   begin
      Result:= '0'                               + // ID do Registro
               '1'                               + // ID do Arquivo( 1 - Remessa)
               'REMESSA'                         + // Literal de Remessa
               '01'                              + // C�digo do Tipo de Servi�o
               padL( 'COBRANCA', 15 )            + // Descri��o do tipo de servi�o
               padR( CodigoCedente, 5, '0')      + // Codigo da Empresa no Banco
               padR( OnlyNumber(CNPJCPF), 14, '0')           + // CNPJ do Cedente
               Space(31)                         + // Fillers - Branco
               '748'                             + // N�mero do banco
               padL('SICREDI', 15)               + // C�digo e Nome do Banco(237 - Bradesco)
               FormatDateTime('yyyymmdd',Now)    + // Data de gera��o do arquivo
               Space(8)                          + // Filler - Brancos
               IntToStrZero(NumeroRemessa,7)     + // Nr. Sequencial de Remessa + brancos
               Space(273)                        + // Filler - Brancos
               '2.00'                            + // Vers�o do sistema
               IntToStrZero(1,6);                  // Nr. Sequencial de Remessa + brancos + Contador

      Result:= UpperCase(Result);
   end;
end;

function TACBrBancoSicredi.GerarRegistroTransacao400(ACBrTitulo :TACBrTitulo): String;
var
  DigitoNossoNumero, Ocorrencia, CodProtesto, DiasProtesto: String;
  TipoSacado: String;
  TipoBoleto: Char;
  AceiteStr: String;
begin

   with ACBrTitulo do
   begin
      DigitoNossoNumero := CalcularDigitoVerificador(ACBrTitulo);

      {Pegando C�digo da Ocorrencia}
      case OcorrenciaOriginal.Tipo of
         toRemessaBaixar                         : Ocorrencia := '02'; {Pedido de Baixa}
         toRemessaConcederAbatimento             : Ocorrencia := '04'; {Concess�o de Abatimento}
         toRemessaCancelarAbatimento             : Ocorrencia := '05'; {Cancelamento de Abatimento concedido}
         toRemessaAlterarVencimento              : Ocorrencia := '06'; {Altera��o de vencimento}
         //toRemessaAlterarNumeroControle         : Ocorrencia := '08'; {Altera��o de seu n�mero}
         toRemessaProtestar                      : Ocorrencia := '09'; {Pedido de protesto}
         toRemessaCancelarInstrucaoProtestoBaixa : Ocorrencia := '18'; {Sustar protesto e baixar}
         toRemessaCancelarInstrucaoProtesto      : Ocorrencia := '19'; {Sustar protesto e manter na carteira}
         toRemessaOutrasOcorrencias              : Ocorrencia := '31'; {Altera��o de Outros Dados}
      else
         Ocorrencia := '01';                                          {Remessa}
      end;

      {Pegando Tipo de Boleto}
      case ACBrBoleto.Cedente.ResponEmissao of
         tbCliEmite : TipoBoleto := 'B';
      else
         TipoBoleto := 'A';
      end;

      {Pegando campo Protesto}
      if (DataProtesto > 0) and (DataProtesto >= Vencimento + 3) then // m�nimo de 3 dias de protesto
      begin
         CodProtesto := '06';
         DiasProtesto := IntToStrZero(DaysBetween(DataProtesto,Vencimento),2);
      end
      else
      begin
         CodProtesto := '00';
         DiasProtesto := '00';
      end;

      {Pegando Tipo de Sacado}
      case Sacado.Pessoa of
         pFisica   : TipoSacado := '1';
         pJuridica : TipoSacado := '2';
      else
         TipoSacado := '9';
      end;

      { Pegando o tipo de EspecieDoc }
      if EspecieDoc = 'DMI' then
         EspecieDoc   := 'A'
      else if EspecieDoc = 'DR' then
         EspecieDoc   := 'B'
      else if EspecieDoc = 'NP' then
         EspecieDoc   := 'C'
      else if EspecieDoc = 'NR' then
         EspecieDoc   := 'D'
      else if EspecieDoc = 'NS' then
         EspecieDoc   := 'E'
      else if EspecieDoc = 'RC' then
         EspecieDoc   := 'G'
      else if EspecieDoc = 'LC' then
         EspecieDoc   := 'H'
      else if EspecieDoc = 'ND' then
         EspecieDoc   := 'I'
      else if EspecieDoc = 'DSI' then
         EspecieDoc   := 'J'
      else if EspecieDoc = 'OS' then
         EspecieDoc   := 'K'
      else
         EspecieDoc := 'A';

      {Pegando o Aceite}
      case Aceite of
        atSim: AceiteStr := 'S';
        atNao: AceiteStr := 'N';
      end;

      with ACBrBoleto do
      begin
         Result:= '1'                                                     +  // 001 a 001 - Identifica��o do registro detalhe
                  'A'                                                     +  // 002 a 002 - Tipo de cobran�a = "A" SICREDI com registro
                  'A'                                                     +  // 003 a 003 - Tipo de carteira = "A" Simples
                  'A'                                                     +  // 004 a 004 - Tipo de impress�o = "A" Normal "B" Carn�
                  Space(12)                                               +  // 005 a 016 - Filler - Brancos
                  'A'                                                     +  // 017 a 017 - Tipo de moeda = "A" Real
                  'A'                                                     +  // 018 a 018 - Tipo de desconto: "A" Valor "B" percentual
                  'A'                                                     +  // 019 a 019 - Tipo de juro: "A" Valor "B" percentual
                  Space(28)                                               +  // 020 a 047 - Filler - Brancos
                  padR(NossoNumero+DigitoNossoNumero,9,'0')               +  // 048 a 056 - Nosso n�mero sem edi��o YYXNNNNND - YY=Ano, X-Emissao, NNNNN-Sequ�ncia, D-D�gito
                  Space(6)                                                +  // 057 a 062 - Filler - Brancos
                  FormatDateTime( 'yyyymmdd', date)                       +  // 063 a 070 - Data da instru��o
                  Space(1)                                                +  // 071 a 071 - Campo alterado, quando instru��o "31" Conforme tabela de instru��es
                  'N'                                                     +  // 072 a 072 - Postagem do t�tulo = "S" Para postar o t�tulo "N" N�o postar e remeter para o cedente
                  Space(1)                                                +  // 073 a 073 - Filler Brancos
                  TipoBoleto                                              +  // 074 a 074 - Emiss�o do bloqueto = "A" Impress�o pelo SICREDI "B" Impress�o pelo Cedente
                  '00'                                                    +  // 075 a 076 - N�mero da parcela do carn�
                  '00'                                                    +  // 077 a 078 - N�mero total de parcelas do carn�
                  Space(4)                                                +  // 079 a 082 - Filler - Brancos
                  IntToStrZero( round( ValorDesconto * 100), 10)          +  // 083 a 092 - Valor de desconto por dia de antecipa��o
                  IntToStrZero( round( PercentualMulta * 100 ), 4)        +  // 093 a 096 - % multa por pagamento em atraso
                  Space(12)                                               +  // 097 a 108 - Filler - Brancos
                  '01'                                                    +  // 109 a 110 - Instru��o = "01" Cadastro de t�tulo
                  padL( NumeroDocumento,  10)                             +  // 111 a 120 - Seu n�mero
                  FormatDateTime( 'ddmmyy', Vencimento)                   +  // 121 a 126 - Data de vencimento
                  IntToStrZero( Round( ValorDocumento * 100 ), 13)        +  // 127 a 139 - Valor do t�tulo
                  Space(9)                                                +  // 140 a 148 - Filler - Brancos
                  EspecieDoc                                              +  // 149 a 149 - Esp�cie de documento
                  AceiteStr                                               +  // 150 a 150 - Aceite do t�tulo
                  FormatDateTime( 'ddmmyy', DataDocumento )               +  // 151 a 156 - Data de emiss�o
                  CodProtesto                                             +  // 157 a 158 - Instru��o de protesto autom�tico = "00" N�o protestar "06" Protestar automaticamente
                  DiasProtesto                                            +  // 159 a 160 - N�mero de dias para protesto autom�tico
                  IntToStrZero( round(ValorMoraJuros * 100 ), 13)         +  // 161 a 173 - Valor/% de juros por dia de atraso
                  IfThen(DataDesconto < EncodeDate(2000,01,01),'000000',
                         FormatDateTime( 'ddmmyy', DataDesconto))         +  // 174 a 179 - Data limite para concess�o de desconto
                  IntToStrZero( round( ValorDesconto * 100 ), 13)         +  // 180 a 192 - Valor/% do desconto
                  padL('', 13, '0')                                       +  // 193 a 205 - Filler - Zeros
                  IntToStrZero( round( ValorAbatimento * 100 ), 13)       +  // 206 a 218 - Valor do abatimento
                  TipoSacado                                              +  // 219 a 219 - Tipo de pessoa do sacado: PF ou PJ = "1" Pessoa F�sica "2" Pessoa Jur�dica
                  '0'                                                     +  // 220 a 220 - Filler - Zeros
                  padR(OnlyNumber(Sacado.CNPJCPF),14,'0')                 +  // 221 a 234 - CIC/CGC do sacado
                  padL( Sacado.NomeSacado, 40, ' ')                       +  // 235 a 274 - Nome do sacado
                  padL( Sacado.Logradouro +','+ Sacado.Numero +','+
                           Sacado.Bairro +','+ Sacado.Cidade +','+
                           Sacado.UF, 40)                                 +  // 275 a 314 - Endere�o do sacado
                  padL('', 5, '0')                                        +  // 315 a 319 - C�digo do sacado na cooperativa cedente (utilizar zeros)
                  padL('', 6, '0')                                        +  // 320 a 325 - Filler - Zeros
                  Space(1)                                                +  // 326 a 326 - Filler - Brancos
                  padL( OnlyNumber(Sacado.CEP), 8 )                       +  // 327 a 334 - CEP do sacado
                  padL('', 5, '0')                                        +  // 335 a 339 - C�digo do sacado junto ao cliente (zeros quando inexistente)
                  padL('', 14, ' ')                                       +  // 340 a 353 - CIC/CGC do sacador avalista
                  Space(41)                                               +  // 354 a 394 - Nome do sacador avalista
                  IntToStrZero( ListadeBoletos.IndexOf(ACBrTitulo)+2, 6 );   // 395 a 400 - N�mero sequencial do registro

         Result:= UpperCase(Result);
      end;
   end;
end;

function TACBrBancoSicredi.GerarRegistroTrailler400( ARemessa:TStringList ): String;
begin
  with ACBrBanco.ACBrBoleto.Cedente do begin
    Result:= '9'                                  + // 001 a 001 - Identifica��o do registro trailler
             '1'                                  + // 002 a 002 - Identifica��o do arquivo remessa
             '748'                                + // 003 a 005 - N�mero do SICREDI
             padR( CodigoCedente, 5, '0')         + // 006 a 010 - C�digo do cedente
             Space(384)                           + // 011 a 394 - Filler
             IntToStrZero( ARemessa.Count + 1, 6);  // 395 a 400 - N�mero sequencial do registro
  end;
   Result:= UpperCase(Result);
end;

procedure TACBrBancoSicredi.LerRetorno400(ARetorno: TStringList);
var
  Titulo : TACBrTitulo;
  ContLinha, CodOcorrencia, i, IdxMotivo: Integer;
  rAgencia, rDigitoAgencia, rConta, rDigitoConta,
  Linha, rCedente, rCNPJCPF, rCodCedente, rEspDoc: String;
begin
   fpTamanhoMaximoNossoNum := 20;
   ContLinha := 0;

   if StrToIntDef(copy(ARetorno[0],77,3),-1) <> Numero then
      raise Exception.Create(ACBrStr(ACBrBanco.ACBrBoleto.NomeArqRetorno +
                             'n�o � um arquivo de retorno do '+ Nome));

   rCNPJCPF      := trim(Copy(ARetorno[0],32,14));
   rCodCedente   := trim(Copy(ARetorno[0],27,5));
   rCedente      := ''; // n�o existe essa info no arquivo de retorno do Sicredi;
   rAgencia      := ''; // n�o existe essa info no arquivo de retorno do Sicredi;
   rDigitoAgencia:= ''; // n�o existe essa info no arquivo de retorno do Sicredi;
   rConta        := ''; // n�o existe essa info no arquivo de retorno do Sicredi;
   rDigitoConta  := ''; // n�o existe essa info no arquivo de retorno do Sicredi;

   ACBrBanco.ACBrBoleto.NumeroArquivo := StrToIntDef(Copy(ARetorno[0],111,7),0);

   ACBrBanco.ACBrBoleto.DataArquivo   := StringToDateTimeDef(Copy(ARetorno[0],101,2)+'/'+
                                                             Copy(ARetorno[0],99,2)+'/'+
                                                             Copy(ARetorno[0],95,4),0, 'DD/MM/YYYY' );

   with ACBrBanco.ACBrBoleto do
   begin
      if (not LeCedenteRetorno) and ((rAgencia <> OnlyNumber(Cedente.Agencia)) or
          (rCodCedente <> OnlyNumber(Cedente.CodigoCedente))) then
         raise Exception.Create(ACBrStr('Agencia\Conta do arquivo inv�lido'));

      Cedente.Nome := rCedente;

      if Copy(rCNPJCPF,1,10) <> '0000000000' then 
         Cedente.CNPJCPF      := rCNPJCPF;

      Cedente.CodigoCedente:= rCodCedente;
      Cedente.Agencia      := rAgencia;
      Cedente.AgenciaDigito:= rDigitoAgencia;
      Cedente.Conta        := rConta;
      Cedente.ContaDigito  := rDigitoConta;

      Cedente.TipoInscricao:= pJuridica;
      ACBrBanco.ACBrBoleto.ListadeBoletos.Clear;
   end;

   ACBrBanco.TamanhoMaximoNossoNum := 9;

   for ContLinha := 1 to ARetorno.Count - 2 do
   begin
      Linha := ARetorno[ContLinha] ;

      if (Copy(Linha,109,2) = '28') then // se a ocorr�ncia do campo 109~110 for = 28
         Continue;

      Titulo := ACBrBanco.ACBrBoleto.CriarTituloNaLista;

      with Titulo do
      begin
         SeuNumero                   := copy(Linha,117,10);
         NumeroDocumento             := copy(Linha,117,10);
         OcorrenciaOriginal.Tipo     := CodOcorrenciaToTipo(StrToIntDef(
                                        copy(Linha,109,2),0));

         CodOcorrencia := StrToInt(IfThen(copy(Linha,109,2) = '00','00',copy(Linha,109,2)));

       
         DataOcorrencia := StringToDateTimeDef( Copy(Linha,111,2)+'/'+
                                                Copy(Linha,113,2)+'/'+
                                                Copy(Linha,115,2),0, 'DD/MM/YY' );

         Vencimento     := StringToDateTimeDef( Copy(Linha,147,2)+'/'+
                                                Copy(Linha,149,2)+'/'+
                                                Copy(Linha,151,2),0, 'DD/MM/YY' );

         ValorDocumento       := StrToFloatDef(Copy(Linha,153,13),0)/100;
         ValorDespesaCobranca := StrToFloatDef(Copy(Linha,176,13),0)/100;
         ValorOutrasDespesas  := StrToFloatDef(Copy(Linha,189,13),0)/100;
         ValorAbatimento      := StrToFloatDef(Copy(Linha,228,13),0)/100;
         ValorDesconto        := StrToFloatDef(Copy(Linha,241,13),0)/100;
         ValorRecebido        := StrToFloatDef(Copy(Linha,254,13),0)/100;
         ValorMoraJuros       := StrToFloatDef(Copy(Linha,267,13),0)/100;
         NossoNumero          := Copy(Linha,48,9);
         Carteira             := Copy(Linha,14,1);
         DataCredito:= StringToDateTimeDef( Copy(Linha,335,2)+'/'+
                                            Copy(Linha,333,2)+'/'+
                                            Copy(Linha,329,4),0, 'DD/MM/YYYY' );

         rEspDoc := trim(Copy(Linha,175,1));
         if (rEspDoc = '') or (rEspDoc = 'K') then
           EspecieDoc := 'OS'
         else if (rEspDoc = 'A') then
           EspecieDoc := 'DMI'
         else if (rEspDoc = 'B') then
           EspecieDoc := 'DR'
         else if (rEspDoc = 'C') then
           EspecieDoc := 'NP'
         else if (rEspDoc = 'D') then
           EspecieDoc := 'NR'
         else if (rEspDoc = 'E') then
           EspecieDoc := 'NS'
         else if (rEspDoc = 'G') then
           EspecieDoc := 'RC'
         else if (rEspDoc = 'H') then
           EspecieDoc := 'LC'
         else if (rEspDoc = 'I') then
           EspecieDoc := 'ND'
         else if (rEspDoc = 'J') then
           EspecieDoc := 'DSI';

         IdxMotivo := 319;
         while (IdxMotivo < 328) do
         begin
           if (trim(Copy(Linha,IdxMotivo,2)) <> '') then begin
             MotivoRejeicaoComando.Add( Copy(Linha,IdxMotivo,2) );
             DescricaoMotivoRejeicaoComando.Add(
                CodMotivoRejeicaoToDescricao(OcorrenciaOriginal.Tipo, StrToIntDef(Copy(Linha,IdxMotivo,2),0) ) );
           end;
           Inc(IdxMotivo, 2);
         end;
      end;
   end;

   fpTamanhoMaximoNossoNum := 9;
end;

function TACBrBancoSicredi.CodMotivoRejeicaoToDescricao(
  const TipoOcorrencia: TACBrTipoOcorrencia; CodMotivo: Integer): String;
begin
  case ACBrBanco.ACBrBoleto.LayoutRemessa of
    c240: begin
      case TipoOcorrencia of
        toRetornoRegistroConfirmado,
        toRetornoRegistroRecusado,
        toRetornoInstrucaoRejeitada,
        toRetornoAlteracaoDadosRejeitados:
        begin
          case CodMotivo of
            01: Result := '01 - C�digo do banco inv�lido';
            02: Result := '02 - C�digo do registro detalhe inv�lido';
            03: Result := '03 - C�digo do segmento inv�lido';
            04: Result := '04 - C�digo de movimento n�o permitido para carteira';
            05: Result := '05 - C�digo de movimento inv�lido';
            06: Result := '06 - Tipo/N�mero de inscri��o do cedente inv�lidos';
            07: Result := '07 - Ag�ncia/Conta/DV inv�lido';
            08: Result := '08 - Nosso n�mero inv�lido';
            09: Result := '09 - Nosso n�mero duplicado';
            10: Result := '10 - Carteira inv�lida';
            11: Result := '11 - Forma de cadastramento do t�tulo inv�lido';
            12: Result := '12 - Tipo de documento inv�lido';
            13: Result := '13 - Identifica��o da emiss�o do bloqueto inv�lida';
            14: Result := '14 - Identifica��o da distribui��o do bloqueto inv�lida';
            15: Result := '15 - Caracter�sticas da cobran�a incompat�veis';
            16: Result := '16 - Data de vencimento inv�lida';
            17: Result := '17 - Data de vencimento anterior � data de emiss�o';
            18: Result := '18 - Vencimento fora do prazo de opera��o';
            19: Result := '19 - T�tulo a cargo de bancos correspondentes com vencimento inferior a XX dias';
            20: Result := '20 - Valor do t�tulo inv�lido';
            21: Result := '21 - Esp�cie do t�tulo inv�lida';
            22: Result := '22 - Esp�cie do t�tulo n�o permitida para a carteira';
            23: Result := '23 - Aceite inv�lido';
            24: Result := '24 - Data da emiss�o inv�lida';
            25: Result := '25 - Data da emiss�o posterior a data de entrada';
            26: Result := '26 - C�digo de juros de mora inv�lido';
            27: Result := '27 - Valor/Taxa de juros de mora inv�lido';
            28: Result := '28 - C�digo do desconto inv�lido';
            29: Result := '29 - Valor do desconto maior ou igual ao valor do t�tulo';
            30: Result := '30 - Desconto a conceder n�o confere';
            31: Result := '31 - Concess�o de desconto - j� existe desconto anterior';
            32: Result := '32 - Valor do IOF inv�lido';
            33: Result := '33 - Valor do abatimento inv�lido';
            34: Result := '34 - Valor do abatimento maior ou igual ao valor do t�tulo';
            35: Result := '35 - Valor a conceder n�o confere';
            36: Result := '36 - Concess�o de abatimento - j� existe abatimento aAnterior';
            37: Result := '37 - C�digo para protesto inv�lido';
            38: Result := '38 - Prazo para protesto inv�lido';
            39: Result := '39 - Pedido de protesto n�o permitido para o t�tulo';
            40: Result := '40 - T�tulo com ordem de protesto emitida';
            41: Result := '41 - Pedido de cancelamento/susta��o para t�tulos sem instru��o de protesto';
            42: Result := '42 - C�digo para baixa/devolu��o inv�lido';
            43: Result := '43 - Prazo para baixa/devolu��o inv�lido';
            44: Result := '44 - C�digo da moeda inv�lido';
            45: Result := '45 - Nome do sacado n�o informado';
            46: Result := '46 - Tipo/N�mero de inscri��o do sacado inv�lidos';
            47: Result := '47 - Endere�o do sacado n�o informado';
            48: Result := '48 - CEP inv�lido';
            49: Result := '49 - CEP sem pra�a de cobran�a (N�o localizado)';
            50: Result := '50 - CEP referente a um banco correspondente';
            51: Result := '51 - CEP incompat�vel com a Unidade da Federa��o';
            52: Result := '52 - Unidade da Federa��o inv�lida';
            53: Result := '53 - Tipo/N�mero de inscri��o do sacador/avalista inv�lidos';
            54: Result := '54 - Sacador/Avalista n�o informado';
            55: Result := '55 - Nosso n�mero no banco correspondente n�o informado';
            56: Result := '56 - C�digo do banco correspondente n�o informado';
            57: Result := '57 - C�digo da multa inv�lido';
            58: Result := '58 - Data da multa inv�lida';
            59: Result := '59 - Valor/Percentual da multa inv�lido';
            60: Result := '60 - Movimento para t�tulo n�o cadastrado';
            61: Result := '61 - Altera��o da ag�ncia cobradora/DV inv�lida';
            62: Result := '62 - Tipo de impress�o inv�lido';
            63: Result := '63 - Entrada para t�tulo j� cadastrado';
            64: Result := '64 - N�mero da linha inv�lido';
            79: Result := '79 - Data juros de mora inv�lido';
            80: Result := '80 - Data do desconto inv�lida';
            84: Result := '84 - N�mero autoriza��o inexistente';
            85: Result := '85 - T�tulo com pagamento vinculado';
            86: Result := '86 - Seu N�mero inv�lido';
          else
            Result := IntToStrZero(CodMotivo, 2) + ' - Outros motivos';
          end;
        end;
        toRetornoDebitoTarifas:
        begin
          case CodMotivo of
            01: Result := '01 - Tarifa de extrato de posi��o';
            02: Result := '02 - Tarifa de manuten��o de t�tulo vencido';
            03: Result := '03 - Tarifa de susta��o';
            04: Result := '04 - Tarifa de protesto';
            05: Result := '05 - Tarifa de outras instru��es';
            06: Result := '06 - Tarifa de outras ocorr�ncias';
            08: Result := '08 - Custas de protesto';
            09: Result := '09 - Custas de susta��o de protesto';
            10: Result := '10 - Custas de cart�rio distribuidor';
            11: Result := '11 - Custas de edital';
            12: Result := '12 - Tarifa sobre devolu��o de t�tulo vencido';
            13: Result := '13 - Tarifa sobre registro cobrada na baixa/liquida��o';
            17: Result := '17 - Tarifa sobre prorroga��o de vencimento';
            18: Result := '18 - Tarifa sobre altera��o de abatimento/desconto';
            19: Result := '19 - Tarifa sobre arquivo mensal (Em ser)';
            20: Result := '20 - Tarifa sobre emiss�o de bloqueto pr�-emitido pelo banco';
          else
            Result := IntToStrZero(CodMotivo, 2) + ' - Outros motivos';
          end;
        end;
        toRetornoLiquidado,
        toRetornoBaixado,
        toRetornoLiquidadoAposBaixaouNaoRegistro:
        begin
          case CodMotivo of
            01: Result := '01 - Por saldo';
            02: Result := '02 - Por conta';
            03: Result := '03 - Liquida��o no guich� de caixa em dinheiro';
            04: Result := '04 - Compensa��o eletr�nica';
            05: Result := '05 - Compensa��o convencional';
            06: Result := '06 - Por meio eletr�nico';
            07: Result := '07 - Ap�s feriado local';
            08: Result := '08 - Em cart�rio';
            30: Result := '30 - Liquida��o no guich� de caixa em cheque';
            31: Result := '31 - Liquida��o em banco correspondente';
          else
            Result := IntToStrZero(CodMotivo, 2) + ' - Outros motivos';
          end;
          if (TipoOcorrencia = toRetornoBaixado) then begin
            case CodMotivo of
              09: Result := '09 - Comandada banco';
              10: Result := '10 - Comandada cliente arquivo';
              11: Result := '11 - Comandada cliente on-line';
              12: Result := '12 - Decurso prazo - cliente';
              13: Result := '13 - Decurso prazo - banco';
              14: Result := '14 - Protestado';
              15: Result := '15 - T�tulo exclu�do';
            end;
          end;
        end;
      else
        Result := IntToStrZero(CodMotivo, 2) + ' - Outros motivos';
      end;
    end;
    c400: begin
      case TipoOcorrencia of
        toRetornoDebitoTarifas: begin
          case CodMotivo of
            03: Result := '03 - Por saldo';
            04: Result := '04 - Por conta';
            08: Result := '08 - Liquida��o no guich� de caixa em dinheiro';
          else
            Result := IntToStrZero(CodMotivo, 2) +' - Outros motivos';
          end;
        end;
      else
        case CodMotivo of
          01: Result := '01 - C�digo do banco inv�lido';
          02: Result := '02 - C�digo do registro detalhe inv�lido';
          03: Result := '03 - C�digo da ocorr�ncia inv�lido';
          04: Result := '04 - C�digo de ocorr�ncia n�o permitido para carteira';
          05: Result := '05 - C�digo de ocorr�ncia n�o num�rico';
          07: Result := '07 - Cooperativa/Ag�ncia/Conta/DV inv�lido';
          08: Result := '08 - Nosso n�mero inv�lido';
          09: Result := '09 - Nosso n�mero duplicado';
          10: Result := '10 - Carteira inv�lida';
          14: Result := '14 - T�tulo protestado';
          15: Result := '15 - Cooperativa/Carteira/Ag�ncia/Conta/Nosso n�mero inv�lidos';
          16: Result := '16 - Data de vencimento inv�lida';
          17: Result := '17 - Data de vencimento anterior � data de emiss�o';
          18: Result := '18 - Vencimento fora do prazo de opera��o';
          20: Result := '20 - Valor do t�tulo inv�lido';
          21: Result := '21 - Esp�cie do t�tulo inv�lida';
          22: Result := '22 - Esp�cie do t�tulo n�o permitida para a carteira';
          24: Result := '24 - Data da emiss�o inv�lida';
          29: Result := '29 - Valor do desconto maior/igual ao valor do t�tulo';
          31: Result := '31 - Concess�o de desconto - existe desconto anterior';
          33: Result := '33 - Valor do abatimento inv�lido';
          34: Result := '34 - Valor do abatimento maior/igual ao valor do t�tulo';
          36: Result := '36 - Concess�o de abatimento - existe abatimento aAnterior';
          38: Result := '38 - Prazo para protesto inv�lido';
          39: Result := '39 - Pedido de protesto n�o permitido para o t�tulo';
          40: Result := '40 - T�tulo com ordem de protesto emitida';
          41: Result := '41 - Pedido de cancelamento/susta��o sem instru��o de protesto';
          44: Result := '44 - Cooperativa de cr�dito/Ag�ncia cedente n�o prevista';
          45: Result := '45 - Nome do sacado inv�lido';
          46: Result := '46 - Tipo/N�mero de inscri��o do sacado inv�lidos';
          47: Result := '47 - Endere�o do sacado n�o informado';
          48: Result := '48 - CEP irregular';
          49: Result := '49 - N�mero de inscri��o do sacador/avalista inv�lido';
          50: Result := '50 - Sacador/Avalista n�o informado';
          60: Result := '60 - Movimento para t�tulo n�o cadastrado';
          63: Result := '63 - Entrada para t�tulo j� cadastrado';
        else
          Result := IntToStrZero(CodMotivo, 2) +' - Outros motivos';
        end;
      end;
    end;
  end;
end;

function TACBrBancoSicredi.TipoOcorrenciaToDescricao(
  const TipoOcorrencia: TACBrTipoOcorrencia): String;
begin
  case ACBrBanco.ACBrBoleto.LayoutRemessa of
    c240: begin
      case TipoOcorrencia of
        toRetornoRegistroConfirmado:                     Result := 'Entrada confirmada';
        toRetornoRegistroRecusado:                       Result := 'Entrada rejeitada';
        toRetornoLiquidado:                              Result := 'Liquida��o';
        toRetornoRecebimentoInstrucaoConcederDesconto:   Result := 'Confirma��o do recebimento da instru��o de desconto';
        toRetornoRecebimentoInstrucaoCancelarDesconto:   Result := 'Confirma��o do recebimento do cancelamento do desconto';
        toRetornoBaixado:                                Result := 'Baixa';
        toRetornoRecebimentoInstrucaoConcederAbatimento: Result := 'Confirma��o do recebimento da instru��o de abatimento';
        toRetornoRecebimentoInstrucaoCancelarAbatimento: Result := 'Confirma��o do recebimento do cancelamento do abatimento';
        toRetornoRecebimentoInstrucaoAlterarVencimento:  Result := 'Confirma��o do recebimento da instru��o de altera��o de vencimento';
        toRetornoLiquidadoAposBaixaouNaoRegistro:        Result := 'Liquida��o ap�s baixa ou liquida��o de t�tulo n�o registrado';
        toRetornoRecebimentoInstrucaoProtestar:          Result := 'Confirma��o de recebimento de instru��o de protesto';
        toRetornoRecebimentoInstrucaoSustarProtesto:     Result := 'Confirma��o de recebimento de instru��o de susta��o/cancelamento de protesto';
        toREtornoEntradaEmCartorio:                      Result := 'Remessa a cart�tio (Aponte em cart�rio)';
        toRetornoRetiradoDeCartorio:                     Result := 'Retirada de cart�rio e manuten��o em carteira';
        toRetornoBaixaPorProtesto:                       Result := 'Protestado e baixado (Baixa por ter sido protestado)';
        toRetornoInstrucaoRejeitada:                     Result := 'Instru��o rejeitada';
        toRetornoDebitoTarifas:                          Result := 'D�bito de tarifas/custas';
        toRetornoAlteracaoDadosRejeitados:               Result := 'Altera��o de dados rejeitada';
        toRetornoBaixaRejeitada:                         Result := 'Baixa rejeitada';
      else
        Result := 'Outras ocorr�ncias';
      end;
    end;
    c400: begin
      case TipoOcorrencia of
        toRetornoRegistroConfirmado:                 Result := 'Entrada confirmada';
        toRetornoRegistroRecusado:                   Result := 'Entrada rejeitada';
        toRetornoLiquidado:                          Result := 'Liquida��o normal';
        toRetornoBaixadoViaArquivo:                  Result := 'Baixado automaticamente via arquivo';
        toRetornoBaixadoInstAgencia:                 Result := 'Baixado conforme instru��es da cooperativa de cr�dito';
        toRetornoAbatimentoConcedido:                Result := 'Abatimento concedido';
        toRetornoAbatimentoCancelado:                Result := 'Abatimento cancelado';
        toRetornoVencimentoAlterado:                 Result := 'Vencimento alterado';
        toRetornoLiquidadoEmCartorio:                Result := 'Liquida��o em cart�rio';
        toRetornoLiquidadoAposBaixaouNaoRegistro:    Result := 'Liquida��o ap�s baixa';
        toRetornoRecebimentoInstrucaoProtestar:      Result := 'Confirma��o de recebimento de instru��o de protesto';
        toRetornoRecebimentoInstrucaoSustarProtesto: Result := 'Confirma��o de recebimento de instru��o de susta��o de protesto';
        toREtornoEntradaEmCartorio:                  Result := 'Entrada de t�tulo em cart�rio';
        toRetornoEntradaRejeitaCEPIrregular:         Result := 'Entrada rejeitada por CEP irregular';
        toRetornoBaixaRejeitada:                     Result := 'Baixa rejeitada';
        toRetornoDebitoTarifas:                      Result := 'Tarifa';
        toRetornoAlteracaoDadosRejeitados:           Result := 'Altera��o rejeitada';
        toRetornoInstrucaoRejeitada:                 Result := 'Instru��o rejeitada';
        toRetornoRetiradoDeCartorio:                 Result := 'Retirado de cart�rio e manuten��o em carteira';
      else
        Result := 'Outras ocorr�ncias';
      end;
    end;
  end;
end;

function TACBrBancoSicredi.CodOcorrenciaToTipo(
  const CodOcorrencia: Integer): TACBrTipoOcorrencia;
begin
  case ACBrBanco.ACBrBoleto.LayoutRemessa of
    c240: begin
      case CodOcorrencia of
        02: Result := toRetornoRegistroConfirmado;
        03: Result := toRetornoRegistroRecusado;
        06: Result := toRetornoLiquidado;
        07: Result := toRetornoRecebimentoInstrucaoConcederDesconto;
        08: Result := toRetornoRecebimentoInstrucaoCancelarDesconto;
        09: Result := toRetornoBaixado;
        12: Result := toRetornoRecebimentoInstrucaoConcederAbatimento;
        13: Result := toRetornoRecebimentoInstrucaoCancelarAbatimento;
        14: Result := toRetornoRecebimentoInstrucaoAlterarVencimento;
        17: Result := toRetornoLiquidadoAposBaixaouNaoRegistro;
        19: Result := toRetornoRecebimentoInstrucaoProtestar;
        20: Result := toRetornoRecebimentoInstrucaoSustarProtesto;
        23: Result := toREtornoEntradaEmCartorio;
        24: Result := toRetornoRetiradoDeCartorio;
        25: Result := toRetornoBaixaPorProtesto;
        26: Result := toRetornoInstrucaoRejeitada;
    //    27: Result :=        Confirma��o do pedido de altera��o de outros dados
        28: Result := toRetornoDebitoTarifas;
        30: Result := toRetornoAlteracaoDadosRejeitados;
        36: Result := toRetornoBaixaRejeitada;
    //    51: Result :=        T�tulo DDA reconhecido pelo sacado
    //    52: Result :=        T�tulo DDA n�o reconhecido pelo sacado
      else
        Result := toRetornoOutrasOcorrencias;
      end;
    end;
    c400: begin
      case CodOcorrencia of
        02: Result := toRetornoRegistroConfirmado;
        03: Result := toRetornoRegistroRecusado;
        06: Result := toRetornoLiquidado;
        09: Result := toRetornoBaixadoViaArquivo;
        10: Result := toRetornoBaixadoInstAgencia;
        12: Result := toRetornoAbatimentoConcedido;
        13: Result := toRetornoAbatimentoCancelado;
        14: Result := toRetornoVencimentoAlterado;
        15: Result := toRetornoLiquidadoEmCartorio;
        17: Result := toRetornoLiquidadoAposBaixaouNaoRegistro;
        19: Result := toRetornoRecebimentoInstrucaoProtestar;
        20: Result := toRetornoRecebimentoInstrucaoSustarProtesto;
        23: Result := toREtornoEntradaEmCartorio;
        24: Result := toRetornoEntradaRejeitaCEPIrregular;
        27: Result := toRetornoBaixaRejeitada;
        28: Result := toRetornoDebitoTarifas;
    //    29: Result :=        Rejei��o do sacado
        30: Result := toRetornoAlteracaoDadosRejeitados;
        32: Result := toRetornoInstrucaoRejeitada;
    //    33: Result :=        Confirma��o do pedido de altera��o de outros dados
        34: Result := toRetornoRetiradoDeCartorio;
    //    35: Result :=        Aceite do sacado
      else
        Result := toRetornoOutrasOcorrencias;
      end;
    end;
  end;
end;

function TACBrBancoSicredi.TipoOCorrenciaToCod(
  const TipoOcorrencia: TACBrTipoOcorrencia): String;
begin
  case ACBrBanco.ACBrBoleto.LayoutRemessa of
    c240: begin
      case TipoOcorrencia of
        toRetornoRegistroConfirmado:                     Result := '02';
        toRetornoRegistroRecusado:                       Result := '03';
        toRetornoLiquidado:                              Result := '06';
        toRetornoRecebimentoInstrucaoConcederDesconto:   Result := '07';
        toRetornoRecebimentoInstrucaoCancelarDesconto:   Result := '08';
        toRetornoBaixado:                                Result := '09';
        toRetornoRecebimentoInstrucaoConcederAbatimento: Result := '12';
        toRetornoRecebimentoInstrucaoCancelarAbatimento: Result := '13';
        toRetornoRecebimentoInstrucaoAlterarVencimento:  Result := '14';
        toRetornoLiquidadoAposBaixaouNaoRegistro:        Result := '17';
        toRetornoRecebimentoInstrucaoProtestar:          Result := '19';
        toRetornoRecebimentoInstrucaoSustarProtesto:     Result := '20';
        toREtornoEntradaEmCartorio:                      Result := '23';
        toRetornoRetiradoDeCartorio:                     Result := '24';
        toRetornoBaixaPorProtesto:                       Result := '25';
        toRetornoInstrucaoRejeitada:                     Result := '26';
        toRetornoDebitoTarifas:                          Result := '28';
        toRetornoAlteracaoDadosRejeitados:               Result := '30';
        toRetornoBaixaRejeitada:                         Result := '36';
      else
        Result := '00';
      end;
    end;
    c400: begin
      case TipoOcorrencia of
        toRetornoRegistroConfirmado:                 Result := '02';
        toRetornoRegistroRecusado:                   Result := '03';
        toRetornoLiquidado:                          Result := '06';
        toRetornoBaixadoViaArquivo:                  Result := '09';
        toRetornoBaixadoInstAgencia:                 Result := '10';
        toRetornoAbatimentoConcedido:                Result := '12';
        toRetornoAbatimentoCancelado:                Result := '13';
        toRetornoVencimentoAlterado:                 Result := '14';
        toRetornoLiquidadoEmCartorio:                Result := '15';
        toRetornoLiquidadoAposBaixaouNaoRegistro:    Result := '17';
        toRetornoRecebimentoInstrucaoProtestar:      Result := '19';
        toRetornoRecebimentoInstrucaoSustarProtesto: Result := '20';
        toREtornoEntradaEmCartorio:                  Result := '23';
        toRetornoEntradaRejeitaCEPIrregular:         Result := '24';
        toRetornoBaixaRejeitada:                     Result := '27';
        toRetornoDebitoTarifas:                      Result := '28';
        toRetornoAlteracaoDadosRejeitados:           Result := '30';
        toRetornoInstrucaoRejeitada:                 Result := '32';
        toRetornoRetiradoDeCartorio:                 Result := '34';
      else
        Result := '00';
      end;
    end;
  end;
end;

function TACBrBancoSicredi.GerarRegistroHeader240(
  NumeroRemessa: Integer): String;
var TipoInsc: String;
begin
  case ACBrBanco.ACBrBoleto.Cedente.TipoInscricao of
    pFisica:   TipoInsc := '1';
    pJuridica: TipoInsc := '2';
  else
    TipoInsc := '9';
  end;

  with ACBrBanco.ACBrBoleto.Cedente do
  begin
    { HEADER DE ARQUIVO }
    Result := '748'                                                         + // 001 a 003 - C�digo do banco na compensa��o "748" SCIREDI
              '0000'                                                        + // 004 a 007 - Lote de servi�o "0000"
              '0'                                                           + // 008 a 008 - Tipo de registro = "0" HEADER ARQUIVO
              Space(9)                                                      + // 009 a 017 - Uso exclusivo FEBRABAN/CNAB
              TipoInsc                                                      + // 018 a 018 - Tipo de inscri��o da empresa = "1" Pessoa F�sica "2" Pessoa Jur�dica
              padR(OnlyNumber(CNPJCPF), 14, '0')                            + // 019 a 032 - N�mero de inscri��o da empresa
              Space(20)                                                     + // 033 a 052 - C�digo do conv�nio no banco (O SICREDI n�o valida este campo; cfe Manual Agosto 2010 p�g. 35)
              padR(OnlyNumber(Agencia), 5, '0')                             + // 053 a 057 - Ag�ncia mantenedora da conta
              Space(1)                                                      + // 058 a 058 - D�gito verificador da ag�ncia
              padR(OnlyNumber(CodigoCedente), 12, '0')                      + // 059 a 070 - C�digo do cedente
              '0'                                                           + // 071 a 071 - Zeros
              Space(1)                                                      + // 072 a 072 - D�gito verificador da ag/conta
              padL(Nome, 30)                                                + // 073 a 102 - Nome da empresa
              padL('SICREDI', 30)                                           + // 103 a 132 - Nome do banco = "SICREDI"
              Space(10)                                                     + // 133 a 142 - Uso exclusivo FEBRABAN/CNAB
              '1'                                                           + // 143 a 143 - C�digo Remessa/Retorno = "1" Remessa "2" Retorno
              FormatDateTime('ddmmyyyy', Now)                               + // 144 a 151 - Data de gera��o do arquivo
              FormatDateTime('hhnnss', Now)                                 + // 152 a 157 - Hora de gera��o do arquivo
              IntToStrZero(NumeroRemessa, 6)                                + // 158 a 163 - N�mero sequencial do arquivo
              '081'                                                         + // 164 a 166 - N� da vers�o do leiaute do arquivo = "081"
              '01600'                                                       + // 167 a 171 - Densidade de grava��o do arquivo = "01600"
              Space(20)                                                     + // 172 a 191 - Para uso reservado do banco
              Space(20)                                                     + // 192 a 211 - Para uso reservado da empresa
              Space(29);                                                      // 212 a 240 - Uso exclusivo FEBRABAN/CNAB

    { HEADER DE LOTE }
    Result := Result + #13#10                                               +
              '748'                                                         + // 001 a 003 - C�digo do banco na compensa��o "748" SICREDI
              '0001'                                                        + // 004 a 007 - Lote de servi�o "0001"
              '1'                                                           + // 008 a 008 - Tipo de registro = "1" HEADER LOTE
              'R'                                                           + // 009 a 009 - Tipo de opera��o = "R" Arquivo de Remessa
              '01'                                                          + // 010 a 011 - Tipo de servi�o = "01" Cobran�a
              Space(2)                                                      + // 012 a 013 - Uso exclusivo FEBRABAN/CNAB
              '040'                                                         + // 014 a 016 - N� da vers�o do leiaute do lote = "040"
              Space(1)                                                      + // 017 a 017 - Uso exclusivo FEBRABAN/CNAB
              TipoInsc                                                      + // 018 a 018 - Tipo de inscri��o da empresa = "1" Pessoa F�sica "2" Pessoa Jur�dica
              padR(OnlyNumber(CNPJCPF), 15, '0')                            + // 019 a 033 - N�mero de inscri��o da empresa
              Space(20)                                                     + // 034 a 053 - C�digo do conv�nio no banco (O SICREDI n�o valida este campo; cfe Manual Agosto 2010 p�g. 35)
              padR(OnlyNumber(Agencia), 5, '0')                             + // 054 a 058 - Ag�ncia mantenedora da conta
              Space(1)                                                      + // 059 a 059 - D�gito verificador da ag�ncia
              padR(OnlyNumber(CodigoCedente), 12, '0')                      + // 060 a 071 - C�digo do cedente
              '0'                                                           + // 072 a 072 - Zeros
              ContaDigito                                                   + // 073 a 073 - D�gito verificador da coop/ag/conta
              padL(Nome, 30)                                                + // 074 a 103 - Nome da empresa
              Space(40)                                                     + // 104 a 143 - Mensagem 1
              Space(40)                                                     + // 144 a 183 - Mensagem 2
              IntToStrZero(NumeroRemessa, 8)                                + // 184 a 191 - N�mero remessa/retorno
              FormatDateTime('ddmmyyyy', Now)                               + // 192 a 199 - Data de grava��o rem./ret.
              padL('', 8, '0')                                              + // 200 a 207 - Data do cr�dito
              Space(33);                                                      // 208 a 240 - Uso exclusivo FEBRABAN/CNAB

    end;

    Result := UpperCase(Result);
end;

function TACBrBancoSicredi.GerarRegistroTrailler240(
  ARemessa: TStringList): String;
begin
   {REGISTRO TRAILER DO LOTE}
   Result:= IntToStrZero(ACBrBanco.Numero, 3)                               + // 001 a 003 - C�digo do banco na compensa��o
            '0001'                                                          + // 004 a 007 - Lote de servi�o = "9999"
            '5'                                                             + // 008 a 008 - Tipo do registro = "5" TRAILLER LOTE
            Space(9)                                                        + // 009 a 017 - Uso exclusivo FEBRABAN/CNAB
            IntToStrZero(ARemessa.Count*2, 6)                               + // 018 a 023 - Quantidade de registros no lote
            padL('', 6, '0')                                                + // 024 a 029 - Quantidade de t�tulos em cobran�a
            padL('',17, '0')                                                + // 030 a 046 - Valor total dos t�tulos em carteiras
            padL('', 6, '0')                                                + // 047 a 052 - Quantidade de t�tulos em cobran�a
            padL('',17, '0')                                                + // 053 a 069 - Valor total dos t�tulos em carteiras
            padL('', 6, '0')                                                + // 070 a 075 - Quantidade de t�tulos em cobran�a
            padL('',17, '0')                                                + // 076 a 092 - Quantidade de t�tulos em carteiras
            padL('', 6, '0')                                                + // 093 a 098 - Quantidade de t�tulos em cobran�a
            padL('',17, '0')                                                + // 099 a 115 - Valor total dos t�tulos em carteiras
            Space(8)                                                        + // 116 a 123 - N�mero do aviso de lan�amento
            Space(117);                                                       // 124 a 240 - Uso exclusivo FEBRABAN/CNAB

   {GERAR REGISTRO TRAILER DO ARQUIVO}
   Result:= Result + #13#10 +
            '748'                                                           + // 001 a 003 - C�digo do banco na compensa��o
            '9999'                                                          + // 004 a 007 - Lote de servi�o = "9999"
            '9'                                                             + // 008 a 008 - Tipo do registro = "9" TRAILLER ARQUIVO
            Space(9)                                                        + // 009 a 017 - Uso exclusivo FEBRABAN/CNAB
            '000001'                                                        + // 018 a 023 - Quantidade de lotes do arquivo
            IntToStrZero((ARemessa.Count*2)+2, 6)                           + // 024 a 029 - Quantidade de registros do arquivo, inclusive este registro que est� sendo criado agora
            padL('', 6, '0')                                                + // 030 a 035 - Quantidade de contas para concilia��o (lotes)
            Space(205);                                                       // 036 a 240 - Uso exclusivo FEBRABAN/CNAB
end;

function TACBrBancoSicredi.GerarRegistroTransacao240(
  ACBrTitulo: TACBrTitulo): String;
var AceiteStr, CodProtesto, DiasProtesto, TipoSacado, EndSacado: String;
    Multa: String;
    DigitoNossoNumero: String;
    Especie: String;
begin
  with ACBrBanco.ACBrBoleto.Cedente, ACBrTitulo do
  begin
    {Nosso N�mero}
    DigitoNossoNumero := CalcularDigitoVerificador(ACBrTitulo);

    {Aceite}
    case Aceite of
      atSim: AceiteStr := 'A';
      atNao: AceiteStr := 'N';
    end;

    {Esp�cie}
    if (EspecieDoc = 'DM') then
      Especie := '03'
    else if (EspecieDoc = 'DMI') then
      Especie := '03'
    else
      Especie := '99';

    {Protesto}
    CodProtesto := '3';
    DiasProtesto := '00';
    if (DataProtesto > 0) and (DataProtesto > Vencimento) then
    begin
      CodProtesto := '1';
      DiasProtesto := padR(IntToStr(DaysBetween(DataProtesto, Vencimento)), 2, '0');
    end;

    {Sacado}
    case Sacado.Pessoa of
      pFisica:   TipoSacado := '1';
      pJuridica: TipoSacado := '2';
    else
      TipoSacado := '9';
    end;

    EndSacado := Sacado.Logradouro;
    if (Sacado.Numero <> '') then
      EndSacado := EndSacado + ', ' + Sacado.Numero;
    EndSacado := padL(trim(EndSacado), 40);

    {SEGMENTO P}
    Result:= '748'                                                          + // 001 a 003 - C�digo do banco na compensa��o
             '0001'                                                         + // 004 a 007 - Lote de servi�o = "0001"
             '3'                                                            + // 008 a 008 - Tipo de registro = "3" DETALHE
             IntToStrZero(
               (3 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo)) + 1 , 5) + // 009 a 013 - N� sequencial do registro do lote
             'P'                                                            + // 014 a 014 - C�d. segmento do registro detalhe
             Space(1)                                                       + // 015 a 015 - Uso exclusivo FEBRABAN/CNAB
             '01'                                                           + // 016 a 017 - C�digo de movimento remessa
             padR(OnlyNumber(Agencia), 5)                                   + // 018 a 022 - Ag�ncia mantenedora da conta
             Space(1)                                                       + // 023 a 023 - D�gito verificador da ag�ncia
             padR(OnlyNumber(Conta), 12)                                    + // 024 a 035 - N�mero da conta corrente
             padR(OnlyNumber(ContaDigito), 1)                               + // 036 a 036 - D�gito verificador da conta
             Space(1)                                                       + // 037 a 037 - D�gito verificador da coop/ag/conta
             padL(NossoNumero + DigitoNossoNumero, 20, '0')                 + // 038 a 057 - Identifica��o do t�tulo no banco
             '1'                                                            + // 058 a 058 - C�digo da carteira
             '1'                                                            + // 059 a 059 - Forma de cadastro do t�tulo no banco
             '2'                                                            + // 060 a 060 - Tipo de documento
             '2'                                                            + // 061 a 061 - Identifica��o de emiss�o do bloqueto
             '2'                                                            + // 062 a 062 - Identifica��o da distribui��o
             padL(NumeroDocumento, 15)                                      + // 063 a 077 - N� do documento de cobran�a
             FormatDateTime('ddmmyyyy', Vencimento)                         + // 078 a 085 - Data de vencimento do t�tulo
             IntToStrZero(Round(ValorDocumento * 100), 15)                  + // 086 a 100 - Valor nominal do t�tulo
             '00000'                                                        + // 101 a 105 - Coop./Ag. encarregada da cobran�a
             Space(1)                                                       + // 106 a 106 - D�gito verificador da coop./ag�ncia
             padR(Especie, 2, '0')                                          + // 107 a 108 - Esp�cie do t�tulo
             AceiteStr                                                      + // 109 a 109 - Identifica��o de t�tulo aceito/n�o aceito
             FormatDateTime('ddmmyyyy', DataDocumento)                      + // 110 a 117 - Data da emiss�o do t�tulo
             '1'                                                            + // 118 a 118 - C�digo do juro de mora
             '00000000'                                                     + // 119 a 126 - Data do juro de mora
             IntToStrZero(Round(ValorMoraJuros * 100), 15)                  + // 127 a 141 - Juros de mora por dia/taxa
             '1'                                                            + // 142 a 142 - C�digo do desconto 1
             FormatDateTime('ddmmyyyy', Vencimento)                         + // 143 a 150 - Data do desconto 1
             IntToStrZero(Round(ValorDesconto * 100), 15)                   + // 151 a 165 - Valor percentual a ser concedido
             IntToStrZero(Round(ValorIOF * 100), 15)                        + // 166 a 180 - Valor do IOF a ser recolhido
             IntToStrZero(Round(ValorAbatimento * 100), 15)                 + // 181 a 195 - Valor do abatimento
             padL(NumeroDocumento, 25)                                      + // 196 a 220 - Identifica��o do t�tulo na empresa
             CodProtesto                                                    + // 221 a 221 - C�digo para protesto
             DiasProtesto                                                   + // 222 a 223 - N�mero de dias para protesto
             '1'                                                            + // 224 a 224 - C�digo para baixa/devolu��o
             '060'                                                          + // 225 a 227 - N� de dias para baixa/devolu��o
             '09'                                                           + // 228 a 229 - C�digo da moeda = "09"
             padL('', 10, '0')                                              + // 230 a 239 - N� do contrato da opera��o de cr�dito
             Space(1);                                                        // 240 a 240 - Uso exclusivo FEBRABAN/CNAB

    {SEGMENTO Q}
    Result:= Result + #13#10 +
             '748'                                                          + // 001 a 003 - C�digo do banco na compensa��o
             '0001'                                                         + // 004 a 007 - Lote de servi�o = "0001"
             '3'                                                            + // 008 a 008 - Tipo de registro = "3" DETALHE
             IntToStrZero(
               (3 * ACBrBoleto.ListadeBoletos.IndexOf(ACBrTitulo)) + 2 , 5) + // 009 a 013 - N� sequencial do registro do lote
             'Q'                                                            + // 014 a 014 - C�d. segmento do registro detalhe
             Space(1)                                                       + // 015 a 015 - Uso exclusivo FEBRABAN/CNAB
             '01'                                                           + // 016 a 017 - C�digo de movimento de remessa
             TipoSacado                                                     + // 018 a 018 - Tipo de inscri��o
             padR(OnlyNumber(Sacado.CNPJCPF), 15, '0')                      + // 019 a 033 - N�mero de inscri��o
             padL(Sacado.NomeSacado, 40)                                    + // 034 a 073 - Nome
             EndSacado                                                      + // 074 a 113 - Endere�o
             padL(Sacado.Bairro, 15)                                        + // 114 a 128 - Bairro
             Copy(padR(OnlyNumber(Sacado.CEP),8,'0'),1,5)                   + // 129 a 133 - CEP
             Copy(padR(OnlyNumber(Sacado.CEP),8,'0'),6,3)                   + // 134 a 136 - Sufixo do CEP
             padL(Sacado.Cidade, 15)                                        + // 137 a 151 - Cidade
             padR(UF, 2)                                                    + // 152 a 153 - Unidade da Federa��o
             '1'                                                            + // 154 a 154 - Tipo de inscri��o
             padL('', 15, '0')                                              + // 155 a 169 - N�mero de inscri��o
             Space(40)                                                      + // 170 a 209 - Nome do sacador/avalista
             padL('', 3, '0')                                               + // 210 a 212 - C�d. bco corresp. na compensa��o
             Space(20)                                                      + // 213 a 232 - Nosso n� no banco correspondente
             Space(8);                                                        // 233 a 240 - Uso exclusivo FEBRABAN/CNAB

  end;

  Result := UpperCase(Result);
end;

procedure TACBrBancoSicredi.LerRetorno240(ARetorno: TStringList);
var Titulo: TACBrTitulo;
    SegT, SegU: String;
    ContLinha, IdxMotivo: Integer;
    rCedente, rCNPJCPF, rCodCedente, rAgencia, rDigitoAgencia: String;
    rConta, rDigitoConta: String;
begin
   ContLinha := 0;

   if (StrToIntDef(Copy(ARetorno[0], 1, 3), -1) <> Numero) then
     raise Exception.Create(ACBrStr('"'+ ACBrBanco.ACBrBoleto.NomeArqRetorno +
                                       '" n�o � um arquivo de retorno do(a) '+ UpperCase(Nome)));

   rCedente       := Trim(Copy(ARetorno[0],73,30));
   rCNPJCPF       := Copy(ARetorno[0],19,14);
   rCodCedente    := Copy(ARetorno[0],59,12);
   rAgencia       := Copy(ARetorno[0],53,5);
   rDigitoAgencia := Copy(ARetorno[0],58,1);
   rConta         := ''; // n�o existe essa info no arquivo de retorno do Sicredi;
   rDigitoConta   := ''; // n�o existe essa info no arquivo de retorno do Sicredi;

   with ACBrBanco.ACBrBoleto do
   begin
      NumeroArquivo   := StrToIntDef( Copy(ARetorno[0],158,6),0 );
      DataArquivo     := StringToDateTimeDef( Copy(ARetorno[0],144,2) +'/'+
                                              Copy(ARetorno[0],146,2) +'/'+
                                              Copy(ARetorno[0],148,4),
                                              0, 'dd/mm/yyyy' );
      DataCreditoLanc := StringToDateTimeDef( Copy(ARetorno[1], 200, 2) +'/'+
                                              Copy(ARetorno[1], 202, 2) +'/'+
                                              Copy(ARetorno[1], 204, 4),
                                              0, 'dd/mm/yyyy' );
   end;

   with ACBrBanco.ACBrBoleto do
   begin
      if (not LeCedenteRetorno) and ((rAgencia <> OnlyNumber(Cedente.Agencia)) or
          (rCodCedente <> OnlyNumber(Cedente.CodigoCedente))) then
         raise Exception.Create(ACBrStr('Agencia\Conta do arquivo inv�lido'));

      Cedente.Nome := rCedente;

      if Copy(rCNPJCPF,1,10) <> '0000000000' then 
         Cedente.CNPJCPF      := rCNPJCPF;

      Cedente.CodigoCedente:= rCodCedente;
      Cedente.Agencia      := rAgencia;
      Cedente.AgenciaDigito:= rDigitoAgencia;
      Cedente.Conta        := rConta;
      Cedente.ContaDigito  := rDigitoConta;

      Cedente.TipoInscricao:= pJuridica;
      ACBrBanco.ACBrBoleto.ListadeBoletos.Clear;
   end;

   for ContLinha := 1 to ARetorno.Count - 2 do
   begin
      SegT := ARetorno[ContLinha] ;
      SegU := ARetorno[ContLinha + 1] ;

      if (SegT[14] <> 'T') then
        Continue
      else if (Copy(SegT,16,2) = '28') then // se a ocorr�ncia do campo 016~017 for = 28
         Continue;

      Titulo := ACBrBanco.ACBrBoleto.CriarTituloNaLista;

      with Titulo do
      begin
        if (SegT[133] = '1') then
          Sacado.Pessoa := pFisica
        else if (SegT[133] = '2') then
          Sacado.Pessoa := pJuridica
        else
          Sacado.Pessoa := pOutras;
        case Sacado.Pessoa of
          pFisica:   Sacado.CNPJCPF := Copy(SegT, 138, 11);
          pJuridica: Sacado.CNPJCPF := Copy(SegT, 135, 14);
        else
          Sacado.CNPJCPF := Copy(SegT, 134, 15);
        end;
        Sacado.NomeSacado := Trim(Copy(SegT, 149, 40));

        NumeroDocumento      := Trim(Copy(SegT,59,15));
        SeuNumero            := NumeroDocumento;
        Carteira             := Copy(SegT,58,1);
        NossoNumero          := Trim(Copy(SegT,38,20));
        Vencimento           := StringToDateTimeDef( Copy(SegT,74,2) +'/'+
                                                     Copy(SegT,76,2) +'/'+
                                                     Copy(SegT,78,4),
                                                     0, 'dd/mm/yyyy' );
        ValorDocumento       := StrToFloatDef(Copy(SegT, 82,15),0)/100;
        ValorDespesaCobranca := StrToFloatDef(Copy(SegT,199,15),0)/100;
        ValorMoraJuros       := StrToFloatDef(Copy(SegU, 18,15),0)/100;
        ValorDesconto        := StrToFloatDef(Copy(SegU, 33,15),0)/100;
        ValorAbatimento      := StrToFloatDef(Copy(SegU, 48,15),0)/100;
        ValorIOF             := StrToFloatDef(Copy(SegU, 63,15),0)/100;
        ValorRecebido        := StrToFloatDef(Copy(SegU, 93,15),0)/100;
        ValorOutrasDespesas  := StrToFloatDef(Copy(SegU,108,15),0)/100;
        ValorOutrosCreditos  := StrToFloatDef(Copy(SegU,123,15),0)/100;
        DataOcorrencia       := StringToDateTimeDef( Copy(SegU,138,2) +'/'+
                                                     Copy(SegU,140,2) +'/'+
                                                     Copy(SegU,142,4),
                                                     0, 'dd/mm/yyyy' );
        DataCredito          := StringToDateTimeDef( Copy(SegU,146,2) +'/'+
                                                     Copy(SegU,148,2) +'/'+
                                                     Copy(SegU,150,4),
                                                     0, 'dd/mm/yyyy' );

        OcorrenciaOriginal.Tipo := CodOcorrenciaToTipo(StrToIntDef(Copy(SegT, 16, 2), 0));

        IdxMotivo := 214;
        while (IdxMotivo < 223) do
        begin
          if (trim(Copy(SegT, IdxMotivo, 2)) <> '') then begin
            MotivoRejeicaoComando.Add(Copy(SegT, IdxMotivo, 2));
            DescricaoMotivoRejeicaoComando.Add(
               CodMotivoRejeicaoToDescricao(OcorrenciaOriginal.Tipo, StrToIntDef(Copy(SegT, IdxMotivo, 2), 0)));
          end;
          Inc(IdxMotivo, 2);
        end;
      end;
   end;
end;

end.

