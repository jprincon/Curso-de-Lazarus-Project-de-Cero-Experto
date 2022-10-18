unit uFReal;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls;

type

  { TFReal }

  TFReal = class(TForm)
    edValor: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    pTitulo: TPanel;
    Panel2: TPanel;
    bGuardar: TSpeedButton;
    procedure bGuardarClick(Sender: TObject);
    procedure edValorKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  private
    valor: real;
  public
    function obtenerValor(titulo: string): real;
  end;

var
  FReal: TFReal;

implementation

{$R *.lfm}

{ TFReal }

procedure TFReal.bGuardarClick(Sender: TObject);
var
  fs: TFormatSettings;
begin
  fs.DecimalSeparator := '.';
  valor := StrToFloat(edValor.Text, fs);
  Close;
end;

procedure TFReal.edValorKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 13 then
  begin
    bGuardarClick(Self);
  end;
end;

function TFReal.obtenerValor(titulo: string): real;
begin
  pTitulo.Caption := titulo;
  edValor.Text := '0';
  valor := 0;

  ShowModal; // Pausa

  Result := valor;
end;

end.
