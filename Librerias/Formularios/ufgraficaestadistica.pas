unit uFGraficaEstadistica;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Grids, Graphics, Dialogs, Menus, ComCtrls,
  ExtCtrls, StdCtrls, Buttons, Utilidades, uFMensaje, TAGraph, TASeries;

type

  { TFGraficas }

  TTipoGrafico = (tgBarras, tgLineal, tgArea, tgCircular);

  TFGraficas = class(TForm)
    cbVerTitulo: TCheckBox;
    cbBarras: TCheckBox;
    cbCircular: TCheckBox;
    cbAreas: TCheckBox;
    cbLineal: TCheckBox;
    cbVerTituloHorizontal: TCheckBox;
    cbVerTituloVertical: TCheckBox;
    dlgColores: TColorDialog;
    diagramaBarras: TBarSeries;
    dlgFuente: TFontDialog;
    edTitulo: TEdit;
    edGruesoLinea: TEdit;
    edTituloEjeHorizontal: TEdit;
    edTituloEjeVertical: TEdit;
    Grafico: TChart;
    Contenido: TPageControl;
    diagramaLineal: TLineSeries;
    diagramaAreas: TAreaSeries;
    diagramaCircular: TPieSeries;
    MenuPrincipal: TPageControl;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    dlgExportarGrafica: TSaveDialog;
    sbExportarGrafica: TSpeedButton;
    sbCambiarColorArea: TSpeedButton;
    sbFuente1: TSpeedButton;
    sbFuente2: TSpeedButton;
    sbFuente3: TSpeedButton;
    sbCambiarColorLinea: TSpeedButton;
    sbActualizarGrafica: TSpeedButton;
    TabGrafica: TTabSheet;
    TabMenu: TTabSheet;
    tabEjes: TTabSheet;
    procedure cbBarrasClick(Sender: TObject);
    procedure cbVerTituloChange(Sender: TObject);
    procedure edGruesoLineaKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure sbActualizarGraficaClick(Sender: TObject);
    procedure sbCambiarColorLineaClick(Sender: TObject);
    procedure sbExportarGraficaClick(Sender: TObject);
    procedure verOcultarTitulos(Sender: TObject);
    procedure cambiarTituloGrafico(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure sbFuente1Click(Sender: TObject);
  private
    sgDatos: TStringGrid;
    tipoGrafico: TTipoGrafico;
  public
    procedure graficar(datos: TStringGrid; tipoGraf: TTipoGrafico);
    procedure realizarGrafica;
  end;

var
  FGraficas: TFGraficas;

implementation

{$R *.lfm}

{ TFGraficas }

procedure TFGraficas.verOcultarTitulos(Sender: TObject);
begin
  Grafico.BottomAxis.Title.Visible := cbVerTituloHorizontal.Checked;
  Grafico.LeftAxis.Title.Visible := cbVerTituloVertical.Checked;
  Grafico.Title.Visible := cbVerTitulo.Checked;
end;

procedure TFGraficas.cbVerTituloChange(Sender: TObject);
begin

end;

procedure TFGraficas.cbBarrasClick(Sender: TObject);
begin
  diagramaAreas.Clear;
  diagramaBarras.Clear;
  diagramaCircular.Clear;
  diagramaLineal.Clear;

  if cbBarras.Checked then
  begin
    tipoGrafico := tgBarras;
    realizarGrafica;
  end;

  if cbLineal.Checked then
  begin
    tipoGrafico := tgLineal;
    realizarGrafica;
  end;

  if cbAreas.Checked then
  begin
    tipoGrafico := tgArea;
    realizarGrafica;
  end;

  if cbCircular.Checked then
  begin
    tipoGrafico := tgCircular;
    realizarGrafica;
  end;

end;

procedure TFGraficas.edGruesoLineaKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if key = $0D then
  begin
    diagramaLineal.LinePen.Width := StrToInt(edGruesoLinea.Text);
    diagramaAreas.AreaContourPen.Width := StrToInt(edGruesoLinea.Text);
  end;
end;

procedure TFGraficas.sbActualizarGraficaClick(Sender: TObject);
begin
  realizarGrafica;
end;

procedure TFGraficas.sbCambiarColorLineaClick(Sender: TObject);
begin
  if dlgColores.Execute then
  begin

    if Sender = sbCambiarColorLinea then
    begin
      diagramaLineal.LinePen.Color := dlgColores.Color;
      diagramaAreas.AreaContourPen.Color := dlgColores.color;
    end;

    if Sender = sbCambiarColorArea then
    begin
      diagramaAreas.AreaBrush.Color := dlgColores.color;
    end;
  end;
end;

procedure TFGraficas.sbExportarGraficaClick(Sender: TObject);
var
  ruta: string;
begin
  if dlgExportarGrafica.Execute then
  begin
    ruta := dlgExportarGrafica.FileName;
    ruta := Utilidades.comprobarExtension(ruta, '.bmp');

    Grafico.SaveToBitmapFile(ruta);
    FMensaje.Mostrar('Información', 'La gráfica se exportó correctamente', tmInfo);
  end;
end;

procedure TFGraficas.cambiarTituloGrafico(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Sender = edTituloEjeHorizontal then
    Grafico.BottomAxis.Title.Caption := edTituloEjeHorizontal.Text;

  if Sender = edTituloEjeVertical then
    Grafico.LeftAxis.Title.Caption := edTituloEjeVertical.Text;

  if Sender = edTitulo then
    Grafico.Title.Text.Text := edTitulo.Text;
end;

procedure TFGraficas.sbFuente1Click(Sender: TObject);
begin
  if dlgFuente.Execute then
  begin

    if Sender = sbFuente1 then
      Grafico.BottomAxis.Title.LabelFont := dlgFuente.Font;

    if Sender = sbFuente2 then
      Grafico.LeftAxis.Title.LabelFont := dlgFuente.Font;

    if Sender = sbFuente3 then
      Grafico.Title.Font := dlgFuente.Font;
  end;
end;

procedure TFGraficas.graficar(datos: TStringGrid; tipoGraf: TTipoGrafico);
begin
  sgDatos := datos;
  tipoGrafico := tipoGraf;

  case tipoGrafico of
    tgBarras: cbBarras.Checked := True;
    tgLineal: cbLineal.Checked := True;
    tgArea: cbAreas.Checked := True;
    tgCircular: cbCircular.Checked := True;
  end;

  Contenido.ActivePage := TabGrafica;
  realizarGrafica;
  Show;
end;

procedure TFGraficas.realizarGrafica;
var
  datoY: real;
  datoX: string;
  i: integer;
  fs: TFormatSettings;
begin
  fs.DecimalSeparator := '.';

  case tipoGrafico of

    {Diagrama de Barras}
    tgBarras: begin
      // cbBarras.Checked := True;
      diagramaBarras.Clear;

      for i := 1 to sgDatos.RowCount - 1 do
      begin
        datoX := sgDatos.Cells[1, i];
        datoY := StrToFloat(sgDatos.Cells[2, i], fs);

        diagramaBarras.Add(datoY, datoX, Utilidades.generarColor);
      end;
    end;

    {Diagrama Lineal}
    tgLineal: begin
      cbLineal.Checked := True;
      diagramaLineal.Clear;

      for i := 1 to sgDatos.RowCount - 1 do
      begin
        datoX := sgDatos.Cells[1, i];
        datoY := StrToFloat(sgDatos.Cells[2, i], fs);

        diagramaLineal.Add(datoY, datoX, Utilidades.generarColor);
      end;
    end;

    {Diagrama Áreas}
    tgArea: begin
      cbAreas.Checked := True;
      diagramaAreas.Clear;

      for i := 1 to sgDatos.RowCount - 1 do
      begin
        datoX := sgDatos.Cells[1, i];
        datoY := StrToFloat(sgDatos.Cells[2, i], fs);

        diagramaAreas.Add(datoY, datoX, Utilidades.generarColor);
      end;
    end;

    {Diagrama Circular}
    tgCircular: begin
      cbCircular.Checked := False;
      diagramaCircular.Clear;

      for i := 1 to sgDatos.RowCount - 1 do
      begin
        datoX := sgDatos.Cells[1, i];
        datoY := StrToFloat(sgDatos.Cells[2, i], fs);

        diagramaCircular.Add(datoY, datoX, Utilidades.generarColor);
      end;
    end;

  end;
end;

end.
