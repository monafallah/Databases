SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblTransactionTypeDelete] 
	@fldID int

AS 
	BEGIN TRAN
	
	DELETE
	FROM   [Trans].[tblTransactionType]
	WHERE  fldId = @fldId

	COMMIT
GO
