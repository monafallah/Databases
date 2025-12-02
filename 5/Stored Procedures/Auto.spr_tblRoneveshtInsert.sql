SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblRoneveshtInsert] 
   
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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblRonevesht] 

	INSERT INTO [Auto].[tblRonevesht] ([fldID], [fldLetterID], [fldAshkhasHoghoghiId], [fldCommisionId], [fldAssignmentTypeId], [fldText], [fldDate], [fldUserID], [fldOrganId], [fldDesc], [fldIP],fldAshkhasHoghoghiTitlesId)
	SELECT @fldID, @fldLetterID, NULL, @fldCommisionId, @fldAssignmentTypeId, @fldText, getdate(), @fldUserID, @fldOrganId, @fldDesc, @fldIP,@fldAshkhasHoghoghiTitlesId
	if(@@Error<>0)
        rollback       
	COMMIT
GO
