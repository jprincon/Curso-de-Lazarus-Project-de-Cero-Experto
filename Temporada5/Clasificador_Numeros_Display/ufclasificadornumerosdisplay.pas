unit uFClasificadorNumerosDisplay;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  uTNeuron, uTActivactionFunction;

type

  { TFDisplay }

  TFDisplay = class(TForm)
    b0: TButton;
    b9: TButton;
    b1: TButton;
    b2: TButton;
    b3: TButton;
    b4: TButton;
    b5: TButton;
    b6: TButton;
    b7: TButton;
    b8: TButton;
    Panel1: TPanel;
    pSalida: TPanel;
    segA: TPanel;
    segG: TPanel;
    segD: TPanel;
    segF: TPanel;
    segB: TPanel;
    segE: TPanel;
    segC: TPanel;
    pDisplay: TPanel;
    procedure dibujarNumero(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    segmentos: array[1..7] of TPanel;
    Neurona: TNeuron;
  public

  end;

var
  FDisplay: TFDisplay;

implementation

{$R *.lfm}

{ TFDisplay }

procedure TFDisplay.dibujarNumero(Sender: TObject);
var
  i: integer;
  sNumero: string;
  lista: TStringList;
  salida: real;
begin
  for i := 1 to 7 do
    segmentos[i].Color := clWhite;

  if Sender = b0 then sNumero := '1111110';
  if Sender = b1 then sNumero := '0110000';
  if Sender = b2 then sNumero := '1101101';
  if Sender = b3 then sNumero := '1111001';
  if Sender = b4 then sNumero := '0110011';
  if Sender = b5 then sNumero := '1011011';
  if Sender = b6 then sNumero := '1011111';
  if Sender = b7 then sNumero := '1110000';
  if Sender = b8 then sNumero := '1111111';
  if Sender = b9 then sNumero := '1111011';

  lista := TStringList.Create;
  for i := 1 to 7 do
  begin
    if sNumero[i] = '1' then segmentos[i].Color := clRed
    else
      segmentos[i].Color := clWhite;

    lista.Add(sNumero[i]);
  end;

  Caption := lista.CommaText;
  Neurona.Inputs.Clear;
  Neurona.Inputs.addList(lista.CommaText, ',');
  salida := Neurona.propagation;

  if salida = 0 then pSalida.Caption := 'Impar'
  else
    pSalida.Caption := 'Par';

  // pSalida.Caption:=FloatToStr(salida);
end;

procedure TFDisplay.FormCreate(Sender: TObject);
begin
  segmentos[1] := segA;
  segmentos[2] := segB;
  segmentos[3] := segC;
  segmentos[4] := segD;
  segmentos[5] := segE;
  segmentos[6] := segF;
  segmentos[7] := segG;

  Neurona := TNeuron.Create;
  Neurona.Weights.addList(
    '-0.644800245623609,0.249989909324398,-0.361982408156283,-0.349469869133644,1.31267710164195,0.676922974600875,0.315948312627023', ',');
  Neurona.polarization := 0.12;
  Neurona.ActivactionFunction.TypeActivactionFunction := tafStep;
end;

end.
