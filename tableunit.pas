unit TableUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  DbCtrls, DBGrids, StdCtrls, MetaUnit;

type

  TFilter = record
    Field : Integer;
    Operation : Integer;
    Constant : String;
  end;

  { TTableForm }

  TTableForm = class(TForm)
    Add: TButton;
    ApplyFilter: TButton;
    DescBox: TCheckBox;
    Clear: TButton;
    FiltConst: TEdit;
    FiltField: TComboBox;
    FiltOperation: TComboBox;
    FiltSort: TComboBox;
    DataSource: TDataSource;
    DBGrid: TDBGrid;
    DBNavigator: TDBNavigator;
    FiltList: TListBox;
    SQLQuery: TSQLQuery;
    function GetFilterExpr(FilterID: integer): string;
    procedure ApplyFilterClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure ShowForm(Sender: TObject);
    procedure AddClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure FilterPartChange(Sender: TObject);
    procedure FiltersListSelectionChange(Sender: TObject; User: boolean);
    procedure UpdateFilter(FilterID: integer);
  public
    AFilters: array of TFilter;
  end;

var
  AForms: array of TTableForm;

procedure MakeForm(FormID: Integer);

implementation

{$R *.lfm}

procedure MakeForm(FormID: Integer);
begin
   if AForms[FormID] = nil then begin
    AForms[FormID] := TTableForm.Create(Application.MainForm);
    AForms[FormID].Tag := FormID;
    AForms[FormID].Show;
  end
  else AForms[FormID].ShowOnTop;
end;

procedure TTableForm.FormActivate(Sender: TObject);
var
  i: integer;
  Query, Str: string;

begin
  Query := ATables[Tag].GetSQL();
  for i := 0 to High(AFilters) do
  begin
    if i = 0 then
      Query += ' Where '
    else
      Query += ' and ';
    Query += GetFilterExpr(i);
  end;

  if FiltSort.ItemIndex > 0 then
  begin
    with ATables[Tag] do
    begin
      if AFields[FiltSort.ItemIndex - 1].FarTable = nil then
        Str := AFields[FiltSort.ItemIndex - 1].Name
      else
      begin
        Str := AFields[FiltSort.ItemIndex - 1].FarTable.Name;
        Str += '.' + AFields[FiltSort.ItemIndex - 1].Name;
      end;
      Query += ' Order By ' + Str;
      if DescBox.Checked then                                    // ghjkl;
        Query += ' Desc';
    end;
  end;

  SQLQuery.Close;
  SQLQuery.SQL.Text := ATables[Tag].GetSQL();
  SQLQuery.Open;

  Caption := ATables[Tag].Caption;
  for i := 0 to High(ATables[Tag].AFields) do
    with DBGrid.Columns.Items[i] do
    begin
      Title.Caption := ATables[Self.Tag].AFields[i].Caption;
      Width := ATables[Self.Tag].AFields[i].Width;
    end;
end;

procedure TTableForm.ApplyFilterClick(Sender: TObject);
begin
  FormActivate(Self);
end;

procedure TTableForm.ShowForm(Sender: TObject);
var
  i: integer;
  FieldName: string;
begin
  Caption := ATables[Tag].Caption;
  FormActivate(Self);
  for i := 0 to High(ATables[Tag].AFields) do
  begin
    FieldName := ATables[Tag].GetFieldName(i);
    FiltField.Items.Add(FieldName);
    FiltSort.Items.Add(FieldName);
  end;
  FiltField.ItemIndex := 0;
  FiltSort.ItemIndex := 0;
end;

procedure TTableForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  AForms[Tag] := nil;
end;

function TTableForm.GetFilterExpr(FilterID: integer): string;
begin
  with AFilters[FilterID] do
    Result := ATables[Tag].GetFieldName(Field) + ' ' +        //
      FiltOperation.Items.Strings[Operation] + ' ' + Constant; //////
end;

procedure TTableForm.UpdateFilter(FilterID: integer);
begin
  with AFilters[FilterID] do
  begin
    Field := FiltField.ItemIndex;
    Operation := FiltOperation.ItemIndex;
    Constant := FiltConst.Text;
    if (ATables[Tag].AFields[Field].FieldType = ftString) then
      Constant := '''' + Constant + '''';
  end;
  FiltList.Items.Strings[FilterID] := GetFilterExpr(FilterID);
end;

procedure TTableForm.AddClick(Sender: TObject);
begin
  SetLength(AFilters, Length(AFilters) + 1);
  FiltList.Items.Add('');
  FiltList.ItemIndex := High(AFilters);
  UpdateFilter(High(AFilters));
end;

procedure TTableForm.ClearClick(Sender: TObject);
begin
  SetLength(AFilters, 0);
  FiltList.Clear();
end;

procedure TTableForm.FilterPartChange(Sender: TObject);
begin
  if Length(AFilters) > 0 then
    UpdateFilter(FiltList.ItemIndex);
end;

procedure TTableForm.FiltersListSelectionChange(Sender: TObject; User: boolean);
begin
  if User then
    with AFilters[FiltList.ItemIndex] do
    begin
      FiltField.ItemIndex := Field;
      FiltOperation.ItemIndex := Operation;
      FiltConst.Text := Constant;
    end;
end;

initialization

SetLength(AForms, 9);

end.


