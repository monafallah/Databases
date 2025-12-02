SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblBoxInsert] 
 
    @fldName nvarchar(50),
    @fldComisionID int,
    @fldBoxTypeID int,
    @fldPID int = NULL,
    @fldOrganID int,
   
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(15) = NULL
AS 

	
	BEGIN TRAN
	declare @fldID int
	set @fldName=com.fn_TextNormalize(@fldName)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblBox] 

	INSERT INTO [Auto].[tblBox] ([fldID], [fldName], [fldComisionID], [fldBoxTypeID], [fldPID], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP])
	SELECT @fldID, @fldName, @fldComisionID, @fldBoxTypeID, @fldPID, @fldOrganID, getdate(), @fldUserID, @fldDesc, @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
