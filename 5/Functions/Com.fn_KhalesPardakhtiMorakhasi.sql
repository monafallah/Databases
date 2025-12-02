SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create function [Com].[fn_KhalesPardakhtiMorakhasi]( @PersonalId int,@Year smallint,@Month tinyint)
returns table
return
		
SELECT       cast(ISNULL(Pay.tblMohasebat_Morakhasi.fldMablagh,0)as bigint) AS fldkhalesPardakhti
FROM         Pay.tblMohasebat_Morakhasi 
               WHERE fldPersonalId=@PersonalId and Pay.tblMohasebat_Morakhasi.fldYear=@year AND Pay.tblMohasebat_Morakhasi.fldMonth=@Month
					  and fldFlag=1
GO
