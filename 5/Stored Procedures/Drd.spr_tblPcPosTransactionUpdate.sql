SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosTransactionUpdate] 
    @fldId int,
    @fldFishId int,
    @fldPrice bigint,
    @fldStatus bit,
    @fldTrackingCode nvarchar(50),
    @fldShGhabz nvarchar(20),
    @fldShPardakht nvarchar(20),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldTerminalCode nvarchar(50),
	@fldSerialNumber nvarchar(50),
	@fldCardNumber nvarchar(50),
	@fldTarikh nvarchar(50)

AS 
	BEGIN TRAN
	set @fldTrackingCode=com.fn_TextNormalize(@fldTrackingCode)
	set @fldShGhabz=com.fn_TextNormalize(@fldShGhabz)
	set @fldShPardakht=com.fn_TextNormalize(@fldShPardakht)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblPcPosTransaction]
	SET    [fldFishId] = @fldFishId, [fldPrice] = @fldPrice, [fldStatus] = @fldStatus, [fldTrackingCode] = @fldTrackingCode, [fldShGhabz] = @fldShGhabz, [fldShPardakht] = @fldShPardakht, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	, fldSerialNumber=@fldSerialNumber, fldTerminalCode=@fldTerminalCode, fldTarikh=@fldTarikh, fldCardNumber=@fldCardNumber
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
