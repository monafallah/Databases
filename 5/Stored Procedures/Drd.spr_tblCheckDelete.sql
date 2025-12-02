SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCheckDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	delete from chk.tblCheckStatus
	where fldCheckVaredeId=@fldid 
	if (@@ERROR<>0)
	rollback
	else
	begin
		UPDATE   [Drd].[tblCheck]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
		if (@@ERROR<>0)
			rollback

		DELETE
		FROM   [Drd].[tblCheck]
		WHERE  fldId = @fldId
		if (@@ERROR<>0)
			rollback
	end
	COMMIT
GO
