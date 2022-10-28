unit uTGAPunto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TGAPunto }

  TGAPunto = class(TObject)
  private
    FNombre: string;
    Fx: real;
    Fy: real;
    procedure SetNombre(AValue: string);
    procedure Setx(AValue: real);
    procedure Sety(AValue: real);

  public
    constructor Create;
    destructor Destroy; override;

    procedure asignar(x, y: real);

    function toString: string;
    function toString(cig: boolean): string;
  published
    property x: real read Fx write Setx;
    property y: real read Fy write Sety;
    property Nombre: string read FNombre write SetNombre;
  end;

implementation

{ TGAPunto }

procedure TGAPunto.Setx(AValue: real);
begin
  if Fx = AValue then Exit;
  Fx := AValue;
end;

procedure TGAPunto.SetNombre(AValue: string);
begin
  if FNombre=AValue then Exit;
  FNombre:=AValue;
end;

procedure TGAPunto.Sety(AValue: real);
begin
  if Fy = AValue then Exit;
  Fy := AValue;
end;

constructor TGAPunto.Create;
begin

end;

destructor TGAPunto.Destroy;
begin
  inherited Destroy;
end;

procedure TGAPunto.asignar(x, y: real);
begin
  Fx := x;
  Fy := y;
end;

function TGAPunto.toString: string;
var
  fs: TFormatSettings;
begin
  fs.DecimalSeparator := '.';
  Result := FNombre+' = ( ' + FloatToStr(Fx, fs) + ' , ' + FloatToStr(Fy, fs) + ' )';
end;

function TGAPunto.toString(cig: boolean): string;
var
  fs: TFormatSettings;
begin
  fs.DecimalSeparator := '.';

  if cig then
  Result := FNombre+' = ( ' + FloatToStr(Fx, fs) + ' , ' + FloatToStr(Fy, fs) + ' )'
  else
    Result := FNombre+'( ' + FloatToStr(Fx, fs) + ' , ' + FloatToStr(Fy, fs) + ' )';
end;

end.
