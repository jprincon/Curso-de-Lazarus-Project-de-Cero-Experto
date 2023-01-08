unit uFColorFondoFuente;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, uTNeuron, uTActivactionFunction, Types;

type

  { TFColorFondo }

  TFColorFondo = class(TForm)
    bAgregarEjemplo: TButton;
    bGuardarEjemplos: TButton;
    cbFondo: TColorButton;
    cbFondoAutomatico: TColorButton;
    cbFuente: TColorButton;
    ContenidoEjemplos: TPageControl;
    edPesosSinapticos: TEdit;
    edPolarizacion: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    lbColor: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    mEjemplos: TMemo;
    Contenido: TPageControl;
    pSalida: TPanel;
    pFondo: TPanel;
    TabSheet1: TTabSheet;
    Editor: TTabSheet;
    procedure bAgregarEjemploClick(Sender: TObject);
    procedure bGuardarEjemplosClick(Sender: TObject);
    procedure cbFondoAutomaticoClick(Sender: TObject);
    procedure cbFondoAutomaticoColorChanged(Sender: TObject);
    procedure cbFondoClick(Sender: TObject);
    procedure cbFondoColorChanged(Sender: TObject);
    procedure cbFuenteClick(Sender: TObject);
    procedure cbFuenteColorChanged(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);

    procedure FormCreate(Sender: TObject);
  private
    Neurona: TNeuron;
  public

  end;

var
  FColorFondo: TFColorFondo;

implementation

{$R *.lfm}

{ TFColorFondo }

procedure TFColorFondo.cbFondoClick(Sender: TObject);
begin
  pFondo.Color := cbFondo.ButtonColor;
end;

procedure TFColorFondo.bGuardarEjemplosClick(Sender: TObject);
begin
  mEjemplos.Lines.SaveToFile('..\Ejemplos\ejemplos_Fondo_Texto.csv');
end;

procedure TFColorFondo.cbFondoAutomaticoClick(Sender: TObject);
var
  fs: TFormatSettings;
begin
  pFondo.Color := cbFondoAutomatico.ButtonColor;

  fs.DecimalSeparator := '.';
  Neurona.Weights.Clear;
  Neurona.Weights.addList(edPesosSinapticos.Text, ',');
  Neurona.polarization := StrToFloat(edPolarizacion.Text, fs);
end;

procedure TFColorFondo.cbFondoAutomaticoColorChanged(Sender: TObject);
var
  cl: longint;
  r, g, b: byte;
  salida: real;
begin
  pFondo.Color := cbFondoAutomatico.ButtonColor;

  cl := ColorToRGB(pFondo.Color);
  r := Red(cl);
  g := Green(cl);
  b := Blue(cl);

  { Llamar a la neurona, pasarle el color en (r,g,b) y mirar si selecciona
  blanco o negro}

  Neurona.Inputs.Clear;
  Neurona.Inputs.add(r);
  Neurona.Inputs.add(g);
  Neurona.Inputs.add(b);

  lbColor.Caption := 'Seleccione un color para probar a la Red Neuronal ' +
    Format('(%d,%d,%d)', [r, g, b]);

  salida := Neurona.propagation;
  pSalida.Caption := FloatToStr(salida);

  if salida = 0 then pFondo.Font.Color := clWhite
  else
    pFondo.Font.Color := clBlack;
end;

procedure TFColorFondo.bAgregarEjemploClick(Sender: TObject);
var
  cl: longint;
  r, g, b, bw: real;
  fs: TFormatSettings;
begin
  cl := ColorToRGB(pFondo.Color);
  r := Red(cl) / 255;
  g := Green(cl) / 255;
  b := Blue(cl) / 255;

  if pFondo.Font.Color = clWhite then bw := 1
  else
    bw := -1;

  fs.DecimalSeparator := '.';
  mEjemplos.Lines.Add(FloatToStr(r, fs) + ',' + FloatToStr(g, fs) + ',' +
    FloatToStr(b, fs) + ',' + FloatToStr(bw));
end;

procedure TFColorFondo.cbFondoColorChanged(Sender: TObject);
begin
  pFondo.Color := cbFondo.ButtonColor;
end;

procedure TFColorFondo.cbFuenteClick(Sender: TObject);
begin
  pFondo.Font.Color := cbFuente.ButtonColor;
end;

procedure TFColorFondo.cbFuenteColorChanged(Sender: TObject);
begin
  pFondo.Font.Color := cbFuente.ButtonColor;
end;

procedure TFColorFondo.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  mEjemplos.Lines.SaveToFile('..\Ejemplos\ejemplos_Fondo_Texto.csv');
end;

procedure TFColorFondo.FormCreate(Sender: TObject);
begin
  mEjemplos.Lines.LoadFromFile('..\Ejemplos\ejemplos_Fondo_Texto.csv');

  Neurona := TNeuron.Create;
  Neurona.Weights.addList('0.733278248459101,0.240770655451342,0.0370688617695123', ',');
  Neurona.polarization := 0;
  Neurona.ActivactionFunction.TypeActivactionFunction := tafStep;
end;

end.
