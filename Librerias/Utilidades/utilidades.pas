unit Utilidades;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Math, Dialogs, uTipos, DOM, XMLRead, Grids, Graphics;

{General}
function version: string;

{Matemáticas}
function calcularMedia(datos: TStringList): real;
function calcularMinimo(datos: TStringList): real;
function calcularMaximo(datos: TStringList): real;
function calcularVarianza(datos: TStringList): real;
function calcularDesvStandar(datos: TStringList): real;
function calcularRegresionLineal(datosX, datosY: TStringList): TRegresionLineal;
function valor(r: real; precision: integer = 2): string;

{Transformaciones}
function imprimirRegLin(regLin: TRegresionLineal): TStringList;

{Generadores}
function generarClave(n: integer): string;
function generarCadena(n: integer): string;
function generarID: string;
function generarColor: TColor;

{Archivos}
function comprobarExtension(ruta, ext: string): string;
function obtenerFilasXML(ruta: string): integer;
procedure exportarCSVFile(sg: TStringGrid; path: string; delimiter: char = ',');
procedure importCSVFile(sg: TStringGrid; path: string; delimiter: char = ',');

const

  base = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!#$%&=';
  base_ = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

implementation

function version: string;
begin
  Result := 'v. 22.10.17.1131';
end;

function calcularMedia(datos: TStringList): real;
var
  i: integer;
  dato, suma: real;
  fs: TFormatSettings;
begin

  Result := 0;
  fs.DecimalSeparator := '.';

  if (datos.Count > 0) then
  begin
    suma := 0;
    for i := 1 to datos.Count do
    begin
      dato := StrToFloat(datos[i - 1], fs);
      suma := suma + dato;
    end;

    Result := suma / datos.Count;
  end;
end;

function calcularMinimo(datos: TStringList): real;
var
  i: integer;
  dato: real;
  fs: TFormatSettings;
begin
  Result := 0;
  fs.DecimalSeparator := '.';

  if (datos.Count > 0) then
  begin
    dato := StrToFloat(datos[0], fs);
    Result := dato;

    for i := 1 to datos.Count do
    begin
      dato := StrToFloat(datos[i - 1], fs);

      if (dato < Result) then
        Result := dato;
    end;
  end;
end;

function calcularMaximo(datos: TStringList): real;
var
  i: integer;
  dato: real;
  fs: TFormatSettings;
begin
  Result := 0;
  fs.DecimalSeparator := '.';

  if (datos.Count > 0) then
  begin
    dato := StrToFloat(datos[0], fs);
    Result := dato;

    for i := 1 to datos.Count do
    begin
      dato := StrToFloat(datos[i - 1], fs);

      if (dato > Result) then
        Result := dato;
    end;
  end;

end;

function calcularVarianza(datos: TStringList): real;
var
  media, suma, dato: real;
  i: integer;
  fs: TFormatSettings;
begin
  Result := 0;
  fs.DecimalSeparator := '.';

  // ShowMessage('Datos = '+datos.CommaText);

  if (datos.Count > 0) then
  begin
    media := calcularMedia(datos);
    suma := 0;

    for i := 1 to datos.Count do
    begin
      dato := StrToFloat(datos[i - 1], fs);
      suma := suma + power(dato - media, 2);
    end;

    Result := suma / (datos.Count - 1);
  end;
end;

function calcularDesvStandar(datos: TStringList): real;
var
  varianza: real;
begin
  varianza := calcularVarianza(datos);
  Result := sqrt(varianza);
end;

function calcularRegresionLineal(datosX, datosY: TStringList): TRegresionLineal;
var
  i, n: integer;
  datoX, datoY: real;
  fs: TFormatSettings;
begin
  Result.sumX := 0;
  Result.sumY := 0;
  Result.sumXY := 0;
  Result.sumX2 := 0;
  Result.sumY2 := 0;

  n := datosX.Count;
  fs.DecimalSeparator := '.';

  for i := 1 to n do
  begin
    // Extrar el dato
    datoX := StrToFloat(datosX[i - 1], fs);
    datoY := StrToFloat(datosY[i - 1], fs);

    Result.sumX := Result.sumX + datoX;
    Result.sumY := Result.sumY + datoY;
    Result.sumXY := Result.sumXY + datoX * datoY;
    Result.sumX2 := Result.sumX2 + power(datoX, 2);
    Result.sumY2 := Result.sumY2 + power(datoY, 2);
  end;

  {Realizar el cálculo
   b = [(ΣY) (ΣX 2 ) – (ΣX) (ΣXY)] / [n (ΣX 2 ) – (ΣX) 2 ]
   m = [n (ΣXY) – (ΣX) (ΣY)] / [n (ΣX 2 ) – (ΣX) 2 ]}

  with Result do
  begin
    b := (sumY * sumX2 - sumX * sumXY) / (n * sumX2 - power(sumX, 2));
    m := (n * sumXY - sumX * sumY) / (n * sumX2 - power(sumX, 2));
  end;

end;

function valor(r: real; precision: integer = 2): string;
begin
  if r = 0 then
  begin
    Result := '';
    exit;
  end;

  if r > 0 then
  begin
    Result := '+' + FloatToStrF(r, ffNumber, 12, precision);
    exit;
  end;

  if r < 0 then
  begin
    Result := FloatToStrF(r, ffNumber, 12, precision);
    exit;
  end;
end;

function imprimirRegLin(regLin: TRegresionLineal): TStringList;
begin
  Result := TStringList.Create;
  Result.Add(format('ΣX  = %f', [regLin.sumX]));
  Result.Add(format('ΣY  = %f', [regLin.sumY]));
  Result.Add(format('ΣXY = %f', [regLin.sumXY]));
  Result.Add(format('ΣX² = %f', [regLin.sumX2]));
  Result.Add(format('ΣY² = %f', [regLin.sumY2]));
  Result.Add(format('m   = %f', [regLin.m]));
  Result.Add(format('b   = %f', [regLin.b]));
end;

function generarClave(n: integer): string;
var
  p, i: integer;
begin
  Result := '';
  for i := 1 to n do
  begin
    p := Random(Length(base)) + 1;
    Result := Result + base[p];
  end;
end;

function generarCadena(n: integer): string;
var
  p, i: integer;
begin
  Result := '';
  for i := 1 to n do
  begin
    p := Random(Length(base_)) + 1;
    Result := Result + base_[p];
  end;
end;

function generarID: string;
begin
  {kmiqhjuy-LolM-ploQ-lokA-junJaYqlMoPq}
  Result := generarCadena(8) + '-' + generarCadena(4) + '-' +
    generarCadena(4) + '-' + generarCadena(4) + '-' + generarCadena(12);
end;

function generarColor: TColor;
var
  r, g, b: byte;
begin
  r := Random(255);
  g := Random(255);
  b := Random(255);

  Result := RGBToColor(r, g, b);
end;

function comprobarExtension(ruta, ext: string): string;
begin
  if ExtractFileExt(ruta) = ext then
    Result := ruta
  else
    Result := ruta + ext;
end;

function obtenerFilasXML(ruta: string): integer;
var
  DocXML: TXMLDocument;
  grid, content, cells, cellsN: TDOMNode;
  countCells: string;
  countRows: integer;
begin
  ReadXMLFile(DocXML, ruta);
  Grid := DocXML.DocumentElement.FirstChild;
  Content := Grid.FindNode('content');
  Cells := Content.FirstChild;

  Result := 0;

  if Assigned(Cells) then
  begin
    countCells := Cells.Attributes.Item[0].NodeValue;
    cellsN := cells.FindNode('cell' + countCells);

    countRows := StrToInt(cellsN.Attributes.Item[0].NodeValue);
    Result := countRows;
  end;
end;

procedure exportarCSVFile(sg: TStringGrid; path: string; delimiter: char = ',');
var
  col, row, i, j: integer;
  sRow: string;
  fileCSV: TStringList;
begin
  col := sg.ColCount;
  row := sg.RowCount;

  fileCSV := TStringList.Create;

  for j := 0 to row - 1 do
  begin

    sRow := '';

    for i := 0 to col - 2 do
    begin
      sRow := sRow + sg.Cells[i, j] + delimiter;
    end;
    sRow := sRow + sg.Cells[i + 1, j];

    fileCSV.Add(sRow);
  end;

  fileCSV.SaveToFile(path);
end;

procedure importCSVFile(sg: TStringGrid; path: string; delimiter: char = ',');
var
  fileCSV: TStringList;
  i, j, row, col: integer;
  sRow: TStringList;
begin
  if Assigned(sg) then
  begin
    fileCSV := TStringList.Create;
    fileCSV.LoadFromFile(path);
    fileCSV.Delimiter := delimiter;

    // get rowCount
    row := fileCSV.Count;
    sg.RowCount := row;

    sRow := TStringList.Create;
    sRow.Delimiter := delimiter;
    sRow.DelimitedText := fileCSV[0];

    // get colCount
    col := sRow.Count;
    sg.ColCount := col;
    sRow.Free;

    for j := 0 to row - 1 do
    begin

      sRow := TStringList.Create;
      sRow.Delimiter := delimiter;
      sRow.DelimitedText := fileCSV[j];

      for i := 0 to col - 1 do
      begin
        sg.Cells[i, j] := sRow[i];
      end;

      sRow.Free;
    end;
  end
  else
    MessageDlg('Advertencia', 'El StringGrid no existe', mtWarning, [mbYes], 0);

end;

end.
