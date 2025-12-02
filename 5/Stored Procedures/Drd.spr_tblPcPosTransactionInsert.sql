SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblPcPosTransactionInsert] 
    @fldId int output,
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
	
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblPcPosTransaction] 
	INSERT INTO [Drd].[tblPcPosTransaction] ([fldId], [fldFishId], [fldPrice], [fldStatus], [fldTrackingCode], [fldShGhabz], [fldShPardakht], [fldUserId], [fldDesc], [fldDate],fldTerminalCode,fldSerialNumber,fldCardNumber,fldTarikh)
	SELECT @fldId, @fldFishId, @fldPrice, @fldStatus, @fldTrackingCode, @fldShGhabz, @fldShPardakht, @fldUserId, @fldDesc, getdate(),@fldTerminalCode,@fldSerialNumber,@fldCardNumber,@fldTarikh
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
