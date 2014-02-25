{$I ACBr.inc}

unit Unit1 ;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ActnList, Menus, ExtCtrls, Buttons, ComCtrls, Spin, ACBrSAT , ACBrSATClass,
  ACBrSATExtratoClass, ACBrSATExtratoESCPOS, OleCtrls, SHDocVw;

{function ConsultarStatusOperacional( numeroSessao : Longint; codigoDeAtivacao : PChar ) : PChar ; cdecl;
  External 'C:\SAT\SAT.DLL';
}

const
  cAssinatura = '9d4c4eef8c515e2c1269c2e4fff0719d526c5096422bf1defa20df50ba06469'+
                'a28adb25ba0447befbced7c0f805a5cc58496b7b23497af9a04f69c77f17c0c'+
                'e68161f8e4ca7e3a94c827b6c563ca6f47aea05fa90a8ce3e4327853bb2d664'+
                'ba226728fff1e2c6275ecc9b20129e1c1d2671a837aa1d265b36809501b519d'+
                'bc08129e1c1d2671a837aa1d265b36809501b519dbc08129e1c1d2671a837aa'+
                '1d265b36809501b519dbc08129e1c' ;
type

  { TForm1 }

  TForm1 = class(TForm)
    ACBrSAT1 : TACBrSAT ;
    bInicializar : TButton ;
    btSalvarParams : TButton ;
    btLerParams : TButton ;
    cbxModelo : TComboBox ;
    cbxAmbiente : TComboBox ;
    cbxIndRatISSQN : TComboBox ;
    cbxRegTribISSQN : TComboBox ;
    edLog : TEdit ;
    edtPorta : TEdit ;
    seNumeroCaixa : TSpinEdit ;
    edPathDLL : TEdit ;
    edtEmitCNPJ : TEdit ;
    edtEmitIE : TEdit ;
    edtEmitIM : TEdit ;
    edtSwHAssinatura : TEdit ;
    edtSwHCNPJ : TEdit ;
    edtCodigoAtivacao : TEdit ;
    edtCodUF : TEdit ;
    GroupBox1 : TGroupBox ;
    gpOperacao : TGroupBox ;
    Label1 : TLabel ;
    Label10 : TLabel ;
    Label11 : TLabel ;
    Label12 : TLabel ;
    Label14 : TLabel ;
    Label15 : TLabel ;
    Label16 : TLabel ;
    Label2 : TLabel ;
    Label3 : TLabel ;
    Label4 : TLabel ;
    Label5 : TLabel ;
    Label6 : TLabel ;
    Label9 : TLabel ;
    MainMenu1 : TMainMenu ;
    MenuItem1 : TMenuItem ;
    mDesligarSAT : TMenuItem ;
    MenuItem2 : TMenuItem ;
    mAtivarSAT : TMenuItem ;
    mComunicarCertificado : TMenuItem ;
    mAssociarAssinatura : TMenuItem ;
    mBloquearSAT : TMenuItem ;
    MenuItem3 : TMenuItem ;
    mDesbloquearSAT : TMenuItem ;
    MenuItem4 : TMenuItem ;
    MenuItem5 : TMenuItem ;
    mCancelarUltimaVenda : TMenuItem ;
    MenuItem6 : TMenuItem ;
    mConsultarStatusOperacional : TMenuItem ;
    mConsultarSAT : TMenuItem ;
    mConsultarNumeroSessao : TMenuItem ;
    MenuItem7 : TMenuItem ;
    MenuItem8 : TMenuItem ;
    mAtaulizarSoftwareSAT : TMenuItem ;
    mConfigurarInterfaceRede : TMenuItem ;
    MenuItem9 : TMenuItem ;
    mExtrairLogs : TMenuItem ;
    mResposta : TMemo ;
    mVenda : TMemo ;
    mTesteFimAFim : TMenuItem ;
    mEnviarVenda : TMenuItem ;
    mGerarVenda : TMenuItem ;
    mCupom : TMemo ;
    OpenDialog1 : TOpenDialog ;
    PageControl1 : TPageControl ;
    PageControl2 : TPageControl ;
    Panel1 : TPanel ;
    SbArqLog : TSpeedButton ;
    Splitter1 : TSplitter ;
    tsDadosEmit : TTabSheet ;
    tsDadosSAT : TTabSheet ;
    tsDadosSwHouse : TTabSheet ;
    tsRecebido : TTabSheet ;
    tsLog : TTabSheet ;
    tsGerado : TTabSheet ;
    N1: TMenuItem;
    ImprimirExtratoVenda1: TMenuItem;
    ImprimirExtratoCancelamento1: TMenuItem;
    ACBrSATExtratoESCPOS1: TACBrSATExtratoESCPOS;
    ImprimirExtratoVendaResumido1: TMenuItem;
    Limpar1: TMenuItem;
    wbVenda: TWebBrowser;
    wbCupom: TWebBrowser;
    Label17: TLabel;
    cbxRegTributario: TComboBox;
    cbxUTF8: TCheckBox;
    Label8: TLabel;
    sePagCod: TSpinEdit;
    procedure ACBrSAT1Log(const AString : String) ;
    procedure bInicializarClick(Sender : TObject) ;
    procedure btLerParamsClick(Sender : TObject) ;
    procedure btSalvarParamsClick(Sender : TObject) ;
    procedure cbxModeloChange(Sender : TObject) ;
    procedure FormCreate(Sender : TObject) ;
    procedure mAssociarAssinaturaClick(Sender : TObject) ;
    procedure mAtaulizarSoftwareSATClick(Sender : TObject) ;
    procedure mAtivarSATClick(Sender : TObject) ;
    procedure mBloquearSATClick(Sender : TObject) ;
    procedure mCancelarUltimaVendaClick(Sender : TObject) ;
    procedure mComunicarCertificadoClick(Sender : TObject) ;
    procedure mConfigurarInterfaceRedeClick(Sender : TObject) ;
    procedure mConsultarNumeroSessaoClick(Sender : TObject) ;
    procedure mConsultarSATClick(Sender : TObject) ;
    procedure mConsultarStatusOperacionalClick(Sender : TObject) ;
    procedure mDesbloquearSATClick(Sender : TObject) ;
    procedure mDesligarSATClick(Sender : TObject) ;
    procedure MenuItem5Click(Sender : TObject) ;
    procedure mEnviarVendaClick(Sender : TObject) ;
    procedure mExtrairLogsClick(Sender : TObject) ;
    procedure mGerarVendaClick(Sender : TObject) ;
    procedure SbArqLogClick(Sender : TObject) ;
    procedure ImprimirExtratoVenda1Click(Sender: TObject);
    procedure ImprimirExtratoVendaResumido1Click(Sender: TObject);
    procedure ImprimirExtratoCancelamento1Click(Sender: TObject);
    procedure Limpar1Click(Sender: TObject);
    procedure cbxUTF8Click(Sender: TObject);
    procedure sePagCodChange(Sender: TObject);
    procedure ACBrSAT1GetcodigoDeAtivacao(var Chave: String);
    procedure ACBrSAT1GetsignAC(var Chave: String);
  private
    procedure TrataErros(Sender : TObject ; E : Exception) ;
    procedure AjustaACBrSAT ;
    procedure LoadXML(MyMemo: TMemo; MyWebBrowser: TWebBrowser);
    { private declarations }
  public
    { public declarations }
  end ;

var
  Form1 : TForm1 ;

implementation

Uses typinfo, ACBrUtil, pcnConversao, synacode, IniFiles, pcnCFe, pcnCFeR;

{$R *.dfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender : TObject) ;
var
  I : TACBrSATModelo ;
  J : TpcnTipoAmbiente ;
  K : TpcnRegTribISSQN ;
  L : TpcnindRatISSQN ;
  M : TpcnRegTrib ;
begin
  cbxModelo.Items.Clear ;
  For I := Low(TACBrSATModelo) to High(TACBrSATModelo) do
     cbxModelo.Items.Add( GetEnumName(TypeInfo(TACBrSATModelo), integer(I) ) ) ;

  cbxAmbiente.Items.Clear ;
  For J := Low(TpcnTipoAmbiente) to High(TpcnTipoAmbiente) do
     cbxAmbiente.Items.Add( GetEnumName(TypeInfo(TpcnTipoAmbiente), integer(J) ) ) ;

  cbxRegTribISSQN.Items.Clear ;
  For K := Low(TpcnRegTribISSQN) to High(TpcnRegTribISSQN) do
     cbxRegTribISSQN.Items.Add( GetEnumName(TypeInfo(TpcnRegTribISSQN), integer(K) ) ) ;

  cbxIndRatISSQN.Items.Clear ;
  For L := Low(TpcnindRatISSQN) to High(TpcnindRatISSQN) do
     cbxIndRatISSQN.Items.Add( GetEnumName(TypeInfo(TpcnindRatISSQN), integer(L) ) ) ;

  cbxRegTributario.Items.Clear ;
  For M := Low(TpcnRegTrib) to High(TpcnRegTrib) do
     cbxRegTributario.Items.Add( GetEnumName(TypeInfo(TpcnRegTrib), integer(M) ) ) ;

  Application.OnException := TrataErros ;

  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 0;

  btLerParams.Click;
end;

procedure TForm1.mAssociarAssinaturaClick(Sender : TObject) ;
begin
  ACBrSAT1.AssociarAssinatura( edtSwHCNPJ.Text, edtSwHAssinatura.Text );
end;

procedure TForm1.mAtaulizarSoftwareSATClick(Sender : TObject) ;
begin
  ACBrSAT1.AtualizarSoftwareSAT;
end;

procedure TForm1.TrataErros(Sender: TObject; E: Exception);
var
  Erro : String ;
begin
  Erro := Trim(E.Message) ;
  ACBrSAT1.DoLog( E.ClassName+' - '+E.Message);
end ;

procedure TForm1.AjustaACBrSAT ;
begin
  with ACBrSAT1 do
  begin
    Modelo  := TACBrSATModelo( cbxModelo.ItemIndex ) ;
    ArqLOG  := edLog.Text;
    PathDLL := edPathDLL.Text;
    Config.ide_numeroCaixa := seNumeroCaixa.Value;
    Config.ide_tpAmb       := TpcnTipoAmbiente( cbxAmbiente.ItemIndex );
    Config.ide_CNPJ        := edtSwHCNPJ.Text;
    Config.emit_CNPJ       := edtEmitCNPJ.Text;
    Config.emit_IE         := edtEmitIE.Text;
    Config.emit_IM         := edtEmitIM.Text;
    Config.emit_cRegTrib      := TpcnRegTrib( cbxRegTributario.ItemIndex ) ;
    Config.emit_cRegTribISSQN := TpcnRegTribISSQN( cbxRegTribISSQN.ItemIndex ) ;
    Config.emit_indRatISSQN   := TpcnindRatISSQN( cbxIndRatISSQN.ItemIndex ) ;
    Config.PaginaDeCodigo     := sePagCod.Value;
    Config.EhUTF8             := cbxUTF8.Checked;
  end
end ;

procedure TForm1.ACBrSAT1Log(const AString : String) ;
begin
  mResposta.Lines.Add(AString);
end;

procedure TForm1.bInicializarClick(Sender : TObject) ;
begin
  AjustaACBrSAT;

  ACBrSAT1.Inicializado := not ACBrSAT1.Inicializado ;

  if ACBrSAT1.Inicializado then
    bInicializar.Caption := 'DesInicializar'
  else
    bInicializar.Caption := 'Inicializar' ;
end;

procedure TForm1.btLerParamsClick(Sender : TObject) ;
Var
  ArqINI : String ;
  INI : TIniFile ;
begin
  ArqINI := ChangeFileExt( Application.ExeName,'.ini' ) ;

  INI := TIniFile.Create(ArqINI);
  try
    cbxModelo.ItemIndex    := INI.ReadInteger('SAT','Modelo',0);
    edLog.Text             := INI.ReadString('SAT','ArqLog','ACBrSAT.log');
    edPathDLL.Text         := INI.ReadString('SAT','PathDLL','C:\SAT\');
    edtCodigoAtivacao.Text := INI.ReadString('SAT','CodigoAtivacao','123456');
    edtCodUF.Text          := INI.ReadString('SAT','CodigoUF','35');
    seNumeroCaixa.Value    := INI.ReadInteger('SAT','NumeroCaixa',1);
    cbxAmbiente.ItemIndex  := INI.ReadInteger('SAT','Ambiente',1);
    sePagCod.Value         := INI.ReadInteger('SAT','PaginaDeCodigo',0);

    edtEmitCNPJ.Text := INI.ReadString('Emit','CNPJ','');
    edtEmitIE.Text   := INI.ReadString('Emit','IE','');
    edtEmitIM.Text   := INI.ReadString('Emit','IM','');
    cbxRegTributario.ItemIndex := INI.ReadInteger('Emit','RegTributario',0);
    cbxRegTribISSQN.ItemIndex := INI.ReadInteger('Emit','RegTribISSQN',0);
    cbxIndRatISSQN.ItemIndex  := INI.ReadInteger('Emit','IndRatISSQN',0);

    edtSwHCNPJ.Text       := INI.ReadString('SwH','CNPJ','11111111111111');
    edtSwHAssinatura.Text := INI.ReadString('SwH','Assinatura',cAssinatura);
  finally
     INI.Free ;
  end ;
end;

procedure TForm1.btSalvarParamsClick(Sender : TObject) ;
Var
  ArqINI : String ;
  INI : TIniFile ;
begin
  ArqINI := ChangeFileExt( Application.ExeName,'.ini' ) ;

  INI := TIniFile.Create(ArqINI);
  try
    INI.WriteInteger('SAT','Modelo',cbxModelo.ItemIndex);
    INI.WriteString('SAT','ArqLog',edLog.Text);
    INI.WriteString('SAT','PathDLL',edPathDLL.Text);
    INI.WriteString('SAT','CodigoAtivacao',edtCodigoAtivacao.Text);
    INI.WriteString('SAT','CodigoUF',edtCodUF.Text);
    INI.WriteInteger('SAT','NumeroCaixa',seNumeroCaixa.Value);
    INI.WriteInteger('SAT','Ambiente',cbxAmbiente.ItemIndex);
    INI.WriteInteger('SAT','PaginaDeCodigo',sePagCod.Value);

    INI.WriteString('Emit','CNPJ',edtEmitCNPJ.Text);
    INI.WriteString('Emit','IE',edtEmitIE.Text);
    INI.WriteString('Emit','IM',edtEmitIM.Text);
    INI.WriteInteger('Emit','RegTributario',cbxRegTributario.ItemIndex);
    INI.WriteInteger('Emit','RegTribISSQN',cbxRegTribISSQN.ItemIndex);
    INI.WriteInteger('Emit','IndRatISSQN',cbxIndRatISSQN.ItemIndex);

    INI.WriteString('SwH','CNPJ',edtSwHCNPJ.Text);
    INI.WriteString('SwH','Assinatura',edtSwHAssinatura.Text);
  finally
     INI.Free ;
  end ;
end;

procedure TForm1.cbxModeloChange(Sender : TObject) ;
begin
  try
    ACBrSAT1.Modelo := TACBrSATModelo( cbxModelo.ItemIndex ) ;
  except
    cbxModelo.ItemIndex := Integer( ACBrSAT1.Modelo ) ;
    raise ;
  end ;
end;

procedure TForm1.mAtivarSATClick(Sender : TObject) ;
begin
  ACBrSAT1.AtivarSAT( 1, edtEmitCNPJ.Text, StrToInt(edtCodUF.Text) );
end;

procedure TForm1.mBloquearSATClick(Sender : TObject) ;
begin
  ACBrSAT1.BloquearSAT;
end;

procedure TForm1.mCancelarUltimaVendaClick(Sender : TObject) ;
begin
  OpenDialog1.Filter := 'Arquivo XML|*.xml';
  if OpenDialog1.Execute then
  begin
    ACBrSAT1.CFe.LoadFromFile( OpenDialog1.FileName );
    ACBrSAT1.CancelarUltimaVenda;
  end ;
end;

procedure TForm1.mComunicarCertificadoClick(Sender : TObject) ;
Var
  SL : TStringList;
begin
  OpenDialog1.Filter := 'Certificado|*.cer|Arquivo Texto|*.txt';
  if OpenDialog1.Execute then
  begin
    SL := TStringList.Create;
    try
      SL.LoadFromFile( OpenDialog1.FileName );

      ACBrSAT1.ComunicarCertificadoICPBRASIL( SL.Text );
    finally
      SL.Free;
    end ;
  end ;
end;

procedure TForm1.mConfigurarInterfaceRedeClick(Sender : TObject) ;
Var
  SL : TStringList;
begin
  OpenDialog1.Filter := 'Arquivo XML|*.xml';
  if OpenDialog1.Execute then
  begin
    SL := TStringList.Create;
    try
      SL.LoadFromFile( OpenDialog1.FileName );

      ACBrSAT1.ConfigurarInterfaceDeRede( SL.Text );
    finally
      SL.Free;
    end ;
  end ;
end;

procedure TForm1.mConsultarNumeroSessaoClick(Sender : TObject) ;
Var
  strSessao: String ;
  nSessao : Integer ;
begin
  strSessao := '';
  if not InputQuery('Consultar Número de Sessão',
                    'Entre com o Número de Sessão a ser consultada:', strSessao ) then
    Exit;

  nSessao := StrToIntDef(strSessao, 0);
  if nSessao <= 0 then
    raise Exception.Create('Numero de sessão informado é inválido') ;

  ACBrSAT1.ConsultarNumeroSessao( nSessao );
end;

procedure TForm1.mConsultarSATClick(Sender : TObject) ;
begin
  ACBrSAT1.ConsultarSAT;
end;

procedure TForm1.mConsultarStatusOperacionalClick(Sender : TObject) ;
begin
  //mResposta.Lines.Add( ConsultarStatusOperacional( Random(999999), '123456' ) ) ;

  ACBrSAT1.ConsultarStatusOperacional;
end;

procedure TForm1.mDesbloquearSATClick(Sender : TObject) ;
begin
  ACBrSAT1.DesbloquearSAT;
end;

procedure TForm1.mDesligarSATClick(Sender : TObject) ;
begin
  ACBrSAT1.DesligarSAT;
end;

procedure TForm1.MenuItem5Click(Sender : TObject) ;
Var
  CodNovo, CodAtual, tipoCodigo: String;
begin
  CodNovo    := '';
  CodAtual   := edtCodigoAtivacao.Text;
  tipoCodigo := '1';

  if not InputQuery('Trocar Código de Ativação',
                    'Entre com o Código de Ativação ou de Emergência:', CodAtual ) then
    Exit;

  if not InputQuery('Trocar Código de Ativação',
                    'Qual o Tipo do Código Informado anteriormente ?'+sLineBreak+
                    '1 - Código de Ativação'+sLineBreak+
                    '2 - Código de Ativação de Emergência'+sLineBreak,
                    tipoCodigo ) then
    Exit;

  if not InputQuery('Trocar Código de Ativação',
                    'Entre com o Número do Novo Código de Ativação:', CodNovo ) then
    Exit;

  ACBrSAT1.TrocarCodigoDeAtivacao( CodAtual, StrToInt(tipoCodigo), CodNovo );

  if ACBrSAT1.Resposta.codigoDeRetorno = 1800 then
  begin
    edtCodigoAtivacao.Text := CodNovo;
    mResposta.Lines.Add('Código de Ativação trocado com sucesso');
    btSalvarParams.Click;
  end ;
end;

procedure TForm1.mEnviarVendaClick(Sender : TObject) ;
Var
  DirEnv, DirResp : String;
  numSessao: Integer;
begin
  if mVenda.Text = '' then
    mGerarVenda.Click;

  PageControl1.ActivePage := tsLog;

  ACBrSAT1.EnviarDadosVenda( mVenda.Text );

  DirEnv := ExtractFilePath(Application.ExeName)+'\Env\';
  DirResp := ExtractFilePath(Application.ExeName)+'\Res\';
  numSessao := ACBrSAT1.numeroSessao;

  ForceDirectories( DirEnv );
  ForceDirectories( DirResp );

  mVenda.Lines.SaveToFile(DirEnv + 'CFe-'+IntToStrZero(numSessao,6)+'.xml');

  if ACBrSAT1.Resposta.codigoDeRetorno = 6000 then
  begin
    mCupom.Lines.Text := ACBrSAT1.CFe.AsXMLString;
    mCupom.Lines.SaveToFile(DirResp + 'CFe-'+ACBrSAT1.CFe.infCFe.ID+'-rec.xml');
    LoadXML(mCupom, wbCupom);
    PageControl1.ActivePage := tsRecebido;
  end;
end;

procedure TForm1.mExtrairLogsClick(Sender : TObject) ;
begin
  ACBrSAT1.ExtrairLogs;
end;

procedure TForm1.mGerarVendaClick(Sender : TObject) ;
var
  TotalItem: Double;
begin
  PageControl1.ActivePage := tsGerado;

  mVenda.Clear;

  // Trasnferindo Informações de Config para o CFe //
  AjustaACBrSAT;
  ACBrSAT1.InicializaCFe ;

  // Montando uma Venda //
  with ACBrSAT1.CFe do
  begin
    ide.numeroCaixa := 1;

    Dest.CNPJCPF := '05481336000137';
    Dest.xNome := 'D.J. SYSTEM';

    Entrega.xLgr := 'logradouro';
    Entrega.nro := '112233';
    Entrega.xCpl := 'complemento';
    Entrega.xBairro := 'bairro';
    Entrega.xMun := 'municipio';
    Entrega.UF := 'RJ';

    with Det.Add do
    begin
      nItem := 1;
      Prod.cProd := 'abc123';
      Prod.cEAN := '6291041500213';
      Prod.xProd := 'xis prod';
      prod.NCM := '99';
      Prod.CFOP := '5500';
      Prod.uCom := 'horas';
      Prod.qCom := 1.1205;
      Prod.vUnCom := 11.210;
      Prod.indRegra := irTruncamento;
      Prod.vDesc := 1;

      with Prod.obsFiscoDet.Add do
      begin
        xCampoDet := 'campo';
        xTextoDet := 'texto';
      end;

      TotalItem := (Prod.qCom * Prod.vUnCom);

      Imposto.vItem12741 := TotalItem * 0.30;

      Imposto.ICMS.orig := oeNacional;
      Imposto.ICMS.CST := cst00;
      Imposto.ICMS.pICMS := 18;

      Imposto.PIS.CST := pis01;
      Imposto.PIS.vBC := TotalItem;
      Imposto.PIS.pPIS := 0.65;

      Imposto.COFINS.CST := cof01;
      Imposto.COFINS.vBC := TotalItem;
      Imposto.COFINS.pCOFINS := 3;
      //
      //Imposto.COFINSST.vBC := 87206.46;
      //Imposto.COFINSST.pCOFINS := 1.8457;

      infAdProd := 'Informacoes adicionais';
    end;

    (*
    with Det.Add do
    begin
      nItem := 2;
      Prod.cProd := 'abc123';
      Prod.cEAN := '6291041500213';
      Prod.xProd := 'Nada';
      Prod.CFOP := '5529';
      Prod.uCom := 'horas';
      Prod.qCom := 1.1205;
      Prod.vUnCom := 11.210;
      Prod.indRegra := irTruncamento;
      Prod.vOutro := 2;

      Imposto.ICMS.orig := oeNacional;
      Imposto.ICMS.CST := cst40;

      Imposto.PIS.CST := pis03;
      Imposto.PIS.qBCProd := 1424.8937;
      Imposto.PIS.vAliqProd := 264.0223;

      Imposto.PISST.qBCProd := 1424.8937;
      Imposto.PISST.vAliqProd := 264.0223;

      Imposto.COFINS.CST := cof03;
      Imposto.COFINS.qBCProd := 1424.8937;
      Imposto.COFINS.vAliqProd := 264.0223;

      Imposto.COFINSST.qBCProd := 503.6348;
      Imposto.COFINSST.vAliqProd := 779.4577;
    end;

    with Det.Add do
    begin
      nItem := 3;
      Prod.cProd := 'abc123';
      Prod.cEAN := '6291041500213';
      Prod.xProd := 'Nada';
      Prod.NCM := '99';
      Prod.CFOP := '5844';
      Prod.uCom := 'horas';
      Prod.qCom := 1.1205;
      Prod.vUnCom := 11.210;
      Prod.indRegra := irTruncamento;

      Imposto.ICMS.orig := oeEstrangeiraImportacaoDireta;
      Imposto.ICMS.CSOSN := csosn102;

      Imposto.PIS.CST := pis04;

      Imposto.PISST.qBCProd := 227.7313;
      Imposto.PISST.vAliqProd := 390.1826;

      Imposto.COFINS.CST := cof06;

      infAdProd := 'Informacoes adicionais';
    end;


    with Det.Add do
    begin
      nItem := 4;
      Prod.cProd := 'abc123';
      Prod.cEAN := '6291041500213';
      Prod.xProd := 'Nada';
      Prod.CFOP := '5025';
      Prod.uCom := 'horas';
      Prod.qCom := 1.1205;
      Prod.vUnCom := 11.210;
      Prod.vProd := 8;
      Prod.indRegra := irTruncamento;
      Prod.vOutro := 93.31;

      Imposto.ICMS.orig := oeEstrangeiraAdquiridaBrasil;
      Imposto.ICMS.CSOSN := csosn900;
      Imposto.ICMS.pICMS := 1.1234;

      Imposto.PIS.CST := pis49;

      Imposto.PISST.qBCProd := 7528.8947;
      Imposto.PISST.vAliqProd := 296.2348;

      Imposto.COFINS.CST := cof49;
    end;
    *)

    Total.DescAcrEntr.vDescSubtot := 5;
    Total.vCFeLei12741 := 1234.56;

    with Pagto.Add do
    begin
      cMP := MPDinheiro;
      vMP := 9999999.99;
    end;

    //with Pagto.Add do
    //begin
    //  cMP := MPCartaodeCredito;
    //  vMP := 10;
    //end;

    InfAdic.infCpl := 'Acesse www.projetoacbr.com.br para obter mais;informações sobre o componente ACBrSAT;'+
                      'Precisa de um PAF-ECF homologado?;Conheça o DJPDV - www.djpdv.com.br'
  end;

  mVenda.Lines.Text := ACBrSAT1.CFe.GetXMLString( True );    // True = Gera apenas as TAGs da aplicação

  mResposta.Lines.Add('Venda Gerada');
  LoadXML(mVenda, wbVenda);
  mResposta.Lines.Add('Venda Gerada');
end;

procedure TForm1.SbArqLogClick(Sender : TObject) ;
begin
  OpenURL( ExtractFilePath( Application.ExeName ) + edLog.Text);
end;

procedure TForm1.ImprimirExtratoVenda1Click(Sender: TObject);
begin
  ACBrSATExtratoESCPOS1.Device.Porta := edtPorta.Text;
  ACBrSATExtratoESCPOS1.Device.Ativar;
  ACBrSATExtratoESCPOS1.Device.Serial.Purge;
  ACBrSATExtratoESCPOS1.ImprimeQRCode := True;

  ACBrSAT1.ImprimirExtrato;
end;

procedure TForm1.ImprimirExtratoVendaResumido1Click(Sender: TObject);
begin
  ACBrSATExtratoESCPOS1.Device.Porta := edtPorta.Text;
  ACBrSATExtratoESCPOS1.Device.Ativar;
  ACBrSATExtratoESCPOS1.Device.Serial.Purge;
  ACBrSATExtratoESCPOS1.ImprimeQRCode := True;

  ACBrSAT1.ImprimirExtratoResumido;
end;

procedure TForm1.ImprimirExtratoCancelamento1Click(Sender: TObject);
begin
  ACBrSATExtratoESCPOS1.Device.Porta := edtPorta.Text;
  ACBrSATExtratoESCPOS1.Device.Ativar;
  ACBrSATExtratoESCPOS1.Device.Serial.Purge;
  ACBrSATExtratoESCPOS1.ImprimeQRCode := True;  

  ACBrSAT1.ImprimirExtratoCancelamento;
end;

procedure TForm1.Limpar1Click(Sender: TObject);
begin
  mVenda.Clear;
  mCupom.Clear;
end;

procedure TForm1.LoadXML(MyMemo: TMemo; MyWebBrowser: TWebBrowser);
begin
  MyMemo.Lines.SaveToFile(PathWithDelim(ExtractFileDir(application.ExeName))+'temp.xml');
  MyWebBrowser.Navigate(PathWithDelim(ExtractFileDir(application.ExeName))+'temp.xml');
end;

procedure TForm1.cbxUTF8Click(Sender: TObject);
begin
  ACBrSAT1.Config.EhUTF8 := cbxUTF8.Checked;
  sePagCod.Value := ACBrSAT1.Config.PaginaDeCodigo;
end;

procedure TForm1.sePagCodChange(Sender: TObject);
begin
  ACBrSAT1.Config.PaginaDeCodigo := sePagCod.Value;
  cbxUTF8.Checked := ACBrSAT1.Config.EhUTF8;
end;

procedure TForm1.ACBrSAT1GetcodigoDeAtivacao(var Chave: String);
begin
  Chave := edtCodigoAtivacao.Text;
end;

procedure TForm1.ACBrSAT1GetsignAC(var Chave: String);
begin
  Chave := edtSwHAssinatura.Text;
end;

end.

