unit ConnectUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, IBConnection, FileUtil;

type

  { TConnection }

  TConnection = class(TDataModule)
    IBConnection: TIBConnection;
    SQLTransaction: TSQLTransaction;
    procedure IBConnectionAfterConnect(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Connection: TConnection;

implementation

{$R *.lfm}

{ TConnection }

procedure TConnection.IBConnectionAfterConnect(Sender: TObject);
begin

end;

end.

