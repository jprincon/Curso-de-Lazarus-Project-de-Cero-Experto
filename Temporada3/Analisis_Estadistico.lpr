program Analisis_Estadistico;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, tachartlazaruspkg, uFAnalisisEstadistico, uFMensaje, uFConsola,
  Utilidades, uTipos, uFImportarCSV, uFGraficaEstadistica, uFAcerca
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFAnalisisEstadistico, FAnalisisEstadistico);
  Application.CreateForm(TFMensaje, FMensaje);
  Application.CreateForm(TFConsola, FConsola);
  Application.CreateForm(TFImportarCSV, FImportarExportarCSV);
  Application.CreateForm(TFGraficas, FGraficas);
  Application.CreateForm(TFAcerca, FAcerca);
  Application.Run;
end.

