SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create function [Dead].[fn_LinkGoogleMap](@OBJECTID int)
returns varchar(max)
as 
begin
declare @address varchar(max)
/*SELECT 
 @address=  
 'https://www.google.com/maps?q=' +
  CAST(
    DEGREES(
      ATAN(
        (EXP(shape.STEnvelope().STPointN(1).STY * PI() / 20037508.34) - EXP(-(shape.STEnvelope().STPointN(1).STY * PI() / 20037508.34))) / 2
      )
    ) AS VARCHAR(20)
  ) + ',' +
  CAST(
    (shape.STEnvelope().STPointN(1).STX * 180 / 20037508.34)
    AS VARCHAR(20)
  ) 
FROM  AramDB.dbo.RECATANGLE_6
WHERE OBJECTID = @OBJECTID*/
return @address
end 

GO
