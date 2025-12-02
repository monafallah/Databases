SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblLevelsAccountingTypeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) ACC.tblLevelsAccountingType.fldId, ACC.tblLevelsAccountingType.fldName, ACC.tblLevelsAccountingType.fldAccountTypeId, 
                      ACC.tblLevelsAccountingType.fldArghumNum, ACC.tblLevelsAccountingType.fldDesc, ACC.tblLevelsAccountingType.flddate, ACC.tblLevelsAccountingType.fldIp, 
                      ACC.tblLevelsAccountingType.fldUserId, ACC.tblAccountingType.fldName AS fldName_AccountingType
FROM         ACC.tblLevelsAccountingType INNER JOIN
                      ACC.tblAccountingType ON ACC.tblLevelsAccountingType.fldAccountTypeId = ACC.tblAccountingType.fldId 
	WHERE  ACC.tblLevelsAccountingType.fldId = @Value
	
	
	
	

	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) ACC.tblLevelsAccountingType.fldId, ACC.tblLevelsAccountingType.fldName, ACC.tblLevelsAccountingType.fldAccountTypeId, 
                      ACC.tblLevelsAccountingType.fldArghumNum, ACC.tblLevelsAccountingType.fldDesc, ACC.tblLevelsAccountingType.flddate, ACC.tblLevelsAccountingType.fldIp, 
                      ACC.tblLevelsAccountingType.fldUserId, ACC.tblAccountingType.fldName AS fldName_AccountingType
FROM         ACC.tblLevelsAccountingType INNER JOIN
                      ACC.tblAccountingType ON ACC.tblLevelsAccountingType.fldAccountTypeId = ACC.tblAccountingType.fldId 
	WHERE ACC.tblLevelsAccountingType.fldDesc like  @Value
	
	
	
	
	

	if (@fieldname=N'')
	SELECT     TOP (@h) ACC.tblLevelsAccountingType.fldId, ACC.tblLevelsAccountingType.fldName, ACC.tblLevelsAccountingType.fldAccountTypeId, 
                      ACC.tblLevelsAccountingType.fldArghumNum, ACC.tblLevelsAccountingType.fldDesc, ACC.tblLevelsAccountingType.flddate, ACC.tblLevelsAccountingType.fldIp, 
                      ACC.tblLevelsAccountingType.fldUserId, ACC.tblAccountingType.fldName AS fldName_AccountingType
FROM         ACC.tblLevelsAccountingType INNER JOIN
                      ACC.tblAccountingType ON ACC.tblLevelsAccountingType.fldAccountTypeId = ACC.tblAccountingType.fldId






if (@fieldname=N'fldName_AccountingType')

	SELECT * FROM (SELECT     TOP (@h) ACC.tblLevelsAccountingType.fldId, ACC.tblLevelsAccountingType.fldName, ACC.tblLevelsAccountingType.fldAccountTypeId, 
                      ACC.tblLevelsAccountingType.fldArghumNum, ACC.tblLevelsAccountingType.fldDesc, ACC.tblLevelsAccountingType.flddate, ACC.tblLevelsAccountingType.fldIp, 
                      ACC.tblLevelsAccountingType.fldUserId, ACC.tblAccountingType.fldName AS fldName_AccountingType
FROM         ACC.tblLevelsAccountingType INNER JOIN
                      ACC.tblAccountingType ON ACC.tblLevelsAccountingType.fldAccountTypeId = ACC.tblAccountingType.fldId)t 
	WHERE t.fldName_AccountingType like  @Value
	
	
	
	
	
	if (@fieldname=N'fldName')
	SELECT     TOP (@h) ACC.tblLevelsAccountingType.fldId, ACC.tblLevelsAccountingType.fldName, ACC.tblLevelsAccountingType.fldAccountTypeId, 
                      ACC.tblLevelsAccountingType.fldArghumNum, ACC.tblLevelsAccountingType.fldDesc, ACC.tblLevelsAccountingType.flddate, ACC.tblLevelsAccountingType.fldIp, 
                      ACC.tblLevelsAccountingType.fldUserId, ACC.tblAccountingType.fldName AS fldName_AccountingType
FROM         ACC.tblLevelsAccountingType INNER JOIN
                      ACC.tblAccountingType ON ACC.tblLevelsAccountingType.fldAccountTypeId = ACC.tblAccountingType.fldId 
	WHERE  ACC.tblLevelsAccountingType.fldName = @Value
	
	
	
	
		if (@fieldname=N'fldAccountTypeId')
	SELECT     TOP (@h) ACC.tblLevelsAccountingType.fldId, ACC.tblLevelsAccountingType.fldName, ACC.tblLevelsAccountingType.fldAccountTypeId, 
                      ACC.tblLevelsAccountingType.fldArghumNum, ACC.tblLevelsAccountingType.fldDesc, ACC.tblLevelsAccountingType.flddate, ACC.tblLevelsAccountingType.fldIp, 
                      ACC.tblLevelsAccountingType.fldUserId, ACC.tblAccountingType.fldName AS fldName_AccountingType
FROM         ACC.tblLevelsAccountingType INNER JOIN
                      ACC.tblAccountingType ON ACC.tblLevelsAccountingType.fldAccountTypeId = ACC.tblAccountingType.fldId 
	WHERE  ACC.tblLevelsAccountingType.fldAccountTypeId = @Value
	COMMIT
GO
