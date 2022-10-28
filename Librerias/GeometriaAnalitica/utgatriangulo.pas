unit uTGATriangulo;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uTGAPunto, uTGAMedidas, Math;

type

  { TGATriangulo }

  TGATriangulo = class(TObject)
  private
    FA: TGAPunto;
    FB: TGAPunto;
    FC: TGAPunto;
    FmedidaA: real;
    FmedidaB: real;
    FmedidaC: real;
    Medida: TGAMedidas;
    procedure SetA(AValue: TGAPunto);
    procedure SetB(AValue: TGAPunto);
    procedure SetC(AValue: TGAPunto);
    procedure SetmedidaA(AValue: real);
    procedure SetmedidaB(AValue: real);
    procedure SetmedidaC(AValue: real);
  public
    constructor Create;
    destructor Destroy; override;

    function perimetro: real;
    function area: real;
  published
    property A: TGAPunto read FA write SetA;
    property B: TGAPunto read FB write SetB;
    property C: TGAPunto read FC write SetC;

    property medidaA: real read FmedidaA write SetmedidaA;
    property medidaB: real read FmedidaB write SetmedidaB;
    property medidaC: real read FmedidaC write SetmedidaC;
  end;

implementation

{ TGATriangulo }

procedure TGATriangulo.SetA(AValue: TGAPunto);
begin
  if FA = AValue then Exit;
  FA := AValue;
end;

procedure TGATriangulo.SetB(AValue: TGAPunto);
begin
  if FB = AValue then Exit;
  FB := AValue;
end;

procedure TGATriangulo.SetC(AValue: TGAPunto);
begin
  if FC = AValue then Exit;
  FC := AValue;
end;

procedure TGATriangulo.SetmedidaA(AValue: real);
begin
  if FmedidaA = AValue then Exit;
  FmedidaA := AValue;
end;

procedure TGATriangulo.SetmedidaB(AValue: real);
begin
  if FmedidaB = AValue then Exit;
  FmedidaB := AValue;
end;

procedure TGATriangulo.SetmedidaC(AValue: real);
begin
  if FmedidaC = AValue then Exit;
  FmedidaC := AValue;
end;

constructor TGATriangulo.Create;
begin
  FA := TGAPunto.Create;
  FA.Nombre := 'A';

  FB := TGAPunto.Create;
  FB.Nombre := 'B';

  FC := TGAPunto.Create;
  FC.Nombre := 'C';

  Medida := TGAMedidas.Create('Medidas');
end;

destructor TGATriangulo.Destroy;
begin
  inherited Destroy;
end;

function TGATriangulo.perimetro: real;
begin
  Medida.A := FA;
  Medida.B := FB;
  FmedidaA := Medida.distancia;

  Medida.A := FA;
  Medida.B := FC;
  FmedidaB := Medida.distancia;

  Medida.A := FB;
  Medida.B := FC;
  FmedidaC := Medida.distancia;

  Result := FmedidaA + FmedidaB + FmedidaC;
end;

function TGATriangulo.area: real;
var
  s: real;
begin
  s := perimetro / 2;
  Result := sqrt(s * (s - FmedidaA) * (s - FmedidaB) * (s - FmedidaC));
end;

end.
