SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create function [dbo].[GetSeparatedNumber](@input decimal(20, 3), @separator char)
  returns varchar(41)
as
begin

declare @ST varchar(41), @STx varchar(20), @STy varchar(20)
declare @i int
declare @sign int
declare @x decimal, @y decimal
declare @part varchar(3)

set @input = isnull(@input, 0)
if @input < 0 begin
  set @sign = -1
  set @input = -@input
end
else
  set @sign = 1

set @input = @input / 1000
set @y = @input * 1000 % 1000
set @x = floor(@input)

set @i = len(@x)
set @STx = ''

while (@i > 3) begin
  set @part = cast(@x % 1000 as varchar(3))
  if len(@part) = 1
    set @part = '00' + @part
  else if len(@part) = 2
    set @part = '0' + @part

  set @STx = @separator + @part + @STx
  set @x = floor(@x / 1000)
  set @i = @i - 3
end

set @STx = cast(@x as varchar(3)) + @STx

set @STy = cast(@y as varchar(3))
  if len(@STy) = 1
    set @STy = '00' + @STy
  else if len(@STy) = 2
    set @STy = '0' + @STy

if @STy = '000'
  set @ST = @STx
else
  set @ST = @STx + '/' + @STy

if @sign < 0
  set @ST = '(' + @ST + ')'

return @ST
end
GO
