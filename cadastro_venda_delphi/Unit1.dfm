object Form1: TForm1
  Left = 242
  Top = 152
  Anchors = []
  BiDiMode = bdLeftToRight
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 461
  ClientWidth = 855
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object page: TPageControl
    Left = 0
    Top = 0
    Width = 873
    Height = 425
    ActivePage = cadastro
    TabOrder = 0
    object cadastro: TTabSheet
      Caption = 'cadastro'
      DesignSize = (
        865
        397)
      object Label1: TLabel
        Left = 3
        Top = 24
        Width = 33
        Height = 13
        Caption = 'Codigo'
      end
      object Label2: TLabel
        Left = 3
        Top = 80
        Width = 76
        Height = 13
        Caption = 'Nome do cliente'
      end
      object Label3: TLabel
        Left = 3
        Top = 141
        Width = 57
        Height = 13
        Caption = 'Data e hora'
      end
      object Label4: TLabel
        Left = 3
        Top = 200
        Width = 24
        Height = 13
        Caption = 'Valor'
      end
      object Label5: TLabel
        Left = 159
        Top = 3
        Width = 38
        Height = 13
        Caption = 'Produto'
      end
      object Label6: TLabel
        Left = 358
        Top = 3
        Width = 56
        Height = 13
        Caption = 'Quantidade'
      end
      object Label7: TLabel
        Left = 550
        Top = 3
        Width = 63
        Height = 13
        Caption = 'Valor unitario'
      end
      object Label8: TLabel
        Left = 737
        Top = 86
        Width = 47
        Height = 13
        Caption = 'Organizar'
      end
      object EDT_CODIGO: TEdit
        Left = 3
        Top = 43
        Width = 150
        Height = 21
        Enabled = False
        TabOrder = 6
      end
      object EDT_NOME: TEdit
        Left = 3
        Top = 99
        Width = 150
        Height = 21
        TabOrder = 0
      end
      object EDT_DATA: TEdit
        Left = 0
        Top = 160
        Width = 153
        Height = 21
        Enabled = False
        TabOrder = 7
      end
      object EDT_VALOR: TEdit
        Left = 0
        Top = 219
        Width = 153
        Height = 21
        Enabled = False
        TabOrder = 8
      end
      object Button1: TButton
        Left = 737
        Top = 12
        Width = 100
        Height = 25
        Caption = 'Adicionar'
        TabOrder = 4
        OnClick = Button1Click
      end
      object StringGrid1: TStringGrid
        Left = 159
        Top = 43
        Width = 572
        Height = 320
        Anchors = []
        ColCount = 4
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 9
        OnDblClick = StringGrid1DblClick
      end
      object EDT_PRODUTO: TEdit
        Left = 159
        Top = 16
        Width = 171
        Height = 21
        TabOrder = 1
      end
      object EDT_QUANTIDADE: TEdit
        Left = 358
        Top = 16
        Width = 171
        Height = 21
        NumbersOnly = True
        TabOrder = 2
      end
      object EDT_VALOR_UNITARIO: TEdit
        Left = 550
        Top = 16
        Width = 171
        Height = 21
        TabOrder = 3
      end
      object Button3: TButton
        Left = 737
        Top = 105
        Width = 75
        Height = 25
        Caption = 'Produto'
        TabOrder = 5
        OnClick = Button3Click
      end
      object BitBtn2: TBitBtn
        Left = 737
        Top = 369
        Width = 100
        Height = 25
        Caption = 'Finalizar Compra'
        TabOrder = 10
        OnClick = BitBtn2Click
      end
      object Button2: TButton
        Left = 737
        Top = 43
        Width = 100
        Height = 25
        Caption = 'Alterar'
        TabOrder = 11
        OnClick = Button2Click
      end
      object Button4: TButton
        Left = 646
        Top = 369
        Width = 75
        Height = 25
        Caption = 'Cadastrar'
        TabOrder = 12
        OnClick = Button4Click
      end
    end
    object compra: TTabSheet
      Caption = 'Compra'
      ImageIndex = 1
      object StringGrid2: TStringGrid
        Left = 91
        Top = 3
        Width = 702
        Height = 391
        ColCount = 4
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnDblClick = StringGrid2DblClick
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 766
    Top = 431
    Width = 75
    Height = 25
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 1
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 4
    Top = 280
  end
end
