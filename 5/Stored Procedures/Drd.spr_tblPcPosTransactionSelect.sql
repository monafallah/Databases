SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosTransactionSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT        TOP (@h) fldId, fldFishId, fldPrice, fldStatus, fldTrackingCode, fldShGhabz, fldShPardakht, fldUserId, fldDesc, fldDate, fldSerialNumber, fldTerminalCode, fldTarikh, fldCardNumber
	,N'PCPos' AS fldNahvePardakht
FROM            Drd.tblPcPosTransaction
	WHERE  fldId = @Value

	if (@fieldname=N'fldFishId')
	SELECT        TOP (1) fldId, fldFishId, fldPrice, fldStatus, fldTrackingCode, fldShGhabz, fldShPardakht, fldUserId, fldDesc, fldDate, fldSerialNumber, fldTerminalCode, fldTarikh, fldCardNumber
	,N'PCPos' AS fldNahvePardakht
FROM            Drd.tblPcPosTransaction
	WHERE  fldFishId = @Value
	ORDER BY fldId DESC

    if (@fieldname=N'fldDesc')
	SELECT        TOP (@h) fldId, fldFishId, fldPrice, fldStatus, fldTrackingCode, fldShGhabz, fldShPardakht, fldUserId, fldDesc, fldDate, fldSerialNumber, fldTerminalCode, fldTarikh, fldCardNumber
	,N'PCPos' AS fldNahvePardakht
FROM            Drd.tblPcPosTransaction
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT        TOP (@h) fldId, fldFishId, fldPrice, fldStatus, fldTrackingCode, fldShGhabz, fldShPardakht, fldUserId, fldDesc, fldDate, fldSerialNumber, fldTerminalCode, fldTarikh, fldCardNumber
	,N'PCPos' AS fldNahvePardakht
FROM            Drd.tblPcPosTransaction

	COMMIT
GO
