unit uTipos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  {Regresión Lineal y = mx+b}
  TRegresionLineal = record
    sumX: real;
    sumY: real;
    sumXY: real;
    sumX2: real;
    sumY2: real;
    m: real;
    b: real;
  end;

implementation

end.

