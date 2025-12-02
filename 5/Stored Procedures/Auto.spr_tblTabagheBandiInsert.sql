SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblTabagheBandiInsert] 

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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblTabagheBandi] 

	INSERT INTO [Auto].[tblTabagheBandi] ([fldID], [fldName], [fldPID], [fldComisionID], [fldUserID], [fldOrganID], [fldDesc], [fldIP], [fldDate])
	SELECT @fldID, @fldName, @fldPID, @fldComisionID, @fldUserID, @fldOrganID, @fldDesc, @fldIP, getdate()
	if(@@Error<>0)
        rollback       
	COMMIT
GO
