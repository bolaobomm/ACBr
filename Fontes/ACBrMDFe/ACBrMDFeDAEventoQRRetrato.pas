{******************************************************************************}
{ Projeto: Componente ACBrMDFe                                                 }
{  Biblioteca multiplataforma de componentes Delphi                            }
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
*******************************************************************************}

{$I ACBr.inc}

unit ACBrMDFeDAEventoQRRetrato;

// Aten��o todos os comiters
// Quando enviar os fontes referentes ao DAEvento favor alterar
// a data e o nome da linha abaixo.
// �ltima libera��o:
// 25/11/2013 por Italo Jurisato Junior

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, XMLIntf, XMLDoc,
  JPEG, ACBrMDFeDAMDFeQRCodeBar, pcnConversao, DB,
  DBClient, ACBrMDFeDAEventoQR;

type
  TfrmDAEventoQRRetrato = class(TfrmDAEventoQR)
    qrb_09_Itens: TQRBand;
    qrdbtTpDoc1: TQRDBText;
    cdsDocumentos: TClientDataSet;
    qrdbtCnpjEmitente1: TQRDBText;
    qrdbtDocumento1: TQRDBText;
    qrdbtDocumento2: TQRDBText;
    qrdbtCnpjEmitente2: TQRDBText;
    qrdbtTpDoc2: TQRDBText;
    cdsDocumentosTIPO_1: TStringField;
    cdsDocumentosCNPJCPF_1: TStringField;
    cdsDocumentosDOCUMENTO_1: TStringField;
    cdsDocumentosTIPO_2: TStringField;
    cdsDocumentosCNPJCPF_2: TStringField;
    cdsDocumentosDOCUMENTO_2: TStringField;
    qrb_01_Titulo: TQRBand;
    qrlProtocolo: TQRLabel;
    qrlOrgao: TQRLabel;
    qrlDescricao: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel78: TQRLabel;
    qrlDescricaoEvento: TQRLabel;
    qrb_08_HeaderItens: TQRBand;
    qrb_10_Sistema: TQRBand;
    qrb_04_Evento: TQRChildBand;
    QRLabel13: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel24: TQRLabel;
    qrlRazaoEmitente: TQRLabel;
    qrlEnderecoEmitente: TQRLabel;
    qrlMunEmitente: TQRLabel;
    qrlCNPJEmitente: TQRLabel;
    QRLabel93: TQRLabel;
    qrlInscEstEmitente: TQRLabel;
    qrlCEPEmitente: TQRLabel;
    QRLabel98: TQRLabel;
    qrb_02_Emitente: TQRChildBand;
    qrb_05_Tomador: TQRChildBand;
    qrb_06_Condicoes: TQRChildBand;
    QRLabel38: TQRLabel;
    QRLabel44: TQRLabel;
    qrmGrupoAlterado: TQRMemo;
    QRLabel46: TQRLabel;
    qrmCampoAlterado: TQRMemo;
    QRLabel42: TQRLabel;
    qrmValorAlterado: TQRMemo;
    QRLabel45: TQRLabel;
    qrmNumItemAlterado: TQRMemo;
    QRShape18: TQRShape;
    QRShape17: TQRShape;
    QRShape15: TQRShape;
    QRShape19: TQRShape;
    QRLabel59: TQRLabel;
    QRShape5: TQRShape;
    qrmCondicoes: TQRMemo;
    qrsQuadro01: TQRShape;
    qrsQuadro02: TQRShape;
    qrsQuadro04: TQRShape;
    qrsQuadro05: TQRShape;
    qrsLinhaV10: TQRShape;
    qrsLinhaV09: TQRShape;
    qrsLinhaH04: TQRShape;
    qrsLinhaV01: TQRShape;
    qrsLinhaH06: TQRShape;
    qrsLinhaH07: TQRShape;
    QRShape10: TQRShape;
    QRLabel65: TQRLabel;
    QRShape2: TQRShape;
    qrb_07_Correcao: TQRChildBand;
    QRShape46: TQRShape;
    qrlLinha3: TQRLabel;
    qrlLinha2: TQRLabel;
    qrlLinha1: TQRLabel;
    qrb_03_Documento: TQRChildBand;
    QRShape81: TQRShape;
    QRShape88: TQRShape;
    qrsQuadro03: TQRShape;
    QRLabel8: TQRLabel;
    qrlModelo: TQRLabel;
    QRLabel21: TQRLabel;
    qrlSerie: TQRLabel;
    QRLabel23: TQRLabel;
    qrlNumMDFe: TQRLabel;
    qrsLinhaV05: TQRShape;
    qrsLinhaV06: TQRShape;
    qrsLinhaV08: TQRShape;
    QRLabel33: TQRLabel;
    qrlEmissao: TQRLabel;
    qrsLinhaV07: TQRShape;
    QRLabel74: TQRLabel;
    qrlChave: TQRLabel;
    qriBarCode: TQRImage;
    qrlTituloEvento: TQRLabel;
    QRShape48: TQRShape;
    QRLabel9: TQRLabel;
    qrlTipoAmbiente: TQRLabel;
    QRLabel6: TQRLabel;
    qrlEmissaoEvento: TQRLabel;
    QRLabel28: TQRLabel;
    qrlTipoEvento: TQRLabel;
    QRLabel17: TQRLabel;
    qrlSeqEvento: TQRLabel;
    QRShape49: TQRShape;
    QRShape50: TQRShape;
    QRLabel18: TQRLabel;
    qrlStatus: TQRLabel;
    QRLabel12: TQRLabel;
    QRShape51: TQRShape;
    QRLabel1: TQRLabel;
    QRShape52: TQRShape;
    QRShape53: TQRShape;
    QRShape82: TQRShape;
    QRShape99: TQRShape;
    QRLabel4: TQRLabel;
    qrlBairroEmitente: TQRLabel;
    QRShape108: TQRShape;
    QRLabel5: TQRLabel;
    qrlFoneEmitente: TQRLabel;
    QRShape109: TQRShape;
    QRLabel14: TQRLabel;
    qrlRazaoTomador: TQRLabel;
    QRLabel25: TQRLabel;
    qrlEnderecoTomador: TQRLabel;
    QRLabel27: TQRLabel;
    qrlMunTomador: TQRLabel;
    QRLabel30: TQRLabel;
    qrlCNPJTomador: TQRLabel;
    QRLabel32: TQRLabel;
    qrlBairroTomador: TQRLabel;
    QRLabel35: TQRLabel;
    qrlCEPTomador: TQRLabel;
    QRLabel37: TQRLabel;
    qrlFoneTomador: TQRLabel;
    QRLabel40: TQRLabel;
    qrlInscEstTomador: TQRLabel;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape55: TQRShape;
    QRShape56: TQRShape;
    QRShape58: TQRShape;
    QRShape59: TQRShape;
    qrlMsgTeste: TQRLabel;
    QRLabel15: TQRLabel;
    QRSysData1: TQRSysData;
    qrlblSistema: TQRLabel;
    procedure QREventoBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure qrb_01_TituloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_03_DocumentoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_04_EventoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_02_EmitenteBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_05_TomadorBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_06_CondicoesBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_07_CorrecaoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_08_HeaderItensBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_09_ItensBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure qrb_10_SistemaBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    procedure Itens;
  public
    procedure ProtocoloMDFe(const sProtocolo: string);
  end;

implementation

uses
  StrUtils, DateUtils,
  ACBrDFeUtil, ACBrMDFeUtil;

{$R *.dfm}

var
  FProtocoloMDFe : string;

procedure TfrmDAEventoQRRetrato.Itens;
begin
 // Itens
end;

procedure TfrmDAEventoQRRetrato.ProtocoloMDFe(const sProtocolo: string);
begin
  FProtocoloMDFe := sProtocolo;
end;

procedure TfrmDAEventoQRRetrato.QREventoBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  inherited;

  Itens;

  QREvento.ReportTitle:='Evento: ' + FormatFloat( '000,000,000', FEventoMDFe.InfEvento.nSeqEvento );

  QREvento.Page.TopMargin    := FMargemSuperior * 100;
  QREvento.Page.BottomMargin := FMargemInferior * 100;
  QREvento.Page.LeftMargin   := FMargemEsquerda * 100;
  QREvento.Page.RightMargin  := FMargemDireita  * 100;
end;

procedure TfrmDAEventoQRRetrato.qrb_01_TituloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;

//  TpcnTpEvento = (teCCe, teCancelamento, teManifDestConfirmacao, teManifDestCiencia,
//                  teManifDestDesconhecimento, teManifDestOperNaoRealizada,
//                  teEncerramento, teEPEC, teInclusaoCondutor, teMultiModal);
  case FEventoMDFe.InfEvento.tpEvento of
   teEncerramento: begin
                    qrlLinha1.Caption := 'ENCERRAMENTO';
                    qrlLinha2.Caption := 'N�o possui valor fiscal, simples representa��o do Encerramento indicado abaixo.';
                    qrlLinha3.Caption := 'CONSULTE A AUTENTICIDADE DO ENCERRAMENTO NO SITE DA SEFAZ AUTORIZADORA.';
                   end;
   teCancelamento: begin
                    qrlLinha1.Caption := 'CANCELAMENTO';
                    qrlLinha2.Caption := 'N�o possui valor fiscal, simples representa��o do Cancelamento indicado abaixo.';
                    qrlLinha3.Caption := 'CONSULTE A AUTENTICIDADE DO CANCELAMENTO NO SITE DA SEFAZ AUTORIZADORA.';
                   end;
  end;
end;

procedure TfrmDAEventoQRRetrato.qrb_03_DocumentoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;

  PrintBand := False;

  if FMDFe <> nil
   then begin
    PrintBand := True;

    qrlModelo.Caption  := FMDFe.ide.modelo;
    qrlSerie.Caption   := IntToStr(FMDFe.ide.serie);
    qrlNumMDFe.Caption  := FormatFloat( '000,000,000', FMDFe.Ide.nMDF );
    qrlEmissao.Caption := DFeUtil.FormatDateTime(DateTimeToStr(FMDFe.Ide.dhEmi));
    SetBarCodeImage(Copy(FMDFe.InfMDFe.Id, 5, 44), qriBarCode);
    qrlChave.Caption := MDFeUtil.FormatarChaveAcesso(Copy(FMDFe.InfMDFe.Id, 5, 44));
   end;
end;

procedure TfrmDAEventoQRRetrato.qrb_04_EventoBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;

  with FEventoMDFe do
    begin
      case InfEvento.tpEvento of
       teEncerramento: qrlTituloEvento.Caption := 'ENCERRAMENTO';
       teCancelamento: qrlTituloEvento.Caption := 'CANCELAMENTO';
      end;

      qrlOrgao.Caption := IntToStr(InfEvento.cOrgao);
      case InfEvento.tpAmb of
       taProducao:    qrlTipoAmbiente.Caption := 'PRODU��O';
       taHomologacao: qrlTipoAmbiente.Caption := 'HOMOLOGA��O - SEM VALOR FISCAL';
      end;
      qrlEmissaoEvento.Caption   := DFeUtil.FormatDateTime(DateTimeToStr(InfEvento.dhEvento));
      qrlTipoEvento.Caption      := InfEvento.TipoEvento;
      qrlDescricaoEvento.Caption := InfEvento.DescEvento;
      qrlSeqEvento.Caption       := IntToStr(InfEvento.nSeqEvento);
      qrlStatus.Caption          := IntToStr(RetInfEvento.cStat) + ' - ' +
                                    RetInfEvento.xMotivo;
      qrlProtocolo.Caption       := RetInfEvento.nProt + ' ' +
                                    DFeUtil.FormatDateTime(DateTimeToStr(RetInfEvento.dhRegEvento));
    end;
end;

procedure TfrmDAEventoQRRetrato.qrb_02_EmitenteBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;

  PrintBand := False;

  if FMDFe <> nil
   then begin
    PrintBand := True;

    qrlRazaoEmitente.Caption    := FMDFe.emit.xNome;
    qrlCNPJEmitente.Caption     := DFeUtil.FormatarCNPJCPF(FMDFe.emit.CNPJ);
    qrlEnderecoEmitente.Caption := FMDFe.emit.EnderEmit.xLgr + ', ' + FMDFe.emit.EnderEmit.nro;
    qrlBairroEmitente.Caption   := FMDFe.emit.EnderEmit.xBairro;
    qrlCEPEmitente.Caption      := DFeUtil.FormatarCEP(FormatFloat( '00000000', FMDFe.emit.EnderEmit.CEP ));
    qrlMunEmitente.Caption      := FMDFe.emit.EnderEmit.xMun+' - '+FMDFe.emit.EnderEmit.UF;
    qrlFoneEmitente.Caption     := DFeUtil.FormatarFone(FMDFe.emit.enderEmit.fone);
    qrlInscEstEmitente.Caption  := FMDFe.emit.IE;
   end;
end;

procedure TfrmDAEventoQRRetrato.qrb_05_TomadorBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;

  PrintBand := False;

  if FMDFe <> nil
   then begin
    (*
    PrintBand := True;
    if FMDFe.Ide.Toma4.xNome = ''
     then begin
      case FMDFe.Ide.Toma03.Toma of
      tmRemetente:
        begin
          qrlRazaoTomador.Caption    := FMDFe.Rem.xNome;
          qrlCNPJTomador.Caption     := DFeUtil.FormatarCNPJCPF(FMDFe.Rem.CNPJCPF);
          qrlEnderecoTomador.Caption := FMDFe.Rem.EnderReme.xLgr + ', ' + FMDFe.Rem.EnderReme.nro;
          qrlBairroTomador.Caption   := FMDFe.Rem.EnderReme.xBairro;
          qrlCEPTomador.Caption      := DFeUtil.FormatarCEP(FormatFloat( '00000000', FMDFe.Rem.EnderReme.CEP));
          qrlMunTomador.Caption      := FMDFe.Rem.EnderReme.xMun+' - '+FMDFe.Rem.EnderReme.UF;
          qrlFoneTomador.Caption     := DFeUtil.FormatarFone(FMDFe.Rem.fone);
          qrlInscEstTomador.Caption  := FMDFe.Rem.IE;
        end;
      tmExpedidor:
        begin
          qrlRazaoTomador.Caption    := FMDFe.Exped.xNome;
          qrlCNPJTomador.Caption     := DFeUtil.FormatarCNPJCPF(FMDFe.Exped.CNPJCPF);
          qrlEnderecoTomador.Caption := FMDFe.Exped.EnderExped.xLgr + ', ' + FMDFe.Exped.EnderExped.nro;
          qrlBairroTomador.Caption   := FMDFe.Exped.EnderExped.xBairro;
          qrlCEPTomador.Caption      := DFeUtil.FormatarCEP(FormatFloat( '00000000', FMDFe.Exped.EnderExped.CEP));
          qrlMunTomador.Caption      := FMDFe.Exped.EnderExped.xMun+' - '+FMDFe.Exped.EnderExped.UF;
          qrlFoneTomador.Caption     := DFeUtil.FormatarFone(FMDFe.Exped.fone);
          qrlInscEstTomador.Caption  := FMDFe.Exped.IE;
        end;
      tmRecebedor:
        begin
          qrlRazaoTomador.Caption    := FMDFe.Receb.xNome;
          qrlCNPJTomador.Caption     := DFeUtil.FormatarCNPJCPF(FMDFe.Receb.CNPJCPF);
          qrlEnderecoTomador.Caption := FMDFe.Receb.EnderReceb.xLgr + ', ' + FMDFe.Receb.EnderReceb.nro;
          qrlBairroTomador.Caption   := FMDFe.Receb.EnderReceb.xBairro;
          qrlCEPTomador.Caption      := DFeUtil.FormatarCEP(FormatFloat( '00000000', FMDFe.Receb.EnderReceb.CEP));
          qrlMunTomador.Caption      := FMDFe.Receb.EnderReceb.xMun+' - '+FMDFe.Receb.EnderReceb.UF;
          qrlFoneTomador.Caption     := DFeUtil.FormatarFone(FMDFe.Receb.fone);
          qrlInscEstTomador.Caption  := FMDFe.Receb.IE;
        end;
      tmDestinatario:
        begin
          qrlRazaoTomador.Caption    := FMDFe.Dest.xNome;
          qrlCNPJTomador.Caption     := DFeUtil.FormatarCNPJCPF(FMDFe.Dest.CNPJCPF);
          qrlEnderecoTomador.Caption := FMDFe.Dest.EnderDest.xLgr + ', ' + FMDFe.Dest.EnderDest.nro;
          qrlBairroTomador.Caption   := FMDFe.Dest.EnderDest.xBairro;
          qrlCEPTomador.Caption      := DFeUtil.FormatarCEP(FormatFloat( '00000000', FMDFe.Dest.EnderDest.CEP));
          qrlMunTomador.Caption      := FMDFe.Dest.EnderDest.xMun+' - '+FMDFe.Dest.EnderDest.UF;
          qrlFoneTomador.Caption     := DFeUtil.FormatarFone(FMDFe.Dest.fone);
          qrlInscEstTomador.Caption  := FMDFe.Dest.IE;
        end;
      end;
     end
     else begin
      qrlRazaoTomador.Caption    := FMDFe.Ide.Toma4.xNome;
      qrlCNPJTomador.Caption     := DFeUtil.FormatarCNPJCPF(FMDFe.Ide.Toma4.CNPJCPF);
      qrlEnderecoTomador.Caption := FMDFe.Ide.Toma4.EnderToma.xLgr + ', ' + FMDFe.Ide.Toma4.EnderToma.nro;
      qrlBairroTomador.Caption   := FMDFe.Ide.Toma4.EnderToma.xBairro;
      qrlCEPTomador.Caption      := DFeUtil.FormatarCEP(FormatFloat( '00000000', FMDFe.Ide.Toma4.EnderToma.CEP));
      qrlMunTomador.Caption      := FMDFe.Ide.Toma4.EnderToma.xMun+' - '+FMDFe.Ide.Toma4.EnderToma.UF;
      qrlFoneTomador.Caption     := DFeUtil.FormatarFone(FMDFe.Ide.Toma4.fone);
      qrlInscEstTomador.Caption  := FMDFe.Ide.Toma4.IE;
     end;
   *)  
   end;
end;

procedure TfrmDAEventoQRRetrato.qrb_06_CondicoesBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
 i: Integer;
begin
  inherited;

  PrintBand := (FEventoMDFe.InfEvento.tpEvento = teCCe) or (FEventoMDFe.InfEvento.tpAmb = taHomologacao);

  qrlMsgTeste.Visible := False;
  qrlMsgTeste.Enabled := False;

  if FEventoMDFe.InfEvento.tpAmb = taHomologacao then
   begin
    qrlMsgTeste.Caption := 'AMBIENTE DE HOMOLOGA��O - SEM VALOR FISCAL';
    qrlMsgTeste.Visible := True;
    qrlMsgTeste.Enabled := True;
   end;

  qrmCondicoes.Visible := (FEventoMDFe.InfEvento.tpEvento = teCCe);
  qrmCondicoes.Enabled := (FEventoMDFe.InfEvento.tpEvento = teCCe);
  qrmCondicoes.Lines.Clear;
  qrmCondicoes.Lines.Add('A Carta de Correcao e disciplinada pelo Art. 58-B do CONVENIO/SINIEF 06/89: Fica permitida a utilizacao de carta de correcao, para regularizacao');
  qrmCondicoes.Lines.Add('de erro ocorrido na emissao de documentos fiscais relativos a prestacao de servico de transporte, desde que o erro nao esteja relacionado com:');
  qrmCondicoes.Lines.Add('I - as variaveis que determinam o valor do imposto tais como: base de calculo, aliquota, diferenca de preco, quantidade, valor da prestacao;');
  qrmCondicoes.Lines.Add('II - a correcao de dados cadastrais que implique mudanca do emitente, tomador, remetente ou do destinatario;');
  qrmCondicoes.Lines.Add('III - a data de emissao ou de saida.');
end;

procedure TfrmDAEventoQRRetrato.qrb_07_CorrecaoBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
var
 i: Integer;
begin
  inherited;

  PrintBand := FEventoMDFe.InfEvento.tpEvento = teCCe;
  (*
  qrmNumItemAlterado.Lines.Clear;
  qrmGrupoAlterado.Lines.Clear;
  qrmCampoAlterado.Lines.Clear;
  qrmValorAlterado.Lines.Clear;

  for i := 0 to (FEventoMDFe.InfEvento.detEvento.infCorrecao.Count -1) do
   begin
    qrmNumItemAlterado.Lines.Add(IntToStr(FEventoMDFe.InfEvento.detEvento.infCorrecao[i].nroItemAlterado));
    qrmGrupoAlterado.Lines.Add(FEventoMDFe.InfEvento.detEvento.infCorrecao[i].grupoAlterado);
    qrmCampoAlterado.Lines.Add(FEventoMDFe.InfEvento.detEvento.infCorrecao[i].campoAlterado);
    qrmValorAlterado.Lines.Add(FEventoMDFe.InfEvento.detEvento.infCorrecao[i].valorAlterado);
   end;
 *)  
end;

procedure TfrmDAEventoQRRetrato.qrb_08_HeaderItensBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  // Imprime os Documentos Origin�rios se o Tipo de MDFe for Normal
end;

procedure TfrmDAEventoQRRetrato.qrb_09_ItensBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  i : integer;
begin
  inherited;

  qrb_09_Itens.Enabled := True;
  (*
  for i := 1 to 2 do
    if Trim(cdsDocumentos.FieldByName('DOCUMENTO_' + IntToStr(i)).AsString) = '' then
      TQRDBText(FindComponent('qrdbtCnpjEmitente' + intToStr(i))).Width := 325
    else
      TQRDBText(FindComponent('qrdbtCnpjEmitente' + intToStr(i))).Width := 128;
  *)
end;

procedure TfrmDAEventoQRRetrato.qrb_10_SistemaBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;

  qrlblSistema.Caption := FSistema + ' - ' + FUsuario;
end;

end.

