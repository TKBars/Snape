unit UnitTable;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  DbCtrls, DBGrids;

type

  { TTable }

  TTable = class(TForm)
    DataSource: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid: TDBGrid;
    DBNavigator: TDBNavigator;
    SQLQuery: TSQLQuery;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Table: TTable;
  MassOfForms: array of TTable;

implementation

{$R *.lfm}

inicialization


end.


