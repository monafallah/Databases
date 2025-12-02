SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Com].[spr_tblAshkhasUpdate] 
    @fldId int,
    @fldHaghighiId int ,
    @fldHoghoghiId int ,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
    
AS 
	BEGIN TRAN
	set  @fldDesc=com.fn_TextNormalize( @fldDesc)
	UPDATE [com].[tblAshkhas]
	SET    [fldHaghighiId] = @fldHaghighiId, [fldHoghoghiId] = @fldHoghoghiId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
