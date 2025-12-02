SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_GetPersonalStatusMaxDate](@fldPersonalInfoId INT,@fieldname NVARCHAR(50))
RETURNS CHAR(10)
AS
BEGIN
	DECLARE @Id NVARCHAR(50)='',@date char(10)='' 
	IF(@fieldname='fldPrs_PersonalInfo')
	SELECT  @date=MAX(fldDateTaghirVaziyat) FROM Com.tblPersonalStatus WHERE fldPrsPersonalInfoId=@fldPersonalInfoId
	if (@fieldname='fldPay_PersonalInfo')
	SELECT  @date=MAX(fldDateTaghirVaziyat) FROM Com.tblPersonalStatus WHERE fldPayPersonalInfoId=@fldPersonalInfoId
	RETURN @date

END
GO
