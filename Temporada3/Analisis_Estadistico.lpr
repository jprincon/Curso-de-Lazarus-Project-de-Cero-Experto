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
  Forms, uFAnalisisEstadistico, uFMensaje, uFConsola, Utilidades, uTipos
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFAnalisisEstadistico, FAnalisisEstadistico);
  Application.CreateForm(TFMensaje, FMensaje);
  Application.CreateForm(TFConsola, FConsola);
  Application.Run;
end.

