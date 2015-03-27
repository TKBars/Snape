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
    DBGrid1: TDBGrid;
    DBGrid: TDBGrid;
    DBNavigator: TDBNavigator;
    SQLQuery: TSQLQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  TableForm: TTableForm;
  AForms: array of TTableForm;

implementation

{$R *.lfm}

procedure TTableForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to High(ATables[Tag].MassOfFields) do
  With DBGrid do begin
    Columns.Add.FieldName := ATables[Tag].MassOfFields[i].Name;
    Columns[i].Title.Caption := ATables[Tag].MassOfFields[i].Caption;
    Columns[i].Width := ATables[Tag].MassOfFields[i].Width;
  end;
end;

procedure TTableForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  AForms[Tag] := nil;
end;

initialization

SetLength(AForms, 9);

end.


