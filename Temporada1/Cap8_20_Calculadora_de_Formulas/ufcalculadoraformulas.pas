unit uFCalculadoraFormulas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls, Menus, Math;

type

  { TFCalculadoraFormulas }

  TMatriz = record
    m11, m12, m13: real;
    m21, m22, m23: real;
    m31, m32, m33: real;
  end;

  TFCalculadoraFormulas = class(TForm)
    bCalcRelTangente: TButton;
    bCalcularSolucion: TButton;
    bCalcularDeterminante: TButton;
    bCalcularTriangulo1: TButton;
    bConvertirSegundos: TButton;
    bSumar: TButton;
    bConvToRadianes: TButton;
    bConvToGrados: TButton;
    bCalcularTriangulo: TButton;
    Contenido: TPageControl;
    edAlfa: TEdit;
    edBeta: TEdit;
    edCoefX2: TEdit;
    edCoefY2: TEdit;
    edDist: TEdit;
    edM11: TEdit;
    edM13: TEdit;
    edM12: TEdit;
    edM21: TEdit;
    edM23: TEdit;
    edM22: TEdit;
    edM31: TEdit;
    edM33: TEdit;
    edM32: TEdit;
    edSegundos: TEdit;
    edGrados: TEdit;
    edRadianes: TEdit;
    edNumero: TEdit;
    edCoefX1: TEdit;
    edCoefY1: TEdit;
    edTerm1: TEdit;
    edTerm2: TEdit;
    edCx1: TEdit;
    edCx2: TEdit;
    edCx3: TEdit;
    edY1: TEdit;
    edX1: TEdit;
    edY2: TEdit;
    edX2: TEdit;
    edY3: TEdit;
    edX3: TEdit;
    edCy1: TEdit;
    edCy2: TEdit;
    edCy3: TEdit;
    gbPtA1: TGroupBox;
    gbPtA2: TGroupBox;
    gbPtA3: TGroupBox;
    gbPtB1: TGroupBox;
    gbPtC1: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    gbCelcius: TGroupBox;
    gbKelvin: TGroupBox;
    gbFahrenheit: TGroupBox;
    gbPtA: TGroupBox;
    gbPtB: TGroupBox;
    gbPtC: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    menuVerLateral: TMenuItem;
    mLogCircunferencia1: TMemo;
    Separator1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    mLogCircunferencia: TMemo;
    mLogSolSisEcu: TMemo;
    mLogDeterminante: TMemo;
    mLogTangente: TMemo;
    mLogSegundos: TMemo;
    mLogPuntos: TMemo;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    pMat1: TPanel;
    pMat2: TPanel;
    pMat3: TPanel;
    Panel15: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    pSuma: TPanel;
    TabSheet1: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    MenuPrincipal: TTreeView;
    tbCelcius: TTrackBar;
    tbKelvin: TTrackBar;
    tbFahrenheit: TTrackBar;
    procedure CalcularDeterminante3x3(Sender: TObject);
    procedure CalcularEcuacionCircunferencia(Sender: TObject);
    procedure CalcularElementosTriangulo(Sender: TObject);
    procedure CalcularRelacionesTangente(Sender: TObject);
    procedure CalcularSolucionSistemaEcuaciones(Sender: TObject);
    procedure ContenidoChange(Sender: TObject);
    procedure ConvertirDeCelciusA_(Sender: TObject);
    procedure ConvertirDeFahrenheitA_(Sender: TObject);
    procedure ConvertirDeGradosARadianes(Sender: TObject);
    procedure ConvertirDeKelvinA_(Sender: TObject);
    procedure ConvertirDeRadianesAGrados(Sender: TObject);
    procedure ConvertirSegundos(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure menuVerLateralClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure seleccionarMenu(Sender: TObject);
    procedure sumarDigitosCuatroCifras(Sender: TObject);
  private

  public
    procedure imprimirMatriz(matriz: TMatriz; bloc: TMemo);

    function calcularDeterminante(matriz: TMatriz): real;
    function generarMatriz(m11, m12, m13, m21, m22, m23, m31, m32, m33: real): tmatriz;
  end;

var
  FCalculadoraFormulas: TFCalculadoraFormulas;

implementation

{$R *.lfm}

{ TFCalculadoraFormulas }

procedure TFCalculadoraFormulas.seleccionarMenu(Sender: TObject);
begin
  // ShowMessage('index = ' + IntToStr(MenuPrincipal.Selected.Index));
  Contenido.TabIndex := MenuPrincipal.Selected.Index + 1;
end;

procedure TFCalculadoraFormulas.sumarDigitosCuatroCifras(Sender: TObject);
var
  n, d1, d2, d3, d4, suma: integer;
begin
  // tomar el valor o número
  n := StrToInt(edNumero.Text);

  d1 := n div 1000;
  n := n mod 1000;

  d2 := n div 100;
  n := n mod 100;

  d3 := n div 10;
  n := n mod 10;

  d4 := n;

  suma := d1 + d2 + d3 + d4;

  pSuma.Caption := 'Suma = ' + IntToStr(suma);
end;

procedure TFCalculadoraFormulas.imprimirMatriz(matriz: TMatriz; bloc: TMemo);
begin
  bloc.Lines.Add(FloatToStr(matriz.m11) + ' ' + FloatToStr(matriz.m12) +
    ' ' + FloatToStr(matriz.m13));

  bloc.Lines.Add(FloatToStr(matriz.m21) + ' ' + FloatToStr(matriz.m22) +
    ' ' + FloatToStr(matriz.m23));

  bloc.Lines.Add(FloatToStr(matriz.m31) + ' ' + FloatToStr(matriz.m32) +
    ' ' + FloatToStr(matriz.m33));
end;

function TFCalculadoraFormulas.calcularDeterminante(matriz: TMatriz): real;
var
  cf1, cf2, cf3: real;
begin
  with matriz do
  begin
    cf1 := m11 * (m22 * m33 - m32 * m23);
    cf2 := m12 * (m21 * m33 - m31 * m23);
    cf3 := m13 * (m21 * m32 - m31 * m22);
  end;

  Result := cf1 - cf2 + cf3;
end;

function TFCalculadoraFormulas.generarMatriz(m11, m12, m13, m21, m22,
  m23, m31, m32, m33: real): tmatriz;
begin
  Result.m11 := m11;
  Result.m12 := m12;
  Result.m13 := m13;

  Result.m21 := m21;
  Result.m22 := m22;
  Result.m23 := m23;

  Result.m31 := m31;
  Result.m32 := m32;
  Result.m33 := m33;
end;

procedure TFCalculadoraFormulas.FormCreate(Sender: TObject);
begin
  Contenido.ShowTabs := False;
  Contenido.TabIndex := 0;

  mLogSegundos.Lines.Clear;

  FCalculadoraFormulas.Width := 1024;
  FCalculadoraFormulas.Height := 600;
end;

procedure TFCalculadoraFormulas.MenuItem10Click(Sender: TObject);
begin
  Contenido.TabIndex := 9;
end;

procedure TFCalculadoraFormulas.MenuItem11Click(Sender: TObject);
begin
  Close();
end;

procedure TFCalculadoraFormulas.MenuItem14Click(Sender: TObject);
begin
    Contenido.TabIndex:= 10;
end;

procedure TFCalculadoraFormulas.MenuItem15Click(Sender: TObject);
begin
     Contenido.TabIndex:= 0;
end;

procedure TFCalculadoraFormulas.menuVerLateralClick(Sender: TObject);
begin
  MenuPrincipal.Visible := not MenuPrincipal.Visible;
  menuVerLateral.Checked := MenuPrincipal.Visible;
end;

procedure TFCalculadoraFormulas.MenuItem2Click(Sender: TObject);
begin
  Contenido.TabIndex := 1;
end;

procedure TFCalculadoraFormulas.MenuItem3Click(Sender: TObject);
begin
  Contenido.TabIndex := 2;
end;

procedure TFCalculadoraFormulas.MenuItem4Click(Sender: TObject);
begin
  Contenido.TabIndex := 3;
end;

procedure TFCalculadoraFormulas.MenuItem5Click(Sender: TObject);
begin
  Contenido.TabIndex := 4;
end;

procedure TFCalculadoraFormulas.MenuItem6Click(Sender: TObject);
begin
  Contenido.TabIndex := 5;
end;

procedure TFCalculadoraFormulas.MenuItem7Click(Sender: TObject);
begin
  Contenido.TabIndex := 6;
end;

procedure TFCalculadoraFormulas.MenuItem8Click(Sender: TObject);
begin
  Contenido.TabIndex := 7;
end;

procedure TFCalculadoraFormulas.MenuItem9Click(Sender: TObject);
begin
  Contenido.TabIndex := 8;
end;

procedure TFCalculadoraFormulas.ConvertirSegundos(Sender: TObject);
var
  segundos, minutos, horas, dias: integer;
begin
  // Obtener los segundos desde la entrada
  segundos := StrToInt(edSegundos.Text);

  mLogSegundos.Lines.Add('');
  mLogSegundos.Lines.Add('=== Nueva Conversión ===');

  dias := segundos div 86400;
  mLogSegundos.Lines.Add('Días = ' + IntToStr(dias));
  segundos := segundos mod 86400;
  // mLogSegundos.Lines.Add('Segundos Restantes = ' + IntToStr(segundos));

  horas := segundos div 3600;
  mLogSegundos.Lines.Add('Horas = ' + IntToStr(horas));
  segundos := segundos mod 3600;
  // mLogSegundos.Lines.Add('Segundos Restantes = ' + IntToStr(segundos));

  minutos := segundos div 60;
  mLogSegundos.Lines.Add('Minutos = ' + IntToStr(minutos));
  segundos := segundos mod 60;
  // mLogSegundos.Lines.Add('Segundos Restantes = ' + IntToStr(segundos));
  mLogSegundos.Lines.Add('Segundos = ' + IntToStr(segundos));
end;

procedure TFCalculadoraFormulas.ConvertirDeGradosARadianes(Sender: TObject);
var
  grados, radianes: real;
begin
  // Se tomará el valor de los grados para convertirlo a radianes
  grados := StrToFloat(edGrados.Text);

  radianes := (grados * Pi) / 180;

  edRadianes.Text := FloatToStr(radianes);
end;

procedure TFCalculadoraFormulas.ConvertirDeKelvinA_(Sender: TObject);
var
  celcius, kelvin, fahrenheit: real;
begin
  // Obtener los grados kelvin
  kelvin := tbKelvin.Position;
  gbKelvin.Caption := 'Grados Kelvin (' + FloatToStr(kelvin) + ' °K)';

  celcius := kelvin - 273.15;
  gbCelcius.Caption := 'Grados Celcius (' + FloatToStr(celcius) + ' °C)';
  tbCelcius.Position := Round(celcius);

  fahrenheit := 1.8 * celcius + 32;
  gbFahrenheit.Caption := 'Grados Fahrenheit (' + FloatToStr(fahrenheit) + ' °F)';
  tbFahrenheit.Position := Round(fahrenheit);
end;

procedure TFCalculadoraFormulas.ConvertirDeCelciusA_(Sender: TObject);
var
  celcius, kelvin, fahrenheit: real;
begin
  // Obtener los grados celcius
  celcius := tbCelcius.Position;
  gbCelcius.Caption := 'Grados Celcius (' + FloatToStr(celcius) + ' °C)';

  kelvin := celcius + 273.15;
  gbKelvin.Caption := 'Grados Kelvin (' + FloatToStr(kelvin) + ' °K)';
  tbKelvin.Position := Round(kelvin);

  fahrenheit := 1.8 * celcius + 32;
  gbFahrenheit.Caption := 'Grados Fahrenheit (' + FloatToStr(fahrenheit) + ' °F)';
  tbFahrenheit.Position := Round(fahrenheit);
end;

procedure TFCalculadoraFormulas.CalcularElementosTriangulo(Sender: TObject);
var
  x1, y1, x2, y2, x3, y3: real;
  area, perimetro, d1, d2, d3, sp: real;
begin
  // Obteniendo los datos
  x1 := StrToFloat(edX1.Text);
  y1 := StrToFloat(edY1.Text);
  x2 := StrToFloat(edX2.Text);
  y2 := StrToFloat(edY2.Text);
  x3 := StrToFloat(edX3.Text);
  y3 := StrToFloat(edY3.Text);

  d1 := sqrt(power(x2 - x1, 2) + power(y2 - y1, 2));
  d2 := sqrt(power(x2 - x3, 2) + power(y2 - y3, 2));
  d3 := sqrt(power(x3 - x1, 2) + power(y3 - y1, 2));

  perimetro := d1 + d2 + d3;

  sp := perimetro / 2;

  area := sqrt(sp * (sp - d1) * (sp - d2) * (sp - d3));

  mLogPuntos.Lines.Add('');
  mLogPuntos.Lines.Add('=== Cálculo Finalizado ===');

  mLogPuntos.Lines.Add('Triángulo con puntos A(' + FloatToStr(x1) +
    ',' + FloatToStr(y1) + '); B(' + FloatToStr(x2) + ',' + FloatToStr(y2) +
    ') y C(' + FloatToStr(x3) + ',' + FloatToStr(y3) + ')');

  mLogPuntos.Lines.Add('d1 = ' + FloatToStr(d1) + '; d2 = ' +
    FloatToStr(d2) + ' y d3 = ' + FloatToStr(d3));

  mLogPuntos.Lines.Add('Perímetro = ' + FloatToStr(perimetro));

  mLogPuntos.Lines.Add('Área = ' + FloatToStr(area));
end;

procedure TFCalculadoraFormulas.CalcularDeterminante3x3(Sender: TObject);
var
  matA: TMatriz;
  det: real;
begin
  matA.m11 := StrToFloat(edM11.Text);
  matA.m12 := StrToFloat(edM12.Text);
  matA.m13 := StrToFloat(edM13.Text);

  matA.m21 := StrToFloat(edM21.Text);
  matA.m22 := StrToFloat(edM22.Text);
  matA.m23 := StrToFloat(edM23.Text);

  matA.m31 := StrToFloat(edM31.Text);
  matA.m32 := StrToFloat(edM32.Text);
  matA.m33 := StrToFloat(edM33.Text);

  // Imprimir la matriz
  imprimirMatriz(matA, mLogDeterminante);

  det := calcularDeterminante(matA);

  mLogDeterminante.Lines.Add('Determinante = ' + FloatToStr(det));
end;

procedure TFCalculadoraFormulas.CalcularEcuacionCircunferencia(Sender: TObject);
var
  matB, matC, matD, matS: TMatriz;
  x1, y1, x2, y2, x3, y3: real;
  t1, t2, t3: real;
  detB, detC, detD, detS: real;
  B, C, D: real;
begin
  // Obtener datos
  x1 := StrToFloat(edCx1.Text);
  y1 := StrToFloat(edCy1.Text);

  x2 := StrToFloat(edCx2.Text);
  y2 := StrToFloat(edCy2.Text);

  x3 := StrToFloat(edCx3.Text);
  y3 := StrToFloat(edCy3.Text);

  t1 := -power(x1, 2) - power(y1, 2);
  t2 := -power(x2, 2) - power(y2, 2);
  t3 := -power(x3, 2) - power(y3, 2);

  matS := generarMatriz(x1, y1, 1, x2, y2, 1, x3, y3, 1);
  detS := calcularDeterminante(matS);

  matB := generarMatriz(t1, y1, 1, t2, y2, 1, t3, y3, 1);
  detB := calcularDeterminante(matB);

  matC := generarMatriz(x1, t1, 1, x2, t2, 1, x3, t3, 1);
  detC := calcularDeterminante(matC);

  matD := generarMatriz(x1, y1, t1, x2, y2, t2, x3, y3, t3);
  detD := calcularDeterminante(matD);

  B := detB / detS;
  C := detC / detS;
  D := detD / detS;

  mLogCircunferencia.Lines.Add('');
  mLogCircunferencia.Lines.Add('B = ' + FloatToStr(B));
  mLogCircunferencia.Lines.Add('C = ' + FloatToStr(C));
  mLogCircunferencia.Lines.Add('D = ' + FloatToStr(D));
end;

procedure TFCalculadoraFormulas.CalcularRelacionesTangente(Sender: TObject);
var
  alfa, beta, dist, x, y: real;
begin
  alfa := StrToFloat(edAlfa.Text);
  beta := StrToFloat(edBeta.Text);
  dist := StrToFloat(edDist.Text);

  // Convertir a radianes
  alfa := (alfa * pi) / 180;
  beta := (beta * pi) / 180;

  x := (dist * tan(alfa)) / (tan(beta) - tan(alfa));
  y := x * tan(beta);

  mLogTangente.Lines.Add('');
  mLogTangente.Lines.Add('=== Resultados del Cálculo');
  mLogTangente.Lines.Add('alfa = ' + FloatToStr(alfa));
  mLogTangente.Lines.Add('beta = ' + FloatToStr(beta));
  mLogTangente.Lines.Add('dist = ' + FloatToStr(dist));
  mLogTangente.Lines.Add('x = ' + FloatToStr(x));
  mLogTangente.Lines.Add('y = ' + FloatToStr(y));
end;

procedure TFCalculadoraFormulas.CalcularSolucionSistemaEcuaciones(Sender: TObject);
var
  a, b, c, e, d, f, detx, dety, dets, x, y: real;
begin
  a := StrToFloat(edCoefX1.Text);
  b := StrToFloat(edCoefY1.Text);
  c := StrToFloat(edTerm1.Text);

  d := StrToFloat(edCoefX2.Text);
  e := StrToFloat(edCoefY2.Text);
  f := StrToFloat(edTerm2.Text);

  detX := c * e - f * b;
  detY := a * f - d * c;
  detS := a * e - d * b;

  x := detX / detS;
  y := detY / detS;

  mLogSolSisEcu.Lines.Add('');
  mLogSolSisEcu.Lines.Add('=== Solución al sistema de ecuaciones ===');
  mLogSolSisEcu.Lines.Add(FloatToStr(a) + 'x+' + FloatToStr(b) + 'y=' + FloatToStr(c));
  mLogSolSisEcu.Lines.Add(FloatToStr(d) + 'x+' + FloatToStr(e) + 'y=' + FloatToStr(f));
  mLogSolSisEcu.Lines.Add('detX = ' + FloatToStr(detx));
  mLogSolSisEcu.Lines.Add('detY = ' + FloatToStr(dety));
  mLogSolSisEcu.Lines.Add('detS = ' + FloatToStr(dets));
  mLogSolSisEcu.Lines.Add('x = ' + FloatToStr(x));
  mLogSolSisEcu.Lines.Add('y = ' + FloatToStr(y));
end;

procedure TFCalculadoraFormulas.ContenidoChange(Sender: TObject);
begin

end;

procedure TFCalculadoraFormulas.ConvertirDeFahrenheitA_(Sender: TObject);
var
  celcius, kelvin, fahrenheit: real;
begin
  // Obtener los grados Fahrenheit
  fahrenheit := tbFahrenheit.Position;
  gbFahrenheit.Caption := 'Grados Fahrenheit (' + FloatToStr(fahrenheit) + ' °F)';

  celcius := (fahrenheit - 32) / 1.8;
  gbCelcius.Caption := 'Grados Celcius (' + FloatToStr(celcius) + ' °C)';
  tbCelcius.Position := Round(celcius);

  kelvin := celcius + 273.15;
  gbKelvin.Caption := 'Grados Kelvin (' + FloatToStr(kelvin) + ' °K)';
  tbKelvin.Position := Round(kelvin);
end;

procedure TFCalculadoraFormulas.ConvertirDeRadianesAGrados(Sender: TObject);
var
  grados, radianes: real;
begin
  // Se tomará el valor de los grados para convertirlo a radianes
  radianes := StrToFloat(edRadianes.Text);

  grados := (radianes * 180) / Pi;

  edGrados.Text := FloatToStr(grados);
end;

end.
{
1. Conversión de Segundos
2. Conversión de grados
3. Conversión de temperatura
4. Punto medio, Distancia, Área de un triángulo
5. Suma de los digitos de un número de cuatro cifras
6. Teorema de la tangente
7. Sistemas de ecuaciones de 2x2
8. Determinante de 3x3
9. Ecuación de una Circunferencia dados tres puntos
}
