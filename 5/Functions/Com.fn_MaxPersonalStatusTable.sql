SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_MaxPersonalStatusTable](@personId int)

RETURNS @t TABLE  (Id INT,statusId INT)
AS
BEGIN
DECLARE  @vasiat tinyint,@date NVARCHAR(10)

select @date=max(fldDateTaghirVaziyat) FROM Com.tblPersonalStatus 
where fldPayPersonalInfoId =@personid
INSERT INTO @t
        ( Id, statusId )
SELECT fldid,fldStatusId FROM Com.tblPersonalStatus 
where fldDateTaghirVaziyat=@date AND (fldPayPersonalInfoId =@personid )
ORDER BY fldDate DESC
return  
end


GO
