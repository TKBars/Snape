unit MetaUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db;

type
  TMyField = class
    Caption, Name: string;
    Width: integer;
    FieldType: TFieldType;
    constructor Create(Capitosha, Nameosha: string; Widthosha: integer; FieldTypeosha: TFieldType);
  end;

  TMyTable = class
    Caption, Name: string;
    MassOfFields: array of TMyField;
    constructor Create(Capitosha, Nameosha: string);
  end;

var
  ATables: array of TMyTable;

  i, n: integer;

implementation

constructor  TMyTable.Create(Capitosha, Nameosha: string);
  begin
     Caption := Capitosha;
     Name := Nameosha;
  end;

constructor TMyField.Create(Capitosha, Nameosha: string; Widthosha: integer; FieldTypeosha: TFieldType);
  begin
     Caption := Capitosha;
     Name := Nameosha;
     Width := Widthosha;
     FieldType := FieldTypeosha;
  end;

initialization

  SetLength(ATables, 9);
  ATables[0] := TMyTable.Create('Преподаватели', 'teachers');
  with  ATables[0] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('Имя', 'name', 500, FTstring);
    end;

  ATables[1] := TMyTable.Create('Предметы', 'subjects');
  with  ATables[1] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('Предмет', 'name', 500, FTstring);
    end;

  ATables[2] := TMyTable.Create('Группы', 'groups');
  with  ATables[2] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('Группа', 'name', 500, FTstring);
    end;

  ATables[3] := TMyTable.Create('Аудитории', 'classrooms');
  with  ATables[3] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('Аудитория', 'name', 500, FTstring);
    end;

  ATables[4] := TMyTable.Create('Преподаватели предметов', 'teachers_subjects');
  with  ATables[4] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id учителя', 'teacher_id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('id предмета', 'subject_id', 60, FTinteger);
    end;

  ATables[5] := TMyTable.Create('Предметы группы', 'groups_subjects');
  with  ATables[5] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id группы', 'group_id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('id предмета', 'subject_id', 60, FTinteger);
    end;

  ATables[6] := TMyTable.Create('Дни недели', 'weekday');
  with  ATables[6] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('День недели', 'weekday', 200, FTstring);
    end;

  ATables[7] := TMyTable.Create('Пары', 'pair');
  with  ATables[7] do
    begin
        SetLength(MassOfFields, 2);
        MassOfFields[0] := TMyField.Create('id', 'id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('Пара', 'num', 60, FTinteger);
    end;

  ATables[8] := TMyTable.Create('Расписание', 'lessons');
  with  ATables[8] do
    begin
        SetLength(MassOfFields, 6);
        MassOfFields[0] := TMyField.Create('id пары', 'pair_id', 60, FTinteger);
        MassOfFields[1] := TMyField.Create('id дня', 'weekday_id', 60, FTinteger);
        MassOfFields[2] := TMyField.Create('id группы', 'group_id', 60, FTinteger);
        MassOfFields[3] := TMyField.Create('id предмета', 'subject_id', 60, FTinteger);
        MassOfFields[4] := TMyField.Create('id аудитории', 'class_id', 60, FTinteger);
        MassOfFields[5] := TMyField.Create('id учителя', 'teacher_id', 60, FTinteger);
    end;
end.
