unit uFAnalisisEstadistico;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, Grids, ComCtrls,
  ExtCtrls, StdCtrls, Buttons, SynEdit, uFMensaje, uFConsola, uFImportarCSV,
  uFGraficaEstadistica, Utilidades, uTipos, DOM, XMLRead, inifiles;

type

  { TFAnalisisEstadistico }

  TFAnalisisEstadistico = class(TForm)
    edDireccion: TEdit;
    edNombre: TEdit;
    edID: TEdit;
    edCorreo: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    menuArchivo: TMenuItem;
    menuExportarGrafica: TMenuItem;
    menuDigramaBarras: TMenuItem;
    menuDiagramaArea: TMenuItem;
    menuDigramaLineal: TMenuItem;
    menuDigramaPastel: TMenuItem;
    menuDatos: TMenuItem;
    menuGenerarDatos: TMenuItem;
    menuConsolaMensajes: TMenuItem;
    Importar: TMenuItem;
    menuImportarDesdeArchivoINI: TMenuItem;
    menuImportarDesdeArchivoCSV: TMenuItem;
    menuGuardarAnalisis: TMenuItem;
    menuCalcularRegresionLineal: TMenuItem;
    menuGenerarDiagramaBarras: TMenuItem;
    menuGenerarDiagramaLineal: TMenuItem;
    menuGenerarDiagramaAreas: TMenuItem;
    menuGenerarDiagramaCircular: TMenuItem;
    Separator4: TMenuItem;
    Separator3: TMenuItem;
    menEstadisticosBasicos: TMenuItem;
    Separator2: TMenuItem;
    menuCerrarTablas: TMenuItem;
    menuObtenerCantidadFilas: TMenuItem;
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
    Contenido: TPageControl;
    datosUsuario: TPageControl;
    Separator1: TMenuItem;
    MenuPrincipal: TMainMenu;
    barraEstado: TStatusBar;
    sgDatos: TStringGrid;
    sbGuardarDatos: TSpeedButton;
    seAnalisis: TSynEdit;
    TabDatos: TTabSheet;
    TabConfig: TTabSheet;
    tabDatosUsuario: TTabSheet;
    TabAnalisis: TTabSheet;

    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure menEstadisticosBasicosClick(Sender: TObject);

    procedure menuAbrirClick(Sender: TObject);
    procedure menuCalcularRegresionLinealClick(Sender: TObject);
    procedure menuCerrarTablasClick(Sender: TObject);
    procedure menuConsolaMensajesClick(Sender: TObject);
    procedure menuExportarArchivoCSVClick(Sender: TObject);
    procedure menuExportarArchivoINIClick(Sender: TObject);
    procedure menuGenerarDatosClick(Sender: TObject);
    procedure menuGenerarDiagramaAreasClick(Sender: TObject);
    procedure menuGenerarDiagramaBarrasClick(Sender: TObject);
    procedure menuGenerarDiagramaCircularClick(Sender: TObject);
    procedure menuGenerarDiagramaLinealClick(Sender: TObject);
    procedure menuGuardarAnalisisClick(Sender: TObject);
    procedure menuGuardarClick(Sender: TObject);
    procedure menuImportarDesdeArchivoCSVClick(Sender: TObject);
    procedure menuImportarDesdeArchivoINIClick(Sender: TObject);
    procedure menuObtenerCantidadFilasClick(Sender: TObject);
    procedure menuObtenerDatosXMLClick(Sender: TObject);
    procedure sbGuardarDatosClick(Sender: TObject);
    procedure sgDatosKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  private
    config: TIniFile;
    nombreArchivo: string;
    archivoAbierto: boolean;
  public
    procedure configurarTabla;
    procedure marcarTabla;
    procedure leerConfiguracion;
    procedure guardarPosicionFormulario;
    procedure posicionarFormularios;
  end;

var
  FAnalisisEstadistico: TFAnalisisEstadistico;

implementation

{$R *.lfm}

{ TFAnalisisEstadistico }

procedure TFAnalisisEstadistico.FormCreate(Sender: TObject);
begin
  // Configurar variables
  archivoAbierto := False;

  configurarTabla;
  marcarTabla;

  leerConfiguracion;

  Contenido.ActivePage := TabDatos;
end;

procedure TFAnalisisEstadistico.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  guardarPosicionFormulario;

  {if FMensaje.Mostrar('Confirmación', '¿Está seguro(a) de salir?', tmQuestion) then
    CanClose := True
  else
    CanClose := False;}

  CanClose := FMensaje.Mostrar('Confirmación', '¿Está seguro(a) de salir?',
    tmQuestion);
end;

procedure TFAnalisisEstadistico.FormResize(Sender: TObject);
begin
  guardarPosicionFormulario;
end;

procedure TFAnalisisEstadistico.FormShow(Sender: TObject);
begin
  posicionarFormularios;

  FConsola.Show;
end;

procedure TFAnalisisEstadistico.menEstadisticosBasicosClick(Sender: TObject);
var
  datosX, datosY: TStringList;
  j: integer;
  media, maximo, minimo, desvest, varianza: real;
begin
  seAnalisis.Lines.Clear;
  seAnalisis.Lines.Add('=== Análisis de Datos ===');
  seAnalisis.Lines.Add('');

  datosX := TStringList.Create;
  datosY := TStringList.Create;

  for j := 1 to sgDatos.RowCount - 1 do
  begin
    datosX.Add(sgDatos.Cells[1, j]);
    datosY.Add(sgDatos.Cells[2, j]);
  end;

  // Cálculo de la Media
  media := Utilidades.calcularMedia(datosX);
  seAnalisis.Lines.Add(format('media X = %f', [media]));
  media := Utilidades.calcularMedia(datosY);
  seAnalisis.Lines.Add(format('media Y = %f', [media]));

  // Cálculo del Mínimo
  minimo := Utilidades.calcularMinimo(datosX);
  seAnalisis.Lines.Add(format('mínimo X = %f', [minimo]));
  minimo := Utilidades.calcularMinimo(datosY);
  seAnalisis.Lines.Add(format('mínimo Y = %f', [minimo]));

  // Cálculo del Mínimo
  maximo := Utilidades.calcularMaximo(datosX);
  seAnalisis.Lines.Add(format('máximo X = %f', [maximo]));
  maximo := Utilidades.calcularMaximo(datosY);
  seAnalisis.Lines.Add(format('máximo Y = %f', [maximo]));

  // Cálculo de la Varianza
  varianza := Utilidades.calcularVarianza(datosX);
  seAnalisis.Lines.Add(format('varianza X = %f', [varianza]));
  varianza := Utilidades.calcularVarianza(datosY);
  seAnalisis.Lines.Add(format('varianza Y = %f', [varianza]));

  // Cálculo de la Desviación Estándar
  desvest := Utilidades.calcularDesvStandar(datosX);
  seAnalisis.Lines.Add(format('desvest X = %f', [desvest]));
  desvest := Utilidades.calcularDesvStandar(datosY);
  seAnalisis.Lines.Add(format('desvest Y = %f', [desvest]));

  Contenido.ActivePage := TabAnalisis;
end;

procedure TFAnalisisEstadistico.menuAbrirClick(Sender: TObject);
var
  countRows: integer;
begin
  if dlgAbrirTabla.Execute then
  begin
    countRows := Utilidades.obtenerFilasXML(dlgAbrirTabla.FileName);
    sgDatos.RowCount := countRows + 1;
    sgDatos.LoadFromFile(dlgAbrirTabla.FileName);

    archivoAbierto := True;
    nombreArchivo := dlgAbrirTabla.FileName;

    Caption := 'Análisis Estadístico - ' + nombreArchivo;
  end;
end;

procedure TFAnalisisEstadistico.menuCalcularRegresionLinealClick(Sender: TObject);
var
  datosX, datosY: TStringList;
  j: integer;
  regLin: TRegresionLineal;
begin
  seAnalisis.Lines.Clear;
  seAnalisis.Lines.Add('=== Análisis de Datos (Regresión Lineal) ===');
  seAnalisis.Lines.Add('');

  datosX := TStringList.Create;
  datosY := TStringList.Create;

  for j := 1 to sgDatos.RowCount - 1 do
  begin
    datosX.Add(sgDatos.Cells[1, j]);
    datosY.Add(sgDatos.Cells[2, j]);
  end;

  regLin := Utilidades.calcularRegresionLineal(datosX, datosY);

  seAnalisis.Lines.AddStrings(Utilidades.imprimirRegLin(regLin));

  Contenido.ActivePage := TabAnalisis;
end;

procedure TFAnalisisEstadistico.menuCerrarTablasClick(Sender: TObject);
var
  i: integer;
begin
  sgDatos.Clean;
  archivoAbierto := False;
  nombreArchivo := '';
  Caption := 'Análisis Estadístico';

  for i := 0 to barraEstado.Panels.Count - 1 do
    barraEstado.Panels[i].Text := '';
end;

procedure TFAnalisisEstadistico.menuConsolaMensajesClick(Sender: TObject);
begin
  FConsola.Show;
end;

procedure TFAnalisisEstadistico.menuExportarArchivoCSVClick(Sender: TObject);
var
  ruta: string;
begin
  dlgGuardarTabla.FilterIndex := 4;
  if dlgGuardarTabla.Execute then
  begin
    ruta := dlgGuardarTabla.FileName;
    ruta := Utilidades.comprobarExtension(ruta, '.csv');

    // sgDatos.SaveToCSVFile(ruta,';');

    FImportarExportarCSV.exportar(sgDatos);
    Utilidades.exportarCSVFile(sgDatos, ruta, FImportarExportarCSV.delimitador);

    FMensaje.Mostrar('Información', 'El archivo CSV se exportó correctamente', tmInfo);
  end;
end;

procedure TFAnalisisEstadistico.menuExportarArchivoINIClick(Sender: TObject);
var
  archivoDatos: TIniFile;
  ruta: string;
  i: integer;
  dato: real;
  fs: TFormatSettings;
begin
  dlgGuardarTabla.FilterIndex := 3;
  if dlgGuardarTabla.Execute then
  begin
    fs.DecimalSeparator := '.';

    ruta := dlgGuardarTabla.FileName;
    ruta := Utilidades.comprobarExtension(ruta, '.ini');
    archivoDatos := TIniFile.Create(ruta);

    archivoDatos.WriteInteger('Config', 'Filas', sgDatos.RowCount);

    for i := 1 to sgDatos.RowCount - 1 do
    begin
      dato := StrToFloat(sgDatos.Cells[1, i], fs);
      archivoDatos.WriteFloat('Datos', 'CeldaX' + IntToStr(i), dato);

      dato := StrToFloat(sgDatos.Cells[2, i], fs);
      archivoDatos.WriteFloat('Datos', 'CeldaY' + IntToStr(i), dato);
    end;

    archivoDatos.Free;

    FMensaje.Mostrar('Información',
      'El archivo de datos se exportó correctamente', tmInfo);
  end;
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
  Contenido.ActivePage := TabDatos;
end;

procedure TFAnalisisEstadistico.menuGenerarDiagramaAreasClick(Sender: TObject);
begin
     FGraficas.graficar(sgDatos, tgArea);
end;

procedure TFAnalisisEstadistico.menuGenerarDiagramaBarrasClick(Sender: TObject);
begin
     FGraficas.graficar(sgDatos, tgBarras);
end;

procedure TFAnalisisEstadistico.menuGenerarDiagramaCircularClick(Sender: TObject
  );
begin
     FGraficas.graficar(sgDatos, tgCircular);
end;

procedure TFAnalisisEstadistico.menuGenerarDiagramaLinealClick(Sender: TObject);
begin
     FGraficas.graficar(sgDatos, tgLineal);
end;

procedure TFAnalisisEstadistico.menuGuardarAnalisisClick(Sender: TObject);
var
  ruta: string;
begin
  dlgGuardarTabla.FilterIndex := 5;
  dlgGuardarTabla.Title := 'Guardar análisis de datos como ...';
  if dlgGuardarTabla.Execute then
  begin
    ruta := dlgGuardarTabla.FileName;
    ruta := Utilidades.comprobarExtension(ruta, '.txt');

    seAnalisis.Lines.SaveToFile(ruta);

    FMensaje.Mostrar('Información', 'El análisis se guardo correctamente', tmInfo);
  end;
end;

procedure TFAnalisisEstadistico.menuGuardarClick(Sender: TObject);
var
  ruta: string;
begin
  if archivoAbierto then
  begin
    sgDatos.SaveToFile(nombreArchivo);
    barraEstado.Panels[1].Text := 'Archivo Guardado - ' + nombreArchivo;
    TabDatos.Caption := 'Datos';
  end
  else
  begin

    if dlgGuardarTabla.Execute then
    begin
      ruta := dlgGuardarTabla.FileName;
      ruta := Utilidades.comprobarExtension(ruta, '.data');

      archivoAbierto := True;
      nombreArchivo := ruta;

      if FileExists(ruta) then
      begin
        if FMensaje.Mostrar('Confirmación',
          'Está seguro(a) de sobreescribir éste archivo', tmQuestion) then
        begin
          sgDatos.SaveToFile(ruta);
          FMensaje.Mostrar('Análisis de Datos dice ...',
            'La tabla se guardo correctamente', tmInfo);
        end
        else
        begin
          archivoAbierto := False;
          nombreArchivo := '';
        end;
      end;
    end;

  end;
end;

procedure TFAnalisisEstadistico.menuImportarDesdeArchivoCSVClick(Sender: TObject);
var
  ruta: string;
begin
  dlgAbrirTabla.FilterIndex := 4;
  if dlgAbrirTabla.Execute then
  begin
    ruta := dlgAbrirTabla.FileName;
    // sgDatos.LoadFromCSVFile(ruta);

    FImportarExportarCSV.importar(ruta); // Pausa

    Utilidades.importCSVFile(sgDatos, ruta, FImportarExportarCSV.delimitador);
    marcarTabla;
  end;
end;

procedure TFAnalisisEstadistico.menuImportarDesdeArchivoINIClick(Sender: TObject);
var
  archivoDatos: TIniFile;
var
  n, i: integer;
  x, y: real;
  sVar: string;
begin
  dlgAbrirTabla.FilterIndex := 3;
  if dlgAbrirTabla.Execute then
  begin
    archivoDatos := TIniFile.Create(dlgAbrirTabla.FileName);

    n := archivoDatos.ReadInteger('Config', 'Filas', 20);
    sgDatos.RowCount := n;

    for i := 1 to n - 1 do
    begin
      sVar := 'CeldaX' + IntToStr(i);
      x := archivoDatos.ReadFloat('Datos', sVar, 0);

      sVar := 'CeldaY' + IntToStr(i);
      y := archivoDatos.ReadFloat('Datos', sVar, 0);

      sgDatos.Cells[1, i] := FloatToStr(x);
      sgDatos.Cells[2, i] := FloatToStr(y);
    end;

    marcarTabla;
    archivoDatos.Free;
  end;
end;

procedure TFAnalisisEstadistico.menuObtenerCantidadFilasClick(Sender: TObject);
var
  countRows: integer;
begin
  if dlgAbrirTabla.Execute then
  begin
    countRows := Utilidades.obtenerFilasXML(dlgAbrirTabla.FileName);
    FConsola.log('countRows', IntToStr(countRows), tcInfo);
  end;
end;

procedure TFAnalisisEstadistico.menuObtenerDatosXMLClick(Sender: TObject);
var
  DocXML: TXMLDocument;
  grid, content, cells, cellsN: TDOMNode;
  countCells: string;
  countRows: integer;
begin
  if dlgAbrirTabla.Execute then
  begin
    ReadXMLFile(DocXML, dlgAbrirTabla.FileName);
    Grid := DocXML.DocumentElement.FirstChild;
    Content := Grid.FindNode('content');
    Cells := Content.FirstChild;

    if Assigned(Cells) then
    begin
      countCells := Cells.Attributes.Item[0].NodeValue;
      cellsN := cells.FindNode('cell' + countCells);
      FConsola.log('NodeName', cellsN.NodeName, tcInfo);

      countRows := StrToInt(cellsN.Attributes.Item[0].NodeValue);
      FConsola.log('CountRows', IntToStr(countRows), tcInfo);
    end
    else
      FConsola.log('Advertencia', 'El nodo no existe', tcWarning);
  end;
end;

procedure TFAnalisisEstadistico.sbGuardarDatosClick(Sender: TObject);
begin
  config.WriteString('Usuario', 'Nombre', edNombre.Text);
  config.WriteString('Usuario', 'correo', edCorreo.Text);
  config.WriteString('Usuario', 'Id', edID.Text);
  config.WriteString('Usuario', 'Direccion', edDireccion.Text);

  FMensaje.Mostrar('Información',
    'Los datos de usuario se guardaron correctamente', tmInfo);
end;

procedure TFAnalisisEstadistico.sgDatosKeyDown(Sender: TObject;
  var Key: word; Shift: TShiftState);
begin
  // barraEstado.Panels[0].Text := 'Key = ' + IntToStr(key);

  barraEstado.Panels[1].Text := '';
  TabDatos.Caption := '*Datos';

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

procedure TFAnalisisEstadistico.leerConfiguracion;
begin
  // Creando o subiendo el archivo a la memoria
  config := TIniFile.Create('Configuracion.ini');

  edNombre.Text := config.ReadString('Usuario', 'Nombre', '');
  edCorreo.Text := config.ReadString('Usuario', 'Correo', '');
  edID.Text := config.ReadString('Usuario', 'ID', '');
  edDireccion.Text := config.ReadString('Usuario', 'Direccion', '');
end;

procedure TFAnalisisEstadistico.guardarPosicionFormulario;
begin
  config.WriteInteger('Formulario_Principal', 'Left', Left);
  config.WriteInteger('Formulario_Principal', 'Top', Top);
  config.WriteInteger('Formulario_Principal', 'Width', Width);
  config.WriteInteger('Formulario_Principal', 'Height', Height);

  config.WriteInteger('Formulario_Consola', 'Left', FConsola.Left);
  config.WriteInteger('Formulario_Consola', 'Top', FConsola.Top);
  config.WriteInteger('Formulario_Consola', 'Width', FConsola.Width);
  config.WriteInteger('Formulario_Consola', 'Height', FConsola.Height);
end;

procedure TFAnalisisEstadistico.posicionarFormularios;
begin
  Left := config.ReadInteger('Formulario_Principal', 'Left', 0);
  Top := config.ReadInteger('Formulario_Principal', 'Top', 0);
  Width := config.ReadInteger('Formulario_Principal', 'Width', 800);
  Height := config.ReadInteger('Formulario_Principal', 'Height', 600);

  FConsola.Left := config.ReadInteger('Formulario_Consola', 'Left', 0);
  FConsola.Top := config.ReadInteger('Formulario_Consola', 'Top', 0);
  FConsola.Width := config.ReadInteger('Formulario_Consola', 'Width', 800);
  FConsola.Height := config.ReadInteger('Formulario_Consola', 'Height', 600);

  FConsola.log('Left', IntToStr(config.ReadInteger('Formulario_Principal',
    'Left', 0)), tcInfo);
  FConsola.log('Top', IntToStr(config.ReadInteger('Formulario_Principal',
    'Top', 0)), tcInfo);
  FConsola.log('Width', IntToStr(config.ReadInteger('Formulario_Principal',
    'Width', 0)), tcInfo);
  FConsola.log('Height', IntToStr(config.ReadInteger('Formulario_Principal',
    'Height', 0)), tcInfo);
end;

end.
