object ACBrNFeDANFCeFortesFr: TACBrNFeDANFCeFortesFr
  Left = 557
  Top = 185
  Width = 771
  Height = 991
  Caption = 'ACBrNFeDANFCeFortesFr'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object rlVenda: TRLReport
    Left = 16
    Top = 0
    Width = 302
    Height = 1512
    AllowedBands = [btHeader, btDetail, btSummary, btFooter]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Arial'
    Font.Style = []
    Margins.LeftMargin = 2.000000000000000000
    Margins.TopMargin = 2.000000000000000000
    Margins.RightMargin = 2.000000000000000000
    Margins.BottomMargin = 20.000000000000000000
    PageSetup.PaperSize = fpCustom
    PageSetup.PaperWidth = 80.000000000000000000
    PageSetup.PaperHeight = 400.000000000000000000
    PrintDialog = False
    ShowProgress = False
    BeforePrint = rlVendaBeforePrint
    OnDataRecord = rlVendaDataRecord
    object rlbRodape: TRLBand
      Left = 8
      Top = 442
      Width = 286
      Height = 197
      AutoSize = True
      BandType = btSummary
      Margins.LeftMargin = 2.000000000000000000
      object RLDraw2: TRLDraw
        Left = 8
        Top = 0
        Width = 278
        Height = 8
        Align = faTop
        DrawKind = dkLine
        Pen.Style = psDot
      end
      object lConsultaQRCode: TRLLabel
        Left = 8
        Top = 8
        Width = 278
        Height = 12
        Align = faTop
        Alignment = taCenter
        Caption = 'Consulta via leitor de QR Code'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Layout = tlBottom
        ParentFont = False
      end
      object imgQRCode: TRLImage
        Left = 8
        Top = 37
        Width = 278
        Height = 133
        Align = faBottom
        Center = True
        Scaled = True
      end
      object pGap05: TRLPanel
        Left = 8
        Top = 20
        Width = 278
        Height = 17
        Align = faBottom
      end
      object lProtocolo: TRLLabel
        Left = 8
        Top = 187
        Width = 278
        Height = 10
        Align = faBottom
        Alignment = taCenter
        Caption = 'Protocolo de Autoriza'#231#227'o: 999999999999999 DD/MM/AAAA HH:MM:SS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = []
        Layout = tlBottom
        ParentFont = False
      end
      object pGap8: TRLPanel
        Left = 8
        Top = 170
        Width = 278
        Height = 17
        Align = faBottom
      end
    end
    object rlsbDetItem: TRLSubDetail
      Left = 8
      Top = 148
      Width = 286
      Height = 80
      AllowedBands = [btDetail, btSummary]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      InsideMargins.LeftMargin = 2.000000000000000000
      InsideMargins.RightMargin = 2.000000000000000000
      ParentFont = False
      OnDataRecord = rlsbDetItemDataRecord
      object rlbDetItem: TRLBand
        Left = 8
        Top = 0
        Width = 270
        Height = 20
        AutoSize = True
        BeforePrint = rlbDetItemBeforePrint
        object lTotalItem: TRLLabel
          Left = 236
          Top = 0
          Width = 34
          Height = 20
          Align = faRight
          Alignment = taRightJustify
          Caption = '99.999,99'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Layout = tlBottom
          ParentFont = False
        end
        object lSequencia: TRLLabel
          Left = 0
          Top = 0
          Width = 14
          Height = 10
          Caption = '001'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object mLinhaItem: TRLMemo
          Left = 18
          Top = 0
          Width = 214
          Height = 20
          Behavior = [beSiteExpander]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Lines.Strings = (
            '9999999999999 DESCRICAO DO PRODUTO 99,999 UN x 999,999 (99,99)')
          ParentFont = False
        end
      end
      object rlbDescItem: TRLBand
        Left = 8
        Top = 20
        Width = 270
        Height = 24
        BeforePrint = rlbDescItemBeforePrint
        object lTitDesconto: TRLLabel
          Left = 18
          Top = 1
          Width = 34
          Height = 10
          Caption = 'Desconto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lTitDescValLiq: TRLLabel
          Left = 18
          Top = 13
          Width = 47
          Height = 10
          Caption = 'Valor L'#237'quido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lDesconto: TRLLabel
          Left = 236
          Top = 1
          Width = 34
          Height = 10
          Alignment = taRightJustify
          Caption = '99.999,99'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lDescValLiq: TRLLabel
          Left = 236
          Top = 13
          Width = 34
          Height = 10
          Alignment = taRightJustify
          Caption = '99.999,99'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlbOutroItem: TRLBand
        Left = 8
        Top = 44
        Width = 270
        Height = 24
        BeforePrint = rlbOutroItemBeforePrint
        object lTitAcrescimo: TRLLabel
          Left = 18
          Top = 1
          Width = 38
          Height = 10
          Caption = 'Acr'#233'scimo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lTitOutroValLiq: TRLLabel
          Left = 18
          Top = 13
          Width = 47
          Height = 10
          Caption = 'Valor L'#237'quido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lOutro: TRLLabel
          Left = 236
          Top = 1
          Width = 34
          Height = 10
          Alignment = taRightJustify
          Caption = '99.999,99'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lOutroValLiq: TRLLabel
          Left = 236
          Top = 13
          Width = 34
          Height = 10
          Alignment = taRightJustify
          Caption = '99.999,99'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlbGap: TRLBand
        Left = 8
        Top = 68
        Width = 270
        Height = 2
        BandType = btSummary
        BeforePrint = rlbGapBeforePrint
      end
    end
    object rlsbPagamentos: TRLSubDetail
      Left = 8
      Top = 228
      Width = 286
      Height = 65
      InsideMargins.LeftMargin = 2.000000000000000000
      InsideMargins.RightMargin = 2.000000000000000000
      OnDataRecord = rlsbPagamentosDataRecord
      object rlbPagamento: TRLBand
        Left = 8
        Top = 42
        Width = 270
        Height = 12
        AutoSize = True
        BeforePrint = rlbPagamentoBeforePrint
        object lPagamento: TRLLabel
          Left = 226
          Top = 0
          Width = 44
          Height = 12
          Alignment = taRightJustify
          Caption = '99.999,99'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lMeioPagamento: TRLLabel
          Left = 0
          Top = 0
          Width = 77
          Height = 12
          Caption = 'Cart'#227'o de Cr'#233'dito'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlbTroco: TRLBand
        Left = 8
        Top = 54
        Width = 270
        Height = 12
        AutoSize = True
        BandType = btSummary
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        BeforePrint = rlbTrocoBeforePrint
        object lTitTroco: TRLLabel
          Left = -2
          Top = 0
          Width = 41
          Height = 12
          Caption = 'Troco R$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lTroco: TRLLabel
          Left = 226
          Top = 0
          Width = 44
          Height = 12
          Alignment = taRightJustify
          Caption = '99.999,99'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object rlbTotal: TRLBand
        Left = 8
        Top = 0
        Width = 270
        Height = 42
        AutoSize = True
        BandType = btHeader
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        BeforePrint = rlbTotalBeforePrint
        object lTitTotal: TRLLabel
          Left = -2
          Top = 18
          Width = 80
          Height = 11
          Caption = 'VALOR TOTAL R$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lTotal: TRLLabel
          Left = 226
          Top = 18
          Width = 44
          Height = 11
          Alignment = taRightJustify
          Caption = '99.999,99'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lQtdItens: TRLLabel
          Left = 0
          Top = 6
          Width = 102
          Height = 12
          Caption = 'QTD. TOTAL DE ITENS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lQtdTotalItensVal: TRLLabel
          Left = 239
          Top = 6
          Width = 31
          Height = 12
          Alignment = taRightJustify
          Caption = '99.999'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lTitFormaPagto: TRLLabel
          Left = 0
          Top = 30
          Width = 112
          Height = 12
          Caption = 'FORMA DE PAGAMENTO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lTitValorPago: TRLLabel
          Left = 221
          Top = 30
          Width = 48
          Height = 12
          Alignment = taRightJustify
          Caption = 'Valor Pago'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object RLDraw7: TRLDraw
          Left = 0
          Top = 0
          Width = 270
          Height = 8
          Align = faTop
          DrawKind = dkLine
          Pen.Style = psDot
        end
      end
    end
    object rlbLei12741: TRLBand
      Left = 8
      Top = 293
      Width = 286
      Height = 28
      AutoSize = True
      BandType = btSummary
      InsideMargins.LeftMargin = 2.000000000000000000
      InsideMargins.RightMargin = 2.000000000000000000
      BeforePrint = rlbLei12741BeforePrint
      object RLDraw6: TRLDraw
        Left = 8
        Top = 0
        Width = 270
        Height = 8
        Align = faTop
        DrawKind = dkLine
        Pen.Style = psDot
      end
      object lTitLei12741: TRLLabel
        Left = 8
        Top = 4
        Width = 182
        Height = 12
        Caption = 'Informa'#231#227'o dos Tributos Totais Incidentes '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lTitLei12742: TRLLabel
        Left = 8
        Top = 16
        Width = 112
        Height = 12
        Caption = '(Lei Federal 12.741 /2012)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lValLei12741: TRLLabel
        Left = 232
        Top = 4
        Width = 44
        Height = 11
        Alignment = taRightJustify
        Caption = '99.999,99'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object rlbsCabecalho: TRLSubDetail
      Left = 8
      Top = 8
      Width = 286
      Height = 140
      OnDataRecord = rlbsCabecalhoDataRecord
      object rlbMsgDANFe: TRLBand
        Left = 0
        Top = 60
        Width = 286
        Height = 42
        AutoSize = True
        object lMsgDANFCe: TRLLabel
          Left = 0
          Top = 0
          Width = 286
          Height = 14
          Align = faTop
          Alignment = taCenter
          Caption = 'DANFE NFC-e - Documento Auxiliar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Layout = tlCenter
          ParentFont = False
        end
        object lMsgDANFCe1: TRLLabel
          Left = 0
          Top = 28
          Width = 286
          Height = 14
          Align = faTop
          Alignment = taCenter
          Caption = 'N'#227'o permite aproveitamento de cr'#233'dito de ICMS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Layout = tlCenter
          ParentFont = False
        end
        object lMsgDANFCe2: TRLLabel
          Left = 0
          Top = 14
          Width = 286
          Height = 14
          Align = faTop
          Alignment = taCenter
          Caption = 'da Nota Fiscal Eletr'#244'nica para Consumidor Final'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Layout = tlCenter
          ParentFont = False
        end
      end
      object rlbDadosCliche: TRLBand
        Left = 0
        Top = 0
        Width = 286
        Height = 60
        AutoSize = True
        object pLogoeCliche: TRLPanel
          Left = 0
          Top = 0
          Width = 286
          Height = 60
          Align = faTop
          AutoExpand = True
          AutoSize = True
          object pCliche: TRLPanel
            Left = 0
            Top = 0
            Width = 286
            Height = 60
            Align = faClient
            AutoExpand = True
            AutoSize = True
            object lEndereco: TRLLabel
              Left = 0
              Top = 43
              Width = 286
              Height = 12
              Align = faTop
              Alignment = taCenter
              Caption = 'Endere'#231'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object lRazaoSocial: TRLLabel
              Left = 0
              Top = 19
              Width = 286
              Height = 12
              Align = faTop
              Alignment = taCenter
              Caption = 'Raz'#195#163'o Social'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
            end
            object lNomeFantasia: TRLLabel
              Left = 0
              Top = 0
              Width = 286
              Height = 19
              Align = faTop
              Alignment = taCenter
              Caption = 'Nome Fantasia'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Layout = tlCenter
              ParentFont = False
            end
            object lEmitCNPJ_IE_IM: TRLLabel
              Left = 0
              Top = 31
              Width = 286
              Height = 12
              Align = faTop
              Alignment = taCenter
              Caption = 
                'CNPJ: 22.222.222/22222-22  IE:223.233.344.233 IM:2323.222.333.23' +
                '3'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -9
              Font.Name = 'Arial'
              Font.Style = []
              Layout = tlBottom
              ParentFont = False
            end
            object RLDraw1: TRLDraw
              Left = 0
              Top = 52
              Width = 286
              Height = 8
              Align = faBottom
              DrawKind = dkLine
              Pen.Style = psDot
            end
            object imgLogo: TRLImage
              Left = 0
              Top = 0
              Width = 1
              Height = 1
              AutoSize = True
              Transparent = False
            end
          end
        end
      end
      object rlbLegenda: TRLBand
        Left = 0
        Top = 102
        Width = 286
        Height = 28
        AutoSize = True
        BeforePrint = rlbLegendaBeforePrint
        object RLDraw4: TRLDraw
          Left = 0
          Top = 0
          Width = 286
          Height = 8
          Align = faTop
          DrawKind = dkLine
          Pen.Style = psDot
        end
        object lCPF_CNPJ1: TRLLabel
          Left = 0
          Top = 8
          Width = 286
          Height = 12
          Align = faTop
          Alignment = taCenter
          Caption = '#|COD|DESC|QTD|UN| VL UN R$|(VLTR R$)*| VL ITEM R$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Layout = tlBottom
          ParentFont = False
        end
        object RLDraw5: TRLDraw
          Left = 0
          Top = 20
          Width = 286
          Height = 8
          Align = faTop
          DrawKind = dkLine
          Pen.Style = psDot
        end
      end
    end
    object rlbConsumidor: TRLBand
      Left = 8
      Top = 387
      Width = 286
      Height = 55
      AutoSize = True
      BandType = btSummary
      InsideMargins.LeftMargin = 2.000000000000000000
      InsideMargins.RightMargin = 2.000000000000000000
      BeforePrint = rlbConsumidorBeforePrint
      object RLDraw10: TRLDraw
        Left = 8
        Top = 0
        Width = 270
        Height = 8
        Align = faTop
        DrawKind = dkLine
        Pen.Style = psDot
      end
      object lTitConsumidor: TRLLabel
        Left = 8
        Top = 8
        Width = 270
        Height = 11
        Align = faTop
        Alignment = taCenter
        Caption = 'CONSUMIDOR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lEnderecoConsumidor: TRLMemo
        Left = 8
        Top = 43
        Width = 270
        Height = 12
        Align = faTop
        Alignment = taCenter
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          'Endere'#231'o Consumidor (Logradouro, n'#186', bairro, Munic'#237#173'pio)')
        ParentFont = False
      end
      object lCPF_CNPJ_ID: TRLMemo
        Left = 8
        Top = 19
        Width = 270
        Height = 24
        Align = faTop
        Alignment = taCenter
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          
            'CNPJ/CPF/ID Estrangeiro - CCCCCCCCCCCCCCCCCCCC NOME DO CONSUMIDO' +
            'R')
        ParentFont = False
      end
    end
    object rlbMensagemFiscal: TRLBand
      Left = 8
      Top = 321
      Width = 286
      Height = 66
      AutoSize = True
      BandType = btSummary
      InsideMargins.LeftMargin = 2.000000000000000000
      InsideMargins.RightMargin = 2.000000000000000000
      BeforePrint = rlbMensagemFiscalBeforePrint
      object RLDraw12: TRLDraw
        Left = 8
        Top = 0
        Width = 270
        Height = 8
        Align = faTop
        DrawKind = dkLine
        Pen.Style = psDot
      end
      object lMensagemFiscal: TRLLabel
        Left = 8
        Top = 8
        Width = 270
        Height = 10
        Align = faTop
        Alignment = taCenter
        Caption = #195#129'REA DE MENSAGEM FISCAL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -8
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lChaveDeAcesso: TRLLabel
        Left = 8
        Top = 54
        Width = 270
        Height = 12
        Align = faTop
        Alignment = taCenter
        Caption = '9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lTitChaveAcesso: TRLLabel
        Left = 8
        Top = 42
        Width = 270
        Height = 12
        Align = faTop
        Alignment = taCenter
        Caption = 'CHAVE DE ACESSO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lNumSerieEmissao: TRLLabel
        Left = 8
        Top = 18
        Width = 270
        Height = 12
        Align = faTop
        Alignment = taCenter
        Caption = 
          'N'#250'mero 999999999 S'#233'rie 999 Emiss'#227'o DD/MM/AAAA HH:MM:SS - Via Est' +
          'abelecimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lTitConsulteChave: TRLMemo
        Left = 8
        Top = 30
        Width = 270
        Height = 12
        Align = faTop
        Alignment = taCenter
        Behavior = [beSiteExpander]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          'Consulte pela Chave de Acesso em www.')
        ParentFont = False
      end
    end
  end
  object RLHTMLFilter1: TRLHTMLFilter
    DocumentStyle = dsCSS2
    DisplayName = 'HTML'
    Left = 320
    Top = 88
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport (Open Source) v3.24(B14)  \251 Copyright '#194#169' 1999-20' +
      '08 Fortes Inform'#195#161'tica'
    DisplayName = 'PDF'
    Left = 328
    Top = 24
  end
end
