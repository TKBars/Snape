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
  private
    { private declarations }
  public
    procedure FormCreate(Sender: TObject);
    { public declarations }
  end;

var
  TableForm: TTableForm;
  AForms: array of TTableForm;

implementation

{$R *.lfm}

procedure TTableForm.FormCreate(Sender: TObject);
begin
  for i := 0 to High(ATables[(Sender as TTableForm).Tag].MassOfFields) do
  With DBGrid do begin
    Columns.Add.FieldName := ATables[(Sender as TTableForm).Tag].MassOfFields[i].Name;
    Columns[i].Title.Caption := ATables[(Sender as TTableForm).Tag].MassOfFields[i].Caption;
    Columns[i].Width := ATables[(Sender as TTableForm).Tag].MassOfFields[i].Width;
  end;
end;

initialization

SetLength(AForms, 9);

end.


