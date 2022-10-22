unit uFConsola;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, Buttons, Menus, SynEdit;

type

  { TFConsola }

  TTipoConsola = (tcInfo, tcWarning, tcError);

  TFConsola = class(TForm)
    iconos32: TImageList;
    lvConsola: TListView;
    menuLimpiarConsola: TMenuItem;
    mMensaje: TMemo;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    Panel1: TPanel;
    bLimpiar: TSpeedButton;
    opcionesConsola: TPopupMenu;
    Splitter1: TSplitter;
    tabConsola: TTabSheet;
    tabMensaje: TTabSheet;
    procedure bLimpiarClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvConsolaClick(Sender: TObject);

    procedure lvConsolaCustomDrawSubItem(Sender: TCustomListView;
      Item: TListItem; SubItem: integer; State: TCustomDrawState;
      var DefaultDraw: boolean);
    procedure menuLimpiarConsolaClick(Sender: TObject);
  private

  public
    procedure log(proceso: string; mensaje: string; tipo: TTipoConsola);
  end;

var
  FConsola: TFConsola;

implementation

{$R *.lfm}

{ TFConsola }

procedure TFConsola.bLimpiarClick(Sender: TObject);
begin
  lvConsola.Items.Clear;
end;

procedure TFConsola.FormResize(Sender: TObject);
begin
  log('Resize', Format('Width := %d; Height := %d; Left := %d; Top := %d',
    [Width, Height, Left, Top]), tcInfo);
end;

procedure TFConsola.FormShow(Sender: TObject);
begin
  Width := 1914;
  Height := 347;
  Left := -7;
  Top := 655;
end;

procedure TFConsola.lvConsolaClick(Sender: TObject);
begin
  if lvConsola.Selected <> nil then
  begin
    mMensaje.Lines.Clear;
    mMensaje.Lines.Add(lvConsola.Selected.SubItems[2]);
  end;
end;

procedure TFConsola.lvConsolaCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: integer; State: TCustomDrawState; var DefaultDraw: boolean);
begin
  if Item.SubItems[4] = 'tcInfo' then
  begin
    Sender.Canvas.Brush.Color := $00FFE9BB;
  end;

  if Item.SubItems[4] = 'tcWarning' then
  begin
    Sender.Canvas.Brush.Color := $00B4F3FE;
  end;

  if Item.SubItems[4] = 'tcError' then
  begin
    Sender.Canvas.Brush.Color := $00C4C4FF;
  end;
end;

procedure TFConsola.menuLimpiarConsolaClick(Sender: TObject);
begin
  bLimpiarClick(self);
end;

procedure TFConsola.log(proceso: string; mensaje: string; tipo: TTipoConsola);
begin

  with lvConsola.Items.Add do
  begin
    SubItems.Add(IntToStr(lvConsola.Items.Count));
    SubItems.Add(proceso);
    SubItems.Add(mensaje);
    SubItems.Add(DateToStr(now));

    case tipo of
      tcInfo: begin
        SubItems.Add('tcInfo');
        ImageIndex := 2;
      end;
      tcWarning: begin
        SubItems.Add('tcWarning');
        ImageIndex := 3;
      end;
      tcError: begin
        SubItems.Add('tcError');
        ImageIndex := 4;
      end;
    end;
  end;

end;

end.
