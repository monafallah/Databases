SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [dbo].[prs_tblApplicationPartDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DELETE
	FROM   [dbo].[tblApplicationPart]
	WHERE  fldId = @fldId

	COMMIT
GO
