unit uTLayer;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uTNeuron, uTNumberList, uTActivactionFunction,
  uTCustomObjectLog, Contnrs, Dialogs, SynEdit;

type

  { TLayer }

  TLayer = class(TCustomObjectLog)
  private
    FActivactionFunction: TActivactionFunction;
    FConsole: TSynEdit;
    FNeurons: TObjectList;
    FOutputs: TNumberList;
    FInputs: TNumberList;
    FviewOnLog: boolean;
    procedure SetActivactionFunction(AValue: TActivactionFunction);
    procedure SetInputs(AValue: TNumberList);
    procedure SetOutputs(AValue: TNumberList);
    procedure SetActivationFunctionToNeurons;
  public
    constructor Create;
    destructor Destroy; override;

    procedure setInputs(list: string; delim: char);

    function addNeuron: TNeuron;
    function getNeuron(id: integer): TNeuron;
    function neuronCount: integer;
    function propagation: TNumberList;
  published
    property Outputs: TNumberList read FOutputs write SetOutputs;
    property Inputs: TNumberList read FInputs write SetInputs;
    property ActivactionFunction: TActivactionFunction
      read FActivactionFunction write SetActivactionFunction;
  end;

implementation

{ TLayer }

procedure TLayer.SetOutputs(AValue: TNumberList);
begin
  if FOutputs = AValue then Exit;
  FOutputs := AValue;
end;

procedure TLayer.SetActivationFunctionToNeurons;
var
  i: integer;
begin
  if Assigned(FActivactionFunction) then
    for i := 0 to neuronCount - 1 do
      getNeuron(i).ActivactionFunction := FActivactionFunction;
end;

procedure TLayer.SetActivactionFunction(AValue: TActivactionFunction);
begin
  if FActivactionFunction = AValue then Exit;
  FActivactionFunction := AValue;
end;

procedure TLayer.SetInputs(AValue: TNumberList);
var
  i: integer;
begin
  if FInputs = AValue then Exit;
  FInputs := AValue;

  for i := 0 to neuronCount - 1 do
    getNeuron(i).Inputs := FInputs;
end;

constructor TLayer.Create;
begin
  FNeurons := TObjectList.Create(True);

  FInputs := TNumberList.Create;
  FOutputs := TNumberList.Create;
  FActivactionFunction := TActivactionFunction.Create;
end;

destructor TLayer.Destroy;
begin
  FNeurons.Free;
  FInputs.Free;
  FOutputs.Free;
  FActivactionFunction.Free;

  inherited Destroy;
end;

procedure TLayer.setInputs(list: string; delim: char);
var
  i: integer;
begin
  FInputs.Clear;
  FInputs.addList(list, delim);

  for i := 0 to neuronCount - 1 do
    getNeuron(i).Inputs := FInputs;
end;

function TLayer.addNeuron: TNeuron;
var
  Neuron: TNeuron;
begin
  Neuron := TNeuron.Create;
  FNeurons.Add(Neuron);
  Result := Neuron;
end;

function TLayer.getNeuron(id: integer): TNeuron;
begin
  Result := FNeurons.Items[id] as TNeuron;
end;

function TLayer.neuronCount: integer;
begin
  Result := FNeurons.Count;
end;

function TLayer.propagation: TNumberList;
var
  i: integer;
  output: real;
begin
  FOutputs.Clear;
  SetActivationFunctionToNeurons;

  for i := 0 to neuronCount - 1 do
  begin
    output := getNeuron(i).propagation;
    FOutputs.add(output);

    log(getNeuron(i).getPropagationData);
  end;

  Result := FOutputs;
end;

end.
