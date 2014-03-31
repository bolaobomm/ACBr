object frmDACTeRL: TfrmDACTeRL
  Left = 239
  Height = 312
  Top = 218
  Width = 881
  Caption = 'frmDACTeRL'
  ClientHeight = 312
  ClientWidth = 881
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  LCLVersion = '1.3'
  object RLCTe: TRLReport
    Left = 2
    Height = 1123
    Top = 2
    Width = 794
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Margins.LeftMargin = 7
    Margins.TopMargin = 7
    Margins.RightMargin = 7
    Margins.BottomMargin = 7
    RealBounds.Left = 0
    RealBounds.Top = 0
    RealBounds.Width = 0
    RealBounds.Height = 0
    ShowProgress = False
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 'FortesReport (Open Source) v3.24(B14)  \251 Copyright © 1999-2008 Fortes Informática'
    DocumentInfo.ModDate = 0
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    left = 136
    top = 48
  end
  object Datasource1: TDatasource
    left = 184
    top = 48
  end
end
