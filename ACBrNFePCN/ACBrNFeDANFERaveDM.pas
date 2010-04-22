{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Nota Fiscal}
{ eletr�nica - NFe - http://www.nfe.fazenda.gov.br                          }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
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
|* 16/12/2008: Wemerson Souto
|*  - Doa��o do componente para o Projeto ACBr
|* 09/03/2009: Dulcemar P.Zilli
|*  - Correcao impress�o informa��es IPI
|* 11/03/2008: Dulcemar P.Zilli
|*  - Inclus�o Observa��es Fisco
|* 11/03/2008: Dulcemar P.Zilli
|*  - Inclus�o totais ISSQN
|* 23/06/2009: Jo�o H. Souza
|*  - Altera��es diversas
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFeDANFERaveDM;

interface

uses Dialogs,
  Forms, SysUtils, Classes, StdCtrls,
  RpRave, RpBase, RpSystem, RpDefine, RpCon, RpRender, RpRenderPDF,
  pcnNFe, pcnConversao, ACBrNFeDANFEClass;

type
  TdmACBrNFeRave = class( TDataModule )
    RvSystem1: TRvSystem;
    RvProject: TRvProject;
    RvRenderPDF1: TRvRenderPDF;
    CustomDestinatarioCXN: TRvCustomConnection;
    CustomEmitenteCXN: TRvCustomConnection;
    CustomDadosProdutosCXN: TRvCustomConnection;
    CustomTransportadorCXN: TRvCustomConnection;
    CustomCalculoImpostoCXN: TRvCustomConnection;
    CustomParametrosCXN: TRvCustomConnection;
    CustomDuplicatasCXN: TRvCustomConnection;
    CustomIdentificacaoCXN: TRvCustomConnection;
    CustomVeiculoCXN: TRvCustomConnection;
    CustomVolumesCXN: TRvCustomConnection;
    CustomInformacoesAdicionaisCXN: TRvCustomConnection;
    CustomFaturaCXN: TRvCustomConnection;
    CustomLocalRetiradaCXN: TRvCustomConnection;
    CustomLocalEntregaCXN: TRvCustomConnection;

    constructor create( AOwner : TComponent ); override ;
    procedure RvSystem1BeforePrint(Sender: TObject);
    procedure CustomDestinatarioCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomDestinatarioCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomDestinatarioCXNOpen(Connection: TRvCustomConnection);
    procedure CustomEmitenteCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomEmitenteCXNOpen(Connection: TRvCustomConnection);
    procedure CustomEmitenteCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomCalculoImpostoCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomCalculoImpostoCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomCalculoImpostoCXNOpen(Connection: TRvCustomConnection);
    procedure CustomDadosProdutosCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomDadosProdutosCXNOpen(Connection: TRvCustomConnection);
    procedure CustomDadosProdutosCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomTransportadorCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomTransportadorCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomTransportadorCXNOpen(Connection: TRvCustomConnection);
    procedure CustomParametrosCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomParametrosCXNOpen(Connection: TRvCustomConnection);
    procedure CustomParametrosCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomIdentificacaoCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomIdentificacaoCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomIdentificacaoCXNOpen(Connection: TRvCustomConnection);
    procedure CustomDuplicatasCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomDuplicatasCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomDuplicatasCXNOpen(Connection: TRvCustomConnection);
    procedure CustomVeiculoCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomVeiculoCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomVeiculoCXNOpen(Connection: TRvCustomConnection);
    procedure CustomVolumesCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomVolumesCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomVolumesCXNOpen(Connection: TRvCustomConnection);
    procedure CustomInformacoesAdicionaisCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomInformacoesAdicionaisCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomInformacoesAdicionaisCXNOpen(Connection: TRvCustomConnection);
    procedure CustomISSQNCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomISSQNCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomISSQNCXNOpen(Connection: TRvCustomConnection);
    procedure CustomFaturaCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomFaturaCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomFaturaCXNOpen(Connection: TRvCustomConnection);
    procedure CustomLocalRetiradaCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomLocalRetiradaCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomLocalRetiradaCXNOpen(Connection: TRvCustomConnection);
    procedure CustomLocalEntregaCXNGetCols(Connection: TRvCustomConnection);
    procedure CustomLocalEntregaCXNGetRow(Connection: TRvCustomConnection);
    procedure CustomLocalEntregaCXNOpen(Connection: TRvCustomConnection);
  private
    FDANFEClassOwner : TACBrNFeDANFEClass ;
    FNFe : TNFe;
  public
    property NFe : TNFe read FNFe write FNFe;
    property DANFEClassOwner : TACBrNFeDANFEClass read FDANFEClassOwner ;
  end;

implementation

uses ACBrNFe, ACBrNFeUtil, StrUtils , Math;

{$R *.dfm}

type
  ArrOfStr = array of string;

function explode(sPart, sInput: string): ArrOfStr;
begin
  while Pos(sPart, sInput) <> 0 do
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1] := Copy(sInput, 0, Pos(sPart, sInput) - 1);
      Delete(sInput, 1, Pos(sPart, sInput));
    end;

  SetLength(Result, Length(Result) + 1);
  Result[Length(Result) - 1] := sInput;
end;

function implode(sPart:string; tokens:array of string):string;
var i:integer;
begin
   result := '';
   for i := 0 to Length(tokens) - 1 do
     result:=result+(tokens[i])+sPart;
end;

function CollateBr(Str: String): String;
var
   resultado,temp: string;
   vChar: char;
   tamanho, i: integer;
begin
   result:='';
   Tamanho:=length(str);
   i:=1;
   while i <= Tamanho do
   begin
      temp:=copy(str,i,1);
      vChar:=temp[1];
      case vChar of
         '�', '�', '�', '�', '�', '�',
         '�', '�', '�', '�', '�', '�': Resultado := 'A';
         '�', '�', '�', '�',
         '�', '�', '�', '�': Resultado := 'E';
         '�', '�', '�', '�',
         '�', '�', '�', '�': Resultado := 'I';
         '�', '�', '�', '�', '�',
         '�', '�', '�', '�', '�': Resultado := 'O';
         '�', '�', '�', '�',
         '�', '�', '�', '�': Resultado := 'U';
         '�', '�': Resultado := 'C';
         '�', '�': Resultado := 'N';
         '�', '�', '�', 'Y': Resultado := 'Y';
      else
         if vChar > #127 then
           Resultado := #32
         else if vChar in ['a'..'z','A'..'Z','0'..'9','-',' '] then
           resultado:=uppercase(vCHAR);
      end;
      result:=result+resultado;
      i:=i+1;
  end;
end;

constructor TdmACBrNFeRave.create(AOwner: TComponent);
begin
  inherited;

  FDANFEClassOwner := TACBrNFeDANFEClass( AOwner ) ;
end;

procedure TdmACBrNFeRave.RvSystem1BeforePrint(Sender: TObject);
begin
   //processo para n�o exibir o quadro ISSQN no DANFE_Rave513
   if ((FNFe.Total.ISSQNtot.VServ=0) and
       (FNFe.Total.ISSQNtot.VBC=0) and
       (FNFe.Total.ISSQNtot.VISS=0)) then
      rvPROJECT.SetParam('wISSQN','N')
   else
      rvPROJECT.SetParam('wISSQN','S');
end;

procedure TdmACBrNFeRave.CustomDestinatarioCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('CNPJCPF',dtString,18,'','');
  Connection.WriteField('XNome',dtString,60,'','');
  Connection.WriteField('XLgr',dtString,60,'','');
  Connection.WriteField('Nro',dtString,60,'','');
  Connection.WriteField('XCpl',dtString,60,'','');
  Connection.WriteField('XBairro',dtString,60,'','');
  Connection.WriteField('CMun',dtString,7,'','');
  Connection.WriteField('XMun',dtString,60,'','');
  Connection.WriteField('UF',dtString,2,'','');
  Connection.WriteField('CEP',dtString,9,'','');
  Connection.WriteField('CPais',dtString,4,'','');
  Connection.WriteField('XPais',dtString,60,'','');
  Connection.WriteField('Fone',dtString,15,'','');
  Connection.WriteField('IE',dtString,14,'','');
end;

procedure TdmACBrNFeRave.CustomDestinatarioCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.Dest do
  begin
    if NotaUtil.NaoEstaVazio(CNPJCPF) then
     begin
       if Length(CNPJCPF) > 11 then
          Connection.WriteStrData('', NotaUtil.FormatarCNPJ(CNPJCPF))
       else
          Connection.WriteStrData('', NotaUtil.FormatarCPF(CNPJCPF));
     end
    else
       Connection.WriteStrData('', '');

    Connection.WriteStrData('', XNome);
    with EnderDest do
    begin
      Connection.WriteStrData('', XLgr);
      Connection.WriteStrData('', Nro);
      Connection.WriteStrData('', XCpl);
      Connection.WriteStrData('', XBairro);
      Connection.WriteStrData('', inttostr(CMun));
      Connection.WriteStrData('', CollateBr(XMun));
      Connection.WriteStrData('', UF);
      Connection.WriteStrData('', NotaUtil.FormatarCEP(NotaUtil.Poem_Zeros(CEP,8)));
      Connection.WriteStrData('', inttostr(CPais));
      Connection.WriteStrData('', XPais);
      Connection.WriteStrData('', NotaUtil.FormatarFone(Fone));
    end;
    Connection.WriteStrData('', IE);
  end;

end;

procedure TdmACBrNFeRave.CustomDestinatarioCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFeRave.CustomEmitenteCXNGetCols(
  Connection: TRvCustomConnection);
begin
  //emit
  Connection.WriteField('CNPJ', dtString, 18, '', '');
  Connection.WriteField('XNome', dtString, 60, '', '');
  Connection.WriteField('XFant', dtString, 60, '', '');
  Connection.WriteField('XLgr', dtString, 60, '', '');
  Connection.WriteField('Nro', dtString, 60, '', '');
  Connection.WriteField('XCpl', dtString, 60, '', '');
  Connection.WriteField('XBairro', dtString, 60, '', '');
  Connection.WriteField('CMun', dtString, 7, '', '');
  Connection.WriteField('XMun', dtString, 60, '', '');
  Connection.WriteField('UF', dtString, 2, '', '');
  Connection.WriteField('CEP', dtString, 9, '', '');
  Connection.WriteField('CPais', dtString, 4, '', '');
  Connection.WriteField('XPais', dtString, 60, '', '');
  Connection.WriteField('Fone', dtString, 15, '', '');
  Connection.WriteField('IE', dtString, 14, '', '');

  Connection.WriteField('IM', dtString, 15, '', '');
  Connection.WriteField('IEST', dtString, 15, '', '');

end;

procedure TdmACBrNFeRave.CustomEmitenteCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFeRave.CustomFaturaCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('Pagamento', dtString, 20, '', '');
  Connection.WriteField('nFat', dtString, 60, '', '');
  Connection.WriteField('vOrig', dtFloat, 10, '', '');
  Connection.WriteField('vDesc', dtFloat, 15, '', '');
  Connection.WriteField('vLiq', dtFloat, 15, '', '');
end;

procedure TdmACBrNFeRave.CustomFaturaCXNGetRow(Connection: TRvCustomConnection);
begin
   //Ocultar se n�o for informado nenhuma
   if (NotaUtil.EstaVazio(FNFe.Cobr.Fat.nFat)) then
   begin
      if (FNFe.Cobr.Dup.Count=0) then
      begin
         if FNFe.Ide.indPag=ipVista then
            Connection.WriteStrData('', 'PAGAMENTO � VISTA')
         else if FNFe.Ide.indPag=ipPrazo then
            Connection.WriteStrData('', 'PAGAMENTO A PRAZO')
         else
            Connection.WriteStrData('', '')
      end
      else
         Connection.WriteStrData('', '')
   end
   else
      Connection.WriteStrData('', '');

   with FNFe.Cobr.Fat do
   begin
      Connection.WriteStrData('', nFat);
      Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(vOrig),0));
      Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(vDesc),0));
      Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(vLiq),0));
   end;
end;

procedure TdmACBrNFeRave.CustomFaturaCXNOpen(Connection: TRvCustomConnection);
begin
   //Ocultar se n�o for informado nenhuma
   if (NotaUtil.EstaVazio(FNFe.Cobr.Fat.nFat)) then
   begin
      if (FNFe.Cobr.Dup.Count=0) then
      begin
         //se for outras n�o exibe nada
         if (FNFe.ide.indPag=ipOutras) then
            Connection.DataRows := 0
         else //vista e prazo exibe
            Connection.DataRows := 1
      end
      else
         Connection.DataRows := 0;
   end
   else
      Connection.DataRows := 1;
end;

procedure TdmACBrNFeRave.CustomEmitenteCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.Emit do
  begin
    Connection.WriteStrData('', NotaUtil.FormatarCNPJ(CNPJCPF));
    Connection.WriteStrData('', XNome);
    Connection.WriteStrData('', XFant);
    with EnderEmit do
    begin
      Connection.WriteStrData('', XLgr);
      Connection.WriteStrData('', Nro);
      Connection.WriteStrData('', XCpl);
      Connection.WriteStrData('', XBairro);
      Connection.WriteStrData('', inttostr(CMun));
      Connection.WriteStrData('', CollateBr(XMun));
      Connection.WriteStrData('', UF);
      Connection.WriteStrData('', NotaUtil.FormatarCEP(NotaUtil.Poem_Zeros(CEP,8)));
      Connection.WriteStrData('', inttostr(CPais));
      Connection.WriteStrData('', XPais);
      Connection.WriteStrData('', NotaUtil.FormatarFone(Fone));
    end;
    Connection.WriteStrData('', IE);
    Connection.WriteStrData('', IM);
    Connection.WriteStrData('', IEST);
  end;
end;

procedure TdmACBrNFeRave.CustomCalculoImpostoCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('VBC', dtFloat, 15, '', '');
  Connection.WriteField('VICMS', dtFloat, 15, '', '');
  Connection.WriteField('VBCST', dtFloat, 15, '', '');
  Connection.WriteField('VST', dtFloat, 15, '', '');
  Connection.WriteField('VProd', dtFloat, 15, '', '');
  Connection.WriteField('VFrete', dtFloat, 15, '', '');
  Connection.WriteField('VSeg', dtFloat, 15, '', '');
  Connection.WriteField('VDesc', dtFloat, 15, '', '');
  Connection.WriteField('VII', dtFloat, 15, '', '');
  Connection.WriteField('VIPI', dtFloat, 15, '', '');
  Connection.WriteField('VPIS', dtFloat, 15, '', '');
  Connection.WriteField('VCOFINS', dtFloat, 15, '', '');
  Connection.WriteField('VOutro', dtFloat, 15, '', '');
  Connection.WriteField('VNF', dtFloat, 15, '', '');
end;

procedure TdmACBrNFeRave.CustomCalculoImpostoCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.Total.ICMSTot do
  begin
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VBC),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VICMS),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VBCST),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VST),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VProd),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VFrete),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VSeg),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VDesc),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VII),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VIPI),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VPIS),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VCOFINS),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VOutro),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VNF),0));
  end;
end;

procedure TdmACBrNFeRave.CustomCalculoImpostoCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFeRave.CustomDadosProdutosCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('CProd', dtString, 60, '', ''); //Codigo
  Connection.WriteField('cEAN', dtString, 60, '', ''); //GTIN
  Connection.WriteField('XProd', dtMemo, 120, '', ''); //Descricao
  Connection.WriteField('infAdProd', dtMemo, 500, '', ''); //Inf. Adic. Produto
  Connection.WriteField('NCM', dtString, 8, '', ''); //NCM
  Connection.WriteField('EXTIPI', dtString, 8, '', ''); //EX_TIPI
  Connection.WriteField('genero', dtString, 8, '', ''); //genero
  Connection.WriteField('CFOP', dtString, 4, '', ''); //CFOP
  Connection.WriteField('UCom', dtString, 6, '', ''); //Unidade
  Connection.WriteField('QCom', dtFloat, 12, '', ''); //Quantidade
  Connection.WriteField('VUnCom', dtFloat, 16, '', ''); //ValorUnitario
  Connection.WriteField('VProd', dtFloat, 15, '', ''); //ValorTotal
  Connection.WriteField('cEANTrib', dtString, 60, '', ''); //GTIN Trib.
  Connection.WriteField('UTrib', dtString, 6, '', ''); //Unidade
  Connection.WriteField('QTrib', dtFloat, 12, '', ''); //Quantidade
  Connection.WriteField('VUnTrib', dtFloat, 16, '', ''); //ValorUnitario
  Connection.WriteField('vFrete', dtFloat, 16, '', ''); //Total do Frete
  Connection.WriteField('vSeg', dtFloat, 16, '', ''); //Total do Seguro
  Connection.WriteField('vDesc', dtString, 16, '', ''); //Desconto
  Connection.WriteField('ORIGEM', dtString, 1, '', ''); //ORIGEM
  Connection.WriteField('CST', dtString, 2, '', ''); //CST
  Connection.WriteField('VBC', dtFloat, 15, '', ''); //ValorBase
  Connection.WriteField('PICMS', dtFloat, 5, '', ''); //Aliquota
  Connection.WriteField('VICMS', dtFloat, 15, '', ''); //Valor
  Connection.WriteField('VIPI', dtFloat, 15, '', ''); //Valor IPI
  Connection.WriteField('PIPI', dtFloat, 5, '', ''); //Aliquota IPI
end;

procedure TdmACBrNFeRave.CustomDadosProdutosCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := FNFe.Det.Count;
end;


procedure TdmACBrNFeRave.CustomDadosProdutosCXNGetRow(
Connection: TRvCustomConnection);
var
   vTemp, vTemp2: TStringList;
   IndexCampo,IndexCampo2:Integer;
   Campos,Campos2:ArrOfStr;

   BufferXProd, BufferXInfProd : PAnsiChar;
   size:integer;
   TmpStr : String;

   j: integer;
   wInfAdProd: string;
begin
   with FNFe.Det.Items[Connection.DataIndex] do
   begin
      with Prod do
      begin
         Connection.WriteStrData('', cProd);
         Connection.WriteStrData('', cEAN);

         vTemp := TStringList.Create;
         try
            Campos := explode(';',XProd);
            for indexCampo:=0 to Length(Campos)-1 do
               vTemp.Add(Trim(Campos[indexCampo]));
            TmpStr := vTemp.Text;
            {$IF CompilerVersion >= 20} //Igual ou Superior ao Delphi2009
               Size := Length(TmpStr) * 2;
            {$ELSE}
               Size := Length(TmpStr);
            {$IFEND}
            BufferXProd := PAnsiChar(TmPStr);
            Connection.WriteBlobData(BufferXProd^, Size);
         finally
            vTemp.Free;
         end;

         wInfAdProd:=infAdProd;
         vTemp2 := TStringList.Create;
         try
            if (FDANFEClassOwner.ImprimirDetalhamentoEspecifico) then
            begin
               //detalhamento especifico de ve�culos
               if (trim(Prod.veicProd.chassi)<>'') then
               begin
                  vTemp2.Add(' CHASSI: '+Prod.veicProd.chassi);
                  vTemp2.Add(' COMBUST�VEL: '+Prod.veicProd.tpComb);
                  vTemp2.Add(' COR: '+Prod.veicProd.xCor);
                  vTemp2.Add(' FAB./MOD.: '+IntToStr(Prod.veicProd.anoFab)+'/'+IntToStr(Prod.veicProd.anoMod));
                  vTemp2.Add(' RENAVAM: '+Prod.veicProd.RENAVAM);
                  vTemp2.Add(' N� DO MOTOR: '+Prod.veicProd.nMotor);

                  if (trim(wInfAdProd) <> '') then
                     wInfAdProd:=wInfAdProd+';';//insere quebra de linha antes do detalhamento
                  wInfAdProd:=wInfAdProd+vTemp2.Text;
                  vTemp2.Clear;
               end;

               //detalhamento espec�fico de medicamentos
               if (Prod.med.Count > 0) then
               begin
                  for j:=0 to Prod.med.Count-1 do
                  begin
                     with Prod.med.Items[j] do
                     begin
                        vTemp2.Add('-LOTE: '+nLote);
                        vTemp2.Add(' QTDADE: '+NotaUtil.FormatFloat(qLote));
                        vTemp2.Add(' FABR.: '+NotaUtil.FormatDate(DateToStr(dFab)));
                        vTemp2.Add(' VAL.: '+NotaUtil.FormatDate(DateToStr(dVal)));
                        vTemp2.Add(NotaUtil.SeSenao(vPMC>0,' PMC: '+NotaUtil.FormatFloat(vPMC),''));
                    end;
                 end;

                 if (trim(wInfAdProd) <> '') then
                    wInfAdProd:=wInfAdProd+';';//insere quebra de linha antes do detalhamento
                 wInfAdProd:=wInfAdProd+vTemp2.Text;
                 vTemp2.Clear;
              end;
            end;

            if (Trim(winfAdProd) <> '') then
            begin
               Campos2 := explode(';',winfAdProd);
               for IndexCampo2:=0 to Length(Campos2)-1 do
                  vTemp2.Add(Trim(Campos2[IndexCampo2]));
               TmpStr := vTemp2.Text;
               {$IF CompilerVersion >= 20} //Igual ou Superior ao Delphi2009
                  Size := Length(TmpStr) * 2;
               {$ELSE}
                  Size := Length(TmpStr);
               {$IFEND}
               BufferXInfProd := PAnsiChar(TmPStr);
            end
            else
            begin
               Size := 0;
               BufferXInfProd := #0;
            end;
            Connection.WriteBlobData(BufferXInfProd^, Size);
         finally
            vTemp2.Free;
         end;

         Connection.WriteStrData('', NCM);
         Connection.WriteStrData('', EXTIPI);
         Connection.WriteStrData('', IntToStr(genero));
         Connection.WriteStrData('', CFOP);
         Connection.WriteStrData('', UCom);
         Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(QCom),0));
         Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VUnCom),0));
         if FDANFEClassOwner.ImprimirTotalLiquido then
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VProd-vDesc),0))
         else
            Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VProd),0));
         Connection.WriteStrData('', cEANTrib);
         Connection.WriteStrData('', uTrib);
         Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(qTrib),0));
         Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(vUnTrib),0));
         Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(vFrete),0));
         Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(vSeg),0));
         if FDANFEClassOwner.ImprimirDescPorc then
          begin
            if vDesc > 0 then
             begin
               Connection.WriteStrData('', NotaUtil.FormatFloat(RoundTo(100-((((VUnCom*QCom)-vDesc)/(VUnCom*QCom))*100),-1))+'%' );
             end
            else
               Connection.WriteStrData('', NotaUtil.FormatFloat(vDesc));
          end
         else
            Connection.WriteStrData('', NotaUtil.FormatFloat(vDesc));
         with Imposto.ICMS do
         begin
           Connection.WriteStrData('',OrigToStr(orig));
//           NotaUtil.SeSenao(orig = oeNacional,'0',NotaUtil.SeSenao(orig = oeEstrangeiraImportacaoDireta,'1','2')));
           if CST = cst00 then
             begin
               Connection.WriteStrData('', CSTICMSToStr(cst00));
               Connection.WriteFloatData('', vBC);
               Connection.WriteFloatData('', pICMS);
               Connection.WriteFloatData('', vICMS);
             end
           else if CST = cst10 then
             begin
               Connection.WriteStrData('', CSTICMSToStr(cst10));
               Connection.WriteFloatData('', VBC);
               Connection.WriteFloatData('', PICMS);
               Connection.WriteFloatData('', VICMS);
             end
           else if CST = cst20 then
             begin
               Connection.WriteStrData('', CSTICMSToStr(cst20));
               Connection.WriteFloatData('', VBC);
               Connection.WriteFloatData('', PICMS);
               Connection.WriteFloatData('', VICMS);
             end
           else if CST = cst30 then
             begin
               Connection.WriteStrData('', CSTICMSToStr(cst30));
//               Connection.WriteFloatData('', VBCST);
//               Connection.WriteFloatData('', PICMSST);
//               Connection.WriteFloatData('', VICMSST);
               Connection.WriteFloatData('', 0);
               Connection.WriteFloatData('', 0);
               Connection.WriteFloatData('', 0);
             end
           else if (CST = cst40) or (CST = cst41) or (CST = cst50) then
             begin
               if (CST = cst40) then
                  Connection.WriteStrData('', CSTICMSToStr(cst40))
               else if (CST = cst41) then
                  Connection.WriteStrData('', CSTICMSToStr(cst41))
               else if (CST = cst50) then
                  Connection.WriteStrData('', CSTICMSToStr(cst50));
               Connection.WriteFloatData('', 0);
               Connection.WriteFloatData('', 0);
               Connection.WriteFloatData('', 0);
             end
           else if (CST = cst51) then
             begin
               Connection.WriteStrData('', CSTICMSToStr(cst51));
               Connection.WriteFloatData('', VBC);
               Connection.WriteFloatData('', PICMS);
               Connection.WriteFloatData('', VICMS);
             end
           else if (CST = cst60) then
             begin
               Connection.WriteStrData('', CSTICMSToStr(cst60));
//               Connection.WriteFloatData('', VBCST);
//               Connection.WriteFloatData('', 0);
//               Connection.WriteFloatData('', VICMSST);
               Connection.WriteFloatData('', 0);
               Connection.WriteFloatData('', 0);
               Connection.WriteFloatData('', 0);
             end
           else if (CST = cst70) then
             begin
               Connection.WriteStrData('', CSTICMSToStr(cst70));
               Connection.WriteFloatData('', VBC);
               Connection.WriteFloatData('', PICMS);
               Connection.WriteFloatData('', VICMS);
             end
           else if (CST = cst90) then
             begin
               Connection.WriteStrData('', CSTICMSToStr(cst90));
               Connection.WriteFloatData('', VBC);
               Connection.WriteFloatData('', PICMS);
               Connection.WriteFloatData('', VICMS);
             end;
         end;

         with Imposto.IPI do
         begin
            if (CST = ipi00) or (CST = ipi49) or
               (CST = ipi50) or (CST = ipi99) then
            begin
               Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VIPI),0));
               Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(PIPI),0));
            end
            else if (CST = ipi01) or (CST = ipi02) or (CST = ipi03) or
                    (CST = ipi04) or (CST = ipi51) or (CST = ipi52) or
                    (CST = ipi53) or (CST = ipi54) or (CST = ipi55) then
            begin
               Connection.WriteFloatData('', 0);
               Connection.WriteFloatData('', 0);
            end
            else
            begin
               Connection.WriteFloatData('', 0);
               Connection.WriteFloatData('', 0);
            end;
         end;
      end;
   end;
end;

procedure TdmACBrNFeRave.CustomTransportadorCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('ModFrete', dtString, 1, '', '');
  Connection.WriteField('CNPJCPF', dtString,18,'','');
  Connection.WriteField('XNome', dtString,60,'','');
  Connection.WriteField('IE', dtString,14,'','');
  Connection.WriteField('XEnder', dtString,60,'','');
  Connection.WriteField('XMun', dtString,60,'','');
  Connection.WriteField('UF', dtString,2,'','');
end;

procedure TdmACBrNFeRave.CustomTransportadorCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.Transp do
  begin
    Connection.WriteStrData('', NotaUtil.SeSenao(modFrete = mfContaEmitente,'0','1'));
    with Transporta do
    begin
      if NotaUtil.NaoEstaVazio(CNPJCPF) then
       begin
         if Length(CNPJCPF) > 11 then
            Connection.WriteStrData('', NotaUtil.FormatarCNPJ(CNPJCPF))
         else
            Connection.WriteStrData('', NotaUtil.FormatarCPF(CNPJCPF));
       end
      else
         Connection.WriteStrData('', '');
      Connection.WriteStrData('', XNome);
      Connection.WriteStrData('', IE);
      Connection.WriteStrData('', XEnder);
      Connection.WriteStrData('', CollateBr(XMun));
      Connection.WriteStrData('', UF);
    end;
  end;
end;

procedure TdmACBrNFeRave.CustomTransportadorCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFeRave.CustomParametrosCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('ResumoCanhoto', dtString, 200, '', '');
  Connection.WriteField('Mensagem0', dtString, 60, '', '');
  Connection.WriteField('Imagem', dtBlob, 60, '', '');
  Connection.WriteField('Sistema', dtString, 60, '', '');
  Connection.WriteField('Usuario', dtString, 60, '', '');
  Connection.WriteField('Fax', dtString, 60, '', '');
  Connection.WriteField('Site', dtString, 60, '', '');
  Connection.WriteField('Email', dtString, 60, '', '');
  Connection.WriteField('Desconto', dtString, 60, '', '');
  Connection.WriteField('ChaveAcesso_Descricao', dtString, 90, '', '');
  Connection.WriteField('Contigencia_ID', dtString, 36, '', '');
  Connection.WriteField('Contigencia_Descricao', dtString, 60, '', '');
  Connection.WriteField('Contigencia_Valor', dtString, 60, '', '');
  Connection.WriteField('LinhasPorPagina', dtInteger,0,'','');
end;

procedure TdmACBrNFeRave.CustomParametrosCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFeRave.CustomParametrosCXNGetRow(
  Connection: TRvCustomConnection);
var
  vStream: TMemoryStream;
  vChave_Contingencia: string;
  vResumo: string;
begin
  vResumo:='';
  if DANFEClassOwner.ExibirResumoCanhoto then
  begin
     if NotaUtil.EstaVazio(DANFEClassOwner.ExibirResumoCanhoto_Texto) then
        vResumo:='Emiss�o: '+NotaUtil.FormatDate(DateToStr(FNFe.Ide.DEmi))+'  Dest/Reme: '+FNFe.Dest.XNome+'  Valor Total: '+NotaUtil.FormatFloat(FNFe.Total.ICMSTot.VNF)
     else
        vResumo:=DANFEClassOwner.ExibirResumoCanhoto_Texto;
  end;
  Connection.WriteStrData('', vResumo);

  if (FNFe.Ide.TpAmb = taHomologacao) then
     Connection.WriteStrData('', 'NFe sem Valor Fiscal - HOMOLOGA��O')
  else
  begin
     if not (FNFe.Ide.tpEmis in [teContingencia, teFSDA]) then
     begin
        if ((NotaUtil.EstaVazio(FDANFEClassOwner.ProtocoloNFe)) and
            (NotaUtil.EstaVazio(FNFe.procNFe.nProt))) then
         Connection.WriteStrData('', 'NFe sem Autoriza��o de Uso da SEFAZ')
       else
         if (not ((NotaUtil.EstaVazio(FDANFEClassOwner.ProtocoloNFe)) and
                  (NotaUtil.EstaVazio(FNFe.procNFe.nProt)))) and
            (FNFe.procNFe.cStat = 101) then
            Connection.WriteStrData('', 'NFe Cancelada')
         else
            Connection.WriteStrData('', '');
     end
     else
        Connection.WriteStrData('', '');
  end;

  vStream := TMemoryStream.Create;
  try
    if NotaUtil.NaoEstaVazio(DANFEClassOwner.Logo) then
    begin
       if FileExists(DANFEClassOwner.Logo) then
          vStream.LoadFromFile(DANFEClassOwner.Logo);
    end;
    vStream.Position := 0;
    Connection.WriteBlobData(vStream.Memory^, vStream.Size);
  finally
    vStream.Free;
  end;

  if FDANFEClassOwner.Sistema <> '' then
     Connection.WriteStrData('', FDANFEClassOwner.Sistema)
  else
     Connection.WriteStrData('', 'Projeto ACBr - http://acbr.sf.net');

  if FDANFEClassOwner.Usuario <> '' then
     Connection.WriteStrData('', ' - '+FDANFEClassOwner.Usuario)
  else
     Connection.WriteStrData('', '');

  if FDANFEClassOwner.Fax <> '' then
     Connection.WriteStrData('', ' - FAX '+FDANFEClassOwner.Fax)
  else
     Connection.WriteStrData('', '');

  Connection.WriteStrData('', FDANFEClassOwner.Site);
  Connection.WriteStrData('', FDANFEClassOwner.Email);

  if FDANFEClassOwner.ImprimirDescPorc then
     Connection.WriteStrData('', 'DESC %')
  else
     Connection.WriteStrData('', 'V.DESC.');

   if ((FNFe.Ide.tpEmis=teNormal) or
       (FNFe.Ide.tpEmis=teSCAN)) or
       ((FNFe.Ide.tpEmis=teDPEC) and  notautil.NaoEstaVazio(FNFe.procNFe.nProt))
        then
    begin
      Connection.WriteStrData('', 'CHAVE DE ACESSO');
      Connection.WriteStrData('', '');
      Connection.WriteStrData('', 'PROTOCOLO DE AUTORIZA��O DE USO');
      if notautil.EstaVazio(FDANFEClassOwner.ProtocoloNFe) then
       begin
         if not (FNFe.Ide.tpEmis in [teContingencia, teFSDA]) and NotaUtil.EstaVazio(FNFe.procNFe.nProt) then
            Connection.WriteStrData('', 'NFe sem Autoriza��o de Uso da SEFAZ')
         else
            Connection.WriteStrData('', FNFe.procNFe.nProt+' '+NotaUtil.SeSenao(FNFe.procNFe.dhRecbto<>0,DateTimeToStr(FNFe.procNFe.dhRecbto),''));
       end
      else
         Connection.WriteStrData('', FDANFEClassOwner.ProtocoloNFe);
    end
   else
    begin
      vChave_Contingencia:=NotaUtil.GerarChaveContingencia(FNFe);
      Connection.WriteStrData('', 'CHAVE DE ACESSO');
      Connection.WriteStrData('', vChave_Contingencia);
      if ((FNFe.Ide.tpEmis=teContingencia) or
          (FNFe.Ide.tpEmis=teFSDA)) then
       begin
         Connection.WriteStrData('', 'DADOS DA NF-E');
         Connection.WriteStrData('', NotaUtil.FormatarChaveContigencia(vChave_Contingencia));
       end
      else if (FNFe.Ide.tpEmis=teDPEC) then
       begin
         Connection.WriteStrData('', 'N�MERO DE REGISTRO DPEC');
         //precisa testar
         if notautil.EstaVazio(FDANFEClassOwner.ProtocoloNFe) and notautil.EstaVazio(FNFe.procNFe.nProt) then
            Connection.WriteStrData('', 'Protocolo de Registro no DPEC n�o informado.')
         else
          begin
            if notautil.EstaVazio(FDANFEClassOwner.ProtocoloNFe) then
               Connection.WriteStrData('', FNFe.procNFe.nProt+' '+NotaUtil.SeSenao(FNFe.procNFe.dhRecbto<>0,DateTimeToStr(FNFe.procNFe.dhRecbto),''))
            else
               Connection.WriteStrData('', FDANFEClassOwner.ProtocoloNFe);
          end
       end;
    end;

   //linhas por p�gina
   Connection.WriteIntData('', FDANFEClassOwner.ProdutosPorPagina);
end;

procedure TdmACBrNFeRave.CustomIdentificacaoCXNGetCols(
  Connection: TRvCustomConnection);
begin
  //Ide
//  Connection.WriteField('Versao', dtString, 4, '', '');
  Connection.WriteField('Id', dtString, 44, '', '');
  Connection.WriteField('Chave', dtString, 60, '', '');
  Connection.WriteField('CUF', dtString, 2, '', '');
  Connection.WriteField('CNF', dtString, 9, '', '');
  Connection.WriteField('NatOp', dtString, 60, '', '');
  Connection.WriteField('IndPag', dtString, 1, '', '');
  Connection.WriteField('Mod_', dtString, 2, '', '');
  Connection.WriteField('Serie', dtString, 3, '', '');
  Connection.WriteField('NNF', dtString, 11, '', '');
  Connection.WriteField('DEmi', dtString, 10, '', '');
  Connection.WriteField('DSaiEnt', dtString, 10, '', '');
  Connection.WriteField('TpNF', dtString, 1, '', '');
  Connection.WriteField('CMunFG', dtString, 7, '', '');
  Connection.WriteField('TpImp', dtString, 1, '', '');
  Connection.WriteField('TpEmis', dtString, 1, '', '');
  Connection.WriteField('CDV', dtString, 1, '', '');
  Connection.WriteField('TpAmb', dtString, 1, '', '');
  Connection.WriteField('FinNFe', dtString, 1, '', '');
  Connection.WriteField('ProcEmi', dtString, 1, '', '');
  Connection.WriteField('VerProc', dtString, 20, '', '');
  Connection.WriteField('HoraSaida', dtString, 10, '', '');
end;

procedure TdmACBrNFeRave.CustomIdentificacaoCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.infNFe do
  begin
//    Connection.WriteStrData('', IntToStr(Versao));
    Connection.WriteStrData('', NotaUtil.LimpaNumero(Id));
    Connection.WriteStrData('', NotaUtil.FormatarChaveAcesso(Id));
  end;

  with FNFe.Ide do
  begin
    Connection.WriteStrData('', inttostr(CUF));
    Connection.WriteStrData('', inttostr(CNF));
    Connection.WriteStrData('', NatOp);
    Connection.WriteStrData('', NotaUtil.SeSenao(IndPag = ipVista,'0', NotaUtil.SeSenao(IndPag = ipPrazo,'1','2')));
    Connection.WriteStrData('', inttostr(Modelo));
    Connection.WriteStrData('', inttostr(Serie));
    Connection.WriteStrData('', NotaUtil.FormatarNumeroDocumentoFiscal(inttostr(NNF)));
    Connection.WriteStrData('', NotaUtil.FormatDate(datetostr(DEmi)));
    Connection.WriteStrData('', IfThen(DSaiEnt<>0, NotaUtil.FormatDate(datetostr(DSaiEnt))));
    Connection.WriteStrData('', NotaUtil.SeSenao(TpNF=tnEntrada,'0','1'));
    Connection.WriteStrData('', inttostr(CMunFG));
    Connection.WriteStrData('', NotaUtil.SeSenao(TpImp=tiRetrato,'1','2'));
    Connection.WriteStrData('', NotaUtil.SeSenao(TpEmis=teNormal,'1','5'));
    Connection.WriteStrData('', inttostr(CDV));
    Connection.WriteStrData('', NotaUtil.SeSenao(TpAmb = taHomologacao,'2','1'));
    Connection.WriteStrData('', NotaUtil.SeSenao(FinNFe=fnNormal,'1',NotaUtil.SeSenao(FinNFe=fnComplementar,'2','3')));
    Connection.WriteStrData('', NotaUtil.SeSenao(ProcEmi=peAplicativoContribuinte,'0',''));
    Connection.WriteStrData('', VerProc);
  end;

  if FDANFEClassOwner.ImprimirHoraSaida then
  begin
     if NotaUtil.EstaVazio(FDANFEClassOwner.ImprimirHoraSaida_Hora) then
        Connection.WriteStrData('', TimeToStr(Now))
     else
        Connection.WriteStrData('', FDANFEClassOwner.ImprimirHoraSaida_Hora);
  end
  else
     Connection.WriteStrData('', '');
end;

procedure TdmACBrNFeRave.CustomIdentificacaoCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFeRave.CustomDuplicatasCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('NDup', dtString, 60, '', '');
  Connection.WriteField('DVenc', dtString, 10, '', '');
  Connection.WriteField('VDup', dtFloat, 15, '', '');
end;

procedure TdmACBrNFeRave.CustomDuplicatasCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.Cobr.Dup[Connection.DataIndex] do
  begin
    Connection.WriteStrData('', NDup);
    Connection.WriteStrData('', NotaUtil.FormatDate(datetostr(DVenc)));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VDup),0));
  end;
end;

procedure TdmACBrNFeRave.CustomDuplicatasCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := FNFe.Cobr.Dup.Count;
end;

procedure TdmACBrNFeRave.CustomVeiculoCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('PLACA', dtString,8,'','');
  Connection.WriteField('UF', dtString,2,'','');
  Connection.WriteField('RNTC', dtString,20,'','');
end;

procedure TdmACBrNFeRave.CustomVeiculoCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.Transp.VeicTransp do
  begin
    Connection.WriteStrData('', Placa);
    Connection.WriteStrData('', UF);
    Connection.WriteStrData('', RNTC);
  end;
end;

procedure TdmACBrNFeRave.CustomVeiculoCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFeRave.CustomVolumesCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('QVol', dtFloat,15,'','');
  Connection.WriteField('Esp', dtString,60,'','');
  Connection.WriteField('Marca', dtString,60,'','');
  Connection.WriteField('NVol', dtString,60,'','');
  Connection.WriteField('PesoL', dtFloat,15,'','');
  Connection.WriteField('PesoB', dtFloat,15,'','');
end;

procedure TdmACBrNFeRave.CustomVolumesCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.Transp.Vol[Connection.DataIndex] do
  begin
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(inttostr(QVol),0));
    Connection.WriteStrData('', Esp);
    Connection.WriteStrData('', Marca);
    Connection.WriteStrData('', NVol);
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(PesoL),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(PesoB),0));
  end;
end;

procedure TdmACBrNFeRave.CustomVolumesCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := FNFe.Transp.Vol.Count;
end;

procedure TdmACBrNFeRave.CustomInformacoesAdicionaisCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('OBS', dtMemo,6900,'','');
  Connection.WriteField('LinhasOBS', dtInteger,0,'','');
end;

procedure TdmACBrNFeRave.CustomInformacoesAdicionaisCXNGetRow(
  Connection: TRvCustomConnection);
   function TotalOBS(wwObs: string): integer;
   var
      wMemo: TMemo;
      wForm: TForm;
   begin
      wForm:=TForm.Create(self);
      wMemo:=TMemo.Create(wForm);
      try
         with wMemo do
         begin
            Parent:=wForm;
            Width := 452;
            Height := 800;
            Font.Height := -8;
            Font.Name := 'Times New Roman';
            Font.Style := [];
            ParentFont := False;
            TabOrder := 0;
            Text:=wwObs;
            Update;
         end;
         result:=wmemo.Lines.count;
      finally
         wMemo.Free;
         wForm.free;
      end;
   end;
var
  i: Integer;
  vTemp: TStringList;
  IndexCampo:Integer;
  Campos: ArrOfStr;
  BufferInfCpl: PAnsiChar;
  size: integer;
  TmpStr: String;
  wContingencia: string;
  wObs:string;
  wLinhasObs: integer;
begin
  wLinhasObs := 0;
  with FNFe.InfAdic do
  begin
    TmpStr:='';
    //Fisco
    if (Length(InfAdFisco)=0) then
      InfAdFisco:='';
    for i:=0  to ObsFisco.Count-1 do
    begin
      with ObsFisco.Items[i] do
         TmpStr:=TmpStr+XCampo+': '+XTexto+';';
    end;
    wObs:=TmpStr+InfAdFisco;
    TmpStr:='';

    //Inf. Complementar
    if (Length(InfCpl)=0) then
      InfCpl:='';
    for i:=0  to ObsCont.Count-1 do
    begin
      with ObsCont.Items[i] do
         TmpStr:=TmpStr+XCampo+': '+XTexto+';';
    end;
    if length(wobs)>0 then
      wobs:=wobs+';';
    wObs:=wObs+TmpStr+InfCpl;
    TmpStr:='';

    //Contingencia
    if (FNFe.Ide.tpEmis=teNORMAL) then
      wcontingencia:=''
    else
    begin
       if ((FNFe.Ide.tpEmis=teContingencia) or
           (FNFe.Ide.tpEmis=teFSDA) or
           (FNFe.Ide.tpEmis=teSCAN)) then
          wcontingencia:='DANFE EM CONTING�NCIA, IMPRESSO EM DECORR�NCIA DE PROBLEMAS T�CNICOS'
       else if (FNFe.Ide.tpEmis=teDPEC) then
          wcontingencia:='DANFE IMPRESSO EM CONTING�NCIA - DPEC REGULARMENTE RECEBIDA PELA RECEITA FEDERAL DO BRASIL';
    end;
    if length(wobs)>0 then
      wobs:=wobs+';';
    wObs:=wObs+wContingencia;

    vTemp := TStringList.Create;
    try
      if (trim(wObs) <> '') then
      begin
         Campos := explode(';',wObs);
         for indexCampo:=0 to Length(Campos)-1 do
            vTemp.Add(Campos[indexCampo]);
         wLinhasObs:=TotalObS(vTemp.Text);
         TmpStr := vTemp.Text;
         {$IF CompilerVersion >= 20} //Igual ou Superior ao Delphi2009
            Size := Length(TmpStr) * 2;
         {$ELSE}
            Size := Length(TmpStr);
         {$IFEND}
         BufferInfCpl:=PAnsiChar(TmpStr);
      end
      else
      begin
         Size:=0;
         BufferInfCpl:=#0;
      end;
      Connection.WriteBlobData(BufferInfCpl^, Size);
      Connection.WriteIntData('', wLinhasObs);
    finally
      vTemp.Free;
    end;
  end;
end;

procedure TdmACBrNFeRave.CustomInformacoesAdicionaisCXNOpen(
  Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TdmACBrNFeRave.CustomISSQNCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('vSERV', dtFloat, 15, '', '');
  Connection.WriteField('vBC', dtFloat, 15, '', '');
  Connection.WriteField('vISS', dtFloat, 15, '', '');
end;

procedure TdmACBrNFeRave.CustomISSQNCXNGetRow(Connection: TRvCustomConnection);
begin
  with FNFe.Total.ISSQNtot do
  begin
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VServ),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VBC),0));
    Connection.WriteFloatData('', NotaUtil.StringToFloatDef(floattostr(VISS),0));
  end;
end;

procedure TdmACBrNFeRave.CustomISSQNCXNOpen(Connection: TRvCustomConnection);
begin
   Connection.DataRows := 1;
end;

procedure TdmACBrNFeRave.CustomLocalEntregaCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('CNPJ',dtString,18,'','');
  Connection.WriteField('XLgr',dtString,60,'','');
  Connection.WriteField('Nro',dtString,60,'','');
  Connection.WriteField('XCpl',dtString,60,'','');
  Connection.WriteField('XBairro',dtString,60,'','');
  Connection.WriteField('CMun',dtString,7,'','');
  Connection.WriteField('XMun',dtString,60,'','');
  Connection.WriteField('UF',dtString,2,'','');
end;

procedure TdmACBrNFeRave.CustomLocalEntregaCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.Entrega do
  begin
    if NotaUtil.NaoEstaVazio(CNPJ) then
      Connection.WriteStrData('', NotaUtil.FormatarCNPJ(CNPJ))
    else
       Connection.WriteStrData('', NotaUtil.FormatarCNPJ(NotaUtil.Poem_Zeros(0,18)));

    Connection.WriteStrData('', XLgr);
    Connection.WriteStrData('', Nro);
    Connection.WriteStrData('', XCpl);
    Connection.WriteStrData('', XBairro);
    Connection.WriteStrData('', inttostr(CMun));
    Connection.WriteStrData('', CollateBr(XMun));
    Connection.WriteStrData('', UF);
  end;
end;

procedure TdmACBrNFeRave.CustomLocalEntregaCXNOpen(
  Connection: TRvCustomConnection);
begin
   if NotaUtil.NaoEstaVazio(FNFe.Entrega.CNPJ) then
      Connection.DataRows := 1
   else
      Connection.DataRows := 0;
end;

procedure TdmACBrNFeRave.CustomLocalRetiradaCXNGetCols(
  Connection: TRvCustomConnection);
begin
  Connection.WriteField('CNPJ',dtString,18,'','');
  Connection.WriteField('XLgr',dtString,60,'','');
  Connection.WriteField('Nro',dtString,60,'','');
  Connection.WriteField('XCpl',dtString,60,'','');
  Connection.WriteField('XBairro',dtString,60,'','');
  Connection.WriteField('CMun',dtString,7,'','');
  Connection.WriteField('XMun',dtString,60,'','');
  Connection.WriteField('UF',dtString,2,'','');
end;

procedure TdmACBrNFeRave.CustomLocalRetiradaCXNGetRow(
  Connection: TRvCustomConnection);
begin
  with FNFe.Retirada do
  begin
    if NotaUtil.NaoEstaVazio(CNPJ) then
      Connection.WriteStrData('', NotaUtil.FormatarCNPJ(CNPJ))
    else
       Connection.WriteStrData('', NotaUtil.FormatarCNPJ(NotaUtil.Poem_Zeros(0,18)));

    Connection.WriteStrData('', XLgr);
    Connection.WriteStrData('', Nro);
    Connection.WriteStrData('', XCpl);
    Connection.WriteStrData('', XBairro);
    Connection.WriteStrData('', inttostr(CMun));
    Connection.WriteStrData('', CollateBr(XMun));
    Connection.WriteStrData('', UF);
  end;
end;

procedure TdmACBrNFeRave.CustomLocalRetiradaCXNOpen(
  Connection: TRvCustomConnection);
begin
   if NotaUtil.NaoEstaVazio(FNFe.Retirada.CNPJ) then
      Connection.DataRows := 1
   else
      Connection.DataRows := 0;
end;

end.
