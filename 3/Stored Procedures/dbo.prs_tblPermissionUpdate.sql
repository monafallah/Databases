SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblPermissionUpdate] 
    @fldID int,
    @fldUserGroupID int,
    @fldApplicationPartID int,
  
	@fldInputID int,
    @fldDesc nvarchar(MAX)
	
AS 
	BEGIN TRAN
	SET @fldDesc =dbo.fn_TextNormalize(@fldDesc) 
	UPDATE [dbo].[tblPermission]
	SET    [fldID] = @fldID, [fldUserGroupID] = @fldUserGroupID, [fldApplicationPartID] = @fldApplicationPartID,
	 [fldDesc] = @fldDesc 
	WHERE  [fldID] = @fldID
	if(@@ERROR<>0)
	begin
	rollback
	end
	
	COMMIT TRAN
GO
