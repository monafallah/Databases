SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHokm_InfoPersonal_HistoryDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE [Prs].[tblHokm_InfoPersonal_History]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Prs].[tblHokm_InfoPersonal_History]
	WHERE  fldId = @fldId

	COMMIT
GO
