SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create FUNCTION [dbo].[ShamsiToMiladi](@FD NCHAR(50))
RETURNS smalldatetime AS  
begin
	Declare @syy bigint 
	Declare @smm bigint 
	Declare @sdd bigint 
	Declare @val  bigint 
	Declare @By bigint 
	declare  @mstart datetime 
	declare @Mc  int

	declare @sbase int
	declare @sleapbmp nchar(150)
	declare @ind as int

	
	
--	set @fd='1384/02/11'
	set @mstart = '1900/03/21'

	set @syy = substring(@FD,1,4)
	set @smm = substring(@FD,6,2)
	set @sdd = substring(@FD,9,2)
	set @By = '1279'

	set @sleapbmp='00001000100010001000100010001000010001000100010001000100010001000010001000100010001000100010001000010001000100010001000100010001'
	set @sbase=475

--	print @smm

	   set   @val = 0

	   While (@By < @syy)
                 begin
	
	set @ind = (@By - @sbase) % (128 + 1)
		if   substring(@sleapbmp, @ind, 1)  ='1'
			  Begin	
			         set @val = @val + 1
		                 end		

		      set @val = @val + 365
		      set @By = @By + 1
	  end

	  set @Mc=1
	  while  @mc< @smm
			
		  begin 
		    Select @val =Case 
			When @Mc= 1 Then @Val+31 
			When @Mc= 2 Then @Val+31 
			When @Mc= 3 Then @Val+31 
			When @Mc= 4 Then @Val+31 
			When @Mc= 5 Then @Val+31 
			When @Mc= 6 Then @Val+31 
			When @Mc= 7 Then @Val+30
			When @Mc= 8 Then @Val+30 
			When @Mc= 9 Then @Val+30 
			When @Mc= 10 Then @Val+30 
			When @Mc= 11 Then @Val+30 
			When @Mc= 12 Then @Val+29
		end
	            set @mc=@mc+1	
    end
		set @val = @val + @sdd
	   	return   DATEADD(day,@val,@mstart ) 
end

GO
