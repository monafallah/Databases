SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblPayamDelete] 
    @fldId int
AS 
	
	
	BEGIN TRAN
	
	
	DELETE
	FROM   [dbo].[tblPayam]
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
