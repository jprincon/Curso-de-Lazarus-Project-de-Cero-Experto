program Procedimientos_y_Funciones;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uFUtilidades, lazcontrols, tachartlazaruspkg, Utilidades, uTipos, 
uFMensaje, uFToast, uFReal, uFTexto, uFConsola
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='Procedimientos y Funciones';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFUtilidades, FUtilidades);
  Application.CreateForm(TFMensaje, FMensaje);
  Application.CreateForm(TFToast, FToast);
  Application.CreateForm(TFReal, FReal);
  Application.CreateForm(TFTexto, FTexto);
  Application.CreateForm(TFConsola, FConsola);
  Application.Run;
end.

