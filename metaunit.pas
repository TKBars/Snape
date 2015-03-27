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
    constructor Create(FiCaption, FiName: string; FiWidth: integer;
      FiFieldType: TFieldType; FiFarTable: TMyTable = nil; FiFarField: string = '');
  end;

  TMyTable = class
    Caption, Name: string;
    MassOfFields: array of TMyField;
    constructor Create(TabCaption, TabName: string);
  end;

var
  ATables: array of TMyTable;

implementation

constructor TMyTable.Create(TabCaption, TabName: string);
  begin
     Caption := TabCaption;
     Name := TabName;
  end;

constructor TMyField.Create(FiCaption, FiName: string; FiWidth: integer;
  FiFieldType: TFieldType; FiFarTable: TMyTable = nil; FiFarField: string = '');
  begin
     Caption := FiCaption;
     Name := FiName;
     Width := FiWidth;
     FieldType := FiFieldType;
     FarTable := FiFarTable;
     FarField := FiFarField;
  end;

initialization

  SetLength(ATables, 9);
  ATables[0] := TMyTable.Create('Преподаватели', 'teachers');
  ATables[1] := TMyTable.Create('Предметы', 'courses');
  ATables[2] := TMyTable.Create('Группы', 'groups');
  ATables[3] := TMyTable.Create('Аудитории', 'classrooms');
  ATables[4] := TMyTable.Create('Преподаватели предметов', 'teachers_courses');
  ATables[5] := TMyTable.Create('Предметы группы', 'groups_subjects');
  ATables[6] := TMyTable.Create('Дни недели', 'weekdays');
  ATables[7] := TMyTable.Create('Пары', 'pairs');
  ATables[8] := TMyTable.Create('Расписание', 'lessons');

  with  ATables[0] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('Имя', 'name', 500, FTstring);
    end;

  with  ATables[1] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('Предмет', 'name', 500, FTstring);
    end;

  with  ATables[2] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('Группа', 'name', 500, FTstring);
    end;

  with  ATables[3] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('Аудитория', 'name', 500, FTstring);
    end;

  with  ATables[4] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id учителя', 'teacher_id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('id предмета', 'subject_id', 60, FTinteger);
    end;

  with  ATables[5] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id группы', 'group_id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('id предмета', 'subject_id', 60, FTinteger);
    end;

  with  ATables[6] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('День недели', 'weekdays', 200, FTstring);
    end;

  with  ATables[7] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('Пара', 'num', 60, FTinteger);
    end;

  with  ATables[8] do
    begin
        SetLength(MassOfFields, 6);
        MassOfFields[0] := TMyField.Create('id пары', 'pair_id', 60, FTinteger, ATables[7], 'id');
        MassOfFields[1] := TMyField.Create('id дня', 'weekday_id', 60, FTinteger, ATables[6], 'id');
        MassOfFields[2] := TMyField.Create('id группы', 'group_id', 60, FTinteger, ATables[2], 'id');
        MassOfFields[3] := TMyField.Create('id предмета', 'course_id', 60, FTinteger, ATables[1], 'id');
        MassOfFields[4] := TMyField.Create('id аудитории', 'class_id', 60, FTinteger, ATables[3], 'id');
        MassOfFields[5] := TMyField.Create('id учителя', 'teacher_id', 60, FTinteger, ATables[0], 'id');
    end;
end.
