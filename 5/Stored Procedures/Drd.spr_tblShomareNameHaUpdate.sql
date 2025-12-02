SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblShomareNameHaUpdate] 
    @fldId int,
    @fldMokatebatId int = NULL,
    @fldReplyTaghsitId int = NULL,
    @fldYear smallint,
    @fldShomare int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
   
AS 
	BEGIN TRAN
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblShomareNameHa]
	SET    [fldMokatebatId] = @fldMokatebatId, [fldReplyTaghsitId] = @fldReplyTaghsitId, [fldYear] = @fldYear, [fldShomare] = @fldShomare, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getDate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
