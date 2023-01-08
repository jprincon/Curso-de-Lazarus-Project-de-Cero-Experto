program Color_Fondo_vs_Fuente;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, tachartlazaruspkg, uTActivactionFunction, uTCustomObjectLog, uTLayer,
  uTMatrix, uTNeuron, uTNeuronalNetwork, uTNumberList, uTProductPoint,
  uFColorFondoFuente
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFColorFondo, FColorFondo);
  Application.Run;
end.

