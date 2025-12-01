SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create function [dbo].[fn_CheckValidCreditCard](@card varchar(16))
returns tinyint 
begin
--declare @card varchar(16)='5892101656071425'
declare @i tinyint=1,@sum smallint=0,@n smallint=0,@Check tinyint=0
while (@i<=len(@card))
begin
	if(@i%2=0)
	begin
		set @n= cast( substring(@card,@i,1) as tinyint)
		set @sum=@sum+@n
	end
	else
	begin
		set @n= cast( substring(@card,@i,1) as tinyint)*2
		set @sum=@sum+case when @n>9 then @n-9 else @n end
	end
	set @i=@i+1
end

set @check= case when @sum%10=0 then 1 else 0 end 
return @check
end
GO
