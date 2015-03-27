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

procedure TTableForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  AForms[Tag] := nil;
end;

initialization

SetLength(AForms, 9);

end.


