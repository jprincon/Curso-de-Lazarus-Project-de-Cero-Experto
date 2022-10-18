unit uFTexto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, ExtCtrls, StdCtrls;

type

  { TFTexto }

  TFTexto = class(TForm)
    bGuardar: TSpeedButton;
    edValor: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Panel2: TPanel;
    pTitulo: TPanel;
    procedure bGuardarClick(Sender: TObject);
    procedure edValorKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  private
    valor: string;
  public
    function obtenerTexto(titulo: string): string;
  end;

var
  FTexto: TFTexto;

implementation

{$R *.lfm}

{ TFTexto }

procedure TFTexto.bGuardarClick(Sender: TObject);
begin
  valor := edValor.Text;
  Close;
end;

procedure TFTexto.edValorKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if key = 13 then
    bGuardarClick(self);
end;

function TFTexto.obtenerTexto(titulo: string): string;
begin
  valor := '';
  pTitulo.Caption := titulo;
  // edValor.Clear;

  ShowModal;

  Result := valor;
end;

end.
