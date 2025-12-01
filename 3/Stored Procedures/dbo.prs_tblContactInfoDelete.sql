SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblContactInfoDelete] 
    @fldId int
AS 
	
	
	BEGIN TRAN
	
	
	DELETE
	FROM   [dbo].[tblContactInfo]
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
