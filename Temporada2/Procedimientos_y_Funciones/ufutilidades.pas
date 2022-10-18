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
    bMostrarConsola: TButton;
    bResolverPitagoras: TButton;
    bSaludaNombre: TButton;
    bSaludarPersonalizado: TButton;
    bMostrarToast: TButton;
    bSaludarSM: TButton;
    bSaludarMD: TButton;
    Button1: TButton;
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
    Memo1: TMemo;
    PageControl1: TPageControl;
    Panel1: TPanel;
    bCalcularMedia: TSpeedButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    seRegresion: TSynEdit;
    Splitter1: TSplitter;
    barraEstado: TStatusBar;
    seEstadistica: TSynEdit;
    tabItemsMenu: TTabSheet;
    filtroMenu: TTreeFilterEdit;
    TabSheet1: TTabSheet;
    tabCalculoMedia: TTabSheet;
    tabRegresionLineal: TTabSheet;
    tabResultados: TTabSheet;
    tabGrafica: TTabSheet;
    tabMensajes: TTabSheet;
    tvMenu: TTreeView;
    procedure bGenerarClaveAleatoriaClick(Sender: TObject);
    procedure bMostrarConsolaClick(Sender: TObject);
    procedure bMostrarToastClick(Sender: TObject);
    procedure bResolverPitagorasClick(Sender: TObject);
    procedure bSaludaNombreClick(Sender: TObject);
    procedure bSaludarMDClick(Sender: TObject);
    procedure bSaludarPersonalizadoClick(Sender: TObject);
    procedure bSaludarSMClick(Sender: TObject);
    procedure CalcularMedia(Sender: TObject);
    procedure CalcularRegresionLineal(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbRutaClick(Sender: TObject);
  private
    unidadMatematicas, unidadSistemaOperativo: TTreeNode;
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

  unidadMatematicas := crearUnidad('Matemáticas');
  crearSeccion(unidadMatematicas, 'Teorema de Pitágoras');

  unidadSistemaOperativo := crearUnidad('Sistema Operativo');

  // Imprimir la versión de la libreria en la barra de estado
  barraEstado.Panels[0].Text := version;
end;

procedure TFUtilidades.lbRutaClick(Sender: TObject);
begin
  lbRuta.Caption := ExtractFilePath(ParamStr(0));
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
  seEstadistica.Lines.Add(format('mínimo = %f', [minimo]));

  maximo := Utilidades.calcularMaximo(datos);
  seEstadistica.Lines.Add(format('máximo = %f', [maximo]));

  varianza := Utilidades.calcularVarianza(datos);
  seEstadistica.Lines.Add(format('varianza = %f', [varianza]));

  desvest := Utilidades.calcularDesvStandar(datos);
  seEstadistica.Lines.Add(format('desviación estándar = %f', [desvest]));
end;

procedure TFUtilidades.bSaludarSMClick(Sender: TObject);
begin
  ShowMessage('Hola, ' + edNombre.Text);
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

  FConsola.log('bMostrarConsolaClick', 'En este capítulo creamos un formulario'+
  ' personalizado para crear una consola de mensajes en la cual podamos mostrar'+
  ' diferentes tipos de mensajes, info, warning y error.', tcInfo);
  FConsola.Show;
end;

procedure TFUtilidades.bGenerarClaveAleatoriaClick(Sender: TObject);
begin
    //
end;

procedure TFUtilidades.bResolverPitagorasClick(Sender: TObject);
var
  a, b, c: real;
begin
  a := FReal.obtenerValor('Cateto A');
  b := FReal.obtenerValor('Cateto B');

  c := Sqrt(power(a, 2) + power(b, 2));

  FMensaje.Mostrar('Resultado', Format(
    'El triángulo con catetos a=%f y b=%f tiene una hipotenusa c=%f',
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

  if FMensaje.Mostrar('Pregunta', '¿Esta seguro que su nombre es ' +
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

  seRegresion.Lines.Add(Format('ΣX = %f', [regLin.sumX]));
  seRegresion.Lines.Add(Format('ΣY = %f', [regLin.sumY]));
  seRegresion.Lines.Add(Format('ΣXY = %f', [regLin.sumXY]));
  seRegresion.Lines.Add(Format('ΣX² = %f', [regLin.sumX2]));
  seRegresion.Lines.Add(Format('ΣY² = %f', [regLin.sumY2]));
  seRegresion.Lines.Add('');
  seRegresion.Lines.Add(Format('m = %f', [regLin.m]));
  seRegresion.Lines.Add(Format('b = %f', [regLin.b]));
  seRegresion.Lines.Add(Format('y = %fx+%f', [regLin.m, regLin.b]));

  // Cálcular máximo y mínimo de X
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

  // Gráficar los puntos
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
