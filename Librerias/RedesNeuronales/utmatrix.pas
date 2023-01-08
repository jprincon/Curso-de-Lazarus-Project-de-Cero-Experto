unit uTMatrix;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uTCustomObjectLog, uTNumberList, Grids;

type

  { TMatrix }

  TMatrix = class(TCustomObjectLog)
  private
    FcolCount: integer;
    FMatrix: TStringGrid;
    FrowCount: integer;
    procedure SetcolCount(AValue: integer);
    procedure SetrowCount(AValue: integer);
  public
    constructor Create;
    destructor Destroy; override;

    procedure loadFromCSVFile(filename: string);
    procedure setValue(col, row: integer; Value: real);
    procedure printOnConsole;

    function getValue(col, row: integer): real;
    function getRow(row: integer): TNumberList;
    function getRowDiminished(row: integer): TNumberList;
    function getCol(col: integer): TNumberList;

  published
    property rowCount: integer read FrowCount write SetrowCount;
    property colCount: integer read FcolCount write SetcolCount;
  end;

implementation

{ TMatrix }

procedure TMatrix.SetcolCount(AValue: integer);
begin
  if FcolCount = AValue then Exit;
  FcolCount := AValue;

  log('colCount = ' + IntToStr(FcolCount));
end;

procedure TMatrix.SetrowCount(AValue: integer);
begin
  if FrowCount = AValue then Exit;
  FrowCount := AValue;

  log('rowCount = ' + IntToStr(FrowCount));
end;

constructor TMatrix.Create;
begin
  FMatrix := TStringGrid.Create(nil);
end;

destructor TMatrix.Destroy;
begin
  FMatrix.Free;
  inherited Destroy;
end;

procedure TMatrix.loadFromCSVFile(filename: string);
begin
  FMatrix.LoadFromCSVFile(filename);

  FrowCount := FMatrix.RowCount;
  FcolCount := FMatrix.ColCount;

  log('Matrix read');
end;

procedure TMatrix.setValue(col, row: integer; Value: real);
var
  fs: TFormatSettings;
begin
  fs.DecimalSeparator := '.';
  FMatrix.Cells[col, row] := FloatToStr(Value, fs);

  log('Set value');
end;

procedure TMatrix.printOnConsole;
var
  i, j: integer;
begin
  for i := 0 to FMatrix.RowCount - 1 do
  begin
    log(getRow(i).getList(','));
  end;
end;

function TMatrix.getValue(col, row: integer): real;
var
  fs: TFormatSettings;
begin
  fs.DecimalSeparator := '.';
  Result := StrToFloat(FMatrix.Cells[col, row], fs);
end;

function TMatrix.getRow(row: integer): TNumberList;
var
  i: integer;
begin
  Result := TNumberList.Create;
  for i := 0 to FMatrix.ColCount - 1 do
  begin
    Result.add(getValue(i, row));
  end;
end;

function TMatrix.getRowDiminished(row: integer): TNumberList;
var
  i: integer;
begin
  Result := TNumberList.Create;
  for i := 0 to FMatrix.ColCount - 2 do
  begin
    Result.add(getValue(i, row));
  end;
end;

function TMatrix.getCol(col: integer): TNumberList;
var
  i: integer;
begin
  Result := TNumberList.Create;
  for i := 0 to FMatrix.RowCount - 1 do
  begin
    Result.add(getValue(i, col));
  end;
end;

end.
