SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create function [Com].[fn_SayerPardakht]( @PersonalId int,@Year smallint,@Month tinyint)
returns table
return
		
select cast(ISNULL(  Pay.tblSayerPardakhts.fldKhalesPardakhti ,0)as bigint)fldKhalesPardakhti
FROM         Pay.tblSayerPardakhts
WHERE fldPersonalId=@PersonalId and Pay.tblSayerPardakhts.fldYear=@year AND Pay.tblSayerPardakhts.fldMonth=@Month
					  and fldFlag=1
GO
