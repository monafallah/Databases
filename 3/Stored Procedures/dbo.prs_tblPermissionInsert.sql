SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblPermissionInsert] 

    @fldUserGroupID int,
    @fldApplicationPartID int,
  
	@fldInputID int,
    @fldDesc nvarchar(100)
AS 
	
	BEGIN TRAN
	declare @fldID INT
	SET @fldDesc =dbo.fn_TextNormalize(@fldDesc)  
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblPermission] 
	INSERT INTO [dbo].[tblPermission] ([fldID], [fldUserGroupID], [fldApplicationPartID], [fldDesc])
	SELECT @fldID, @fldUserGroupID, @fldApplicationPartID, @fldDesc
	if (@@ERROR<>0)
	begin	
		ROLLBACK
	end
	

	COMMIT
GO
