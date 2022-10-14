unit uFTiposVariables;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls;

type

  { TFTiposVariables }

  TFTiposVariables = class(TForm)
    bCalcular: TButton;
    edNum1: TEdit;
    edNum2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    mCalcBasica: TMemo;
    paginaMenuPrincipal: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    tabCalculadora: TTabSheet;
    tabFloat: TTabSheet;
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
  a, b, c: Integer;
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

end.

