SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblCompanyPostUpdate] 
    @fldId smallint,
    @fldTitle nvarchar(150),
    @fldUserId int,
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN
	set @fldTitle=com.fn_TextNormalize(@fldTitle)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Com].[tblCompanyPost]
	SET    [fldTitle] = @fldTitle, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
