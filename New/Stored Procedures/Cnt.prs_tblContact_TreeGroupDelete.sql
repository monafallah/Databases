SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblContact_TreeGroupDelete] 
@fieldName nvarchar(50),
@fldID int
AS 
	
	BEGIN TRAN
	if(@fieldName='Id')
	begin
	DELETE
	FROM   [Cnt].[tblContact_TreeGroup]
	where  fldId =@fldId
			if(@@ERROR<>0)
			rollback
	end

	if(@fieldName='ContactId')
	begin
	DELETE
	FROM   [Cnt].[tblContact_TreeGroup]
	where  fldContactId =@fldId
			if(@@ERROR<>0)
			rollback
	end
	COMMIT
GO
