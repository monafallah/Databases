SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [dbo].[prs_tblTimeLimit_UserUpdate] 
    @fldId int,
    @fldAppId int,
    @fldTimeLimit smallint,
    @fldUserId int,
	@fldinputid int
AS 
	BEGIN TRAN
	UPDATE [dbo].[tblTimeLimit_User]
	SET    [fldAppId] = @fldAppId, [fldTimeLimit] = @fldTimeLimit, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	if (@@ERROR<>0)
		
		ROLLBACK
	
	
	
	COMMIT TRAN
GO
