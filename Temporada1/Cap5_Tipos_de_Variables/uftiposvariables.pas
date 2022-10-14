unit uFTiposVariables;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, Math;

type

  { TFTiposVariables }

  TFTiposVariables = class(TForm)
    bCalcular: TButton;
    bPitagoras: TButton;
    edNum1: TEdit;
    edNum2: TEdit;
    edCatA: TEdit;
    edCatB: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    mCalcBasica: TMemo;
    mConsolaPitagoras: TMemo;
    paginaMenuPrincipal: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    tabCalculadora: TTabSheet;
    tabTrianguloPitagoras: TTabSheet;
    procedure calcularPitagoras(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure realizarCalculo(Sender: TObject);
  private

  public

  end;

var
  // Variables Globales
  FTiposVariables: TFTiposVariables;

implementation

{$R *.lfm}

{ TFTiposVariables }

procedure TFTiposVariables.realizarCalculo(Sender: TObject);
var
  // Variables Locales
  a, b, c: integer;
begin
  a := StrToInt(edNum1.Text);
  b := StrToInt(edNum2.Text);

  mCalcBasica.Lines.Add('');
  mCalcBasica.Lines.Add('=================================');

  // Realizar cálculo básicos
  c := a + b;
  mCalcBasica.Lines.add('Suma = ' + IntToStr(c));

  c := a - b;
  mCalcBasica.Lines.add('Diferencia = ' + IntToStr(c));

  c := a * b;
  mCalcBasica.Lines.add('Producto = ' + IntToStr(c));

  c := a div b;
  mCalcBasica.Lines.add('Cociente = ' + IntToStr(c));

  c := a mod b;
  mCalcBasica.Lines.add('Residuo = ' + IntToStr(c));
end;

procedure TFTiposVariables.FormCreate(Sender: TObject);
begin
  // Borrar las consolas
  mCalcBasica.Lines.Clear;
  mConsolaPitagoras.Lines.Clear;
end;

procedure TFTiposVariables.calcularPitagoras(Sender: TObject);
var
  catA, catB, Hipt, Perimetro, Area: real;
begin
  catA := StrToFloat(edCatA.Text);
  catB := StrToFloat(edCatB.Text);
  Hipt := sqrt(Power(catA, 2) + Power(catB, 2));

  Area := (catA * catB) / 2;
  Perimetro := catA + catB + Hipt;

  // Imprimir los resultados en la consola
  mConsolaPitagoras.Lines.Add('');
  mConsolaPitagoras.Lines.Add('================================');
  mConsolaPitagoras.Lines.Add('Cateto A = ' + FloatToStr(catA));
  mConsolaPitagoras.Lines.Add('Cateto B = ' + FloatToStr(catB));
  mConsolaPitagoras.Lines.Add('Hipotenusa = ' + FloatToStr(Hipt));
  mConsolaPitagoras.Lines.Add('Área = ' + FloatToStr(Area));
  mConsolaPitagoras.Lines.Add('Perímetro = ' + FloatToStr(Perimetro));
end;

end.
