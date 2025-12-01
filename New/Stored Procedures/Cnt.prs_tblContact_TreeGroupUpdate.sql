SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblContact_TreeGroupUpdate] 
    @fldId int,
    @fldTreeGroupId int,
    @fldContactId int,
	@inputid int
AS 

	BEGIN TRAN
	Declare @flag tinyint,@flag1 bit=0
		UPDATE [Cnt].[tblContact_TreeGroup]
	SET    [fldTreeGroupId] = @fldTreeGroupId, [fldContactId] = @fldContactId,fldInputId=@inputid
	WHERE  fldId=@fldId
	
		
			if(@@ERROR<>0)
			rollback
	
	COMMIT
GO
