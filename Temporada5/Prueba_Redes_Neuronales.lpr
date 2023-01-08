program Prueba_Redes_Neuronales;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, tachartlazaruspkg, uFPruebaRedesNeuronales, uTNumberList,
  uTProductPoint, uTActivactionFunction, uFFuncionActivacion, uTNeuron, uTLayer,
  uTNeuronalNetwork, uTCustomObjectLog, uTMatrix
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFPruebaRedesNeuronales, FPruebaRedesNeuronales);
  Application.CreateForm(TFGraficaFuncionActivacion, FGraficaFuncionActivacion);
  Application.Run;
end.

