unit uTAutor;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ExtCtrls, Controls, StdCtrls, Graphics;

type

  { TAutor }

  TAutor = class(TObject)
  private
    pContenido, pContenido2: TPanel;
    iFoto: TImage;
    lbNombre, lbCorreo, lbBiografia: TLabel;
  public
    constructor Create(padre: TWinControl);
    destructor Destroy; override;

    procedure cargarFotoAutor(ruta: string);
    procedure datosAutor(foto, nombre, correo, biografia: string);
  published
  end;

implementation

{ TAutor }

constructor TAutor.Create(padre: TWinControl);
begin
  pContenido := TPanel.Create(nil);
  with pContenido do
  begin
    Parent := padre;
    Align := alTop;
    BorderSpacing.Around := 10;
    BorderStyle := bsSingle;
    BevelOuter := bvNone;
    Height := 200;
  end;

  iFoto := TImage.Create(nil);
  with iFoto do
  begin
    Parent := pContenido;
    Align := alLeft;
    Width := 200;
    BorderSpacing.Around := 5;
    Proportional := True;
    Center := True;
  end;

  pContenido2 := TPanel.Create(nil);
  with pContenido2 do
  begin
    Parent := pContenido;
    Align := alClient;
    BorderSpacing.Around := 10;
    BevelOuter := bvNone;
  end;

  lbBiografia := TLabel.Create(nil);
  with lbBiografia do
  begin
    Parent := pContenido2;
    Align := alClient;
    BorderSpacing.Around := 10;
    Caption := 'Biografía ...';
    Font.Size := 12;
    Font.Style := [];
    Font.Color := clBlack;
    WordWrap := True;
  end;

  lbCorreo := TLabel.Create(nil);
  with lbCorreo do
  begin
    Parent := pContenido2;
    Align := alTop;
    BorderSpacing.Around := 10;
    Caption := 'Autor@Dominio.com';
    Font.Size := 16;
    Font.Style := [fsUnderline];
    Font.Color := clBlue;
  end;

  lbNombre := TLabel.Create(nil);
  with lbNombre do
  begin
    Parent := pContenido2;
    Align := alTop;
    BorderSpacing.Around := 10;
    Caption := 'Autor';
    Font.Size := 20;
    Font.Style := [fsbold];
    Font.Color := $00C08000;
  end;

end;

destructor TAutor.Destroy;
begin
  inherited Destroy;
end;

procedure TAutor.cargarFotoAutor(ruta: string);
begin
  iFoto.Picture.LoadFromFile(ruta);
end;

procedure TAutor.datosAutor(foto, nombre, correo, biografia: string);
begin
  iFoto.Picture.LoadFromFile(foto);
  lbNombre.Caption := nombre;
  lbCorreo.Caption := correo;
  lbBiografia.Caption := biografia;
end;

end.
