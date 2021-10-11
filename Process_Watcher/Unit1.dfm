object Form1: TForm1
  Left = 256
  Top = 128
  Width = 371
  Height = 449
  Caption = 'Process Watcher'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object ListView1: TListView
    Left = 0
    Top = 0
    Width = 363
    Height = 421
    Align = alClient
    Columns = <
      item
        Caption = 'Action'
        Width = 98
      end
      item
        Caption = 'Process'
        Width = 185
      end
      item
        Alignment = taRightJustify
        Caption = 'PID'
        Width = 49
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnCustomDrawItem = ListView1CustomDrawItem
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 12
    Top = 30
  end
end
