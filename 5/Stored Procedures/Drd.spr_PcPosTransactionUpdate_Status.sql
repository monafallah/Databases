SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_PcPosTransactionUpdate_Status] 
    @fldId int,
	@fldTrackingCode nvarchar(50),
	@fldDesc nvarchar(MAX),
	@fldTerminalCode nvarchar(50),
	@fldSerialNumber nvarchar(50),
	@fldCardNumber nvarchar(50),
	@fldTarikh nvarchar(50)

    
AS 
	BEGIN TRAN
	UPDATE [drd].[tblPcPosTransaction]
	SET      [fldStatus] = 1,fldTrackingCode=@fldTrackingCode,fldDesc=@fldDesc
	, fldSerialNumber=@fldSerialNumber, fldTerminalCode=@fldTerminalCode, fldTarikh=@fldTarikh, fldCardNumber=@fldCardNumber
	WHERE  [fldId] = @fldId
	COMMIT TRAN

GO
