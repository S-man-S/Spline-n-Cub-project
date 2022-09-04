unit DrawInterpolatedLine;

{$mode objfpc}{$H+}

interface

uses
  Math, global;

procedure DrawLine(var Arr: MATR; var N, x1, y1, x2, y2: integer; s: real);

implementation

procedure DrawLine(var Arr: MATR; var N, x1, y1, x2, y2: integer; s: real);
var
  i: integer;
  x, y: real;
Begin
      x1:=x2;
      y1:=y2;
      x:=0;
      y:=0;
      for i:= 0 to 3 do Begin
        x:=x+(Arr[4*(Trunc(s)-1)+i, 0]*power(s, i));
        y:=y+(Arr[4*(Trunc(s)-1)+i, 1]*power(s, i));
      end;   
      x2:=round(x);
      y2:=round(y);
end;

end.


