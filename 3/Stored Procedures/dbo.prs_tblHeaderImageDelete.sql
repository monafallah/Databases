SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblHeaderImageDelete] 
    @fldId smallint
AS 
	

	
	DELETE
	FROM   [dbo].[tblHeaderImage]
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
