unit uFImportarCSV;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, Buttons, SynEdit, Grids;

type

  { TFImportarCSV }

  TTipoAccionCSV = (taImportando, taExportando);

  TFImportarCSV = class(TForm)
    edDelimitador: TEdit;
    GroupBox1: TGroupBox;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    pTitulo: TPanel;
    Panel2: TPanel;
    seDatos: TSynEdit;
    sbImportar: TSpeedButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure edDelimitadorKeyUp(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure sbImportarClick(Sender: TObject);
  private
    sgDatos: TStringGrid;
    tipo: TTipoAccionCSV;
  public
    procedure importar(ruta: string);
    procedure exportar(sg: TStringGrid);
    procedure generarCSV(sg: TStringGrid);

    function delimitador: char;
  end;

var
  FImportarExportarCSV: TFImportarCSV;

implementation

{$R *.lfm}

{ TFImportarCSV }

procedure TFImportarCSV.sbImportarClick(Sender: TObject);
begin
  Close;
end;

procedure TFImportarCSV.edDelimitadorKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if tipo = taExportando then
    generarCSV(sgDatos);
end;

procedure TFImportarCSV.exportar(sg: TStringGrid);
begin
  pTitulo.Caption := 'Exportando Archivo CSV';
  sbImportar.Caption := 'Exportar CSV';

  sgDatos := sg;
  generarCSV(sg);
  tipo := taExportando;

  ShowModal;
end;

procedure TFImportarCSV.generarCSV(sg: TStringGrid);
var
  sRow: string;
  i, j: integer;
begin
  seDatos.Lines.Clear;

  for j := 0 to sg.RowCount - 1 do
  begin
    sRow := '';

    for i := 0 to sg.ColCount - 2 do
    begin
      sRow := sRow + sg.Cells[i, j] + delimitador;
    end;
    sRow := sRow + sg.Cells[i + 1, j];

    seDatos.Lines.Add(sRow);
  end;
end;

procedure TFImportarCSV.importar(ruta: string);
begin
  pTitulo.Caption := 'Importando Archivo CSV';
  seDatos.Lines.LoadFromFile(ruta);
  sbImportar.Caption := 'Importar CSV';
  tipo := taImportando;
  ShowModal;
end;

function TFImportarCSV.delimitador: char;
begin
  Result := edDelimitador.Text[1];
end;

end.
