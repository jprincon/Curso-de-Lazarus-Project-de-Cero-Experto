unit uTRegistroInicio;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Controls, ComCtrls, StdCtrls, Buttons, Graphics;

type

  { TRegistroInicio }

  TRegistroInicio = class(TObject)
  private
    Contenido: TPageControl;
    tabRegistro, tabInicio: TTabSheet;
    lbNombreReg, lbDocumentoReg, lbCorreoReg, lbContra1Reg, lbContra2Reg: TLabel;
    lbCorreoIni, lbContraIni: TLabel;
    edNombreReg, edDocumentoReg, edCorreoReg, edContra1Reg, edContra2Reg: TEdit;
    edCorreoIni, edContraIni: TEdit;
    sbRegistrarme, sbIniciarSesion: TSpeedButton;
  public
    constructor Create(padre: TWinControl);
    destructor Destroy; override;

    procedure ajustarPosicion(w, h: integer);
  published
  end;

implementation

{ TRegistroInicio }

constructor TRegistroInicio.Create(padre: TWinControl);
var
  margen: integer;
begin

  margen := 20;

  Contenido := TPageControl.Create(nil);
  with Contenido do
  begin
    Parent := padre;
    Width := 350;
    Height := 450;
  end;

  // Pestaña para crear el registro
  tabRegistro := TTabSheet.Create(nil);
  with tabRegistro do
  begin
    Parent := contenido;
    Caption := 'Registro';
  end;

  sbRegistrarme := TSpeedButton.Create(nil);
  with sbRegistrarme do
  begin
    parent := tabRegistro;
    Caption := 'Registrarme';
    Align := alBottom;
    Height := 45;
    BorderSpacing.Around := 5;
    BorderSpacing.Left := margen;
    BorderSpacing.Right := margen;
    flat := True;
  end;

  edContra2Reg := TEdit.Create(nil);
  with edContra2Reg do
  begin
    parent := tabRegistro;
    Align := alTop;
    BorderSpacing.Around := 5;
    BorderSpacing.Left := margen;
    BorderSpacing.Right := margen;
    Alignment := taCenter;
    PasswordChar := '*';
  end;

  lbContra2Reg := TLabel.Create(nil);
  with lbContra2Reg do
  begin
    parent := tabRegistro;
    Align := alTop;
    BorderSpacing.Around := 5;
    Alignment := taCenter;
    Caption := 'Repita la Contraseña';
    Font.Style := [fsBold];
  end;

  edContra1Reg := TEdit.Create(nil);
  with edContra1Reg do
  begin
    parent := tabRegistro;
    Align := alTop;
    BorderSpacing.Around := 5;
    BorderSpacing.Left := margen;
    BorderSpacing.Right := margen;
    Alignment := taCenter;
    PasswordChar := '*';
  end;

  lbContra1Reg := TLabel.Create(nil);
  with lbContra1Reg do
  begin
    parent := tabRegistro;
    Align := alTop;
    BorderSpacing.Around := 5;
    Alignment := taCenter;
    Caption := 'Escriba la Contraseña';
    Font.Style := [fsBold];
  end;

  edCorreoReg := TEdit.Create(nil);
  with edCorreoReg do
  begin
    parent := tabRegistro;
    Align := alTop;
    BorderSpacing.Around := 5;
    BorderSpacing.Left := margen;
    BorderSpacing.Right := margen;
    Alignment := taCenter;
    Font.Color := clBlue;
  end;

  lbCorreoReg := TLabel.Create(nil);
  with lbCorreoReg do
  begin
    parent := tabRegistro;
    Align := alTop;
    BorderSpacing.Around := 5;
    Alignment := taCenter;
    Caption := 'Ingrese su correo';
    Font.Style := [fsBold];
  end;

  edNombreReg := TEdit.Create(nil);
  with edNombreReg do
  begin
    parent := tabRegistro;
    Align := alTop;
    BorderSpacing.Around := 5;
    BorderSpacing.Left := margen;
    BorderSpacing.Right := margen;
    Alignment := taCenter;
  end;

  lbNombreReg := TLabel.Create(nil);
  with lbNombreReg do
  begin
    parent := tabRegistro;
    Align := alTop;
    BorderSpacing.Around := 5;
    Alignment := taCenter;
    Caption := 'Ingrese su nombre';
    Font.Style := [fsBold];
  end;

  edDocumentoReg := TEdit.Create(nil);
  with edDocumentoReg do
  begin
    parent := tabRegistro;
    Align := alTop;
    BorderSpacing.Around := 5;
    BorderSpacing.Left := margen;
    BorderSpacing.Right := margen;
    Alignment := taCenter;
  end;

  lbDocumentoReg := TLabel.Create(nil);
  with lbDocumentoReg do
  begin
    parent := tabRegistro;
    Align := alTop;
    BorderSpacing.Around := 5;
    BorderSpacing.Top := 20;
    Alignment := taCenter;
    Caption := 'Ingrese su documento';
    Font.Style := [fsBold];
  end;

end;

destructor TRegistroInicio.Destroy;
begin
  inherited Destroy;
end;

procedure TRegistroInicio.ajustarPosicion(w, h: integer);
var
  iLeft, iTop: integer;
begin
  iLeft := (w - Contenido.Width) div 2;
  iTop := (h - Contenido.Height) div 2;

  Contenido.Left := iLeft;
  Contenido.Top := iTop;
end;

end.
