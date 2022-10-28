unit uTGARecta;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uTGAPunto, Utilidades;

type

  { TGARecta }

  TGARecta = class(TObject)
  private
    FA: TGAPunto;
    FB: TGAPunto;
    FcorteY: real;

    FNombre: string;
    Fpendiente: real;
    procedure SetA(AValue: TGAPunto);
    procedure SetB(AValue: TGAPunto);
    procedure SetcorteY(AValue: real);
    procedure SetNombre(AValue: string);
    procedure Setpendiente(AValue: real);
  public
    constructor Create(nombre: string); virtual;
    destructor Destroy; override;

    procedure calcularRecta;

    function toString: string;
    function toString(cig: boolean): string;
    function calcularPendiente: real;
    function calcularCorteY: real;
    function ordenadaOrigen: string;
    function puntoPendiente: string;
    function general: string;

  published
    property Nombre: string read FNombre write SetNombre;
    property A: TGAPunto read FA write SetA;
    property B: TGAPunto read FB write SetB;
    property pendiente: real read Fpendiente write Setpendiente;
    property corteY: real read FcorteY write SetcorteY;
  end;

implementation

{ TGARecta }

procedure TGARecta.SetNombre(AValue: string);
begin
  if FNombre = AValue then Exit;
  FNombre := AValue;
end;

procedure TGARecta.Setpendiente(AValue: real);
begin
  if Fpendiente = AValue then Exit;
  Fpendiente := AValue;
end;

procedure TGARecta.SetA(AValue: TGAPunto);
begin
  if FA = AValue then Exit;
  FA := AValue;
end;

procedure TGARecta.SetB(AValue: TGAPunto);
begin
  if FB = AValue then Exit;
  FB := AValue;
end;

procedure TGARecta.SetcorteY(AValue: real);
begin
  if FcorteY = AValue then Exit;
  FcorteY := AValue;
end;

constructor TGARecta.Create(nombre: string);
begin
  FNombre := nombre;

  FA := TGAPunto.Create;
  FA.Nombre := 'A';

  FB := TGAPunto.Create;
  FB.Nombre := 'B';
end;

destructor TGARecta.Destroy;
begin
  FA.Free;
  FB.Free;
  inherited Destroy;
end;

procedure TGARecta.calcularRecta;
begin
  calcularPendiente;
  calcularCorteY;
end;

function TGARecta.toString: string;
begin
  Result := FNombre + ' = ' + Fa.toString(False) + ' - ' + fb.toString(False);
end;

function TGARecta.toString(cig: boolean): string;
begin
  Result := FNombre + ' = ' + Fa.toString(cig) + ' - ' + fb.toString(cig);
end;

function TGARecta.calcularPendiente: real;
begin
  Fpendiente := (FB.y - FA.y) / (FB.x - FA.x);
  Result := Fpendiente;
end;

function TGARecta.calcularCorteY: real;
var
  m: real;
begin
  m := calcularPendiente;
  FcorteY := FA.y - m * FA.x;
  Result := FcorteY;
end;

function TGARecta.ordenadaOrigen: string;
begin
  calcularRecta;
  Result := 'y = ' + FloatToStrF(Fpendiente, ffNumber, 12, 2) + 'x' +
    Utilidades.valor(FcorteY);
end;

function TGARecta.puntoPendiente: string;
begin
  calcularRecta;
  Result := 'y - ' + FloatToStr(FA.y) + ' = ' +
    FloatToStrF(Fpendiente, ffNumber, 12, 2) + '(x - ' + FloatToStr(FA.x) + ')';
end;

function TGARecta.general: string;
var
  rA, rB, rC: real;
begin
  rA := (FB.y - FA.y);
  rB := -1 * (FB.x - FA.x);
  rC := FA.y * (FB.x - FA.x) - FA.x * (FB.y - FA.y);

  Result := FloatToStrF(rA, ffNumber, 12, 2) + 'x ' + Utilidades.valor(rB) +
    'y ' + Utilidades.valor(rC) + ' = 0';
end;

end.
