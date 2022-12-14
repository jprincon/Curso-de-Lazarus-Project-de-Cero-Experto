unit uFUtilidades;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls, Buttons, Utilidades, uTipos, uFMensaje, uFToast, uFReal, uFTexto,
  uFConsola, TreeFilterEdit, SynEdit, TAGraph, TASeries, TAMultiSeries, Math;

type

  { TFUtilidades }

  TFUtilidades = class(TForm)
    bCalcularRegresion: TSpeedButton;
    bGenerarIDs: TButton;
    bVerConsola: TButton;
    bMostrarConsola: TButton;
    bGenerarClaveAleatoria: TButton;
    bResolverPitagoras: TButton;
    bSaludaNombre: TButton;
    bSaludarPersonalizado: TButton;
    bMostrarToast: TButton;
    bSaludarSM: TButton;
    bSaludarMD: TButton;
    Chart1: TChart;
    edNombre: TEdit;
    grafPuntos: TBubbleSeries;
    grafRegLin: TLineSeries;
    ContenidoMenu: TPageControl;
    Contenido: TPageControl;
    edDatos: TEdit;
    edDatosX: TEdit;
    edDatosY: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    lbRuta: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    bCalcularMedia: TSpeedButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    seRegresion: TSynEdit;
    Splitter1: TSplitter;
    barraEstado: TStatusBar;
    seEstadistica: TSynEdit;
    tabItemsMenu: TTabSheet;
    filtroMenu: TTreeFilterEdit;
    tabCalculoMedia: TTabSheet;
    tabRegresionLineal: TTabSheet;
    tabResultados: TTabSheet;
    tabGrafica: TTabSheet;
    tabMensajes: TTabSheet;
    tabGeneradores: TTabSheet;
    tvMenu: TTreeView;
    procedure bGenerarClaveAleatoriaClick(Sender: TObject);
    procedure bGenerarIDsClick(Sender: TObject);
    procedure bMostrarConsolaClick(Sender: TObject);
    procedure bMostrarToastClick(Sender: TObject);
    procedure bResolverPitagorasClick(Sender: TObject);
    procedure bSaludaNombreClick(Sender: TObject);
    procedure bSaludarMDClick(Sender: TObject);
    procedure bSaludarPersonalizadoClick(Sender: TObject);
    procedure bSaludarSMClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure bVerConsolaClick(Sender: TObject);
    procedure CalcularMedia(Sender: TObject);
    procedure CalcularRegresionLineal(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbRutaClick(Sender: TObject);
    procedure seleccionarMenu(Sender: TObject);
  private
    unidadMatematicas, unidadFormularios, unidadGeneradores: TTreeNode;
  public

    procedure crearSeccion(padre: TTreeNode; nombre: string);

    function crearUnidad(nombre: string): TTreeNode;
    function pitagoras(a, b: real): real;

  end;

var
  FUtilidades: TFUtilidades;

implementation

{$R *.lfm}

{ TFUtilidades }

procedure TFUtilidades.FormCreate(Sender: TObject);
begin
  Width := 1024;
  Height := 600;

  Contenido.ShowTabs := False;

  unidadMatematicas := crearUnidad('Matem??ticas');
  crearSeccion(unidadMatematicas, 'C??lculo Media');
  crearSeccion(unidadMatematicas, 'Regresi??n Lineal');

  unidadFormularios := crearUnidad('Formularios');
  crearSeccion(unidadFormularios, 'Saludar con Showmessage');
  crearSeccion(unidadFormularios, 'Saludar con MessageDlg');
  crearSeccion(unidadFormularios, 'Formulario Personalizado para Mensajes');
  crearSeccion(unidadFormularios, 'Toasts');
  crearSeccion(unidadFormularios, 'Consola de Mensajes');
  crearSeccion(unidadFormularios, 'Formulario para ingreso de reales');
  crearSeccion(unidadFormularios, 'Formulario para ingreso de texto');

  unidadGeneradores := crearUnidad('Generadores');
  crearSeccion(unidadGeneradores, 'Generar clave aleatoria');
  crearSeccion(unidadGeneradores, 'Generar IDs');

  // Imprimir la versi??n de la libreria en la barra de estado
  barraEstado.Panels[0].Text := version;
end;

procedure TFUtilidades.lbRutaClick(Sender: TObject);
begin
  lbRuta.Caption := ExtractFilePath(ParamStr(0));
end;

procedure TFUtilidades.seleccionarMenu(Sender: TObject);
var
  nombre: string;
begin
  if tvMenu.Selected <> nil then
  begin
    nombre := tvMenu.Selected.Text;
    // FMensaje.Mostrar('Men??',nombre,tmInfo);

    if nombre = 'C??lculo Media' then
      Contenido.ActivePage := tabCalculoMedia;

    if nombre = 'Regresi??n Lineal' then
      Contenido.ActivePage := tabRegresionLineal;

    if nombre = 'Saludar con Showmessage' then
    begin
      Contenido.ActivePage := tabMensajes;
      bSaludarSMClick(Self);
    end;

    if nombre = 'Saludar con MessageDlg' then
    begin
      Contenido.ActivePage := tabMensajes;
      bSaludarMDClick(Self);
    end;

    if nombre = 'Formulario Personalizado para Mensajes' then
    begin
      Contenido.ActivePage := tabMensajes;
      bSaludarPersonalizadoClick(Self);
    end;

    if nombre = 'Toasts' then
    begin
      Contenido.ActivePage := tabMensajes;
      bMostrarToastClick(Self);
    end;

    if nombre = 'Consola de Mensajes' then
    begin
      Contenido.ActivePage := tabMensajes;
      bMostrarConsolaClick(Self);
    end;

    if nombre = 'Formulario para ingreso de reales' then
    begin
      Contenido.ActivePage := tabMensajes;
      bResolverPitagorasClick(Self);
    end;

    if nombre = 'Formulario para ingreso de texto' then
    begin
      Contenido.ActivePage := tabMensajes;
      bSaludaNombreClick(Self);
    end;

    if nombre = 'Generar clave aleatoria' then
    begin
      Contenido.ActivePage := tabGeneradores;
      bGenerarClaveAleatoriaClick(Self);
    end;

    if nombre = 'Generar IDs' then
    begin
      Contenido.ActivePage := tabGeneradores;
      bGenerarIDsClick(Self);
    end;
  end;
end;

procedure TFUtilidades.CalcularMedia(Sender: TObject);
var
  datos: TStringList;
  media, minimo, maximo, varianza, desvest: real;
  i: integer;
begin
  datos := TStringList.Create;

  datos.DelimitedText := edDatos.Text;

  for i := 1 to datos.Count do
  begin
    seEstadistica.Lines.Add(datos[i - 1]);
  end;

  media := utilidades.calcularMedia(datos);
  seEstadistica.Lines.Add(format('media = %f', [media]));

  minimo := Utilidades.calcularMinimo(datos);
  seEstadistica.Lines.Add(format('m??nimo = %f', [minimo]));

  maximo := Utilidades.calcularMaximo(datos);
  seEstadistica.Lines.Add(format('m??ximo = %f', [maximo]));

  varianza := Utilidades.calcularVarianza(datos);
  seEstadistica.Lines.Add(format('varianza = %f', [varianza]));

  desvest := Utilidades.calcularDesvStandar(datos);
  seEstadistica.Lines.Add(format('desviaci??n est??ndar = %f', [desvest]));
end;

procedure TFUtilidades.bSaludarSMClick(Sender: TObject);
begin
  ShowMessage('Hola, ' + edNombre.Text);
end;

procedure TFUtilidades.Button1Click(Sender: TObject);
begin

end;

procedure TFUtilidades.bVerConsolaClick(Sender: TObject);
begin
  FConsola.Show;
end;

procedure TFUtilidades.bSaludarMDClick(Sender: TObject);
begin
  MessageDlg('Saludar', 'Hola, ' + edNombre.Text, mtInformation, [mbYes], ''); ///Pausa

  MessageDlg('Advertencia', 'Hola, ' + edNombre.Text + ', posible error',
    mtWarning, [mbYes], '');

  MessageDlg('Error', edNombre.Text + ', se ha generado un error', mtError, [mbYes], '');
end;

procedure TFUtilidades.bMostrarToastClick(Sender: TObject);
begin
  FToast.Mostrar('Hola, ' + edNombre.Text + ', bienvenido a este programa');

end;

procedure TFUtilidades.bMostrarConsolaClick(Sender: TObject);
begin
  FConsola.log('bMostrarConsolaClick', 'Estoy usando la consola de mensajes', tcInfo);
  FConsola.log('bMostrarConsolaClick', 'Posible error encontrado',
    tcWarning);
  FConsola.log('bMostrarConsolaClick',
    'Error en el procedimiento', tcError);

  FConsola.log('bMostrarConsolaClick', 'En este cap??tulo creamos un formulario' +
    ' personalizado para crear una consola de mensajes en la cual podamos mostrar' +
    ' diferentes tipos de mensajes, info, warning y error.', tcInfo);
  FConsola.Show;
end;

procedure TFUtilidades.bGenerarClaveAleatoriaClick(Sender: TObject);
var
  clave: string;
begin
  clave := Utilidades.generarClave(12);
  FConsola.log('Generador Claves', clave, tcInfo);
end;

procedure TFUtilidades.bGenerarIDsClick(Sender: TObject);
var
  ID: string;
begin
  ID := Utilidades.generarID;
  FConsola.log('Generador IDs', ID, tcInfo);
end;

procedure TFUtilidades.bResolverPitagorasClick(Sender: TObject);
var
  a, b, c: real;
begin
  a := FReal.obtenerValor('Cateto A');
  b := FReal.obtenerValor('Cateto B');

  c := Sqrt(power(a, 2) + power(b, 2));

  FMensaje.Mostrar('Resultado', Format(
    'El tri??ngulo con catetos a=%f y b=%f tiene una hipotenusa c=%f',
    [a, b, c]), tmInfo);
end;

procedure TFUtilidades.bSaludaNombreClick(Sender: TObject);
var
  nombre: string;
begin
  nombre := FTexto.obtenerTexto('Ingresa tu nombre');
  FMensaje.Mostrar('Saludar', 'Hola, ' + nombre, tmInfo);
end;

procedure TFUtilidades.bSaludarPersonalizadoClick(Sender: TObject);
begin

  // FMensaje.Mostrar('Advertencia', 'Hola, ' + edNombre.Text + ', posible error', tmWarning);

  if FMensaje.Mostrar('Pregunta', '??Esta seguro que su nombre es ' +
    edNombre.Text + '?', tmQuestion) then
  begin
    FMensaje.Mostrar('Saludar', 'Hola, ' + edNombre.Text, tmInfo);
  end
  else
  begin
    FMensaje.Mostrar('Error', edNombre.Text + ', se ha generado un error', tmError);
  end;
end;

procedure TFUtilidades.CalcularRegresionLineal(Sender: TObject);
var
  datosX, datosY: TStringList;
  regLin: TRegresionLineal;
  minX, maxX, y, x: real;
  fs: TFormatSettings;
  i: integer;
begin
  datosX := TStringList.Create;
  datosX.DelimitedText := edDatosX.Text;
  datosY := TStringList.Create;
  datosY.DelimitedText := edDatosY.Text;

  regLin := Utilidades.calcularRegresionLineal(datosX, datosY);

  seRegresion.Lines.Add(Format('??X = %f', [regLin.sumX]));
  seRegresion.Lines.Add(Format('??Y = %f', [regLin.sumY]));
  seRegresion.Lines.Add(Format('??XY = %f', [regLin.sumXY]));
  seRegresion.Lines.Add(Format('??X?? = %f', [regLin.sumX2]));
  seRegresion.Lines.Add(Format('??Y?? = %f', [regLin.sumY2]));
  seRegresion.Lines.Add('');
  seRegresion.Lines.Add(Format('m = %f', [regLin.m]));
  seRegresion.Lines.Add(Format('b = %f', [regLin.b]));
  seRegresion.Lines.Add(Format('y = %fx+%f', [regLin.m, regLin.b]));

  // C??lcular m??ximo y m??nimo de X
  minX := calcularMinimo(datosX);
  maxX := calcularMaximo(datosX);

  grafRegLin.Clear;

  x := minX;
  y := regLin.m * x + regLin.b;
  grafRegLin.AddXY(x, y, '', clYellow);
  seRegresion.Lines.Add(Format('(%f, %f)', [minX, y]));

  x := maxX;
  y := regLin.m * x + regLin.b;
  grafRegLin.AddXY(x, y, '', clYellow);
  seRegresion.Lines.Add(Format('(%f, %f)', [maxX, y]));

  // Gr??ficar los puntos
  grafPuntos.Clear;
  fs.DecimalSeparator := '.';
  for i := 1 to datosX.Count do
  begin
    x := StrToFloat(datosX[i - 1], fs);
    y := StrToFloat(datosY[i - 1], fs);

    grafPuntos.AddXY(x, y, 0.4, '', clBlue);
  end;
end;

procedure TFUtilidades.crearSeccion(padre: TTreeNode; nombre: string);
begin
  with tvMenu.Items.AddChild(padre, nombre) do
  begin
    ImageIndex := 1;
    SelectedIndex := 1;
  end;
end;

function TFUtilidades.crearUnidad(nombre: string): TTreeNode;
begin
  Result := tvMenu.Items.Add(nil, nombre);
  Result.ImageIndex := 0;
  Result.SelectedIndex := 0;
end;

function TFUtilidades.pitagoras(a, b: real): real;
begin
  Result := sqrt(power(a, 2) + power(b, 2));
end;

end.
