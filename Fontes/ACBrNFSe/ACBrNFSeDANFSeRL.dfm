object frlDANFSeRL: TfrlDANFSeRL
  Left = 280
  Height = 537
  Top = 152
  Width = 850
  Caption = 'frlDANFSeRL'
  ClientHeight = 537
  ClientWidth = 850
  Color = clBtnFace
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  LCLVersion = '1.1'
  object RLNFSe: TRLReport
    Left = -4
    Height = 1123
    Top = -2
    Width = 794
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    PreviewOptions.ShowModal = True
    PreviewOptions.Caption = 'DANFe'
    RealBounds.Left = 0
    RealBounds.Top = 0
    RealBounds.Width = 0
    RealBounds.Height = 0
    ShowProgress = False
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Author = 'FortesReport 3.23 - Copyright © 1999-2009 Fortes Informática'
    DocumentInfo.Creator = 'Projeto ACBr (Componente NFS-e)'
    DocumentInfo.ModDate = 0
    ViewerOptions = []
    FontEncoding = feNoEncoding
    DisplayName = 'Documento PDF'
    left = 368
    top = 152
  end
  object dsItens: TDatasource
    left = 437
    top = 167
  end
end
