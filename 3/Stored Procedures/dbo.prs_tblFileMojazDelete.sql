SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblFileMojazDelete] 
	@fldID int,
	@InputID int
AS 
	BEGIN TRAN
	
		DELETE
		FROM   tblFileMojaz
		WHERE  fldId = @fldId
		IF (@@ERROR<>0)
			ROLLBACK

	COMMIT
GO
