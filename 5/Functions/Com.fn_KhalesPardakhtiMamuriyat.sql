SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create function [Com].[fn_KhalesPardakhtiMamuriyat]( @PersonalId int,@Year smallint,@Month tinyint)
returns table
return
		
SELECT      cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
FROM         Pay.tblMohasebat_Mamuriyat
WHERE fldPersonalId=@PersonalId and fldYear=@year AND fldMonth=@Month
					  and fldFlag=1
GO
