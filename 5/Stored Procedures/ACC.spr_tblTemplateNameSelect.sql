SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblTemplateNameSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	
	@h int
AS 
	BEGIN TRAN
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT     TOP (@h) ACC.tblTemplateName.fldId, ACC.tblTemplateName.fldName, ACC.tblTemplateName.fldAccountingTypeId, ACC.tblTemplateName.fldDesc, 
           ACC.tblTemplateName.fldDate, ACC.tblTemplateName.fldIp, ACC.tblTemplateName.fldUserId, ACC.tblAccountingType.fldName AS fldName_AccountingType
 FROM   ACC.tblTemplateName INNER JOIN ACC.tblAccountingType ON ACC.tblTemplateName.fldAccountingTypeId = ACC.tblAccountingType.fldId  
	WHERE  ACC.tblTemplateName.fldId = @Value


	
	

	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) ACC.tblTemplateName.fldId, ACC.tblTemplateName.fldName, ACC.tblTemplateName.fldAccountingTypeId, ACC.tblTemplateName.fldDesc, 
           ACC.tblTemplateName.fldDate, ACC.tblTemplateName.fldIp, ACC.tblTemplateName.fldUserId, ACC.tblAccountingType.fldName AS  fldName_AccountingType
FROM ACC.tblTemplateName INNER JOIN ACC.tblAccountingType ON ACC.tblTemplateName.fldAccountingTypeId = ACC.tblAccountingType.fldId  
	WHERE ACC.tblTemplateName.fldDesc like  @Value
	
	
	

	if (@fieldname=N'')
SELECT     TOP (@h) ACC.tblTemplateName.fldId, ACC.tblTemplateName.fldName, ACC.tblTemplateName.fldAccountingTypeId, ACC.tblTemplateName.fldDesc, 
            ACC.tblTemplateName.fldDate, ACC.tblTemplateName.fldIp, ACC.tblTemplateName.fldUserId, ACC.tblAccountingType.fldName  AS fldName_AccountingType
FROM         ACC.tblTemplateName INNER JOIN  ACC.tblAccountingType ON ACC.tblTemplateName.fldAccountingTypeId = ACC.tblAccountingType.fldId
                      
                      

	if (@fieldname=N'fldName')
SELECT     TOP (@h) ACC.tblTemplateName.fldId, ACC.tblTemplateName.fldName, ACC.tblTemplateName.fldAccountingTypeId, ACC.tblTemplateName.fldDesc, 
             ACC.tblTemplateName.fldDate, ACC.tblTemplateName.fldIp, ACC.tblTemplateName.fldUserId, ACC.tblAccountingType.fldName  AS fldName_AccountingType
FROM         ACC.tblTemplateName INNER JOIN ACC.tblAccountingType ON ACC.tblTemplateName.fldAccountingTypeId = ACC.tblAccountingType.fldId  
	WHERE ACC.tblTemplateName.fldName like  @Value 
	
	
	if (@fieldname=N'fldAccountingTypeId')
SELECT     TOP (@h) ACC.tblTemplateName.fldId, ACC.tblTemplateName.fldName, ACC.tblTemplateName.fldAccountingTypeId, ACC.tblTemplateName.fldDesc, 
             ACC.tblTemplateName.fldDate, ACC.tblTemplateName.fldIp, ACC.tblTemplateName.fldUserId, ACC.tblAccountingType.fldName  AS fldName_AccountingType
FROM         ACC.tblTemplateName INNER JOIN ACC.tblAccountingType ON ACC.tblTemplateName.fldAccountingTypeId = ACC.tblAccountingType.fldId  
	WHERE ACC.tblTemplateName.fldAccountingTypeId like  @Value 
	
		if (@fieldname=N'fldName_AccountingType')
SELECT * FROM (select   TOP (@h) ACC.tblTemplateName.fldId, ACC.tblTemplateName.fldName, ACC.tblTemplateName.fldAccountingTypeId, ACC.tblTemplateName.fldDesc, 
             ACC.tblTemplateName.fldDate, ACC.tblTemplateName.fldIp, ACC.tblTemplateName.fldUserId, ACC.tblAccountingType.fldName  AS fldName_AccountingType
FROM         ACC.tblTemplateName INNER JOIN ACC.tblAccountingType ON ACC.tblTemplateName.fldAccountingTypeId = ACC.tblAccountingType.fldId )t
	WHERE t.fldName_AccountingType LIKE  @Value 
	


               

	COMMIT
GO
