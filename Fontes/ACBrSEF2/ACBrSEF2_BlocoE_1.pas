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

  { TBloco_E }

  TBloco_E = class(TACBrSEFIIEDOC)
  private
    FRegistroE001: TRegistroSEFE001;
    FRegistroE990: TRegistroSEFE990;

    FRegistroE020Count: Integer;
    FRegistroE025Count: Integer;
    FRegistroE050Count: Integer;
    FRegistroE055Count: Integer;
    FRegistroE060Count: Integer;
    FRegistroE065Count: Integer;
    FRegistroE080Count: Integer;
    FRegistroE085Count: Integer;
    FRegistroE300Count: Integer;
    FRegistroE305Count: Integer;
    FRegistroE310Count: Integer;
    FRegistroE330Count: Integer;
    FRegistroE340Count: Integer;
    FRegistroE350Count: Integer;
    FRegistroE360Count: Integer;


    //procedure WriteRegistroE003(RegE001: TRegistroSEFE001);
    procedure WriteRegistroE020(RegE001: TRegistroSEFE001);
    procedure WriteRegistroE025(RegE020: TRegistroSEFE020);
    procedure WriteRegistroE050(RegE001: TRegistroSEFE001);
    procedure WriteRegistroE055(RegE050: TRegistroSEFE050);
    procedure WriteRegistroE060(RegE001: TRegistroSEFE001);
    procedure WriteRegistroE065(RegE060: TRegistroSEFE060);
    procedure WriteRegistroE080(RegE001: TRegistroSEFE001);
    procedure WriteRegistroE085(RegE080: TRegistroSEFE080);
    procedure WriteRegistroE300(RegE001: TRegistroSEFE001);
    procedure WriteRegistroE305(RegE300: TRegistroSEFE300);
    procedure WriteRegistroE310(RegE300: TRegistroSEFE300);
    procedure WriteRegistroE330(RegE300: TRegistroSEFE300);
    procedure WriteRegistroE340(RegE300: TRegistroSEFE300);
    procedure WriteRegistroE350(RegE300: TRegistroSEFE300);
    procedure WriteRegistroE360(RegE300: TRegistroSEFE300);

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
    function RegistroE310New : TRegistroSEFE310;
    function RegistroE330New : TRegistroSEFE330;
    function RegistroE350New : TRegistroSEFE350;
    function RegistroE360New : TRegistroSEFE360;

    procedure WriteRegistroE001;
    procedure WriteRegistroE990;

    property RegistroE001: TRegistroSEFE001 read FRegistroE001 write FRegistroE001;
    property RegistroE990: TRegistroSEFE990 read FRegistroE990 write FRegistroE990;

    property RegistroE020Count: Integer read FRegistroE020Count write FRegistroE020Count;
    property RegistroE025Count: Integer read FRegistroE025Count write FRegistroE025Count;
    property RegistroE050Count: Integer read FRegistroE050Count write FRegistroE050Count;
    property RegistroE055Count: Integer read FRegistroE055Count write FRegistroE055Count;
    property RegistroE060Count: Integer read FRegistroE060Count write FRegistroE060Count;
    property RegistroE065Count: Integer read FRegistroE065Count write FRegistroE065Count;
    property RegistroE080Count: Integer read FRegistroE080Count write FRegistroE080Count;
    property RegistroE085Count: Integer read FRegistroE085Count write FRegistroE085Count;
    property RegistroE300Count: Integer read FRegistroE300Count write FRegistroE300Count;
    property RegistroE305Count: Integer read FRegistroE305Count write FRegistroE305Count;
    property RegistroE310Count: Integer read FRegistroE310Count write FRegistroE310Count;
    property RegistroE330Count: Integer read FRegistroE330Count write FRegistroE330Count;
    property RegistroE340Count: Integer read FRegistroE340Count write FRegistroE340Count;
    property RegistroE350Count: Integer read FRegistroE350Count write FRegistroE350Count;
    property RegistroE360Count: Integer read FRegistroE360Count write FRegistroE360Count;
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
    SrefNF      : Result := '01';
    SrefNFVCCVC : Result := '02';
    SrefCCF     : Result := '2D';
    SrefCBP     : Result := '2E';
    SrefNFPR    : Result := '04';
    SrefNFEE    : Result := '06';
    SrefNFTR    : Result := '07';
    SrefCTRC    : Result := '08';
    SrefCTAQ    : Result := '09';
    SrefCTAR    : Result := '10';
    SrefCTFC    : Result := '11';
    SrefBPR     : Result := '13';
    SrefBPAQ    : Result := '14';
    SrefBPNB    : Result := '15';
    SrefBPF     : Result := '16';
    SrefDT      : Result := '17';
    SrefRMD     : Result := '18';
    SrefOCC     : Result := '20';
    SrefNFSC    : Result := '21';
    SrefNFST    : Result := '22';
    SrefGNRE    : Result := '23';
    SrefACT     : Result := '24';
    SrefMC      : Result := '25';
    SrefCTMC    : Result := '26';
    SrefNFTF    : Result := '27';
    SrefNFGC    : Result := '28';
    SrefNFAC    : Result := '29';
    SrefMV      : Result := '30';
    SrefBRP     : Result := '31';
    SrefNFe     : Result := '55';
    SrefCTe     : Result := '57';
  end;
end;

function ConvertCodigoSituacao(CodigoSituacao : TCodigoSituacao) : string;
begin
  Case CodigoSituacao of
    SefcsEmissaonormal           : Result := '00';
    SefcsEmissaocontingencia     : Result := '01';
    SefcsEmissaocontingenciaFS   : Result := '02';
    SefcsEmissaocontingenciaSCAN : Result := '03';
    SefcsEmissaocontingenciaDPEC : Result := '04';
    SefcsEmissaocontingenciaFSDA : Result := '05';
    SefcsEmissaoavulsa           : Result := '10';
    SefcsComplemento             : Result := '20';
    SefcsConsolidavalores        : Result := '25';
    SefcsAutorizadenegada        : Result := '80';
    SefcsNumerainutilizada       : Result := '81';
    SefcsOperacancelada          : Result := '90';
    SefcsNegociodesfeito         : Result := '91';
    SefcsAjusteinformacoes       : Result := '95';
    SefcsSemrepercussaofiscal    : Result := '99';
  end;
end;


function ConvertIndicePagamento(IndicePagamento : TIndicePagamento) : string;
begin
  case IndicePagamento of
   SefNenhum     : Result := '';
   SefipAVista   : Result := '0';
   SefAPrazao    : Result := '1';
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

function CalculaCOP(CFOP : String) : String;
begin
  Case StrToIntDef(CFOP,0) of
    0    : Result := 'OP00';
    1101 : Result := 'EA10';
    1102 : Result := 'EA10';
    1111 : Result := 'EA10';
    1113 : Result := 'EA10';
    1116 : Result := 'EA10';
    1117 : Result := 'EA10';
    1118 : Result := 'EA10';
    1120 : Result := 'EA10';
    1121 : Result := 'EA10';
    1122 : Result := 'EA10';
    1124 : Result := 'EA30';
    1125 : Result := 'EA30';
    1126 : Result := 'EA10';
    1128 : Result := 'EA10';
    1151 : Result := 'EA60';
    1152 : Result := 'EA60';
    1153 : Result := 'EA60';
    1154 : Result := 'EA60';
    1201 : Result := 'EA20';
    1202 : Result := 'EA20';
    1203 : Result := 'EA20';
    1204 : Result := 'EA20';
    1205 : Result := 'EA80';
    1206 : Result := 'EA80';
    1207 : Result := 'EA80';
    1208 : Result := 'EA60';
    1209 : Result := 'EA60';
    1251 : Result := 'EA10';
    1252 : Result := 'EA10';
    1253 : Result := 'EA10';
    1254 : Result := 'EA10';
    1255 : Result := 'EA10';
    1256 : Result := 'EA10';
    1257 : Result := 'EA10';
    1301 : Result := 'EA70';
    1302 : Result := 'EA70';
    1303 : Result := 'EA70';
    1304 : Result := 'EA70';
    1305 : Result := 'EA70';
    1306 : Result := 'EA70';
    1351 : Result := 'EA70';
    1352 : Result := 'EA70';
    1353 : Result := 'EA70';
    1354 : Result := 'EA70';
    1355 : Result := 'EA70';
    1356 : Result := 'EA70';
    1360 : Result := 'EA70';
    1401 : Result := 'EA10';
    1403 : Result := 'EA10';
    1406 : Result := 'EA10';
    1407 : Result := 'EA10';
    1408 : Result := 'EA60';
    1409 : Result := 'EA60';
    1410 : Result := 'EA20';
    1411 : Result := 'EA20';
    1414 : Result := 'EA30';
    1415 : Result := 'EA30';
    1451 : Result := 'EA30';
    1452 : Result := 'EA30';
    1501 : Result := 'EA50';
    1503 : Result := 'EA40';
    1504 : Result := 'EA40';
    1505 : Result := 'EA40';
    1506 : Result := 'EA40';
    1551 : Result := 'EA10';
    1552 : Result := 'EA60';
    1553 : Result := 'EA20';
    1554 : Result := 'EA30';
    1555 : Result := 'EA50';
    1556 : Result := 'EA10';
    1557 : Result := 'EA60';
    1601 : Result := 'EA90';
    1602 : Result := 'EA90';
    1603 : Result := 'EA91';
    1604 : Result := 'EA90';
    1605 : Result := 'EA90';
    1651 : Result := 'EA10';
    1652 : Result := 'EA10';
    1653 : Result := 'EA10';
    1658 : Result := 'EA60';
    1659 : Result := 'EA60';
    1660 : Result := 'EA20';
    1661 : Result := 'EA20';
    1662 : Result := 'EA20';
    1663 : Result := 'EA50';
    1664 : Result := 'EA30';
    1901 : Result := 'EA50';
    1902 : Result := 'EA30';
    1903 : Result := 'EA30';
    1904 : Result := 'EA30';
    1905 : Result := 'EA50';
    1906 : Result := 'EA30';
    1907 : Result := 'EA30';
    1908 : Result := 'EA50';
    1909 : Result := 'EA30';
    1910 : Result := 'EA50';
    1911 : Result := 'EA50';
    1912 : Result := 'EA50';
    1913 : Result := 'EA30';
    1914 : Result := 'EA30';
    1915 : Result := 'EA50';
    1916 : Result := 'EA30';
    1917 : Result := 'EA50';
    1918 : Result := 'EA30';
    1919 : Result := 'EA30';
    1920 : Result := 'EA50';
    1921 : Result := 'EA30';
    1922 : Result := 'EA90';
    1923 : Result := 'EA50';
    1924 : Result := 'EA50';
    1925 : Result := 'EA30';
    1926 : Result := 'EA65';
    1931 : Result := 'EA90';
    1932 : Result := 'EA70';
    1933 : Result := 'EA10';
    1934 : Result := 'EA50';
    1949 : Result := 'EA99';
    2101 : Result := 'EA10';
    2102 : Result := 'EA10';
    2111 : Result := 'EA10';
    2113 : Result := 'EA10';
    2116 : Result := 'EA10';
    2117 : Result := 'EA10';
    2118 : Result := 'EA10';
    2120 : Result := 'EA10';
    2121 : Result := 'EA10';
    2122 : Result := 'EA10';
    2124 : Result := 'EA30';
    2125 : Result := 'EA30';
    2126 : Result := 'EA10';
    2128 : Result := 'EA10';
    2151 : Result := 'EA60';
    2152 : Result := 'EA60';
    2153 : Result := 'EA60';
    2154 : Result := 'EA60';
    2201 : Result := 'EA20';
    2202 : Result := 'EA20';
    2203 : Result := 'EA20';
    2204 : Result := 'EA20';
    2205 : Result := 'EA80';
    2206 : Result := 'EA80';
    2207 : Result := 'EA80';
    2208 : Result := 'EA60';
    2209 : Result := 'EA60';
    2251 : Result := 'EA10';
    2252 : Result := 'EA10';
    2253 : Result := 'EA10';
    2254 : Result := 'EA10';
    2255 : Result := 'EA10';
    2256 : Result := 'EA10';
    2257 : Result := 'EA10';
    2301 : Result := 'EA70';
    2302 : Result := 'EA70';
    2303 : Result := 'EA70';
    2304 : Result := 'EA70';
    2305 : Result := 'EA70';
    2306 : Result := 'EA70';
    2351 : Result := 'EA70';
    2352 : Result := 'EA70';
    2353 : Result := 'EA70';
    2354 : Result := 'EA70';
    2355 : Result := 'EA70';
    2356 : Result := 'EA70';
    2401 : Result := 'EA10';
    2403 : Result := 'EA10';
    2406 : Result := 'EA10';
    2407 : Result := 'EA10';
    2408 : Result := 'EA60';
    2409 : Result := 'EA60';
    2410 : Result := 'EA20';
    2411 : Result := 'EA20';
    2414 : Result := 'EA30';
    2415 : Result := 'EA30';
    2501 : Result := 'EA50';
    2503 : Result := 'EA40';
    2504 : Result := 'EA40';
    2505 : Result := 'EA40';
    2506 : Result := 'EA40';
    2551 : Result := 'EA10';
    2552 : Result := 'EA60';
    2553 : Result := 'EA20';
    2554 : Result := 'EA30';
    2555 : Result := 'EA50';
    2556 : Result := 'EA10';
    2557 : Result := 'EA60';
    2603 : Result := 'EA91';
    2651 : Result := 'EA10';
    2652 : Result := 'EA10';
    2653 : Result := 'EA10';
    2658 : Result := 'EA60';
    2659 : Result := 'EA60';
    2660 : Result := 'EA20';
    2661 : Result := 'EA20';
    2662 : Result := 'EA20';
    2663 : Result := 'EA50';
    2664 : Result := 'EA30';
    2901 : Result := 'EA50';
    2902 : Result := 'EA30';
    2903 : Result := 'EA30';
    2904 : Result := 'EA30';
    2905 : Result := 'EA50';
    2906 : Result := 'EA30';
    2907 : Result := 'EA30';
    2908 : Result := 'EA50';
    2909 : Result := 'EA30';
    2910 : Result := 'EA50';
    2911 : Result := 'EA50';
    2912 : Result := 'EA50';
    2913 : Result := 'EA30';
    2914 : Result := 'EA30';
    2915 : Result := 'EA50';
    2916 : Result := 'EA30';
    2917 : Result := 'EA50';
    2918 : Result := 'EA40';
    2919 : Result := 'EA30';
    2920 : Result := 'EA50';
    2921 : Result := 'EA30';
    2922 : Result := 'EA90';
    2923 : Result := 'EA50';
    2924 : Result := 'EA50';
    2925 : Result := 'EA30';
    2931 : Result := 'EA90';
    2932 : Result := 'EA70';
    2933 : Result := 'EA10';
    2934 : Result := 'EA50';
    2949 : Result := 'EA99';
    3101 : Result := 'EA10';
    3102 : Result := 'EA10';
    3126 : Result := 'EA10';
    3127 : Result := 'EA10';
    3128 : Result := 'EA10';
    3201 : Result := 'EA20';
    3202 : Result := 'EA20';
    3205 : Result := 'EA80';
    3206 : Result := 'EA80';
    3207 : Result := 'EA80';
    3211 : Result := 'EA20';
    3251 : Result := 'EA10';
    3301 : Result := 'EA70';
    3351 : Result := 'EA70';
    3352 : Result := 'EA70';
    3353 : Result := 'EA70';
    3354 : Result := 'EA70';
    3355 : Result := 'EA70';
    3356 : Result := 'EA70';
    3503 : Result := 'EA40';
    3551 : Result := 'EA10';
    3553 : Result := 'EA20';
    3556 : Result := 'EA10';
    3651 : Result := 'EA10';
    3652 : Result := 'EA10';
    3653 : Result := 'EA10';
    3930 : Result := 'EA50';
    3949 : Result := 'EA99';
    5101 : Result := 'SP10';
    5102 : Result := 'SP10';
    5103 : Result := 'SP10';
    5104 : Result := 'SP10';
    5105 : Result := 'SP10';
    5106 : Result := 'SP10';
    5109 : Result := 'SP10';
    5110 : Result := 'SP10';
    5111 : Result := 'SP10';
    5112 : Result := 'SP10';
    5113 : Result := 'SP10';
    5114 : Result := 'SP10';
    5115 : Result := 'SP10';
    5116 : Result := 'SP10';
    5117 : Result := 'SP10';
    5118 : Result := 'SP10';
    5119 : Result := 'SP10';
    5120 : Result := 'SP10';
    5122 : Result := 'SP10';
    5123 : Result := 'SP10';
    5124 : Result := 'SP50';
    5125 : Result := 'SP50';
    5151 : Result := 'SP60';
    5152 : Result := 'SP60';
    5153 : Result := 'SP60';
    5155 : Result := 'SP60';
    5156 : Result := 'SP60';
    5201 : Result := 'SP20';
    5202 : Result := 'SP20';
    5205 : Result := 'SP80';
    5206 : Result := 'SP80';
    5207 : Result := 'SP80';
    5208 : Result := 'SP60';
    5209 : Result := 'SP60';
    5210 : Result := 'SP20';
    5251 : Result := 'SP10';
    5252 : Result := 'SP10';
    5253 : Result := 'SP10';
    5254 : Result := 'SP10';
    5255 : Result := 'SP10';
    5256 : Result := 'SP10';
    5257 : Result := 'SP10';
    5258 : Result := 'SP10';
    5301 : Result := 'SP70';
    5302 : Result := 'SP70';
    5303 : Result := 'SP70';
    5304 : Result := 'SP70';
    5305 : Result := 'SP70';
    5306 : Result := 'SP70';
    5307 : Result := 'SP70';
    5351 : Result := 'SP70';
    5352 : Result := 'SP70';
    5353 : Result := 'SP70';
    5354 : Result := 'SP70';
    5355 : Result := 'SP70';
    5356 : Result := 'SP70';
    5357 : Result := 'SP70';
    5359 : Result := 'SP70';
    5360 : Result := 'SP70';
    5401 : Result := 'SP10';
    5402 : Result := 'SP10';
    5403 : Result := 'SP10';
    5405 : Result := 'SP10';
    5408 : Result := 'SP60';
    5409 : Result := 'SP60';
    5410 : Result := 'SP20';
    5411 : Result := 'SP20';
    5412 : Result := 'SP20';
    5413 : Result := 'SP20';
    5414 : Result := 'SP30';
    5415 : Result := 'SP30';
    5451 : Result := 'SP30';
    5501 : Result := 'SP30';
    5502 : Result := 'SP30';
    5503 : Result := 'SP50';
    5504 : Result := 'SP30';
    5505 : Result := 'SP30';
    5551 : Result := 'SP10';
    5552 : Result := 'SP60';
    5553 : Result := 'SP20';
    5554 : Result := 'SP30';
    5555 : Result := 'SP50';
    5556 : Result := 'SP20';
    5557 : Result := 'SP60';
    5601 : Result := 'SP90';
    5602 : Result := 'SP90';
    5603 : Result := 'SP91';
    5605 : Result := 'SP90';
    5606 : Result := 'SP90';
    5651 : Result := 'SP10';
    5652 : Result := 'SP10';
    5653 : Result := 'SP10';
    5654 : Result := 'SP10';
    5655 : Result := 'SP10';
    5656 : Result := 'SP10';
    5657 : Result := 'SP30';
    5658 : Result := 'SP60';
    5659 : Result := 'SP60';
    5660 : Result := 'SP20';
    5661 : Result := 'SP20';
    5662 : Result := 'SP20';
    5663 : Result := 'SP30';
    5664 : Result := 'SP50';
    5665 : Result := 'SP50';
    5666 : Result := 'SP30';
    5667 : Result := 'SP10';
    5901 : Result := 'SP30';
    5902 : Result := 'SP50';
    5903 : Result := 'SP50';
    5904 : Result := 'SP30';
    5905 : Result := 'SP30';
    5906 : Result := 'SP50';
    5907 : Result := 'SP50';
    5908 : Result := 'SP30';
    5909 : Result := 'SP50';
    5910 : Result := 'SP30';
    5911 : Result := 'SP30';
    5912 : Result := 'SP30';
    5913 : Result := 'SP50';
    5914 : Result := 'SP30';
    5915 : Result := 'SP30';
    5916 : Result := 'SP50';
    5917 : Result := 'SP30';
    5918 : Result := 'SP50';
    5919 : Result := 'SP50';
    5920 : Result := 'SP30';
    5921 : Result := 'SP50';
    5922 : Result := 'SP90';
    5923 : Result := 'SP30';
    5924 : Result := 'SP30';
    5925 : Result := 'SP50';
    5926 : Result := 'SP65';
    5927 : Result := 'SP65';
    5928 : Result := 'SP65';
    5929 : Result := 'SP90';
    5931 : Result := 'SP90';
    5932 : Result := 'SP70';
    5933 : Result := 'SP10';
    5934 : Result := 'SP30';
    5949 : Result := 'SP99';
    6101 : Result := 'SP10';
    6102 : Result := 'SP10';
    6103 : Result := 'SP10';
    6104 : Result := 'SP10';
    6105 : Result := 'SP10';
    6106 : Result := 'SP10';
    6107 : Result := 'SP10';
    6108 : Result := 'SP10';
    6109 : Result := 'SP10';
    6110 : Result := 'SP10';
    6111 : Result := 'SP10';
    6112 : Result := 'SP10';
    6113 : Result := 'SP10';
    6114 : Result := 'SP10';
    6115 : Result := 'SP10';
    6116 : Result := 'SP10';
    6117 : Result := 'SP10';
    6118 : Result := 'SP10';
    6119 : Result := 'SP10';
    6120 : Result := 'SP10';
    6122 : Result := 'SP10';
    6123 : Result := 'SP10';
    6124 : Result := 'SP50';
    6125 : Result := 'SP50';
    6151 : Result := 'SP60';
    6152 : Result := 'SP60';
    6153 : Result := 'SP60';
    6155 : Result := 'SP60';
    6156 : Result := 'SP60';
    6201 : Result := 'SP20';
    6202 : Result := 'SP20';
    6205 : Result := 'SP80';
    6206 : Result := 'SP80';
    6207 : Result := 'SP80';
    6208 : Result := 'SP50';
    6209 : Result := 'SP50';
    6210 : Result := 'SP20';
    6251 : Result := 'SP10';
    6252 : Result := 'SP10';
    6253 : Result := 'SP10';
    6254 : Result := 'SP10';
    6255 : Result := 'SP10';
    6256 : Result := 'SP10';
    6257 : Result := 'SP10';
    6258 : Result := 'SP10';
    6301 : Result := 'SP70';
    6302 : Result := 'SP70';
    6303 : Result := 'SP70';
    6304 : Result := 'SP70';
    6305 : Result := 'SP70';
    6306 : Result := 'SP70';
    6307 : Result := 'SP70';
    6351 : Result := 'SP70';
    6352 : Result := 'SP70';
    6353 : Result := 'SP70';
    6354 : Result := 'SP70';
    6355 : Result := 'SP70';
    6356 : Result := 'SP70';
    6357 : Result := 'SP70';
    6359 : Result := 'SP70';
    6360 : Result := 'SP70';
    6401 : Result := 'SP10';
    6402 : Result := 'SP10';
    6403 : Result := 'SP10';
    6404 : Result := 'SP10';
    6408 : Result := 'SP60';
    6409 : Result := 'SP60';
    6410 : Result := 'SP20';
    6411 : Result := 'SP20';
    6412 : Result := 'SP20';
    6413 : Result := 'SP20';
    6414 : Result := 'SP30';
    6415 : Result := 'SP30';
    6501 : Result := 'SP30';
    6502 : Result := 'SP30';
    6503 : Result := 'SP50';
    6504 : Result := 'SP30';
    6505 : Result := 'SP30';
    6551 : Result := 'SP10';
    6552 : Result := 'SP60';
    6553 : Result := 'SP20';
    6554 : Result := 'SP30';
    6555 : Result := 'SP50';
    6556 : Result := 'SP20';
    6557 : Result := 'SP60';
    6603 : Result := 'SP91';
    6651 : Result := 'SP10';
    6652 : Result := 'SP10';
    6653 : Result := 'SP10';
    6654 : Result := 'SP10';
    6655 : Result := 'SP10';
    6656 : Result := 'SP10';
    6657 : Result := 'SP30';
    6658 : Result := 'SP60';
    6659 : Result := 'SP60';
    6660 : Result := 'SP20';
    6661 : Result := 'SP20';
    6662 : Result := 'SP20';
    6663 : Result := 'SP30';
    6664 : Result := 'SP50';
    6665 : Result := 'SP50';
    6666 : Result := 'SP30';
    6667 : Result := 'SP10';
    6901 : Result := 'SP30';
    6902 : Result := 'SP50';
    6903 : Result := 'SP50';
    6904 : Result := 'SP30';
    6905 : Result := 'SP30';
    6906 : Result := 'SP50';
    6907 : Result := 'SP50';
    6908 : Result := 'SP30';
    6909 : Result := 'SP50';
    6910 : Result := 'SP30';
    6911 : Result := 'SP30';
    6912 : Result := 'SP30';
    6913 : Result := 'SP50';
    6914 : Result := 'SP30';
    6915 : Result := 'SP30';
    6916 : Result := 'SP50';
    6917 : Result := 'SP30';
    6918 : Result := 'SP50';
    6919 : Result := 'SP50';
    6920 : Result := 'SP30';
    6921 : Result := 'SP50';
    6922 : Result := 'SP90';
    6923 : Result := 'SP30';
    6924 : Result := 'SP30';
    6925 : Result := 'SP50';
    6929 : Result := 'SP90';
    6931 : Result := 'SP90';
    6932 : Result := 'SP70';
    6933 : Result := 'SP10';
    6934 : Result := 'SP30';
    6949 : Result := 'SP99';
    7101 : Result := 'SP10';
    7102 : Result := 'SP10';
    7105 : Result := 'SP10';
    7106 : Result := 'SP10';
    7127 : Result := 'SP10';
    7201 : Result := 'SP20';
    7202 : Result := 'SP20';
    7205 : Result := 'SP80';
    7206 : Result := 'SP80';
    7207 : Result := 'SP80';
    7210 : Result := 'SP20';
    7211 : Result := 'SP20';
    7251 : Result := 'SP10';
    7301 : Result := 'SP70';
    7358 : Result := 'SP70';
    7501 : Result := 'SP10';
    7551 : Result := 'SP10';
    7553 : Result := 'SP20';
    7556 : Result := 'SP20';
    7651 : Result := 'SP10';
    7654 : Result := 'SP10';
    7667 : Result := 'SP10';
    7930 : Result := 'SP20';
    7949 : Result := 'SP99';
  end;
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

         WriteRegistroE020(FRegistroE001);
         WriteRegistroE050(FRegistroE001);
         WriteRegistroE060(FRegistroE001);
         WriteRegistroE080(FRegistroE001);
         WriteRegistroE300(FRegistroE001);
         //WriteRegistroE500(FRegistroE001);
      end;

      RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
   end;
end;

{
procedure TBloco_E.WriteRegistroE003(RegE001: TRegistroSEFE001);
begin
  Exit;
end;
 }
 
procedure TBloco_E.WriteRegistroE020(RegE001: TRegistroSEFE001);
var
  intFor : Integer;
  RegE020: TRegistroSEFE020;
  wCOP: String;
begin
   for intFor := 0 to RegE001.RegistroE020.Count - 1 do
   begin
      RegE020 := TRegistroSEFE020(RegE001.RegistroE020.Items[intFor]);
      with RegE020 do
      begin
          wCOP := CalculaCOP(COD_NAT);
          Add( LFill('E020')                                     +
               LFill(ConvertIndiceOperacao(IND_OPER))            +
               LFill(ConvertTIndiceEmissao(IND_EMIT))            +
               LFill(COD_PART)                                   +
               LFill(ConvertSEFIIDocFiscalReferenciado(COD_MOD)) +
               LFill(ConvertCodigoSituacao(COD_SIT))             +
               LFill(SER)                                        +
               LFill(NUM_DOC,0)                                  +
               LFill(CHV_NFE)                                    +
               LFill(DT_EMIS)                                    +
               LFill(DT_DOC)                                     +
               LFill(COD_NAT)                                    +
               LFill(wCOP)                                       +
               LFill(NUM_LCTO,0)                                 +
               LFill(ConvertIndicePagamento(IND_PGTO))           +
               LFill(VL_CONT,2)                                  +
               LFill(VL_OP_ISS,2)                                +
               LFill(VL_BC_ICMS,2)                               +
               LFill(VL_ICMS,2)                                  +
               LFill(VL_ICMS_ST,2, 2, True)                      +
               LFill(VL_ST_E,2)                                  +
               LFill(VL_ST_S,2)                                  +
               LFill(VL_AT,2, 2, True)                           +
               LFill(VL_ISNT_ICMS,2)                             +
               LFill(VL_OUT_ICMS,2)                              +
               LFill(VL_BC_IPI,2, 2, True)                       +
               LFill(VL_IPI,2, 2, True)                          +
               LFill(VL_ISNT_IPI,2, 2, True)                     +
               LFill(VL_OUT_IPI,2, 2, True)                      +
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
            Add( LFill('E025')                   +
                 LFill(VL_CONT_P, 2)             +
                 LFill(VL_OP_ISS_P, 2)           +
                 LFill(CFOP)                     +
                 LFill(VL_BC_ICMS_P, 2)          +
                 LFill(ALIQ_ICMS, 2, 2, True)    +
                 LFill(VL_ICMS_P, 2)             +
                 LFill(VL_BC_ST_P, 2)            +
                 LFill(VL_ICMS_ST_P, 2)          +
                 LFill(VL_ISNT_ICMS_P, 2)        +
                 LFill(VL_OUT_ICMS_P, 2)         +
                 LFill(VL_BC_IPI_P, 2)           +
                 LFill(VL_IPI_P, 2)              +
                 LFill(VL_ISNT_IPI_P, 2)         +
                 LFill(VL_OUT_IPI_P, 2, 2, True) +
                 LFill(IND_PETR, 1)                 +
                 LFill(IND_IMUN, 1));
         end;
         RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
      end;
      FRegistroE025Count := FRegistroE025Count + RegE020.RegistroE025.Count;
   end;
end;

procedure TBloco_E.WriteRegistroE050(RegE001: TRegistroSEFE001);
var
  intFor : Integer;
  RegE050: TRegistroSEFE050;
  wCOP: String;
begin
   for intFor := 0 to RegE001.RegistroE050.Count - 1 do
   begin
      RegE050 := TRegistroSEFE050(RegE001.RegistroE050.Items[intFor]);
      with RegE050 do
      begin
         wCOP:= CalculaCOP(CFOP);
         Add( LFill('E050')                                     +
              LFill(ConvertSEFIIDocFiscalReferenciado(COD_MOD)) +
              LFill(QTD_CANC,0)                                 +
              LFill(SER)                                        +
              LFill(SUB)                                        +
              LFill(NUM_DOC_INI,0)                              +
              LFill(NUM_DOC_FIN,0)                              +
              LFill(DT_DOC)                                     +
              LFill(wCOP)                                       +
              LFill(NUM_LCTO,0)                                 +
              LFill(VL_CONT,2)                                  +
              LFill(VL_BC_ICMS,2)                               +
              LFill(VL_ICMS,2)                                  +
              LFill(VL_ISNT_ICMS,2)                             +
              LFill(VL_OUT_ICMS,2)                              +
              LFill(COD_INF_OBS));
      end;

      WriteRegistroE055(RegE050);

      RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
   end;

   FRegistroE050Count := FRegistroE050Count + RegE001.RegistroE050.Count;

end;

procedure TBloco_E.WriteRegistroE055(RegE050: TRegistroSEFE050);
var
  intFor : Integer;
  RegE055: TRegistroSEFE055;
begin
   if Assigned(RegE050.RegistroE055) then
   begin
      for intFor := 0 to RegE050.RegistroE055.Count - 1 do
      begin
         RegE055:= TRegistroSEFE055(RegE050.RegistroE055.Items[intFor]);
         with RegE055  do
         begin
            Add( LFill('E055')                   +
                 LFill(VL_CONT_P, 2)             +
                 LFill(CFOP)                     +
                 LFill(VL_BC_ICMS_P, 2)          +
                 LFill(ALIQ_ICMS, 2, 2, True)    +
                 LFill(VL_ICMS_P, 2)             +
                 LFill(VL_ISNT_ICMS_P, 2)        +
                 LFill(VL_OUT_ICMS_P, 2)         +
                 LFill(IND_IMUN));
         end;
         RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
      end;
      FRegistroE055Count := FRegistroE055Count + RegE050.RegistroE055.Count;
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
         Add( LFill('E060')                                     +
              LFill(ConvertSEFIIDocFiscalReferenciado(COD_MOD)) +
              LFill(ECF_CX,0)                                   +
              LFill(ECF_FAB)                                    +
              LFill(CRO,0)                                      +
              LFill(CRZ,0)                                      +
              LFill(DT_DOC)                                     +
              LFill(NUM_DOC_INI,0)                              +
              LFill(NUM_DOC_FIN,0)                              +
              LFill(GT_INI,2)                                   +
              LFill(GT_FIN,2)                                   +
              LFill(VL_BRT,2)                                   +
              LFill(VL_CANC_ICMS,2)                             +
              LFill(VL_DESC_ICMS,2)                             +
              LFill(VL_ACMO_ICMS,2)                             +
              LFill(VL_OP_ISS,2)                                +
              LFill(VL_LIQ,2)                                   +
              LFill(VL_BC_ICMS,2)                               +
              LFill(VL_ICMS,2)                                  +
              LFill(VL_ISN,2)                                   +
              LFill(VL_NT,2)                                    +
              LFill(VL_ST,2)                                    +
              LFill(COD_INF_OBS));
      end;

      WriteRegistroE065(RegE060);

      RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
   end;

   FRegistroE060Count := FRegistroE060Count + RegE001.RegistroE060.Count;
end;

procedure TBloco_E.WriteRegistroE065(RegE060: TRegistroSEFE060);
var
  intFor : Integer;
  RegE065: TRegistroSEFE065;
begin
   if Assigned(RegE060.RegistroE065) then
   begin
      for intFor := 0 to RegE060.RegistroE065.Count - 1 do
      begin
         RegE065:= TRegistroSEFE065(RegE060.RegistroE065.Items[intFor]);
         with RegE065  do
         begin
            Add( LFill('E065')          +
                 LFill(CFOP)            +
                 LFill(VL_BC_ICMS_P, 2) +
                 LFill(ALIQ_ICMS, 2)    +
                 LFill(VL_ICMS_P, 2)    +
                 LFill(IND_IMUN));
         end;
         RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
      end;
      FRegistroE065Count := FRegistroE065Count + RegE060.RegistroE065.Count;
   end;
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
              LFill(IND_TOT, 1)     +
              LFill(COD_MOD)        +
              LFill(NUM_MR, 2)      +
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

      WriteRegistroE085(RegE080);

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
                 LFill(CFOP,4)           +
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

procedure TBloco_E.WriteRegistroE300(RegE001: TRegistroSEFE001);
var
  intFor : Integer;
  RegE300: TRegistroSEFE300;
begin
   for intFor := 0 to RegE001.RegistroE300.Count - 1 do
   begin
      RegE300 := TRegistroSEFE300(RegE001.RegistroE300.Items[intFor]);
      with RegE300 do
      begin
         Add( LFill('E300')         +
              LFill(DT_INI)         +
              LFill(DT_FIN));
      end;

      WriteRegistroE305(RegE300);
      WriteRegistroE310(RegE300);
      WriteRegistroE330(RegE300);
      WriteRegistroE340(RegE300);
      WriteRegistroE350(RegE300);
      WriteRegistroE360(RegE300);


      RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
   end;

   FRegistroE300Count := FRegistroE300Count + RegE001.RegistroE300.Count;
end;

procedure TBloco_E.WriteRegistroE305(RegE300: TRegistroSEFE300);
var
   intFor : Integer;
   RegE305: TRegistroSEFE305;
begin
   if Assigned(RegE300.RegistroE305) then
   begin
      for intFor := 0 to RegE300.RegistroE305.Count - 1 do
      begin
         RegE305:= TRegistroSEFE305(RegE300.RegistroE305.Items[intFor]);
         with RegE305  do
         begin
            Add( LFill('E305')         +
                 LFill(IND_MRO)        +
                 LFill(IND_OPER)       +
                 LFill(DT_DOC)         +
                 LFill(COP)            +
                 LFill(NUM_LCTO)       +
                 LFill(QTD_LCTO)       +
                 LFill(VL_CONT, 2)     +
                 LFill(VL_OP_ISS, 2)   +
                 LFill(VL_BC_ICMS, 2)  +
                 LFill(VL_ICMS, 2)     +
                 LFill(VL_ICMS_ST, 2)  +
                 LFill(VL_ST_ENT, 2)   +
                 LFill(VL_ST_FNT, 2)   +
                 LFill(VL_ST_UF, 2)    +
                 LFill(VL_ST_OE, 2)    +
                 LFill(VL_AT, 2)       +
                 LFill(VL_ISNT_ICMS, 2)+
                 LFill(VL_OUT_ICMS, 2) +
                 LFill(VL_BC_IPI, 2)   +
                 LFill(VL_IPI, 2)      +
                 LFill(VL_ISNT_IPI, 2) +
                 LFill(VL_OUT_IPI, 2) );
         end;
         RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
      end;
      FRegistroE305Count := FRegistroE305Count + RegE300.RegistroE305.Count;
   end;
end;

procedure TBloco_E.WriteRegistroE310(RegE300: TRegistroSEFE300);
var
 intFor : Integer;
 RegE310: TRegistroSEFE310;
begin
   if Assigned(RegE300.RegistroE310) then
   begin
      for intFor := 0 to RegE300.RegistroE310.Count - 1 do
        begin
         RegE310:= TRegistroSEFE310(RegE300.RegistroE310.Items[intFor]);
         with RegE310  do
            begin
              Add( LFill('E310')          +
                   LFill(VL_CONT, 2)      +
                   LFill(VL_OP_ISS, 2)    +
                   LFill(CFOP, 4)         +
                   LFill(VL_BC_ICMS, 2)   +
                   LFill(VL_ICMS, 2)      +
                   LFill(VL_ICMS_ST, 2)   +
                   Lfill(VL_ISNT_ICMS, 2) +
                   LFill(VL_OUT_ICMS, 2)  +
                   LFill(IND_IMUN, 1));
             end;
         RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
         end;
     /// Variav鬠para armazenar a quantidade de registro do tipo.
     FRegistroE310Count := FRegistroE310Count + RegE300.RegistroE310.Count;
  end;
end;

procedure TBloco_E.WriteRegistroE330(RegE300: TRegistroSEFE300);
var
 intFor : Integer;
 RegE330: TRegistroSEFE330;
begin
   if Assigned(RegE300.RegistroE330) then
   begin
      for intFor := 0 to RegE300.RegistroE330.Count - 1 do
        begin
         RegE330:= TRegistroSEFE330(RegE300.RegistroE330.Items[intFor]);
         with RegE330  do
            begin
              Add( LFill('E330')          +
                   LFill(IND_TOT, 1)      +
                   LFill(VL_CONT, 2)      +
                   LFill(VL_OP_ISS, 2)    +
                   LFill(VL_BC_ICMS, 2)   +
                   LFill(VL_ICMS, 2)      +
                   LFill(VL_ICMS_ST, 2)   +
                   LFill(VL_ST_ENT, 2)    +
                   LFill(VL_ST_FNT, 2)    +
                   LFill(VL_ST_UF, 2)     +
                   LFill(VL_ST_OE, 2)     +
                   LFill(VL_AT, 2)        +
                   LFill(VL_ISNT_ICMS, 2) +
                   LFill(VL_OUT_ICMS, 2));
             end;
         RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
         end;
     /// Variav鬠para armazenar a quantidade de registro do tipo.
     FRegistroE330Count := FRegistroE330Count + RegE300.RegistroE330.Count;
  end;
end;


procedure TBloco_E.WriteRegistroE340(RegE300: TRegistroSEFE300);
var
 intFor : Integer;
 RegE340: TRegistroSEFE340;
begin
  if Assigned(RegE300.RegistroE340) then
  begin
  for intFor := 0 to RegE300.RegistroE340.Count - 1 do
    begin
     RegE340:= TRegistroSEFE340(RegE300.RegistroE340.Items[intFor]);
     with RegE340  do
        begin
          Add( LFill('E340')    +
               LFill(VL_01, 2)  +
               LFill(VL_02, 2)  +
               LFill(VL_03, 2)  +
               LFill(VL_04, 2)  +
               LFill(VL_05, 2)  +
               LFill(VL_06, 2)  +
               LFill(VL_07, 2)  +
               LFill(VL_08, 2)  +
               LFill(VL_09, 2)  +
               LFill(VL_10, 2)  +
               LFill(VL_11, 2)  +
               LFill(VL_12, 2)  +
               LFill(VL_13, 2)  +
               LFill(VL_14, 2)  +
               LFill(VL_15, 2)  +
               LFill(VL_16, 2)  +
               LFill(VL_17, 2)  +
               LFill(VL_18, 2)  +
               LFill(VL_19, 2)  +
               LFill(VL_20, 2)  +
               LFill(VL_21, 2)  +
               LFill(VL_22, 2)  +
               LFill(VL_99, 2));
         end;
     RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
     /// Variavel para armazenar a quantidade de registro do tipo.
     FRegistroE340Count := FRegistroE340Count + 1;
    end;
  end;
end;

procedure TBloco_E.WriteRegistroE350(RegE300: TRegistroSEFE300);
var
 intFor : Integer;
 RegE350: TRegistroSEFE350;
begin
   if Assigned(RegE300.RegistroE350) then
   begin
      for intFor := 0 to RegE300.RegistroE350.Count - 1 do
        begin
         RegE350:= TRegistroSEFE350(RegE300.RegistroE350.Items[intFor]);
         with RegE350  do
            begin
              Add( LFill('E350')      +
                   LFill(UF_AJ, 2)    +
                   LFill(COD_AJ, 3)   +
                   LFill(VL_AJ, 2)    +
                   LFill(NUM_DA)      +
                   LFill(NUM_PROC)    +
                   LFill(IND_PROC)    +
                   LFill(DESC_PROC)   +
                   Lfill(COD_INF_OBS) +
                   LFill(IND_AP));
              end;
         RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
         end;
     /// Variav鬠para armazenar a quantidade de registro do tipo.
     FRegistroE350Count := FRegistroE350Count + RegE300.RegistroE350.Count;
  end;
end;

procedure TBloco_E.WriteRegistroE360(RegE300: TRegistroSEFE300);
var
 intFor : Integer;
 RegE360: TRegistroSEFE360;
begin
   if Assigned(RegE300.RegistroE360) then
   begin
      for intFor := 0 to RegE300.RegistroE360.Count - 1 do
        begin
         RegE360:= TRegistroSEFE360(RegE300.RegistroE360.Items[intFor]);
         with RegE360  do
            begin
              Add( LFill('E360')          +
                   LFill(UF_OR, 2) +
                   LFill(COD_OR, 3) +
                   LFill(PER_REF, 6) +
                   LFill(COD_REC) +
                   LFill(VL_ICMS_REC, 2) +
                   LFill(DT_VCTO) +
                   LFill(NUM_PROC) +
                   LFill(IND_PROC) +
                   LFill(DESCR_PROC) +
                   LFill(COD_INF_OBS));
            end;
         RegistroE990.QTD_LIN_E := RegistroE990.QTD_LIN_E + 1;
         end;
     /// Variav鬠para armazenar a quantidade de registro do tipo.
     FRegistroE360Count := FRegistroE360Count + RegE300.RegistroE360.Count;
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
   FRegistroE300Count := 0;
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
      E020 := TRegistroSEFE020(Items[AchaUltimoPai('E020', 'E025') ]);
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

function TBloco_E.RegistroE310New: TRegistroSEFE310;
var
  E300: TRegistroSEFE300;
begin
   with FRegistroE001.RegistroE300 do
      E300 := TRegistroSEFE300(Items[ AchaUltimoPai('E300', 'E310') ]);

   Result := E300.RegistroE310.New(E300);
end;

function TBloco_E.RegistroE330New: TRegistroSEFE330;
var
  E300: TRegistroSEFE300;
begin
   with FRegistroE001.RegistroE300 do
      E300 := TRegistroSEFE300(Items[ AchaUltimoPai('E300', 'E330') ]);

   Result := E300.RegistroE330.New(E300);
end;

function TBloco_E.RegistroE350New: TRegistroSEFE350;
var
  E300: TRegistroSEFE300;
begin
   with FRegistroE001.RegistroE300 do
      E300 := TRegistroSEFE300(Items[ AchaUltimoPai('E300', 'E350') ]);

   Result := E300.RegistroE350.New(E300);
end;

function TBloco_E.RegistroE360New: TRegistroSEFE360;
var
  E300: TRegistroSEFE300;
begin
   with FRegistroE001.RegistroE300 do
      E300 := TRegistroSEFE300(Items[ AchaUltimoPai('E300', 'E360') ]);

   Result := E300.RegistroE360.New(E300);
end;

function TBloco_E.RegistroE001New: TRegistroSEFE001;
begin
   Result := FRegistroE001;
end;

end.
