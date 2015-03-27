unit MainUn;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, mssqlconn, IBConnection, db, FileUtil, Forms,
  Controls, Graphics, Dialogs, DBGrids, StdCtrls, Buttons, Menus, ExtCtrls,
  ConnectUnit, metaunit, UnitTable;

type

  { TMainForm }

  TMainForm = class(TForm)
    FunImg: TImage;
    MainMenu: TMainMenu;
    MAbout: TMenuItem;
    Reference: TMenuItem;
    procedure MAboutClick(Sender: TObject);
    procedure OpenTable(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MExitClick(Sender: TObject);
  private
    MassOfReference: array of TMenuItem;
    //procedure ErrorMessage();
    { private declarations }
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;
implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.OpenTable(Sender: TObject);
var
  i: integer;
  cmd: string;
  Item: TMenuItem;
begin
  Item := TMenuItem(Sender);
  If AForms[Item.Tag] = nil then begin
    Application.CreateForm(TTableForm, AForms[Item.Tag]);
    With AForms[Item.Tag] do begin
      Caption := Item.Caption;
      Tag := Item.Tag;

      cmd := 'SELECT * FROM ' + ATables[Tag].Name;

      for i := 0 to High(ATables[Tag].MassOfFields) do
        if not (ATables[Tag].MassOfFields[i].FarTable = nil) then
          cmd += ' INNER JOIN ' + ATables[Tag].MassOfFields[i].FarTable.Name
                       + ' ON ' + ATables[Tag].MassOfFields[i].FarTable.Name + '.' + ATables[Tag].MassOfFields[i].FarField
                       +  ' = ' + ATables[Tag].MassOfFields[i].Name;
           ShowMessage(cmd);
      SQLQuery.Close;
      SQLQuery.SQL.Text := cmd;
      SQLQuery.Open;

      for i := 0 to High(ATables[Tag].MassOfFields) do
      With DBGrid.Columns.Items[i] do begin
        Title.Caption := ATables[Item.Tag].MassOfFields[i].Caption;
        Width := ATables[Item.Tag].MassOfFields[i].Width;
      end;
    end;
  end else begin
    AForms[Item.Tag].ShowOnTop;
  end;
end;

procedure TMainForm.MAboutClick(Sender: TObject);
begin
  ShowMessage('Карандаев Т.А.');
end;

procedure TMainForm.FormCreate(Sender: TObject);
var i: integer;
begin
  SetLength(MassOfReference, Length(ATables));
  for i := 0 to High(MassOfReference) do
  begin
    MassOfReference[i] := TMenuItem.Create(Reference);
    MassOfReference[i].Name := ATables[i].Name;
    MassOfReference[i].Caption := ATables[i].Caption;
    MassOfReference[i].Tag := i;
    MassOfReference[i].OnClick := @OpenTable;
  end;
  MainMenu.Items[0].Add(MassOfReference);
end;

procedure TMainForm.MExitClick(Sender: TObject);
begin
  Close;
end;

//procedure TMainForm.ErrorMessage();
//begin
//  MessageDlg('You''re wrong.', mtError, [mbClose], 0);
//end;

  //SQLQuery.SQL.Text := Memo.Lines.Text;

end.

