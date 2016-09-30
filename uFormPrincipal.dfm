object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Exemplo de Importa'#231#227'o de XML para ClientDataSet'
  ClientHeight = 409
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 457
    Height = 191
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 447
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 191
    Width = 457
    Height = 166
    Align = alTop
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnFromNodes: TButton
    Left = 250
    Top = 365
    Width = 75
    Height = 25
    Caption = 'From Nodes'
    TabOrder = 2
    OnClick = btnFromNodesClick
  end
  object btnAttributes: TButton
    Left = 122
    Top = 365
    Width = 75
    Height = 25
    Caption = 'Attributes'
    TabOrder = 3
    OnClick = btnAttributesClick
  end
  object CDS1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 104
  end
  object DataSource1: TDataSource
    DataSet = CDS1
    Left = 368
    Top = 128
  end
end
