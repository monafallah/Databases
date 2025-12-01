SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblUser_PermissionUpdate] 
    @fldId int,
    @fldUserSelectId int,
    @fldAppId int,
    @fldIsAccept bit,
  
	@fldInputID int,
    @fldDesc nvarchar(1000)
    AS 
	BEGIN TRAN
	SET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	UPDATE [dbo].[tblUser_Permission]
	SET    [fldUserSelectId] = @fldUserSelectId, [fldAppId] = @fldAppId, [fldIsAccept] = @fldIsAccept,   [fldDesc] = @fldDesc

	WHERE  [fldId] = @fldId
	if(@@ERROR<>0)
	
	 rollback
	
	COMMIT TRAN
GO
