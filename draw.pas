unit Draw;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, Grids, ExtCtrls, StdCtrls, math, Global, work;
           
procedure BuildFigure();
procedure BuildG(N:integer);

implementation

uses
  Cubic1;

procedure BuildFigure();
var
  i:integer;
begin
  for i:= 1 to 6 do begin
    if FCub.vsblG[i] = 1 then begin
      BuildG(i);
    end;
  end
end;

procedure BuildG(N:integer);
var
  j: array[1..4] of TPoint;
  i, X, Y:integer;
Begin
  for i:= 1 to 4 do Begin
    GlobalToLocal(FCub.G[N,i], X, Y);
    Form1.paintbox1.Canvas.Brush.Color:=FCub.ColorG[N];
    j[i]:=Point(X, Y);
  end;    
  Form1.PaintBox1.Canvas.Pen.Width:=1;
  Form1.PaintBox1.Canvas.Pen.Color:=0;
  Form1.paintbox1.Canvas.Polygon(j);
end;
end.

