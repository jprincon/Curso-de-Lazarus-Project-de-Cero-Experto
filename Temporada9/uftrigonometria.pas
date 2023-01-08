unit uFTrigonometria;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  uTRegistroInicio;

type

  { TFSAETrigonometria }

  TFSAETrigonometria = class(TForm)
    Contenido: TPageControl;
    Edit1: TEdit;
    TabRegistroInicio: TTabSheet;
    TabContenido: TTabSheet;
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
        RegistroInicio: TRegistroInicio;
  public
       procedure configuracion;
       procedure crearRegistroInicio;
  end;

var
  FSAETrigonometria: TFSAETrigonometria;

implementation

{$R *.lfm}

{ TFSAETrigonometria }

procedure TFSAETrigonometria.FormCreate(Sender: TObject);
begin
     configuracion;
     crearRegistroInicio;

     {TPageControl TLabel}

end;

procedure TFSAETrigonometria.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     Edit1.Text := IntToStr(key);
end;

procedure TFSAETrigonometria.FormResize(Sender: TObject);
begin
     RegistroInicio.ajustarPosicion(Width, Height);
end;

procedure TFSAETrigonometria.configuracion;
begin
     Contenido.ActivePage := TabRegistroInicio;
     Contenido.ShowTabs:=false;
end;

procedure TFSAETrigonometria.crearRegistroInicio;
begin
     RegistroInicio := TRegistroInicio.Create(TabRegistroInicio);
end;

end.

