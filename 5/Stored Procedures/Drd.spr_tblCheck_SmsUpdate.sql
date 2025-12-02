SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCheck_SmsUpdate] 
    @fldId int,
    @fldCheckId int,
    @fldStatus tinyint,
    @fldUserId int,

    @fldIP nvarchar(15)
AS 
	 
	
	BEGIN TRAN

	UPDATE [Drd].[tblCheck_Sms]
	SET    [fldCheckId] = @fldCheckId, [fldStatus] = @fldStatus, [fldUserId] = @fldUserId , [fldIP] = @fldIP, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
