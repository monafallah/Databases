SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Com].[spr_tblMeasureUnitUpdate] 
    @fldId int,
    @fldNameVahed nvarchar(100),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
    
AS 
	BEGIN TRAN
	set @fldNameVahed=com.fn_TextNormalize(@fldNameVahed)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [com].[tblMeasureUnit]
	SET    [fldNameVahed] = @fldNameVahed, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] =getdate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
