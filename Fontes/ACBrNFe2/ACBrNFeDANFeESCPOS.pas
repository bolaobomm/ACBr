{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
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
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 04/04/2013:  André Ferreira de Moraes
|*   Inicio do desenvolvimento
******************************************************************************}
{$I ACBr.inc}
unit ACBrNFeDANFeESCPOS;

interface

uses Classes, SysUtils,
     {$IFDEF FPC}
       LResources,
     {$ENDIF}
     ACBrNFeDANFEClass, ACBrDevice, ACBrUtil,
     pcnNFe, pcnConversao, pcnAuxiliar, ACBrDFeUtil;

const
      cCmdImpZera = #27+'@';
      cCmdEspacoLinha = #27+'3'+#14;
      cCmdPagCod = #27+'t'+#39;
      cCmdImpNegrito = #27+'E1';
      cCmdImpFimNegrito = #27+'E2';
      cCmdImpExpandido = #29+'!'+#16;
      cCmdImpFimExpandido = #29+'!'+#0;
      cCmdFonteNormal = #27+'M0';
      cCmdFontePequena = #27+'M1';
      cCmdAlinhadoEsquerda = #27+'a0';
      cCmdAlinhadoCentro = #27+'a1';
      cCmdAlinhadoDireita = #27+'a2';
      cCmdCortaPapel = #29+'V1';      

type
  TACBrNFeDANFeESCPOS = class( TACBrNFeDANFEClass )
  private
    FDevice : TACBrDevice ;
    FLinhaCmd : String;
    FBuffer : TStringList;

    procedure ImprimePorta( AString : AnsiString ) ;
  protected
    FpNFe: TNFe;

    procedure GerarCabecalho;
    procedure GerarItens;
    procedure GerarTotais(Resumido : Boolean = False);
    procedure GerarPagamentos(Resumido : Boolean = False );
    procedure GerarTotTrib;
    procedure GerarObsFisco;
    procedure GerarDadosConsumidor;
    procedure GerarRodape(CortaPapel: Boolean = True; Cancelamento: Boolean = False);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE : TNFe = nil); override ;
    procedure ImprimirDANFEResumido(NFE : TNFe = nil); override ;
  published
    property Device : TACBrDevice read FDevice ;
  end ;

procedure Register;

implementation

uses ACBrNFe, ACBrNFeUtil, StrUtils;

procedure Register;
begin
  RegisterComponents('ACBr',[TACBrNFeDANFeESCPOS]);
end;

function Int2TB(AInteger: Integer): AnsiString;
var
   AHexStr: String;
begin
  AHexStr := IntToHex(AInteger,4);
  Result  := AnsiChar(chr( StrToInt('$'+copy(AHexStr,3,2) ) )) +
             AnsiChar(chr( StrToInt('$'+copy(AHexStr,1,2) ) )) ;
  AHexStr := Result;
end;

{ TACBrNFeDANFeESCPOS }

constructor TACBrNFeDANFeESCPOS.Create(AOwner: TComponent);
begin
  inherited create( AOwner );

  { Instanciando SubComponente TACBrDevice }
  FDevice := TACBrDevice.Create( self ) ;  { O dono é o proprio componente }
  FDevice.Name := 'ACBrDevice' ;      { Apenas para aparecer no Object Inspector}
  {$IFDEF COMPILER6_UP}
  FDevice.SetSubComponent( true );{ para gravar no DFM/XFM }
  {$ENDIF}
  FDevice.SetDefaultValues ;
  FDevice.Porta := 'COM1';

  FBuffer := TStringList.Create;
end;

destructor TACBrNFeDANFeESCPOS.Destroy;
begin
  FBuffer.Free;

  FreeAndNil( FDevice ) ;
  
  inherited Destroy ;
end;

procedure TACBrNFeDANFeESCPOS.GerarCabecalho;
begin
  FLinhaCmd := cCmdImpZera+cCmdEspacoLinha+cCmdPagCod+cCmdFonteNormal+cCmdAlinhadoCentro;
  FBuffer.clear;
  FBuffer.Add(FLinhaCmd+chr(29)+'(L'+chr(6)+chr(0)+'0E  '+chr(1)+chr(1)); // Imprimindo logo já gravado na memória

//  FLinhaCmd := cCmdAlinhadoCentro+cCmdImpNegrito+FpCFe.Emit.xFant+cCmdImpFimNegrito;
//  FBuffer.Add(FLinhaCmd);
  FBuffer.Add(cCmdImpNegrito+FpNFe.Emit.xNome+cCmdImpFimNegrito);
  FLinhaCmd := cCmdImpNegrito+cCmdFontePequena+
              'CNPJ:'+DFeUtil.FormatarCNPJ(FpNFe.Emit.CNPJCPF)+'   '+
              'Inscrição Estadual:'+Trim(FpNFe.Emit.IE)+cCmdImpFimNegrito;
  FBuffer.Add(FLinhaCmd);

  FBuffer.Add(cCmdFontePequena+Trim(FpNFe.Emit.EnderEmit.xLgr)+' '+
              Trim(FpNFe.Emit.EnderEmit.nro)+' '+
              Trim(FpNFe.Emit.EnderEmit.xCpl)+' '+
              Trim(FpNFe.Emit.EnderEmit.xBairro)+'-'+
              Trim(FpNFe.Emit.EnderEmit.xMun));


  FBuffer.Add(cCmdAlinhadoEsquerda+cCmdFonteNormal+'------------------------------------------------');

  FLinhaCmd := cCmdFonteNormal+cCmdAlinhadoCentro+cCmdImpNegrito+
                 'DANFE NFC-e - Documento Auxiliar';
  FBuffer.Add(FLinhaCmd);
  FLinhaCmd := 'da Nota Fiscal Eletrônica para Consumidor Final';
  FBuffer.Add(FLinhaCmd);
  FLinhaCmd := 'Não permite aproveitamento de crédito de ICMS'+cCmdImpFimNegrito;
  FBuffer.Add(FLinhaCmd);
end;

procedure TACBrNFeDANFeESCPOS.GerarItens;
var
  i : integer;
begin
  FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
  FBuffer.Add('#|COD|DESCRIÇÃO|QTD|UN|VL UN R$|VL TOTAL R$');
  FBuffer.Add('------------------------------------------------');

  for i:=0 to FpNFe.Det.Count - 1 do
   begin
     FLinhaCmd := IntToStrZero(FpNFe.Det.Items[i].Prod.nItem,3)+' '+
                  Trim(FpNFe.Det.Items[i].Prod.cProd)+' '+
                  Trim(copy(FpNFe.Det.Items[i].Prod.xProd,1,28))+' '+
                  DFeUtil.FormatFloat(FpNFe.Det.Items[i].Prod.qCom,'0.0000')+' '+
                  Trim(FpNFe.Det.Items[i].Prod.uCom)+' X '+
                  DFeUtil.FormatFloat(FpNFe.Det.Items[i].Prod.vUnCom,'0.000')+' ';

     FLinhaCmd := FLinhaCmd + '|' + FormatFloat('#,###,##0.00',FpNFe.Det.Items[i].Prod.vProd)+' ';

     FLinhaCmd := padS(FLinhaCmd,64, '|');

     FBuffer.Add(cCmdAlinhadoEsquerda+cCmdFontePequena+FLinhaCmd);

     if FpNFe.Det.Items[i].Prod.vDesc > 0 then
      begin
        FBuffer.Add(padS('desconto|'+FormatFloat('-#,###,##0.00',FpNFe.Det.Items[i].Prod.vDesc),64, '|'));
        FBuffer.Add(padS('valor líquido|'+FormatFloat('#,###,##0.00',(FpNFe.Det.Items[i].Prod.qCom*FpNFe.Det.Items[i].Prod.vUnCom)-FpNFe.Det.Items[i].Prod.vDesc),64, '|'));
      end;

     if FpNFe.Det.Items[i].Prod.vOutro > 0 then
      begin
        FBuffer.Add(padS('desconto|'+FormatFloat('-#,###,##0.00',FpNFe.Det.Items[i].Prod.vOutro),64, '|'));
        FBuffer.Add(padS('valor líquido|'+FormatFloat('#,###,##0.00',(FpNFe.Det.Items[i].Prod.qCom*FpNFe.Det.Items[i].Prod.vUnCom)+FpNFe.Det.Items[i].Prod.vOutro),64, '|'));
      end;
   end;
  FBuffer.Add(cCmdAlinhadoEsquerda+cCmdFonteNormal);
end;

procedure TACBrNFeDANFeESCPOS.GerarTotais(Resumido: Boolean);
begin
  FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
  FBuffer.Add(cCmdFontePequena+padS('QTD. TOTAL DE ITENS|'+IntToStrZero(FpNFe.Det.Count,3),64, '|'));
  if not Resumido then
   begin
     if (FpNFe.Total.ICMSTot.vDesc > 0) or (FpNFe.Total.ICMSTot.vOutro > 0) then
        FBuffer.Add(cCmdFontePequena+padS('Subtotal|'+FormatFloat('#,###,##0.00',FpNFe.Total.ICMSTot.vProd),64, '|'));
     if FpNFe.Total.ICMSTot.vDesc > 0 then
        FBuffer.Add(cCmdFontePequena+padS('Descontos|'+FormatFloat('-#,###,##0.00',FpNFe.Total.ICMSTot.vDesc),64, '|'));
     if FpNFe.Total.ICMSTot.vOutro > 0 then
        FBuffer.Add(cCmdFontePequena+padS('Acréscimos|'+FormatFloat('+#,###,##0.00',FpNFe.Total.ICMSTot.vOutro),64, '|'));
   end;

  FLinhaCmd := cCmdAlinhadoEsquerda+cCmdImpExpandido+
               padS('TOTAL R$|'+FormatFloat('#,###,##0.00',FpNFe.Total.ICMSTot.vNF),32, '|')+
               cCmdImpFimExpandido;
  FBuffer.Add(FLinhaCmd);
end;

procedure TACBrNFeDANFeESCPOS.GerarPagamentos(Resumido : Boolean = False );
var
  i : integer;
  Total, Troco : Real;
begin
  Total := 0;
  FBuffer.Add(cCmdFontePequena+padS('FORMA DE PAGAMENTO '+'|'+' Valor Pago',64, '|'));
  for i:=0 to FpNFe.pag.Count - 1 do
   begin
     FBuffer.Add(cCmdFontePequena+padS(FormaPagamentoToDescricao(FpNFe.pag.Items[i].tPag)+'|'+FormatFloat('#,###,##0.00',FpNFe.pag.Items[i].vPag),64, '|'));
     Total := Total + FpNFe.pag.Items[i].vPag;
   end;

  Troco := Total - FpNFe.Total.ICMSTot.vNF;
  if Troco > 0 then
     FBuffer.Add(cCmdFontePequena+padS('Troco R$|'+FormatFloat('#,###,##0.00',Troco),64, '|'));
  FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
end;

procedure TACBrNFeDANFeESCPOS.GerarTotTrib;
begin
  if FpNFe.Total.ICMSTot.vTotTrib > 0 then
   begin
     FBuffer.Add(cCmdFontePequena+padS('Informação dos Tributos Totais Incidentes |'+cCmdImpNegrito+FormatFloat('#,###,##0.00',FpNFe.Total.ICMSTot.vTotTrib),66, '|'));
     FBuffer.Add(cCmdImpFimNegrito+'(Lei Federal 12.741/2012)');
     FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
   end;
end;

procedure TACBrNFeDANFeESCPOS.GerarObsFisco;
begin
  if FpNFe.ide.tpAmb = taHomologacao then
   begin
     FLinhaCmd := cCmdFontePequena+cCmdAlinhadoCentro+cCmdImpNegrito+
                 'EMITIDA EM AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL';
   end
  else
   begin
     if FpNFe.Ide.tpEmis <> teNormal then
        FLinhaCmd := cCmdFonteNormal+cCmdAlinhadoCentro+cCmdImpNegrito+
                 'EMITIDA EM CONTINGÊNCIA'
     else
        FLinhaCmd := cCmdFonteNormal+cCmdAlinhadoCentro+cCmdImpNegrito+
                 'ÁREA DE MENSAGEM FISCAL';
   end;

  FBuffer.Add(FLinhaCmd);

  FLinhaCmd := cCmdImpFimNegrito+cCmdFontePequena+cCmdAlinhadoCentro+
               'Número '+IntToStrZero(FpNFe.Ide.nNF,9)+
               ' Série '+IntToStrZero(FpNFe.Ide.serie,3)+
               ' Emissão '+DateTimeToStr(FpNFe.ide.dEmi) ;
  FBuffer.Add(FLinhaCmd);
  FBuffer.Add(cCmdAlinhadoCentro+cCmdFontePequena+'Consulte pela Chave de Acesso em '+NotaUtil.GetURLConsultaNFCe(FpNFe.Ide.cUF,FpNFe.ide.tpAmb));
  FBuffer.Add(cCmdAlinhadoCentro+cCmdFonteNormal+'CHAVE DE ACESSO');
  FLinhaCmd :=  cCmdAlinhadoCentro+cCmdFontePequena+DFeUtil.FormatarChaveAcesso(OnlyNumber(FpNFe.infNFe.ID))+cCmdFonteNormal;
  FBuffer.Add(FLinhaCmd);

  FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
end;

procedure TACBrNFeDANFeESCPOS.GerarDadosConsumidor;
begin
  FLinhaCmd := cCmdFonteNormal+cCmdAlinhadoCentro+cCmdImpNegrito+
               'CONSUMIDOR'+cCmdImpFimNegrito;
  FBuffer.Add(FLinhaCmd);

  if (FpNFe.Dest.idEstrangeiro = '') and
     (FpNFe.Dest.CNPJCPF = '') then
   begin
      FLinhaCmd := 'CONSUMIDOR NÃO IDENTIFICADO';
   end
  else if FpNFe.Dest.idEstrangeiro <> '' then
   begin
     FLinhaCmd := 'CNPJ/CPF/ID Estrangeiro -'+FpNFe.Dest.idEstrangeiro+' '+FpNFe.Dest.xNome;
   end
  else
   begin
     if Length(trim(FpNFe.Dest.CNPJCPF)) > 11 then
        FLinhaCmd := 'CNPJ/CPF/ID Estrangeiro -'+DFeUtil.FormatarCNPJ(FpNFe.Dest.CNPJCPF)
     else
        FLinhaCmd := 'CNPJ/CPF/ID Estrangeiro -'+DFeUtil.FormatarCPF(FpNFe.Dest.CNPJCPF);

     FLinhaCmd := FLinhaCmd+' '+FpNFe.Dest.xNome;
   end;

  FBuffer.Add(cCmdFontePequena+FLinhaCmd);
  FBuffer.Add(cCmdFontePequena+Trim(FpNFe.Dest.EnderDest.xLgr)+' '+
              Trim(FpNFe.Dest.EnderDest.nro)+' '+
              Trim(FpNFe.Dest.EnderDest.xCpl)+' '+
              Trim(FpNFe.Dest.EnderDest.xBairro)+' '+
              Trim(FpNFe.Dest.EnderDest.xMun));

end;


procedure TACBrNFeDANFeESCPOS.GerarRodape(CortaPapel: Boolean = True; Cancelamento: Boolean = False);
var
  qrcode : string;
begin
  FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
  FLinhaCmd := cCmdAlinhadoCentro+'Consulta via leitor de QR Code';
  FBuffer.Add(FLinhaCmd);
  FBuffer.Add(' ');


{  qrcode := NotaUtil.GetURLConsultaNFCe(FpNFe.Ide.cUF,StrToInt(TpAmbToStr(FpNFe.ide.tpAmb)));
  qrcode := qrcode + 'chNFe='+OnlyNumber(FpNFe.infNFe.ID) + '&';
  qrcode := qrcode + 'nVersao=100' + '&';
  qrcode := qrcode + 'tpAmb='+ TpAmbToStr(FpNFe.Ide.tpAmb) + '&';

  if FpNFe.Dest.idEstrangeiro <> '' then
   begin
     qrcode := qrcode + 'cDest'+FpNFe.Dest.idEstrangeiro+ '&';
   end
  else
   begin
     if Length(Trim(FpNFe.Dest.CNPJCPF)) > 11 then
       qrcode := qrcode + 'cDest'+FpNFe.Dest.CNPJCPF+ '&'
     else
      begin
       if Length(Trim(FpNFe.Dest.CNPJCPF)) = 11 then
          qrcode := qrcode + 'cDest'+FpNFe.Dest.CNPJCPF+ '&';
      end;
   end;

  qrcode := qrcode + 'dhEmi='  + AsciiToHex(DateTimeTodh(FpNFe.Ide.dEmi) + GetUTC(CodigoParaUF(FpNFe.ide.cUF), FpNFe.Ide.dEmi)) + '&';
  qrcode := qrcode + 'vNF='    + DFeUtil.FormatFloat(FpNFe.Total.ICMSTot.vNF,'0.00') + '&';
  qrcode := qrcode + 'vICMS='  + DFeUtil.FormatFloat(FpNFe.Total.ICMSTot.vICMS,'0.00') + '&';
  qrcode := qrcode + 'digVal=' + AsciiToHex(FpNFe.procNFe.digVal)+ '&';
  qrcode := qrcode + 'cIdToken=' + '123456'+ '&';
  qrcode := qrcode + 'cHashQRCode=' + FpNFe.procNFe.digVal;  }


  qrcode := NotaUtil.GetURLQRCode( FpNFe.ide.cUF, FpNFe.ide.tpAmb,
                                   FpNFe.infNFe.ID,
                                   DFeUtil.SeSenao(FpNFe.Dest.idEstrangeiro <> '',FpNFe.Dest.idEstrangeiro, FpNFe.Dest.CNPJCPF),
                                   FpNFe.ide.dEmi,
                                   FpNFe.Total.ICMSTot.vNF, FpNFe.Total.ICMSTot.vICMS,
                                   FpNFe.signature.DigestValue );

  FLinhaCmd := chr(29)+'(k'+chr(4)+chr(0)+'1A2'+chr(0)+
               chr(29)+'(k'+chr(3)+chr(0)+'1C'+chr(4)+
               chr(29)+'(k'+chr(3)+chr(0)+'1E0'+
               chr(29)+'(k'+Int2TB(length(qrcode)+3)+'1P0'+qrcode+
               chr(29)+'(k'+chr(3)+chr(0)+'1Q0';
  FBuffer.Add(FLinhaCmd);

  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add(cCmdFontePequena+'Protocolo de Autorização:'+Trim(FpNFe.procNFe.nProt)+' '+DFeUtil.SeSenao(FpNFe.procNFe.dhRecbto<>0,DateTimeToStr(FpNFe.procNFe.dhRecbto),'')+cCmdFonteNormal);
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add('');

  if CortaPapel then
     FBuffer.Add(cCmdCortaPapel);
end;

procedure TACBrNFeDANFeESCPOS.ImprimePorta(AString: AnsiString);
begin
   FDevice.EnviaString( AString );
end;

procedure TACBrNFeDANFeESCPOS.ImprimirDANFE(NFE : TNFe);
begin
  if NFe = nil then
   begin
     if not Assigned(ACBrNFe) then
        raise Exception.Create('Componente ACBrNFe não atribuído');

     FpNFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe;
   end
  else
    FpNFe := NFE;

  GerarCabecalho;
  GerarItens;
  GerarTotais;
  GerarPagamentos;
  GerarTotTrib;
  GerarObsFisco;
  GerarDadosConsumidor;
  GerarRodape;

  ImprimePorta(FBuffer.Text);
end;

procedure TACBrNFeDANFeESCPOS.ImprimirDANFEResumido(NFE : TNFe);
begin
  if NFe = nil then
   begin
     if not Assigned(ACBrNFe) then
        raise Exception.Create('Componente ACBrNFe não atribuído');

     FpNFe := TACBrNFe(ACBrNFe).NotasFiscais.Items[0].NFe;
   end
  else
    FpNFe := NFE;

  GerarCabecalho;
  GerarTotais(True);
  GerarPagamentos(True);
  GerarTotTrib;
  GerarObsFisco;
  GerarDadosConsumidor;
  GerarRodape;

  ImprimePorta(FBuffer.Text);
end;

{$ifdef FPC}
initialization
   {$I ACBrNFeDANFeESCPOS.lrs}
{$endif}


end.
