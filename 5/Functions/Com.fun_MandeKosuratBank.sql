SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [Com].[fun_MandeKosuratBank] (@kosoratId int)
returns nvarchar(max)
begin
declare @title nvarchar(max),@mande int=0,@type tinyint--1=mande 2=jam
set @type=(select case when fldMandeDarFish=1 then 1 
 end as t from Pay.tblKosuratBank
where fldid=@kosoratId)
set @mande=(select case when fldMandeDarFish=1 then fldMandeAzGhabl 
 end as t from Pay.tblKosuratBank
where fldid=@kosoratId)

return isnull((SELECT     case when @type=1 then @mande-isnull(sum(fldMablagh),0) when @type=2 then @mande+isnull(sum(fldMablagh),0) END
FROM         Pay.[tblMohasebat_KosoratBank]
WHERE     (fldKosoratBankId =@kosoratId)),'')
end

GO
