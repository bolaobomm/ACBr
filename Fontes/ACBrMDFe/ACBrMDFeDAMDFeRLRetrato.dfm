inherited frlDAMDFeRLRetrato: TfrlDAMDFeRLRetrato
  Left = 259
  Height = 637
  Top = 148
  Width = 838
  Caption = 'Manifesto - Retrato'
  ClientHeight = 637
  ClientWidth = 838
  Font.Height = -8
  Font.Name = 'Arial'
  Font.Style = [fsBold]
  inherited RLMDFe: TRLReport
    Tag = 1
    Left = 8
    Top = 8
    Font.Height = -8
    Font.Name = 'Courier New'
    Margins.LeftMargin = 7
    Margins.TopMargin = 7
    Margins.RightMargin = 7
    Margins.BottomMargin = 7
    BeforePrint = rlMDFeBeforePrint
    object rlb_1_DadosManifesto: TRLBand[0]
      Left = 26
      Height = 267
      Top = 26
      Width = 742
      BandType = btTitle
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_1_DadosManifestoBeforePrint
      object rlsQuadro4: TRLDraw
        Left = 0
        Height = 62
        Top = 200
        Width = 752
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsQuadro3: TRLDraw
        Left = 352
        Height = 169
        Top = 0
        Width = 400
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsQuadro2: TRLDraw
        Left = 0
        Height = 33
        Top = 168
        Width = 752
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsQuadro1: TRLDraw
        Left = 0
        Height = 169
        Top = 0
        Width = 353
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsHorizontal1: TRLDraw
        Left = 0
        Height = 1
        Top = 218
        Width = 752
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlLabel8: TRLLabel
        Left = 456
        Height = 29
        Top = 4
        Width = 273
        AutoSize = False
        Caption = 'Documento Auxiliar de Manifesto Eletrônico de Documentos Fiscais'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlLabel17: TRLLabel
        Left = 356
        Height = 22
        Top = 6
        Width = 89
        Caption = 'DAMDFE'
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rliLogo: TRLImage
        Left = 9
        Height = 96
        Top = 57
        Width = 96
        Center = True
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Stretch = True
      end
      object rlmEmitente: TRLMemo
        Left = 7
        Height = 39
        Top = 10
        Width = 338
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
        Height = 108
        Top = 53
        Width = 232
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
      object rlShape1: TRLDraw
        Left = 352
        Height = 1
        Top = 35
        Width = 400
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlLabel74: TRLLabel
        Left = 510
        Height = 11
        Top = 38
        Width = 63
        Caption = 'Controle do Fisco'
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
      object rlShape2: TRLDraw
        Left = 352
        Height = 1
        Top = 120
        Width = 400
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlLabel1: TRLLabel
        Left = 358
        Height = 11
        Top = 126
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
        Left = 358
        Height = 14
        Top = 148
        Width = 386
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
      object rlLabel2: TRLLabel
        Left = 5
        Height = 8
        Top = 171
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
        Left = 6
        Height = 15
        Top = 182
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
      object rlLabel3: TRLLabel
        Left = 39
        Height = 8
        Top = 171
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
        Left = 40
        Height = 15
        Top = 182
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
      object rlLabel4: TRLLabel
        Left = 64
        Height = 9
        Top = 171
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
      object rllNumMDFe: TRLLabel
        Left = 62
        Height = 15
        Top = 182
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
      object rlLabel25: TRLLabel
        Left = 138
        Height = 9
        Top = 171
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
        Left = 138
        Height = 15
        Top = 182
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
      object rlLabel33: TRLLabel
        Left = 182
        Height = 9
        Top = 171
        Width = 124
        Alignment = taCenter
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
        Left = 182
        Height = 15
        Top = 182
        Width = 124
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
      object rlLabel77: TRLLabel
        Left = 312
        Height = 8
        Top = 171
        Width = 35
        Caption = 'UF Carrega'
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
      object rllUFCarrega: TRLLabel
        Left = 312
        Height = 15
        Top = 182
        Width = 34
        Alignment = taCenter
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
      object rlsLinhaV09: TRLDraw
        Left = 308
        Height = 33
        Top = 168
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaV08: TRLDraw
        Left = 180
        Height = 33
        Top = 168
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaV07: TRLDraw
        Left = 136
        Height = 33
        Top = 168
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaV06: TRLDraw
        Left = 62
        Height = 33
        Top = 168
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaV05: TRLDraw
        Left = 38
        Height = 33
        Top = 168
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlsLinhaV10: TRLDraw
        Left = 352
        Height = 33
        Top = 168
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllDescricao: TRLLabel
        Left = 358
        Height = 8
        Top = 171
        Width = 141
        Caption = 'PROTOCOLO DE AUTORIZAÇÃO DE USO'
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
        Left = 358
        Height = 19
        Top = 180
        Width = 386
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
      object rllModal: TRLLabel
        Left = 8
        Height = 15
        Top = 202
        Width = 738
        Alignment = taCenter
        AutoSize = False
        Caption = 'Modal Rodoviário de Carga'
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
      object rlLabel6: TRLLabel
        Left = 4
        Height = 15
        Top = 222
        Width = 117
        AutoSize = False
        Caption = 'CIOT'
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
      object rlLabel5: TRLLabel
        Left = 130
        Height = 15
        Top = 222
        Width = 87
        AutoSize = False
        Caption = 'QTDE CT-e'
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
      object rlLabel7: TRLLabel
        Left = 224
        Height = 15
        Top = 222
        Width = 87
        AutoSize = False
        Caption = 'QTDE CTRC'
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
      object rlLabel10: TRLLabel
        Left = 318
        Height = 15
        Top = 222
        Width = 87
        AutoSize = False
        Caption = 'QTDE NF-e'
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
      object rlLabel11: TRLLabel
        Left = 412
        Height = 15
        Top = 222
        Width = 87
        AutoSize = False
        Caption = 'QTDE NF'
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
      object rlLabel12: TRLLabel
        Left = 600
        Height = 14
        Top = 222
        Width = 96
        Caption = 'PESO TOTAL (Kg)'
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
      object rlShape3: TRLDraw
        Left = 126
        Height = 44
        Top = 218
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlShape4: TRLDraw
        Left = 220
        Height = 44
        Top = 218
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlShape5: TRLDraw
        Left = 314
        Height = 44
        Top = 218
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlShape6: TRLDraw
        Left = 408
        Height = 44
        Top = 218
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlShape7: TRLDraw
        Left = 596
        Height = 44
        Top = 218
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCIOT: TRLLabel
        Left = 4
        Height = 16
        Top = 240
        Width = 118
        Alignment = taCenter
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllqCTe: TRLLabel
        Left = 130
        Height = 16
        Top = 240
        Width = 88
        Alignment = taCenter
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllqCT: TRLLabel
        Left = 224
        Height = 16
        Top = 240
        Width = 88
        Alignment = taCenter
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllqNFe: TRLLabel
        Left = 318
        Height = 16
        Top = 240
        Width = 88
        Alignment = taCenter
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllqNF: TRLLabel
        Left = 412
        Height = 16
        Top = 240
        Width = 88
        Alignment = taCenter
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllPesoTotal: TRLLabel
        Left = 600
        Height = 16
        Top = 240
        Width = 146
        Alignment = taCenter
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlLabel23: TRLLabel
        Left = 506
        Height = 15
        Top = 222
        Width = 87
        AutoSize = False
        Caption = 'QTDE MDF-e'
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
      object rllqMDFe: TRLLabel
        Left = 506
        Height = 16
        Top = 240
        Width = 88
        Alignment = taCenter
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlShape19: TRLDraw
        Left = 502
        Height = 44
        Top = 218
        Width = 1
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object RLBarcode1: TRLBarcode
        Left = 360
        Height = 57
        Top = 53
        Width = 99
        BarcodeType = bcCode128C
        Margins.LeftMargin = 1
        Margins.RightMargin = 1
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
    end
    object rlb_2_Rodo: TRLBand[1]
      Left = 26
      Height = 208
      Top = 293
      Width = 742
      BandType = btTitle
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_2_RodoBeforePrint
      object rlShape8: TRLDraw
        Left = 0
        Height = 201
        Top = 0
        Width = 752
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlLabel35: TRLLabel
        Left = 4
        Height = 14
        Top = 4
        Width = 37
        Caption = 'Veículo'
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
      object rlLabel9: TRLLabel
        Left = 318
        Height = 14
        Top = 4
        Width = 46
        Caption = 'Condutor'
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
      object rlShape9: TRLDraw
        Left = 0
        Height = 1
        Top = 20
        Width = 752
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlLabel13: TRLLabel
        Left = 4
        Height = 14
        Top = 24
        Width = 28
        Caption = 'Placa'
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
      object rlLabel14: TRLLabel
        Left = 124
        Height = 14
        Top = 24
        Width = 40
        Caption = 'RNTRC'
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
      object rlLabel15: TRLLabel
        Left = 318
        Height = 14
        Top = 24
        Width = 23
        Caption = 'CPF'
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
      object rlLabel16: TRLLabel
        Left = 412
        Height = 14
        Top = 24
        Width = 31
        Caption = 'Nome'
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
      object rlShape10: TRLDraw
        Left = 0
        Height = 1
        Top = 40
        Width = 752
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlShape11: TRLDraw
        Left = 314
        Height = 200
        Top = 0
        Width = 1
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlShape12: TRLDraw
        Left = 120
        Height = 80
        Top = 20
        Width = 1
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmPlaca: TRLMemo
        Left = 4
        Height = 52
        Top = 45
        Width = 109
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          '1 Linha'
          '2 Linha'
          '3 Linha'
          '4 Linha'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlmRNTRC: TRLMemo
        Left = 124
        Height = 52
        Top = 45
        Width = 141
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          '1 Linha'
          '2 Linha'
          '3 Linha'
          '4 Linha'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlmCPF: TRLMemo
        Left = 318
        Height = 148
        Top = 45
        Width = 85
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          '1 Linha'
          '2 Linha'
          '3 Linha'
          '4 Linha'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlShape13: TRLDraw
        Left = 408
        Height = 180
        Top = 20
        Width = 1
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmCondutor: TRLMemo
        Left = 412
        Height = 148
        Top = 45
        Width = 333
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          '1 Linha'
          '2 Linha'
          '3 Linha'
          '4 Linha'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlShape14: TRLDraw
        Left = 0
        Height = 1
        Top = 100
        Width = 314
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlLabel18: TRLLabel
        Left = 4
        Height = 14
        Top = 104
        Width = 62
        Caption = 'Vale Pedágio'
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
      object rlShape15: TRLDraw
        Left = 0
        Height = 1
        Top = 120
        Width = 314
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlLabel19: TRLLabel
        Left = 4
        Height = 14
        Top = 122
        Width = 89
        Caption = 'Responsável CNPJ'
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
      object rlLabel20: TRLLabel
        Left = 98
        Height = 14
        Top = 122
        Width = 84
        Caption = 'Fornecedor CNPJ'
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
      object rlLabel21: TRLLabel
        Left = 196
        Height = 14
        Top = 122
        Width = 81
        Caption = 'N. Comprovante'
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
      object rlShape16: TRLDraw
        Left = 94
        Height = 80
        Top = 120
        Width = 1
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlShape17: TRLDraw
        Left = 192
        Height = 80
        Top = 120
        Width = 1
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmRespCNPJ: TRLMemo
        Left = 4
        Height = 52
        Top = 141
        Width = 86
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          '1 Linha'
          '2 Linha'
          '3 Linha'
          '4 Linha'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlmFornCNPJ: TRLMemo
        Left = 100
        Height = 52
        Top = 141
        Width = 86
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          '1 Linha'
          '2 Linha'
          '3 Linha'
          '4 Linha'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlmNumComprovante: TRLMemo
        Left = 196
        Height = 52
        Top = 141
        Width = 114
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          '1 Linha'
          '2 Linha'
          '3 Linha'
          '4 Linha'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
    end
    object rlb_3_Aereo: TRLBand[2]
      Left = 26
      Height = 40
      Top = 501
      Width = 742
      BandType = btColumnHeader
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_3_AereoBeforePrint
    end
    object rlb_4_Aquav: TRLBand[3]
      Left = 26
      Height = 120
      Top = 541
      Width = 742
      BandType = btColumnHeader
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_4_AquavBeforePrint
      object rlShape20: TRLDraw
        Left = 0
        Height = 113
        Top = 0
        Width = 752
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlLabel24: TRLLabel
        Left = 4
        Height = 14
        Top = 4
        Width = 107
        Caption = 'Código da Embarcação'
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
      object rlLabel26: TRLLabel
        Left = 214
        Height = 14
        Top = 4
        Width = 103
        Caption = 'Nome da Embarcação'
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
      object rlShape21: TRLDraw
        Left = 206
        Height = 20
        Top = 0
        Width = 1
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlShape22: TRLDraw
        Left = 0
        Height = 1
        Top = 20
        Width = 752
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllCodEmbar: TRLLabel
        Left = 116
        Height = 16
        Top = 2
        Width = 85
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllNomeEmbar: TRLLabel
        Left = 322
        Height = 16
        Top = 2
        Width = 423
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlShape23: TRLDraw
        Left = 376
        Height = 92
        Top = 20
        Width = 1
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlShape24: TRLDraw
        Left = 70
        Height = 92
        Top = 20
        Width = 1
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlShape25: TRLDraw
        Left = 446
        Height = 92
        Top = 20
        Width = 1
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlShape26: TRLDraw
        Left = 0
        Height = 1
        Top = 40
        Width = 752
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlLabel27: TRLLabel
        Left = 6
        Height = 14
        Top = 24
        Width = 35
        Caption = 'Código'
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
      object rlLabel28: TRLLabel
        Left = 78
        Height = 14
        Top = 24
        Width = 172
        Caption = 'Nome do Terminal de Carregamento'
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
      object rlLabel29: TRLLabel
        Left = 382
        Height = 14
        Top = 24
        Width = 35
        Caption = 'Código'
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
      object rlLabel30: TRLLabel
        Left = 454
        Height = 14
        Top = 24
        Width = 187
        Caption = 'Nome do Terminal de Descarregamento'
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
      object rlmCodCarreg: TRLMemo
        Left = 6
        Height = 62
        Top = 45
        Width = 59
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          '1 Linha'
          '2 Linha'
          '3 Linha'
          '4 Linha'
          '5 Linha'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlmCodDescarreg: TRLMemo
        Left = 382
        Height = 62
        Top = 45
        Width = 59
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          '1 Linha'
          '2 Linha'
          '3 Linha'
          '4 Linha'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlmNomeCarreg: TRLMemo
        Left = 78
        Height = 62
        Top = 45
        Width = 291
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          '1 Linha'
          '2 Linha'
          '3 Linha'
          '4 Linha'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
      object rlmNomeDescarreg: TRLMemo
        Left = 454
        Height = 62
        Top = 45
        Width = 291
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          '1 Linha'
          '2 Linha'
          '3 Linha'
          '4 Linha'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
        Transparent = False
      end
    end
    object rlb_5_Ferrov: TRLBand[4]
      Left = 26
      Height = 40
      Top = 661
      Width = 742
      BandType = btColumnHeader
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_5_FerrovBeforePrint
    end
    object rlb_6_Observacao: TRLBand[5]
      Left = 26
      Height = 152
      Top = 701
      Width = 742
      BandType = btColumnHeader
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      BeforePrint = rlb_6_ObservacaoBeforePrint
      object rlShape18: TRLDraw
        Left = 0
        Height = 137
        Top = 0
        Width = 752
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlLabel22: TRLLabel
        Left = 4
        Height = 14
        Top = 4
        Width = 56
        Caption = 'Observação'
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
      object rlmObservacao: TRLMemo
        Left = 4
        Height = 108
        Top = 21
        Width = 741
        AutoSize = False
        Color = clWhite
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Times New Roman'
        Lines.Strings = (
          '1 Linha'
          '2 Linha'
          '3 Linha'
          '4 Linha'
        )
        ParentColor = False
        ParentFont = False
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rllMsgTeste: TRLLabel
        Left = 14
        Height = 31
        Top = 38
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
      object rllDataHoraImpressao: TRLLabel
        Left = 2
        Height = 10
        Top = 138
        Width = 77
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
      object rllSistema: TRLLabel
        Left = 356
        Height = 11
        Top = 139
        Width = 392
        Alignment = taRightJustify
        AutoSize = False
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
    end
    object rlb_8_Documentos_Lista: TRLBand[6]
      Left = 26
      Height = 24
      Top = 887
      Width = 742
      BandType = btColumnHeader
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      object rlmChave1: TRLDBText
        Left = 3
        Height = 16
        Top = 4
        Width = 366
        AutoSize = False
        Color = clWhite
        DataField = 'Chave_1'
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
      object rls2: TRLDraw
        Left = 374
        Height = 22
        Top = 0
        Width = 1
        Angle = 0
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlmChave2: TRLDBText
        Left = 380
        Height = 16
        Top = 4
        Width = 366
        AutoSize = False
        Color = clWhite
        DataField = 'Chave_2'
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
    object rlb_7_Documentos_Titulos: TRLBand[7]
      Left = 26
      Height = 34
      Top = 853
      Width = 742
      BandType = btColumnHeader
      Color = clWhite
      ParentColor = False
      RealBounds.Left = 0
      RealBounds.Top = 0
      RealBounds.Width = 0
      RealBounds.Height = 0
      object rlsQuadrado5: TRLDraw
        Left = 0
        Height = 20
        Top = 0
        Width = 752
        Angle = 0
        Brush.Style = bsClear
        RealBounds.Left = 0
        RealBounds.Top = 0
        RealBounds.Width = 0
        RealBounds.Height = 0
      end
      object rlLabel141: TRLLabel
        Left = 254
        Height = 12
        Top = 4
        Width = 244
        Alignment = taCenter
        Caption = 'RELAÇÃO DOS DOCUMENTOS FISCAIS ELETRÔNICOS'
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
      object rlLabel91: TRLLabel
        Left = 5
        Height = 8
        Top = 22
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
      object rlLabel92: TRLLabel
        Left = 88
        Height = 8
        Top = 22
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
      object rlLabel96: TRLLabel
        Left = 174
        Height = 8
        Top = 22
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
      object rlLabel109: TRLLabel
        Left = 381
        Height = 8
        Top = 22
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
      object rlLabel106: TRLLabel
        Left = 464
        Height = 8
        Top = 22
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
      object rlLabel100: TRLLabel
        Left = 550
        Height = 8
        Top = 22
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
  end
end
