SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHokm_ItemDelete] 
	@fieldName NVARCHAR(50),
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	IF(@fieldName='fldId')
	BEGIN
	UPDATE [Prs].[tblHokm_Item]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Prs].[tblHokm_Item]
	WHERE  fldId = @fldId
	end
	IF(@fieldName='fldHokmId')
	BEGIN
	UPDATE [Prs].[tblHokm_Item]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldPersonalHokmId = @fldId
	DELETE
	FROM   [Prs].[tblHokm_Item]
	WHERE  fldPersonalHokmId = @fldId
	end
	COMMIT
GO
