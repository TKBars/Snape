program Snape;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, MainUnit, ConnectUnit, TableUnit;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.Title := 'Snape';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TConnection, Connection);
  Application.Run;
end.

