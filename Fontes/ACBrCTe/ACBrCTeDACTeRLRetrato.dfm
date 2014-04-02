inherited frmDACTeRLRetrato: TfrmDACTeRLRetrato
  Left = 304
  Height = 439
  Top = 241
  Width = 810
  VertScrollBar.Position = 24
  Caption = 'DACTe - Retrato'
  ClientHeight = 439
  ClientWidth = 810
  Font.Height = -8
  Font.Name = 'Arial'
  Font.Style = [fsBold]
  inherited RLCTe: TRLReport
    Left = 16
    Top = -728
    Background.Arrange = baDistributed
    Background.Height = 96
    Background.Width = 175
    DataSource = Datasource1
    Font.Height = -8
    Font.Name = 'Courier New'
    Margins.LeftMargin = 7
    Margins.TopMargin = 7
    Margins.RightMargin = 7
    Margins.BottomMargin = 7
    PreviewOptions.FormStyle = fsStayOnTop
    PreviewOptions.ShowModal = True
    PreviewOptions.Caption = 'DACT-e'
    Title = 'DACT-e Retrato'
    BeforePrint = RLCTeBeforePrint
    object rlb_08_Itens: TRLBand[0]
      Left = 26
      Height = 13
      Top = 1076
      Width = 742
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_08_ItensBeforePrint
      object RLDraw29: TRLDraw
        Left = 370
        Height = 13
        Top = 0
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw28: TRLDraw
        Left = 0
        Height = 14
        Top = 0
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw35: TRLDraw
        Left = 740
        Height = 14
        Top = 0
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsFimItens: TRLDraw
        Left = 0
        Height = 4
        Top = 13
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rldbtTpDoc2: TRLDBText
        Left = 373
        Height = 13
        Top = 1
        Width = 76
        AutoSize = False
        Color = clWhite
        DataField = 'TIPO_2'
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rldbtTpDoc1: TRLDBText
        Left = 5
        Height = 13
        Top = 1
        Width = 76
        AutoSize = False
        Color = clWhite
        DataField = 'TIPO_1'
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rldbtDocumento2: TRLDBText
        Left = 542
        Height = 13
        Top = 1
        Width = 195
        AutoSize = False
        Color = clWhite
        DataField = 'DOCUMENTO_2'
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rldbtDocumento1: TRLDBText
        Left = 174
        Height = 13
        Top = 1
        Width = 195
        AutoSize = False
        Color = clWhite
        DataField = 'DOCUMENTO_1'
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rldbtCnpjEmitente2: TRLDBText
        Left = 456
        Height = 12
        Top = 1
        Width = 51
        Color = clWhite
        DataField = 'CNPJCPF_2'
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rldbtCnpjEmitente1: TRLDBText
        Left = 88
        Height = 12
        Top = 1
        Width = 51
        Color = clWhite
        DataField = 'CNPJCPF_1'
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
    end
    object rlb_01_Recibo: TRLBand[1]
      Left = 26
      Height = 82
      Top = 26
      Width = 742
      BandType = btHeader
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_01_ReciboBeforePrint
      object RLDraw46: TRLDraw
        Left = 0
        Height = 78
        Top = 0
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw49: TRLDraw
        Left = 1
        Height = 1
        Top = 51
        Width = 201
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw50: TRLDraw
        Left = 593
        Height = 52
        Top = 25
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw51: TRLDraw
        Left = 473
        Height = 52
        Top = 25
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw52: TRLDraw
        Left = 202
        Height = 52
        Top = 25
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw48: TRLDraw
        Left = 1
        Height = 1
        Top = 25
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllSerie2: TRLLabel
        Left = 655
        Height = 13
        Top = 57
        Width = 50
        Alignment = taCenter
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllNumCTe2: TRLLabel
        Left = 638
        Height = 16
        Top = 43
        Width = 86
        Alignment = taRightJustify
        AutoSize = False
        Caption = '999999999'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlLabel3: TRLLabel
        Left = 480
        Height = 16
        Top = 59
        Width = 108
        Alignment = taCenter
        AutoSize = False
        Caption = '__/__/__    __:__'
        Color = clWhite
        Font.CharSet = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlLabel143: TRLLabel
        Left = 480
        Height = 16
        Top = 35
        Width = 108
        Alignment = taCenter
        AutoSize = False
        Caption = '__/__/__    __:__'
        Color = clWhite
        Font.CharSet = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlLabel140: TRLLabel
        Left = 647
        Height = 13
        Top = 27
        Width = 28
        Caption = 'CT-E'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlLabel139: TRLLabel
        Left = 605
        Height = 12
        Top = 43
        Width = 14
        Caption = 'Nº '
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlLabel138: TRLLabel
        Left = 605
        Height = 12
        Top = 57
        Width = 30
        Caption = 'SÉRIE:'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel137: TRLLabel
        Left = 6
        Height = 15
        Top = 2
        Width = 732
        Alignment = taCenter
        AutoSize = False
        Caption = 'DECLARO QUE RECEBI OS VOLUMES DESTE CONHECIMENTO EM PERFEITO ESTADO PELO QUE DOU POR CUMPRIDO O PRESENTE CONTRATO DE TRANSPORTE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel136: TRLLabel
        Left = 6
        Height = 12
        Top = 32
        Width = 30
        Caption = 'NOME'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel135: TRLLabel
        Left = 480
        Height = 9
        Top = 27
        Width = 108
        Alignment = taCenter
        AutoSize = False
        Caption = 'CHEGADA DATA/HORA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel134: TRLLabel
        Left = 480
        Height = 9
        Top = 50
        Width = 108
        Alignment = taCenter
        AutoSize = False
        Caption = 'SAÍDA DATA/HORA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel133: TRLLabel
        Left = 207
        Height = 13
        Top = 58
        Width = 262
        Alignment = taCenter
        AutoSize = False
        Caption = 'ASSINATURA / CARIMBO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel132: TRLLabel
        Left = 6
        Height = 12
        Top = 56
        Width = 15
        Caption = 'RG'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlsLinhaPontilhada: TRLDraw
        Left = 0
        Height = 1
        Top = 79
        Width = 741
        Angle = 0
        DrawKind = dkLine
        Pen.Style = psDot
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllResumoCanhotoCTe: TRLLabel
        Left = 6
        Height = 13
        Top = 12
        Width = 732
        Alignment = taCenter
        AutoSize = False
        Caption = 'RESUMO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
    end
    object rlb_07_HeaderItens: TRLBand[2]
      Left = 26
      Height = 24
      Top = 1052
      Width = 742
      BandType = btColumnHeader
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_07_HeaderItensBeforePrint
      object rlsQuadro07: TRLDraw
        Left = 0
        Height = 27
        Top = 0
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw32: TRLDraw
        Left = 1
        Height = 1
        Top = 15
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw34: TRLDraw
        Left = 370
        Height = 11
        Top = 14
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel96: TRLLabel
        Left = 174
        Height = 8
        Top = 16
        Width = 86
        Caption = 'SÉRIE/NRO. DOCUMENTO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel92: TRLLabel
        Left = 88
        Height = 8
        Top = 16
        Width = 69
        Caption = 'CNPJ/CPF EMITENTE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel91: TRLLabel
        Left = 5
        Height = 8
        Top = 16
        Width = 29
        Caption = 'TP DOC.'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel20: TRLLabel
        Left = 6
        Height = 13
        Top = 2
        Width = 732
        Alignment = taCenter
        AutoSize = False
        Caption = 'DOCUMENTOS ORIGINÁRIOS'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel109: TRLLabel
        Left = 373
        Height = 8
        Top = 16
        Width = 29
        Caption = 'TP DOC.'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel106: TRLLabel
        Left = 456
        Height = 8
        Top = 16
        Width = 69
        Caption = 'CNPJ/CPF EMITENTE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel100: TRLLabel
        Left = 542
        Height = 8
        Top = 16
        Width = 86
        Caption = 'SÉRIE/NRO. DOCUMENTO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
    end
    object rlb_09_Obs: TRLBand[3]
      Left = 26
      Height = 65
      Top = 1089
      Width = 742
      AlignToBottom = True
      BandType = btColumnFooter
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_09_ObsBeforePrint
      object rlsQuadro08: TRLDraw
        Left = 0
        Height = 64
        Top = 0
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw1: TRLDraw
        Left = 1
        Height = 1
        Top = 16
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmObs: TRLMemo
        Left = 5
        Height = 45
        Top = 17
        Width = 730
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'OBS LINHA 1'
          'OBS LINHA 2'
          'OBS LINHA 3'
          'OBS LINHA 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllMsgTeste: TRLLabel
        Left = 11
        Height = 31
        Top = 27
        Width = 718
        Alignment = taCenter
        Caption = 'AMBIENTE DE HOMOLOGAÇÃO - SEM VALOR FISCAL'
        Color = clWhite
        Font.Color = clGray
        Font.Height = -27
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel10: TRLLabel
        Left = 6
        Height = 13
        Top = 2
        Width = 732
        Alignment = taCenter
        AutoSize = False
        Caption = 'OBSERVAÇÕES'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
    end
    object rlb_02_Cabecalho: TRLBand[4]
      Left = 26
      Height = 203
      Top = 254
      Width = 742
      BandType = btColumnHeader
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_02_CabecalhoBeforePrint
      object rlsQuadro01: TRLDraw
        Left = 0
        Height = 202
        Top = 1
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaH02: TRLDraw
        Left = 332
        Height = 1
        Top = 59
        Width = 408
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaH03: TRLDraw
        Left = 332
        Height = 1
        Top = 100
        Width = 408
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaV01: TRLDraw
        Left = 174
        Height = 60
        Top = 142
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaV04: TRLDraw
        Left = 332
        Height = 202
        Top = 0
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaV05: TRLDraw
        Left = 366
        Height = 26
        Top = 33
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaV06: TRLDraw
        Left = 390
        Height = 26
        Top = 33
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaV07: TRLDraw
        Left = 614
        Height = 28
        Top = 33
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaV08: TRLDraw
        Left = 464
        Height = 26
        Top = 33
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaV09: TRLDraw
        Left = 508
        Height = 26
        Top = 33
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaV10: TRLDraw
        Left = 627
        Height = 33
        Top = 0
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rliLogo: TRLImage
        Left = 7
        Height = 62
        Top = 40
        Width = 94
        Center = True
        Picture.Data = {
          0A544A706567496D616765D1080000FFD8FFE000104A46494600010101006000
          600000FFE1002245786966000049492A00080000000100005104000100000000
          00000000000000FFDB004300080606070605080707070909080A0C140D0C0B0B
          0C1912130F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434
          341F27393D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C2132
          3232323232323232323232323232323232323232323232323232323232323232
          3232323232323232323232323232323232FFC00011080047005A030122000211
          01031101FFC4001F000001050101010101010000000000000000010203040506
          0708090A0BFFC400B5100002010303020403050504040000017D010203000411
          05122131410613516107227114328191A1082342B1C11552D1F0243362728209
          0A161718191A25262728292A3435363738393A434445464748494A5354555657
          58595A636465666768696A737475767778797A838485868788898A9293949596
          9798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2
          D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F
          0100030101010101010101010000000000000102030405060708090A0BFFC400
          B511000201020404030407050404000102770001020311040521310612415107
          61711322328108144291A1B1C109233352F0156272D10A162434E125F1171819
          1A262728292A35363738393A434445464748494A535455565758595A63646566
          6768696A737475767778797A82838485868788898A92939495969798999AA2A3
          A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8
          D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C0301000211031100
          3F00F6900B1000C9352FD966C6768FA6697CF86C34E9EFA7388E246918FF00B2
          064FF2AF34D3FC63E28D7758FB569EA059C7264C247CAEB9E99C7A77AE75056B
          B2EE7A308DCBEC0BF37A53FECD3671E59FAE457112F8D751BAD6FECADA63D8B7
          96CBBC4BE6027B1FBA315B916A77DA67C3BBBD52F67692E92096446739C1E420
          FE5F9D38D34C4E425EDBEBD15F4ACB70B15A1C042550E3DBD69B697D2C17D3A5
          EDEE6358D4A07455C9EE4605705A5EABE2FD72DE291EECBDBEECFCD5DC38862B
          449AF767EE97259874ADDD28F298BA8D3B965BC43621D86642ABD5C21C67D2B0
          4F8BAE3ED52F94B1B4521C43E67CAA98EB93DCFB550BEBF92FDC298D96127F75
          6EBC17FF0069BDBDBFC9AD0E8F7F25D1B9D434E9E68A338B78A11919F538E95C
          CE9B92BC76FEBEE0552537D91A4FE20D4D9894BC04F5C45002A3F135A9A4789C
          CF38B4BF55495BEE48380DEC7D0D65B59EA31A2CB2C71C7001968E2E0A0FEB50
          EB31E9B2E929756773BE5475C1E8706B19D19D3576CA6D25CD17B1DEAB86E869
          D5CA4377343A025D4521930548E73DF9AD58B570F1236D3F32834A9B93BA96E9
          D8DD9B5782DF52D3EE34DBB9B60BA8DA2CE4024118E3DEA8F873428FC2DA5F91
          2DDC6C89D642BB723DE9752D3A0D52CDEDA750518570D2FC3BBB129587519442
          7F84B1E057A0626BDE789A0D675D934FD36554555C19550162724707F0A77C51
          B81A778161D3A3273712C7001DCAAFCC4FFE3A3F3AAB69E1CFF8460B4D6F6AD7
          3941B994F20E4E7F0C1ACCD6F41FEDED5ADE784BC8E06ED80600FA9AAB2B1177
          7373C336A2D342B74C63E5C9ACBD4F503A84E0202D6E8DB628FF00E7AB7F78FB
          0AB17F7FB34A86CE23B2490159307EE28EBFE156FC29A50BCBA5BA99311A8F91
          7D00A997BF2E5E8BF332B733B1A7A07872382137FA830DE46E258E303DFD2ACE
          9FE33F0E5E6AA34AB2B90D313B54843B18FA03567C51A48D774CFECCFED33631
          B9065D98DCEBFDDE7A0ACFD17C1BA3688D13C5323BC6721988CE6AAF737B5B62
          E6B89069FE54AC42C73C822DA7FBC413FD2B94F13F931D9DB411A2AB3C99181F
          C2064D2F8E3577D4BC4BA7E8968CAF1C0EB712B29CE1B0401F91359BA94C752D
          53119CA2E208F1DF1F78D454778A877FCBA99544AF6468697A7DC2E90BF65942
          8907CD1BF2BF51E86AB8F11CF6E3C96B693747F21C74C8E2B6E7BA8748D3E30C
          0B3F0B1C6BD5DBD05659F0C6A9707CE6B954693E72A3B13CE2B4718A7EA52726
          775451454161481557A003E8296A0BE95A0D3EE665FBC91330FA804D26ECAE07
          9EDF42BABEB13B42E62124C550A742ABDFF1AEC3C1D7AAD35E58BB2978182A11
          C6E5AE3F4D996DADA49CF3E5C785F6279FEB5B56F6C61F0D4B7F1318EED47991
          CABD41FF000AE6C2C9C937FD776251B453F98CF10FC3FB8D6BC5B71A8492B35B
          CC8BB70F8D840C63FAFE3506ABE07F0BE85A52CBA95EDC24CC70A44BCB9F40B5
          3EA7E3AD7ED14DAC5A1ABCBB702E04E719F5DBB7FAD72A74BBBBA9D755F115CC
          97370C711404F24FA01D8575B7CAAEC4E496A5DB7D3AC748B7DF60C5AE6E410A
          CDFC2BDD8FD2B4F40B1124BF682BFBA886D8F3DFDEA8DADA49777261182CDFEB
          597A22FF00747B574F3EDB0D34A44006036A0F5268A716DF3CBFA464BBB33B44
          B49355D664BEB962EB0B94407A2FD2BB4C0AA3A4D8AE9FA745081F3632E7D49E
          B57A866EB425F247FCF58BFEFAA3C91FF3D62FFBEAABD15CFED5F634E4458F24
          7FCF58BFEFAA8E7B559ADE488CB161D4A9F9BD4547451ED5F60E4479CD9DA194
          5DE9923AA4E094C13DC74FC2BB6D36CE39B41FB34F2468BB0A480B631597AFF8
          6C6A12FDAADCED9C7520E09AE33538358B3F92EA09E74ECCF2B11F957353F694
          9BE5574C8B492E5EC749A86B10E9974F05B5C477FB8001F3F2A37BB7422B2E24
          B8BFB9661279929FBF39E1507A2FA0AA5A46957FAE853332C3A7A36708A14311
          E807F3AEAEFED6DE2D39AC2153E64E362AA753FF00D6AEDA519C973D5F918B8A
          E6EE54B0B90ADF62D22013C80E1E67384FCFBD74369A3DCCD771DC5FCD6E045F
          72346C827D4D58D3EC21D3ED638628D576A807156EA5D76CDD5248B1E48FF9EB
          17FDF547923FE7AC5FF7D557A2A7DABEC57220A28A2B22828A28A002992451CA
          3122061EF4514018D75A549644DC69516493F35B6E0AADEE33D0D58D2B4F6881
          BCBB8C0BC93EF739D83FBA28A2A9CE4D728B955EE6A514515230A28A2803FFD9
        }
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Stretch = True
      end
      object rlsLinhaH04: TRLDraw
        Left = 0
        Height = 1
        Top = 142
        Width = 332
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmEmitente: TRLMemo
        Left = 7
        Height = 15
        Top = 2
        Width = 322
        Alignment = taCenter
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlmDadosEmitente: TRLMemo
        Left = 113
        Height = 116
        Top = 21
        Width = 216
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          '1 Linha - LOGRADOURO - COMPLEMENTO - BAIRRO'
          '2 Linha - CEP - MUNICIPIO - UF'
          '3 Linha - CNPJ INSCRICAO ESTADUAL'
          '4 Linha - TELEFONE'
          '5 Linha - URL'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel17: TRLLabel
        Left = 371
        Height = 17
        Top = 3
        Width = 218
        Alignment = taCenter
        AutoSize = False
        Caption = 'DACTE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel18: TRLLabel
        Left = 344
        Height = 14
        Top = 20
        Width = 278
        Alignment = taCenter
        AutoSize = False
        Caption = 'Documento Auxiliar do Conhecimento de Transporte Eletrônico'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel6: TRLLabel
        Left = 640
        Height = 16
        Top = 4
        Width = 76
        Alignment = taCenter
        AutoSize = False
        Caption = 'MODAL'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllModal: TRLLabel
        Left = 633
        Height = 15
        Top = 18
        Width = 104
        Alignment = taCenter
        AutoSize = False
        Color = clWhite
        Font.CharSet = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel8: TRLLabel
        Left = 334
        Height = 8
        Top = 35
        Width = 32
        Alignment = taCenter
        Caption = 'MODELO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllModelo: TRLLabel
        Left = 334
        Height = 15
        Top = 43
        Width = 30
        Alignment = taCenter
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel21: TRLLabel
        Left = 368
        Height = 8
        Top = 35
        Width = 22
        Alignment = taCenter
        Caption = 'SÉRIE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllSerie: TRLLabel
        Left = 368
        Height = 15
        Top = 43
        Width = 20
        Alignment = taCenter
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel23: TRLLabel
        Left = 392
        Height = 9
        Top = 35
        Width = 70
        Alignment = taCenter
        AutoSize = False
        Caption = 'NÚMERO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllNumCte: TRLLabel
        Left = 392
        Height = 15
        Top = 43
        Width = 72
        Alignment = taRightJustify
        Caption = '999.999.999'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel25: TRLLabel
        Left = 466
        Height = 9
        Top = 35
        Width = 42
        Alignment = taCenter
        AutoSize = False
        Caption = 'FOLHA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllPageNumber: TRLLabel
        Left = 466
        Height = 15
        Top = 43
        Width = 42
        Alignment = taCenter
        AutoSize = False
        Caption = '00/00'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel33: TRLLabel
        Left = 510
        Height = 9
        Top = 35
        Width = 95
        AutoSize = False
        Caption = 'DATA E HORA DE EMISSÃO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllEmissao: TRLLabel
        Left = 510
        Height = 13
        Top = 43
        Width = 58
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel74: TRLLabel
        Left = 334
        Height = 11
        Top = 102
        Width = 58
        Caption = 'Chave de acesso'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllChave: TRLLabel
        Left = 336
        Height = 14
        Top = 116
        Width = 402
        Alignment = taCenter
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel2: TRLLabel
        Left = 4
        Height = 8
        Top = 144
        Width = 46
        Caption = 'TIPO DO CT-E'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllTipoCte: TRLLabel
        Left = 4
        Height = 15
        Top = 154
        Width = 76
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel9: TRLLabel
        Left = 178
        Height = 8
        Top = 144
        Width = 61
        Caption = 'TIPO DO SERVIÇO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllTipoServico: TRLLabel
        Left = 178
        Height = 15
        Top = 154
        Width = 91
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel28: TRLLabel
        Left = 4
        Height = 8
        Top = 174
        Width = 81
        Caption = 'TOMADOR DO SERVIÇO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllTomaServico: TRLLabel
        Left = 4
        Height = 15
        Top = 184
        Width = 81
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel78: TRLLabel
        Left = 178
        Height = 8
        Top = 174
        Width = 83
        Caption = 'FORMA DE PAGAMENTO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllFormaPagamento: TRLLabel
        Left = 178
        Height = 15
        Top = 184
        Width = 73
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllDescricao: TRLLabel
        Left = 334
        Height = 8
        Top = 174
        Width = 56
        Caption = 'N° PROTOCOLO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllProtocolo: TRLLabel
        Left = 336
        Height = 15
        Top = 184
        Width = 402
        Alignment = taCenter
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel77: TRLLabel
        Left = 616
        Height = 8
        Top = 35
        Width = 120
        Caption = 'INSC. SUFRAMA DO DESTINATÁRIO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllInscSuframa: TRLLabel
        Left = 616
        Height = 12
        Top = 43
        Width = 56
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw88: TRLDraw
        Left = 0
        Height = 1
        Top = 172
        Width = 740
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllVariavel1: TRLLabel
        Left = 344
        Height = 29
        Top = 138
        Width = 386
        Alignment = taJustify
        AutoSize = False
        Caption = 'Consulta de autenticidade no portal nacional do CT-e, no site da Sefaz Autorizadora, ou em http://www.cte.fazenda.gov.br/portal'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlsLinhaH01: TRLDraw
        Left = 332
        Height = 1
        Top = 33
        Width = 408
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rliBarCode2: TRLImage
        Left = 357
        Height = 33
        Top = 136
        Width = 361
        Center = True
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw99: TRLDraw
        Left = 332
        Height = 1
        Top = 132
        Width = 408
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
    end
    object rlb_10_ModRodFracionado: TRLBand[5]
      Left = 26
      Height = 44
      Top = 1154
      Width = 742
      AlignToBottom = True
      BandType = btColumnFooter
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_10_ModRodFracionadoBeforePrint
      object rlsQuadro09: TRLDraw
        Left = 0
        Height = 43
        Top = 0
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw24: TRLDraw
        Left = 1
        Height = 1
        Top = 15
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw36: TRLDraw
        Left = 150
        Height = 28
        Top = 15
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw37: TRLDraw
        Left = 192
        Height = 28
        Top = 15
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw38: TRLDraw
        Left = 300
        Height = 28
        Top = 15
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllTituloLotacao: TRLLabel
        Left = 6
        Height = 13
        Top = 2
        Width = 732
        Alignment = taCenter
        AutoSize = False
        Caption = 'DADOS ESPECÍFICOS DO MODAL RODOVIÁRIO - CARGA FRACIONADA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllRntrcEmpresa: TRLLabel
        Left = 6
        Height = 12
        Top = 25
        Width = 64
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllLotacao: TRLLabel
        Left = 154
        Height = 13
        Top = 25
        Width = 34
        Alignment = taCenter
        AutoSize = False
        Caption = 'SIM'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllDtPrevEntrega: TRLLabel
        Left = 196
        Height = 12
        Top = 25
        Width = 69
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel85: TRLLabel
        Left = 304
        Height = 11
        Top = 23
        Width = 434
        Alignment = taCenter
        AutoSize = False
        Caption = 'ESSE CONHECIMENTO DE TRANSPORTE ATENDE À LEGISLAÇÃO DE TRANSPORTE RODOVIÁRIO EM VIGOR'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -8
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel84: TRLLabel
        Left = 196
        Height = 8
        Top = 16
        Width = 101
        Caption = 'DATA PREVISTA DE ENTREGA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel83: TRLLabel
        Left = 154
        Height = 8
        Top = 16
        Width = 35
        Caption = 'LOTAÇÃO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel11: TRLLabel
        Left = 6
        Height = 8
        Top = 16
        Width = 72
        Caption = 'RNTRC DA EMPRESA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object lblCIOT: TRLLabel
        Left = 84
        Height = 8
        Top = 16
        Width = 18
        Caption = 'CIOT'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllCIOT: TRLLabel
        Left = 84
        Height = 12
        Top = 25
        Width = 32
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsCIOT: TRLDraw
        Left = 80
        Height = 28
        Top = 15
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
    end
    object rlb_11_ModRodLot103: TRLBand[6]
      Left = 26
      Height = 108
      Top = 1198
      Width = 742
      AlignToBottom = True
      BandType = btColumnFooter
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_11_ModRodLot103BeforePrint
      object RLDraw11: TRLDraw
        Left = 0
        Height = 107
        Top = 0
        Width = 740
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw43: TRLDraw
        Left = 425
        Height = 53
        Top = 29
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw40: TRLDraw
        Left = 207
        Height = 1
        Top = 42
        Width = 532
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw39: TRLDraw
        Left = 1
        Height = 1
        Top = 29
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw12: TRLDraw
        Left = 207
        Height = 105
        Top = 0
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw13: TRLDraw
        Left = 1
        Height = 1
        Top = 14
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw14: TRLDraw
        Left = 42
        Height = 69
        Top = 13
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw31: TRLDraw
        Left = 100
        Height = 69
        Top = 13
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw33: TRLDraw
        Left = 122
        Height = 69
        Top = 13
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw42: TRLDraw
        Left = 345
        Height = 92
        Top = 13
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw44: TRLDraw
        Left = 585
        Height = 69
        Top = 13
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw41: TRLDraw
        Left = 1
        Height = 1
        Top = 82
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmVigencias: TRLMemo
        Left = 348
        Height = 35
        Top = 45
        Width = 76
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Vigencia 1'
          'Vigencia 2'
          'Vigencia 3'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmUF: TRLMemo
        Left = 102
        Height = 50
        Top = 32
        Width = 16
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Uf1'
          'Uf2'
          'Uf3'
          'Uf4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmTipo: TRLMemo
        Left = 2
        Height = 50
        Top = 32
        Width = 36
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Tipo 1'
          'Tipo 2'
          'Tipo 3'
          'Tipo 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmRNTRC: TRLMemo
        Left = 124
        Height = 50
        Top = 32
        Width = 77
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'RNTRC 1'
          'RNTRC 2'
          'RNTRC 3'
          'RNTRC 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmPlaca: TRLMemo
        Left = 44
        Height = 50
        Top = 32
        Width = 53
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Placa 1'
          'Placa 2'
          'Placa 3'
          'Placa 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmNumDispositivo: TRLMemo
        Left = 428
        Height = 35
        Top = 45
        Width = 156
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Dispositivo 1'
          'Dispositivo 2'
          'Dispositivo 3'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmEmpresas: TRLMemo
        Left = 210
        Height = 35
        Top = 45
        Width = 133
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Empresa 1'
          'Empresa 2'
          'Empresa 3'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmCodTransacao: TRLMemo
        Left = 588
        Height = 35
        Top = 45
        Width = 149
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Transacao 1'
          'Transacao 2'
          'Transacao 3'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllValorTotal: TRLLabel
        Left = 640
        Height = 13
        Top = 15
        Width = 95
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllResponsavel: TRLLabel
        Left = 404
        Height = 12
        Top = 15
        Width = 60
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllNumRegEsp: TRLLabel
        Left = 272
        Height = 12
        Top = 15
        Width = 59
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllNomeMotorista: TRLLabel
        Left = 4
        Height = 12
        Top = 93
        Width = 71
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllLacres: TRLLabel
        Left = 351
        Height = 12
        Top = 93
        Width = 36
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCPFMotorista: TRLLabel
        Left = 212
        Height = 12
        Top = 93
        Width = 66
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel76: TRLLabel
        Left = 2
        Height = 12
        Top = 15
        Width = 23
        Caption = 'TIPO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel75: TRLLabel
        Left = 214
        Height = 13
        Top = 1
        Width = 524
        Alignment = taCenter
        AutoSize = False
        Caption = 'INFORMAÇÕES REFERENTES AO VALE-PEDÁGIO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel71: TRLLabel
        Left = 2
        Height = 13
        Top = 1
        Width = 202
        Alignment = taCenter
        AutoSize = False
        Caption = 'IDENTIFICAÇÃO DO CONJ. TRANSPORTADOR'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel131: TRLLabel
        Left = 351
        Height = 8
        Top = 84
        Width = 148
        Caption = 'IDENTIFICAÇÃO DOS LACRES EM TRÂNSITO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel130: TRLLabel
        Left = 212
        Height = 8
        Top = 84
        Width = 69
        Caption = 'CPF DO MOTORISTA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel129: TRLLabel
        Left = 4
        Height = 8
        Top = 84
        Width = 76
        Caption = 'NOME DO MOTORISTA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel127: TRLLabel
        Left = 588
        Height = 8
        Top = 31
        Width = 86
        Caption = 'CÓDIGO DA TRANSAÇÃO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel126: TRLLabel
        Left = 428
        Height = 8
        Top = 31
        Width = 88
        Caption = 'NÚMERO DO DISPOSITIVO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel124: TRLLabel
        Left = 348
        Height = 8
        Top = 31
        Width = 35
        Caption = 'VIGÊNCIA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel122: TRLLabel
        Left = 210
        Height = 8
        Top = 31
        Width = 86
        Caption = 'EMPRESA CREDENCIADA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel121: TRLLabel
        Left = 588
        Height = 8
        Top = 15
        Width = 50
        Caption = 'VALOR TOTAL'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel120: TRLLabel
        Left = 348
        Height = 8
        Top = 15
        Width = 51
        Caption = 'RESPONSÁVEL'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel118: TRLLabel
        Left = 210
        Height = 8
        Top = 15
        Width = 53
        Caption = 'NRO. REG. ESP.'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel117: TRLLabel
        Left = 124
        Height = 12
        Top = 15
        Width = 32
        Caption = 'RNTRC'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel115: TRLLabel
        Left = 102
        Height = 12
        Top = 15
        Width = 14
        Caption = 'UF'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel112: TRLLabel
        Left = 44
        Height = 12
        Top = 15
        Width = 34
        Caption = 'PLACA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
    end
    object rlb_03_DadosDACTe: TRLBand[7]
      Left = 26
      Height = 202
      Top = 457
      Width = 742
      BandType = btColumnHeader
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_03_DadosDACTeBeforePrint
      object rlsQuadro02: TRLDraw
        Left = 0
        Height = 201
        Top = 0
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaH08: TRLDraw
        Left = 1
        Height = 1
        Top = 167
        Width = 740
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaV11: TRLDraw
        Left = 370
        Height = 141
        Top = 27
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaH07: TRLDraw
        Left = 1
        Height = 1
        Top = 109
        Width = 740
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaH06: TRLDraw
        Left = 1
        Height = 1
        Top = 51
        Width = 740
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaH05: TRLDraw
        Left = 1
        Height = 1
        Top = 26
        Width = 740
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllRazaoToma: TRLLabel
        Left = 88
        Height = 13
        Top = 169
        Width = 280
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllRazaoRemet: TRLLabel
        Left = 48
        Height = 13
        Top = 54
        Width = 318
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllRazaoReceb: TRLLabel
        Left = 424
        Height = 15
        Top = 111
        Width = 310
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllRazaoExped: TRLLabel
        Left = 48
        Height = 13
        Top = 111
        Width = 318
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllRazaoDest: TRLLabel
        Left = 432
        Height = 13
        Top = 54
        Width = 303
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllPaisToma: TRLLabel
        Left = 520
        Height = 13
        Top = 177
        Width = 214
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllPaisRemet: TRLLabel
        Left = 48
        Height = 13
        Top = 96
        Width = 209
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllPaisReceb: TRLLabel
        Left = 424
        Height = 13
        Top = 153
        Width = 209
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllPaisExped: TRLLabel
        Left = 48
        Height = 13
        Top = 153
        Width = 212
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllPaisDest: TRLLabel
        Left = 432
        Height = 13
        Top = 96
        Width = 203
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllOrigPrestacao: TRLLabel
        Left = 4
        Height = 15
        Top = 36
        Width = 360
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllNatOperacao: TRLLabel
        Left = 4
        Height = 15
        Top = 11
        Width = 733
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllMunToma: TRLLabel
        Left = 416
        Height = 13
        Top = 169
        Width = 233
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllMunRemet: TRLLabel
        Left = 48
        Height = 19
        Top = 78
        Width = 234
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllMunReceb: TRLLabel
        Left = 424
        Height = 13
        Top = 135
        Width = 226
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllMunExped: TRLLabel
        Left = 48
        Height = 13
        Top = 135
        Width = 234
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllMunDest: TRLLabel
        Left = 432
        Height = 13
        Top = 78
        Width = 225
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllInscEstToma: TRLLabel
        Left = 256
        Height = 13
        Top = 187
        Width = 111
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllInscEstRemet: TRLLabel
        Left = 256
        Height = 13
        Top = 87
        Width = 109
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllInscEstReceb: TRLLabel
        Left = 632
        Height = 13
        Top = 144
        Width = 102
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllInscEstExped: TRLLabel
        Left = 256
        Height = 13
        Top = 144
        Width = 109
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllInscEstDest: TRLLabel
        Left = 632
        Height = 13
        Top = 87
        Width = 102
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllFoneToma: TRLLabel
        Left = 398
        Height = 13
        Top = 187
        Width = 85
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllFoneRemet: TRLLabel
        Left = 288
        Height = 13
        Top = 96
        Width = 77
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllFoneReceb: TRLLabel
        Left = 664
        Height = 13
        Top = 153
        Width = 70
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllFoneExped: TRLLabel
        Left = 288
        Height = 13
        Top = 153
        Width = 77
        AutoSize = False
        Caption = 'rlFoneExped'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllFoneDest: TRLLabel
        Left = 664
        Height = 13
        Top = 96
        Width = 70
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllEnderecoToma: TRLLabel
        Left = 48
        Height = 13
        Top = 177
        Width = 445
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllEnderecoRemet2: TRLLabel
        Left = 48
        Height = 13
        Top = 70
        Width = 318
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllEnderecoRemet1: TRLLabel
        Left = 48
        Height = 13
        Top = 62
        Width = 318
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllEnderecoReceb2: TRLLabel
        Left = 424
        Height = 13
        Top = 127
        Width = 310
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllEnderecoReceb1: TRLLabel
        Left = 424
        Height = 13
        Top = 119
        Width = 310
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllEnderecoExped2: TRLLabel
        Left = 48
        Height = 13
        Top = 127
        Width = 318
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllEnderecoExped1: TRLLabel
        Left = 48
        Height = 13
        Top = 119
        Width = 318
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllEnderecoDest2: TRLLabel
        Left = 432
        Height = 13
        Top = 70
        Width = 303
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllEnderecoDest1: TRLLabel
        Left = 432
        Height = 19
        Top = 62
        Width = 303
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllDestPrestacao: TRLLabel
        Left = 374
        Height = 15
        Top = 36
        Width = 360
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCnpjToma: TRLLabel
        Left = 41
        Height = 13
        Top = 187
        Width = 130
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCnpjRemet: TRLLabel
        Left = 48
        Height = 13
        Top = 87
        Width = 124
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCnpjReceb: TRLLabel
        Left = 424
        Height = 13
        Top = 144
        Width = 121
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCnpjExped: TRLLabel
        Left = 48
        Height = 13
        Top = 144
        Width = 124
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCnpjDest: TRLLabel
        Left = 432
        Height = 18
        Top = 87
        Width = 115
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCEPToma: TRLLabel
        Left = 670
        Height = 13
        Top = 169
        Width = 64
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCEPRemet: TRLLabel
        Left = 301
        Height = 13
        Top = 78
        Width = 64
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCEPReceb: TRLLabel
        Left = 670
        Height = 13
        Top = 135
        Width = 64
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCEPExped: TRLLabel
        Left = 301
        Height = 13
        Top = 135
        Width = 64
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCEPDest: TRLLabel
        Left = 677
        Height = 13
        Top = 78
        Width = 57
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel99: TRLLabel
        Left = 374
        Height = 8
        Top = 111
        Width = 44
        Caption = 'RECEBEDOR'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel98: TRLLabel
        Left = 284
        Height = 8
        Top = 78
        Width = 15
        Caption = 'CEP'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel97: TRLLabel
        Left = 374
        Height = 8
        Top = 170
        Width = 38
        Caption = 'MUNICÍPIO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel95: TRLLabel
        Left = 262
        Height = 8
        Top = 96
        Width = 20
        Caption = 'FONE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel94: TRLLabel
        Left = 653
        Height = 8
        Top = 170
        Width = 15
        Caption = 'CEP'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel93: TRLLabel
        Left = 174
        Height = 8
        Top = 87
        Width = 78
        Caption = 'INSCRIÇÃO ESTADUAL'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel90: TRLLabel
        Left = 4
        Height = 8
        Top = 153
        Width = 17
        Caption = 'PAIS'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel89: TRLLabel
        Left = 4
        Height = 8
        Top = 144
        Width = 34
        Caption = 'CNPJ/CPF'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel88: TRLLabel
        Left = 4
        Height = 8
        Top = 135
        Width = 38
        Caption = 'MUNICÍPIO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel87: TRLLabel
        Left = 4
        Height = 8
        Top = 119
        Width = 39
        Caption = 'ENDEREÇO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel86: TRLLabel
        Left = 4
        Height = 8
        Top = 111
        Width = 41
        Caption = 'EXPEDIDOR'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel82: TRLLabel
        Left = 4
        Height = 8
        Top = 187
        Width = 34
        Caption = 'CNPJ/CPF'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel81: TRLLabel
        Left = 4
        Height = 8
        Top = 178
        Width = 39
        Caption = 'ENDEREÇO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel80: TRLLabel
        Left = 4
        Height = 8
        Top = 170
        Width = 81
        Caption = 'TOMADOR DO SERVIÇO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel79: TRLLabel
        Left = 374
        Height = 8
        Top = 96
        Width = 17
        Caption = 'PAIS'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel32: TRLLabel
        Left = 374
        Height = 8
        Top = 87
        Width = 34
        Caption = 'CNPJ/CPF'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel31: TRLLabel
        Left = 374
        Height = 8
        Top = 78
        Width = 38
        Caption = 'MUNICÍPIO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel30: TRLLabel
        Left = 374
        Height = 8
        Top = 62
        Width = 39
        Caption = 'ENDEREÇO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel29: TRLLabel
        Left = 4
        Height = 8
        Top = 2
        Width = 115
        Caption = 'CFOP - NATUREZA DA OPERAÇÃO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel27: TRLLabel
        Left = 374
        Height = 8
        Top = 54
        Width = 52
        Caption = 'DESTINATÁRIO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel26: TRLLabel
        Left = 4
        Height = 8
        Top = 96
        Width = 17
        Caption = 'PAIS'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel24: TRLLabel
        Left = 4
        Height = 8
        Top = 87
        Width = 34
        Caption = 'CNPJ/CPF'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel22: TRLLabel
        Left = 4
        Height = 8
        Top = 78
        Width = 38
        Caption = 'MUNICÍPIO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel16: TRLLabel
        Left = 4
        Height = 8
        Top = 62
        Width = 39
        Caption = 'ENDEREÇO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel14: TRLLabel
        Left = 374
        Height = 8
        Top = 28
        Width = 86
        Caption = 'DESTINO DA PRESTAÇÃO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel13: TRLLabel
        Left = 4
        Height = 8
        Top = 54
        Width = 42
        Caption = 'REMETENTE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel128: TRLLabel
        Left = 653
        Height = 8
        Top = 135
        Width = 15
        Caption = 'CEP'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel125: TRLLabel
        Left = 640
        Height = 8
        Top = 153
        Width = 20
        Caption = 'FONE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel123: TRLLabel
        Left = 551
        Height = 8
        Top = 144
        Width = 78
        Caption = 'INSCRIÇÃO ESTADUAL'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel12: TRLLabel
        Left = 4
        Height = 8
        Top = 28
        Width = 84
        Caption = 'ORIGEM DA PRESTAÇÃO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel119: TRLLabel
        Left = 660
        Height = 8
        Top = 78
        Width = 15
        Caption = 'CEP'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel116: TRLLabel
        Left = 640
        Height = 8
        Top = 96
        Width = 20
        Caption = 'FONE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel114: TRLLabel
        Left = 551
        Height = 8
        Top = 87
        Width = 78
        Caption = 'INSCRIÇÃO ESTADUAL'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel113: TRLLabel
        Left = 500
        Height = 8
        Top = 178
        Width = 17
        Caption = 'PAIS'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel111: TRLLabel
        Left = 374
        Height = 8
        Top = 187
        Width = 20
        Caption = 'FONE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel110: TRLLabel
        Left = 284
        Height = 8
        Top = 135
        Width = 15
        Caption = 'CEP'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel108: TRLLabel
        Left = 174
        Height = 8
        Top = 187
        Width = 78
        Caption = 'INSCRIÇÃO ESTADUAL'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel107: TRLLabel
        Left = 262
        Height = 8
        Top = 153
        Width = 20
        Caption = 'FONE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel105: TRLLabel
        Left = 174
        Height = 8
        Top = 144
        Width = 78
        Caption = 'INSCRIÇÃO ESTADUAL'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel104: TRLLabel
        Left = 374
        Height = 8
        Top = 153
        Width = 17
        Caption = 'PAIS'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel103: TRLLabel
        Left = 374
        Height = 8
        Top = 144
        Width = 34
        Caption = 'CNPJ/CPF'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel102: TRLLabel
        Left = 374
        Height = 8
        Top = 135
        Width = 38
        Caption = 'MUNICÍPIO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel101: TRLLabel
        Left = 374
        Height = 8
        Top = 119
        Width = 39
        Caption = 'ENDEREÇO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
    end
    object rlb_04_DadosNotaFiscal: TRLBand[8]
      Left = 26
      Height = 108
      Top = 659
      Width = 742
      BandType = btColumnHeader
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_04_DadosNotaFiscalBeforePrint
      object rlsQuadro03: TRLDraw
        Left = 0
        Height = 107
        Top = 0
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw9: TRLDraw
        Left = 283
        Height = 25
        Top = 0
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw8: TRLDraw
        Left = 632
        Height = 40
        Top = 66
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw7: TRLDraw
        Left = 526
        Height = 40
        Top = 66
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw62: TRLDraw
        Left = 414
        Height = 1
        Top = 66
        Width = 326
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw61: TRLDraw
        Left = 414
        Height = 80
        Top = 26
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw60: TRLDraw
        Left = 324
        Height = 80
        Top = 26
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw59: TRLDraw
        Left = 164
        Height = 80
        Top = 26
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw58: TRLDraw
        Left = 84
        Height = 80
        Top = 26
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw56: TRLDraw
        Left = 540
        Height = 25
        Top = 0
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw55: TRLDraw
        Left = 1
        Height = 1
        Top = 25
        Width = 740
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmQtdUnidMedida5: TRLMemo
        Left = 328
        Height = 68
        Top = 37
        Width = 84
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'COMP 1'
          'COMP 2'
          'COMP 3'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmQtdUnidMedida3: TRLMemo
        Left = 166
        Height = 68
        Top = 37
        Width = 76
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'COMP 1'
          'COMP 2'
          'COMP 3'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmQtdUnidMedida2: TRLMemo
        Left = 86
        Height = 68
        Top = 37
        Width = 76
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'COMP 1'
          'COMP 2'
          'COMP 3'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmQtdUnidMedida1: TRLMemo
        Left = 5
        Height = 68
        Top = 37
        Width = 76
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'COMP 1'
          'COMP 2'
          'COMP 3'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllVlrTotalMerc: TRLLabel
        Left = 549
        Height = 13
        Top = 12
        Width = 185
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllProdPredominante: TRLLabel
        Left = 4
        Height = 13
        Top = 12
        Width = 275
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllOutrasCaracCarga: TRLLabel
        Left = 287
        Height = 13
        Top = 12
        Width = 249
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel5: TRLLabel
        Left = 418
        Height = 8
        Top = 27
        Width = 84
        Caption = 'NOME DA SEGURADORA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel43: TRLLabel
        Left = 328
        Height = 9
        Top = 28
        Width = 84
        Alignment = taCenter
        AutoSize = False
        Caption = 'QTDE. VOLUMES (Unid)'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel41: TRLLabel
        Left = 166
        Height = 9
        Top = 28
        Width = 76
        Alignment = taCenter
        AutoSize = False
        Caption = 'PESO AFERIDO (Kg)'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel40: TRLLabel
        Left = 634
        Height = 8
        Top = 70
        Width = 90
        Caption = 'NÚMERO DA AVERBAÇÃO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel4: TRLLabel
        Left = 286
        Height = 8
        Top = 2
        Width = 135
        Caption = 'OUTRAS CARACTERÍSTICAS DA CARGA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel39: TRLLabel
        Left = 528
        Height = 8
        Top = 70
        Width = 75
        Caption = 'NÚMERO DA APÓLICE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel37: TRLLabel
        Left = 416
        Height = 8
        Top = 70
        Width = 51
        Caption = 'RESPONSÁVEL'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel36: TRLLabel
        Left = 86
        Height = 9
        Top = 28
        Width = 76
        Alignment = taCenter
        AutoSize = False
        Caption = 'PESO BASE CÁLC. (Kg)'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel35: TRLLabel
        Left = 5
        Height = 9
        Top = 28
        Width = 76
        Alignment = taCenter
        AutoSize = False
        Caption = 'PESO BRUTO (Kg)'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel34: TRLLabel
        Left = 546
        Height = 8
        Top = 2
        Width = 111
        Caption = 'VALOR TOTAL DA MERCADORIA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel1: TRLLabel
        Left = 4
        Height = 8
        Top = 2
        Width = 91
        Caption = 'PRODUTO PREDOMINANTE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlmQtdUnidMedida4: TRLMemo
        Left = 246
        Height = 68
        Top = 37
        Width = 76
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'COMP 1'
          'COMP 2'
          'COMP 3'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel73: TRLLabel
        Left = 246
        Height = 9
        Top = 28
        Width = 76
        Alignment = taCenter
        AutoSize = False
        Caption = 'CUBAGEM (M3)'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLDraw100: TRLDraw
        Left = 244
        Height = 80
        Top = 26
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmNomeSeguradora: TRLMemo
        Left = 418
        Height = 28
        Top = 37
        Width = 319
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Seguradora 1'
          'Seguradora 2'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmRespSeguroMerc: TRLMemo
        Left = 416
        Height = 25
        Top = 80
        Width = 108
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Resp Seguro 1'
          'Resp Seguro 2'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmNroApolice: TRLMemo
        Left = 528
        Height = 25
        Top = 80
        Width = 102
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Nro Apolice 1'
          'Nro Apolice 2'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmNroAverbacao: TRLMemo
        Left = 634
        Height = 25
        Top = 80
        Width = 102
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Nro Averbacao 1'
          'Nro Averbacao 2'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
    end
    object rlb_05_Complemento: TRLBand[9]
      Left = 26
      Height = 87
      Top = 767
      Width = 742
      BandType = btColumnHeader
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_05_ComplementoBeforePrint
      object rlsQuadro04: TRLDraw
        Left = 0
        Height = 86
        Top = 0
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw6: TRLDraw
        Left = 372
        Height = 71
        Top = 15
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw5: TRLDraw
        Left = 1
        Height = 1
        Top = 15
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmComplValor2: TRLMemo
        Left = 645
        Height = 54
        Top = 27
        Width = 89
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'COMP 1'
          'COMP 2'
          'COMP 3'
          'COMP 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmComplValor1: TRLMemo
        Left = 280
        Height = 54
        Top = 27
        Width = 89
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'COMP 1'
          'COMP 2'
          'COMP 3'
          'COMP 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmComplChave2: TRLMemo
        Left = 377
        Height = 54
        Top = 27
        Width = 264
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'COMP 1'
          'COMP 2'
          'COMP 3'
          'COMP 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmComplChave1: TRLMemo
        Left = 5
        Height = 54
        Top = 27
        Width = 269
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'COMP 1'
          'COMP 2'
          'COMP 3'
          'COMP 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel64: TRLLabel
        Left = 645
        Height = 8
        Top = 18
        Width = 90
        Caption = 'VALOR COMPLEMENTADO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel63: TRLLabel
        Left = 377
        Height = 8
        Top = 18
        Width = 119
        Caption = 'CHAVE DO CT-E COMPLEMENTADO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel62: TRLLabel
        Left = 280
        Height = 8
        Top = 18
        Width = 90
        Caption = 'VALOR COMPLEMENTADO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel61: TRLLabel
        Left = 5
        Height = 8
        Top = 18
        Width = 119
        Caption = 'CHAVE DO CT-E COMPLEMENTADO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel59: TRLLabel
        Left = 6
        Height = 13
        Top = 2
        Width = 732
        Alignment = taCenter
        AutoSize = False
        Caption = 'CT-e COMPLEMENTADO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
    end
    object rlb_17_Sistema: TRLBand[10]
      Left = 26
      Height = 16
      Top = 1760
      Width = 742
      AlignToBottom = True
      BandType = btSummary
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_17_SistemaBeforePrint
      object RLLabel15: TRLLabel
        Left = 2
        Height = 12
        Top = 0
        Width = 140
        Caption = 'DATA E HORA DA IMPRESSÃO: '
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllblSistema: TRLLabel
        Left = 352
        Height = 13
        Top = 0
        Width = 387
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Desenvolvido por Projeto ACBr - http://acbr.sourceforge.net/'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
    end
    object rlb_16_DadosExcEmitente: TRLBand[11]
      Left = 26
      Height = 68
      Top = 1610
      Width = 742
      AlignToBottom = True
      BandType = btColumnFooter
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_16_DadosExcEmitenteBeforePrint
      object RLDraw71: TRLDraw
        Left = 0
        Height = 67
        Top = 0
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel165: TRLLabel
        Left = 566
        Height = 12
        Top = 3
        Width = 102
        Caption = 'RESERVADO AO FISCO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel7: TRLLabel
        Left = 142
        Height = 12
        Top = 3
        Width = 171
        Caption = 'USO EXCLUSIVO DO EMISSOR DO CT-E'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlmObsExcEmitente: TRLMemo
        Left = 5
        Height = 49
        Top = 16
        Width = 492
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'OBS LINHA 1'
          'OBS LINHA 2'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw27: TRLDraw
        Left = 1
        Height = 1
        Top = 14
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw3: TRLDraw
        Left = 500
        Height = 67
        Top = 0
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmObsFisco: TRLMemo
        Left = 509
        Height = 49
        Top = 16
        Width = 228
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'OBS LINHA 1'
          'OBS LINHA 2'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
    end
    object rlb_06_ValorPrestacao: TRLBand[12]
      Left = 26
      Height = 116
      Top = 936
      Width = 742
      BandType = btColumnHeader
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_06_ValorPrestacaoBeforePrint
      object rlsQuadro05: TRLDraw
        Left = 0
        Height = 115
        Top = 0
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw16: TRLDraw
        Left = 557
        Height = 1
        Top = 46
        Width = 184
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw17: TRLDraw
        Left = 1
        Height = 1
        Top = 15
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw18: TRLDraw
        Left = 372
        Height = 62
        Top = 15
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw19: TRLDraw
        Left = 556
        Height = 62
        Top = 15
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw20: TRLDraw
        Left = 448
        Height = 24
        Top = 89
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw22: TRLDraw
        Left = 346
        Height = 24
        Top = 89
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw23: TRLDraw
        Left = 500
        Height = 24
        Top = 89
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw25: TRLDraw
        Left = 586
        Height = 24
        Top = 89
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw26: TRLDraw
        Left = 650
        Height = 24
        Top = 89
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw45: TRLDraw
        Left = 1
        Height = 1
        Top = 77
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw15: TRLDraw
        Left = 186
        Height = 62
        Top = 15
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw21: TRLDraw
        Left = 1
        Height = 1
        Top = 92
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmCompValor3: TRLMemo
        Left = 476
        Height = 50
        Top = 27
        Width = 78
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'COMP 1'
          'COMP 2'
          'COMP 3'
          'COMP 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmCompValor2: TRLMemo
        Left = 290
        Height = 50
        Top = 27
        Width = 78
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'COMP 1'
          'COMP 2'
          'COMP 3'
          'COMP 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmCompValor1: TRLMemo
        Left = 104
        Height = 50
        Top = 27
        Width = 78
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'COMP 1'
          'COMP 2'
          'COMP 3'
          'COMP 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmCompNome3: TRLMemo
        Left = 377
        Height = 50
        Top = 27
        Width = 96
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'COMP 1'
          'COMP 2'
          'COMP 3'
          'COMP 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmCompNome2: TRLMemo
        Left = 190
        Height = 50
        Top = 27
        Width = 96
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'COMP 1'
          'COMP 2'
          'COMP 3'
          'COMP 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmCompNome1: TRLMemo
        Left = 5
        Height = 50
        Top = 27
        Width = 96
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'COMP 1'
          'COMP 2'
          'COMP 3'
          'COMP 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllVlrTotServico: TRLLabel
        Left = 570
        Height = 14
        Top = 28
        Width = 164
        Alignment = taRightJustify
        AutoSize = False
        Caption = '999999999'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllVlrTotReceber: TRLLabel
        Left = 570
        Height = 14
        Top = 60
        Width = 164
        Alignment = taRightJustify
        AutoSize = False
        Caption = '999999999'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllVlrICMS: TRLLabel
        Left = 504
        Height = 13
        Top = 101
        Width = 79
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllSitTrib: TRLLabel
        Left = 3
        Height = 13
        Top = 101
        Width = 340
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllRedBaseCalc: TRLLabel
        Left = 590
        Height = 13
        Top = 101
        Width = 57
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllICMS_ST: TRLLabel
        Left = 656
        Height = 13
        Top = 101
        Width = 81
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllBaseCalc: TRLLabel
        Left = 350
        Height = 13
        Top = 101
        Width = 95
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllAliqICMS: TRLLabel
        Left = 454
        Height = 13
        Top = 101
        Width = 41
        Alignment = taRightJustify
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel58: TRLLabel
        Left = 656
        Height = 8
        Top = 94
        Width = 29
        Caption = 'ICMS ST'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel56: TRLLabel
        Left = 454
        Height = 8
        Top = 94
        Width = 39
        Caption = 'ALÍQ. ICMS'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel55: TRLLabel
        Left = 350
        Height = 8
        Top = 94
        Width = 66
        Caption = 'BASE DE CÁLCULO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel54: TRLLabel
        Left = 504
        Height = 8
        Top = 94
        Width = 45
        Caption = 'VALOR ICMS'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel53: TRLLabel
        Left = 590
        Height = 8
        Top = 94
        Width = 59
        Caption = '% RED.BC.CALC.'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel52: TRLLabel
        Left = 3
        Height = 8
        Top = 94
        Width = 81
        Caption = 'SITUAÇÃO TRIBUTÁRIA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel51: TRLLabel
        Left = 8
        Height = 13
        Top = 79
        Width = 728
        Alignment = taCenter
        AutoSize = False
        Caption = 'INFORMAÇÕES RELATIVAS AO IMPOSTO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel50: TRLLabel
        Left = 560
        Height = 9
        Top = 48
        Width = 96
        AutoSize = False
        Caption = 'VALOR A RECEBER'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel49: TRLLabel
        Left = 560
        Height = 9
        Top = 18
        Width = 96
        AutoSize = False
        Caption = 'VALOR TOTAL DO SERVIÇO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel48: TRLLabel
        Left = 528
        Height = 8
        Top = 18
        Width = 26
        Caption = 'VALOR'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel47: TRLLabel
        Left = 377
        Height = 8
        Top = 18
        Width = 22
        Caption = 'NOME'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel46: TRLLabel
        Left = 156
        Height = 8
        Top = 18
        Width = 26
        Caption = 'VALOR'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel45: TRLLabel
        Left = 342
        Height = 8
        Top = 18
        Width = 26
        Caption = 'VALOR'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel44: TRLLabel
        Left = 5
        Height = 8
        Top = 18
        Width = 22
        Caption = 'NOME'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel42: TRLLabel
        Left = 190
        Height = 8
        Top = 18
        Width = 22
        Caption = 'NOME'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel38: TRLLabel
        Left = 6
        Height = 13
        Top = 3
        Width = 732
        Alignment = taCenter
        AutoSize = False
        Caption = 'COMPONENTES DO VALOR DA PRESTAÇÃO DE SERVIÇO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
    end
    object rlb_12_ModAereo: TRLBand[13]
      Left = 26
      Height = 97
      Top = 1411
      Width = 742
      BandType = btColumnFooter
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_12_ModAereoBeforePrint
      object RLDraw47: TRLDraw
        Left = 0
        Height = 96
        Top = 0
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw66: TRLDraw
        Left = 68
        Height = 22
        Top = 49
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw67: TRLDraw
        Left = 90
        Height = 22
        Top = 49
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw68: TRLDraw
        Left = 154
        Height = 22
        Top = 49
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw69: TRLDraw
        Left = 540
        Height = 24
        Top = 15
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw65: TRLDraw
        Left = 260
        Height = 56
        Top = 15
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw57: TRLDraw
        Left = 1
        Height = 1
        Top = 38
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw72: TRLDraw
        Left = 596
        Height = 56
        Top = 39
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw70: TRLDraw
        Left = 34
        Height = 26
        Top = 70
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllTrecho: TRLLabel
        Left = 2
        Height = 12
        Top = 58
        Width = 37
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllTarifaValor: TRLLabel
        Left = 158
        Height = 13
        Top = 58
        Width = 95
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllTarifaCodigo: TRLLabel
        Left = 95
        Height = 12
        Top = 58
        Width = 22
        Caption = '1234'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllTarifaCL: TRLLabel
        Left = 72
        Height = 12
        Top = 58
        Width = 12
        Caption = '12'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllRetira: TRLLabel
        Left = 2
        Height = 13
        Top = 81
        Width = 26
        Alignment = taCenter
        AutoSize = False
        Caption = 'SIM'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllMinuta: TRLLabel
        Left = 672
        Height = 19
        Top = 50
        Width = 65
        AutoSize = False
        Caption = '123456789'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllLojaAgenteEmissor: TRLLabel
        Left = 598
        Height = 12
        Top = 81
        Width = 88
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllDadosRetira: TRLLabel
        Left = 39
        Height = 14
        Top = 81
        Width = 554
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllContaCorrente: TRLLabel
        Left = 262
        Height = 12
        Top = 49
        Width = 67
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCaracAdTransporte: TRLLabel
        Left = 262
        Height = 12
        Top = 25
        Width = 85
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCaracAdServico: TRLLabel
        Left = 6
        Height = 12
        Top = 25
        Width = 73
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllAWB: TRLLabel
        Left = 632
        Height = 19
        Top = 16
        Width = 105
        AutoSize = False
        Caption = '000-0-000000000-0'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel157: TRLLabel
        Left = 598
        Height = 8
        Top = 72
        Width = 92
        Caption = 'LOJA OU AGENTE EMISSOR'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel156: TRLLabel
        Left = 262
        Height = 8
        Top = 40
        Width = 65
        Caption = 'CONTA CORRENTE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel155: TRLLabel
        Left = 262
        Height = 8
        Top = 16
        Width = 167
        Caption = 'CARACTERISTICAS ADICIONAIS DO TRANSPORTE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel154: TRLLabel
        Left = 6
        Height = 8
        Top = 16
        Width = 152
        Caption = 'CARACTERISTICAS ADICIONAIS DO SERVIÇO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel153: TRLLabel
        Left = 8
        Height = 13
        Top = 2
        Width = 730
        Alignment = taCenter
        AutoSize = False
        Caption = 'INFORMAÇÕES ESPECÍFICAS DO MODAL AÉREO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel150: TRLLabel
        Left = 39
        Height = 8
        Top = 72
        Width = 149
        Caption = 'DADOS RELATIVOS A RETIRADA DA CARGA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel149: TRLLabel
        Left = 2
        Height = 8
        Top = 72
        Width = 27
        Caption = 'RETIRA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel148: TRLLabel
        Left = 598
        Height = 8
        Top = 40
        Width = 73
        Caption = 'NÚMERO DA MINUTA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel147: TRLLabel
        Left = 158
        Height = 8
        Top = 50
        Width = 26
        Caption = 'VALOR'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel146: TRLLabel
        Left = 95
        Height = 8
        Top = 50
        Width = 29
        Caption = 'CÓDIGO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel145: TRLLabel
        Left = 72
        Height = 8
        Top = 50
        Width = 11
        Caption = 'CL'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel144: TRLLabel
        Left = 2
        Height = 8
        Top = 50
        Width = 30
        Caption = 'TRECHO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel142: TRLLabel
        Left = 8
        Height = 9
        Top = 40
        Width = 250
        Alignment = taCenter
        AutoSize = False
        Caption = 'DADOS DA TARIFA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel141: TRLLabel
        Left = 543
        Height = 8
        Top = 16
        Width = 83
        Caption = 'NÚMERO OPERACIONAL'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLDraw54: TRLDraw
        Left = 1
        Height = 1
        Top = 14
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw63: TRLDraw
        Left = 0
        Height = 1
        Top = 70
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw64: TRLDraw
        Left = 0
        Height = 1
        Top = 48
        Width = 260
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
    end
    object rlb_13_ModAquaviario: TRLBand[14]
      Left = 26
      Height = 90
      Top = 1508
      Width = 742
      BandType = btColumnFooter
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_13_ModAquaviarioBeforePrint
      object RLDraw73: TRLDraw
        Left = 0
        Height = 89
        Top = 0
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel151: TRLLabel
        Left = 6
        Height = 13
        Top = 3
        Width = 732
        Alignment = taCenter
        AutoSize = False
        Caption = 'DADOS ESPECÍFICOS DO MODAL AQUAVIÁRIO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLDraw74: TRLDraw
        Left = 1
        Height = 1
        Top = 14
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel152: TRLLabel
        Left = 6
        Height = 8
        Top = 16
        Width = 77
        Caption = 'PORTO DE EMBARQUE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllPortoEmbarque: TRLLabel
        Left = 6
        Height = 12
        Top = 25
        Width = 71
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel158: TRLLabel
        Left = 406
        Height = 8
        Top = 16
        Width = 67
        Caption = 'PORTO DE DESTINO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllPortoDestino: TRLLabel
        Left = 406
        Height = 12
        Top = 25
        Width = 64
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw75: TRLDraw
        Left = 1
        Height = 1
        Top = 38
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel159: TRLLabel
        Left = 6
        Height = 8
        Top = 40
        Width = 141
        Caption = 'IDENTIFICAÇÃO DO NAVIO / REBOCADOR'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllIndNavioRebocador: TRLLabel
        Left = 6
        Height = 12
        Top = 49
        Width = 89
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw76: TRLDraw
        Left = 1
        Height = 1
        Top = 62
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel160: TRLLabel
        Left = 6
        Height = 8
        Top = 64
        Width = 108
        Caption = 'IDENTIFICAÇÃO DA(S) BALSA(S)'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllIndConteiners: TRLLabel
        Left = 406
        Height = 12
        Top = 73
        Width = 66
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw77: TRLDraw
        Left = 402
        Height = 73
        Top = 15
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel162: TRLLabel
        Left = 406
        Height = 8
        Top = 40
        Width = 95
        Caption = 'VR DA B. DE CALC. AFRMM'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllBCAFRMM: TRLLabel
        Left = 406
        Height = 12
        Top = 49
        Width = 57
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel164: TRLLabel
        Left = 518
        Height = 8
        Top = 40
        Width = 56
        Caption = 'VLR DO AFRMM'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllValorAFRMM: TRLLabel
        Left = 518
        Height = 12
        Top = 49
        Width = 66
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel166: TRLLabel
        Left = 614
        Height = 8
        Top = 40
        Width = 74
        Caption = 'TIPO DE NAVEGAÇÃO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllTipoNav: TRLLabel
        Left = 614
        Height = 12
        Top = 49
        Width = 45
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel168: TRLLabel
        Left = 694
        Height = 8
        Top = 40
        Width = 33
        Caption = 'DIREÇÃO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllDirecao: TRLLabel
        Left = 694
        Height = 12
        Top = 49
        Width = 41
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw78: TRLDraw
        Left = 690
        Height = 24
        Top = 39
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw79: TRLDraw
        Left = 610
        Height = 24
        Top = 39
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw80: TRLDraw
        Left = 514
        Height = 24
        Top = 39
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel178: TRLLabel
        Left = 406
        Height = 8
        Top = 64
        Width = 116
        Caption = 'IDENTIFICAÇÃO DOS CONTEINERS'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllIndBalsas: TRLLabel
        Left = 6
        Height = 12
        Top = 73
        Width = 49
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
    end
    object rlb_14_ModFerroviario: TRLBand[15]
      Left = 26
      Height = 6
      Top = 1598
      Width = 742
      BandType = btColumnFooter
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_14_ModFerroviarioBeforePrint
    end
    object rlb_15_ModDutoviario: TRLBand[16]
      Left = 26
      Height = 6
      Top = 1604
      Width = 742
      BandType = btColumnFooter
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_15_ModDutoviarioBeforePrint
    end
    object rlb_01_Recibo_Aereo: TRLBand[17]
      Left = 26
      Height = 146
      Top = 108
      Width = 742
      BandType = btHeader
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_01_Recibo_AereoBeforePrint
      object RLDraw10: TRLDraw
        Left = 0
        Height = 145
        Top = 0
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw53: TRLDraw
        Left = 367
        Height = 78
        Top = 66
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw2: TRLDraw
        Left = 1
        Height = 1
        Top = 15
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel70: TRLLabel
        Left = 6
        Height = 12
        Top = 109
        Width = 15
        Caption = 'RG'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel66: TRLLabel
        Left = 6
        Height = 12
        Top = 80
        Width = 30
        Caption = 'NOME'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel65: TRLLabel
        Left = 6
        Height = 13
        Top = 2
        Width = 730
        Alignment = taCenter
        AutoSize = False
        Caption = 'DECLARO QUE RECEBI OS VOLUMES DESTE CONHECIMENTO EM PERFEITO ESTADO PELO QUE DOU POR CUMPRIDO O PRESENTE CONTRATO DE TRANSPORTE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel19: TRLLabel
        Left = 6
        Height = 48
        Top = 17
        Width = 730
        AutoSize = False
        Caption = 'O Transporte coberto por este conhecimento se rege pelo código Brasileiro de Aeronáutica (Lei 7.565 de 19/12/1986), especificamente pelas regras relativas a responsabilidade Civil prevista nos artigos 193, 241, 244, 262 e 264, de cujo teor o Expedidor / Remetente declara concordar e ter plena ciência. O Expedidor / Remetente aceita como corretas todas as especificações impressas, manuscritas, datilografadas ou carimbadas neste conhecimento, certificando que os artigos perigosos descritos pela regulamentação da I.C.A.O. foram devidamente informados e acondicionados para transporte Aéreo.'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLDraw81: TRLDraw
        Left = 1
        Height = 1
        Top = 66
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw82: TRLDraw
        Left = 1
        Height = 1
        Top = 77
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel57: TRLLabel
        Left = 121
        Height = 8
        Top = 68
        Width = 88
        Alignment = taCenter
        Caption = 'EXPEDIDOR / REMETENTE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel60: TRLLabel
        Left = 508
        Height = 8
        Top = 68
        Width = 100
        Alignment = taCenter
        Caption = 'DESTINATÁRIO / RECEBEDOR'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel69: TRLLabel
        Left = 206
        Height = 12
        Top = 80
        Width = 62
        Caption = 'DATA / HORA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel161: TRLLabel
        Left = 206
        Height = 12
        Top = 109
        Width = 61
        Caption = 'ASSINATURA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel67: TRLLabel
        Left = 374
        Height = 12
        Top = 80
        Width = 30
        Caption = 'NOME'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel68: TRLLabel
        Left = 374
        Height = 12
        Top = 109
        Width = 15
        Caption = 'RG'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel72: TRLLabel
        Left = 574
        Height = 12
        Top = 80
        Width = 62
        Caption = 'DATA / HORA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel163: TRLLabel
        Left = 574
        Height = 12
        Top = 109
        Width = 61
        Caption = 'ASSINATURA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
    end
    object rlb_11_ModRodLot104: TRLBand[18]
      Left = 26
      Height = 105
      Top = 1306
      Width = 742
      BandType = btColumnFooter
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_11_ModRodLot104BeforePrint
      object RLDraw4: TRLDraw
        Left = 0
        Height = 104
        Top = 0
        Width = 740
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw30: TRLDraw
        Left = 207
        Height = 103
        Top = 0
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw83: TRLDraw
        Left = 1
        Height = 1
        Top = 14
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw84: TRLDraw
        Left = 42
        Height = 66
        Top = 13
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw85: TRLDraw
        Left = 100
        Height = 66
        Top = 13
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw86: TRLDraw
        Left = 122
        Height = 66
        Top = 13
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw87: TRLDraw
        Left = 1
        Height = 1
        Top = 25
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw89: TRLDraw
        Left = 1
        Height = 1
        Top = 78
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw90: TRLDraw
        Left = 345
        Height = 25
        Top = 78
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw92: TRLDraw
        Left = 330
        Height = 66
        Top = 13
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel167: TRLLabel
        Left = 2
        Height = 8
        Top = 15
        Width = 17
        Caption = 'TIPO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel169: TRLLabel
        Left = 214
        Height = 13
        Top = 1
        Width = 524
        Alignment = taCenter
        AutoSize = False
        Caption = 'INFORMAÇÕES REFERENTES AO VALE-PEDÁGIO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel170: TRLLabel
        Left = 2
        Height = 13
        Top = 1
        Width = 202
        Alignment = taCenter
        AutoSize = False
        Caption = 'IDENTIFICAÇÃO DO CONJ. TRANSPORTADOR'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel171: TRLLabel
        Left = 351
        Height = 8
        Top = 81
        Width = 148
        Caption = 'IDENTIFICAÇÃO DOS LACRES EM TRÂNSITO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel172: TRLLabel
        Left = 212
        Height = 8
        Top = 81
        Width = 69
        Caption = 'CPF DO MOTORISTA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel173: TRLLabel
        Left = 4
        Height = 8
        Top = 81
        Width = 76
        Caption = 'NOME DO MOTORISTA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel174: TRLLabel
        Left = 334
        Height = 8
        Top = 15
        Width = 87
        Caption = 'NÚMERO COMPROVANTE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel177: TRLLabel
        Left = 618
        Height = 8
        Top = 15
        Width = 70
        Caption = 'CNPJ RESPONSÁVEL'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel179: TRLLabel
        Left = 210
        Height = 8
        Top = 15
        Width = 68
        Caption = 'CNPJ FORNECEDOR'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel181: TRLLabel
        Left = 124
        Height = 8
        Top = 15
        Width = 26
        Caption = 'RNTRC'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel182: TRLLabel
        Left = 102
        Height = 8
        Top = 15
        Width = 11
        Caption = 'UF'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel183: TRLLabel
        Left = 44
        Height = 8
        Top = 15
        Width = 25
        Caption = 'PLACA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlmUF2: TRLMemo
        Left = 102
        Height = 50
        Top = 27
        Width = 16
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Uf1'
          'Uf2'
          'Uf3'
          'Uf4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmTipo2: TRLMemo
        Left = 2
        Height = 50
        Top = 27
        Width = 36
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Tipo 1'
          'Tipo 2'
          'Tipo 3'
          'Tipo 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmRNTRC2: TRLMemo
        Left = 124
        Height = 50
        Top = 27
        Width = 77
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'RNTRC 1'
          'RNTRC 2'
          'RNTRC 3'
          'RNTRC 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmPlaca2: TRLMemo
        Left = 44
        Height = 50
        Top = 27
        Width = 53
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Placa 1'
          'Placa 2'
          'Placa 3'
          'Placa 4'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmCNPJForn: TRLMemo
        Left = 210
        Height = 48
        Top = 27
        Width = 117
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Empresa 1'
          'Empresa 2'
          'Empresa 3'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmNumCompra: TRLMemo
        Left = 334
        Height = 48
        Top = 27
        Width = 275
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Transacao 1'
          'Transacao 2'
          'Transacao 3'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllNomeMotorista2: TRLLabel
        Left = 4
        Height = 12
        Top = 90
        Width = 76
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllLacres2: TRLLabel
        Left = 351
        Height = 12
        Top = 90
        Width = 41
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCPFMotorista2: TRLLabel
        Left = 212
        Height = 12
        Top = 90
        Width = 71
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw98: TRLDraw
        Left = 614
        Height = 66
        Top = 13
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmCNPJPg: TRLMemo
        Left = 618
        Height = 48
        Top = 27
        Width = 117
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Empresa 1'
          'Empresa 2'
          'Empresa 3'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
    end
    object rlb_18_Recibo: TRLBand[19]
      Left = 26
      Height = 82
      Top = 1678
      Width = 742
      BandType = btSummary
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_18_ReciboBeforePrint
      object RLDraw97: TRLDraw
        Left = 0
        Height = 78
        Top = 0
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw91: TRLDraw
        Left = 202
        Height = 52
        Top = 25
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw93: TRLDraw
        Left = 473
        Height = 52
        Top = 25
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw94: TRLDraw
        Left = 593
        Height = 52
        Top = 25
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw95: TRLDraw
        Left = 1
        Height = 1
        Top = 51
        Width = 201
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw96: TRLDraw
        Left = 1
        Height = 1
        Top = 25
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel175: TRLLabel
        Left = 480
        Height = 16
        Top = 59
        Width = 108
        Alignment = taCenter
        AutoSize = False
        Caption = '__/__/__    __:__'
        Color = clWhite
        Font.CharSet = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel176: TRLLabel
        Left = 480
        Height = 16
        Top = 35
        Width = 108
        Alignment = taCenter
        AutoSize = False
        Caption = '__/__/__    __:__'
        Color = clWhite
        Font.CharSet = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel180: TRLLabel
        Left = 647
        Height = 13
        Top = 27
        Width = 28
        Caption = 'CT-E'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel184: TRLLabel
        Left = 605
        Height = 12
        Top = 43
        Width = 14
        Caption = 'Nº '
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel185: TRLLabel
        Left = 605
        Height = 12
        Top = 57
        Width = 30
        Caption = 'SÉRIE:'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel186: TRLLabel
        Left = 6
        Height = 13
        Top = 2
        Width = 732
        Alignment = taCenter
        AutoSize = False
        Caption = 'DECLARO QUE RECEBI OS VOLUMES DESTE CONHECIMENTO EM PERFEITO ESTADO PELO QUE DOU POR CUMPRIDO O PRESENTE CONTRATO DE TRANSPORTE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel187: TRLLabel
        Left = 6
        Height = 12
        Top = 32
        Width = 30
        Caption = 'NOME'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel188: TRLLabel
        Left = 480
        Height = 9
        Top = 27
        Width = 108
        Alignment = taCenter
        AutoSize = False
        Caption = 'CHEGADA DATA/HORA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel189: TRLLabel
        Left = 480
        Height = 9
        Top = 50
        Width = 108
        Alignment = taCenter
        AutoSize = False
        Caption = 'SAÍDA DATA/HORA'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel190: TRLLabel
        Left = 207
        Height = 13
        Top = 58
        Width = 262
        Alignment = taCenter
        AutoSize = False
        Caption = 'ASSINATURA / CARIMBO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel191: TRLLabel
        Left = 6
        Height = 12
        Top = 56
        Width = 15
        Caption = 'RG'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllSerie3: TRLLabel
        Left = 655
        Height = 13
        Top = 57
        Width = 50
        Alignment = taCenter
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllNumCTe3: TRLLabel
        Left = 638
        Height = 16
        Top = 43
        Width = 86
        Alignment = taRightJustify
        AutoSize = False
        Caption = '999999999'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rllResumoCanhotoCTe2: TRLLabel
        Left = 6
        Height = 13
        Top = 12
        Width = 732
        Alignment = taCenter
        AutoSize = False
        Caption = 'RESUMO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
    end
    object rlb_06_ProdutosPerigosos: TRLBand[20]
      Left = 26
      Height = 82
      Top = 854
      Width = 742
      BandType = btColumnHeader
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_06_ProdutosPerigososBeforePrint
      object RLDraw101: TRLDraw
        Left = 0
        Height = 81
        Top = 0
        Width = 741
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel192: TRLLabel
        Left = 6
        Height = 13
        Top = 2
        Width = 732
        Alignment = taCenter
        AutoSize = False
        Caption = 'INFORMAÇÕES SOBRE OS PRODUTOS PERIGOSOS'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLDraw102: TRLDraw
        Left = 1
        Height = 1
        Top = 15
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLLabel193: TRLLabel
        Left = 5
        Height = 8
        Top = 18
        Width = 36
        Caption = 'NRO. ONU'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel194: TRLLabel
        Left = 84
        Height = 8
        Top = 18
        Width = 69
        Caption = 'NOME APROPRIADO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel195: TRLLabel
        Left = 310
        Height = 8
        Top = 18
        Width = 145
        Caption = 'CLASSE/SUBCLASSE E RISCO SUBSIDIÁRIO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel196: TRLLabel
        Left = 510
        Height = 8
        Top = 18
        Width = 83
        Caption = 'GRUPO DE EMBALAGEM'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLLabel197: TRLLabel
        Left = 625
        Height = 8
        Top = 18
        Width = 79
        Caption = 'QTDE TOTAL PRODUTO'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -7
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object RLDraw103: TRLDraw
        Left = 80
        Height = 66
        Top = 15
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw104: TRLDraw
        Left = 300
        Height = 66
        Top = 15
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw105: TRLDraw
        Left = 500
        Height = 66
        Top = 15
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw106: TRLDraw
        Left = 620
        Height = 66
        Top = 15
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        DrawKind = dkLine
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmNumONU: TRLMemo
        Left = 5
        Height = 45
        Top = 32
        Width = 68
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'NUM ONU'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmNomeApropriado: TRLMemo
        Left = 85
        Height = 45
        Top = 32
        Width = 212
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Nome Apropriado'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmClasse: TRLMemo
        Left = 309
        Height = 45
        Top = 32
        Width = 188
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Classe'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmGrupoEmbalagem: TRLMemo
        Left = 509
        Height = 45
        Top = 32
        Width = 108
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Grupo de Embalagem'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmQtdeProduto: TRLMemo
        Left = 625
        Height = 45
        Top = 32
        Width = 112
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          'Quantidade'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLDraw107: TRLDraw
        Left = 1
        Height = 1
        Top = 29
        Width = 740
        HelpContext = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
    end
  end
  object rlbCodigoBarras: TRLBarcode[1]
    Left = 496
    Height = 32
    Top = 320
    Width = 132
    Alignment = taCenter
    BarcodeType = bcCode128C
    Margins.LeftMargin = 1
    Margins.RightMargin = 1
    RealBounds.Left = 0
    RealBounds.Top = 0
    RealBounds.Width = 0
    RealBounds.Height = 0
    Transparent = False
  end
  inherited RLPDFFilter1: TRLPDFFilter[2]
  end
  inherited Datasource1: TDatasource[3]
  end
end
