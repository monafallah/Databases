SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblPersonalStatusSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT        TOP (@h) Com.tblPersonalStatus.fldId, Com.tblPersonalStatus.fldStatusId, Com.tblPersonalStatus.fldPrsPersonalInfoId, Com.tblPersonalStatus.fldPayPersonalInfoId, Com.tblPersonalStatus.fldDateTaghirVaziyat, 
                         Com.tblPersonalStatus.fldUserId, Com.tblPersonalStatus.fldDate, Com.tblPersonalStatus.fldDesc, Com.tblStatus.fldTitle
FROM            Com.tblPersonalStatus INNER JOIN
                         Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId 
	WHERE  Com.tblPersonalStatus.fldId = @Value
	
	
	if (@fieldname=N'fldPrsPersonalInfoId')
		SELECT     TOP (@h) Com.tblPersonalStatus.fldId, Com.tblPersonalStatus.fldStatusId, Com.tblPersonalStatus.fldPrsPersonalInfoId, 
                      Com.tblPersonalStatus.fldPayPersonalInfoId, Com.tblPersonalStatus.fldDateTaghirVaziyat, 
                      Com.tblPersonalStatus.fldUserId, Com.tblPersonalStatus.fldDate, Com.tblPersonalStatus.fldDesc, Com.tblStatus.fldTitle
FROM            Com.tblPersonalStatus INNER JOIN
                         Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId 
                      WHERE  fldPrsPersonalInfoId = @Value
	
	if (@fieldname=N'DateTaghirVaziyat_PrsPersonalInfoId')
	SELECT     TOP (@h) Com.tblPersonalStatus.fldId, Com.tblPersonalStatus.fldStatusId, Com.tblPersonalStatus.fldPrsPersonalInfoId, 
                      Com.tblPersonalStatus.fldPayPersonalInfoId, Com.tblPersonalStatus.fldDateTaghirVaziyat, 
                      Com.tblPersonalStatus.fldUserId, Com.tblPersonalStatus.fldDate, Com.tblPersonalStatus.fldDesc, Com.tblStatus.fldTitle
FROM            Com.tblPersonalStatus INNER JOIN
                         Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId
                      WHERE  fldDateTaghirVaziyat = Com.fn_GetPersonalStatusMaxDate(@value,'fldPrs_PersonalInfo')
	
	if (@fieldname=N'fldPayPersonalInfoId')
	SELECT     TOP (@h) Com.tblPersonalStatus.fldId, Com.tblPersonalStatus.fldStatusId, Com.tblPersonalStatus.fldPrsPersonalInfoId, 
                      Com.tblPersonalStatus.fldPayPersonalInfoId, Com.tblPersonalStatus.fldDateTaghirVaziyat, 
                      Com.tblPersonalStatus.fldUserId, Com.tblPersonalStatus.fldDate, Com.tblPersonalStatus.fldDesc, Com.tblStatus.fldTitle
FROM            Com.tblPersonalStatus INNER JOIN
                         Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId
	WHERE  fldPayPersonalInfoId = @Value
	
	if (@fieldname=N'fldStatusId')
	SELECT     TOP (@h) Com.tblPersonalStatus.fldId, Com.tblPersonalStatus.fldStatusId, Com.tblPersonalStatus.fldPrsPersonalInfoId, 
                      Com.tblPersonalStatus.fldPayPersonalInfoId, Com.tblPersonalStatus.fldDateTaghirVaziyat, 
                      Com.tblPersonalStatus.fldUserId, Com.tblPersonalStatus.fldDate, Com.tblPersonalStatus.fldDesc, Com.tblStatus.fldTitle
FROM            Com.tblPersonalStatus INNER JOIN
                         Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId
	WHERE  fldStatusId = @Value
	
	if (@fieldname=N'fldStatusChangeEnd_KargoziniId')
	SELECT     TOP (1) Com.tblPersonalStatus.fldId, Com.tblPersonalStatus.fldStatusId, Com.tblPersonalStatus.fldPrsPersonalInfoId, 
                      Com.tblPersonalStatus.fldPayPersonalInfoId, Com.tblPersonalStatus.fldDateTaghirVaziyat, 
                      Com.tblPersonalStatus.fldUserId, Com.tblPersonalStatus.fldDate, Com.tblPersonalStatus.fldDesc, Com.tblStatus.fldTitle
FROM            Com.tblPersonalStatus INNER JOIN
                         Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId
                      WHERE fldDateTaghirVaziyat=[Com].[fn_GetPersonalStatusMaxDate](@Value,'fldPrs_PersonalInfo')
                      AND fldPrsPersonalInfoId=@Value
                      ORDER BY fldDate DESC
                      
                      
       if (@fieldname=N'fldStatusChangeEnd_HoghughiId')
	SELECT     TOP (1) Com.tblPersonalStatus.fldId, Com.tblPersonalStatus.fldStatusId, Com.tblPersonalStatus.fldPrsPersonalInfoId, 
                      Com.tblPersonalStatus.fldPayPersonalInfoId, Com.tblPersonalStatus.fldDateTaghirVaziyat, 
                      Com.tblPersonalStatus.fldUserId, Com.tblPersonalStatus.fldDate, Com.tblPersonalStatus.fldDesc, Com.tblStatus.fldTitle
FROM            Com.tblPersonalStatus INNER JOIN
                         Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId
                      WHERE fldDateTaghirVaziyat= [Com].[fn_GetPersonalStatusMaxDate](@Value,'fldPay_PersonalInfo')
                      AND fldPayPersonalInfoId=@Value
 ORDER BY fldDate DESC
                     
if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) Com.tblPersonalStatus.fldId, Com.tblPersonalStatus.fldStatusId, Com.tblPersonalStatus.fldPrsPersonalInfoId, 
                      Com.tblPersonalStatus.fldPayPersonalInfoId, Com.tblPersonalStatus.fldDateTaghirVaziyat, 
                      Com.tblPersonalStatus.fldUserId, Com.tblPersonalStatus.fldDate, Com.tblPersonalStatus.fldDesc, Com.tblStatus.fldTitle
FROM            Com.tblPersonalStatus INNER JOIN
                         Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId
	WHERE  Com.tblPersonalStatus.fldDesc like @Value

	if (@fieldname=N'')
	SELECT     TOP (@h) Com.tblPersonalStatus.fldId, Com.tblPersonalStatus.fldStatusId, Com.tblPersonalStatus.fldPrsPersonalInfoId, 
                      Com.tblPersonalStatus.fldPayPersonalInfoId, Com.tblPersonalStatus.fldDateTaghirVaziyat, 
                      Com.tblPersonalStatus.fldUserId, Com.tblPersonalStatus.fldDate, Com.tblPersonalStatus.fldDesc, Com.tblStatus.fldTitle
FROM            Com.tblPersonalStatus INNER JOIN
                         Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId
	COMMIT
GO
