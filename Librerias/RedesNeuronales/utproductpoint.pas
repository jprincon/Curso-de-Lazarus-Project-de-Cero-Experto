unit uTProductPoint;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uTNumberList, uTCustomObjectLog, Dialogs, SynEdit;

type

  { TProductPoint }

  TProductPoint = class(TCustomObjectLog)
  private
    FConsole: TSynEdit;
    FviewOnLog: boolean;
    procedure SetConsole(AValue: TSynEdit);
    procedure SetviewOnLog(AValue: boolean);

  public
    constructor Create;
    destructor Destroy; override;

    function calculate(listA, listB: TNumberList): real;
  published

  end;

implementation

{ TProductPoint }

procedure TProductPoint.SetConsole(AValue: TSynEdit);
begin
  if FConsole = AValue then Exit;
  FConsole := AValue;
end;

procedure TProductPoint.SetviewOnLog(AValue: boolean);
begin
  if FviewOnLog = AValue then Exit;
  FviewOnLog := AValue;
end;

constructor TProductPoint.Create;
begin

end;

destructor TProductPoint.Destroy;
begin
  inherited Destroy;
end;

function TProductPoint.calculate(listA, listB: TNumberList): real;
var
  i: integer;
  operation: real;
begin
  Result := 0;

  if listA.dimension = listB.dimension then
  begin
    for i := 0 to listA.dimension - 1 do
    begin
      operation := listA.get(i) * listB.get(i);
      Result := Result + operation;

      log(Format('%f * %f = %f', [listA.get(i), listB.get(i), operation]));
    end;
  end
  else
  begin
    MessageDlg('Error', 'Number list dimensions are not equal', mtError, [mbYes], 0);
  end;
end;

end.
