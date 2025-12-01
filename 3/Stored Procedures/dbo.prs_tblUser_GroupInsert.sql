SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblUser_GroupInsert] 

    @fldUserGroupID int,
    @fldUserSelectID int,
    @fldGrant	bit	,
	@fldWithGrant	bit	,
    
	@fldInputID int,
    @fldDesc nvarchar(500)
AS 
	
	BEGIN TRAN
	SET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblUser_Group] 
	INSERT INTO [dbo].[tblUser_Group] ([fldID], [fldUserGroupID], [fldUserSelectID],fldGrant,fldWithGrant , [fldDesc])
	SELECT @fldID, @fldUserGroupID, @fldUserSelectID,@fldGrant,@fldWithGrant, @fldDesc
	if (@@ERROR<>0)
	begin	
		ROLLBACK
	end
	
	COMMIT
GO
