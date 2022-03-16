object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Anagram Helper by Lorenzo Monti'
  ClientHeight = 525
  ClientWidth = 1126
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = Menu
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object panTop: TPanel
    Left = 0
    Top = 0
    Width = 1126
    Height = 150
    Align = alTop
    TabOrder = 0
    DesignSize = (
      1126
      150)
    object Label53: TLabel
      Left = 4
      Top = 7
      Width = 140
      Height = 16
      Caption = 'F&rase da anagrammare:'
      FocusControl = edtSentence
    end
    object edtSentence: TMemo
      Left = 4
      Top = 29
      Width = 1117
      Height = 115
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnChange = edtSentenceChange
    end
  end
  object tabCtrl: TcxTabControl
    Left = 0
    Top = 158
    Width = 1126
    Height = 367
    Align = alClient
    TabOrder = 1
    Properties.AllowTabDragDrop = True
    Properties.CloseButtonMode = cbmEveryTab
    Properties.CustomButtons.Buttons = <>
    Properties.TabIndex = 0
    Properties.Tabs.Strings = (
      '&1.')
    Properties.TabWidth = 180
    LookAndFeel.NativeStyle = False
    OnCanCloseEx = tabCtrlCanCloseEx
    OnChange = tabCtrlChange
    OnNewTabButtonClick = tabCtrlNewTabButtonClick
    OnTabEndDrag = tabCtrlTabEndDrag
    ClientRectBottom = 367
    ClientRectRight = 1126
    ClientRectTop = 27
    object panData: TPanel
      Left = 0
      Top = 27
      Width = 1126
      Height = 126
      Align = alTop
      AutoSize = True
      TabOrder = 0
      object lblVowels: TLabel
        Left = 1
        Top = 1
        Width = 1124
        Height = 22
        Align = alTop
        Caption = '--'
        Font.Charset = ANSI_CHARSET
        Font.Color = clOlive
        Font.Height = -19
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
        ExplicitWidth = 20
      end
      object lblConsonants: TLabel
        Left = 1
        Top = 23
        Width = 1124
        Height = 22
        Align = alTop
        Caption = '--'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
        ExplicitWidth = 20
      end
      object Grid: TGridPanel
        Left = 1
        Top = 45
        Width = 1124
        Height = 80
        Align = alTop
        ColumnCollection = <
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153847000
          end
          item
            Value = 3.846153846153762000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = Label1
            Row = 0
          end
          item
            Column = 1
            Control = Label2
            Row = 0
          end
          item
            Column = 2
            Control = Label3
            Row = 0
          end
          item
            Column = 3
            Control = Label4
            Row = 0
          end
          item
            Column = 4
            Control = Label5
            Row = 0
          end
          item
            Column = 5
            Control = Label6
            Row = 0
          end
          item
            Column = 6
            Control = Label7
            Row = 0
          end
          item
            Column = 7
            Control = Label8
            Row = 0
          end
          item
            Column = 8
            Control = Label9
            Row = 0
          end
          item
            Column = 9
            Control = Label10
            Row = 0
          end
          item
            Column = 10
            Control = Label11
            Row = 0
          end
          item
            Column = 11
            Control = Label12
            Row = 0
          end
          item
            Column = 12
            Control = Label13
            Row = 0
          end
          item
            Column = 13
            Control = Label14
            Row = 0
          end
          item
            Column = 14
            Control = Label15
            Row = 0
          end
          item
            Column = 15
            Control = Label16
            Row = 0
          end
          item
            Column = 16
            Control = Label17
            Row = 0
          end
          item
            Column = 17
            Control = Label18
            Row = 0
          end
          item
            Column = 18
            Control = Label19
            Row = 0
          end
          item
            Column = 19
            Control = Label20
            Row = 0
          end
          item
            Column = 20
            Control = Label21
            Row = 0
          end
          item
            Column = 21
            Control = Label22
            Row = 0
          end
          item
            Column = 22
            Control = Label23
            Row = 0
          end
          item
            Column = 23
            Control = Label24
            Row = 0
          end
          item
            Column = 24
            Control = Label25
            Row = 0
          end
          item
            Column = 25
            Control = Label26
            Row = 0
          end
          item
            Column = 0
            Control = Label27
            Row = 1
          end
          item
            Column = 1
            Control = Label28
            Row = 1
          end
          item
            Column = 2
            Control = Label29
            Row = 1
          end
          item
            Column = 3
            Control = Label30
            Row = 1
          end
          item
            Column = 4
            Control = Label31
            Row = 1
          end
          item
            Column = 5
            Control = Label32
            Row = 1
          end
          item
            Column = 6
            Control = Label33
            Row = 1
          end
          item
            Column = 7
            Control = Label34
            Row = 1
          end
          item
            Column = 8
            Control = Label35
            Row = 1
          end
          item
            Column = 9
            Control = Label36
            Row = 1
          end
          item
            Column = 10
            Control = Label37
            Row = 1
          end
          item
            Column = 11
            Control = Label38
            Row = 1
          end
          item
            Column = 12
            Control = Label39
            Row = 1
          end
          item
            Column = 13
            Control = Label40
            Row = 1
          end
          item
            Column = 14
            Control = Label41
            Row = 1
          end
          item
            Column = 15
            Control = Label42
            Row = 1
          end
          item
            Column = 16
            Control = Label43
            Row = 1
          end
          item
            Column = 17
            Control = Label44
            Row = 1
          end
          item
            Column = 18
            Control = Label45
            Row = 1
          end
          item
            Column = 19
            Control = Label46
            Row = 1
          end
          item
            Column = 20
            Control = Label47
            Row = 1
          end
          item
            Column = 21
            Control = Label48
            Row = 1
          end
          item
            Column = 22
            Control = Label49
            Row = 1
          end
          item
            Column = 23
            Control = Label50
            Row = 1
          end
          item
            Column = 24
            Control = Label51
            Row = 1
          end
          item
            Column = 25
            Control = Label52
            Row = 1
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        RowCollection = <
          item
            Value = 50.000000000000000000
          end
          item
            Value = 50.000000000000000000
          end>
        TabOrder = 0
        DesignSize = (
          1124
          80)
        object Label1: TLabel
          Left = 1
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 5
          ExplicitTop = 28
        end
        object Label2: TLabel
          Left = 44
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 51
          ExplicitTop = 28
        end
        object Label3: TLabel
          Left = 87
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 97
          ExplicitTop = 28
        end
        object Label4: TLabel
          Left = 131
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 143
          ExplicitTop = 28
        end
        object Label5: TLabel
          Left = 174
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 189
          ExplicitTop = 28
        end
        object Label6: TLabel
          Left = 217
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 235
          ExplicitTop = 28
        end
        object Label7: TLabel
          Left = 260
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 281
          ExplicitTop = 28
        end
        object Label8: TLabel
          Left = 303
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 327
          ExplicitTop = 28
        end
        object Label9: TLabel
          Left = 346
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 373
          ExplicitTop = 28
        end
        object Label10: TLabel
          Left = 390
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 419
          ExplicitTop = 28
        end
        object Label11: TLabel
          Left = 433
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 465
          ExplicitTop = 28
        end
        object Label12: TLabel
          Left = 476
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 511
          ExplicitTop = 28
        end
        object Label13: TLabel
          Left = 519
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 557
          ExplicitTop = 28
        end
        object Label14: TLabel
          Left = 562
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 603
          ExplicitTop = 28
        end
        object Label15: TLabel
          Left = 605
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 649
          ExplicitTop = 28
        end
        object Label16: TLabel
          Left = 648
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 695
          ExplicitTop = 28
        end
        object Label17: TLabel
          Left = 692
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 741
          ExplicitTop = 28
        end
        object Label18: TLabel
          Left = 735
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 787
          ExplicitTop = 28
        end
        object Label19: TLabel
          Left = 778
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 833
          ExplicitTop = 28
        end
        object Label20: TLabel
          Left = 821
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 879
          ExplicitTop = 28
        end
        object Label21: TLabel
          Left = 864
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 925
          ExplicitTop = 28
        end
        object Label22: TLabel
          Left = 907
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 971
          ExplicitTop = 28
        end
        object Label23: TLabel
          Left = 951
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 1017
          ExplicitTop = 28
        end
        object Label24: TLabel
          Left = 994
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 1063
          ExplicitTop = 28
        end
        object Label25: TLabel
          Left = 1037
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 1109
          ExplicitTop = 28
        end
        object Label26: TLabel
          Left = 1080
          Top = 13
          Width = 42
          Height = 15
          Anchors = []
          Caption = 'Label1'
          ExplicitLeft = 1157
          ExplicitTop = 28
        end
        object Label27: TLabel
          Left = 1
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 5
          ExplicitTop = 98
        end
        object Label28: TLabel
          Left = 44
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 51
          ExplicitTop = 98
        end
        object Label29: TLabel
          Left = 87
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 97
          ExplicitTop = 98
        end
        object Label30: TLabel
          Left = 131
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 143
          ExplicitTop = 98
        end
        object Label31: TLabel
          Left = 174
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 189
          ExplicitTop = 98
        end
        object Label32: TLabel
          Left = 217
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 235
          ExplicitTop = 98
        end
        object Label33: TLabel
          Left = 260
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 281
          ExplicitTop = 98
        end
        object Label34: TLabel
          Left = 303
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 327
          ExplicitTop = 98
        end
        object Label35: TLabel
          Left = 346
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 373
          ExplicitTop = 98
        end
        object Label36: TLabel
          Left = 390
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 419
          ExplicitTop = 98
        end
        object Label37: TLabel
          Left = 433
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 465
          ExplicitTop = 98
        end
        object Label38: TLabel
          Left = 476
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 511
          ExplicitTop = 98
        end
        object Label39: TLabel
          Left = 519
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 557
          ExplicitTop = 98
        end
        object Label40: TLabel
          Left = 562
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 603
          ExplicitTop = 98
        end
        object Label41: TLabel
          Left = 605
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 649
          ExplicitTop = 98
        end
        object Label42: TLabel
          Left = 648
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 695
          ExplicitTop = 98
        end
        object Label43: TLabel
          Left = 692
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 741
          ExplicitTop = 98
        end
        object Label44: TLabel
          Left = 735
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 787
          ExplicitTop = 98
        end
        object Label45: TLabel
          Left = 778
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 833
          ExplicitTop = 98
        end
        object Label46: TLabel
          Left = 821
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 879
          ExplicitTop = 98
        end
        object Label47: TLabel
          Left = 864
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 925
          ExplicitTop = 98
        end
        object Label48: TLabel
          Left = 907
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 971
          ExplicitTop = 98
        end
        object Label49: TLabel
          Left = 951
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 1017
          ExplicitTop = 98
        end
        object Label50: TLabel
          Left = 994
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 1063
          ExplicitTop = 98
        end
        object Label51: TLabel
          Left = 1037
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 1109
          ExplicitTop = 98
        end
        object Label52: TLabel
          Left = 1080
          Top = 52
          Width = 42
          Height = 15
          Cursor = crHandPoint
          Anchors = []
          Caption = 'Label1'
          OnMouseDown = LabelsMouseDown
          OnMouseUp = LabelsMouseUp
          OnMouseEnter = LabelsMouseEnter
          OnMouseLeave = LabelsMouseLeave
          ExplicitLeft = 1157
          ExplicitTop = 98
        end
      end
    end
    object panBottom: TPanel
      Left = 0
      Top = 153
      Width = 1126
      Height = 214
      Align = alClient
      TabOrder = 1
      DesignSize = (
        1126
        214)
      object Label54: TLabel
        Left = 4
        Top = 10
        Width = 75
        Height = 16
        Caption = '&Anagramma:'
        FocusControl = edtAnagram
      end
      object edtAnagram: TJvRichEdit
        Left = 4
        Top = 32
        Width = 1117
        Height = 174
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        SelText = ''
        TabOrder = 1
        OnChange = edtAnagramChange
        OnKeyPress = edtAnagramKeyPress
        OnProtectChangeEx = edtAnagramProtectChangeEx
      end
      object chkAllowExcess: TCheckBox
        Left = 856
        Top = 9
        Width = 265
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'C&onsenti l'#39'inserimento di lettere in eccesso'
        TabOrder = 0
      end
    end
  end
  object split: TcxSplitter
    Left = 0
    Top = 150
    Width = 1126
    Height = 8
    Cursor = crVSplit
    AlignSplitter = salTop
    ResizeUpdate = True
  end
  object Menu: TMainMenu
    Left = 904
    Top = 177
    object mnuFile: TMenuItem
      Caption = '&File'
      object mnuNew: TMenuItem
        Caption = '&Nuovo'
        ShortCut = 16462
        OnClick = mnuNewClick
      end
      object mnuOpen: TMenuItem
        Caption = 'A&pri'
        ShortCut = 16464
        OnClick = mnuOpenClick
      end
      object mnuSave: TMenuItem
        Caption = '&Salva'
        ShortCut = 16467
        OnClick = mnuSaveClick
      end
      object mnuSaveas: TMenuItem
        Caption = 'Salva con n&ome...'
        ShortCut = 16463
        OnClick = mnuSaveasClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mnuOptions: TMenuItem
        Caption = 'Op&zioni'
        ShortCut = 121
        OnClick = mnuOptionsClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mnuInfo: TMenuItem
        Caption = '&Informazioni...'
        OnClick = mnuInfoClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object mnuClose: TMenuItem
        Caption = 'Es&ci'
        OnClick = mnuCloseClick
      end
    end
    object mnuUtilities: TMenuItem
      Caption = 'U&tilit'#224
      object mnuShuffle: TMenuItem
        Caption = '&Rimescola le lettere residue'
        ShortCut = 16466
        OnClick = mnuShuffleClick
      end
      object mnuSort: TMenuItem
        Caption = '&Ordina alfabeticamente le lettere residue'
        ShortCut = 16454
        OnClick = mnuSortClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object mnuAddAssociation: TMenuItem
        Caption = 'A&ssocia questo programma con i file *.anf'
        OnClick = mnuAddAssociationClick
      end
      object mnuDeleteAssociation: TMenuItem
        Caption = 'E&limina l'#39'associazione con i file *.anf'
        OnClick = mnuDeleteAssociationClick
      end
    end
  end
  object OpenDlg: TOpenDialog
    Filter = 'File anagramma (*.anf)|*.anf'
    Left = 976
    Top = 177
  end
  object SaveDlg: TSaveDialog
    DefaultExt = 'anf'
    Filter = 'File anagramma (*.anf)|*.anf'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 1048
    Top = 177
  end
  object Tim: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TimTimer
    Left = 848
    Top = 177
  end
end
