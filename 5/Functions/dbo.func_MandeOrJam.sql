SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [dbo].[func_MandeOrJam] (@kosoratId int)
returns nvarchar(max)
begin
declare @title nvarchar(max),@mande int=0,@type tinyint--1=mande 2=jam
set @type=(select case when fldMondeFish=1 then 1 
when fldsumfish=1 then 2 end as t from Pay.tblKosorateParametri_Personal
where fldid=@kosoratId)
set @mande=(select case when fldMondeFish=1 then fldMondeGHabl 
when fldsumfish=1 then fldSumPardakhtiGHabl end as t from Pay.tblKosorateParametri_Personal
where fldid=@kosoratId)

return isnull((SELECT     case when @type=1 then N'(مانده:'+cast(@mande-isnull(sum(fldMablagh),0)as nvarchar(100))+')' when @type=2 then N'(جمع:'+cast(@mande+isnull(sum(fldMablagh),0)as nvarchar(100))+')'end
FROM         Pay.[tblMohasebat_kosorat/MotalebatParam]
WHERE     (fldKosoratId =@kosoratId)),'')
end

GO
