unit uFCalculadoraFormulas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls;

type

  { TFCalculadoraFormulas }

  TFCalculadoraFormulas = class(TForm)
    bConvertirSegundos: TButton;
    Contenido: TPageControl;
    edSegundos: TEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    mLogSegundos: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    TabSheet1: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    MenuPrincipal: TTreeView;
    procedure ConvertirSegundos(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure seleccionarMenu(Sender: TObject);
  private

  public

  end;

var
  FCalculadoraFormulas: TFCalculadoraFormulas;

implementation

{$R *.lfm}

{ TFCalculadoraFormulas }

procedure TFCalculadoraFormulas.seleccionarMenu(Sender: TObject);
begin
  // ShowMessage('index = ' + IntToStr(MenuPrincipal.Selected.Index));
  Contenido.TabIndex := MenuPrincipal.Selected.Index + 1;
end;

procedure TFCalculadoraFormulas.FormCreate(Sender: TObject);
begin
  Contenido.ShowTabs := False;
  Contenido.TabIndex := 0;

  mLogSegundos.Lines.Clear;
end;

procedure TFCalculadoraFormulas.ConvertirSegundos(Sender: TObject);
var
  segundos, minutos, horas, dias: integer;
begin
  // Obtener los segundos desde la entrada
  segundos := StrToInt(edSegundos.Text);

  mLogSegundos.Lines.Add('');
  mLogSegundos.Lines.Add('=== Nueva Conversión ===');

  dias := segundos div 86400;
  mLogSegundos.Lines.Add('Días = ' + IntToStr(dias));
  segundos := segundos mod 86400;
  // mLogSegundos.Lines.Add('Segundos Restantes = ' + IntToStr(segundos));

  horas := segundos div 3600;
  mLogSegundos.Lines.Add('Horas = ' + IntToStr(horas));
  segundos := segundos mod 3600;
  // mLogSegundos.Lines.Add('Segundos Restantes = ' + IntToStr(segundos));

  minutos := segundos div 60;
  mLogSegundos.Lines.Add('Minutos = ' + IntToStr(minutos));
  segundos := segundos mod 60;
  // mLogSegundos.Lines.Add('Segundos Restantes = ' + IntToStr(segundos));
  mLogSegundos.Lines.Add('Segundos = ' + IntToStr(segundos));
end;

end.
