unit Utilidades;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Math, Dialogs, uTipos;

{General}
function version: string;

{Matemáticas}
function calcularMedia(datos: TStringList): real;
function calcularMinimo(datos: TStringList): real;
function calcularMaximo(datos: TStringList): real;
function calcularVarianza(datos: TStringList): real;
function calcularDesvStandar(datos: TStringList): real;
function calcularRegresionLineal(datosX, datosY: TStringList): TRegresionLineal;

{Generadores}
function generarClave(n: integer): string;
function generarCadena(n: integer): string;
function generarID: string;

{Archivos}
function comprobarExtension(ruta, ext: string): string;

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

function comprobarExtension(ruta, ext: string): string;
begin
  if ExtractFileExt(ruta) = ext then
    Result := ruta
  else
    Result := ruta + ext;
end;

end.
