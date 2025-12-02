SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Com].[spr_DiffDayMahSal](@rozCount int)
as
declare @sal int ,@mah int,@roz int
set @sal=@rozCount/365
set @mah=(@rozCount-(@sal*365))/30.41666666666667
set @roz=(@rozCount-(@sal*365))-(@mah*30.41666666666667)
select cast(@sal as nvarchar(5)) +N'سال و'+cast(@mah as nvarchar(5))+N'ماه و'+cast(@roz as nvarchar(5))+N'روز' AS CountString
--select cast(@sal as nvarchar(5)) +N'/'+cast(@mah as nvarchar(5))+N'/'+cast(@roz as nvarchar(5))AS CountString
GO
