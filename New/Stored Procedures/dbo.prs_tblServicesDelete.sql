SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblServicesDelete] 
    @fldId int
AS 
	
	
	BEGIN TRAN
	
	
	DELETE
	FROM   [dbo].[tblServices]
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
