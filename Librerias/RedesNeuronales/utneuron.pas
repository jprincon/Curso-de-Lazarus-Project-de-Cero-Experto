unit uTNeuron;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uTNumberList, uTProductPoint, uTActivactionFunction,
  uTCustomObjectLog, uTMatrix, Math, TAseries, Graphics, Forms;

type

  { TNeuron }

  TNeuron = class(TCustomObjectLog)
  private
    FActivactionFunction: TActivactionFunction;
    FerrorGraph: TLineSeries;
    FInputs: TNumberList;
    FNetOutflow: real;
    Fpolarization: real;
    FSamples: TMatrix;
    FWeights: TNumberList;
    FProductPoint: TProductPoint;
    procedure SetActivactionFunction(AValue: TActivactionFunction);
    procedure SeterrorGraph(AValue: TLineSeries);
    procedure SetInputs(AValue: TNumberList);
    procedure SetNetOutflow(AValue: real);
    procedure Setpolarization(AValue: real);
    procedure SetSamples(AValue: TMatrix);
    procedure SetWeights(AValue: TNumberList);
  public
    constructor Create;
    destructor Destroy; override;

    procedure update;

    procedure train(epochs: integer; ratio: real);

    function propagation: real;
    function getPropagationData: string;
  published
    property Inputs: TNumberList read FInputs write SetInputs;
    property Weights: TNumberList read FWeights write SetWeights;
    property polarization: real read Fpolarization write Setpolarization;
    property ActivactionFunction: TActivactionFunction
      read FActivactionFunction write SetActivactionFunction;
    property NetOutflow: real read FNetOutflow write SetNetOutflow;
    property ProductPoint: TProductPoint read FProductPoint;
    property Samples: TMatrix read FSamples write SetSamples;

    property errorGraph: TLineSeries read FerrorGraph write SeterrorGraph;
  end;

implementation

{ TNeuron }

procedure TNeuron.SetInputs(AValue: TNumberList);
begin
  if FInputs = AValue then Exit;
  FInputs := AValue;

  log('Add Inputs = ' + FInputs.getList(','));
end;

procedure TNeuron.SetNetOutflow(AValue: real);
begin
  if FNetOutflow = AValue then Exit;
  FNetOutflow := AValue;
end;

procedure TNeuron.SetActivactionFunction(AValue: TActivactionFunction);
begin
  if FActivactionFunction = AValue then Exit;
  FActivactionFunction := AValue;
end;

procedure TNeuron.SeterrorGraph(AValue: TLineSeries);
begin
  if FerrorGraph = AValue then Exit;
  FerrorGraph := AValue;
end;

procedure TNeuron.Setpolarization(AValue: real);
begin
  if Fpolarization = AValue then Exit;
  Fpolarization := AValue;
end;

procedure TNeuron.SetSamples(AValue: TMatrix);
begin
  if FSamples = AValue then Exit;
  FSamples := AValue;
end;

procedure TNeuron.SetWeights(AValue: TNumberList);
begin
  if FWeights = AValue then Exit;
  FWeights := AValue;

  log('Add Weights = ' + FWeights.getList(','));
end;

constructor TNeuron.Create;
begin
  FInputs := TNumberList.Create;
  FWeights := TNumberList.Create;
  FActivactionFunction := TActivactionFunction.Create;
  FProductPoint := TProductPoint.Create;
  FSamples := TMatrix.Create;
end;

destructor TNeuron.Destroy;
begin
  FInputs.Free;
  FWeights.Free;
  FActivactionFunction.Free;
  FProductPoint.Free;
  FSamples.Free;

  inherited Destroy;
end;

procedure TNeuron.update;
begin
  FWeights.viewOnLog := viewOnLog;
  FWeights.Console := Console;

  FInputs.viewOnLog := viewOnLog;
  FInputs.Console := Console;

  FProductPoint.viewOnLog := viewOnLog;
  FProductPoint.Console := Console;

  FActivactionFunction.viewOnLog := viewOnLog;
  FActivactionFunction.Console := Console;

  FSamples.viewOnLog := viewOnLog;
  FSamples.Console := Console;
end;

procedure TNeuron.train(epochs: integer; ratio: real);
var
  nw, e, i, n: integer;
  output, sum, t, error: real;
begin

  {determine the quantity and synaptic weights}
  nw := FSamples.getRow(0).dimension - 1;
  n := FSamples.rowCount;

  {generate random weights and polarization}
  FWeights.generateRandomList(nw);
  Fpolarization := Random;

  {Process the epochs}
  for e := 1 to epochs do
  begin

    {Process the samples}
    sum := 0;
    for i := 0 to n - 1 do
    begin
      FInputs := FSamples.getRowDiminished(i);
      output := propagation;

      t := FSamples.getValue(nw, i);
      error := t-output;
      sum := sum + power(error, 2);

      FWeights.updateFromFactor(ratio, error, FInputs);
      Fpolarization := Fpolarization +  ratio*error;

      log(Format('output = %f | t = %f | error = %f',
        [output, t, error]));
    end;

    error := sqrt(sum / n);

    log('{ ============================================= }');
    log(Format('Error from epoch = %d is %f', [e, error]));
    log('{ ============================================= }');

    if Assigned(errorGraph) then
      errorGraph.Add(error, '', clred);

    Application.ProcessMessages;
  end;
end;

function TNeuron.propagation: real;
begin
  FNetOutflow := FProductPoint.calculate(FInputs, FWeights) + Fpolarization;
  Result := FActivactionFunction.calculate(FNetOutflow);

  log(getPropagationData);
end;

function TNeuron.getPropagationData: string;
var
  Output: real;
begin
  Output := FActivactionFunction.calculate(FNetOutflow);
  Result := Format('NetOutflow = %f | Output = %f | Polarization = %f',
    [FNetOutflow, Output, Fpolarization]);
end;

end.
