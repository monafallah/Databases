SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [chk].[spr_tblOlgoCheckSelect] 
	@fieldname nvarchar(50),
	@Value  nvarchar(50),
	@fldOrganId int,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT        TOP (@h) chk.tblOlgoCheck.fldId, chk.tblOlgoCheck.fldIdFile, chk.tblOlgoCheck.fldIdBank, chk.tblOlgoCheck.fldUserID, chk.tblOlgoCheck.fldDesc, chk.tblOlgoCheck.fldDate ,chk.tblOlgoCheck.fldOrganId,fldTitle,  Com.tblBank.fldBankName
FROM            chk.tblOlgoCheck INNER JOIN
                         Com.tblBank ON chk.tblOlgoCheck.fldIdBank = Com.tblBank.fldId
	WHERE  chk.tblOlgoCheck.fldId = @Value and fldOrganId=@fldOrganId and fldOrganId=@fldOrganId

	
	if (@fieldname=N'fldBankName')
SELECT        TOP (@h) chk.tblOlgoCheck.fldId, chk.tblOlgoCheck.fldIdFile, chk.tblOlgoCheck.fldIdBank, chk.tblOlgoCheck.fldUserID, chk.tblOlgoCheck.fldDesc, chk.tblOlgoCheck.fldDate ,chk.tblOlgoCheck.fldOrganId,fldTitle, Com.tblBank.fldBankName
FROM            chk.tblOlgoCheck INNER JOIN
                         Com.tblBank ON chk.tblOlgoCheck.fldIdBank = Com.tblBank.fldId
	WHERE  Com.tblBank.fldBankName like  @Value and fldOrganId=@fldOrganId
	
	if (@fieldname=N'fldBankId')
SELECT        TOP (@h) chk.tblOlgoCheck.fldId, chk.tblOlgoCheck.fldIdFile, chk.tblOlgoCheck.fldIdBank, chk.tblOlgoCheck.fldUserID, chk.tblOlgoCheck.fldDesc, chk.tblOlgoCheck.fldDate ,chk.tblOlgoCheck.fldOrganId,fldTitle, Com.tblBank.fldBankName
FROM            chk.tblOlgoCheck INNER JOIN
                         Com.tblBank ON chk.tblOlgoCheck.fldIdBank = Com.tblBank.fldId
	WHERE  Com.tblBank.fldId like  @Value and fldOrganId=@fldOrganId
	
	if (@fieldname=N'fldBankId_Check')
SELECT        TOP (@h) chk.tblOlgoCheck.fldId, chk.tblOlgoCheck.fldIdFile, chk.tblOlgoCheck.fldIdBank, chk.tblOlgoCheck.fldUserID, chk.tblOlgoCheck.fldDesc, chk.tblOlgoCheck.fldDate ,chk.tblOlgoCheck.fldOrganId,fldTitle, Com.tblBank.fldBankName
FROM            chk.tblOlgoCheck INNER JOIN
                         Com.tblBank ON chk.tblOlgoCheck.fldIdBank = Com.tblBank.fldId
	WHERE  Com.tblBank.fldId like  @Value 
	
	if (@fieldname=N'fldTitle')
SELECT        TOP (@h) chk.tblOlgoCheck.fldId, chk.tblOlgoCheck.fldIdFile, chk.tblOlgoCheck.fldIdBank, chk.tblOlgoCheck.fldUserID, chk.tblOlgoCheck.fldDesc, chk.tblOlgoCheck.fldDate ,chk.tblOlgoCheck.fldOrganId,fldTitle, Com.tblBank.fldBankName
FROM            chk.tblOlgoCheck INNER JOIN
                         Com.tblBank ON chk.tblOlgoCheck.fldIdBank = Com.tblBank.fldId
	WHERE  chk.tblOlgoCheck.fldTitle like  @Value and fldOrganId=@fldOrganId

	if (@fieldname=N'fldDesc')
SELECT        TOP (@h) chk.tblOlgoCheck.fldId, chk.tblOlgoCheck.fldIdFile, chk.tblOlgoCheck.fldIdBank, chk.tblOlgoCheck.fldUserID, chk.tblOlgoCheck.fldDesc, chk.tblOlgoCheck.fldDate ,chk.tblOlgoCheck.fldOrganId,fldTitle, Com.tblBank.fldBankName
FROM            chk.tblOlgoCheck INNER JOIN
                         Com.tblBank ON chk.tblOlgoCheck.fldIdBank = Com.tblBank.fldId
	WHERE  chk.tblOlgoCheck.fldDesc like  @Value and fldOrganId=@fldOrganId

	if (@fieldname=N'')
SELECT        TOP (@h) chk.tblOlgoCheck.fldId, chk.tblOlgoCheck.fldIdFile, chk.tblOlgoCheck.fldIdBank, chk.tblOlgoCheck.fldUserID, chk.tblOlgoCheck.fldDesc, chk.tblOlgoCheck.fldDate ,chk.tblOlgoCheck.fldOrganId,fldTitle,  Com.tblBank.fldBankName
FROM            chk.tblOlgoCheck INNER JOIN
                         Com.tblBank ON chk.tblOlgoCheck.fldIdBank = Com.tblBank.fldId 

	COMMIT
GO
