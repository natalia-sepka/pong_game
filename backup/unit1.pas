unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    lblScore: TLabel;
    lblGameOver: TLabel;
    lblRestart: TLabel;
    Paddle: TShape;
    Ball: TShape;
    tmrGame: TTimer;
    procedure ControlPaddle(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure lblRestartClick(Sender: TObject);
    procedure lblRestartMouseEnter(Sender: TObject);
    procedure lblRestartMouseLeave(Sender: TObject);
    procedure PaddleMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure tmrGameTimer(Sender: TObject);
  private
   procedure InitGame;
   procedure UpdateScore;
   procedure GameOver;
   procedure IncreaseSpeed;
  public

  end;

var
  Form1: TForm1;
  Score: Integer;
  SpeedX, SpeedY: Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ControlPaddle(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Paddle.Left := X - Paddle.Width div 2;
  Paddle.Top := ClientHeight - Paddle.Height - 2;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
  InitGame;
end;

procedure TForm1.lblRestartClick(Sender: TObject);
begin
  initGame;
end;

procedure TForm1.lblRestartMouseEnter(Sender: TObject);
begin
  lblRestart.Font.Style := [fsBold];
end;

procedure TForm1.lblRestartMouseLeave(Sender: TObject);
begin
  lblRestart.Font.Style := [];
end;

procedure TForm1.PaddleMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  ControlPaddle(Sender, Shift, X + Paddle.Left, Y + Paddle.Top);
end;

procedure TForm1.tmrGameTimer(Sender: TObject);
begin
  Ball.Left := Ball.Left + SpeedX;
  Ball.Top := Ball.Top + SpeedY;

  if Ball.Top <= 0 then SpeedY := -SpeedY;
  if (Ball.Left <= 0) or (Ball.Left + Ball.Width >= ClientWidth) then SpeedX := -SpeedX;

  if Ball.Top + Ball.Height >= ClientHeight then GameOver;

  if (Ball.Left + Ball.Width >= Paddle.Left) and (Ball.Left <= Paddle.Left + Paddle.Width)
  and (Ball.Top + Ball.Height >= Paddle.Top) then
  begin
    SpeedY := -SpeedY;
    IncreaseSpeed;
    Inc(Score);
    updateScore;
  end;
end;

procedure TForm1.InitGame;
begin
  Score := 0;
  SpeedX := 4;
  SpeedY := 4;

  lblGameOver.Visible := False;
  lblRestart.Visible := False;
  lblRestart.Font.Style := [];

  Ball.Top := 10;
  Ball.left := 10;

  UpdateScore;
end;
procedure TForm1.UpdateScore;
begin
  lblScore.Caption := 'Score: ' + IntToStr(Score);
end;
procedure TForm1.GameOver;
begin
  tmrGame.Enabled := False;
  lblGameOver.Visible := True;
  lblRestart.Visible := True;
end;

procedure TForm1.IncreaseSpeed;
begin
  if SpeedX > 0 then Inc(SpeedX) else Dec(SpeedX);
  if SpeedY > 0 then Inc(SpeedY) else Dec(SpeedY);
end;

end.

