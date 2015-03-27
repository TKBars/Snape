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
    procedure MMenuClick(Sender: TObject);
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
begin
  Application.CreateForm(TTableForm, AForms[(Sender as TMenuItem).tag]);
  With AForms[(Sender as TMenuItem).tag] do begin
    Caption := (Sender as TMenuItem).Caption;
    Tag := (Sender as TMenuItem).tag;
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

procedure TMainForm.MMenuClick(Sender: TObject);
begin

end;


//procedure TMainForm.ErrorMessage();
//begin
//  MessageDlg('You''re wrong.', mtError, [mbClose], 0);
//end;

  //SQLQuery.SQL.Text := Memo.Lines.Text;

end.

