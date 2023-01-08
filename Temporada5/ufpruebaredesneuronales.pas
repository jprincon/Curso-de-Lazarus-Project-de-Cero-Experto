unit uFPruebaRedesNeuronales;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Menus,
  uTNumberList, uTProductPoint, uTActivactionFunction, uTNeuron, uTLayer,
  uTNeuronalNetwork, uTMatrix, uFFuncionActivacion, SynEdit, SynHighlighterAny,
  TAGraph, TASeries;

type

  { TFPruebaRedesNeuronales }

  TFPruebaRedesNeuronales = class(TForm)
    Grafica: TChart;
    graficaError: TLineSeries;
    menuBorrar: TMenuItem;
    MenuPrincipal: TPageControl;
    Consola: TPageControl;
    opcionesConsola: TPopupMenu;
    ContenidoGrafica: TPageControl;
    seConsola: TSynEdit;
    SynAnySyn1: TSynAnySyn;
    TabMenuPrincipal: TTabSheet;
    TabConsola: TTabSheet;
    TabGrafica: TTabSheet;
    tvMenu: TTreeView;

    procedure FormCreate(Sender: TObject);

    procedure seleccionarOpcionMenuConsola(Sender: TObject);
    procedure tvMenuDblClick(Sender: TObject);
  private

  public
    procedure log(msg: string);
    procedure agregarMenu(nombre: string);
    procedure limpiarConsola;

    procedure probar_ListaNumeros;
    procedure probar_ProductoEscalar;
    procedure probar_FuncionesActivacion;
    procedure probar_Neurona;
    procedure probar_Capa;
    procedure probar_RedNeuronal;
    procedure probar_Matriz;
    procedure probar_EntrenamientoPerceptron;
    procedure probar_ReconocimientoNumeros;
    procedure probar_ColorFondoFuente;
  end;

const

  MENU_LISTA_DE_NUMEROS = 'Lista de Números';
  MENU_PRODUCTO_ESCALAR = 'Producto Escalar/Punto';
  MENU_FUNCIONES_ACTIVACION = 'Funciones de Activación';
  MENU_NEURONA = 'Neurona';
  MENU_CAPA = 'Capa';
  MENU_RED_NEURONAL = 'Red Neuronal';
  MENU_MATRIZ = 'Matriz';
  MENU_ENTRENAMIENTO_PERCENTRON = 'Entrenamiento Perceptron';
  MENU_RECONOCIMIENTO_NUMEROS = 'Reconocimiento Números';
  MENU_COLOR_FONDO_FUENTE = 'Color Fondo VS Fuente';

var
  FPruebaRedesNeuronales: TFPruebaRedesNeuronales;

implementation

{$R *.lfm}

{ TFPruebaRedesNeuronales }

procedure TFPruebaRedesNeuronales.seleccionarOpcionMenuConsola(Sender: TObject);
begin
  if Sender = menuBorrar then seConsola.Lines.Clear;
end;

procedure TFPruebaRedesNeuronales.tvMenuDblClick(Sender: TObject);
var
  nombre: string;
begin
  if tvMenu.Selected <> nil then
  begin

    nombre := tvMenu.Selected.Text;

    if nombre = MENU_LISTA_DE_NUMEROS then
    begin
      probar_ListaNumeros;
      exit;
    end;

    if nombre = MENU_PRODUCTO_ESCALAR then
    begin
      probar_ProductoEscalar;
      exit;
    end;

    if nombre = MENU_FUNCIONES_ACTIVACION then
    begin
      probar_FuncionesActivacion;
      exit;
    end;

    if nombre = MENU_NEURONA then
    begin
      probar_Neurona;
      exit;
    end;

    if nombre = MENU_CAPA then
    begin
      probar_Capa;
      exit;
    end;

    if nombre = MENU_RED_NEURONAL then
    begin
      probar_RedNeuronal;
      exit;
    end;

    if nombre = MENU_MATRIZ then
    begin
      probar_Matriz;
      exit;
    end;

    if nombre = MENU_ENTRENAMIENTO_PERCENTRON then
    begin
      probar_EntrenamientoPerceptron;
      exit;
    end;

    if nombre = MENU_RECONOCIMIENTO_NUMEROS then
    begin
      probar_ReconocimientoNumeros;
      exit;
    end;

    if nombre = MENU_COLOR_FONDO_FUENTE then
    begin
      probar_ColorFondoFuente;
      exit;
    end;
  end;
end;

procedure TFPruebaRedesNeuronales.FormCreate(Sender: TObject);
begin
  agregarMenu(MENU_LISTA_DE_NUMEROS);
  agregarMenu(MENU_PRODUCTO_ESCALAR);
  agregarMenu(MENU_FUNCIONES_ACTIVACION);
  agregarMenu(MENU_NEURONA);
  agregarMenu(MENU_CAPA);
  agregarMenu(MENU_RED_NEURONAL);
  agregarMenu(MENU_MATRIZ);
  agregarMenu(MENU_ENTRENAMIENTO_PERCENTRON);
  agregarMenu(MENU_RECONOCIMIENTO_NUMEROS);
  agregarMenu(MENU_COLOR_FONDO_FUENTE);
end;

procedure TFPruebaRedesNeuronales.log(msg: string);
begin
  seConsola.Lines.Add(msg);
end;

procedure TFPruebaRedesNeuronales.agregarMenu(nombre: string);
begin
  tvMenu.Items.Add(nil, nombre);
end;

procedure TFPruebaRedesNeuronales.limpiarConsola;
begin
  seConsola.Lines.Clear;
end;

procedure TFPruebaRedesNeuronales.probar_ListaNumeros;
var
  listaNumeros: TNumberList;
begin
  limpiarConsola;

  listaNumeros := TNumberList.Create;
  listaNumeros.viewOnLog := True;
  listaNumeros.Console := seConsola;

  listaNumeros.add(1);
  listaNumeros.add(2);
  listaNumeros.add(3);

  listaNumeros.addList('4,5,6,7,8,9,10', ',');
  listaNumeros.addList('20;30;40;50;60;70;80;90;100', ';');

  // log(listaNumeros.getList);
  listaNumeros.viewListOnLog;

  listaNumeros.saveToFile('listNumeros.txt');
end;

procedure TFPruebaRedesNeuronales.probar_ProductoEscalar;
var
  productoEscalar: TProductPoint;
  listA, listB, listC, listD: TNumberList;
  pp: real;
begin
  limpiarConsola;

  productoEscalar := TProductPoint.Create;
  productoEscalar.viewOnLog := True;
  productoEscalar.Console := seConsola;

  // Lista de Entradas
  listA := TNumberList.Create;
  listA.addList('3, 5, 1.8', ',');

  // Pesos de la Neurona 1
  listB := TNumberList.Create;
  listB.addList('0.5, 1.2, -0.6', ',');

  // Cálculo de la neurona 1
  log(listA.getList);
  log(listB.getList);
  pp := productoEscalar.calculate(listA, listB) + 1.9;
  log(format('pp = %f', [pp]));

  // Pesos de la Neurona 2
  listC := TNumberList.Create;
  listC.addList('0.4, 0.8, 1.3', ',');

  // Calculo de la neurona 2
  log(listA.getList);
  log(listC.getList);
  pp := productoEscalar.calculate(listA, listC) - 6.2;
  log(format('pp = %f', [pp]));

  // Pesos de la Neurona 3
  listD := TNumberList.Create;
  listD.addList('1.4, -1.8, -2.6', ',');

  // Calculo de la neurona 3
  log(listA.getList);
  log(listC.getList);
  pp := productoEscalar.calculate(listA, listD) + 7.9;
  log(format('pp = %f', [pp]));

end;

procedure TFPruebaRedesNeuronales.probar_FuncionesActivacion;
var
  funcionActivacion: TActivactionFunction;
begin
  funcionActivacion := TActivactionFunction.Create;
  funcionActivacion.GraphActivationFunction :=
    FGraficaFuncionActivacion.FuncionActivacion;
  funcionActivacion.viewOnLog := True;
  funcionActivacion.Console := seConsola;

  // Función Escalón
  {funcionActivacion.TypeActivactionFunction := tafStep;
  FGraficaFuncionActivacion.borrarGrafica;
  x := li;
  while x <= ls do
  begin
    y := funcionActivacion.calculate(x);
    FGraficaFuncionActivacion.agregar(x, y);
    x := x + dx;
  end;
  FGraficaFuncionActivacion.ShowModal; // Pausa }

  funcionActivacion.TypeActivactionFunction := tafStep;
  funcionActivacion.graph(-5, 5, 0.1);
  FGraficaFuncionActivacion.ShowModal;

  funcionActivacion.TypeActivactionFunction := tafSimetricalStep;
  funcionActivacion.graph(-5, 5, 0.1);
  FGraficaFuncionActivacion.ShowModal;

  funcionActivacion.TypeActivactionFunction := tafReLU;
  funcionActivacion.graph(-5, 5, 0.1);
  FGraficaFuncionActivacion.ShowModal;

  funcionActivacion.TypeActivactionFunction := tafSimetricalReLU;
  funcionActivacion.graph(-5, 5, 0.1);
  FGraficaFuncionActivacion.ShowModal;

  funcionActivacion.TypeActivactionFunction := tafLinear;
  funcionActivacion.graph(-5, 5, 0.1);
  FGraficaFuncionActivacion.ShowModal;

  funcionActivacion.TypeActivactionFunction := tafSigmoide;
  funcionActivacion.graph(-5, 5, 0.1);
  FGraficaFuncionActivacion.ShowModal;

  funcionActivacion.TypeActivactionFunction := tafTanH;
  funcionActivacion.graph(-5, 5, 0.1);
  FGraficaFuncionActivacion.ShowModal;

  funcionActivacion.TypeActivactionFunction := tafArcTan;
  funcionActivacion.graph(-50, 50, 0.1);
  FGraficaFuncionActivacion.ShowModal;
end;

procedure TFPruebaRedesNeuronales.probar_Neurona;
var
  Neurona: TNeuron;
  salida: real;
begin
  limpiarConsola;

  Neurona := TNeuron.Create;
  Neurona.Inputs.addList('3, 5, 1.8', ',');
  Neurona.viewOnLog := True;
  Neurona.Console := seConsola;
  Neurona.ProductPoint.viewOnLog := True;
  Neurona.ProductPoint.Console := seConsola;

  Neurona.Weights.Clear;
  Neurona.Weights.addList('0.5, 1.2, -0.6', ',');
  Neurona.polarization := 1.9;
  Neurona.ActivactionFunction.TypeActivactionFunction := tafSigmoide;
  salida := Neurona.propagation;

  Neurona.Weights.Clear;
  Neurona.Weights.addList('0.4, 0.8, 1.3', ',');
  Neurona.polarization := -6.2;
  Neurona.ActivactionFunction.TypeActivactionFunction := tafSigmoide;
  salida := Neurona.propagation;

  Neurona.Weights.Clear;
  Neurona.Weights.addList('1.4, -1.8, -2.6', ',');
  Neurona.polarization := 7.9;
  Neurona.ActivactionFunction.TypeActivactionFunction := tafSigmoide;
  salida := Neurona.propagation;
end;

procedure TFPruebaRedesNeuronales.probar_Capa;
var
  Capa: TLayer;
begin
  limpiarConsola;

  Capa := TLayer.Create;
  Capa.viewOnLog := True;
  Capa.Console := seConsola;

  with Capa.addNeuron do
  begin
    polarization := 1.9;
    Weights.addList('0.5, 1.2, -0.6', ',');
    ProductPoint.viewOnLog := True;
    ProductPoint.Console := seConsola;
  end;

  with Capa.addNeuron do
  begin
    polarization := -6.2;
    Weights.addList('0.4, 0.8, 1.3', ',');
    ProductPoint.viewOnLog := True;
    ProductPoint.Console := seConsola;
  end;

  with Capa.addNeuron do
  begin
    polarization := 7.9;
    Weights.addList('1.4, -1.8, -2.6', ',');
    ProductPoint.viewOnLog := True;
    ProductPoint.Console := seConsola;
  end;

  Capa.setInputs('3, 5, 1.8', ',');
  Capa.ActivactionFunction.TypeActivactionFunction := tafSigmoide;

  Capa.propagation;

  {log(Capa.getNeuron(0).getPropagationData);
  log(Capa.getNeuron(1).getPropagationData);
  log(Capa.getNeuron(2).getPropagationData);}

  log(Capa.Outputs.getList(','));
end;

procedure TFPruebaRedesNeuronales.probar_RedNeuronal;
var
  RedNeuronal: TNeuronalNetwork;
  Capa: TLayer;
  i, j: integer;
begin
  limpiarConsola;

  RedNeuronal := TNeuronalNetwork.Create;
  RedNeuronal.viewOnLog := True;
  RedNeuronal.Console := seConsola;

  {Capa 1}
  Capa := RedNeuronal.addLayer;
  Capa.viewOnLog := True;
  Capa.Console := seConsola;

  with Capa.addNeuron do
  begin
    polarization := 1.9;
    Weights.addList('0.5, 1.2, -0.6', ',');
  end;

  with Capa.addNeuron do
  begin
    polarization := -6.2;
    Weights.addList('0.4, 0.8, 1.3', ',');
  end;

  with Capa.addNeuron do
  begin
    polarization := 7.9;
    Weights.addList('1.4, -1.8, -2.6', ',');
  end;

  Capa.ActivactionFunction.TypeActivactionFunction := tafSigmoide;

  {Capa 2}
  Capa := RedNeuronal.addLayer;
  Capa.viewOnLog := True;
  Capa.Console := seConsola;

  with Capa.addNeuron do
  begin
    polarization := 3.5;
    Weights.addList('0.2, 1.7, -0.1', ',');
  end;

  with Capa.addNeuron do
  begin
    polarization := -1.2;
    Weights.addList('1.3, -0.9, -8.4', ',');
  end;

  Capa.ActivactionFunction.TypeActivactionFunction := tafSigmoide;

  {Capa 3}

  Capa := RedNeuronal.addLayer;
  Capa.viewOnLog := True;
  Capa.Console := seConsola;

  with Capa.addNeuron do
  begin
    polarization := 1.3;
    Weights.addList('2.3, -2.76', ',');
  end;

  Capa.ActivactionFunction.TypeActivactionFunction := tafLinear;

  {Pasar la entrada a la capa}
  RedNeuronal.setInputs('3, 5, 1.8', ',');
  RedNeuronal.propagation;

  {for i := 0 to RedNeuronal.layerCount - 1 do
  begin
    log('Capa ' + IntToStr(i + 1));
    for j := 0 to RedNeuronal.getLayer(i).neuronCount - 1 do
    begin
      log('Neurona ' + IntToStr(j) + ' => ' + RedNeuronal.getLayer(
        i).getNeuron(j).getPropagationData);
    end;

    log('');
  end;}

  // log(RedNeuronal.Outputs.getList);

end;

procedure TFPruebaRedesNeuronales.probar_Matriz;
var
  Matriz: TMatrix;
begin
  limpiarConsola;

  Matriz := TMatrix.Create;
  Matriz.viewOnLog := True;
  Matriz.Console := seConsola;
  Matriz.loadFromCSVFile('Ejemplos\ejemplo_Clasificacion_Puntos.csv');
  Matriz.printOnConsole;

  log(format('Dimensión de la Matriz %dx%d', [Matriz.rowCount, Matriz.colCount]));
end;

procedure TFPruebaRedesNeuronales.probar_EntrenamientoPerceptron;
var
  Neurona: TNeuron;
begin
  limpiarConsola;
  graficaError.Clear;

  Neurona := TNeuron.Create;
  Neurona.viewOnLog := True;
  Neurona.Console := seConsola;
  Neurona.update;
  Neurona.errorGraph := graficaError;

  // Cargar los ejemplos
  Neurona.Samples.loadFromCSVFile('Ejemplos\ejemplo_Clasificacion_Puntos.csv');
  Neurona.Samples.printOnConsole;
  Neurona.ActivactionFunction.TypeActivactionFunction := tafTanH;
  Neurona.train(300, 0.1);
  Neurona.Weights.viewListOnLog;
end;

procedure TFPruebaRedesNeuronales.probar_ReconocimientoNumeros;
var
  Neurona: TNeuron;
begin
  limpiarConsola;
  graficaError.Clear;

  Neurona := TNeuron.Create;
  Neurona.viewOnLog := True;
  Neurona.Console := seConsola;
  Neurona.update;
  Neurona.errorGraph := graficaError;

  // Cargar los ejemplos
  Neurona.Samples.loadFromCSVFile('Ejemplos\Display_Siete_Segmentos_Par_Impar.csv');
  Neurona.Samples.printOnConsole;
  Neurona.ActivactionFunction.TypeActivactionFunction := tafReLU;
  Neurona.train(100, 0.1);
  Neurona.Weights.viewListOnLog;
end;

procedure TFPruebaRedesNeuronales.probar_ColorFondoFuente;
var
  Neurona: TNeuron;
begin
  limpiarConsola;
  graficaError.Clear;

  Neurona := TNeuron.Create;
  Neurona.viewOnLog := True;
  Neurona.Console := seConsola;
  Neurona.update;
  Neurona.errorGraph := graficaError;

  // Cargar los ejemplos
  Neurona.Samples.loadFromCSVFile('Ejemplos\ejemplos_Fondo_Texto.csv');
  Neurona.Samples.printOnConsole;
  Neurona.ActivactionFunction.TypeActivactionFunction := tafSimetricalStep;
  Neurona.train(7, 0.1);
  Neurona.Weights.viewListOnLog;
end;

end.
