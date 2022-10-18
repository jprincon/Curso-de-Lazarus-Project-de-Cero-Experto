unit uFMensaje;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls;

type

  { TFMensaje }

  TTipoMensaje = (tmInfo, tmWarning, tmError, tmQuestion);  // Enumaración

  TFMensaje = class(TForm)
    bCancelar: TSpeedButton;
    imgLogo: TImage;
    lbMsg: TLabel;
    pBotones: TPanel;
    pTitulo: TPanel;
    bAceptar: TSpeedButton;
    procedure bAceptarClick(Sender: TObject);
    procedure bCancelarClick(Sender: TObject);
  private
    resultado: boolean;
  public
    function Mostrar(titulo: string; mensaje: string; tipo: TTipoMensaje): boolean;
  end;

var
  FMensaje: TFMensaje;

implementation

{$R *.lfm}

{ TFMensaje }

procedure TFMensaje.bAceptarClick(Sender: TObject);
begin
    resultado:=true;
    close;
end;

procedure TFMensaje.bCancelarClick(Sender: TObject);
begin
    resultado:=false;
    close;
end;

function TFMensaje.Mostrar(titulo: string; mensaje: string;
  tipo: TTipoMensaje): boolean;
begin
  pTitulo.Caption := titulo;
  lbMsg.Caption := mensaje;

  case tipo of

    tmInfo: begin
      imgLogo.Picture.LoadFromFile('Imagenes\info.png');
      bCancelar.Visible:=false;
      pTitulo.Color:=$00C08000;
    end;

    tmQuestion: begin
      imgLogo.Picture.LoadFromFile('Imagenes\question.png');
      pTitulo.Color:=$00C08000;
      bCancelar.Visible:=true;
    end;

    tmWarning: begin
      imgLogo.Picture.LoadFromFile('Imagenes\warning.png');
      bCancelar.Visible:=false;
      pTitulo.Color:=$003BB9F6;
    end;

    tmError: begin
      imgLogo.Picture.LoadFromFile('Imagenes\error.png');
      bCancelar.Visible:=false;
      pTitulo.Color:=$004E55E5;
    end;
  end;

  ShowModal; // Pausa

  result := resultado;
end;

end.
