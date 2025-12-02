SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[sp_PcPosTransactionUpdate_Status] 
    @fldId int,
	@fldTrackingCode nvarchar(50),
	@fldDesc nvarchar(MAX)

    
AS 
	BEGIN TRAN
	UPDATE drd.[tblPcPosTransaction]
	SET      [fldStatus] = 1,fldTrackingCode=@fldTrackingCode,fldDesc=@fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
