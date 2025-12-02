SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblAshkhasInsert] 
   
    @fldHaghighiId int ,
    @fldHoghoghiId int ,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
   
AS 
	
	BEGIN TRAN
	set  @fldDesc=com.fn_TextNormalize( @fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [com].[tblAshkhas] 
	INSERT INTO [com].[tblAshkhas] ([fldId], [fldHaghighiId], [fldHoghoghiId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldHaghighiId, @fldHoghoghiId, @fldUserId, @fldDesc, getdate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
