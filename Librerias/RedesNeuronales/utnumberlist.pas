unit uTNumberList;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SynEdit, uTCustomObjectLog;

type

  { TNumberList }

  TNumberList = class(TCustomObjectLog)
  private
    FNumberList: TStringList;
  public
    constructor Create;
    destructor Destroy; override;

    procedure add(number: real);
    procedure replace(id: integer; newValue: real);
    procedure addList(list: string; delim: char);
    procedure saveToFile(nameFile: string);
    procedure Clear;
    procedure viewListOnLog;
    procedure generateRandomList(n: integer);
    procedure updateFromFactor(ratio, error: real; inputs: TNumberList);

    function getList: string;
    function getList(delim: char): string;
    function dimension: integer;
    function get(id: integer): real;
  published
  end;

implementation

{ TNumberList }

constructor TNumberList.Create;
begin
  FNumberList := TStringList.Create;
end;

destructor TNumberList.Destroy;
begin
  FNumberList.Free;
  inherited Destroy;
end;

procedure TNumberList.add(number: real);
var
  fs: TFormatSettings;
begin
  fs.DecimalSeparator := '.';
  FNumberList.Add(FloatToStr(number, fs));

  log(Format('Add Number = %f', [number]));
end;

procedure TNumberList.replace(id: integer; newValue: real);
var
  fs: TFormatSettings;
begin
  fs.DecimalSeparator := '.';
  FNumberList[id] := FloatToStr(newValue, fs);
end;

procedure TNumberList.addList(list: string; delim: char);
var
  FList: TStringList;
begin
  FList := TStringList.Create;
  FList.Delimiter := delim;
  FList.DelimitedText := list;

  FNumberList.AddStrings(FList);

  log('Add List = ' + list);
end;

procedure TNumberList.saveToFile(nameFile: string);
begin
  FNumberList.SaveToFile(nameFile);
end;

procedure TNumberList.Clear;
begin
  FNumberList.Clear;
end;

procedure TNumberList.viewListOnLog;
begin
  log(getList(','));
end;

procedure TNumberList.generateRandomList(n: integer);
var
  i: integer;
begin
  Randomize;

  FNumberList.Clear;
  for i := 1 to n do
    add(Random);
end;

procedure TNumberList.updateFromFactor(ratio, error: real; inputs: TNumberList);
var
  i: integer;
  number: real;
begin
  for i := 0 to dimension - 1 do
  begin
    number := get(i) + ratio * inputs.get(i) * error;
    replace(i, number);
  end;
end;

function TNumberList.getList: string;
begin
  Result := FNumberList.CommaText;
end;

function TNumberList.getList(delim: char): string;
var
  i: integer;
begin
  Result := '';

  if dimension >= 2 then
  begin
    for i := 0 to dimension - 2 do
      Result := Result + FNumberList[i] + delim;

    Result := Result + FNumberList[i + 1];
  end
  else
    Result := FNumberList[0];
end;

function TNumberList.dimension: integer;
begin
  Result := FNumberList.Count;
end;

function TNumberList.get(id: integer): real;
var
  fs: TFormatSettings;
begin
  fs.DecimalSeparator := '.';
  Result := StrToFloat(FNumberList[id], fs);
end;

end.
