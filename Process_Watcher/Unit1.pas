{
 Автор Зорков Игорь - zorkovigor@mail.ru
}

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, TlHelp32;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    ListView1: TListView;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListView1CustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  NewPIDList, PIDList, NewProcessList, ProcessList: TStringList;
  RefreshFirstTime: Boolean = True;

implementation

{$R *.dfm}

procedure TForm1.Timer1Timer(Sender: TObject);
var
  ProcessCount, i: DWORD;
  pe32: TlHelp32.TProcessEntry32;
  hSnapShot: THandle;
begin
  NewPIDList.Clear;
  NewProcessList.Clear;

  hSnapShot := TlHelp32.CreateToolHelp32SnapShot(TlHelp32.TH32CS_SNAPPROCESS, 4);
  if hSnapShot <> INVALID_HANDLE_VALUE then
  begin
    pe32.dwSize := SizeOf(TlHelp32.ProcessEntry32);
    while TlHelp32.Process32Next(hSnapShot, pe32) = True do
    begin
      NewPIDList.Add(IntToStr(pe32.th32ProcessID));
      NewProcessList.Add(pe32.szExeFile);
    end;
    CloseHandle(hSnapShot);
  end;

  if (NewPIDList.Text <> PIDList.Text) then
  begin

    if NewPIDList.Count > 0 then
    begin
      for i := 0 to NewPIDList.Count - 1 do
      begin
        if PIDList.IndexOf(NewPIDList.Strings[i]) = -1 then
        begin
          if not RefreshFirstTime then
          begin
            with ListView1.Items.Add do
            begin
              Caption := 'Create';
              SubItems.Add(NewProcessList.Strings[i]);
              SubItems.Add(NewPIDList.Strings[i]);
              Data := Pointer(clLime);
            end;
          end;
        end;
      end;
    end;

    if PIDList.Count > 0 then
    begin
      for i := 0 to PIDList.Count - 1 do
      begin
        if NewPIDList.IndexOf(PIDList.Strings[i]) = -1 then
        begin
          with ListView1.Items.Add do
          begin
            Caption := 'Destroy';
            SubItems.Add(ProcessList.Strings[i]);
            SubItems.Add(PIDList.Strings[i]);
            Data := Pointer(clRed);
          end;
        end;
      end;
    end;

  end;

  PIDList.Assign(NewPIDList);
  ProcessList.Assign(NewProcessList);

  RefreshFirstTime := False;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Position:= poDesktopCenter;
  NewPIDList := TStringList.Create;
  PIDList := TStringList.Create;
  NewProcessList := TStringList.Create;
  ProcessList := TStringList.Create;
end;

procedure TForm1.ListView1CustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  Sender.Canvas.Brush.Color := TColor(Item.Data);
end;

end.

