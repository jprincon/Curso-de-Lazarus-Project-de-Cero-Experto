program Programa_Consola;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes
  { you can add units after this };

var
  a,b,c: integer;
begin
  WriteLn('Suma de numeros');
  a := 5;
  b := 23;
  c := a + b;
  WriteLn('suma = ', c);
  ReadLn;
end.

