SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblAddressDelete] 
@fldID int
AS 
	
	BEGIN TRAN
	Declare  @fldRowId varbinary(8)
	Declare @flag tinyint
	
	DELETE
	FROM   [Cnt].[tblAddress]
	where  fldId =@fldId
	if (@@ERROR<>0)
		begin	
			rollback
			
		end
		

	COMMIT
GO
