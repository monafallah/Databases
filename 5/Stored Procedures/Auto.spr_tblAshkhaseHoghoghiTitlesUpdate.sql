SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblAshkhaseHoghoghiTitlesUpdate] 
    @fldId int,
    @fldName nvarchar(300),
    @fldAshkhasHoghoghiId int,
    @fldIP varchar(15),
    @fldDesc nvarchar(100),
 
    @fldUserId int,
    @fldOrganId int
AS 
	 
	
	BEGIN TRAN
		set @fldName=com.fn_TextNormalize(@fldName)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Auto].[tblAshkhaseHoghoghiTitles]
	SET    [fldName] = @fldName, [fldAshkhasHoghoghiId] = @fldAshkhasHoghoghiId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
