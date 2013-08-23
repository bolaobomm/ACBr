{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009   Isaque Pinheiro                      }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
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

{******************************************************************************
|* Historico
|*
|* 23/08/2013: Juliana Tamizou
|*  - Distribuição da Primeira Versao
*******************************************************************************}

unit ACBrSEF2_BlocoE_1;

interface

Uses SysUtils, Classes, Contnrs, ACBrSEF2_BlocoE, ACBrSEF2Conversao,
     ACBrTXTClass, ACBrSEF2_Bloco9;
type
  TBloco_E = class(TACBrSEFIIEDOC)
  private
    FRegistroE001: TRegistroSEFE001;
    FRegistroE990: TRegistroSEFE990;

    FRegistroE020Count: Integer;
    FRegistroE025Count: Integer;
    FRegistroE060Count: Integer;
    FRegistroE080Count: Integer;
    FRegistroE085Count: Integer;

    procedure WriteRegistroE003(RegE001: TRegistroSEFE001);
    procedure WriteRegistroE020(RegE001: TRegistroSEFE001);
    procedure WriteRegistroE025(RegE020: TRegistroSEFE020);
    procedure WriteRegistroE060(RegE001: TRegistroSEFE001);
    procedure WriteRegistroE080(RegE001: TRegistroSEFE001);
    procedure WriteRegistroE085(RegE080: TRegistroSEFE080);

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LimpaRegistros;

    function RegistroE001New : TRegistroSEFE001;
    function RegistroE003New : TRegistroSEFE003;
    function RegistroE020New : TRegistroSEFE020;
    function RegistroE025New : TRegistroSEFE025;
    function RegistroE050New : TRegistroSEFE050;
    function RegistroE055New : TRegistroSEFE055;
    function RegistroE060New : TRegistroSEFE060;
    function RegistroE065New : TRegistroSEFE065;
    function RegistroE080New : TRegistroSEFE080;
    function RegistroE085New : TRegistroSEFE085;
    function RegistroE300New : TRegistroSEFE300;
    function RegistroE305New : TRegistroSEFE305;

    procedure WriteRegistroE001;
    procedure WriteRegistroE990;

    property RegistroE001: TRegistroSEFE001 read FRegistroE001 write FRegistroE001;
    property RegistroE990: TRegistroSEFE990 read FRegistroE990 write FRegistroE990;

    property RegistroE020Count: Integer read FRegistroE020Count write FRegistroE020Count;
    property RegistroE025Count: Integer read FRegistroE025Count write FRegistroE025Count;
    property RegistroE060Count: Integer read FRegistroE060Count write FRegistroE060Count;
    property RegistroE080Count: Integer read FRegistroE080Count write FRegistroE080Count;
    property RegistroE085Count: Integer read FRegistroE085Count write FRegistroE085Count;
  end;


implementation

function IntToStrNull(AInteger : Integer) : string;
begin
   if AInteger = 0 then
     Result := ''
   else
     Result := IntToStr(AInteger);
end;


function ConvertIndicadorConteudo(SEFIIIndicadorConteudo : TSEFIIIndicadorConteudo) : string;
begin
  case SEFIIIndicadorConteudo of
     icContConteudo : Result := '0';
     icSemConteudo : Result := '1';
  end;
end;

function ConvertIndiceOperacao(IndiceOperacao : TIndiceOperacao) : string;
begin
  case IndiceOperacao of
    SefioEntrada : Result := '0';
    SefioSaida : Result := '1';
  end;
end;

function ConvertTIndiceEmissao(IndiceEmissao :TIndiceEmissao) : string;
begin
  Case IndiceEmissao of
    SefiePropria : Result := '0';
    SefieTerceiros : Result := '1';
  end;
end;

function ConvertSEFIIDocFiscalReferenciado(SEFIIDocFiscalReferenciado : TSEFIIDocFiscalReferenciado) : string;
begin
  Case SEFIIDocFiscalReferenciado of
    SrefNF : Result := '01';
    SrefNFVCCVC : Result := '02';
    SrefCCF : Result := '2D';
    SrefCBP : Result := '2E';
    SrefNFPR : Result := '04';
    SrefNFEE : Result := '06';
    SrefNFTR : Result := '07';
    SrefCTRC : Result := '08';
    SrefCTAQ : Result := '09';
    SrefCTAR : Result := '10';
    SrefCTFC : Result := '11';
    SrefBPR : Result := '13';
    SrefBPAQ : Result := '14';
    SrefBPNB : Result := '15';
    SrefBPF : Result := '16';
    SrefDT : Result := '17';
    SrefRMD : Result := '18';
    SrefOCC : Result := '20';
    SrefNFSC : Result := '21';
    SrefNFST : Result := '22';
    SrefGNRE : Result := '23';
    SrefACT : Result := '24';
    SrefMC : Result := '25';
    SrefCTMC : Result := '26';
    SrefNFTF : Result := '27';
    SrefNFGC : Result := '28';
    SrefNFAC : Result := '29';
    SrefMV : Result := '30';
    SrefBRP : Result := '31';
    SrefNFe : Result := '55';
    SrefCTe : Result := '57';
  end;
end;

function ConvertCodigoSituacao(CodigoSituacao : TCodigoSituacao) : string;
begin
  Case CodigoSituacao of
    SefcsEmissaonormal : Result := '00';
    SefcsEmissaocontingencia : Result := '01';
    SefcsEmissaocontingenciaFS : Result := '02';
    SefcsEmissaocontingenciaSCAN : Result := '03';
    SefcsEmissaocontingenciaDPEC : Result := '04';
    SefcsEmissaocontingenciaFSDA : Result := '05';
    SefcsEmissaoavulsa : Result := '10';
    SefcsComplemento : Result := '20';
    SefcsConsolidavalores : Result := '25';
    SefcsAutorizadenegada : Result := '80';
    SefcsNumerainutilizada : Result := '81';
    SefcsOperacancelada : Result := '90';
    SefcsNegociodesfeito : Result := '91';
    SefcsAjusteinformacoes : Result := '95';
    SefcsSemrepercussaofiscal : Result := '99';
  end;
end;


function ConvertIndicePagamento(IndicePagamento : TIndicePagamento) : string;
begin
  case IndicePagamento of
   SefipAVista : Result := '0';
   SefAPrazao : Result := '1';
   SefNaoOnerada : Result := '2';
  end;
end;

function FloatToStrBull(AFloat : Currency) : string;
begin
  if AFloat = 0 then
    Result := ''
  else
    Result := Format('%0.2f',[AFloat]);
end;


{ TBlocoE }

constructor TBloco_E.Create;
begin
   inherited ;
   CriaRegistros;
end;

destructor TBloco_E.Destroy;
begin
   LiberaRegistros;
   inherited;
end;

procedure TBloco_E.WriteRegistroE001;
var
  Astr: String;
begin
   if Assigned(FRegistroE001) then
   begin
      with FRegistroE001 do
      begin
         Astr:=  LFill( 'E001' ) +
                 LFill( Integer(IND_MOV), 1 );

         Add(Astr);

         //WriteRegistroE020(FRegistroE001);
         //WriteRegistroE300(FRegistroE001);
         //WriteRegistroE500(FRegistroE001);
      end;

      RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
   end;
end;

procedure TBloco_E.WriteRegistroE003(RegE001: TRegistroSEFE001);
begin
  Exit;
end;

procedure TBloco_E.WriteRegistroE020(RegE001: TRegistroSEFE001);
var
  intFor : Integer;
  RegE020: TRegistroSEFE020;
begin
   for intFor := 0 to RegE001.RegistroE020.Count - 1 do
   begin
      RegE020 := TRegistroSEFE020(RegE001.RegistroE020.Items[intFor]);
      with RegE020 do
      begin
          Add( LFill('E020') +
               LFill(ConvertIndiceOperacao(IND_OPER)) +
               LFill(ConvertTIndiceEmissao(IND_EMIT)) +
               LFill(COD_PART) +
               LFill(ConvertSEFIIDocFiscalReferenciado(COD_MOD))  +
               LFill(ConvertCodigoSituacao(COD_SIT)) +
               LFill(SER) +
               LFill(NUM_DOC,0) +
               LFill(CHV_NFE) +
               LFill(DT_EMIS) +
               LFill(DT_DOC) +
               LFill(COP) +
               LFill(NUM_LCTO) +
               LFill(VL_CONT,2) +
               LFill(VL_OP_ISS,2) +
               LFill(VL_BC_ICMS) +
               LFill(VL_ICMS,2) +
               LFill(VL_ICMS_ST,2) +
               LFill(VL_ST_E,2) +
               LFill(VL_ST_S,2) +
               LFill(VL_ISNT_ICMS,2) +
               LFill(VL_OUT_ICMS,2) +
               LFill(VL_BC_IPI,2) +
               LFill(VL_IPI,2) +
               LFill(VL_ISNT_IPI,2) +
               LFill(VL_OUT_IPI,2) +
               LFill(COD_INF_OBS));
      end;

      WriteRegistroE025(RegE020);

      RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
   end;

   FRegistroE020Count := FRegistroE020Count + RegE001.RegistroE020.Count;
end;

procedure TBloco_E.WriteRegistroE025(RegE020: TRegistroSEFE020);
var
  intFor : Integer;
  RegE025: TRegistroSEFE025;
begin
   if Assigned(RegE020.RegistroE025) then
   begin
      for intFor := 0 to RegE020.RegistroE025.Count - 1 do
      begin
         RegE025:= TRegistroSEFE025(RegE020.RegistroE025.Items[intFor]);
         with RegE025  do
         begin
            Add( LFill('E025') +
                 LFill(VL_CONT_P,2) +
                 LFill(VL_OP_ISS_P,2) +
                 LFill(CFOP) +
                 LFill(VL_BC_ICMS_P,2) +
                 LFill(ALIQ_ICMS,2) +
                 LFill(VL_ICMS_P,2) +
                 LFill(VL_BC_ST_P,2) +
                 LFill(VL_ICMS_ST_P,2) +
                 LFill(VL_ISNT_ICMS_P,2) +
                 LFill(VL_OUT_ICMS_P,2) +
                 LFill(VL_BC_IPI_P,2) +
                 LFill(VL_IPI_P,2) +
                 LFill(VL_ISNT_IPI_P,2) +
                 LFill(VL_OUT_IPI_P,2) +
                 LFill(IND_PETR) +
                 LFill(IND_IMUN));
         end;
         RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
      end;
      FRegistroE025Count := FRegistroE025Count + RegE020.RegistroE025.Count;
   end;
end;

procedure TBloco_E.WriteRegistroE060(RegE001: TRegistroSEFE001);
var
  intFor : Integer;
  RegE060: TRegistroSEFE060;
begin
   for intFor := 0 to RegE001.RegistroE060.Count - 1 do
   begin
      RegE060 := TRegistroSEFE060(RegE001.RegistroE060.Items[intFor]);
      with RegE060 do
      begin
         Add( LFill('E060') +
              LFill(ConvertSEFIIDocFiscalReferenciado(COD_MOD))  +
              LFill(ECF_CX) +
              LFill(ECF_FAB) +
              LFill(CRO) +
              LFill(CRZ) +
              LFill(DT_DOC) +
              LFill(NUM_DOC_INI) +
              LFill(NUM_DOC_FIN) +
              LFill(GT_INI) +
              LFill(GT_FIN) +
              LFill(VL_BRT,2) +
              LFill(VL_CANC_ICMS,2) +
              LFill(VL_DESC_ICMS,2) +
              LFill(VL_ACMO_ICMS,2) +
              LFill(VL_OP_ISS,2) +
              LFill(VL_LIQ,2) +
              LFill(VL_BC_ICMS,2) +
              LFill(VL_ICMS,2) +
              LFill(VL_ISN,2) +
              LFill(VL_NT,2) +
              LFill(VL_ST,2) +
              LFill(COD_INF_OBS));
      end;

      //WriteRegistroE065(RegE060);

      RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
   end;

   FRegistroE060Count := FRegistroE060Count + RegE001.RegistroE060.Count;
end;

procedure TBloco_E.WriteRegistroE080(RegE001: TRegistroSEFE001);
var
  intFor : Integer;
  RegE080: TRegistroSEFE080;
begin
   for intFor := 0 to RegE001.RegistroE080.Count - 1 do
   begin
      RegE080 := TRegistroSEFE080(RegE001.RegistroE080.Items[intFor]);
      with RegE080 do
      begin
         Add( LFill('E080')         +
              LFill(IND_TOT)        +
              LFill(COD_MOD)        +
              LFill(NUM_MR)         +
              LFill(DT_DOC)         +
              LFill(VL_BRT,2)       +
              LFill(VL_CANC_ICMS,2) +
              LFill(VL_DESC_ICMS,2) +
              LFill(VL_ACMO_ICMS,2) +
              LFill(VL_OP_ISS,2)    +
              LFill(COP)            +
              LFill(NUM_LCTO)       +
              LFill(VL_CONT,2)      +
              LFill(VL_BC_ICMS,2)   +
              LFill(VL_ICMS,2)      +
              LFill(VL_ISNT_ICMS,2) +
              LFill(VL_ST,2)        +
              LFill(IND_OBS));
      end;

      //WriteRegistroE085(RegE080);

      RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
   end;

   FRegistroE080Count := FRegistroE080Count + RegE001.RegistroE080.Count;
end;

procedure TBloco_E.WriteRegistroE085(RegE080: TRegistroSEFE080);
var
   intFor : Integer;
   RegE085: TRegistroSEFE085;
begin
   if Assigned(RegE080.RegistroE085) then
   begin
      for intFor := 0 to RegE080.RegistroE085.Count - 1 do
      begin
         RegE085:= TRegistroSEFE085(RegE080.RegistroE085.Items[intFor]);
         with RegE085  do
         begin
            Add( LFill('E085')           +
                 LFill(VL_CONT_P,2)      +
                 LFill(VL_OP_ISS_P,2)    +
                 LFill(CFOP)             +
                 LFill(VL_BC_ICMS_P,2)   +
                 LFill(ALIQ_ICMS,2)      +
                 LFill(VL_ICMS_P,2)      +
                 LFill(VL_ISNT_ICMS_P,2) +
                 LFill(VL_ST_P,2)        +
                 LFill(IND_IMUN));
         end;
         RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
      end;
      FRegistroE085Count := FRegistroE085Count + RegE080.RegistroE085.Count;
   end;
end;

procedure TBloco_E.WriteRegistroE990;
var
  strLinha : String;
begin
   //--Before
   strLinha := '';

   if Assigned(RegistroE990) then
   begin
      with RegistroE990 do
      begin
        QTD_LIN_E := QTD_LIN_E + 1;

        strLinha := LFill('E990') +
                    LFill(QTD_LIN_E,0);
        Add(strLinha);
      end;
   end;
end;

procedure TBloco_E.CriaRegistros;
begin
   FRegistroE001 := TRegistroSEFE001.Create;
   FRegistroE990 := TRegistroSEFE990.Create;

   FRegistroE020Count := 0;
   FRegistroE025Count := 0;
   FRegistroE060Count := 0;
   FRegistroE080Count := 0;
   FRegistroE085Count := 0;
   FRegistroE990.QTD_LIN_E := 0;
end;

procedure TBloco_E.LiberaRegistros;
begin
   FRegistroE001.Free;
   FRegistroE990.Free;
end;

function TBloco_E.RegistroE003New: TRegistroSEFE003;
begin
   Result := FRegistroE001.RegistroE003.New(FRegistroE001);
end;

function TBloco_E.RegistroE020New: TRegistroSEFE020;
begin
   Result := FRegistroE001.RegistroE020.New(FRegistroE001);
end;

procedure TBloco_E.LimpaRegistros;
begin
   /// Limpa os Registros
   LiberaRegistros;
   Conteudo.Clear;

   /// Recriar os Registros Limpos
   CriaRegistros;
end;

function TBloco_E.RegistroE025New: TRegistroSEFE025;
var
  E020: TRegistroSEFE020;
begin
   with FRegistroE001.RegistroE020 do
      E020 := TRegistroSEFE020(Items[ AchaUltimoPai('E020', 'E025') ]);

   Result := E020.RegistroE025.New(E020);
end;

function TBloco_E.RegistroE050New: TRegistroSEFE050;
begin
   Result := FRegistroE001.RegistroE050.New(FRegistroE001);
end;

function TBloco_E.RegistroE055New: TRegistroSEFE055;
var
  E050: TRegistroSEFE050;
begin
   with FRegistroE001.RegistroE050 do
      E050 := TRegistroSEFE050(Items[ AchaUltimoPai('E050', 'E055') ]);

   Result := E050.RegistroE055.New(E050);
end;

function TBloco_E.RegistroE060New: TRegistroSEFE060;
begin
   Result := FRegistroE001.RegistroE060.New(FRegistroE001);
end;

function TBloco_E.RegistroE065New: TRegistroSEFE065;
var
  E060: TRegistroSEFE060;
begin
   with FRegistroE001.RegistroE060 do
      E060 := TRegistroSEFE060(Items[ AchaUltimoPai('E060', 'E065') ]);

   Result := E060.RegistroE065.New(E060);
end;

function TBloco_E.RegistroE080New: TRegistroSEFE080;
begin
   Result := FRegistroE001.RegistroE080.New(FRegistroE001);
end;

function TBloco_E.RegistroE085New: TRegistroSEFE085;
var
  E080: TRegistroSEFE080;
begin
   with FRegistroE001.RegistroE080 do
      E080 := TRegistroSEFE080(Items[ AchaUltimoPai('E080', 'E085') ]);

   Result := E080.RegistroE085.New(E080);
end;

function TBloco_E.RegistroE300New: TRegistroSEFE300;
begin
   Result := FRegistroE001.RegistroE300.New(FRegistroE001);
end;

function TBloco_E.RegistroE305New: TRegistroSEFE305;
var
  E300: TRegistroSEFE300;
begin
   with FRegistroE001.RegistroE300 do
      E300 := TRegistroSEFE300(Items[ AchaUltimoPai('E300', 'E305') ]);

   Result := E300.RegistroE305.New(E300);
end;

function TBloco_E.RegistroE001New: TRegistroSEFE001;
begin
   Result := FRegistroE001;
end;

end.
