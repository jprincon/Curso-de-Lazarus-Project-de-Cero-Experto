unit uTGAMedidas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uTGAPunto, uTGARecta, Math;

type

  { TGAMedidas }

  TGAMedidas = class(TGARecta)
  private

  public
    constructor Create(n: string); override;
    destructor Destroy; override;

    function distancia: real;
    function puntoMedio: TGAPunto;
  published

  end;

implementation

{ TGAMedidas }

constructor TGAMedidas.Create(n: string);
begin
  inherited Create(n);
end;

destructor TGAMedidas.Destroy;
begin
  inherited Destroy;
end;

function TGAMedidas.distancia: real;
begin
  Result := sqrt(power(A.x - B.x, 2) + power(A.y - B.y, 2));
end;

function TGAMedidas.puntoMedio: TGAPunto;
begin
  Result := TGAPunto.Create;
  Result.Nombre := 'Pm(' + A.Nombre + B.Nombre + ')';
  Result.x := (A.x + B.x) / 2;
  Result.y := (A.y + B.y) / 2;
end;

end.
