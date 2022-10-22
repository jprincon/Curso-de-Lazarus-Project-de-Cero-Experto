unit uFAnalisisEstadistico;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, Grids;

type

  { TFAnalisisEstadistico }

  TFAnalisisEstadistico = class(TForm)
    menuArchivo: TMenuItem;
    menuExportarGrafica: TMenuItem;
    menuDigramaBarras: TMenuItem;
    menuDiagramaArea: TMenuItem;
    menuDigramaLineal: TMenuItem;
    menuDigramaPastel: TMenuItem;
    menuManualAyuda: TMenuItem;
    menuAcerca: TMenuItem;
    menuConfigurar: TMenuItem;
    menuConfigurarAplicacion: TMenuItem;
    menuNuevo: TMenuItem;
    menuAbrir: TMenuItem;
    menuGuardar: TMenuItem;
    menuSalir: TMenuItem;
    menuAyuda: TMenuItem;
    menuExportar: TMenuItem;
    menuExportarArchivoINI: TMenuItem;
    menuExportarArchivoCSV: TMenuItem;
    Separator1: TMenuItem;
    MenuPrincipal: TMainMenu;
    sgDatos: TStringGrid;
    procedure FormCreate(Sender: TObject);
  private

  public
    procedure configurarTabla;
    procedure marcarTabla;
  end;

var
  FAnalisisEstadistico: TFAnalisisEstadistico;

implementation

{$R *.lfm}

{ TFAnalisisEstadistico }

procedure TFAnalisisEstadistico.FormCreate(Sender: TObject);
begin
  // Configurar tabla
  configurarTabla;
  marcarTabla;
end;

procedure TFAnalisisEstadistico.configurarTabla;
begin
  sgDatos.ColCount := 3;
  sgDatos.RowCount := 20;
end;

procedure TFAnalisisEstadistico.marcarTabla;
var
  i: integer;
begin
  for i := 1 to sgDatos.RowCount - 1 do
  begin
    sgDatos.Cells[0, i] := IntToStr(i);
  end;

  sgDatos.Cells[1, 0] := 'X';
  sgDatos.Cells[2, 0] := 'Y';
end;

end.
