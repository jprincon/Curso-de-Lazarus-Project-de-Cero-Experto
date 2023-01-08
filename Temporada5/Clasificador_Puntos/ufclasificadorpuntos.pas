unit uFClasificadorPuntos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  TAGraph, uTNeuron, uTActivactionFunction;

type

  { TForm1 }

  TForm1 = class(TForm)
    bClasificar: TButton;
    edX: TLabeledEdit;
    edY: TLabeledEdit;
    Panel1: TPanel;
    pClasificacion: TPanel;
    procedure bClasificarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Neurona: TNeuron;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Neurona := TNeuron.Create;
  Neurona.Weights.addList('0.4007, 1.8081', ',');
  Neurona.polarization := -4.13;

  Neurona.ActivactionFunction.TypeActivactionFunction := tafStep;
end;

procedure TForm1.bClasificarClick(Sender: TObject);
var
  x, y, salida: real;
  fs: TFormatSettings;
begin
  fs.DecimalSeparator := '.';
  x := StrToFloat(edX.Text, fs);
  y := StrToFloat(edY.Text, fs);

  Neurona.Inputs.Clear;
  Neurona.Inputs.add(x);
  Neurona.Inputs.add(y);

  salida := Neurona.propagation;
  pClasificacion.Caption := FloatToStr(salida);
end;

end.
