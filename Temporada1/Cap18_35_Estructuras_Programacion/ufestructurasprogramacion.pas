unit uFEstructurasProgramacion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, Menus, SynEdit, TAGraph, TASeries, TAFuncSeries, Math;

type

  { TFEstructurasProgramacion }

  TFEstructurasProgramacion = class(TForm)
    bCalcularListaAleatoria: TButton;
    bGenerarListaAleatoria: TButton;
    bGenerarDatos: TButton;
    bCalcularPrimosN: TButton;
    bCalcularEstadisticas: TButton;
    bSimulacion: TButton;
    bOrdenarNumeros: TButton;
    bCalcularTabla: TButton;
    bCalcularFactorial: TButton;
    bGenerarClaves: TButton;
    bRseolverEcuacion: TButton;
    bEvaluarNumeros1: TButton;
    bEvaluarNumerosPares: TButton;
    bInsertar: TButton;
    bTabular: TButton;
    bPausarCrono: TButton;
    bIniciarCrono: TButton;
    Chart1: TChart;
    graficaPelota: TCubicSplineSeries;
    edCond: TEdit;
    edRango: TEdit;
    edPerdida: TEdit;
    edAltura: TEdit;
    graficaFuncion: TChart;
    edLimInf: TEdit;
    edDx: TEdit;
    edLimSup: TEdit;
    GraficaDiagramaBarras: TChart;
    diagramaBarras: TBarSeries;
    Contenido: TPageControl;
    edCoefA: TEdit;
    edValor: TEdit;
    edNumA: TEdit;
    edCoefC: TEdit;
    edNumB: TEdit;
    edNumC: TEdit;
    edCoefB: TEdit;
    edClave: TEdit;
    edNumN: TEdit;
    edNumTabla: TEdit;
    edNumFact: TEdit;
    fx: TCubicSplineSeries;
    GroupBox1: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    GroupBox12: TGroupBox;
    GroupBox13: TGroupBox;
    GroupBox14: TGroupBox;
    GroupBox15: TGroupBox;
    GroupBox16: TGroupBox;
    GroupBox17: TGroupBox;
    GroupBox18: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbCrono: TLabel;
    lbMili: TLabel;
    lvTabulacion: TListView;
    mAyuda: TMemo;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    menuGuardarDatosConsola: TMenuItem;
    menuAutor: TMenuItem;
    menuAyuda: TMenuItem;
    menuEcuGenSegGra: TMenuItem;
    menuFactorialNumero: TMenuItem;
    menuGenerarClaves: TMenuItem;
    menuCalculosEstadisticos: TMenuItem;
    menuCronometro: TMenuItem;
    menuSimulacionCodigo: TMenuItem;
    menuRebotes: TMenuItem;
    menuListaSinRepeticion: TMenuItem;
    menuListaAleatoria: TMenuItem;
    menuTabulacion: TMenuItem;
    menuOrdenarNumeros: TMenuItem;
    menuPrimerosPrimos: TMenuItem;
    menuTablaMultiplicar: TMenuItem;
    menuParImpar: TMenuItem;
    menuNumeroMayor: TMenuItem;
    menuSalir: TMenuItem;
    mLog: TSynEdit;
    PageControl1: TPageControl;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    Panel24: TPanel;
    Panel25: TPanel;
    Panel26: TPanel;
    Panel27: TPanel;
    Panel28: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Separator1: TMenuItem;
    MenuPrincipal: TMainMenu;
    Panel1: TPanel;
    Panel2: TPanel;
    pTitulo: TPanel;
    Splitter1: TSplitter;
    seCodigo: TSynEdit;
    TabSheet1: TTabSheet;
    tabFactorial: TTabSheet;
    tabGenerarClaves: TTabSheet;
    tabPrimerosPrimos: TTabSheet;
    tabOrdenarNumeros: TTabSheet;
    tabCalculosEstdisticos: TTabSheet;
    tabListaAleatoria: TTabSheet;
    tabListaSinRepeticion: TTabSheet;
    tabRebotes: TTabSheet;
    tabCronometro: TTabSheet;
    tabSimulacionCodigo: TTabSheet;
    tabTabulacion: TTabSheet;
    tabTablaMultiplicar: TTabSheet;
    tabSolEcuacion: TTabSheet;
    tabAyuda: TTabSheet;
    tabAutor: TTabSheet;
    tabParImpar: TTabSheet;
    tabNumeroMayor: TTabSheet;
    Cronometro: TTimer;
    Mili: TTimer;
    Simulador: TTimer;
    tvCodigo: TTreeView;
    tvDatos: TTreeView;
    procedure CalcularEstadisticas(Sender: TObject);
    procedure CalcularFactorial(Sender: TObject);
    procedure CalcularListaAleatoria(Sender: TObject);
    procedure CalcularPrimerosPrimosN(Sender: TObject);
    procedure CalcularTablaMultiplicar(Sender: TObject);
    procedure ContarTiempo(Sender: TObject);
    procedure EvaluarNumeros(Sender: TObject);
    procedure EvaluarNumerosParesImpares(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GenerarClaveAleatoria(Sender: TObject);
    procedure GenerarDatos(Sender: TObject);
    procedure GenerarListaAleatoria(Sender: TObject);
    procedure GenerarSimulacion(Sender: TObject);
    procedure IniciarCrono(Sender: TObject);
    procedure InsertarValor(Sender: TObject);
    procedure IrMenuVer(Sender: TObject);
    procedure IrMenuAcerca(Sender: TObject);
    procedure menuListaAleatoriaClick(Sender: TObject);
    procedure MiliTimer(Sender: TObject);
    procedure OrdenarNumeros(Sender: TObject);
    procedure pausarCrono(Sender: TObject);
    procedure RealizarGrafica(Sender: TObject);
    procedure ResolverEcuacion(Sender: TObject);
    procedure SimuladorTimer(Sender: TObject);
    procedure validarBorrarDatos(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure validarEnter(Sender: TObject; var Key: word; Shift: TShiftState);
  private
    hh, mm, ss, ml: integer;
    cronoFuncionando: boolean;
    contCod: integer;
  public
    procedure Log(mensaje: string);
  end;

var
  FEstructurasProgramacion: TFEstructurasProgramacion;

implementation

{$R *.lfm}

{ TFEstructurasProgramacion }

procedure TFEstructurasProgramacion.FormCreate(Sender: TObject);
begin
  Width := 1024;
  Height := 600;

  Contenido.ShowTabs := False;

  contCod:=0;
end;

procedure TFEstructurasProgramacion.GenerarClaveAleatoria(Sender: TObject);
var
  base, clave: string;
  l, i, n: integer;
begin
  base := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!#$%&=?';

  // Calcular la longitud del texto
  l := Length(base);

  // Log(format('La longitud de la base es %d', [l]));

  clave := '';
  for i := 1 to 12 do
  begin
    n := Random(l) + 1;
    clave := clave + base[n];
    // Log(format('Ciclo for con i=%d con clave = %s',[i, clave]));
  end;

  Log('La clave generada es = ' + clave);
  edClave.Text := clave;
end;

procedure TFEstructurasProgramacion.GenerarDatos(Sender: TObject);
var
  i, n: integer;
begin
  tvDatos.Items.Clear;
  for i := 1 to 20 do
  begin
    n := Random(200) + 5;
    tvDatos.Items.Add(nil, IntToStr(n));
  end;
end;

procedure TFEstructurasProgramacion.GenerarListaAleatoria(Sender: TObject);
var
  rango, i, d: integer;
  numeros: TStringList;
begin
  // Obtenemos el rango
  rango := StrToInt(edRango.Text);
  numeros := TStringList.Create;
  numeros.Clear;

  d := Random(rango);
  numeros.Add(IntToStr(d));

  for i := 2 to rango do
  begin
    d := Random(rango);

    while numeros.IndexOf(IntToStr(d)) >= 0 do
    begin
      d := Random(rango);
    end;
    numeros.Add(IntToStr(d));
  end;

  // numeros.Sort;
  Log(numeros.CommaText);
end;

procedure TFEstructurasProgramacion.GenerarSimulacion(Sender: TObject);
var
  altura, perdida: real;
  rebotes: integer;
begin
  // tomamos los datos
  altura := StrToFloat(edAltura.Text);
  perdida := StrToFloat(edPerdida.Text);
  perdida := perdida / 100;

  graficaPelota.Clear;
  rebotes := 0;

  while altura > 0.1 do
  begin
    // Log(format('Altura = %f', [altura]));
    graficaPelota.Add(altura, '', clblue);
    graficaPelota.Add(0, FloatToStr(altura), clblue);
    altura := altura * (1 - perdida);

    Inc(rebotes);
  end;

  Log(format('Cantidad de Rebotes = %d', [rebotes]));

end;

procedure TFEstructurasProgramacion.IniciarCrono(Sender: TObject);
begin
  cronoFuncionando := True;
  hh := 0;
  mm := 0;
  ss := 0;
  ml := 0;
end;

procedure TFEstructurasProgramacion.InsertarValor(Sender: TObject);
begin
  tvDatos.Items.Add(nil, edValor.Text);
  edValor.Text := '';
  edValor.SetFocus;
end;

procedure TFEstructurasProgramacion.IrMenuVer(Sender: TObject);
begin
  if TMenuItem(Sender) = menuNumeroMayor then
    Contenido.ActivePage := tabNumeroMayor;

  if TMenuItem(Sender) = menuParImpar then
    Contenido.ActivePage := tabParImpar;

  if TMenuItem(Sender) = menuEcuGenSegGra then
    Contenido.ActivePage := tabSolEcuacion;

  if TMenuItem(Sender) = menuTablaMultiplicar then
    Contenido.ActivePage := tabTablaMultiplicar;

  if TMenuItem(Sender) = menuFactorialNumero then
    Contenido.ActivePage := tabFactorial;

  if TMenuItem(Sender) = menuGenerarClaves then
    Contenido.ActivePage := tabGenerarClaves;

  if TMenuItem(Sender) = menuPrimerosPrimos then
    Contenido.ActivePage := tabPrimerosPrimos;

  if TMenuItem(Sender) = menuOrdenarNumeros then
    Contenido.ActivePage := tabOrdenarNumeros;

  if TMenuItem(Sender) = menuCalculosEstadisticos then
    Contenido.ActivePage := tabCalculosEstdisticos;

  if TMenuItem(Sender) = menuTabulacion then
    Contenido.ActivePage := tabTabulacion;

  if TMenuItem(Sender) = menuListaAleatoria then
    Contenido.ActivePage := tabListaAleatoria;

  if TMenuItem(Sender) = menuListaSinRepeticion then
    Contenido.ActivePage := tabListaSinRepeticion;

  if TMenuItem(Sender) = menuRebotes then
    Contenido.ActivePage := tabRebotes;

  if TMenuItem(Sender) = menuCronometro then
    Contenido.ActivePage := tabCronometro;

  if TMenuItem(Sender) = menuSimulacionCodigo then
    Contenido.ActivePage := tabSimulacionCodigo;

  pTitulo.Caption := TMenuItem(Sender).Caption;
end;

procedure TFEstructurasProgramacion.IrMenuAcerca(Sender: TObject);
begin
  if TMenuItem(Sender) = menuAyuda then
    Contenido.ActivePage := tabAyuda;

  if TMenuItem(Sender) = menuAutor then
    Contenido.ActivePage := tabAutor;
end;

procedure TFEstructurasProgramacion.menuListaAleatoriaClick(Sender: TObject);
begin

end;

procedure TFEstructurasProgramacion.MiliTimer(Sender: TObject);
begin
  if cronoFuncionando then
  begin
    Inc(ml,98);
    lbMili.Caption := FormatCurr('000', ml);

    if ml > 999 then ml := 0;
  end;
end;

procedure TFEstructurasProgramacion.OrdenarNumeros(Sender: TObject);
var
  lista: array[1..20] of integer;
  i, j, k, temp: integer;
  numeros: string;
begin

  {Crear una lista de números aleatorios}
  numeros := '';
  for i := 1 to 20 do
  begin
    lista[i] := Random(20);
    numeros := numeros + IntToStr(lista[i]) + ', ';
  end;

  Log('Lista de números generada aleatoriamente');
  Log(numeros);

  for i := 1 to 20 do
  begin

    Log('Comparando el número ' + IntToStr(lista[i]) + ' con el resto de la lista');
    for j := i to 20 do
    begin

      if lista[i] > lista[j] then
      begin
        temp := lista[i];
        lista[i] := lista[j];
        lista[j] := temp;
      end;

      numeros := '';
      for k := 1 to 20 do
      begin
        numeros := numeros + IntToStr(lista[k]) + ', ';
      end;
      Log(numeros);
    end;

  end;

  numeros := '';
  for i := 1 to 20 do
  begin
    numeros := numeros + IntToStr(lista[i]) + ', ';
  end;

  Log('Lista Ordenada');
  Log(numeros);
end;

procedure TFEstructurasProgramacion.pausarCrono(Sender: TObject);
begin
  cronoFuncionando := not cronoFuncionando;
end;

procedure TFEstructurasProgramacion.RealizarGrafica(Sender: TObject);
var
  x, y, dx, li, ls: real;
begin
  // Obtener los datos
  dx := StrToFloat(edDx.Text);
  li := StrToFloat(edLimInf.Text);
  ls := StrToFloat(edLimSup.Text);

  Log(Format('Los datos de graficación son los siguientes limInf=%f, limSup=%f y dx=%f',
    [li, ls, dx]));

  // Configuración de la tabla
  lvTabulacion.Items.Clear;
  fx.Clear;

  x := li;
  while x < ls do
  begin
    // y := 0.5 * power(x, 2) + 3 * x - 2;
    y := 3 * sin(x) + 1;
    x := x + dx;

    with lvTabulacion.Items.Add.SubItems do
    begin
      Add(FloatToStr(x));
      Add(FloatToStr(y));
    end;

    fx.AddXY(x, y, '', clred);

    Log(format('x = %f | y = %f', [x, y]));
  end;
end;

procedure TFEstructurasProgramacion.ResolverEcuacion(Sender: TObject);
var
  a, b, c, disc, x1, x2, img, rel: real;
begin
  // Obtener los datos
  a := StrToFloat(edCoefA.Text);
  b := StrToFloat(edCoefB.Text);
  c := StrToFloat(edCoefC.Text);

  disc := power(b, 2) - 4 * a * c;

  {Única solución}
  if disc = 0 then
  begin
    x1 := -b / (2 * a);
    Log('La ecuación tiena una única solución en x = ' + FloatToStr(x1));
  end;

  {Dos soluciones}
  if disc > 0 then
  begin
    x1 := (-b + sqrt(disc)) / (2 * a);
    x2 := (-b - sqrt(disc)) / (2 * a);
    Log(Format('La ecuación tiene dos soluciones en x1=%f y en x2=%f', [x1, x2]));
  end;

  {Soluciones imaginarias}
  if disc < 0 then
  begin
    img := sqrt(abs(disc)) / (2 * a);
    rel := -b / (2 * a);

    Log(Format('La ecuación tiene soluciones imaginarias en x1=%f + %fi y en x2=%f - %fi',
      [rel, img, rel, img]));
  end;
end;

procedure TFEstructurasProgramacion.SimuladorTimer(Sender: TObject);
begin
     with tvCodigo.Items.Add(nil, seCodigo.Lines[contCod]) do
     begin
       Selected:=true;
       Next;
     end;

     Inc(contCod);

     if contCod>=seCodigo.Lines.Count then contCod:=0;
end;

procedure TFEstructurasProgramacion.validarBorrarDatos(Sender: TObject;
  var Key: word; Shift: TShiftState);
begin
  if key = 46 then
  begin
    if tvDatos.Selected <> nil then
      tvDatos.Selected.Delete;
  end;
end;

procedure TFEstructurasProgramacion.validarEnter(Sender: TObject;
  var Key: word; Shift: TShiftState);
begin
  if key = $0D then
  begin
    tvDatos.Items.Add(nil, edValor.Text);
    edValor.Text := '';
    edValor.SetFocus;
  end;
end;

procedure TFEstructurasProgramacion.Log(mensaje: string);
begin
  mLog.Lines.Add(mensaje);
end;

procedure TFEstructurasProgramacion.EvaluarNumeros(Sender: TObject);
var
  a, b: real;
begin
  // Obtener los números
  a := StrToFloat(edNumA.Text);
  b := StrToFloat(edNumB.Text);

  if (a > b) then
  begin
    Log(FloatToStr(a) + ' es mayor que ' + FloatToStr(b));
  end
  else
  begin
    Log(FloatToStr(b) + ' es mayor que ' + FloatToStr(a));
  end;
end;

procedure TFEstructurasProgramacion.CalcularTablaMultiplicar(Sender: TObject);
var
  n, r, i: integer;
begin
  {Obtener los datos}
  n := StrToInt(edNumTabla.Text);

  //i := 1;
  //r := n*i;
  //Log(Format('%d x %d = %d',[n, i, r]));

  //i := 2;
  //r := n*i;
  //Log(Format('%d x %d = %d',[n, i, r]));

  //i := 3;
  //r := n*i;
  //Log(Format('%d x %d = %d',[n, i, r]));

  //i := 4;
  //r := n*i;
  //Log(Format('%d x %d = %d',[n, i, r]));

  //i := 5;
  //r := n*i;
  //Log(Format('%d x %d = %d',[n, i, r]));

  //i := 6;
  //r := n*i;
  //Log(Format('%d x %d = %d',[n, i, r]));

  //i := 7;
  //r := n*i;
  //Log(Format('%d x %d = %d',[n, i, r]));

  //i := 8;
  //r := n*i;
  //Log(Format('%d x %d = %d',[n, i, r]));

  //i := 9;
  //r := n*i;
  //Log(Format('%d x %d = %d',[n, i, r]));

  //i := 10;
  //r := n*i;
  //Log(Format('%d x %d = %d',[n, i, r]));

  for i := 1 to 20 do
  begin
    r := n * i;
    Log(Format('%d x %d = %d', [n, i, r]));
  end;
end;

procedure TFEstructurasProgramacion.ContarTiempo(Sender: TObject);
begin
  if cronoFuncionando then
  begin
    Inc(ss);
    ml := 0;

    if ss > 59 then
    begin
      Inc(mm);
      ss := 0;
    end;

    if mm > 59 then
    begin
      Inc(hh);
      mm := 0;
    end;

    // lbCrono.Caption:=Format('%2d:%2d:%2d',[hh,mm,ss]);
    lbCrono.Caption := FormatCurr('00', hh) + ':' + FormatCurr('00', mm) +
      ':' + FormatCurr('00', ss);
  end;
end;

procedure TFEstructurasProgramacion.CalcularFactorial(Sender: TObject);
var
  n, fact, i: longint;
begin
  {Obtener los valores}
  n := StrToInt(edNumFact.Text);
  fact := 1;

  for i := 1 to n do
    fact := fact * i;

  Log(Format('El factorial de %d es %d', [n, fact]));
end;

procedure TFEstructurasProgramacion.CalcularListaAleatoria(Sender: TObject);
var
  n, d: integer;
begin
  n := StrToInt(edCond.Text);
  d := Random(999);
  Log(FloatToStr(d));

  while d <> n do
  begin
    d := Random(999);
    Log(FloatToStr(d));
  end;
end;

procedure TFEstructurasProgramacion.CalcularEstadisticas(Sender: TObject);
var
  minimo, maximo, dato, media, suma, sumaVar, desest, varianza: real;
  i, n: integer;
begin
  // Inicializar las variables en vacio
  media := 0;
  suma := 0;
  desest := 0;
  varianza := 0;

  Randomize;

  n := tvDatos.Items.Count;

  if n > 0 then
  begin
    minimo := StrToFloat(tvDatos.Items[0].Text);
    maximo := StrToFloat(tvDatos.Items[0].Text);

    diagramaBarras.Clear;
    for i := 1 to n do
    begin
      dato := StrToFloat(tvDatos.Items[i - 1].Text);

      // Graficar
      diagramaBarras.Add(dato, tvDatos.Items[i - 1].Text, clred);
      suma := suma + dato;

      if dato < minimo then
        minimo := dato;

      if dato > maximo then
        maximo := dato;
    end;

    // Media
    media := suma / n;

    sumaVar := 0;
    for i := 1 to n do
    begin
      dato := StrToFloat(tvDatos.Items[i - 1].Text);
      sumaVar := sumaVar + power(dato - media, 2);
    end;

    varianza := sumaVar / (n - 1);
    desest := sqrt(varianza);

    Log(Format('La suma de los datos es = %f', [suma]));
    Log(Format('La suma de varianza es = %f', [sumaVar]));
    Log(Format('Le media de los datos es = %f', [media]));
    Log(Format('El dado mínimo es = %f', [minimo]));
    Log(Format('El dado máximo es = %f', [maximo]));
    Log(Format('La varianza es = %f', [varianza]));
    Log(Format('La desviación estándar es = %f', [desest]));
  end
  else
    ShowMessage('Debe ingresar datos para realizar el cálculo');

end;

procedure TFEstructurasProgramacion.CalcularPrimerosPrimosN(Sender: TObject);
var
  n, i, j, divisores: integer;
  primos: string;
begin
  // Obtener los datos
  n := StrToInt(edNumN.Text);

  primos := '';

  for i := 2 to n do
  begin

    Log('');
    Log(format('Estamos calculando los divisores de %d', [i]));
    divisores := 0;
    for j := 1 to i do
    begin
      if (i mod j) = 0 then
      begin
        divisores := divisores + 1;
        Log(format('Encontramos que %d es divisor de %d', [j, i]));
      end;
    end;

    if divisores = 2 then
    begin
      primos := primos + IntToStr(i) + ', ';
      Log(Format('Como %d tiene %d divisores, por lo tanto es un primo',
        [i, divisores]));
    end
    else
      Log(Format('Como %d tiene %d divisores, por lo tanto NO es un primo',
        [i, divisores]));
  end;

  Log(primos);
end;

procedure TFEstructurasProgramacion.EvaluarNumerosParesImpares(Sender: TObject);
var
  a: integer;
begin
  a := StrToInt(edNumC.Text);

  if (a mod 2) = 0 then
    Log('El número ' + FloatToStr(a) + ' es par')
  else
    Log('El número ' + FloatToStr(a) + ' es impar');
end;

end.
