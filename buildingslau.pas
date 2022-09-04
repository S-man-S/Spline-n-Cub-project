unit BuildingSLAU;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, global, math;
           
procedure ChangeN_H(var N, H:integer; X:integer);
procedure Build3rdVariant(var A: MATR; H, N, CurX, CurY: integer);  
procedure BuildMain(var A: MATR; H, CurX, curY, j: integer);

implementation

procedure ChangeN_H(var N, H:integer; X:integer);
begin
  N+=X;
  H+=X;
end;

procedure Build3rdVariant(var A: MATR; H, N, CurX, CurY: integer);
var
  i: integer;
begin
  for i:=1 to 3 do Begin
    A[0, 4*H-4+i]:=power(N, i-1)*i;
    A[0, i]:=-1*i;
  End;
  for i:=2 to 3 do Begin
    A[1, 4*H-4+i]:=power(N, i-2)*(i*4-6);
    A[1, i]:=-1*(i*4-6);
  End;
  for i:=0 to 3 do Begin
    A[4*H-2, 4*H-4+i]:=power(N, i);
    A[4*H-1, i]:=1;
  end;
  A[4*H-2, 4*H]:=CurX;
  A[4*H-1, 4*H]:=CurX;
  A[4*H-2, 4*H+1]:=CurY;
  A[4*H-1, 4*H+1]:=CurY;
end;
 
procedure BuildMain(var A: MATR; H, CurX, curY, j: integer);
var
  i: integer;
begin
  for i:=0 to 3 do Begin
    A[j*4-2, j*4-4+i]:=power(j+1, i);
    A[j*4-1, j*4+i]:=power(j+1, i);
  end;
  for i:=1 to 3 do Begin
    A[j*4, j*4-4+i]:=power(j+1, i-1)*i;
    A[j*4, j*4+i]:=-power(j+1, i-1)*i;
  end;
  for i:=2 to 3 do Begin
    A[j*4+1, j*4-4+i]:=power(j+1, i-2)*(i*4-6);
    A[j*4+1, j*4+i]:=-power(j+1, i-2)*(i*4-6);
  end;
  A[j*4-2, 4*H]:=CurX;
  A[j*4-1, 4*H]:=CurX;
  A[j*4-2, 4*H+1]:=CurY;
  A[j*4-1, 4*H+1]:=CurY;
end;
end.

