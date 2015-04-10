unit MetaUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db;

type

  TMyTable = class;

  TMyField = class
    Caption, Name: string;
    Width: integer;
    FieldType: TFieldType;
    FarTable: TMyTable;
    FarField: string;
    FarKey: string;
    constructor Create(FiCaption, FiName: string; FiWidth: integer;
      FiFieldType: TFieldType; FiFarTable: TMyTable = nil; FiFarField: string = ''; FiFarKey: string = '');
  end;

  { TMyTable }

  TMyTable = class
    Caption, Name: string;
    MassOfFields: array of TMyField;
    constructor Create(TabCaption, TabName: string);
    function AddField(TabCaption, TabName: string; TabWidth: integer;
      FiFieldType: TFieldType; FiFarTable: TMyTable = nil; FiFarField: string = ''; FiJoinKey: string = ''): TMyField;
    function GetSQL(): string;
    function GetField: string;
  end;

var
  ATables: array of TMyTable;

implementation

constructor TMyTable.Create(TabCaption, TabName: string);
  begin
     Caption := TabCaption;
     Name := TabName;
  end;

function TMyTable.AddField(TabCaption, TabName: string; TabWidth: integer;
  FiFieldType: TFieldType; FiFarTable: TMyTable = nil; FiFarField: string = ''; FiJoinKey: string = ''): TMyField;
begin
  SetLength(MassOfFields, Length(MassOfFields)+1);
  MassOfFields[High(MassOfFields)] := TMyField.Create(TabCaption, TabName, TabWidth, FiFieldType, FiFarTable, FiFarField, FiJoinKey);
  Result := MassOfFields[High(MassOfFields)];
end;

function TMyTable.GetSQL: string;
  var
  i: integer;
begin
  Result := 'Select ';
  for i := 0 to High(MassOfFields) do begin
    if i > 0 then Result += ', ';
    if MassOfFields[i].FarTable = nil then
      Result += Name
    else
      Result += MassOfFields[i].FarTable.Name;
    Result += '.' + MassOfFields[i].Name;
  end;
  Result += ' from ' + Name;
  for i := 0 to High(MassOfFields) do begin
    if MassOfFields[i].FarTable <> nil then
      Result += ' inner join ' + MassOfFields[i].FarTable.Name
      + ' on ' + Name + '.' + MassOfFields[i].FarField
      + ' = ' + MassOfFields[i].FarTable.Name + '.' + MassOfFields[i].FarKey;
  end;
end;

function TMyTable.GetField: string;
var
i: integer;
begin
  for i := 0 to High(MassOfFields) do
  begin
    if MassOfFields[i].FarTable = nil then
    Result += Name
  else
    Result += MassOfFields[i].FarTable.Name;
  end;
end;

constructor TMyField.Create(FiCaption, FiName: string; FiWidth: integer;
  FiFieldType: TFieldType; FiFarTable: TMyTable = nil; FiFarField: string = ''; FiFarKey: string = '');
  begin
     Caption := FiCaption;
     Name := FiName;
     Width := FiWidth;
     FieldType := FiFieldType;
     FarTable := FiFarTable;
     FarField := FiFarField;
     FarKey := FiFarKey;
  end;

initialization

  SetLength(ATables, 9);
  ATables[0] := TMyTable.Create('Учителя', 'teachers');
  ATables[1] := TMyTable.Create('Предметы', 'courses');
  ATables[2] := TMyTable.Create('Группы', 'groups');
  ATables[3] := TMyTable.Create('Аудитории', 'classrooms');
  ATables[4] := TMyTable.Create('Преподаватели предметов', 'teachers_courses');
  ATables[5] := TMyTable.Create('Предметы группы', 'groups_courses');
  ATables[6] := TMyTable.Create('Дни недели', 'weekdays');
  ATables[7] := TMyTable.Create('Пары', 'pairs');
  ATables[8] := TMyTable.Create('Расписание', 'lessons');

  with ATables[0] do begin
  AddField('id', 'ID', 25, ftString);
  AddField('Учитель', 'NAME', 185, ftString);
end;
with ATables[1] do begin
  AddField('id', 'ID', 25, ftString);
  AddField('Предмет', 'NAME', 185, ftString);
end;
with ATables[2] do begin
  AddField('id', 'ID', 25, ftInteger);
  AddField('Группа', 'NAME', 70, ftString);
end;
with ATables[3] do begin
  AddField('id', 'ID', 25, ftInteger);
  AddField('Аудитория', 'CLASSROOM', 70, ftString);
end;
with ATables[4] do begin
  AddField('id Учителя', 'TEACHER_ID', 65, ftInteger);
  AddField('id Предмета', 'COURSE_ID', 75, ftInteger);
end;
with ATables[5] do begin
  AddField('id Группы', 'GROUP_ID', 60, ftInteger);
  AddField('id Предмета', 'COURSE_ID', 75, ftInteger);
end;
with ATables[6] do begin
  AddField('id', 'ID', 25, ftInteger);
  AddField('День недели', 'WEEKDAY', 80, ftString);
end;
with ATables[7] do begin
  AddField('id', 'ID', 25, ftInteger);
  AddField('Время', 'PERIOD', 80, ftString);
end;
with ATables[8] do begin
  AddField('Время', 'PERIOD', 50, ftInteger, ATables[7], 'PAIR_ID', 'ID');
  AddField('День недели', 'WEEKDAY', 85, ftInteger, ATables[6], 'WEEKDAY_ID', 'ID');
  AddField('Группа', 'NAME', 60, ftInteger, ATables[2], 'GROUP_ID', 'ID');
  AddField('Предмет', 'NAME', 75, ftInteger, ATables[1], 'COURSE_ID', 'ID');
  AddField('Аудитория', 'CLASSROOM', 80, ftInteger, ATables[3], 'CLASS_ID', 'ID');
  AddField('Учитель', 'NAME', 65, ftInteger, ATables[0], 'TEACHER_ID', 'ID');
end;

//
//  with  ATables[0] do
//    begin
//        SetLength(MassOfFields, 2);
//        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
//        MassOfFields[1] := TMyField.Create('Имя', 'name', 500, FTstring);
//    end;
//
//  with  ATables[1] do
//    begin
//        SetLength(MassOfFields, 2);
//        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
//        MassOfFields[1] := TMyField.Create('Предмет', 'name', 500, FTstring);
//    end;
//
//  with  ATables[2] do
//    begin
//        SetLength(MassOfFields, 2);
//        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
//        MassOfFields[1] := TMyField.Create('Группа', 'name', 500, FTstring);
//    end;
//
//  with  ATables[3] do
//    begin
//        SetLength(MassOfFields, 2);
//        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
//        MassOfFields[1] := TMyField.Create('Аудитория', 'name', 500, FTstring);
//    end;
//
//  with  ATables[4] do
//    begin
//        SetLength(MassOfFields, 2);
//        MassOfFields[0] := TMyField.Create('id учителя', 'teacher_id', 60, FTinteger);
//        MassOfFields[1] := TMyField.Create('id предмета', 'subject_id', 60, FTinteger);
//    end;
//
//  with  ATables[5] do
//    begin
//        SetLength(MassOfFields, 2);
//        MassOfFields[0] := TMyField.Create('id группы', 'group_id', 60, FTinteger);
//        MassOfFields[1] := TMyField.Create('id предмета', 'subject_id', 60, FTinteger);
//    end;
//
//  with  ATables[6] do
//    begin
//        SetLength(MassOfFields, 2);
//        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
//        MassOfFields[1] := TMyField.Create('День недели', 'weekdays', 200, FTstring);
//    end;
//
//  with  ATables[7] do
//    begin
//        SetLength(MassOfFields, 2);
//        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
//        MassOfFields[1] := TMyField.Create('Пара', 'num', 60, FTinteger);
//    end;
//with  ATables[8] do
//  begin
//      SetLength(MassOfFields, 6);
//      MassOfFields[0] := TMyField.Create('id пары', 'pair_id', 60, FTinteger, ATables[7], 'id');
//      MassOfFields[1] := TMyField.Create('id дня', 'weekday_id', 60, FTinteger, ATables[6], 'id');
//      MassOfFields[2] := TMyField.Create('id группы', 'group_id', 60, FTinteger, ATables[2], 'id');
//      MassOfFields[3] := TMyField.Create('id предмета', 'course_id', 60, FTinteger, ATables[1], 'id');
//      MassOfFields[4] := TMyField.Create('id аудитории', 'class_id', 60, FTinteger, ATables[3], 'id');
//      MassOfFields[5] := TMyField.Create('id учителя', 'teacher_id', 60, FTinteger, ATables[0], 'id');
//  end;


end.
