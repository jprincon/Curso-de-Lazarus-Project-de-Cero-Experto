unit uFEstructuraCurso;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls;

type

  { TFTemporadas }

  TFTemporadas = class(TForm)
    ImageList1: TImageList;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    tabCapitulos: TTabSheet;
    tabTemporadas: TTabSheet;
    tvTemporadas: TTreeView;
    tvCapitulos: TTreeView;
    procedure FormCreate(Sender: TObject);
    procedure seleccionarTemporada(Sender: TObject);
  private

  public
    procedure agregarTemporada(temporada: string);
    procedure agregarCapitulo(capitulo: string);

    procedure fundamentosProgramacion;
    procedure procedimientosFunciones;
    procedure AnalisisEstadistico;
    procedure programacionOrientadaObjetos;
    procedure baseDatos;
    procedure aplicacionRedesNeuronales;
    procedure RazonamientoMaquina;
  end;

var
  FTemporadas: TFTemporadas;

implementation

{$R *.lfm}

{ TFTemporadas }

procedure TFTemporadas.FormCreate(Sender: TObject);
begin
  Width := 1024;
  Height := 600;

  agregarTemporada('Fundamentos de Programación');
  agregarTemporada('Procedimientos y Funciones');
  agregarTemporada('Tratamiento de Archivos y Estadística');
  agregarTemporada('Programación Orientada a Objetos');
  agregarTemporada('Aplicación de Redes Neuronales');
  agregarTemporada('Base de Datos');
  agregarTemporada('Razonamiento de Máquina');
  agregarTemporada('Exportando Latex/Lyx');

end;

procedure TFTemporadas.seleccionarTemporada(Sender: TObject);
begin
  if tvTemporadas.Selected <> nil then
  begin
    if tvTemporadas.Selected.Text.IndexOf('Fundamentos de Programación') >= 0 then
      fundamentosProgramacion;

    if tvTemporadas.Selected.Text.IndexOf('Procedimientos y Funciones') >= 0 then
      procedimientosFunciones;

    if tvTemporadas.Selected.Text.IndexOf(
      'Tratamiento de Archivos y Estadística') >= 0 then
      AnalisisEstadistico;

    if tvTemporadas.Selected.Text.IndexOf('Programación Orientada a Objetos') >= 0 then
      programacionOrientadaObjetos;

    if tvTemporadas.Selected.Text.IndexOf('Aplicación de Redes Neuronales') >= 0 then
      aplicacionRedesNeuronales;

    if tvTemporadas.Selected.Text.IndexOf('Base de Datos') >= 0 then
      baseDatos;

    if tvTemporadas.Selected.Text.IndexOf('Razonamiento de Máquina') >= 0 then
      RazonamientoMaquina;

    tabCapitulos.Caption := tvTemporadas.Selected.Text;
  end;
end;

procedure TFTemporadas.agregarTemporada(temporada: string);
var
  n: integer;
begin
  n := tvTemporadas.Items.Count + 1;
  with tvTemporadas.Items.Add(nil, 'Temporada ' + IntToStr(n) + ': ' + temporada) do
  begin
    ImageIndex := 0;
    SelectedIndex := 0;
  end;
end;

procedure TFTemporadas.agregarCapitulo(capitulo: string);
var
  n: integer;
begin
  n := tvCapitulos.Items.Count + 1;
  with tvCapitulos.Items.Add(nil, 'Capítulo ' + IntToStr(n) + ': ' + capitulo) do
  begin
    ImageIndex := 1;
    SelectedIndex := 1;
  end;
end;

procedure TFTemporadas.fundamentosProgramacion;
begin
  tvCapitulos.Items.Clear;

  agregarCapitulo('Instalación del IDE');
  agregarCapitulo('Configuración del entorno de desarrollo');
  agregarCapitulo('Cómo guardar correctamente un programa');
  agregarCapitulo('Tipos de programas');
  agregarCapitulo('Diseño de formularios');
  agregarCapitulo('Variables de tipo integer');
  agregarCapitulo('Variables de tipo real');
  agregarCapitulo('Conversión de segundos');
  agregarCapitulo('Conversión de grados a radianes');
  agregarCapitulo('Conversión de temperaturas');
  agregarCapitulo('Operaciones con puntos en el plano');
  agregarCapitulo('Suma de los dígitos de un número de cuatro cifras');
  agregarCapitulo('Relaciones de las tangentes');
  agregarCapitulo('Sistema de ecuaciones de 2x2');
  agregarCapitulo('Variable personalizada - Determinante 3x3');
  agregarCapitulo('Circunferencia que pasa por tres puntos');
  agregarCapitulo('Crendo menús en la aplicación');
  agregarCapitulo('Determinar cuál de dos números es mayor');
  agregarCapitulo('Número par e impar');
  agregarCapitulo('Ecuación general de segundo grado');
  agregarCapitulo('Tablas de multiplicar');
  agregarCapitulo('Factorial de un número');
  agregarCapitulo('Generar claves aleatorias');
  agregarCapitulo('Calcular los primeros primos');
  agregarCapitulo('Ordenar lista de números');
  agregarCapitulo('Cálculos estadísticos');
  agregarCapitulo('Tabulación de una función');
  agregarCapitulo('Generar números aleatorios y parar');
  agregarCapitulo('Generar aleatorios sin repetición');
  agregarCapitulo('Rebotes de una pelota');
  agregarCapitulo('Cronómetro');
  agregarCapitulo('Simulación de código');
end;

procedure TFTemporadas.procedimientosFunciones;
begin
  tvCapitulos.Items.Clear;

  agregarCapitulo('Aplicación de Utilidades');
  agregarCapitulo('¿Que es un procedimiento?');
  agregarCapitulo('¿Cómo definir e implementar una procedimiento?');
  agregarCapitulo('¿Qué es una función?');
  agregarCapitulo('¿Cómo definir e implementar una función?');
  agregarCapitulo('Unidad de Utilidades');
  agregarCapitulo('Calcular la media, mínimo, máximo, varianza y desviación estándar de una lista de datos');
  agregarCapitulo('Calcular la regresión lineal');
  agregarCapitulo('Generar Claves Aleatorias');
  agregarCapitulo('Generar Identificadores Aleatorios');
  agregarCapitulo('Verificar la extensión de un archivo');
  agregarCapitulo('Generador de nombres');
  agregarCapitulo('Generador de correos dado el nombre');
  agregarCapitulo('Generador de Teléfonos');
  agregarCapitulo('Generador de número de documento');
  agregarCapitulo('Generador de CSV con datos de usuarios');
  agregarCapitulo('Generador de INI con datos de usuarios');
  agregarCapitulo('Convertir a MD5');
  agregarCapitulo('Mensajes Showmessage');
  agregarCapitulo('Mensajes con MessageDlg');
  agregarCapitulo('Mensajes con Formulario Personalizado');
  agregarCapitulo('Mensaje de Confirmación');
  agregarCapitulo('Mensaje Toast');
  agregarCapitulo('Formulario para ingresar un real');
  agregarCapitulo('Formulario para ingresar un texto');
  agregarCapitulo('Consola de Mensajes');
  agregarCapitulo('Formulario para el Acerca de la aplicación');
end;

procedure TFTemporadas.AnalisisEstadistico;
begin
  tvCapitulos.Items.Clear;

  agregarCapitulo('Aplicación de Análisis Estadístico');
  agregarCapitulo('Crear rejilla de datos');
  agregarCapitulo('Guardar y leer el archivo');
  agregarCapitulo('Exportar a CSV');
  agregarCapitulo('Importar desde CSV');
  agregarCapitulo('Exportar a INI');
  agregarCapitulo('Importar desde INI');
  agregarCapitulo('Calcular la Media, el Máximo, Mínimo, Varianza, Desviación Estándar');
  agregarCapitulo('Calcular Regresión Lineal');
  agregarCapitulo('Diagrama de Barras');
  agregarCapitulo('Diagrama de Áreas');
  agregarCapitulo('Diagrama Lineal');
  agregarCapitulo('Diagrama de Pastel');
  agregarCapitulo('Exportar Gráficas');
  agregarCapitulo('Acerca de la Aplicación');
end;

procedure TFTemporadas.programacionOrientadaObjetos;
begin
  tvCapitulos.Items.Clear;

  agregarCapitulo('Calculadora de Geometría Analítica');
  agregarCapitulo('¿Qué es una clase?');
  agregarCapitulo('¿Qué es un objeto?');
  agregarCapitulo('Variables Punto, Recta, Circunferencia, Parábola, Elipse e Hipérbola (Class)');
  agregarCapitulo('Distancia entre dos puntos: Real');
  agregarCapitulo('Punto medio: Punto');
  agregarCapitulo('Área de un triángulo: Real');
  agregarCapitulo('Perímetro de un triángulo: Real');
  agregarCapitulo('Pendiente de una recta: Real');
  agregarCapitulo('Ángulo entre dos rectas: Real');
  agregarCapitulo('Recta Perpendicular: Recta');
  agregarCapitulo('Corte entre dos rectas: Punto');
  agregarCapitulo('Baricentro: Punto');
  agregarCapitulo('Ortocentro: Punto');
  agregarCapitulo('Circuncentro: Punto');
  agregarCapitulo('Circunferencia que pasa por tres puntos: Circunferencia');
  agregarCapitulo('Parábola que pasa por tres puntos: Parábola');
  agregarCapitulo('Puntos de Corte entre dos circunferencias: Matriz Puntos');
  agregarCapitulo('Cortes de una circunferencia con una recta');
end;

procedure TFTemporadas.baseDatos;
begin
  tvCapitulos.Items.Clear;

  agregarCapitulo('Aplicación de Tienda Local');
  agregarCapitulo('Módulo de Datos');
  agregarCapitulo('Registro de Usuarios e Inicio de Sesión');
  agregarCapitulo('¿Qué es un CRUD?');
  agregarCapitulo('CRUD para Productos');
  agregarCapitulo('CRUD para clientes');
  agregarCapitulo('CRUD para ventas');
  agregarCapitulo('Estadísticas de Ventas');
  agregarCapitulo('Estadísticas de Clientes');
  agregarCapitulo('Inventario de la Tienda');
  agregarCapitulo('Reportes en HTML');
  agregarCapitulo('Configuración final de la aplicación');
end;

procedure TFTemporadas.aplicacionRedesNeuronales;
begin
  tvCapitulos.Items.Clear;

  agregarCapitulo('Aplicación de Redes Neuronales');
  agregarCapitulo('Clase (Lista de Números)');
  agregarCapitulo('Clase (Funciones de Activación)');
  agregarCapitulo('Clase (Neurona)');
  agregarCapitulo('Clase (Capa)');
  agregarCapitulo('Clase (Red Neuronal)');
  agregarCapitulo('Perceptron Simple');
  agregarCapitulo('Algoritmo de Entrenamiento');
  agregarCapitulo('Perceptron Multicapa');
  agregarCapitulo('Clasificación de Pares e Impares');
  agregarCapitulo('Problema del Color de Fondo');
  agregarCapitulo('Clasificación de Puntos en R2');
  agregarCapitulo('Clasificación de Puntos en R3');
  agregarCapitulo('Generador de datos de entrenamiento para funciones en R2');
  agregarCapitulo('Ajuste de Funciones');
  agregarCapitulo('Generador de datos de entrenamiento para superficies en R3');
  agregarCapitulo('Ajuste de Superficies');
  agregarCapitulo('Configuración Final de la Aplicación');
end;

procedure TFTemporadas.RazonamientoMaquina;
begin
  tvCapitulos.Items.Clear;

  agregarCapitulo('Razonamiento de Máquina');
end;

end.
