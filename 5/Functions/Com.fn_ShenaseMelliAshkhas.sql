SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_ShenaseMelliAshkhas](@AshkhasId INT)
RETURNS NVARCHAR(50)
AS
BEGIN
DECLARE @haghighiid INT,@hoghoghiid INT,@Shenase NVARCHAR(50)=''
SELECT @haghighiid=fldHaghighiId,@hoghoghiid=fldHoghoghiId FROM Com.tblAshkhas WHERE fldId=@AshkhasId

IF(@haghighiid IS NOT NULL)
SELECT @Shenase=fldCodemeli FROM Com.tblEmployee WHERE fldId=@haghighiid

ELSE IF(@hoghoghiid IS NOT NULL )
SELECT @Shenase=fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=@hoghoghiid
RETURN @Shenase
END
GO
