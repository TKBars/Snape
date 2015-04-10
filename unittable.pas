unit UnitTable;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  DbCtrls, DBGrids, MetaUnit;

type

  { TTableForm }

  TTableForm = class(TForm)
    DataSource: TDataSource;
    DBGrid: TDBGrid;
    DBNavigator: TDBNavigator;
    SQLQuery: TSQLQuery;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    { private declarations }
  public
    { public declarations }
  end;
    procedure MakeForm(FormID: Integer);

var
  AForms: array of TTableForm;

implementation

{$R *.lfm}

procedure MakeForm(FormID: Integer);
begin
   if AForms[FormID] = nil then begin
    Application.CreateForm(TTableForm, AForms[FormID]);
    AForms[FormID].Tag := FormID;
    AForms[FormID].Show;
  end
  else AForms[FormID].ShowOnTop;
end;

procedure TTableForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  AForms[Tag] := nil;
end;

procedure TTableForm.FormActivate(Sender: TObject);
var
  i: integer;
begin
  SQLQuery.Close;
  SQLQuery.SQL.Text := ATables[Tag].GetSQL();
  SQLQuery.Open;

  Caption := ATables[Tag].Caption;
  for i := 0 to High(ATables[Tag].MassOfFields) do
    with DBGrid.Columns.Items[i] do begin
      Title.Caption := ATables[Self.Tag].MassOfFields[i].Caption;
      Width := ATables[Self.Tag].MassOfFields[i].Width;
    end;
end;

initialization

SetLength(AForms, 9);

end.


