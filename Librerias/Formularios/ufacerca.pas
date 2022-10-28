unit uFAcerca;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, uTAutor, Contnrs;

type

  { TFAcerca }

  TFAcerca = class(TForm)
    Contenido: TPageControl;
    iconos24: TImageList;
    lbAcerca: TLabel;
    lvReq: TListView;
    TabRequisitos: TTabSheet;
    TabAutores: TTabSheet;
    TabManual: TTabSheet;
    procedure FormCreate(Sender: TObject);
  private
    listAutores: TObjectList;
    procedure crearRequisito(nombre, valor: string; imagen: integer);
  public
    procedure crearAutores;
    procedure memoriaRam(valor: string);
    procedure discoDuro(valor: string);
    procedure pantalla(valor: string);
    procedure sistemaOperativo(valor: string);

    procedure agregarAutor(foto, nombre, correo, biografia: string);

    procedure acerca(msg: string);
  end;

var
  FAcerca: TFAcerca;

implementation

{$R *.lfm}

{ TFAcerca }

procedure TFAcerca.FormCreate(Sender: TObject);
begin
  listAutores := TObjectList.Create(True);
  crearAutores;
end;

procedure TFAcerca.crearRequisito(nombre, valor: string; imagen: integer);
begin
  with lvReq.Items.Add do
  begin
    SubItems.Add(IntToStr(lvReq.Items.Count));
    SubItems.Add(nombre);
    SubItems.Add(valor);

    ImageIndex:=imagen;
  end;
end;

procedure TFAcerca.crearAutores;
begin

end;

procedure TFAcerca.memoriaRam(valor: string);
begin
  crearRequisito('Memoria RAM', valor, 1);
end;

procedure TFAcerca.discoDuro(valor: string);
begin
  crearRequisito('Disco duro', valor, 0);
end;

procedure TFAcerca.pantalla(valor: string);
begin
  crearRequisito('Pantalla', valor, 2);
end;

procedure TFAcerca.sistemaOperativo(valor: string);
begin
  crearRequisito('Sistema Operativo', valor, 3);
end;

procedure TFAcerca.agregarAutor(foto, nombre, correo, biografia: string);
var
  Autor: TAutor;
begin
  Autor := TAutor.Create(TabAutores);
  Autor.datosAutor(foto, nombre, correo, biografia);
  listAutores.Add(Autor);
end;

procedure TFAcerca.acerca(msg: string);
begin
  lbAcerca.Caption:=msg;
end;

end.
