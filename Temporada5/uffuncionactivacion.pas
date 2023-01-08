unit uFFuncionActivacion;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, TAGraph, TAFuncSeries,
  TASeries;

type

  { TFGraficaFuncionActivacion }

  TFGraficaFuncionActivacion = class(TForm)
    Grafica: TChart;
    FuncionActivacion: TLineSeries;
  private

  public
      procedure borrarGrafica;
      procedure agregar(x,y: real);
  end;

var
  FGraficaFuncionActivacion: TFGraficaFuncionActivacion;

implementation

{$R *.lfm}

{ TFGraficaFuncionActivacion }

procedure TFGraficaFuncionActivacion.borrarGrafica;
begin
     FuncionActivacion.Clear;
end;

procedure TFGraficaFuncionActivacion.agregar(x,y: real);
begin
     FuncionActivacion.AddXY(x,y,'',clRed);
end;

end.

