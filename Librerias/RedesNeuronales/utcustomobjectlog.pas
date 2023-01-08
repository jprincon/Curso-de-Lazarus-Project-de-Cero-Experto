unit uTCustomObjectLog;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SynEdit;

type

  { TCustomObjectLog }

  TCustomObjectLog = class(TObject)
  private
    FConsole: TSynEdit;
    FviewOnLog: boolean;
    procedure SetConsole(AValue: TSynEdit);
    procedure SetviewOnLog(AValue: boolean);
  public
    constructor Create;
    destructor Destroy; override;

    procedure log(msg: string);
  published
    property viewOnLog: boolean read FviewOnLog write SetviewOnLog;
    property Console: TSynEdit read FConsole write SetConsole;
  end;

implementation

{ TCustomObjectLog }

procedure TCustomObjectLog.SetConsole(AValue: TSynEdit);
begin
  if FConsole = AValue then Exit;
  FConsole := AValue;
end;

procedure TCustomObjectLog.SetviewOnLog(AValue: boolean);
begin
  if FviewOnLog = AValue then Exit;
  FviewOnLog := AValue;
end;

constructor TCustomObjectLog.Create;
begin

end;

destructor TCustomObjectLog.Destroy;
begin
  inherited Destroy;
end;

procedure TCustomObjectLog.log(msg: string);
begin
  if Assigned(FConsole) and FviewOnLog then
    FConsole.Lines.Add(msg);
end;

end.
