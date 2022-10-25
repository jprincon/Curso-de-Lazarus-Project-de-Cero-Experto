unit uFAnalisisEstadistico;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, Grids, ComCtrls,
  ExtCtrls, StdCtrls, uFMensaje, uFConsola, Utilidades, DOM, XMLRead;

type

  { TFAnalisisEstadistico }

  TFAnalisisEstadistico = class(TForm)
    menuArchivo: TMenuItem;
    menuExportarGrafica: TMenuItem;
    menuDigramaBarras: TMenuItem;
    menuDiagramaArea: TMenuItem;
    menuDigramaLineal: TMenuItem;
    menuDigramaPastel: TMenuItem;
    menuDatos: TMenuItem;
    menuGenerarDatos: TMenuItem;
    menuConsolaMensajes: TMenuItem;
    menuVer: TMenuItem;
    menuObtenerDatosXML: TMenuItem;
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
    dlgGuardarTabla: TSaveDialog;
    dlgAbrirTabla: TOpenDialog;
    Separator1: TMenuItem;
    MenuPrincipal: TMainMenu;
    sgDatos: TStringGrid;
    barraEstado: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure menuAbrirClick(Sender: TObject);
    procedure menuConsolaMensajesClick(Sender: TObject);
    procedure menuGenerarDatosClick(Sender: TObject);
    procedure menuGuardarClick(Sender: TObject);
    procedure menuObtenerDatosXMLClick(Sender: TObject);
    procedure sgDatosKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
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

procedure TFAnalisisEstadistico.menuAbrirClick(Sender: TObject);
begin
  if dlgAbrirTabla.Execute then
  begin
    sgDatos.LoadFromFile(dlgAbrirTabla.FileName);
  end;
end;

procedure TFAnalisisEstadistico.menuConsolaMensajesClick(Sender: TObject);
begin
    FConsola.Show;
end;

procedure TFAnalisisEstadistico.menuGenerarDatosClick(Sender: TObject);
var
  i: integer;
  x, y: real;
begin
  sgDatos.Clean;
  Randomize;

  for i := 1 to sgDatos.RowCount - 1 do
  begin
    x := Random(100);
    y := Random(100);

    sgDatos.Cells[1, i] := FloatToStr(x);
    sgDatos.Cells[2, i] := FloatToStr(y);
  end;

  marcarTabla;
end;

procedure TFAnalisisEstadistico.menuGuardarClick(Sender: TObject);
var
  ruta: string;
begin
  if dlgGuardarTabla.Execute then
  begin
    ruta := dlgGuardarTabla.FileName;
    ruta := Utilidades.comprobarExtension(ruta, '.data');
    sgDatos.SaveToFile(ruta);
    FMensaje.Mostrar('Análisis de Datos dice ...',
      'La tabla se guardo correctamente', tmInfo);
  end;
end;

procedure TFAnalisisEstadistico.menuObtenerDatosXMLClick(Sender: TObject);
var
  DocXML: TXMLDocument;
  Grid, saveOptions, Content, Cells: TDOMNode;
begin
  if dlgAbrirTabla.Execute then
  begin
    ReadXMLFile(DocXML, dlgAbrirTabla.FileName);
    Grid := DocXML.DocumentElement.FirstChild;
    saveOptions := Grid.FirstChild;
    Content := saveOptions.FirstChild;
    Cells := Content.FirstChild;

    if Assigned(Grid) then
    begin
      FConsola.log('NodeName',Cells.NodeName, tcInfo);
      FConsola.log('NodeValue', Cells.NodeValue, tcInfo);
    end
    else
        FConsola.log('Advertencia','El nodo no existe', tcWarning);
  end;
end;

procedure TFAnalisisEstadistico.sgDatosKeyDown(Sender: TObject;
  var Key: word; Shift: TShiftState);
begin
  barraEstado.Panels[0].Text := 'Key = ' + IntToStr(key);

  if (key = $0D) or (key = $28) then
  begin
    // FMensaje.Mostrar('Tabla',IntToStr(sgDatos.Row),tmInfo);
    if sgDatos.Row = (sgDatos.RowCount - 1) then
    begin
      sgDatos.RowCount := sgDatos.RowCount + 1;
      marcarTabla;
    end;
  end;
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
