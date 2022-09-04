unit Work;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
    ComCtrls, Grids, ExtCtrls, StdCtrls, math, Global, DrawInterpolatedLine;

  procedure ChangeOX(MoreLess: integer);
  procedure ChangeOY(MoreLess: integer);
  procedure ChangeOZ(MoreLess: integer);
  procedure MatrMulti();
  procedure ReChanges();
  procedure FindNorm();
  procedure FindVectorLength(CurG:integer; Var x1, y1, z1, x2, y2, z2:real);
  procedure Visibility();
  procedure GlobalToLocal(N: integer; var LocalX, LocalY: integer);

implementation

uses
  Cubic1;

procedure FindVectorLength(CurG:integer; Var x1, y1, z1, x2, y2, z2:real);
begin
  x1:=FCub.V[FCub.G[CurG, 3], 1]-FCub.V[FCub.G[CurG, 2], 1];
  y1:=FCub.V[FCub.G[CurG, 3], 2]-FCub.V[FCub.G[CurG, 2], 2];
  z1:=FCub.V[FCub.G[CurG, 3], 3]-FCub.V[FCub.G[CurG, 2], 3];
  x2:=FCub.V[FCub.G[CurG, 2], 1]-FCub.V[FCub.G[CurG, 1], 1];
  y2:=FCub.V[FCub.G[CurG, 2], 2]-FCub.V[FCub.G[CurG, 1], 2];
  z2:=FCub.V[FCub.G[CurG, 2], 3]-FCub.V[FCub.G[CurG, 1], 3];
end;

procedure Visibility();
var
  i, j: integer;
  cs: array[1..6] of float;
begin
  for i:= 1 to 6 do begin
    cs[i]:= 0;
  end;
  for j:= 1 to 3 do begin
    for i:=1 to 6 do begin
      cs[i]+= FCub.Norm[i, j]*cnstEye[j];
      if cs[i]>0 then begin
        FCub.vsblG[i]:= 1;
      end
      else begin  
        FCub.vsblG[i]:= 0;
      end;
    end;
  end;
end;

procedure FindNorm();
var
  i: integer;
  x1, y1, z1, x2, y2, z2: real;
begin
  for i:=1 to 6 do begin
    if ((i = 1) or (i = 4) or (i = 6)) then begin
      FindVectorLength(i, x2, y2, z2, x1, y1, z1);
    end
    else begin
      FindVectorLength(i, x1, y1, z1, x2, y2, z2);
    end;
    FCub.Norm[i, 1] :=(y1*z2-z1*y2)/4;  
    FCub.Norm[i, 2] :=-(x1*z2-z1*x2)/4;
    FCub.Norm[i, 3] :=(x1*y2-y1*x2)/4;
  end;
end;

procedure Rechanges();
var
  i, j:integer;
begin
  //Form1.labelededit2.text:=IntToStr(0);
  //Form1.labelededit3.text:=IntToStr(0);
  //Form1.labelededit4.text:=IntToStr(0);
  //Form1.Timer1.Enabled:= False;

  //Form1.stringgrid1.RowCount:=NVall+1;
  //Form1.stringgrid2.RowCount:=NG+1;
  //Form1.stringgrid3.RowCount:=NG+1;

  FCub.V := cnstVCub;
  Fcub.R := cnstRCub;
  FCub.G := cnstGCub;
  FCub.GR := cnstGRCub;
  FCub.Norm := cnstNormCub;
  FCub.vsblG := cnstvsblGCub;
  FCub.ColorG := cnstColorGCub;

  //for j:= 1 to 3 do begin
    //for i:=1 to NVall do begin
      //Form1.stringgrid1.Cells[j, i]:=FloatToStr(FCub.V[i,j]);
    //end;
    //for i:=1 to NG do begin
      //Form1.stringgrid2.Cells[j, i]:=FloatToStr(FCub.Norm[i,j]);
      //Form1.stringgrid3.Cells[1, i]:=FloatToStr(FCub.vsblG[i]);
    //end;
  //end;
end;

procedure MatrMulti();
var
  i,j,z: integer;
  XYZ: array[1..100] of array[1..3] of real;
begin
  for i:= 1 to 8 do
    for j:= 1 to 3 do
      XYZ[i,j]:=0;
  for i:= 1 to 3 do
    for j:= 1 to 3 do
      for z:= 1 to 8 do begin
        XYZ[z,i]+=OMatr[i,j]*FCUB.V[z,j];
      end;
  for i:= 1 to 8 do
    for j:= 1 to 3 do begin
      FCUB.V[i,j]:=XYZ[i,j];
    end;
  FindNorm();
  Visibility();
end;

{ TForm1 }
procedure ChangeOX(MoreLess: integer);
begin
  OMATR[1, 1]:=1;
  OMATR[1, 2]:=0;
  OMATR[1, 3]:=0;
  OMATR[2, 1]:=0;
  OMATR[3, 1]:=0;
  OMATR[2, 2]:= cs;
  OMATR[2, 3]:= sn*MoreLess;
  OMATR[3, 2]:= -sn*MoreLess;
  OMATR[3, 3]:= cs;
  MatrMulti();
end;

procedure ChangeOY(MoreLess: integer);
begin
  OMATR[2, 2]:=1;
  OMATR[1, 2]:=0;
  OMATR[2, 1]:=0;
  OMATR[2, 3]:=0;
  OMATR[3, 2]:=0;
  OMATR[1, 1]:= cs;
  OMATR[1, 3]:= sn*MoreLess;
  OMATR[3, 1]:= -sn*MoreLess;
  OMATR[3, 3]:= cs;
  MatrMulti();
end;

procedure ChangeOZ(MoreLess: integer);
begin
  OMATR[3, 3]:=1;
  OMATR[2, 3]:=0;
  OMATR[1, 3]:=0;
  OMATR[3, 1]:=0;
  OMATR[3, 2]:=0;
  OMATR[1, 1]:= cs;
  OMATR[1, 2]:= sn*MoreLess;
  OMATR[2, 1]:= -sn*MoreLess;
  OMATR[2, 2]:= cs;
  MatrMulti();
end;

procedure GlobalToLocal(N: integer; var LocalX, LocalY: integer);
Var
  s: float;
  x1, x2, y1, y2:integer;
begin
  s:= 1 + Form1.UpDown1.Position/10;
  DrawLine(Arr, N, x1, y1, x2, y2, s);
  LocalX:=trunc(x2+FCub.V[N, 2]*Form1.UpDown2.Position-FCub.V[N, 1]*Form1.UpDown2.Position*power(2, -3/2));
  LocalY:=trunc(y2-FCub.V[N, 3]*Form1.UpDown2.Position+FCub.V[N, 1]*Form1.UpDown2.Position*power(2, -3/2));
end;

end.

