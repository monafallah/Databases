SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblTabagheBandiUpdate] 
    @fldID int,
    @fldName nvarchar(400),
	    @fldComisionID int,
    @fldPID int = NULL,
	  @fldOrganID int,
    @fldUserID int,
  
    @fldDesc nvarchar(100),
    @fldIP nvarchar(16)
AS 

	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	set @fldName=com.fn_TextNormalize(@fldName)
	UPDATE [Auto].[tblTabagheBandi]
	SET    [fldName] = @fldName, [fldPID] = @fldPID, [fldComisionID] = @fldComisionID, [fldUserID] = @fldUserID, [fldOrganID] = @fldOrganID, [fldDesc] = @fldDesc, [fldIP] = @fldIP, [fldDate] = getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
