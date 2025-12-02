SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblReshteTahsiliInsert] 
 
    @fldTitle nvarchar(300),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldTitle=com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblReshteTahsili] 
	INSERT INTO [Com].[tblReshteTahsili] ([fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldTitle, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
