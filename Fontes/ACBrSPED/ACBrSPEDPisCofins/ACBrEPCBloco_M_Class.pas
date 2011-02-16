{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2010   Isaque Pinheiro                      }
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
|* 15/02/2011: Isaque Pinheiro e Fernando Amado
|*  - Cria��o e distribui��o da Primeira Versao
*******************************************************************************}

unit ACBrEPCBloco_M_Class;

interface

uses SysUtils, Classes, DateUtils, ACBrSped, ACBrEPCBloco_M, ACBrEPCBlocos,
     ACBrTXTClass;

type
  /// TBloco_M -

  { TBloco_M }

  TBloco_M = class(TACBrSPED)
  private
    FRegistroM001: TRegistroM001;      /// BLOCO M - RegistroM001
    FRegistroM990: TRegistroM990;      /// BLOCO M - RegistroM990

    FRegistroM100Count: integer;
    FRegistroM105Count: integer;
    FRegistroM110Count: integer;
    FRegistroM200Count: integer;
    FRegistroM210Count: integer;
    FRegistroM211Count: integer;
    FRegistroM220Count: integer;
    FRegistroM230Count: integer;
    FRegistroM300Count: integer;
    FRegistroM350Count: integer;
    FRegistroM400Count: integer;
    FRegistroM410Count: integer;
    FRegistroM500Count: integer;
    FRegistroM505Count: integer;
    FRegistroM510Count: integer;
    FRegistroM600Count: integer;
    FRegistroM610Count: integer;
    FRegistroM611Count: integer;
    FRegistroM620Count: integer;
    FRegistroM630Count: integer;
    FRegistroM700Count: integer;
    FRegistroM800Count: integer;
    FRegistroM810Count: integer;

    procedure WriteRegistroM100(RegM001: TRegistroM001);
    procedure WriteRegistroM105(RegM100: TRegistroM100);
    procedure WriteRegistroM110(RegM100: TRegistroM100);
    procedure WriteRegistroM200(RegM001: TRegistroM001);
    procedure WriteRegistroM210(RegM200: TRegistroM200);
    procedure WriteRegistroM211(RegM210: TRegistroM210);
    procedure WriteRegistroM220(RegM210: TRegistroM210);
    procedure WriteRegistroM230(RegM210: TRegistroM210);
    procedure WriteRegistroM300(RegM001: TRegistroM001);
    procedure WriteRegistroM350(RegM001: TRegistroM001);
    procedure WriteRegistroM400(RegM001: TRegistroM001);
    procedure WriteRegistroM410(RegM400: TRegistroM400);
    procedure WriteRegistroM500(RegM001: TRegistroM001);
    procedure WriteRegistroM505(RegM500: TRegistroM500);
    procedure WriteRegistroM510(RegM500: TRegistroM500);
    procedure WriteRegistroM600(RegM001: TRegistroM001);
    procedure WriteRegistroM610(RegM600: TRegistroM600);
    procedure WriteRegistroM611(RegM610: TRegistroM610);
    procedure WriteRegistroM620(RegM610: TRegistroM610);
    procedure WriteRegistroM630(RegM610: TRegistroM610);
    procedure WriteRegistroM700(RegM001: TRegistroM001);
    procedure WriteRegistroM800(RegM001: TRegistroM001);
    procedure WriteRegistroM810(RegM800: TRegistroM800);

    procedure CriaRegistros;
    procedure LiberaRegistros;
  public
    constructor Create ;          /// Create
    destructor Destroy; override; /// Destroy
    procedure LimpaRegistros;

    function RegistroM001New: TRegistroM001;
    function RegistroM100New: TRegistroM100;
    function RegistroM105New: TRegistroM105;
    function RegistroM110New: TRegistroM110;
    function RegistroM200New: TRegistroM200;
    function RegistroM210New: TRegistroM210;
    function RegistroM211New: TRegistroM211;
    function RegistroM220New: TRegistroM220;
    function RegistroM230New: TRegistroM230;
    function RegistroM300New: TRegistroM300;
    function RegistroM350New: TRegistroM350;
    function RegistroM400New: TRegistroM400;
    function RegistroM410New: TRegistroM410;
    function RegistroM500New: TRegistroM500;
    function RegistroM505New: TRegistroM505;
    function RegistroM510New: TRegistroM510;
    function RegistroM600New: TRegistroM600;
    function RegistroM610New: TRegistroM610;
    function RegistroM611New: TRegistroM611;
    function RegistroM620New: TRegistroM620;
    function RegistroM630New: TRegistroM630;
    function RegistroM700New: TRegistroM700;
    function RegistroM800New: TRegistroM800;
    function RegistroM810New: TRegistroM810;

    procedure WriteRegistroM001;
    procedure WriteRegistroM990;

    property RegistroM001: TRegistroM001 read FRegistroM001 write FRegistroM001;
    property RegistroM990: TRegistroM990 read FRegistroM990 write FRegistroM990;

    property RegistroM100Count: integer read FRegistroM100Count write FRegistroM100Count;
    property RegistroM105Count: integer read FRegistroM105Count write FRegistroM105Count;
    property RegistroM110Count: integer read FRegistroM110Count write FRegistroM110Count;
    property RegistroM200Count: integer read FRegistroM200Count write FRegistroM200Count;
    property RegistroM210Count: integer read FRegistroM210Count write FRegistroM210Count;
    property RegistroM211Count: integer read FRegistroM211Count write FRegistroM211Count;
    property RegistroM220Count: integer read FRegistroM220Count write FRegistroM220Count;
    property RegistroM230Count: integer read FRegistroM230Count write FRegistroM230Count;
    property RegistroM300Count: integer read FRegistroM300Count write FRegistroM300Count;
    property RegistroM350Count: integer read FRegistroM350Count write FRegistroM350Count;
    property RegistroM400Count: integer read FRegistroM400Count write FRegistroM400Count;
    property RegistroM410Count: integer read FRegistroM410Count write FRegistroM410Count;
    property RegistroM500Count: integer read FRegistroM500Count write FRegistroM500Count;
    property RegistroM505Count: integer read FRegistroM505Count write FRegistroM505Count;
    property RegistroM510Count: integer read FRegistroM510Count write FRegistroM510Count;
    property RegistroM600Count: integer read FRegistroM600Count write FRegistroM600Count;
    property RegistroM610Count: integer read FRegistroM610Count write FRegistroM610Count;
    property RegistroM611Count: integer read FRegistroM611Count write FRegistroM611Count;
    property RegistroM620Count: integer read FRegistroM620Count write FRegistroM620Count;
    property RegistroM630Count: integer read FRegistroM630Count write FRegistroM630Count;
    property RegistroM700Count: integer read FRegistroM700Count write FRegistroM700Count;
    property RegistroM800Count: integer read FRegistroM800Count write FRegistroM800Count;
    property RegistroM810Count: integer read FRegistroM810Count write FRegistroM810Count;
  end;

implementation

uses ACBrSpedUtils;

{ TBloco_M }

constructor TBloco_M.Create;
begin
  inherited ;
  CriaRegistros;
end;

destructor TBloco_M.Destroy;
begin
  LiberaRegistros;
  inherited;
end;

procedure TBloco_M.CriaRegistros;
begin
  FRegistroM001 := TRegistroM001.Create;
  FRegistroM990 := TRegistroM990.Create;

  FRegistroM100Count:= 0;
  FRegistroM105Count:= 0;
  FRegistroM110Count:= 0;
  FRegistroM200Count:= 0;
  FRegistroM210Count:= 0;
  FRegistroM211Count:= 0;
  FRegistroM220Count:= 0;
  FRegistroM230Count:= 0;
  FRegistroM300Count:= 0;
  FRegistroM350Count:= 0;
  FRegistroM400Count:= 0;
  FRegistroM410Count:= 0;
  FRegistroM500Count:= 0;
  FRegistroM505Count:= 0;
  FRegistroM510Count:= 0;
  FRegistroM600Count:= 0;
  FRegistroM610Count:= 0;
  FRegistroM611Count:= 0;
  FRegistroM620Count:= 0;
  FRegistroM630Count:= 0;
  FRegistroM700Count:= 0;
  FRegistroM800Count:= 0;
  FRegistroM810Count:= 0;

  FRegistroM990.QTD_LIN_M := 0;
end;

procedure TBloco_M.LiberaRegistros;
begin
  FRegistroM001.Free;
  FRegistroM990.Free;
end;

procedure TBloco_M.LimpaRegistros;
begin
  /// Limpa os Registros
  LiberaRegistros;
  Conteudo.Clear;

  /// Recriar os Registros Limpos
  CriaRegistros;
end;

function TBloco_M.RegistroM001New: TRegistroM001;
begin
   Result := FRegistroM001;
end;

function TBloco_M.RegistroM100New: TRegistroM100;
begin
   Result := FRegistroM001.RegistroM100.New;
end;

function TBloco_M.RegistroM105New: TRegistroM105;
var
M100Count: integer;
begin
   M100Count := FRegistroM001.RegistroM100.Count -1;
   //
   Result := FRegistroM001.RegistroM100.Items[M100Count].RegistroM105.New;
end;

function TBloco_M.RegistroM110New: TRegistroM110;
var
M100Count: integer;
begin
   M100Count := FRegistroM001.RegistroM100.Count -1;
   //
   Result := FRegistroM001.RegistroM100.Items[M100Count].RegistroM110.New;
end;

function TBloco_M.RegistroM200New: TRegistroM200;
begin
   Result := FRegistroM001.RegistroM200.New;
end;

function TBloco_M.RegistroM210New: TRegistroM210;
var
M200Count: integer;
begin
   M200Count := FRegistroM001.RegistroM200.Count -1;
   //
   Result := FRegistroM001.RegistroM200.Items[M200Count].RegistroM210.New;
end;

function TBloco_M.RegistroM211New: TRegistroM211;
var
M200Count: integer;
M210Count: integer;
begin
   M200Count := FRegistroM001.RegistroM200.Count -1;
   M210Count := FRegistroM001.RegistroM200.Items[M200Count].RegistroM210.Count -1;
   //
   Result := FRegistroM001.RegistroM200.Items[M200Count].RegistroM210.Items[M210Count].RegistroM211.New;
end;

function TBloco_M.RegistroM220New: TRegistroM220;
var
M200Count: integer;
M210Count: integer;
begin
   M200Count := FRegistroM001.RegistroM200.Count -1;
   M210Count := FRegistroM001.RegistroM200.Items[M200Count].RegistroM210.Count -1;
   //
   Result := FRegistroM001.RegistroM200.Items[M200Count].RegistroM210.Items[M210Count].RegistroM220.New;
end;

function TBloco_M.RegistroM230New: TRegistroM230;
var
M200Count: integer;
M210Count: integer;
begin
   M200Count := FRegistroM001.RegistroM200.Count -1;
   M210Count := FRegistroM001.RegistroM200.Items[M200Count].RegistroM210.Count -1;
   //
   Result := FRegistroM001.RegistroM200.Items[M200Count].RegistroM210.Items[M210Count].RegistroM230.New;
end;

function TBloco_M.RegistroM300New: TRegistroM300;
begin
   Result := FRegistroM001.RegistroM300.New;
end;

function TBloco_M.RegistroM350New: TRegistroM350;
begin
   Result := FRegistroM001.RegistroM350.New;
end;

function TBloco_M.RegistroM400New: TRegistroM400;
begin
   Result := FRegistroM001.RegistroM400.New;
end;

function TBloco_M.RegistroM410New: TRegistroM410;
var
M400Count: integer;
begin
   M400Count := FRegistroM001.RegistroM400.Count -1;
   //
   Result := FRegistroM001.RegistroM400.Items[M400Count].RegistroM410.New;
end;

function TBloco_M.RegistroM500New: TRegistroM500;
begin
   Result := FRegistroM001.RegistroM500.New;
end;

function TBloco_M.RegistroM505New: TRegistroM505;
var
M500Count: integer;
begin
   M500Count := FRegistroM001.RegistroM500.Count -1;
   //
   Result := FRegistroM001.RegistroM500.Items[M500Count].RegistroM505.New;
end;

function TBloco_M.RegistroM510New: TRegistroM510;
var
M500Count: integer;
begin
   M500Count := FRegistroM001.RegistroM500.Count -1;
   //
   Result := FRegistroM001.RegistroM500.Items[M500Count].RegistroM510.New;
end;

function TBloco_M.RegistroM600New: TRegistroM600;
begin
   Result := FRegistroM001.RegistroM600.New;
end;

function TBloco_M.RegistroM610New: TRegistroM610;
var
M600Count: integer;
begin
   M600Count := FRegistroM001.RegistroM600.Count -1;
   //
   Result := FRegistroM001.RegistroM600.Items[M600Count].RegistroM610.New;
end;

function TBloco_M.RegistroM611New: TRegistroM611;
var
M600Count: integer;
M610Count: integer;
begin
   M600Count := FRegistroM001.RegistroM600.Count -1;
   M610Count := FRegistroM001.RegistroM600.Items[M600Count].RegistroM610.Count -1;
   //
   Result := FRegistroM001.RegistroM600.Items[M600Count].RegistroM610.Items[M610Count].RegistroM611.New;
end;

function TBloco_M.RegistroM620New: TRegistroM620;
var
M600Count: integer;
M610Count: integer;
begin
   M600Count := FRegistroM001.RegistroM600.Count -1;
   M610Count := FRegistroM001.RegistroM600.Items[M600Count].RegistroM610.Count -1;
   //
   Result := FRegistroM001.RegistroM600.Items[M600Count].RegistroM610.Items[M610Count].RegistroM620.New;
end;

function TBloco_M.RegistroM630New: TRegistroM630;
var
M600Count: integer;
M610Count: integer;
begin
   M600Count := FRegistroM001.RegistroM600.Count -1;
   M610Count := FRegistroM001.RegistroM600.Items[M600Count].RegistroM610.Count -1;
   //
   Result := FRegistroM001.RegistroM600.Items[M600Count].RegistroM610.Items[M610Count].RegistroM630.New;
end;

function TBloco_M.RegistroM700New: TRegistroM700;
begin
   Result := FRegistroM001.RegistroM700.New;
end;

function TBloco_M.RegistroM800New: TRegistroM800;
begin
   Result := FRegistroM001.RegistroM800.New;
end;

function TBloco_M.RegistroM810New: TRegistroM810;
var
M800Count: integer;
begin
   M800Count := FRegistroM001.RegistroM800.Count -1;
   //
   Result := FRegistroM001.RegistroM800.Items[M800Count].RegistroM810.New;
end;

procedure TBloco_M.WriteRegistroM001 ;
begin
  if Assigned(FRegistroM001) then
  begin
     with FRegistroM001 do
     begin
        Add( LFill( 'M001' ) +
             LFill( Integer(IND_MOV), 0 ) ) ;

        if IND_MOV = imComDados then
        begin
          WriteRegistroM100(FRegistroM001) ;
          WriteRegistroM200(FRegistroM001) ;
          WriteRegistroM300(FRegistroM001) ;
          WriteRegistroM350(FRegistroM001) ;
          WriteRegistroM400(FRegistroM001) ;
          WriteRegistroM500(FRegistroM001) ;
          WriteRegistroM600(FRegistroM001) ;
          WriteRegistroM700(FRegistroM001) ;
          WriteRegistroM800(FRegistroM001) ;
        end;
     end;

     RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
  end;
end;

procedure TBloco_M.WriteRegistroM100(RegM001: TRegistroM001) ;
var
intFor: integer;
begin
  if Assigned(RegM001.RegistroM100) then
  begin
     for intFor := 0 to RegM001.RegistroM100.Count - 1 do
     begin
        with RegM001.RegistroM100.Items[intFor] do
        begin

          Add( LFill('M100') +
               LFill( COD_CRED ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( IND_CRED_ORI ) +    //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_BC_PIS,0,2 ) +
               LFill( ALIQ_PIS,0,2 ) +
               LFill( QUANT_BC_PIS,0,2 ) +
               LFill( ALIQ_PIS_QUANT,0,2 ) +
               LFill( VL_CRED ,0,2 ) +
               LFill( VL_AJUS_ACRES ,0,2 ) +
               LFill( VL_AJUS_REDUC ,0,2 ) +
               LFill( VL_CRED_DIF ,0,2 ) +
               LFill( VL_CRED_DISP ,0,2 ) +
               LFill( IND_DESC_CRED ) +  //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_CRED_DESC ,0,2 ) +
               LFill( SLD_CRED ,0,2 ) ) ;
        end;

        // Registros FILHOS
        WriteRegistroF105( RegM001.RegistroM100.Items[intFor] );
        WriteRegistroF110( RegM001.RegistroM100.Items[intFor] );
        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM100Count := FRegistroM100Count + RegM001.RegistroM100.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM105(RegM100: TRegistroM100) ;
var
intFor: integer;
begin
  if Assigned(RegM100.RegistroM105) then
  begin
     for intFor := 0 to RegM100.RegistroM105.Count - 1 do
     begin
        with RegM100.RegistroM105.Items[intFor] do
        begin

          Add( LFill('M105') +
               LFill( NAT_BC_CRED ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( CST_PIS ) +
               LFill( VL_BC_PIS_TOT ,0,2 ) +
               LFill( VL_BC_PIS_CUM ,0,2 ) +
               LFill( VL_BC_PIS_NC ,0,2 ) +
               LFill( VL_BC_PIS ,0,2 ) +
               LFill( QUANT_BC_PIS_TOT ,0,2 ) +
               LFill( QUANT_BC_PIS ,0,2 ) +
               LFill( DESC_CRED ) ) ;
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM105Count := FRegistroM105Count + RegM100.RegistroM105.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM110(RegM100: TRegistroM100) ;
var
intFor: integer;
begin
  if Assigned(RegM100.RegistroM110) then
  begin
     for intFor := 0 to RegM100.RegistroM110.Count - 1 do
     begin
        with RegM100.RegistroM110.Items[intFor] do
        begin

          Add( LFill('M110') +
               LFill( IND_AJ ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_AJ ,0,2 ) +
               LFill( COD_AJ ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( NUM_DOC ) +
               LFill( DESCR_AJ ) +
               LFill( DT_REF ) ) ;
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM110Count := FRegistroM110Count + RegM100.RegistroM110.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM200(RegM001: TRegistroM001) ;
var
intFor: integer;
begin
  if Assigned(RegM001.RegistroM200) then
  begin
     for intFor := 0 to RegM001.RegistroM200.Count - 1 do
     begin
        with RegM001.RegistroM200.Items[intFor] do
        begin

          Add( LFill('M200') +
               LFill( VL_TOT_CONT_NC_PER,0,2 ) +
               LFill( VL_TOT_CRED_DESC,0,2 ) +
               LFill( VL_TOT_CRED_DESC_ANT,0,2 ) +
               LFill( VL_TOT_CONT_NC_DEV,0,2 ) +
               LFill( VL_RET_NC,0,2 ) +
               LFill( VL_OUT_DED_NC,0,2 ) +
               LFill( VL_CONT_NC_REC,0,2 ) +
               LFill( VL_TOT_CONT_CUM_PER,0,2 ) +
               LFill( VL_RET_CUM,0,2 ) +
               LFill( VL_OUT_DED_CUM,0,2 ) +
               LFill( VL_CONT_CUM_REC,0,2 ) +
               LFill( VL_TOT_CONT_REC,0,2 ) ) ;
        end;

        // Registros FILHOS
        WriteRegistroF210( RegM001.RegistroM200.Items[intFor] );
        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM200Count := FRegistroM200Count + RegM001.RegistroM200.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM210(RegM200: TRegistroM200) ;
var
intFor: integer;
begin
  if Assigned(RegM200.RegistroM210) then
  begin
     for intFor := 0 to RegM200.RegistroM210.Count - 1 do
     begin
        with RegM200.RegistroM210.Items[intFor] do
        begin

          Add( LFill('M210') +
               LFill( COD_CONT ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_REC_BRT ,0,2 ) +
               LFill( VL_BC_CONT ,0,2 ) +
               LFill( ALIQ_PIS ,0,2 ) +
               LFill( QUANT_BC_PIS ,0,2 ) +
               LFill( ALIQ_PIS_QUANT ,0,2 ) +
               LFill( VL_CONT_APUR ,0,2 ) +
               LFill( VL_AJUS_ACRES ,0,2 ) +
               LFill( VL_AJUS_REDUC ,0,2 ) +
               LFill( VL_CONT_DIFER ,0,2 ) +
               LFill( VL_CONT_DIFER_ANT ,0,2 ) +
               LFill( VL_CONT_PER ,0,2 ) ) ;
        end;

        // Registros FILHOS
        WriteRegistroF211( RegM200.RegistroM210.Items[intFor] );
        WriteRegistroF220( RegM200.RegistroM210.Items[intFor] );
        WriteRegistroF230( RegM200.RegistroM210.Items[intFor] );
        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM210Count := FRegistroM210Count + RegM200.RegistroM210.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM211(RegM210: TRegistroM210) ;
var
intFor: integer;
begin
  if Assigned(RegM210.RegistroM211) then
  begin
     for intFor := 0 to RegM210.RegistroM211.Count - 1 do
     begin
        with RegM210.RegistroM211.Items[intFor] do
        begin

          Add( LFill('M211') +
               LFill( IND_TIP_COOP ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_BC_CONT_ANT_EXC_COOP,0,2 ) +
               LFill( VL_EXC_COOP_GER,0,2 ) +
               LFill( VL_EXC_ESP_COOP,0,2 ) +
               LFill( VL_BC_CONT,0,2 ) ) ;
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM211Count := FRegistroM211Count + RegM210.RegistroM211.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM220(RegM210: TRegistroM210) ;
var
intFor: integer;
begin
  if Assigned(RegM210.RegistroM220) then
  begin
     for intFor := 0 to RegM210.RegistroM220.Count - 1 do
     begin
        with RegM210.RegistroM220.Items[intFor] do
        begin

          Add( LFill('M220') +
               LFill( IND_AJ ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_AJ ,0,2 ) +
               LFill( COD_AJ ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( NUM_DOC ) +
               LFill( DESCR_AJ ) +
               LFill( DT_REF ) ) ;
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM220Count := FRegistroM220Count + RegM210.RegistroM220.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM230(RegM210: TRegistroM210) ;
var
intFor: integer;
begin
  if Assigned(RegM210.RegistroM230) then
  begin
     for intFor := 0 to RegM210.RegistroM230.Count - 1 do
     begin
        with RegM210.RegistroM230.Items[intFor] do
        begin

          Add( LFill('M230') +
               LFill( CNPJ ) +
               LFill( VL_VEND,0,2 ) +
               LFill( VL_NAO_RECEB,0,2 ) +
               LFill( VL_CONT_DIF,0,2 ) +
               LFill( VL_CRED_DIF,0,2 ) +
               LFill( COD_CRED ) ) ;       //Verificar cria��o da tabela no ACBrEPCBlocos
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM230Count := FRegistroM230Count + RegM210.RegistroM230.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM300(RegM001: TRegistroM001) ;
var
intFor: integer;
begin
  if Assigned(RegM001.RegistroM300) then
  begin
     for intFor := 0 to RegM001.RegistroM300.Count - 1 do
     begin
        with RegM001.RegistroM300.Items[intFor] do
        begin

          Add( LFill('M300') +
               LFill( COD_CONT ) +              //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_CONT_APUR_DIFER,0,2 ) +
               LFill( NAT_CRED_DESC ) +         //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_CRED_DESC_DIFER,0,2 ) +
               LFill( VL_CONT_DIFER_ANT,0,2 ) +
               LFill( PER_APUR ) +
               LFill( DT_RECEB ) ) ;
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM300Count := FRegistroM300Count + RegM001.RegistroM300.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM350(RegM001: TRegistroM001) ;
var
intFor: integer;
begin
  if Assigned(RegM001.RegistroM350) then
  begin
     for intFor := 0 to RegM001.RegistroM350.Count - 1 do
     begin
        with RegM001.RegistroM350.Items[intFor] do
        begin

          Add( LFill('M350') +
               LFill( VL_TOT_FOL,0,2 ) +
               LFill( VL_EXC_BC,0,2 ) +
               LFill( VL_TOT_BC,0,2 ) +
               LFill( ALIQ_PIS_FOL,0,2 ) +
               LFill( VL_TOT_CONT_FOL,0,2 ) ) ;
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM350Count := FRegistroM350Count + RegM001.RegistroM350.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM400(RegM001: TRegistroM001) ;
var
intFor: integer;
begin
  if Assigned(RegM001.RegistroM400) then
  begin
     for intFor := 0 to RegM001.RegistroM400.Count - 1 do
     begin
        with RegM001.RegistroM400.Items[intFor] do
        begin

          Add( LFill('M400') +
               LFill( CST_PIS ) +
               LFill( VL_TOT_REC,0,2 ) +
               LFill( COD_CTA ) +
               LFill( DESC_COMPL ) ) ;
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM400Count := FRegistroM400Count + RegM001.RegistroM400.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM410(RegM400: TRegistroM400) ;
var
intFor: integer;
begin
  if Assigned(RegM400.RegistroM410) then
  begin
     for intFor := 0 to RegM400.RegistroM410.Count - 1 do
     begin
        with RegM400.RegistroM410.Items[intFor] do
        begin

          Add( LFill('M410') +
               LFill( NAT_REC ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_REC ,0,2 ) +
               LFill( COD_CTA ) +
               LFill( DESC_COMPL ) ) ;
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM410Count := FRegistroM410Count + RegM400.RegistroM410.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM500(RegM001: TRegistroM001) ;
var
intFor: integer;
begin
  if Assigned(RegM001.RegistroM500) then
  begin
     for intFor := 0 to RegM001.RegistroM500.Count - 1 do
     begin
        with RegM001.RegistroM500.Items[intFor] do
        begin

          Add( LFill('M500') +
               LFill( COD_CRED ) +                  //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( IND_CRED_ORI ) +              //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_BC_COFINS,0,2 ) +
               LFill( ALIQ_COFINS,0,2 ) +
               LFill( QUANT_BC_COFINS,0,2 ) +
               LFill( ALIQ_COFINS_QUANT,0,2 ) +
               LFill( VL_CRED,0,2 ) +
               LFill( VL_AJUS_ACRES,0,2 ) +
               LFill( VL_AJUS_REDUC,0,2 ) +
               LFill( VL_CRED_DIFER,0,2 ) +
               LFill( VL_CRED_DISP,0,2 ) +
               LFill( IND_DESC_CRED ) +             //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_CRED_DESC,0,2 ) +
               LFill( SLD_CRED,0,2 ) ) ;
        end;

        // Registros FILHOS
        WriteRegistroF505( RegM001.RegistroM500.Items[intFor] );
        WriteRegistroF510( RegM001.RegistroM500.Items[intFor] );
        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM500Count := FRegistroM500Count + RegM001.RegistroM500.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM505(RegM500: TRegistroM500) ;
var
intFor: integer;
begin
  if Assigned(RegM500.RegistroM505) then
  begin
     for intFor := 0 to RegM500.RegistroM505.Count - 1 do
     begin
        with RegM500.RegistroM505.Items[intFor] do
        begin

          Add( LFill('M505') +
               LFill( NAT_BC_CRED ) +                  //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( CST_COFINS ) +
               LFill( VL_BC_COFINS_TOT,0,2 ) +
               LFill( VL_BC_COFINS_CUM,0,2 ) +
               LFill( VL_BC_COFINS_NC,0,2 ) +
               LFill( VL_BC_COFINS,0,2 ) +
               LFill( QUANT_BC_COFINS_TOT,0,2 ) +
               LFill( QUANT_BC_COFINS,0,2 ) +
               LFill( DESC_CRED ) ) ;
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM505Count := FRegistroM505Count + RegM500.RegistroM505.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM510(RegM500: TRegistroM500) ;
var
intFor: integer;
begin
  if Assigned(RegM500.RegistroM510) then
  begin
     for intFor := 0 to RegM500.RegistroM510.Count - 1 do
     begin
        with RegM500.RegistroM510.Items[intFor] do
        begin

          Add( LFill('M510') +
               LFill( IND_AJ ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_AJ ,0,2 ) +
               LFill( COD_AJ ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( NUM_DOC ) +
               LFill( DESCR_AJ ) +
               LFill( DT_REF ) ) ;
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM10Count := FRegistroM510Count + RegM500.RegistroM510.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM600(RegM001: TRegistroM001) ;
var
intFor: integer;
begin
  if Assigned(RegM001.RegistroM600) then
  begin
     for intFor := 0 to RegM001.RegistroM600.Count - 1 do
     begin
        with RegM001.RegistroM600.Items[intFor] do
        begin

          Add( LFill('M600') +
               LFill( VL_TOT_CONT_NC_PER,0,2 ) +
               LFill( VL_TOT_CRED_DESC,0,2 ) +
               LFill( VL_TOT_CRED_DESC_ANT,0,2 ) +
               LFill( VL_TOT_CONT_NC_DEV,0,2 ) +
               LFill( VL_RET_NC,0,2 ) +
               LFill( VL_OUT_DED_NC,0,2 ) +
               LFill( VL_CONT_NC_REC,0,2 ) +
               LFill( VL_TOT_CONT_CUM_PER,0,2 ) +
               LFill( VL_RET_CUM,0,2 ) +
               LFill( VL_OUT_DED_CUM,0,2 ) +
               LFill( VL_CONT_CUM_REC,0,2 ) +
               LFill( VL_TOT_CONT_REC,0,2 ) ) ;
        end;

        // Registros FILHOS
        WriteRegistroF610( RegM001.RegistroM600.Items[intFor] );
        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM600Count := FRegistroM600Count + RegM001.RegistroM600.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM610(RegM600: TRegistroM600) ;
var
intFor: integer;
begin
  if Assigned(RegM600.RegistroM610) then
  begin
     for intFor := 0 to RegM600.RegistroM610.Count - 1 do
     begin
        with RegM600.RegistroM610.Items[intFor] do
        begin

          Add( LFill('M610') +
               LFill( COD_CONT ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_REC_BRT ,0,2 ) +
               LFill( VL_BC_CONT ,0,2 ) +
               LFill( ALIQ_COFINS ,0,2 ) +
               LFill( QUANT_BC_COFINS ,0,2 ) +
               LFill( ALIQ_COFINS_QUANT ,0,2 ) +
               LFill( VL_CONT_APUR ,0,2 ) +
               LFill( VL_AJUS_ACRES ,0,2 ) +
               LFill( VL_AJUS_REDUC ,0,2 ) +
               LFill( VL_CONT_DIFER ,0,2 ) +
               LFill( VL_CONT_DIFER_ANT ,0,2 ) +
               LFill( VL_CONT_PER ,0,2 ) ) ;
        end;

        // Registros FILHOS
        WriteRegistroF611( RegM600.RegistroM610.Items[intFor] );
        WriteRegistroF620( RegM600.RegistroM610.Items[intFor] );
        WriteRegistroF630( RegM600.RegistroM610.Items[intFor] );
        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM610Count := FRegistroM610Count + RegM600.RegistroM610.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM611(RegM610: TRegistroM610) ;
var
intFor: integer;
begin
  if Assigned(RegM610.RegistroM611) then
  begin
     for intFor := 0 to RegM610.RegistroM611.Count - 1 do
     begin
        with RegM610.RegistroM611.Items[intFor] do
        begin

          Add( LFill('M611') +
               LFill( IND_TIP_COOP ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_BC_CONT_ANT_EXC_COOP,0,2 ) +
               LFill( VL_EXC_COOP_GER,0,2 ) +
               LFill( VL_EXC_ESP_COOP,0,2 ) +
               LFill( VL_BC_CONT,0,2 ) ) ;
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM611Count := FRegistroM611Count + RegM610.RegistroM611.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM620(RegM610: TRegistroM610) ;
var
intFor: integer;
begin
  if Assigned(RegM610.RegistroM620) then
  begin
     for intFor := 0 to RegM610.RegistroM620.Count - 1 do
     begin
        with RegM610.RegistroM620.Items[intFor] do
        begin

          Add( LFill('M620') +
               LFill( IND_AJ ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_AJ ,0,2 ) +
               LFill( COD_AJ ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( NUM_DOC ) +
               LFill( DESCR_AJ ) +
               LFill( DT_REF ) ) ;
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM620Count := FRegistroM620Count + RegM610.RegistroM620.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM630(RegM610: TRegistroM610) ;
var
intFor: integer;
begin
  if Assigned(RegM610.RegistroM630) then
  begin
     for intFor := 0 to RegM610.RegistroM630.Count - 1 do
     begin
        with RegM610.RegistroM630.Items[intFor] do
        begin

          Add( LFill('M630') +
               LFill( CNPJ ) +
               LFill( VL_VEND,0,2 ) +
               LFill( VL_NAO_RECEB,0,2 ) +
               LFill( VL_CONT_DIF,0,2 ) +
               LFill( VL_CRED_DIF,0,2 ) +
               LFill( COD_CRED ) ) ;       //Verificar cria��o da tabela no ACBrEPCBlocos
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM630Count := FRegistroM630Count + RegM610.RegistroM630.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM700(RegM001: TRegistroM001) ;
var
intFor: integer;
begin
  if Assigned(RegM001.RegistroM700) then
  begin
     for intFor := 0 to RegM001.RegistroM700.Count - 1 do
     begin
        with RegM001.RegistroM700.Items[intFor] do
        begin

          Add( LFill('M700') +
               LFill( COD_CONT ) +            //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_CONT_APUR_DIFER,0,2 ) +
               LFill( NAT_CRED_DESC ) +       //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_CRED_DESC_DIFER,0,2 ) +
               LFill( VL_CONT_DIFER_ANT,0,2 ) +
               LFill( PER_APUR ) +
               LFill( DT_RECEB ) ) ;
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM700Count := FRegistroM700Count + RegM001.RegistroM700.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM800(RegM001: TRegistroM001) ;
var
intFor: integer;
begin
  if Assigned(RegM001.RegistroM800) then
  begin
     for intFor := 0 to RegM001.RegistroM800.Count - 1 do
     begin
        with RegM001.RegistroM800.Items[intFor] do
        begin

          Add( LFill('M800') +
               LFill( CST_COFINS ) +
               LFill( VL_TOT_REC,0,2 ) +
               LFill( COD_CTA ) +
               LFill( DESC_COMPL ) ) ;
        end;

        // Registros FILHOS
        WriteRegistroF810( RegM001.RegistroM800.Items[intFor] );
        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM800Count := FRegistroM800Count + RegM001.RegistroM800.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM810(RegM800: TRegistroM800) ;
var
intFor: integer;
begin
  if Assigned(RegM800.RegistroM810) then
  begin
     for intFor := 0 to RegM800.RegistroM810.Count - 1 do
     begin
        with RegM800.RegistroM810.Items[intFor] do
        begin

          Add( LFill('M810') +
               LFill( NAT_REC ) +        //Verificar cria��o da tabela no ACBrEPCBlocos
               LFill( VL_REC ,0,2 ) +
               LFill( COD_CTA ) +
               LFill( DESC_COMPL ) ) ;
        end;

        ///
        RegistroM990.QTD_LIN_M := RegistroM990.QTD_LIN_M + 1;
     end;
     /// Variav�l para armazenar a quantidade de registro do tipo.
     FRegistroM810Count := FRegistroM810Count + RegM800.RegistroM810.Count;
  end;
end;

procedure TBloco_M.WriteRegistroM990 ;
begin
  if Assigned(RegistroM990) then
  begin
     with RegistroM990 do
     begin
       QTD_LIN_M := QTD_LIN_M + 1;
       ///
       Add( LFill('M990') +
            LFill(QTD_LIN_M,0) );
     end;
  end;
end;

end.
