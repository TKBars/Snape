unit MainUn;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  DBGrids, StdCtrls, Buttons, Menus, ExtCtrls, ConnectUnit, metaunit, UnitTable;

type

  { TMainForm }

  TMainForm = class(TForm)
    FunImg: TImage;
    MainMenu: TMainMenu;
    MAbout: TMenuItem;
    Reference: TMenuItem;
    procedure MAboutClick(Sender: TObject);
    //procedure OpenTable(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MExitClick(Sender: TObject);
    procedure MenuItemClick(Sender: TObject);
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

procedure TMainForm.FormCreate(Sender: TObject);
var
  i: integer;
  newitem: TMenuItem;
begin
  for i := 0 to High(ATables) do begin
    newitem := TMenuItem.Create(nil);
    with newitem do begin
      Caption := ATables[i].Caption;
      Name := ATables[i].Name;
      Tag := i;
      OnClick := @Self.MenuItemClick;
    end;
    Reference.Add(newitem);
  end;
end;

procedure TMainForm.MAboutClick(Sender: TObject);
begin
  ShowMessage('Карандаев Т.А.');
end;

procedure TMainForm.MenuItemClick(Sender: TObject);
begin
  MakeForm((Sender as TMenuItem).tag);
end;

procedure TMainForm.MExitClick(Sender: TObject);
begin
  Close;
end;

end.

