SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblDaramadGroup_ParametrValuesDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE  [Drd].[tblDaramadGroup_ParametrValues]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblDaramadGroup_ParametrValues]
	WHERE  fldElamAvarezId = @fldId

	COMMIT
GO
