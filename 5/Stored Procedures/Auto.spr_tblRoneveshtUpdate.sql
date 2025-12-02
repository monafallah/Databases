SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblRoneveshtUpdate] 
    @fldID int,
    @fldLetterID bigint,
    --@fldAshkhasHoghoghiId int = NULL,
	@fldAshkhasHoghoghiTitlesId int,
    @fldCommisionId int = NULL,
    @fldAssignmentTypeId int = NULL,
    @fldText nvarchar(250),
   
    @fldUserID int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(16)
AS 

	BEGIN TRAN
	set @fldtext=com.fn_TextNormalize(@fldText)
	UPDATE [Auto].[tblRonevesht]
	SET    [fldLetterID] = @fldLetterID, /**[fldAshkhasHoghoghiId] = @fldAshkhasHoghoghiId,*/fldAshkhasHoghoghiTitlesId=@fldAshkhasHoghoghiTitlesId, [fldCommisionId] = @fldCommisionId, [fldAssignmentTypeId] = @fldAssignmentTypeId, [fldText] = @fldText, [fldDate] = getdate(), [fldUserID] = @fldUserID, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
