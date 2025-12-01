SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblTransactionGroupDelete] 
	@fldID int
	as
	BEGIN TRAN
	
	DELETE
	FROM   [Trans].[tblTransactionGroup]
	WHERE  fldId = @fldId

	COMMIT
GO
