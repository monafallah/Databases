SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_MaxPersonalStatus](@personId int,@state nvarchar(50))

RETURNS tinyint
AS
BEGIN
DECLARE  @vasiat tinyint,@date NVARCHAR(10)

if (@state='kargozini')
BEGIN
select @date=max(fldDateTaghirVaziyat) FROM Com.tblPersonalStatus  
where fldPrsPersonalInfoId=@personid
SELECT @vasiat=fldStatusId FROM Com.tblPersonalStatus 
where fldDateTaghirVaziyat=@date AND (fldPrsPersonalInfoId =@personid )
end
if (@state='hoghoghi')
BEGIN
select @date=max(fldDateTaghirVaziyat) FROM Com.tblPersonalStatus 
where fldPayPersonalInfoId =@personid
SELECT @vasiat=fldStatusId FROM Com.tblPersonalStatus 
where fldDateTaghirVaziyat=@date AND (fldPayPersonalInfoId =@personid )
end
return @vasiat 
end
GO
