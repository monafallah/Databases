SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblTreeGroupDelete] 
@fldID int
AS 
	
	BEGIN TRAN
	
	DELETE
	FROM   [Cnt].[tblTreeGroup]
	where  fldId =@fldId
	if (@@ERROR<>0)
		begin	
			rollback
			
		end
		

	COMMIT
GO
