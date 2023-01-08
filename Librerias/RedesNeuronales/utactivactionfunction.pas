unit uTActivactionFunction;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Math, TASeries, Graphics, uTCustomObjectLog;

type

  { TActivactionFunction }

  TTypeActivationFuncton = (tafStep, tafSimetricalStep, tafReLU, tafSimetricalReLU,
    tafSigmoide, tafTanH, tafArcTan, tafLinear);

  TActivactionFunction = class(TCustomObjectLog)
  private
    FGraphActivationFunction: TLineSeries;
    FTypeActivactionFunction: TTypeActivationFuncton;
    procedure SetGraphActivationFunction(AValue: TLineSeries);
    procedure SetTypeActivactionFunction(AValue: TTypeActivationFuncton);

    function calculateFunctionStep(x: real): real;
    function calculateFunctionSimetricalStep(x: real): real;
    function calculateFunctionReLU(x: real): real;
    function calculateFunctionSimetricalReLU(x: real): real;
    function calculateFunctionSigmoide(x: real): real;
    function calculateFunctionTanH(x: real): real;
    function calculateFunctionArcTan(x: real): real;
    function calculateFunctionLinear(x: real): real;
  public
    constructor Create;
    destructor Destroy; override;

    procedure graph(limInf, limSup, dx: real);

    function calculate(x: real): real;
  published
    property TypeActivactionFunction: TTypeActivationFuncton
      read FTypeActivactionFunction write SetTypeActivactionFunction;

    property GraphActivationFunction: TLineSeries
      read FGraphActivationFunction write SetGraphActivationFunction;
  end;

implementation

{ TActivactionFunction }

procedure TActivactionFunction.SetTypeActivactionFunction(
  AValue: TTypeActivationFuncton);
begin
  if FTypeActivactionFunction = AValue then Exit;
  FTypeActivactionFunction := AValue;
end;

procedure TActivactionFunction.SetGraphActivationFunction(AValue: TLineSeries);
begin
  if FGraphActivationFunction = AValue then Exit;
  FGraphActivationFunction := AValue;
end;

function TActivactionFunction.calculateFunctionStep(x: real): real;
begin
  if x < 0 then Result := 0
  else
    Result := 1;
end;

function TActivactionFunction.calculateFunctionSimetricalStep(x: real): real;
begin
  if x < 0 then Result := -1
  else
    Result := 1;
end;

function TActivactionFunction.calculateFunctionReLU(x: real): real;
begin
  if x < 0 then Result := 0
  else if (x >= 0) and (x < 1) then Result := x
  else
    Result := 1;
end;

function TActivactionFunction.calculateFunctionSimetricalReLU(x: real): real;
begin
  if x < -1 then Result := -1
  else if (x >= -1) and (x < 1) then Result := x
  else
    Result := 1;
end;

function TActivactionFunction.calculateFunctionSigmoide(x: real): real;
begin
  Result := 1 / (1 + exp(-x));
end;

function TActivactionFunction.calculateFunctionTanH(x: real): real;
begin
  Result := TanH(x);
end;

function TActivactionFunction.calculateFunctionArcTan(x: real): real;
begin
  Result := ArcTan(x);
end;

function TActivactionFunction.calculateFunctionLinear(x: real): real;
begin
  Result := x;
end;

constructor TActivactionFunction.Create;
begin

end;

destructor TActivactionFunction.Destroy;
begin
  inherited Destroy;
end;

procedure TActivactionFunction.graph(limInf, limSup, dx: real);
var
  x, y: real;
begin
  case FTypeActivactionFunction of
    tafStep: log('=== calculateFunctionStep ===');
    tafSimetricalStep: log('=== calculateFunctionSimetricalStep ===');
    tafReLU: log('=== calculateFunctionReLU ===');
    tafSimetricalReLU: log('=== calculateFunctionSimetricalReLU ===');
    tafSigmoide: log('=== calculateFunctionSigmoide ===');
    tafTanH: log('=== calculateFunctionTanH ===');
    tafArcTan: log('=== calculateFunctionArcTan ===');
    tafLinear: log('=== calculateFunctionLinear ===');
  end;

  if Assigned(FGraphActivationFunction) then
  begin
    FGraphActivationFunction.Clear;
    x := limInf;
    while x <= limSup do
    begin
      y := calculate(x);
      FGraphActivationFunction.AddXY(x, y, '', clRed);

      x := x + dx;

      log(Format('x = %f, y = %f', [x, y]));
    end;
    log('');
  end;
end;

function TActivactionFunction.calculate(x: real): real;
begin
  case FTypeActivactionFunction of
    tafStep: Result := calculateFunctionStep(x);
    tafSimetricalStep: Result := calculateFunctionSimetricalStep(x);
    tafReLU: Result := calculateFunctionReLU(x);
    tafSimetricalReLU: Result := calculateFunctionSimetricalReLU(x);
    tafSigmoide: Result := calculateFunctionSigmoide(x);
    tafTanH: Result := calculateFunctionTanH(x);
    tafArcTan: Result := calculateFunctionArcTan(x);
    tafLinear: Result := calculateFunctionLinear(x);
  end;
end;

end.
