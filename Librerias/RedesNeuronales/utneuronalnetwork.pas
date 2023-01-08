unit uTNeuronalNetwork;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uTLayer, uTNumberList, uTCustomObjectLog, Contnrs, Dialogs;

type

  { TNeuronalNetwork }

  TNeuronalNetwork = class(TCustomObjectLog)
  private
    FLayers: TObjectList;
    FOutputs: TNumberList;
    procedure SetOutputs(AValue: TNumberList);
  public
    constructor Create;
    destructor Destroy; override;

    procedure setInputs(list: string; delim: char);

    function addLayer: TLayer;
    function propagation: TNumberList;
    function layerCount: integer;
    function getLayer(id: integer): TLayer;
  published
    property Outputs: TNumberList read FOutputs write SetOutputs;
  end;

implementation

{ TNeuronalNetwork }

procedure TNeuronalNetwork.SetOutputs(AValue: TNumberList);
begin
  if FOutputs = AValue then Exit;
  FOutputs := AValue;
end;

constructor TNeuronalNetwork.Create;
begin
  FLayers := TObjectList.Create(True);
  FOutputs := TNumberList.Create;
end;

destructor TNeuronalNetwork.Destroy;
begin
  FLayers.Free;
  FOutputs.Free;
  inherited Destroy;
end;

procedure TNeuronalNetwork.setInputs(list: string; delim: char);
begin
  if layerCount >= 1 then
  begin
    getLayer(0).setInputs(list, delim);
    log('Added Inputs = ' + list);
  end;
end;

function TNeuronalNetwork.addLayer: TLayer;
var
  Layer: TLayer;
begin
  Layer := TLayer.Create;
  FLayers.Add(Layer);
  Result := Layer;

  log('Added Layer');
end;

function TNeuronalNetwork.propagation: TNumberList;
var
  i, n: integer;
begin

  n := layerCount - 1;
  for i := 0 to n do
  begin

    if i <= (n - 1) then
    begin
      getLayer(i + 1).Inputs := getLayer(i).propagation;
      log('Outputs Layer' + IntToStr(i) + ' = ' + getLayer(i + 1).Inputs.getList(','));
    end
    else
    begin
      FOutputs := getLayer(i).propagation;
      log('Outputs Layer' + IntToStr(i) + ' = ' + FOutputs.getList(','));
    end;
  end;

  Result := FOutputs;
end;

function TNeuronalNetwork.layerCount: integer;
begin
  Result := FLayers.Count;
end;

function TNeuronalNetwork.getLayer(id: integer): TLayer;
begin
  Result := FLayers.Items[id] as TLayer;
end;

end.
