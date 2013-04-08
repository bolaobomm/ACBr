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
unit ACBrSATExtratoESCPOS;

interface

uses Classes, SysUtils,
     ACBrSATExtratoClass, ACBrDevice, ACBrUtil,
     pcnCFe, pcnConversao, ACBrDFeUtil;

const
      cCmdImpZera = #27+'@' ;
      cCmdPagCod = #27+'t'+#39;
      cCmdImpNegrito = #27+'E1' ;
      cCmdImpFimNegrito = #27+'E2';
      cCmdFonteNormal = #27+'M0';
      cCmdFontePequena = #27+'M1';
      cCmdAlinhadoEsquerda = #27+'a0';
      cCmdAlinhadoCentro = #27+'a1';
      cCmdAlinhadoDireita = #27+'a2';

type
  TACBrSATExtratoESCPOS = class( TACBrSATExtratoClass )
  private
    FDevice : TACBrDevice ;

    procedure ImprimePorta( AString : AnsiString ) ; 
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirExtrato(CFe : TCFe = nil); virtual;
    procedure ImprimirExtratoResumido(CFe : TCFe = nil); virtual;
    procedure ImprimirExtratoCancelamento(CFe : TCFe = nil); virtual;
  published
    property Device : TACBrDevice read FDevice ;
  end ;

implementation

function Int2TB(AInteger: Integer): AnsiString;
var
   AHexStr: String;
begin
  AHexStr := IntToHex(AInteger,4);
  Result  := AnsiChar(chr( StrToInt('$'+copy(AHexStr,3,2) ) )) +
             AnsiChar(chr( StrToInt('$'+copy(AHexStr,1,2) ) )) ;
  AHexStr := Result;
end;

{ TACBrSATExtratoESCPOS }

constructor TACBrSATExtratoESCPOS.Create(AOwner: TComponent);
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
end;

destructor TACBrSATExtratoESCPOS.Destroy;
begin
  FreeAndNil( FDevice ) ;
  
  inherited Destroy ;
end;

procedure TACBrSATExtratoESCPOS.ImprimePorta(AString: AnsiString);
begin
   FDevice.EnviaString( AString );
end;

procedure TACBrSATExtratoESCPOS.ImprimirExtrato(CFe: TCFe);
var
  LinhaCmd, qrcode : String;
  Buffer : TStringList;
  i : integer;
begin
  Buffer := TStringList.Create;
  try
     LinhaCmd := cCmdImpZera+cCmdPagCod+cCmdFonteNormal+cCmdAlinhadoCentro;
     Buffer.Add(LinhaCmd);  // Comando de Inicialização da Impressora
     Buffer.Add(chr(29)+'(L'+chr(6)+chr(0)+'0E  '+chr(1)+chr(1)); // Imprimindo logo já gravado na memória

     //Cabeçalho
     LinhaCmd := cCmdAlinhadoCentro+cCmdImpNegrito+CFe.Emit.xFant+cCmdImpFimNegrito;
     Buffer.Add(LinhaCmd);
     Buffer.Add(CFe.Emit.xNome);
     Buffer.Add(Trim(CFe.Emit.EnderEmit.xLgr)+' '+
                       Trim(CFe.Emit.EnderEmit.nro)+' '+
                       Trim(CFe.Emit.EnderEmit.xCpl)+' '+
                       Trim(CFe.Emit.EnderEmit.xBairro)+'-'+
                       Trim(CFe.Emit.EnderEmit.xMun)+'-'+
                       DFeUtil.FormatarCEP(IntToStr(CFe.Emit.EnderEmit.CEP)));

     LinhaCmd := cCmdAlinhadoEsquerda+cCmdFontePequena+
                 'CNPJ:'+DFeUtil.FormatarCNPJ(CFe.Emit.CNPJCPF)+
                 ' IE:'+Trim(CFe.Emit.IE)+
                 ' IM:'+Trim(CFe.Emit.IM);
     Buffer.Add(LinhaCmd);

      //Corpo do Extrato
     LinhaCmd := cCmdFonteNormal+cCmdAlinhadoCentro+cCmdImpNegrito+
                 'Extrato '+IntToStrZero(CFe.ide.nCFe,6);
     Buffer.Add(LinhaCmd);
     LinhaCmd := 'CUPOM FISCAL ELETRÔNICO - SAT'+cCmdImpFimNegrito;
     Buffer.Add(LinhaCmd);
     Buffer.Add('------------------------------------------------');
     Buffer.Add('CPF/CNPJ do Consumidor: '+DFeUtil.FormatarCNPJ(CFe.Dest.CNPJCPF));
     Buffer.Add('------------------------------------------------');
     Buffer.Add('#|COD|DESC|QTD|UN|VL UNIT R$|ST|ALIQ|VL ITEM R$');
     Buffer.Add('------------------------------------------------');

     for i:=0 to CFe.Det.Count - 1 do
      begin
        LinhaCmd := cCmdAlinhadoEsquerda+cCmdFontePequena+
                    IntToStrZero(CFe.Det.Items[i].nItem,3)+' '+
                    Trim(CFe.Det.Items[i].Prod.cProd)+' '+
                    Trim(CFe.Det.Items[i].Prod.xProd)+' '+
                    DFeUtil.FormatFloat(CFe.Det.Items[i].Prod.qCom,'0.0000')+' '+
                    Trim(CFe.Det.Items[i].Prod.uCom)+' '+
                    DFeUtil.FormatFloat(CFe.Det.Items[i].Prod.vUnCom,'0.000')+' '+
                    DFeUtil.FormatFloat(CFe.Det.Items[i].Prod.vProd,'0.00')+' ';
        Buffer.Add(LinhaCmd);
      end;


     //Totais
     Buffer.Add(cCmdAlinhadoEsquerda+cCmdFonteNormal+padS('Subtotal|'+FormatFloat('#,###,##0.00',CFe.Total.ICMSTot.vProd),48, '|'));
     Buffer.Add(padS('Descontos|'+FormatFloat('-#,###,##0.00',CFe.Total.ICMSTot.vDesc),48, '|'));
     Buffer.Add(padS('Acréscimos|'+FormatFloat('+#,###,##0.00',CFe.Total.ICMSTot.vOutro),48, '|'));
     LinhaCmd := cCmdAlinhadoEsquerda+cCmdImpNegrito+
                 padS('TOTAL R$|'+FormatFloat('#,###,##0.00',CFe.Total.vCFe),48, '|')+
                 cCmdImpFimNegrito;
     Buffer.Add(LinhaCmd);

     //Pagamentos

     //Destinatário
     Buffer.Add('------------------------------------------------');
     Buffer.Add('DEST');
     Buffer.Add(CFe.Dest.xNome);
     Buffer.Add(Trim(CFe.Entrega.xLgr)+' '+
                       Trim(CFe.Entrega.nro)+' '+
                       Trim(CFe.Entrega.xCpl)+' '+
                       Trim(CFe.Entrega.xBairro)+' '+
                       Trim(CFe.Entrega.xMun));

      //Rodapé
     Buffer.Add('------------------------------------------------');
     LinhaCmd := cCmdAlinhadoCentro+'SAT No. '+
                 cCmdImpNegrito+IntToStr(CFe.ide.nserieSAT)+cCmdImpFimNegrito;
     Buffer.Add(LinhaCmd);
     Buffer.Add(DFeUtil.FormatDate(DateToStr(CFe.ide.dEmi))+' '+TimeToStr(CFe.ide.hEmi));
     LinhaCmd :=  cCmdFontePequena+DFeUtil.FormatarChaveAcesso((CFe.infCFe.ID))+cCmdFonteNormal;
     Buffer.Add(LinhaCmd);


     LinhaCmd := chr(29)+'h'+chr(100)+
                 chr(29)+'w'+chr(2)+
                 chr(29)+'H0'+
                 chr(29)+'kI'+chr(24)+'{C'+AscToBcd(CFe.infCFe.ID,22);
     Buffer.Add(LinhaCmd);
     Buffer.Add('');

     qrcode := CFe.infCFe.ID + '|';
     qrcode := qrcode + FormatDateTime('yyyymmddhhmmss',CFe.ide.dEmi+CFe.ide.hEmi) + '|';
     qrcode := qrcode + DFeUtil.FormatFloat(CFe.Total.vCFe,'0.00') + '|';
     qrcode := qrcode + Trim(CFe.Dest.CNPJCPF) + '|';
     qrcode := qrcode + CFe.ide.assinaturaQRCODE;
     LinhaCmd := chr(29)+'(k'+chr(4)+chr(0)+'1A2'+chr(0)+
                 chr(29)+'(k'+chr(3)+chr(0)+'1C'+chr(6)+
                 chr(29)+'(k'+chr(3)+chr(0)+'1E0'+
                 chr(29)+'(k'+Int2TB(length(qrcode)+3)+'1P0'+qrcode+
                 chr(29)+'(k'+chr(3)+chr(0)+'1Q0';
     Buffer.Add(LinhaCmd);                 
     Buffer.Add('');
     Buffer.Add('');
     Buffer.Add('');
     Buffer.Add('');

     Buffer.Add(chr(29)+'V1');  //Corte de Papel   }

     ImprimePorta(Buffer.Text);
  finally
    Buffer.Free;
  end;
end;

procedure TACBrSATExtratoESCPOS.ImprimirExtratoCancelamento(CFe: TCFe);
begin

end;

procedure TACBrSATExtratoESCPOS.ImprimirExtratoResumido(CFe: TCFe);
begin

end;

end.
