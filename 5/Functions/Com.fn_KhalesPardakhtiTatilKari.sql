SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [Com].[fn_KhalesPardakhtiTatilKari]( @PersonalId int,@Year smallint,@Month tinyint,@type tinyint)
returns table
return
		
select cast(ISNULL( Pay.tblMohasebatEzafeKari_TatilKari.fldKhalesPardakhti ,0)as bigint)fldKhalesPardakhti
FROM         Pay.tblMohasebatEzafeKari_TatilKari
WHERE fldPersonalId=@PersonalId and Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@year AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month
					  AND fldType=@type and fldFlag=1
GO
