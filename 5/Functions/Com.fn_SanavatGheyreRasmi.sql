SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function  [Com].[fn_SanavatGheyreRasmi](@PersonalId int)
returns  nvarchar(100)
begin
	declare @sal int ,@mah int,@roz int,@rozCount int,@CountString  nvarchar(100)=''
	SELECT @rozCount=sum( DATEDIFF(DAY,DBO.Fn_AssembelyShamsiToMiladiDate( [fldAzTarikh]), DBO.Fn_AssembelyShamsiToMiladiDate([fldTaTarikh])))
		FROM   [Prs].[tblSavabegheSanavateKHedmat] 
		WHERE  fldPersonalId = @PersonalId


	set @sal=@rozCount/365
	set @mah=(@rozCount-(@sal*365))/30.41666666666667
	set @roz=(@rozCount-(@sal*365))-(@mah*30.41666666666667)
	--select cast(@sal as nvarchar(5)) +N'سال و'+cast(@mah as nvarchar(5))+N'ماه و'+cast(@roz as nvarchar(5))+N'روز' AS CountString
	select @CountString=right('00'+cast(@sal as varchar(2)),2) +N'/'+right('00'+cast(@mah as varchar(2)),2)+N'/'+right('00'+cast(@roz as varchar(2)),2)
	return @CountString
end
GO
