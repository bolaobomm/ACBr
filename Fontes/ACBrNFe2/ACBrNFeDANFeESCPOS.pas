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
|* 20/11/2014:  Welkson Renny de Medeiros
|*   Contribuições para impressão na Bematech e Daruma
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

type
  TACBrNFeMarcaImpressora = (iEpson, iBematech, iDaruma);

  TACBrNFeDANFeESCPOS = class( TACBrNFeDANFEClass )
  private
    FDevice : TACBrDevice ;
    FMarcaImpressora: TACBrNFeMarcaImpressora;
    FLinhasEntreCupons : Integer ;
    FLinhaCmd : AnsiString;
    FBuffer : TStringList;

    cCmdImpZera : String;
    cCmdEspacoLinha : String;
    cCmdPagCod : String;
    cCmdImpNegrito : String;
    cCmdImpFimNegrito : String;
    cCmdImpExpandido : String;
    cCmdImpFimExpandido : String;
    cCmdFonteNormal : String;
    cCmdFontePequena : String;
    cCmdAlinhadoEsquerda : String;
    cCmdAlinhadoCentro : String;
    cCmdAlinhadoDireita : String;
    cCmdCortaPapel : String;
    cCmdImprimeLogo : String;

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
    procedure PulaLinhas( NumLinhas : Integer = 0 );
    function  ParseTextESCPOS( Text: AnsiString ): AnsiString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFE(NFE : TNFe = nil); override ;
    procedure ImprimirDANFEResumido(NFE : TNFe = nil); override ;
  published
    property Device : TACBrDevice read FDevice ;
    property MarcaImpressora: TACBrNFeMarcaImpressora read FMarcaImpressora write FMarcaImpressora default iEpson ;
    property LinhasEntreCupons : Integer read FLinhasEntreCupons write FLinhasEntreCupons default 21 ;
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

function TACBrNFeDANFeESCPOS.ParseTextESCPOS( Text: AnsiString ): AnsiString;
begin
  //codifica linhas de texto com UTF-8 para evitar erros de acentuação na Bematech
  if MarcaImpressora = iBematech then
      Result := UTF8Encode(Text)
  else
      Result := Text;    
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
  FMarcaImpressora := iEpson;
  FLinhasEntreCupons := 21; 
end;

destructor TACBrNFeDANFeESCPOS.Destroy;
begin
  FBuffer.Free;

  FreeAndNil( FDevice ) ;
  
  inherited Destroy ;
end;

procedure TACBrNFeDANFeESCPOS.GerarCabecalho;
begin
  if MarcaImpressora = iBematech then
   begin
     cCmdImpZera     := #27+'@'+#29#249#32#48 ; //#27+'@' Inicializa impressora, demais selecionam ESC/Bema temporariamente
     cCmdEspacoLinha := #27+'3'+#14;  //Verificar comando BEMA/POS
     cCmdPagCod      := #27+'t'+#8;   //codepage UTF-8
     cCmdImpNegrito  := #27#78#3;
     cCmdImpFimNegrito := #27#78#2;
     cCmdImpExpandido  := #27#87#1;
     cCmdImpFimExpandido := #27#87#0;
     cCmdFonteNormal   := #18;
     cCmdFontePequena  := #15;
     cCmdAlinhadoEsquerda := #27+'a0';
     cCmdAlinhadoCentro   := #27+'a1';
     cCmdAlinhadoDireita  := #27+'a2'; //Verificar comando BEMA/POS
     cCmdCortaPapel       := #27+'w'+#29#249#31#49; //#27+'w' corta papel, demais voltam a configuração da impressora
     cCmdImprimeLogo      := '';
   end
  else if MarcaImpressora = iDaruma then
   begin
     cCmdImpZera     := #27+'@';
     cCmdEspacoLinha := #27+'2';
     cCmdPagCod      := '';      //pelo aplicativo da Daruma (Tool) selecione ISO 8859-1 (TODO: tentar implementar essa mudança via código)  
     cCmdImpNegrito  := #27#69;
     cCmdImpFimNegrito := #27#70;
     cCmdImpExpandido  := #27 + 'W' + #1;
     cCmdImpFimExpandido := #27 + 'W' + #0;
     cCmdFonteNormal   := #20;
     cCmdFontePequena  := #15;
     cCmdAlinhadoEsquerda := #27#106#0;
     cCmdAlinhadoCentro   := #27#106#1;
     cCmdAlinhadoDireita  := #27#106#2;
     cCmdCortaPapel       := #27#109;
     cCmdImprimeLogo      := '';
   end
  else
   begin
      cCmdImpZera     := #27+'@';
      cCmdEspacoLinha := #27+'3'+#14;
      cCmdPagCod      := #27+'t'+#39;
      cCmdImpNegrito  := #27+'E1';
      cCmdImpFimNegrito := #27+'E2';
      cCmdImpExpandido  := #29+'!'+#16;
      cCmdImpFimExpandido := #29+'!'+#0;
      cCmdFonteNormal   := #27+'M0';
      cCmdFontePequena  := #27+'M1';
      cCmdAlinhadoEsquerda := #27+'a0';
      cCmdAlinhadoCentro   := #27+'a1';
      cCmdAlinhadoDireita  := #27+'a2';
      cCmdCortaPapel       := #29+'V1';
      cCmdImprimeLogo      := #29+'(L'#6#0+'0E  '+#1#1;
   end;

  FBuffer.clear;
  FLinhaCmd := cCmdImpZera+cCmdEspacoLinha+cCmdPagCod+cCmdFonteNormal+cCmdAlinhadoCentro;
  FBuffer.Add(FLinhaCmd+cCmdImprimeLogo); // Imprimindo logo já gravado na memória

//  FLinhaCmd := cCmdAlinhadoCentro+cCmdImpNegrito+FpCFe.Emit.xFant+cCmdImpFimNegrito;
//  FBuffer.Add(FLinhaCmd);
  FBuffer.Add(cCmdImpNegrito+FpNFe.Emit.xNome+cCmdImpFimNegrito);
  FLinhaCmd := cCmdImpNegrito+cCmdFontePequena+
              ParseTextESCPOS('CNPJ:'+DFeUtil.FormatarCNPJ(FpNFe.Emit.CNPJCPF)+'   '+
              'Inscrição Estadual:'+Trim(FpNFe.Emit.IE))+cCmdImpFimNegrito;
  FBuffer.Add(FLinhaCmd);

  FBuffer.Add(cCmdFontePequena+ParseTextESCPOS(Trim(FpNFe.Emit.EnderEmit.xLgr)+' '+
              Trim(FpNFe.Emit.EnderEmit.nro)+' '+
              Trim(FpNFe.Emit.EnderEmit.xCpl)+' '+
              Trim(FpNFe.Emit.EnderEmit.xBairro)+'-'+
              Trim(FpNFe.Emit.EnderEmit.xMun)));


  FBuffer.Add(cCmdAlinhadoEsquerda+cCmdFonteNormal+'------------------------------------------------');

  FLinhaCmd := cCmdFonteNormal+cCmdAlinhadoCentro+cCmdImpNegrito+
                 ParseTextESCPOS('DANFE NFC-e - Documento Auxiliar');
  FBuffer.Add(FLinhaCmd);
  FLinhaCmd := ParseTextESCPOS('da Nota Fiscal Eletrônica para Consumidor Final');
  FBuffer.Add(FLinhaCmd);
  FLinhaCmd := ParseTextESCPOS('Não permite aproveitamento de crédito de ICMS')+cCmdImpFimNegrito;
  FBuffer.Add(FLinhaCmd);
end;

procedure TACBrNFeDANFeESCPOS.GerarItens;
var
  i : integer;
begin
  FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
  FBuffer.Add(ParseTextESCPOS('#|COD|DESCRIÇÃO|QTD|UN|VL UN R$|VL TOTAL R$'));
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

     FLinhaCmd := ParseTextESCPOS(padS(FLinhaCmd,64, '|'));

     FBuffer.Add(cCmdAlinhadoEsquerda+cCmdFontePequena+FLinhaCmd);

     if FpNFe.Det.Items[i].Prod.vDesc > 0 then
      begin
        FBuffer.Add(ParseTextESCPOS(padS('desconto|'+FormatFloat('-#,###,##0.00',FpNFe.Det.Items[i].Prod.vDesc),64, '|')));
        FBuffer.Add(ParseTextESCPOS(padS(('valor líquido|')+FormatFloat('#,###,##0.00',(FpNFe.Det.Items[i].Prod.qCom*FpNFe.Det.Items[i].Prod.vUnCom)-FpNFe.Det.Items[i].Prod.vDesc),64, '|')));
      end;

     if FpNFe.Det.Items[i].Prod.vOutro > 0 then
      begin
        FBuffer.Add(ParseTextESCPOS(padS('outros|'+FormatFloat('-#,###,##0.00',FpNFe.Det.Items[i].Prod.vOutro),64, '|')));
        FBuffer.Add(ParseTextESCPOS(padS(('valor líquido|')+FormatFloat('#,###,##0.00',(FpNFe.Det.Items[i].Prod.qCom*FpNFe.Det.Items[i].Prod.vUnCom)+FpNFe.Det.Items[i].Prod.vOutro),64, '|')));
      end;
   end;
  FBuffer.Add(cCmdAlinhadoEsquerda+cCmdFonteNormal);
end;

procedure TACBrNFeDANFeESCPOS.GerarTotais(Resumido: Boolean);
begin
  FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
  FBuffer.Add(cCmdFontePequena+ParseTextESCPOS(padS('QTD. TOTAL DE ITENS|'+IntToStrZero(FpNFe.Det.Count,3),64, '|')));
  if not Resumido then
   begin
     if (FpNFe.Total.ICMSTot.vDesc > 0) or (FpNFe.Total.ICMSTot.vOutro > 0) then
        FBuffer.Add(cCmdFontePequena+ParseTextESCPOS(padS('Subtotal|'+FormatFloat('#,###,##0.00',FpNFe.Total.ICMSTot.vProd),64, '|')));
     if FpNFe.Total.ICMSTot.vDesc > 0 then
        FBuffer.Add(cCmdFontePequena+ParseTextESCPOS(padS('Descontos|'+FormatFloat('-#,###,##0.00',FpNFe.Total.ICMSTot.vDesc),64, '|')));
     if FpNFe.Total.ICMSTot.vOutro > 0 then
        FBuffer.Add(cCmdFontePequena+ParseTextESCPOS(padS(('Acréscimos|')+FormatFloat('+#,###,##0.00',FpNFe.Total.ICMSTot.vOutro),64, '|')));
   end;

  FLinhaCmd := cCmdAlinhadoEsquerda+cCmdImpExpandido+
               ParseTextESCPOS(padS('TOTAL R$|'+FormatFloat('#,###,##0.00',FpNFe.Total.ICMSTot.vNF),32, '|'))+
               cCmdImpFimExpandido;
  FBuffer.Add(FLinhaCmd);
end;

procedure TACBrNFeDANFeESCPOS.GerarPagamentos(Resumido : Boolean = False );
var
  i : integer;
  Total, Troco : Real;
begin
  Total := 0;
  FBuffer.Add(cCmdFontePequena+ParseTextESCPOS(padS('FORMA DE PAGAMENTO '+'|'+' Valor Pago',64, '|')));
  for i:=0 to FpNFe.pag.Count - 1 do
   begin
     FBuffer.Add(cCmdFontePequena+ParseTextESCPOS(padS(FormaPagamentoToDescricao(FpNFe.pag.Items[i].tPag)+'|'+FormatFloat('#,###,##0.00',FpNFe.pag.Items[i].vPag),64, '|')));
     Total := Total + FpNFe.pag.Items[i].vPag;
   end;

  Troco := Total - FpNFe.Total.ICMSTot.vNF;
  if Troco > 0 then
     FBuffer.Add(cCmdFontePequena+ParseTextESCPOS(padS('Troco R$|'+FormatFloat('#,###,##0.00',Troco),64, '|')));
  FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
end;

procedure TACBrNFeDANFeESCPOS.GerarTotTrib;
begin
  if FpNFe.Total.ICMSTot.vTotTrib > 0 then
   begin
     FBuffer.Add(cCmdFontePequena+ParseTextESCPOS(padS('Informação dos Tributos Totais Incidentes |'+cCmdImpNegrito+FormatFloat('#,###,##0.00',FpNFe.Total.ICMSTot.vTotTrib),66, '|')));
     FBuffer.Add(cCmdImpFimNegrito+ParseTextESCPOS('(Lei Federal 12.741/2012)'));
     FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
   end;
end;

procedure TACBrNFeDANFeESCPOS.GerarObsFisco;
begin
  if FpNFe.ide.tpAmb = taHomologacao then
   begin
     FLinhaCmd := cCmdFontePequena+cCmdAlinhadoCentro+cCmdImpNegrito+
                 ParseTextESCPOS('EMITIDA EM AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL');
   end
  else
   begin
     if FpNFe.Ide.tpEmis <> teNormal then
        FLinhaCmd := cCmdFonteNormal+cCmdAlinhadoCentro+cCmdImpNegrito+
                 ParseTextESCPOS('EMITIDA EM CONTINGÊNCIA')
     else
        FLinhaCmd := cCmdFonteNormal+cCmdAlinhadoCentro+cCmdImpNegrito+
                 ParseTextESCPOS('ÁREA DE MENSAGEM FISCAL');
   end;

  FBuffer.Add(FLinhaCmd);

  FLinhaCmd := cCmdImpFimNegrito+cCmdFontePequena+cCmdAlinhadoCentro+
               ParseTextESCPOS('Número '+IntToStrZero(FpNFe.Ide.nNF,9)+
               ' Série '+IntToStrZero(FpNFe.Ide.serie,3)+
               ' Emissão '+DateTimeToStr(FpNFe.ide.dEmi)) ;
  FBuffer.Add(FLinhaCmd);
  FBuffer.Add(cCmdAlinhadoCentro+cCmdFontePequena+ParseTextESCPOS('Consulte pela Chave de Acesso em ')+NotaUtil.GetURLConsultaNFCe(FpNFe.Ide.cUF,FpNFe.ide.tpAmb));
  FBuffer.Add(cCmdAlinhadoCentro+cCmdFonteNormal+ParseTextESCPOS('CHAVE DE ACESSO'));
  FLinhaCmd :=  cCmdAlinhadoCentro+cCmdFontePequena+DFeUtil.FormatarChaveAcesso(OnlyNumber(FpNFe.infNFe.ID))+cCmdFonteNormal;
  FBuffer.Add(FLinhaCmd);

  FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
end;

procedure TACBrNFeDANFeESCPOS.GerarDadosConsumidor;
begin
  FLinhaCmd := cCmdFonteNormal+cCmdAlinhadoCentro+cCmdImpNegrito+
               ParseTextESCPOS('CONSUMIDOR')+cCmdImpFimNegrito;
  FBuffer.Add(FLinhaCmd);

  FLinhaCmd := ParseTextESCPOS('CNPJ/CPF/ID Estrangeiro -');

  if (FpNFe.Dest.idEstrangeiro = '') and
     (FpNFe.Dest.CNPJCPF = '') then
   begin
      FLinhaCmd := ParseTextESCPOS('CONSUMIDOR NÃO IDENTIFICADO');
   end
  else if FpNFe.Dest.idEstrangeiro <> '' then
   begin
     FLinhaCmd := FLinhaCmd+FpNFe.Dest.idEstrangeiro+' '+FpNFe.Dest.xNome;
   end
  else
   begin
     if Length(trim(FpNFe.Dest.CNPJCPF)) > 11 then
        FLinhaCmd := FLinhaCmd+DFeUtil.FormatarCNPJ(FpNFe.Dest.CNPJCPF)
     else
        FLinhaCmd := FLinhaCmd+DFeUtil.FormatarCPF(FpNFe.Dest.CNPJCPF);

     FLinhaCmd := FLinhaCmd+' '+FpNFe.Dest.xNome;
   end;

  FBuffer.Add(cCmdFontePequena+FLinhaCmd);
  FBuffer.Add(cCmdFontePequena+ParseTextESCPOS(Trim(FpNFe.Dest.EnderDest.xLgr)+' '+
              Trim(FpNFe.Dest.EnderDest.nro)+' '+
              Trim(FpNFe.Dest.EnderDest.xCpl)+' '+
              Trim(FpNFe.Dest.EnderDest.xBairro)+' '+
              Trim(FpNFe.Dest.EnderDest.xMun)));

end;


procedure TACBrNFeDANFeESCPOS.GerarRodape(CortaPapel: Boolean = True; Cancelamento: Boolean = False);
var
  qrcode : string;
  cCaracter : String;
  i, cTam1, cTam2 : Integer;
  bMenos, bMais, iQtdBytes, iLargMod, iNivelCorrecao : Integer;
begin
  FBuffer.Add(cCmdFonteNormal+'------------------------------------------------');
  FLinhaCmd := cCmdAlinhadoCentro+ParseTextESCPOS('Consulta via leitor de QR Code');
  FBuffer.Add(FLinhaCmd);
  FBuffer.Add(' ');

  qrcode := NotaUtil.GetURLQRCode( FpNFe.ide.cUF, FpNFe.ide.tpAmb,
                                   FpNFe.infNFe.ID,
                                   DFeUtil.SeSenao(FpNFe.Dest.idEstrangeiro <> '',FpNFe.Dest.idEstrangeiro, FpNFe.Dest.CNPJCPF),
                                   FpNFe.ide.dEmi,
                                   FpNFe.Total.ICMSTot.vNF, FpNFe.Total.ICMSTot.vICMS,
                                   FpNFe.signature.DigestValue ,
                                   TACBrNFe( ACBrNFe ).Configuracoes.Geral.IdToken,
                                   TACBrNFe( ACBrNFe ).Configuracoes.Geral.Token);


  if MarcaImpressora = iBematech then
   begin
     for i := 1 to length(qrcode) do
      begin
         cCaracter := cCaracter + Chr(Ord(qrcode[i]));
      end;

     if (length(qrcode) > 255) then
      begin
        cTam1 := length(qrcode) mod 255;
        cTam2 := length(qrcode) div 255;
      end
     else
      begin
        cTam1 := length(qrcode);
        cTam2 := 0;
      end;

     FLinhaCmd :=  chr(27) + chr(97) + chr(1) +
                   chr(29) + chr(107) + chr(81) +
                   chr(3) + chr(8) +
                   chr(8) + chr(1) +
                   chr(cTam1) +
                   chr(cTam2) +
                   cCaracter;
   end
  else if MarcaImpressora = iDaruma then
   begin
     iQtdBytes := Length(qrcode);
     iLargMod := 4;
     bMenos := iQtdBytes shr 8;
     bMais := iQtdBytes AND 255 + 2;
     iNivelCorrecao := (Ord('M'));

     FLinhaCmd := #27 + #129 + chr(bMais) + chr(bMenos) + chr(iLargMod) +
                   chr(iNivelCorrecao) + qrcode;
   end
  else
   begin
     FLinhaCmd := chr(29)+'(k'+chr(4)+chr(0)+'1A2'+chr(0)+
                  chr(29)+'(k'+chr(3)+chr(0)+'1C'+chr(4)+
                  chr(29)+'(k'+chr(3)+chr(0)+'1E0'+
                  chr(29)+'(k'+Int2TB(length(qrcode)+3)+'1P0'+qrcode+
                  chr(29)+'(k'+chr(3)+chr(0)+'1Q0';
   end;

  FBuffer.Add(FLinhaCmd);

  FBuffer.Add('');
  FBuffer.Add('');
  FBuffer.Add(cCmdFontePequena+(ParseTextESCPOS('Protocolo de Autorização:')+Trim(FpNFe.procNFe.nProt)+' '+DFeUtil.SeSenao(FpNFe.procNFe.dhRecbto<>0,DateTimeToStr(FpNFe.procNFe.dhRecbto),''))+cCmdFonteNormal);
  PulaLinhas;

  if CortaPapel then
     FBuffer.Add(cCmdCortaPapel);
end;

procedure TACBrNFeDANFeESCPOS.PulaLinhas(NumLinhas: Integer);
var
  i : integer;
begin
  if NumLinhas = 0 then
     NumLinhas := LinhasEntreCupons ;

  for i:=0 to NumLinhas do
   begin
     FBuffer.Add('');
   end
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
        raise Exception.Create(ACBrStr('Componente ACBrNFe não atribuído'));

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
        raise Exception.Create(ACBrStr('Componente ACBrNFe não atribuído'));

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
