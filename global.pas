unit global;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, Grids, ExtCtrls, StdCtrls, math;

type

  MATR = array of array of real;  (*Создание типа матриц(Двумерных массивов)*)
  
  TCUB = record
    V: array[1..8] of array [1..3] of real;
    R: array[1..12] of array [1..2] of integer;
    G: array[1..6] of array [1..4] of integer;
    GR: array[1..6] of array [1..4] of integer;
    Norm: array[1..6] of array [1..3] OF real;
    vsblG: array[1..6] of integer;
    ColorG: array[1..6] of TColor;
  end;

var
  Arr, A:MATR; (*Матрица*)
  N(*количество точек*), H(*Количество отрезков*), currentXS, currentYS:integer;
  CanPaint(*Возможность рисования*): boolean;
  Tint: integer;
  FCub:TCUB; 
  sn, cs: float;
  OMatr: array[1..3] of array[1..3] of real;
                 
  const
    cnstEye: array[1..3] of real = (2.8284271247461900976033774484194, 1, 1);

    cnstVCub: array[1..8] of array [1..3] of real = ((-1, -1, 1), (-1, 1, 1), (-1, 1, -1), (-1, -1, -1),
                                                     (1, -1, 1), (1, 1, 1), (1, 1, -1), (1, -1, -1));
    cnstRCub: array[1..12] of array [1..2] of integer = ((1, 2), (2, 3), (3, 4), (4, 1), (5, 6), (6, 7),
                                                      (7, 8), (8, 5), (1, 5), (2, 6), (3, 7), (4, 8));
    cnstGCub: array[1..6] of array [1..4] of integer = ((1, 2, 3, 4), (2, 3, 7, 6), (5, 6, 7, 8),
                                                     (1, 4, 8, 5), (1, 2, 6, 5), (4, 3, 7, 8));
    cnstGRCub: array[1..6] of array [1..4] of integer = ((1, 2, 3, 4), (2, 11, 6, 10), (5, 6, 7, 8),
                                                     (4, 12, 8, 9), (1, 10, 5, 9), (3, 11, 7, 12));
    cnstNormCub: array[1..6] of array [1..3] OF real = ((-1, 0, 0), (0, 1, 0), (1, 0, 0),
                                                     (0, -1, 0), (0, 0, 1), (0, 0, -1));
    cnstvsblGCub: array[1..6] of integer = (0, 1, 1, 0, 1, 0);
    cnstColorGCub: array[1..6] of TColor = (clSilver, clRed, clLime,
                                         clFuchsia, clBlue, clYellow);

implementation

end.

