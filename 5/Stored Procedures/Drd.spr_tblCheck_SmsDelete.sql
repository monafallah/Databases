SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCheck_SmsDelete] 
   @fldCheckId int,
	@fldUserId int
AS 
	
	
	BEGIN TRAN
	UPDATE [Drd].[tblCheck_Sms]
	SET    fldUserId=@fldUserId,fldDate=getdate()
	WHERE  fldCheckId = @fldCheckId
	if (@@error<>0)
		rollback
	
	DELETE
	FROM   [Drd].[tblCheck_Sms]
	WHERE  fldCheckId = @fldCheckId
	if (@@error<>0)
		rollback
	COMMIT
GO
