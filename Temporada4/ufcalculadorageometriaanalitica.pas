unit uFCalculadoraGeometriaAnalitica;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  Buttons, uTGAPunto, uTGARecta, uTGAMedidas, uTGATriangulo, uFAcerca, SynEdit;

type

  { TFCalculadoraGeometria }

  TFCalculadoraGeometria = class(TForm)
    MenuPrincipal: TPageControl;
    Contenido: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    sbAcerca: TSpeedButton;
    sbTriangulo: TSpeedButton;
    sbProbarPuntos: TSpeedButton;
    sbProbarRectas: TSpeedButton;
    sbMedidas: TSpeedButton;
    seConsola: TSynEdit;
    TabArchivo: TTabSheet;
    TabConsola: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure sbAcercaClick(Sender: TObject);
    procedure sbMedidasClick(Sender: TObject);
    procedure sbProbarPuntosClick(Sender: TObject);
    procedure sbProbarRectasClick(Sender: TObject);
    procedure sbTrianguloClick(Sender: TObject);
  private

  public
    procedure log(msg: string);
    procedure limpiarConsola;
  end;

var
  FCalculadoraGeometria: TFCalculadoraGeometria;

implementation

{$R *.lfm}

{ TFCalculadoraGeometria }

procedure TFCalculadoraGeometria.FormCreate(Sender: TObject);
begin
  limpiarConsola;
  log('=== Bienvenidos a la calculadora de Geometría Analítica ===');
end;

procedure TFCalculadoraGeometria.sbAcercaClick(Sender: TObject);
var
  foto, nombre, correo, biografia: string;
begin
  FAcerca.discoDuro('100MB');
  FAcerca.memoriaRam('20MB');
  FAcerca.sistemaOperativo('Windows 10');
  FAcerca.pantalla('1024px * 600px');

  foto := 'Imagenes\Autores\autor1.png';
  nombre := 'Ian Esteban Rincón Tavera';
  correo := 'ierincont@gmail.com';
  biografia := 'Estudiante de Licenciatura en Matemáticas';
  FAcerca.agregarAutor(foto, nombre, correo, biografia);

  foto := 'Imagenes\Autores\autor1.png';
  nombre := 'Joel Santiago Rincón Tavera';
  correo := 'jsrinconr@gmail.com';
  biografia := 'Estudiante de Licenciatura en Matemáticas';
  FAcerca.agregarAutor(foto, nombre, correo, biografia);

  foto := 'Imagenes\Autores\autor1.png';
  nombre := 'Julián Andrés Rincón Penagos';
  correo := 'jarincon1989@gmail.com';
  biografia := 'Licenciado en Matemáticas y Magister en Ciencias de la' +
    ' Educación de la Universidad del Quindío';
  FAcerca.agregarAutor(foto, nombre, correo, biografia);

  FAcerca.acerca('Esta aplicación es un ejemplo de cómo usar la ' +
    'programación orientada a objetos para resolver problemas de ' +
    'reutilización de código. Contiene clases para el cálculo básico ' +
    'de puntos, rectas y triángulos. Por otra parte se muestra cómo ' +
    'crear un objeto de tipo visual para mostrar la información de un autor.');

  FAcerca.ShowModal;
end;

procedure TFCalculadoraGeometria.sbMedidasClick(Sender: TObject);
var
  Medidas: TGAMedidas;
begin
  Medidas := TGAMedidas.Create('Medidas');

  Medidas.A.asignar(1, 2);
  log(Medidas.A.toString);
  Medidas.B.asignar(6, 4);
  log(Medidas.B.toString);
  log('Distancia = ' + FloatToStr(Medidas.distancia));
  log(Medidas.puntoMedio.toString);

  log('');

  Medidas.A.Nombre := 'X';
  Medidas.A.asignar(-1, -2);
  log(Medidas.A.toString);
  Medidas.B.Nombre := 'Y';
  Medidas.B.asignar(10, 6);
  log(Medidas.B.toString);
  log('Distancia = ' + FloatToStr(Medidas.distancia));
  log(Medidas.puntoMedio.toString);
end;

procedure TFCalculadoraGeometria.sbProbarPuntosClick(Sender: TObject);
var
  A, B, C: TGAPunto;
begin
  A := TGAPunto.Create;
  A.Nombre := 'A';
  A.asignar(5.6, 6.7);
  log(A.toString);

  B := TGAPunto.Create;
  B.Nombre := 'B1';
  B.asignar(10, sqrt(10));
  log(B.toString);

  C := TGAPunto.Create;
  C.Nombre := 'Circ';
  C.asignar(10, sqrt(10));
  log(C.toString);
end;

procedure TFCalculadoraGeometria.sbProbarRectasClick(Sender: TObject);
var
  L1: TGARecta;
begin
  L1 := TGARecta.Create('L1');
  L1.A.asignar(1, 1);
  L1.B.asignar(4, 8);
  log(L1.toString);
  log(L1.toString(True));

  log(L1.ordenadaOrigen);
  log(L1.puntoPendiente);
  log(L1.general);
end;

procedure TFCalculadoraGeometria.sbTrianguloClick(Sender: TObject);
var
  T1: TGATriangulo;
begin
  T1 := TGATriangulo.Create;

  T1.A.asignar(2, 1);
  log(T1.A.toString);

  T1.B.asignar(10, 3);
  log(T1.B.toString);

  T1.C.asignar(5, 12);
  log(T1.C.toString);

  log(format('Perímetro = %f', [T1.perimetro]));
  log(format('Área = %f', [T1.area]));
end;

procedure TFCalculadoraGeometria.log(msg: string);
begin
  seConsola.Lines.Add(msg);
end;

procedure TFCalculadoraGeometria.limpiarConsola;
begin
  seConsola.Lines.Clear;
end;

end.
