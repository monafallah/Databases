SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblUser_GroupUpdate] 
    @fldID int,
    @fldUserGroupID int,
    @fldUserSelectID int,
    @fldGrant bit,
    @fldWithGrant bit,
   
	@fldInputID int,
    @fldDesc nvarchar(1000)
AS 
	BEGIN TRAN
	SET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	UPDATE [dbo].[tblUser_Group]
	SET    [fldUserGroupID] = @fldUserGroupID, [fldUserSelectID] = @fldUserSelectID,fldGrant=@fldGrant,fldWithGrant=@fldWithGrant,[fldDesc] = @fldDesc

	WHERE  [fldID] = @fldID
	if(@@ERROR<>0)
	
	rollback
	
	COMMIT TRAN
GO
