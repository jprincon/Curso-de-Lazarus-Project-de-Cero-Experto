unit uFToast;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TFToast }

  TFToast = class(TForm)
    lbMensaje: TLabel;
    Panel1: TPanel;
    Temporizador: TTimer;
    procedure TemporizadorTimer(Sender: TObject);
  private
     cont,limite: integer;
     contando: boolean;
  public
     procedure Mostrar(mensaje: string);

     function calcularTiempo(mensaje: string): integer;
  end;

var
  FToast: TFToast;

implementation

{$R *.lfm}

{ TFToast }

procedure TFToast.TemporizadorTimer(Sender: TObject);
begin
     if contando then
     begin
       Inc(cont);

       if cont>limite then
       begin
         cont := 0;
         contando:=false;
         close;
       end;
     end;
end;

procedure TFToast.Mostrar(mensaje: string);
begin
     cont := 0;
     contando:=true;
     limite:=calcularTiempo(mensaje);
     lbMensaje.Caption:=mensaje;
     Show;
end;

function TFToast.calcularTiempo(mensaje: string): integer;
var
  lm: integer;
begin
    lm := Length(mensaje);
    result := 4*((lm div 70) + 1);
end;

end.

