inherited frlDANFeRLPaisagem: TfrlDANFeRLPaisagem
  Left = 223
  Width = 1149
  Height = 732
  VertScrollBar.Position = 0
  Caption = 'frlDANFeRLPaisagem'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited RLNFe: TRLReport
    Top = 0
    Width = 1123
    Height = 794
    Background.Arrange = baDistributed
    Background.Height = 96
    Background.Width = 175
    DataSource = DataSource1
    Margins.LeftMargin = 7.000000000000000000
    Margins.TopMargin = 7.000000000000000000
    Margins.RightMargin = 7.000000000000000000
    Margins.BottomMargin = 7.000000000000000000
    PageSetup.Orientation = poLandscape
    PreviewOptions.FormStyle = fsStayOnTop
    PrintDialog = False
    Title = 'Danfe Paisagem'
    BeforePrint = RLNFeBeforePrint
    object rliMarcaDagua1: TRLImage
      Left = 361
      Top = 430
      Width = 327
      Height = 234
      Center = True
      HoldStyle = hsHorizontally
      Scaled = True
    end
    object rlbContinuacaoInformacoesComplementares: TRLBand
      Left = 99
      Top = 539
      Width = 998
      Height = 35
      AutoSize = True
      BandType = btSummary
      object rlmContinuacaoDadosAdicionais: TRLMemo
        Tag = 20
        Left = 8
        Top = 24
        Width = 1018
        Height = 8
        Borders.Style = bsClear
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel16: TRLLabel
        Tag = 10
        Left = 3
        Top = 13
        Width = 195
        Height = 7
        Caption = 'CONTINUA'#199#195'O DAS INFORMA'#199#213'ES COMPLEMENTARES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object LinhaDCSuperior: TRLDraw
        Left = 0
        Top = 10
        Width = 997
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaDCInferior: TRLDraw
        Left = 0
        Top = 34
        Width = 997
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaDCEsquerda: TRLDraw
        Left = 0
        Top = 10
        Width = 1
        Height = 25
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaDCDireita: TRLDraw
        Left = 996
        Top = 10
        Width = 1
        Height = 25
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
    end
    object rlbCabecalhoItens: TRLBand
      Left = 99
      Top = 484
      Width = 998
      Height = 26
      AutoSize = True
      Background.Arrange = baDistributed
      Background.Height = 96
      Background.Width = 175
      BandType = btColumnHeader
      PageBreaking = pbBeforePrint
      object pnlCabecalho1: TRLPanel
        Left = 0
        Top = 0
        Width = 497
        Height = 26
        Align = faLeftMost
        object rlsRectProdutos1: TRLDraw
          Left = 0
          Top = 7
          Width = 497
          Height = 19
          Align = faWidth
        end
        object rllCinza1: TRLLabel
          Left = 1
          Top = 8
          Width = 495
          Height = 16
          AutoSize = False
          Caption = '  '
          Color = 14540253
          ParentColor = False
          Transparent = False
        end
        object lblDadosDoProduto: TRLLabel
          Tag = 30
          Left = 0
          Top = 0
          Width = 117
          Height = 7
          Caption = 'DADOS DO PRODUTO / SERVI'#199'OS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object rlmCodProd: TRLMemo
          Tag = 10
          Left = 2
          Top = 9
          Width = 52
          Height = 14
          Alignment = taCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Lines.Strings = (
            'C'#211'DIGO DO PROD. / SERV.')
          ParentFont = False
        end
        object rlsDivProd1: TRLDraw
          Left = 54
          Top = 7
          Width = 1
          Height = 19
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rlmDescricaoProduto: TRLMemo
          Tag = 10
          Left = 128
          Top = 13
          Width = 366
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          Lines.Strings = (
            'DESCRI'#199#195'O DO PRODUTO / SERVI'#199'O')
          ParentFont = False
        end
        object rllEAN: TRLLabel
          Tag = 10
          Left = 55
          Top = 13
          Width = 70
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'EAN'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object rlsDivProdEAN: TRLDraw
          Left = 126
          Top = 7
          Width = 1
          Height = 19
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
      end
      object pnlCabecalho2: TRLPanel
        Left = 496
        Top = 0
        Width = 501
        Height = 26
        object rlsRectProdutos2: TRLDraw
          Left = 0
          Top = 7
          Width = 501
          Height = 19
        end
        object rllCinza2: TRLLabel
          Left = 1
          Top = 8
          Width = 498
          Height = 16
          AutoSize = False
          Caption = '  '
          Color = 14540253
          ParentColor = False
          Transparent = False
        end
        object rlsDivProd3: TRLDraw
          Left = 43
          Top = 7
          Width = 1
          Height = 19
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rlsDivProd4: TRLDraw
          Left = 66
          Top = 7
          Width = 1
          Height = 19
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rlsDivProd5: TRLDraw
          Left = 90
          Top = 7
          Width = 1
          Height = 19
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rlsDivProd6: TRLDraw
          Left = 112
          Top = 7
          Width = 1
          Height = 19
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rlsDivProd7: TRLDraw
          Left = 164
          Top = 7
          Width = 1
          Height = 19
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rlsDivProd8: TRLDraw
          Left = 215
          Top = 7
          Width = 1
          Height = 19
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object RLDraw1: TRLDraw
          Left = 268
          Top = 7
          Width = 1
          Height = 19
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rlsDivProd9: TRLDraw
          Left = 314
          Top = 7
          Width = 1
          Height = 19
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rlsDivProd10: TRLDraw
          Left = 369
          Top = 7
          Width = 1
          Height = 19
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rlsDivProd11: TRLDraw
          Left = 410
          Top = 7
          Width = 1
          Height = 19
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rlsDivProd12: TRLDraw
          Left = 450
          Top = 7
          Width = 1
          Height = 19
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object RLLabel82: TRLLabel
          Tag = 10
          Left = 1
          Top = 13
          Width = 42
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'NCM / SH'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object lblCST: TRLLabel
          Tag = 10
          Left = 44
          Top = 13
          Width = 22
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'CST'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel84: TRLLabel
          Tag = 10
          Left = 67
          Top = 13
          Width = 22
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'CFOP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel85: TRLLabel
          Tag = 10
          Left = 91
          Top = 13
          Width = 22
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'UNID.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel91: TRLLabel
          Tag = 10
          Left = 113
          Top = 13
          Width = 50
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'QUANTIDADE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel87: TRLLabel
          Tag = 10
          Left = 165
          Top = 9
          Width = 50
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'VALOR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel88: TRLLabel
          Tag = 10
          Left = 165
          Top = 16
          Width = 50
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'UNIT'#193'RIO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel86: TRLLabel
          Tag = 10
          Left = 217
          Top = 13
          Width = 50
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'VALOR TOTAL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel10: TRLLabel
          Tag = 10
          Left = 269
          Top = 9
          Width = 44
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'VALOR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel11: TRLLabel
          Tag = 10
          Left = 269
          Top = 16
          Width = 44
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'DESCONTO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel89: TRLLabel
          Tag = 10
          Left = 316
          Top = 9
          Width = 52
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'BASE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel90: TRLLabel
          Tag = 10
          Left = 316
          Top = 16
          Width = 52
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'C'#193'LC. ICMS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel92: TRLLabel
          Tag = 10
          Left = 371
          Top = 9
          Width = 38
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'VALOR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel93: TRLLabel
          Tag = 10
          Left = 371
          Top = 16
          Width = 38
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'I.C.M.S.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel94: TRLLabel
          Tag = 10
          Left = 412
          Top = 9
          Width = 38
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'VALOR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel95: TRLLabel
          Tag = 10
          Left = 412
          Top = 16
          Width = 38
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'I.P.I.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel96: TRLLabel
          Tag = 10
          Left = 452
          Top = 8
          Width = 46
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'AL'#205'QUOTAS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel97: TRLLabel
          Left = 453
          Top = 17
          Width = 24
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'ICMS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLLabel98: TRLLabel
          Left = 477
          Top = 17
          Width = 24
          Height = 7
          Alignment = taCenter
          AutoSize = False
          Caption = 'IPI'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -7
          Font.Name = 'Arial'
          Font.Style = []
          HoldStyle = hsRelatively
          ParentFont = False
        end
        object RLDraw54: TRLDraw
          Left = 450
          Top = 16
          Width = 50
          Height = 1
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rlsDivProd13: TRLDraw
          Left = 475
          Top = 16
          Width = 1
          Height = 9
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
      end
    end
    object rlbEmitente: TRLBand
      Left = 99
      Top = 26
      Width = 998
      Height = 158
      AutoExpand = False
      BandType = btHeader
      AfterPrint = rlbEmitenteAfterPrint
      BeforePrint = rlbEmitenteBeforePrint
      object rliEmitente: TRLDraw
        Left = 0
        Top = 0
        Width = 465
        Height = 105
      end
      object rlmSiteEmail: TRLMemo
        Tag = 3
        Left = 116
        Top = 78
        Width = 342
        Height = 22
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rliNatOpe: TRLDraw
        Left = 0
        Top = 104
        Width = 997
        Height = 53
      end
      object rliChave: TRLDraw
        Left = 636
        Top = 0
        Width = 361
        Height = 105
      end
      object rliNatOpe1: TRLDraw
        Left = 0
        Top = 130
        Width = 997
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsHorizontally
      end
      object RLDraw9: TRLDraw
        Left = 636
        Top = 104
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object RLDraw10: TRLDraw
        Left = 332
        Top = 130
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object rllDANFE: TRLLabel
        Left = 476
        Top = 3
        Width = 150
        Height = 18
        Alignment = taCenter
        AutoSize = False
        Caption = 'DANFE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllDocumento1: TRLLabel
        Left = 476
        Top = 20
        Width = 150
        Height = 10
        Alignment = taCenter
        AutoSize = False
        Caption = 'DOCUMENTO AUXILIAR DA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllDocumento2: TRLLabel
        Left = 476
        Top = 30
        Width = 150
        Height = 10
        Alignment = taCenter
        AutoSize = False
        Caption = 'NOTA FISCAL ELETR'#212'NICA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllTipoEntrada: TRLLabel
        Left = 492
        Top = 44
        Width = 68
        Height = 14
        Caption = '0 - ENTRADA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllTipoSaida: TRLLabel
        Left = 492
        Top = 56
        Width = 51
        Height = 14
        Caption = '1 - SA'#205'DA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rliTipoEntrada: TRLDraw
        Left = 578
        Top = 44
        Width = 25
        Height = 25
      end
      object rllEntradaSaida: TRLLabel
        Left = 581
        Top = 47
        Width = 20
        Height = 20
        Alignment = taCenter
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllNumNF1: TRLLabel
        Left = 476
        Top = 72
        Width = 93
        Height = 16
        Caption = 'N'#186' 000.000.000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllSERIE1: TRLLabel
        Left = 476
        Top = 87
        Width = 150
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'S'#201'RIE 000'
      end
      object rliChave2: TRLDraw
        Left = 636
        Top = 40
        Width = 361
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsHorizontally
      end
      object rliChave3: TRLDraw
        Left = 636
        Top = 66
        Width = 361
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsHorizontally
      end
      object rlbCodigoBarras: TRLBarcode
        Left = 750
        Top = 3
        Width = 132
        Height = 35
        Alignment = taCenter
        BarcodeType = bcCode128C
        Margins.LeftMargin = 1.000000000000000000
        Margins.RightMargin = 1.000000000000000000
      end
      object rllChaveAcesso: TRLLabel
        Tag = 10
        Left = 639
        Top = 43
        Width = 71
        Height = 7
        Caption = 'CHAVE DE ACESSO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDadosVariaveis1a: TRLLabel
        Left = 640
        Top = 72
        Width = 354
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Consulta de autenticidade no portal nacional da NF-e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDadosVariaveis1b: TRLLabel
        Left = 640
        Top = 85
        Width = 354
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'www.nfe.fazenda.gov.br/portal ou no site da Sefaz autorizadora'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDadosVariaveis3_Descricao: TRLLabel
        Tag = 10
        Left = 639
        Top = 107
        Width = 140
        Height = 7
        Caption = 'PROTOCOLO DE AUTORIZA'#199#195'O DE USO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel28: TRLLabel
        Tag = 10
        Left = 3
        Top = 107
        Width = 95
        Height = 7
        Caption = 'NATUREZA DE OPERA'#199#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Holder = rliNatOpe
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel29: TRLLabel
        Tag = 10
        Left = 3
        Top = 133
        Width = 82
        Height = 7
        Caption = 'INSCRI'#199#195'O ESTADUAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel30: TRLLabel
        Tag = 10
        Left = 335
        Top = 133
        Width = 144
        Height = 7
        Caption = 'INSCRI'#199#195'O ESTADUAL DO SUBST. TRIB.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel31: TRLLabel
        Tag = 10
        Left = 667
        Top = 133
        Width = 21
        Height = 7
        Caption = 'CNPJ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rlmEmitente: TRLMemo
        Tag = 4
        Left = 116
        Top = 12
        Width = 342
        Height = 26
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlmEndereco: TRLMemo
        Tag = 3
        Left = 116
        Top = 38
        Width = 342
        Height = 24
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllFone: TRLLabel
        Tag = 3
        Left = 116
        Top = 64
        Width = 342
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rliLogo: TRLImage
        Left = 8
        Top = 16
        Width = 89
        Height = 81
        Center = True
        Scaled = True
      end
      object rllNatOperacao: TRLLabel
        Left = 7
        Top = 115
        Width = 602
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllDadosVariaveis3: TRLLabel
        Left = 643
        Top = 115
        Width = 350
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllInscricaoEstadual: TRLLabel
        Left = 7
        Top = 141
        Width = 314
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllInscrEstSubst: TRLLabel
        Left = 339
        Top = 141
        Width = 318
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllCNPJ: TRLLabel
        Left = 671
        Top = 141
        Width = 314
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllChave: TRLLabel
        Left = 643
        Top = 51
        Width = 334
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllEmitente: TRLLabel
        Tag = 10
        Left = 3
        Top = 3
        Width = 108
        Height = 7
        Caption = 'IDENTIFICA'#199'AO DO EMITENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllXmotivo: TRLLabel
        Left = 766
        Top = 9
        Width = 100
        Height = 22
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlbCodigoBarrasFS: TRLBarcode
        Left = 744
        Top = 70
        Width = 144
        Height = 33
        Alignment = taCenter
        BarcodeType = bcCode128C
        Margins.LeftMargin = 1.000000000000000000
        Margins.RightMargin = 1.000000000000000000
      end
      object rllPageNumber: TRLSystemInfo
        Left = 572
        Top = 72
        Width = 41
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Info = itPageNumber
        Text = 'FL. '
      end
      object rllLastPage: TRLSystemInfo
        Left = 608
        Top = 72
        Width = 24
        Height = 16
        AutoSize = False
        Info = itLastPageNumber
        Text = '/'
      end
      object RLDraw4: TRLDraw
        Left = 465
        Top = 0
        Width = 172
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsHorizontally
      end
      object RLDraw2: TRLDraw
        Left = 664
        Top = 130
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
    end
    object rlbDadosAdicionais: TRLBand
      Left = 99
      Top = 603
      Width = 998
      Height = 124
      AlignToBottom = True
      AutoExpand = False
      BandType = btFooter
      AfterPrint = rlbDadosAdicionaisAfterPrint
      BeforePrint = rlbDadosAdicionaisBeforePrint
      object RLDraw50: TRLDraw
        Left = 0
        Top = 4
        Width = 997
        Height = 112
      end
      object RLLabel77: TRLLabel
        Tag = 10
        Left = 35
        Top = 7
        Width = 124
        Height = 7
        Caption = 'INFORMA'#199#213'ES COMPLEMENTARES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel78: TRLLabel
        Tag = 10
        Left = 727
        Top = 7
        Width = 82
        Height = 7
        Caption = 'RESERVADO AO FISCO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rlmDadosAdicionais: TRLMemo
        Tag = 20
        Left = 39
        Top = 18
        Width = 706
        Height = 92
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Courier New'
        Font.Style = []
        IntegralHeight = True
        ParentFont = False
      end
      object rllHomologacao: TRLLabel
        Left = 423
        Top = 51
        Width = 152
        Height = 22
        Align = faCenter
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllUsuario: TRLLabel
        Tag = 10
        Left = 3
        Top = 117
        Width = 212
        Height = 7
        Caption = 'DATA / HORA DA IMPRESS'#195'O: 00/00/0000 00:00:00 - USUARIO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllSistema: TRLLabel
        Tag = 10
        Left = 818
        Top = 117
        Width = 176
        Height = 7
        Alignment = taRightJustify
        Caption = 'DESENVOLVIDO POR: EMPRESA RRRRRRRRRRRR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw5: TRLDraw
        Left = 32
        Top = 4
        Width = 1
        Height = 112
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLAngleLabel9: TRLAngleLabel
        Left = 13
        Top = 20
        Width = 10
        Height = 77
        Angle = 90.000000000000000000
        AngleBorders = True
        Caption = 'DADOS ADICIONAIS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Layout = tlCenter
        ParentFont = False
      end
      object RLDraw51: TRLDraw
        Left = 724
        Top = 4
        Width = 1
        Height = 112
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
    end
    object rlbDestinatario: TRLBand
      Left = 99
      Top = 184
      Width = 998
      Height = 80
      BandType = btTitle
      object RLDraw15: TRLDraw
        Left = 0
        Top = 0
        Width = 997
        Height = 79
      end
      object RLLabel32: TRLLabel
        Tag = 10
        Left = 35
        Top = 3
        Width = 80
        Height = 7
        Caption = 'NOME / RAZ'#195'O SOCIAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestNome: TRLLabel
        Left = 40
        Top = 11
        Width = 689
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel35: TRLLabel
        Tag = 10
        Left = 35
        Top = 29
        Width = 42
        Height = 7
        Caption = 'ENDERE'#199'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestEndereco: TRLLabel
        Left = 40
        Top = 37
        Width = 537
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel39: TRLLabel
        Tag = 10
        Left = 35
        Top = 55
        Width = 38
        Height = 7
        Caption = 'MUNIC'#205'PIO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestCidade: TRLLabel
        Left = 40
        Top = 63
        Width = 457
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel40: TRLLabel
        Tag = 10
        Left = 503
        Top = 55
        Width = 41
        Height = 7
        Caption = 'FONE / FAX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestFone: TRLLabel
        Left = 507
        Top = 63
        Width = 146
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel36: TRLLabel
        Tag = 10
        Left = 589
        Top = 29
        Width = 69
        Height = 7
        Caption = 'BAIRRO / DISTRITO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestBairro: TRLLabel
        Left = 593
        Top = 37
        Width = 192
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel41: TRLLabel
        Tag = 10
        Left = 684
        Top = 55
        Width = 11
        Height = 7
        Caption = 'UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestUF: TRLLabel
        Left = 688
        Top = 63
        Width = 38
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel33: TRLLabel
        Tag = 10
        Left = 741
        Top = 3
        Width = 41
        Height = 7
        Caption = 'CNPJ / CPF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestCNPJ: TRLLabel
        Left = 745
        Top = 11
        Width = 112
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel37: TRLLabel
        Tag = 10
        Left = 793
        Top = 29
        Width = 17
        Height = 7
        Caption = 'CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestCEP: TRLLabel
        Left = 797
        Top = 37
        Width = 60
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel42: TRLLabel
        Tag = 10
        Left = 741
        Top = 55
        Width = 82
        Height = 7
        Caption = 'INSCRI'#199#195'O ESTADUAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDestIE: TRLLabel
        Left = 745
        Top = 63
        Width = 112
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel34: TRLLabel
        Tag = 10
        Left = 882
        Top = 3
        Width = 68
        Height = 7
        Caption = 'DATA DA EMISS'#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllEmissao: TRLLabel
        Left = 886
        Top = 11
        Width = 80
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel38: TRLLabel
        Tag = 10
        Left = 882
        Top = 29
        Width = 87
        Height = 7
        Caption = 'DATA SA'#205'DA / ENTRADA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllSaida: TRLLabel
        Left = 886
        Top = 37
        Width = 80
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel43: TRLLabel
        Tag = 10
        Left = 882
        Top = 55
        Width = 58
        Height = 7
        Caption = 'HORA DA SA'#205'DA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllHoraSaida: TRLLabel
        Left = 886
        Top = 63
        Width = 80
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw16: TRLDraw
        Left = 32
        Top = 26
        Width = 965
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw17: TRLDraw
        Left = 32
        Top = 52
        Width = 965
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw22: TRLDraw
        Left = 500
        Top = 52
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw23: TRLDraw
        Left = 681
        Top = 52
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw20: TRLDraw
        Left = 586
        Top = 26
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw19: TRLDraw
        Left = 738
        Top = 0
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw24: TRLDraw
        Left = 738
        Top = 52
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw21: TRLDraw
        Left = 790
        Top = 26
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw18: TRLDraw
        Left = 879
        Top = 0
        Width = 1
        Height = 79
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLAngleLabel1: TRLAngleLabel
        Left = 6
        Top = 9
        Width = 10
        Height = 61
        Angle = 90.000000000000000000
        Caption = 'DESTINAT'#193'RIO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Layout = tlCenter
        ParentFont = False
      end
      object RLAngleLabel2: TRLAngleLabel
        Left = 19
        Top = 12
        Width = 10
        Height = 55
        Angle = 90.000000000000000000
        AngleBorders = True
        Caption = '/ REMETENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Layout = tlCenter
        ParentFont = False
      end
      object RLDraw13: TRLDraw
        Left = 32
        Top = 0
        Width = 1
        Height = 79
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
    end
    object rlbFatura: TRLBand
      Left = 99
      Top = 264
      Width = 998
      Height = 54
      BandType = btTitle
      object rliFatura: TRLDraw
        Left = 0
        Top = 0
        Width = 997
        Height = 53
      end
      object rllFatNum1: TRLLabel
        Left = 35
        Top = 15
        Width = 70
        Height = 10
        AutoSize = False
        Caption = '01'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum6: TRLLabel
        Left = 35
        Top = 27
        Width = 70
        Height = 10
        AutoSize = False
        Caption = '06'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum11: TRLLabel
        Left = 35
        Top = 39
        Width = 70
        Height = 10
        AutoSize = False
        Caption = '11'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData1: TRLLabel
        Left = 106
        Top = 15
        Width = 57
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '99/99/9999'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData6: TRLLabel
        Left = 106
        Top = 27
        Width = 57
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData11: TRLLabel
        Left = 106
        Top = 39
        Width = 57
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor1: TRLLabel
        Left = 162
        Top = 15
        Width = 60
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor6: TRLLabel
        Left = 162
        Top = 27
        Width = 60
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor11: TRLLabel
        Left = 162
        Top = 39
        Width = 60
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum2: TRLLabel
        Left = 228
        Top = 15
        Width = 70
        Height = 10
        AutoSize = False
        Caption = '02'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum7: TRLLabel
        Left = 228
        Top = 27
        Width = 70
        Height = 10
        AutoSize = False
        Caption = '07'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum12: TRLLabel
        Left = 228
        Top = 39
        Width = 70
        Height = 10
        AutoSize = False
        Caption = '12'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData2: TRLLabel
        Left = 299
        Top = 15
        Width = 57
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData7: TRLLabel
        Left = 299
        Top = 27
        Width = 57
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData12: TRLLabel
        Left = 299
        Top = 39
        Width = 57
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor2: TRLLabel
        Left = 355
        Top = 15
        Width = 60
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor7: TRLLabel
        Left = 355
        Top = 27
        Width = 60
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor12: TRLLabel
        Left = 355
        Top = 39
        Width = 60
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum3: TRLLabel
        Left = 421
        Top = 15
        Width = 70
        Height = 10
        AutoSize = False
        Caption = '03'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum8: TRLLabel
        Left = 421
        Top = 27
        Width = 70
        Height = 10
        AutoSize = False
        Caption = '08'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum13: TRLLabel
        Left = 421
        Top = 39
        Width = 70
        Height = 10
        AutoSize = False
        Caption = '13'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData3: TRLLabel
        Left = 492
        Top = 15
        Width = 57
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData8: TRLLabel
        Left = 492
        Top = 27
        Width = 57
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData13: TRLLabel
        Left = 492
        Top = 39
        Width = 57
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor3: TRLLabel
        Left = 548
        Top = 15
        Width = 60
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor8: TRLLabel
        Left = 548
        Top = 27
        Width = 60
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor13: TRLLabel
        Left = 548
        Top = 39
        Width = 60
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum4: TRLLabel
        Left = 614
        Top = 15
        Width = 70
        Height = 10
        AutoSize = False
        Caption = '04'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum9: TRLLabel
        Left = 614
        Top = 27
        Width = 70
        Height = 10
        AutoSize = False
        Caption = '09'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum14: TRLLabel
        Left = 614
        Top = 39
        Width = 70
        Height = 10
        AutoSize = False
        Caption = '14'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData4: TRLLabel
        Left = 685
        Top = 15
        Width = 57
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData9: TRLLabel
        Left = 685
        Top = 27
        Width = 57
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData14: TRLLabel
        Left = 685
        Top = 39
        Width = 57
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor4: TRLLabel
        Left = 741
        Top = 15
        Width = 60
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor9: TRLLabel
        Left = 741
        Top = 27
        Width = 60
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor14: TRLLabel
        Left = 741
        Top = 39
        Width = 60
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum5: TRLLabel
        Left = 807
        Top = 15
        Width = 70
        Height = 10
        AutoSize = False
        Caption = '05'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum10: TRLLabel
        Left = 807
        Top = 27
        Width = 70
        Height = 10
        AutoSize = False
        Caption = '10'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatNum15: TRLLabel
        Left = 807
        Top = 39
        Width = 70
        Height = 10
        AutoSize = False
        Caption = '15'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData15: TRLLabel
        Left = 878
        Top = 39
        Width = 57
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData10: TRLLabel
        Left = 878
        Top = 27
        Width = 57
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatData5: TRLLabel
        Left = 878
        Top = 15
        Width = 57
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'XX/XX/XXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor5: TRLLabel
        Left = 934
        Top = 15
        Width = 60
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor10: TRLLabel
        Left = 934
        Top = 27
        Width = 60
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatValor15: TRLLabel
        Left = 934
        Top = 39
        Width = 60
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '9.999.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel12: TRLLabel
        Left = 33
        Top = 1
        Width = 962
        Height = 11
        AutoSize = False
        Caption = '  '
        Color = 14540253
        ParentColor = False
        Transparent = False
      end
      object rliFatura1: TRLDraw
        Left = 32
        Top = 0
        Width = 1
        Height = 53
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object rliFatura2: TRLDraw
        Left = 225
        Top = 0
        Width = 1
        Height = 53
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object rliFatura3: TRLDraw
        Left = 418
        Top = 0
        Width = 1
        Height = 53
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object rliFatura4: TRLDraw
        Left = 611
        Top = 0
        Width = 1
        Height = 53
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object rliFatura5: TRLDraw
        Left = 804
        Top = 0
        Width = 1
        Height = 53
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object RLDraw69: TRLDraw
        Left = 32
        Top = 12
        Width = 965
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rllCabFatura1: TRLLabel
        Tag = 10
        Left = 39
        Top = 3
        Width = 54
        Height = 7
        Alignment = taCenter
        Caption = 'N'#186' DUPLICATA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllCabFatura2: TRLLabel
        Tag = 10
        Left = 124
        Top = 3
        Width = 24
        Height = 7
        Alignment = taCenter
        Caption = 'VENC.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllCabFatura3: TRLLabel
        Tag = 10
        Left = 187
        Top = 3
        Width = 26
        Height = 7
        Alignment = taCenter
        Caption = 'VALOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel1: TRLLabel
        Tag = 10
        Left = 232
        Top = 3
        Width = 54
        Height = 7
        Alignment = taCenter
        Caption = 'N'#186' DUPLICATA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel2: TRLLabel
        Tag = 10
        Left = 317
        Top = 3
        Width = 24
        Height = 7
        Alignment = taCenter
        Caption = 'VENC.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel3: TRLLabel
        Tag = 10
        Left = 380
        Top = 3
        Width = 26
        Height = 7
        Alignment = taCenter
        Caption = 'VALOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel4: TRLLabel
        Tag = 10
        Left = 425
        Top = 3
        Width = 54
        Height = 7
        Alignment = taCenter
        Caption = 'N'#186' DUPLICATA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel5: TRLLabel
        Tag = 10
        Left = 510
        Top = 3
        Width = 24
        Height = 7
        Alignment = taCenter
        Caption = 'VENC.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel6: TRLLabel
        Tag = 10
        Left = 573
        Top = 3
        Width = 26
        Height = 7
        Alignment = taCenter
        Caption = 'VALOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel7: TRLLabel
        Tag = 10
        Left = 618
        Top = 3
        Width = 54
        Height = 7
        Alignment = taCenter
        Caption = 'N'#186' DUPLICATA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel8: TRLLabel
        Tag = 10
        Left = 703
        Top = 3
        Width = 24
        Height = 7
        Alignment = taCenter
        Caption = 'VENC.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel9: TRLLabel
        Tag = 10
        Left = 766
        Top = 3
        Width = 26
        Height = 7
        Alignment = taCenter
        Caption = 'VALOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel57: TRLLabel
        Tag = 10
        Left = 811
        Top = 3
        Width = 54
        Height = 7
        Alignment = taCenter
        Caption = 'N'#186' DUPLICATA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel58: TRLLabel
        Tag = 10
        Left = 896
        Top = 3
        Width = 24
        Height = 7
        Alignment = taCenter
        Caption = 'VENC.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel79: TRLLabel
        Tag = 10
        Left = 959
        Top = 3
        Width = 26
        Height = 7
        Alignment = taCenter
        Caption = 'VALOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllFatura: TRLAngleLabel
        Left = 13
        Top = 9
        Width = 10
        Height = 34
        Angle = 90.000000000000000000
        AngleBorders = True
        Caption = 'FATURA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Layout = tlCenter
        ParentFont = False
      end
    end
    object rlbImposto: TRLBand
      Left = 99
      Top = 318
      Width = 998
      Height = 58
      BandType = btTitle
      object RLDraw29: TRLDraw
        Left = 0
        Top = 0
        Width = 997
        Height = 57
      end
      object RLLabel25: TRLLabel
        Left = 790
        Top = 29
        Width = 205
        Height = 26
        AutoSize = False
        Caption = '  '
        Color = 14540253
        ParentColor = False
        Transparent = False
      end
      object RLLabel44: TRLLabel
        Tag = 10
        Left = 35
        Top = 3
        Width = 100
        Height = 7
        Caption = 'BASE DE C'#193'LCULO DO ICMS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllBaseICMS: TRLLabel
        Left = 39
        Top = 11
        Width = 186
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel49: TRLLabel
        Tag = 10
        Left = 35
        Top = 31
        Width = 64
        Height = 7
        Caption = 'VALOR DO FRETE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllValorFrete: TRLLabel
        Left = 39
        Top = 39
        Width = 136
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel45: TRLLabel
        Tag = 10
        Left = 233
        Top = 3
        Width = 57
        Height = 7
        Caption = 'VALOR DO ICMS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllValorICMS: TRLLabel
        Left = 237
        Top = 11
        Width = 186
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel50: TRLLabel
        Tag = 10
        Left = 184
        Top = 31
        Width = 70
        Height = 7
        Caption = 'VALOR DO SEGURO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllValorSeguro: TRLLabel
        Left = 188
        Top = 39
        Width = 136
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel51: TRLLabel
        Tag = 10
        Left = 333
        Top = 31
        Width = 42
        Height = 7
        Caption = 'DESCONTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllDescontos: TRLLabel
        Left = 337
        Top = 39
        Width = 136
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel46: TRLLabel
        Tag = 10
        Left = 432
        Top = 3
        Width = 120
        Height = 7
        Caption = 'BASE C'#193'LC. ICMS SUBSTITUI'#199#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllBaseICMST: TRLLabel
        Left = 436
        Top = 11
        Width = 186
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel52: TRLLabel
        Tag = 10
        Left = 482
        Top = 31
        Width = 90
        Height = 7
        Caption = 'OUTRAS DESP. ACCESS.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllAcessorias: TRLLabel
        Left = 486
        Top = 39
        Width = 136
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel47: TRLLabel
        Tag = 10
        Left = 631
        Top = 3
        Width = 113
        Height = 7
        Caption = 'VALOR DO ICMS SUBSTITUI'#199#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllValorICMST: TRLLabel
        Left = 635
        Top = 11
        Width = 148
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel53: TRLLabel
        Tag = 10
        Left = 631
        Top = 31
        Width = 49
        Height = 7
        Caption = 'VALOR DO IPI'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllValorIPI: TRLLabel
        Left = 635
        Top = 39
        Width = 148
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel48: TRLLabel
        Tag = 10
        Left = 792
        Top = 3
        Width = 111
        Height = 7
        Caption = 'VALOR TOTAL DOS PRODUTOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTotalProdutos: TRLLabel
        Left = 796
        Top = 11
        Width = 194
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw30: TRLDraw
        Left = 32
        Top = 28
        Width = 965
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw32: TRLDraw
        Left = 230
        Top = 0
        Width = 1
        Height = 29
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw33: TRLDraw
        Left = 181
        Top = 28
        Width = 1
        Height = 29
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw34: TRLDraw
        Left = 330
        Top = 28
        Width = 1
        Height = 29
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw35: TRLDraw
        Left = 479
        Top = 28
        Width = 1
        Height = 29
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw36: TRLDraw
        Left = 628
        Top = 0
        Width = 1
        Height = 57
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw31: TRLDraw
        Left = 429
        Top = 0
        Width = 1
        Height = 29
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw37: TRLDraw
        Left = 789
        Top = 0
        Width = 1
        Height = 57
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLLabel54: TRLLabel
        Tag = 10
        Left = 792
        Top = 31
        Width = 86
        Height = 7
        Caption = 'VALOR TOTAL DA NOTA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTotalNF: TRLLabel
        Left = 796
        Top = 39
        Width = 194
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw53: TRLDraw
        Left = 32
        Top = 0
        Width = 1
        Height = 57
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLAngleLabel4: TRLAngleLabel
        Left = 6
        Top = 7
        Width = 10
        Height = 42
        Angle = 90.000000000000000000
        Caption = 'C'#193'LCULO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Layout = tlCenter
        ParentFont = False
      end
      object RLAngleLabel5: TRLAngleLabel
        Left = 19
        Top = 2
        Width = 10
        Height = 52
        Angle = 90.000000000000000000
        AngleBorders = True
        Caption = 'DO IMPOSTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Layout = tlCenter
        ParentFont = False
      end
    end
    object rlbTransportadora: TRLBand
      Left = 99
      Top = 376
      Width = 998
      Height = 80
      BandType = btTitle
      object RLDraw40: TRLDraw
        Left = 0
        Top = 0
        Width = 997
        Height = 79
        HoldStyle = hsRelatively
      end
      object RLLabel55: TRLLabel
        Tag = 10
        Left = 35
        Top = 3
        Width = 54
        Height = 7
        Caption = 'RAZ'#195'O SOCIAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransNome: TRLLabel
        Left = 39
        Top = 11
        Width = 458
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel63: TRLLabel
        Tag = 10
        Left = 35
        Top = 29
        Width = 42
        Height = 7
        Caption = 'ENDERE'#199'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransEndereco: TRLLabel
        Left = 39
        Top = 37
        Width = 458
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel67: TRLLabel
        Tag = 10
        Left = 35
        Top = 55
        Width = 49
        Height = 7
        Caption = 'QUANTIDADE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransQTDE: TRLLabel
        Left = 39
        Top = 63
        Width = 79
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel68: TRLLabel
        Tag = 10
        Left = 126
        Top = 55
        Width = 34
        Height = 7
        Caption = 'ESP'#201'CIE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransEspecie: TRLLabel
        Left = 130
        Top = 63
        Width = 151
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel69: TRLLabel
        Tag = 10
        Left = 293
        Top = 55
        Width = 27
        Height = 7
        Caption = 'MARCA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransMarca: TRLLabel
        Left = 297
        Top = 63
        Width = 200
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel56: TRLLabel
        Tag = 10
        Left = 503
        Top = 3
        Width = 70
        Height = 7
        Caption = 'FRETE POR CONTA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel64: TRLLabel
        Tag = 10
        Left = 503
        Top = 29
        Width = 38
        Height = 7
        Caption = 'MUNIC'#205'PIO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransCidade: TRLLabel
        Left = 507
        Top = 37
        Width = 262
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel70: TRLLabel
        Tag = 10
        Left = 503
        Top = 55
        Width = 47
        Height = 7
        Caption = 'NUMERA'#199#195'O'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransNumeracao: TRLLabel
        Left = 507
        Top = 63
        Width = 102
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel59: TRLLabel
        Tag = 10
        Left = 619
        Top = 3
        Width = 51
        Height = 7
        Caption = 'C'#211'DIGO ANTT'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransCodigoANTT: TRLLabel
        Left = 623
        Top = 11
        Width = 66
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel60: TRLLabel
        Tag = 10
        Left = 696
        Top = 3
        Width = 71
        Height = 7
        Caption = 'PLACA DO VE'#205'CULO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransPlaca: TRLLabel
        Left = 700
        Top = 11
        Width = 66
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel71: TRLLabel
        Tag = 10
        Left = 618
        Top = 55
        Width = 49
        Height = 7
        Caption = 'PESO BRUTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransPesoBruto: TRLLabel
        Left = 623
        Top = 63
        Width = 178
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel61: TRLLabel
        Tag = 10
        Left = 776
        Top = 3
        Width = 11
        Height = 7
        Caption = 'UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransUFPlaca: TRLLabel
        Left = 780
        Top = 11
        Width = 21
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel65: TRLLabel
        Tag = 10
        Left = 776
        Top = 29
        Width = 11
        Height = 7
        Caption = 'UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransUF: TRLLabel
        Left = 780
        Top = 37
        Width = 21
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel62: TRLLabel
        Tag = 10
        Left = 810
        Top = 3
        Width = 41
        Height = 7
        Caption = 'CNPJ / CPF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransCNPJ: TRLLabel
        Left = 813
        Top = 11
        Width = 180
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel66: TRLLabel
        Tag = 10
        Left = 810
        Top = 29
        Width = 82
        Height = 7
        Caption = 'INSCRI'#199#195'O ESTADUAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransIE: TRLLabel
        Left = 813
        Top = 37
        Width = 180
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw38: TRLDraw
        Left = 32
        Top = 26
        Width = 965
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw39: TRLDraw
        Left = 32
        Top = 52
        Width = 965
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw46: TRLDraw
        Left = 123
        Top = 52
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw45: TRLDraw
        Left = 290
        Top = 52
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw41: TRLDraw
        Left = 500
        Top = 0
        Width = 1
        Height = 29
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw44: TRLDraw
        Left = 615
        Top = 52
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw47: TRLDraw
        Left = 616
        Top = 0
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw48: TRLDraw
        Left = 693
        Top = 0
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw49: TRLDraw
        Left = 773
        Top = 0
        Width = 1
        Height = 53
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw42: TRLDraw
        Left = 806
        Top = 0
        Width = 1
        Height = 79
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rllTransModFrete: TRLLabel
        Left = 507
        Top = 11
        Width = 106
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel72: TRLLabel
        Tag = 10
        Left = 810
        Top = 55
        Width = 52
        Height = 7
        Caption = 'PESO L'#205'QUIDO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object rllTransPesoLiq: TRLLabel
        Left = 813
        Top = 63
        Width = 178
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw70: TRLDraw
        Left = 500
        Top = 26
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw71: TRLDraw
        Left = 500
        Top = 52
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw55: TRLDraw
        Left = 32
        Top = 0
        Width = 1
        Height = 79
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLAngleLabel6: TRLAngleLabel
        Left = 6
        Top = 2
        Width = 10
        Height = 74
        Angle = 90.000000000000000000
        Caption = 'TRANSPORTADOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Layout = tlCenter
        ParentFont = False
      end
      object RLAngleLabel7: TRLAngleLabel
        Left = 19
        Top = 11
        Width = 10
        Height = 56
        Angle = 90.000000000000000000
        AngleBorders = True
        Caption = 'VOL. TRANSP.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Layout = tlCenter
        ParentFont = False
      end
    end
    object rlbItens: TRLBand
      Left = 99
      Top = 510
      Width = 998
      Height = 13
      Background.Height = 487
      Background.Width = 865
      AfterPrint = rlbItensAfterPrint
      BeforePrint = rlbItensBeforePrint
      object RLLabel101: TRLLabel
        Left = 680
        Top = 16
        Width = 72
        Height = 16
      end
      object LinhaFimItens: TRLDraw
        Left = 0
        Top = 12
        Width = 997
        Height = 1
        Align = faBottomOnly
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object pnlDescricao1: TRLPanel
        Left = 0
        Top = 0
        Width = 497
        Height = 13
        Align = faLeftMost
        AutoExpand = True
        object txtCodigo: TRLDBText
          Left = 2
          Top = 1
          Width = 51
          Height = 11
          AutoSize = False
          DataField = 'CODIGO'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object LinhaProd2: TRLDraw
          Left = 54
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object LinhaProd1: TRLDraw
          Left = 0
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object rlmDescricao: TRLDBMemo
          Left = 128
          Top = 1
          Width = 337
          Height = 10
          DataField = 'DESCRICAO'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object txtEAN: TRLDBText
          Left = 55
          Top = 1
          Width = 70
          Height = 10
          AutoSize = False
          DataField = 'EAN'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object LinhaProdEAN: TRLDraw
          Left = 126
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
      end
      object pnlDescricao2: TRLPanel
        Left = 496
        Top = 0
        Width = 501
        Height = 13
        object txtNCM: TRLDBText
          Left = 1
          Top = 1
          Width = 42
          Height = 11
          AutoSize = False
          DataField = 'NCM'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object txtCST: TRLDBText
          Left = 44
          Top = 1
          Width = 22
          Height = 11
          Alignment = taCenter
          AutoSize = False
          DataField = 'CST'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object txtCFOP: TRLDBText
          Left = 68
          Top = 1
          Width = 21
          Height = 11
          AutoSize = False
          DataField = 'CFOP'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object txtUnidade: TRLDBText
          Left = 92
          Top = 1
          Width = 19
          Height = 11
          AutoSize = False
          DataField = 'UNIDADE'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object txtQuantidade: TRLDBText
          Left = 113
          Top = 1
          Width = 50
          Height = 11
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'QTDE'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object txtValorUnitario: TRLDBText
          Left = 164
          Top = 1
          Width = 50
          Height = 11
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALOR'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object txtValorTotal: TRLDBText
          Left = 215
          Top = 1
          Width = 52
          Height = 11
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'TOTAL'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object txtValorDesconto: TRLDBText
          Left = 269
          Top = 1
          Width = 44
          Height = 11
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALORDESC'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object txtBaseICMS: TRLDBText
          Left = 316
          Top = 1
          Width = 52
          Height = 11
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'BICMS'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object txtValorICMS: TRLDBText
          Left = 371
          Top = 1
          Width = 38
          Height = 11
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALORICMS'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object txtValorIPI: TRLDBText
          Left = 412
          Top = 1
          Width = 37
          Height = 11
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALORIPI'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object txtAliqICMS: TRLDBText
          Left = 452
          Top = 1
          Width = 23
          Height = 11
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'ALIQICMS'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object txtAliqIPI: TRLDBText
          Left = 477
          Top = 1
          Width = 23
          Height = 11
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'ALIQIPI'
          DataSource = DataSource1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object LinhaProd4: TRLDraw
          Left = 43
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object LinhaProd5: TRLDraw
          Left = 66
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object LinhaProd6: TRLDraw
          Left = 90
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object LinhaProd7: TRLDraw
          Left = 112
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object LinhaProd8: TRLDraw
          Left = 164
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object LinhaProd9: TRLDraw
          Left = 215
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object LinhaProd10: TRLDraw
          Left = 268
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object LinhaProd11: TRLDraw
          Left = 314
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object LinhaProd12: TRLDraw
          Left = 369
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object LinhaProd13: TRLDraw
          Left = 410
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object LinhaProd14: TRLDraw
          Left = 450
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object LinhaProd15: TRLDraw
          Left = 475
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object LinhaProd16: TRLDraw
          Left = 500
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
        object LinhaProd3: TRLDraw
          Left = 0
          Top = 0
          Width = 1
          Height = 13
          Align = faHeight
          Angle = 90.000000000000000000
          DrawKind = dkLine
          HoldStyle = hsRelatively
        end
      end
    end
    object rlbISSQN: TRLBand
      Left = 99
      Top = 574
      Width = 998
      Height = 29
      BandType = btFooter
      object RLDraw52: TRLDraw
        Left = 0
        Top = 0
        Width = 997
        Height = 27
      end
      object RLLabel73: TRLLabel
        Tag = 10
        Left = 35
        Top = 3
        Width = 81
        Height = 7
        Caption = 'INSCRI'#199#195'O MUNICIPAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel74: TRLLabel
        Tag = 10
        Left = 276
        Top = 3
        Width = 108
        Height = 7
        Caption = 'VALOR TOTAL DOS SERVI'#199'OS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel75: TRLLabel
        Tag = 10
        Left = 517
        Top = 3
        Width = 105
        Height = 7
        Caption = 'BASE DE C'#193'LCULO DO ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLLabel76: TRLLabel
        Tag = 10
        Left = 759
        Top = 3
        Width = 62
        Height = 7
        Caption = 'VALOR DO ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        HoldStyle = hsRelatively
        ParentFont = False
      end
      object RLDraw56: TRLDraw
        Left = 273
        Top = 0
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw57: TRLDraw
        Left = 514
        Top = 0
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLDraw58: TRLDraw
        Left = 756
        Top = 0
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rllISSQNValorServicos: TRLLabel
        Left = 279
        Top = 11
        Width = 220
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllISSQNBaseCalculo: TRLLabel
        Left = 521
        Top = 11
        Width = 220
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllISSQNValorISSQN: TRLLabel
        Left = 763
        Top = 11
        Width = 220
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllISSQNInscricao: TRLLabel
        Left = 39
        Top = 11
        Width = 220
        Height = 14
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw3: TRLDraw
        Left = 32
        Top = 0
        Width = 1
        Height = 27
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object RLAngleLabel8: TRLAngleLabel
        Left = 13
        Top = 1
        Width = 7
        Height = 24
        Angle = 90.000000000000000000
        AngleBorders = True
        Caption = 'ISSQN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Layout = tlCenter
        ParentFont = False
      end
    end
    object rlbAvisoContingencia: TRLBand
      Left = 99
      Top = 456
      Width = 998
      Height = 28
      BandType = btColumnHeader
      object rllContingencia: TRLLabel
        Left = 349
        Top = 16
        Width = 302
        Height = 12
        Alignment = taCenter
        Caption = 
          'Data / Hora da entrada em conting'#234'ncia: 00/00/0000 00:00:00  Mot' +
          'ivo: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object rllAvisoContingencia: TRLLabel
        Left = 432
        Top = 0
        Width = 136
        Height = 16
        Alignment = taCenter
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
    end
    object rlmDadosAdicionaisAuxiliar: TRLMemo
      Left = 64
      Top = 704
      Width = 681
      Height = 12
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Courier New'
      Font.Style = []
      IntegralHeight = True
      ParentColor = False
      ParentFont = False
      Transparent = False
      Visible = False
    end
    object pnlCanhoto: TRLPanel
      Left = 26
      Top = 26
      Width = 57
      Height = 742
      Align = faLeftMost
      object rliCanhoto: TRLDraw
        Left = 0
        Top = 0
        Width = 57
        Height = 740
      end
      object rliCanhoto3: TRLDraw
        Left = 0
        Top = 138
        Width = 57
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object rliCanhoto1: TRLDraw
        Left = 25
        Top = 138
        Width = 1
        Height = 602
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object rliCanhoto2: TRLDraw
        Left = 25
        Top = 617
        Width = 32
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsVertically
      end
      object rllNFe: TRLAngleLabel
        Tag = 1
        Left = 4
        Top = 53
        Width = 16
        Height = 32
        Angle = 90.000000000000000000
        Caption = 'NF-e'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Layout = tlCenter
        ParentFont = False
      end
      object rllNumNF0: TRLAngleLabel
        Tag = 1
        Left = 22
        Top = 22
        Width = 16
        Height = 93
        Angle = 90.000000000000000000
        Caption = 'N'#186' 000.000.000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Layout = tlCenter
        ParentFont = False
      end
      object rllSERIE0: TRLAngleLabel
        Tag = 1
        Left = 38
        Top = 35
        Width = 16
        Height = 68
        Angle = 90.000000000000000000
        Caption = 'S'#201'RIE 000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Layout = tlCenter
        ParentFont = False
      end
      object rllIdentificacao: TRLAngleLabel
        Tag = 1
        Left = 28
        Top = 440
        Width = 7
        Height = 172
        Angle = 90.000000000000000000
        Caption = 'IDENTIFICA'#199#195'O E ASSINATURA DO RECEBEDOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Layout = tlBottom
        ParentFont = False
      end
      object rllDataRecebimento: TRLAngleLabel
        Tag = 1
        Left = 28
        Top = 646
        Width = 7
        Height = 88
        Angle = 90.000000000000000000
        Caption = 'DATA DE RECEBIMENTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Layout = tlBottom
        ParentFont = False
      end
      object rllRecebemosDe: TRLAngleLabel
        Tag = 1
        Left = 4
        Top = 428
        Width = 7
        Height = 307
        Angle = 90.000000000000000000
        Caption = 
          'RECEBEMOS DE %s OS PRODUTOS CONSTANTES DA NOTA FISCAL INDICADO A' +
          'O LADO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -7
        Font.Name = 'Arial'
        Font.Style = []
        Layout = tlBottom
        ParentFont = False
      end
      object rllResumo: TRLAngleLabel
        Tag = 1
        Left = 14
        Top = 195
        Width = 10
        Height = 486
        Angle = 90.000000000000000000
        Caption = 
          'DATA DE EMISS'#195'O: 00/00/0000  -  DEST./REM.: XXXXXXXXXXXXXXXXXXXX' +
          'XXXXXXXXXXXXXXXXXXXXX  -  VALOR TOTAL: R$ 0.000,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Layout = tlCenter
        ParentFont = False
      end
    end
    object pnlDivisao: TRLPanel
      Left = 83
      Top = 26
      Width = 16
      Height = 742
      Align = faLeftMost
      object rliDivisao: TRLDraw
        Left = 0
        Top = 0
        Width = 16
        Height = 742
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsVertically
        Pen.Style = psDot
      end
    end
    object rlbObsItem: TRLBand
      Left = 99
      Top = 523
      Width = 998
      Height = 16
      BeforePrint = rlbObsItemBeforePrint
      object LinhaFimObsItem: TRLDraw
        Left = 0
        Top = 10
        Width = 997
        Height = 1
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaInicioItem: TRLDraw
        Left = 0
        Top = 15
        Width = 997
        Height = 1
        Align = faBottomOnly
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaObsItemEsquerda: TRLDraw
        Left = 0
        Top = 0
        Width = 1
        Height = 10
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object LinhaObsItemDireita: TRLDraw
        Left = 996
        Top = 0
        Width = 1
        Height = 10
        Angle = 90.000000000000000000
        DrawKind = dkLine
        HoldStyle = hsRelatively
      end
      object rlmObsItem: TRLMemo
        Tag = 20
        Left = 1
        Top = 1
        Width = 952
        Height = 8
        Borders.Style = bsClear
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 'FortesReport v3.23 \251 Copyright '#169' 1999-2004 Fortes Inform'#225'tica'
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    ShowProgress = False
    Left = 923
    Top = 45
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 952
    Top = 45
    object cdsItensCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 60
    end
    object cdsItensEAN: TStringField
      FieldName = 'EAN'
      Size = 14
    end
    object cdsItensDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 120
    end
    object cdsItensNCM: TStringField
      FieldName = 'NCM'
      Size = 8
    end
    object cdsItensCFOP: TStringField
      FieldName = 'CFOP'
      Size = 4
    end
    object cdsItensUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Size = 6
    end
    object cdsItensQTDE: TStringField
      FieldName = 'QTDE'
      Size = 18
    end
    object cdsItensVALOR: TStringField
      FieldName = 'VALOR'
      Size = 18
    end
    object cdsItensVALORDESC: TStringField
      DisplayWidth = 18
      FieldName = 'VALORDESC'
    end
    object cdsItensTOTAL: TStringField
      FieldName = 'TOTAL'
      Size = 18
    end
    object cdsItensCSOSN: TStringField
      FieldName = 'CST'
      Size = 3
    end
    object cdsItensCST2: TStringField
      DisplayWidth = 4
      FieldName = 'CSOSN'
      Size = 4
    end
    object cdsItensBICMS: TStringField
      FieldName = 'BICMS'
      Size = 18
    end
    object cdsItensALIQICMS: TStringField
      FieldName = 'ALIQICMS'
      Size = 6
    end
    object cdsItensVALORICMS: TStringField
      FieldName = 'VALORICMS'
      Size = 18
    end
    object cdsItensALIQIPI: TStringField
      FieldName = 'ALIQIPI'
      Size = 6
    end
    object cdsItensVALORIPI: TStringField
      FieldName = 'VALORIPI'
      Size = 18
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsItens
    Left = 987
    Top = 44
  end
end
