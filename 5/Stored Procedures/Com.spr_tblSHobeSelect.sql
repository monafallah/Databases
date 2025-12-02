SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblSHobeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblSHobe.fldId, tblSHobe.fldBankId, tblSHobe.fldName, tblSHobe.fldCodeSHobe, tblSHobe.fldAddress, tblSHobe.fldUserId, 
                      tblSHobe.fldDesc, tblSHobe.fldDate, tblBank.fldBankName
FROM         tblSHobe INNER JOIN
                      tblBank ON tblSHobe.fldBankId = tblBank.fldId
	WHERE  tblSHobe.fldId = @Value
	
	if (@fieldname=N'fldBankId')
	SELECT     TOP (@h) tblSHobe.fldId, tblSHobe.fldBankId, tblSHobe.fldName, tblSHobe.fldCodeSHobe, tblSHobe.fldAddress, tblSHobe.fldUserId, 
                      tblSHobe.fldDesc, tblSHobe.fldDate, tblBank.fldBankName
FROM         tblSHobe INNER JOIN
                      tblBank ON tblSHobe.fldBankId = tblBank.fldId
	WHERE  tblSHobe.fldBankId = @Value
	
		if (@fieldname=N'fldName')
	SELECT     TOP (@h) tblSHobe.fldId, tblSHobe.fldBankId, tblSHobe.fldName, tblSHobe.fldCodeSHobe, tblSHobe.fldAddress,  tblSHobe.fldUserId, 
                      tblSHobe.fldDesc, tblSHobe.fldDate, tblBank.fldBankName
FROM         tblSHobe INNER JOIN
                      tblBank ON tblSHobe.fldBankId = tblBank.fldId
	WHERE  fldName like @Value

		if (@fieldname=N'fldBankName')
	SELECT     TOP (@h) tblSHobe.fldId, tblSHobe.fldBankId, tblSHobe.fldName, tblSHobe.fldCodeSHobe, tblSHobe.fldAddress, tblSHobe.fldUserId, 
                      tblSHobe.fldDesc, tblSHobe.fldDate, tblBank.fldBankName
FROM         tblSHobe INNER JOIN
                      tblBank ON tblSHobe.fldBankId = tblBank.fldId
	WHERE  fldBankName like @Value
	
		if (@fieldname=N'fldCodeSHobe')
	SELECT     TOP (@h) tblSHobe.fldId, tblSHobe.fldBankId, tblSHobe.fldName, tblSHobe.fldCodeSHobe, tblSHobe.fldAddress, tblSHobe.fldUserId, 
                      tblSHobe.fldDesc, tblSHobe.fldDate, tblBank.fldBankName
FROM         tblSHobe INNER JOIN
                      tblBank ON tblSHobe.fldBankId = tblBank.fldId
	WHERE  fldCodeSHobe like @Value
	
			if (@fieldname=N'fldAddress')
	SELECT     TOP (@h) tblSHobe.fldId, tblSHobe.fldBankId, tblSHobe.fldName, tblSHobe.fldCodeSHobe, tblSHobe.fldAddress, tblSHobe.fldUserId, 
                      tblSHobe.fldDesc, tblSHobe.fldDate, tblBank.fldBankName
FROM         tblSHobe INNER JOIN
                      tblBank ON tblSHobe.fldBankId = tblBank.fldId
	WHERE  fldAddress like @Value
		
	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) tblSHobe.fldId, tblSHobe.fldBankId, tblSHobe.fldName, tblSHobe.fldCodeSHobe, tblSHobe.fldAddress, tblSHobe.fldUserId, 
                      tblSHobe.fldDesc, tblSHobe.fldDate, tblBank.fldBankName
FROM         tblSHobe INNER JOIN
                      tblBank ON tblSHobe.fldBankId = tblBank.fldId
	WHERE  tblSHobe.fldDesc like @Value

	if (@fieldname=N'')
		SELECT     TOP (@h) tblSHobe.fldId, tblSHobe.fldBankId, tblSHobe.fldName, tblSHobe.fldCodeSHobe, tblSHobe.fldAddress, tblSHobe.fldUserId, 
                      tblSHobe.fldDesc, tblSHobe.fldDate, tblBank.fldBankName
FROM         tblSHobe INNER JOIN
                      tblBank ON tblSHobe.fldBankId = tblBank.fldId
	COMMIT
GO
