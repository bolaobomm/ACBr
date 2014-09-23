object Form1: TForm1
  Left = 406
  Top = 154
  Width = 772
  Height = 486
  Caption = 'SAT Teste - Projeto ACBr'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 184
    Width = 756
    Height = 5
    Cursor = crVSplit
    Align = alTop
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 189
    Width = 756
    Height = 239
    ActivePage = tsRecebido
    Align = alClient
    TabOrder = 1
    object tsLog: TTabSheet
      Caption = 'Log de Comandos'
      object mResposta: TMemo
        Left = 0
        Top = 95
        Width = 731
        Height = 116
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object tsGerado: TTabSheet
      Caption = 'XML Gerado'
      object mVenda: TMemo
        Left = 0
        Top = 186
        Width = 731
        Height = 25
        Align = alBottom
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object wbVenda: TWebBrowser
        Left = 0
        Top = 0
        Width = 731
        Height = 186
        Align = alClient
        TabOrder = 1
        ControlData = {
          4C0000008D4B0000391300000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
    object tsRecebido: TTabSheet
      Caption = 'XML Recebido'
      object mCupom: TMemo
        Left = 0
        Top = 186
        Width = 748
        Height = 25
        Align = alBottom
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object wbCupom: TWebBrowser
        Left = 0
        Top = 0
        Width = 748
        Height = 186
        Align = alClient
        TabOrder = 1
        ControlData = {
          4C0000004F4D0000391300000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 756
    Height = 184
    Align = alTop
    TabOrder = 0
    object gpOperacao: TGroupBox
      Left = 1
      Top = 1
      Width = 145
      Height = 182
      Align = alLeft
      Caption = 'Inicializa'#231#227'o'
      TabOrder = 0
      object bInicializar: TButton
        Left = 16
        Top = 52
        Width = 105
        Height = 33
        Caption = 'Inicializar'
        TabOrder = 0
        OnClick = bInicializarClick
      end
      object cbxModelo: TComboBox
        Left = 16
        Top = 20
        Width = 105
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = cbxModeloChange
      end
      object btSalvarParams: TButton
        Left = 16
        Top = 139
        Width = 105
        Height = 25
        Caption = 'Salvar Params'
        TabOrder = 2
        OnClick = btSalvarParamsClick
      end
      object btLerParams: TButton
        Left = 16
        Top = 107
        Width = 105
        Height = 25
        Caption = 'Ler Params'
        TabOrder = 3
        OnClick = btLerParamsClick
      end
    end
    object GroupBox1: TGroupBox
      Left = 146
      Top = 1
      Width = 609
      Height = 182
      Align = alClient
      Caption = 'Configura'#231#227'o'
      TabOrder = 1
      object PageControl2: TPageControl
        Left = 2
        Top = 15
        Width = 605
        Height = 165
        ActivePage = tsDadosSAT
        Align = alClient
        TabOrder = 0
        object tsDadosSAT: TTabSheet
          Caption = 'Dados do SAT CFe'
          DesignSize = (
            597
            137)
          object Label9: TLabel
            Left = 26
            Top = 7
            Width = 42
            Height = 13
            Alignment = taRightJustify
            Caption = 'Arq.Log:'
            Color = clBtnFace
            ParentColor = False
          end
          object SbArqLog: TSpeedButton
            Left = 192
            Top = 24
            Width = 24
            Height = 22
            Caption = '...'
            OnClick = SbArqLogClick
          end
          object Label10: TLabel
            Left = 233
            Top = 7
            Width = 46
            Height = 13
            Alignment = taRightJustify
            Caption = 'Path DLL:'
            Color = clBtnFace
            ParentColor = False
          end
          object Label1: TLabel
            Left = 23
            Top = 56
            Width = 93
            Height = 13
            Caption = 'C'#243'digo de Ativa'#231#227'o'
            Color = clBtnFace
            ParentColor = False
          end
          object Label4: TLabel
            Left = 200
            Top = 56
            Width = 36
            Height = 13
            Caption = 'C'#243'd.UF'
            Color = clBtnFace
            ParentColor = False
          end
          object Label3: TLabel
            Left = 262
            Top = 56
            Width = 52
            Height = 13
            Caption = 'Num.Caixa'
            Color = clBtnFace
            ParentColor = False
          end
          object Label6: TLabel
            Left = 341
            Top = 56
            Width = 45
            Height = 13
            Caption = 'Ambiente'
            Color = clBtnFace
            ParentColor = False
          end
          object Label7: TLabel
            Left = 399
            Top = 8
            Width = 26
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Porta'
          end
          object Label8: TLabel
            Left = 127
            Top = 106
            Width = 68
            Height = 13
            Caption = 'P'#225'gina C'#243'digo'
            Color = clBtnFace
            ParentColor = False
          end
          object edLog: TEdit
            Left = 24
            Top = 24
            Width = 163
            Height = 21
            Cursor = crIBeam
            TabOrder = 0
          end
          object edNomeDLL: TEdit
            Left = 230
            Top = 24
            Width = 156
            Height = 21
            Cursor = crIBeam
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 1
          end
          object edtCodigoAtivacao: TEdit
            Left = 23
            Top = 72
            Width = 164
            Height = 21
            TabOrder = 2
          end
          object edtCodUF: TEdit
            Left = 200
            Top = 72
            Width = 49
            Height = 21
            TabOrder = 3
          end
          object seNumeroCaixa: TSpinEdit
            Left = 262
            Top = 72
            Width = 58
            Height = 22
            MaxValue = 999
            MinValue = 1
            TabOrder = 4
            Value = 1
          end
          object cbxAmbiente: TComboBox
            Left = 341
            Top = 72
            Width = 190
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akTop, akRight]
            ItemHeight = 13
            TabOrder = 5
          end
          object edtPorta: TEdit
            Left = 399
            Top = 24
            Width = 132
            Height = 21
            Anchors = [akTop, akRight]
            TabOrder = 6
            Text = 'COM7'
          end
          object cbxUTF8: TCheckBox
            Left = 24
            Top = 106
            Width = 73
            Height = 17
            Caption = 'UTF8'
            TabOrder = 7
            OnClick = cbxUTF8Click
          end
          object sePagCod: TSpinEdit
            Left = 200
            Top = 102
            Width = 83
            Height = 22
            MaxValue = 65001
            MinValue = 0
            TabOrder = 8
            Value = 0
            OnChange = sePagCodChange
          end
        end
        object tsDadosEmit: TTabSheet
          Caption = 'Dados Emitente'
          object Label11: TLabel
            Left = 12
            Top = 23
            Width = 25
            Height = 13
            Caption = 'CNPJ'
            Color = clBtnFace
            ParentColor = False
          end
          object Label12: TLabel
            Left = 192
            Top = 23
            Width = 65
            Height = 13
            Caption = 'Insc.Estadual'
            Color = clBtnFace
            ParentColor = False
          end
          object Label14: TLabel
            Left = 336
            Top = 23
            Width = 67
            Height = 13
            Caption = 'Insc.Municipal'
            Color = clBtnFace
            ParentColor = False
          end
          object Label15: TLabel
            Left = 192
            Top = 79
            Width = 94
            Height = 13
            Caption = 'Regime Trib. ISSQN'
            Color = clBtnFace
            ParentColor = False
          end
          object Label16: TLabel
            Left = 336
            Top = 79
            Width = 72
            Height = 13
            Caption = 'Ind.Rat.ISSQN'
            Color = clBtnFace
            ParentColor = False
          end
          object Label17: TLabel
            Left = 12
            Top = 81
            Width = 84
            Height = 13
            Caption = 'Regime Tributario'
            Color = clBtnFace
            ParentColor = False
          end
          object edtEmitCNPJ: TEdit
            Left = 12
            Top = 38
            Width = 166
            Height = 21
            Cursor = crIBeam
            TabOrder = 0
          end
          object edtEmitIE: TEdit
            Left = 192
            Top = 38
            Width = 134
            Height = 21
            Cursor = crIBeam
            TabOrder = 1
          end
          object edtEmitIM: TEdit
            Left = 336
            Top = 38
            Width = 134
            Height = 21
            Cursor = crIBeam
            TabOrder = 2
          end
          object cbxRegTribISSQN: TComboBox
            Left = 192
            Top = 95
            Width = 134
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 4
          end
          object cbxIndRatISSQN: TComboBox
            Left = 336
            Top = 95
            Width = 134
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 5
          end
          object cbxRegTributario: TComboBox
            Left = 12
            Top = 95
            Width = 166
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 3
          end
        end
        object tsDadosSwHouse: TTabSheet
          Caption = 'Dados Sw.House'
          DesignSize = (
            597
            137)
          object Label2: TLabel
            Left = 10
            Top = 15
            Width = 25
            Height = 13
            Caption = 'CNPJ'
            Color = clBtnFace
            ParentColor = False
          end
          object Label5: TLabel
            Left = 10
            Top = 71
            Width = 185
            Height = 13
            Caption = 'Assinatura Sw.House (344 caracteres)'
            Color = clBtnFace
            ParentColor = False
          end
          object edtSwHCNPJ: TEdit
            Left = 10
            Top = 31
            Width = 248
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
          end
          object edtSwHAssinatura: TEdit
            Left = 10
            Top = 89
            Width = 513
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 1
          end
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 61
    Top = 328
    object MenuItem1: TMenuItem
      Caption = 'Ativa'#231#227'o'
      object mAtivarSAT: TMenuItem
        Caption = 'Ativar SAT'
        OnClick = mAtivarSATClick
      end
      object mComunicarCertificado: TMenuItem
        Caption = 'Comunicar Certificado'
        OnClick = mComunicarCertificadoClick
      end
      object mAssociarAssinatura: TMenuItem
        Caption = 'Associar Assinatura'
        OnClick = mAssociarAssinaturaClick
      end
      object MenuItem3: TMenuItem
        Caption = '-'
      end
      object mBloquearSAT: TMenuItem
        Caption = 'Bloquear SAT'
        OnClick = mBloquearSATClick
      end
      object mDesbloquearSAT: TMenuItem
        Caption = 'Desbloquear SAT'
        OnClick = mDesbloquearSATClick
      end
      object MenuItem4: TMenuItem
        Caption = '-'
      end
      object MenuItem5: TMenuItem
        Caption = 'Trocar  C'#243'digo de Ativa'#231#227'o'
        OnClick = MenuItem5Click
      end
    end
    object MenuItem2: TMenuItem
      Caption = 'Venda'
      object mGerarVenda: TMenuItem
        Caption = 'Gerar Venda'
        OnClick = mGerarVendaClick
      end
      object mEnviarVenda: TMenuItem
        Caption = 'Enviar Venda'
        OnClick = mEnviarVendaClick
      end
      object ImprimirExtratoVenda1: TMenuItem
        Caption = 'Imprimir Extrato Venda'
        OnClick = ImprimirExtratoVenda1Click
      end
      object ImprimirExtratoVendaResumido1: TMenuItem
        Caption = 'Imprimir Extrato Venda Resumido'
        OnClick = ImprimirExtratoVendaResumido1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mCancelarUltimaVenda: TMenuItem
        Caption = 'Cancelar '#218'ltima Venda'
        OnClick = mCancelarUltimaVendaClick
      end
      object ImprimirExtratoCancelamento1: TMenuItem
        Caption = 'Imprimir Extrato Cancelamento'
        OnClick = ImprimirExtratoCancelamento1Click
      end
    end
    object MenuItem6: TMenuItem
      Caption = 'Consultas'
      object mConsultarStatusOperacional: TMenuItem
        Caption = 'Consultar Status Operacional'
        OnClick = mConsultarStatusOperacionalClick
      end
      object mConsultarSAT: TMenuItem
        Caption = 'Consultar SAT'
        OnClick = mConsultarSATClick
      end
      object mConsultarNumeroSessao: TMenuItem
        Caption = 'Consultar Numero Sess'#227'o'
        OnClick = mConsultarNumeroSessaoClick
      end
    end
    object MenuItem7: TMenuItem
      Caption = 'Configura'#231#227'o'
      object mAtaulizarSoftwareSAT: TMenuItem
        Caption = 'Ataulizar Software SAT'
        OnClick = mAtaulizarSoftwareSATClick
      end
      object mConfigurarInterfaceRede: TMenuItem
        Caption = 'Configurar Interface Rede'
        OnClick = mConfigurarInterfaceRedeClick
      end
    end
    object MenuItem8: TMenuItem
      Caption = 'Diversos'
      object mTesteFimAFim: TMenuItem
        Caption = 'Teste Fim a Fim'
      end
      object mExtrairLogs: TMenuItem
        Caption = 'Extrair Logs'
        OnClick = mExtrairLogsClick
      end
      object MenuItem9: TMenuItem
        Caption = '-'
      end
      object mDesligarSAT: TMenuItem
        Caption = 'Desligar SAT'
        OnClick = mDesligarSATClick
      end
    end
    object Limpar1: TMenuItem
      Caption = 'Limpar'
      OnClick = Limpar1Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 97
    Top = 328
  end
  object ACBrSAT1: TACBrSAT
    Extrato = ACBrSATExtratoFortes1
    OnLog = ACBrSAT1Log
    Config.infCFe_versaoDadosEnt = 0.030000000000000000
    Config.ide_numeroCaixa = 0
    Config.ide_tpAmb = taHomologacao
    Config.emit_cRegTrib = RTSimplesNacional
    Config.emit_cRegTribISSQN = RTISSMicroempresaMunicipal
    Config.emit_indRatISSQN = irSim
    Config.EhUTF8 = False
    Config.PaginaDeCodigo = 0
    OnGetcodigoDeAtivacao = ACBrSAT1GetcodigoDeAtivacao
    OnGetsignAC = ACBrSAT1GetsignAC
    Left = 58
    Top = 234
  end
  object ACBrSATExtratoESCPOS1: TACBrSATExtratoESCPOS
    Mask_qCom = '0.0000'
    Mask_vUnCom = '0.000'
    ImprimeQRCode = False
    Left = 57
    Top = 269
  end
  object ACBrSATExtratoFortes1: TACBrSATExtratoFortes
    ACBrSAT = ACBrSAT1
    Mask_qCom = '0.00'
    Mask_vUnCom = '0.00'
    PictureLogo.Data = {
      07544269746D6170FE000000424DFE000000000000003E000000280000003300
      0000180000000100010000000000C0000000C40E0000C40E0000020000000000
      000000000000FFFFFF0000000000000000003FFFFFFFFFFF8000600006000000
      C000407EFFFD6FC04000404F7FFFEFE04000400007C3C00040007FFFFFFFF1FF
      C0001E3CE1FFADFF00000338C0FFCDC0000003008C7AEDC0000001018CFACDC0
      000001999FFFDEC0000001919FFDDFC0000000838C7BD540000000C3807DDFC0
      000000C3C0FFBF000000007FFFFFFE000000007FFFFFFC0000000003FFFFF800
      00000001FFFFF00000000000FFFFC000000000003FFF8000000000000FFC0000
      000000003BE000000000}
    MostrarPreview = True
    Left = 108
    Top = 269
  end
end
