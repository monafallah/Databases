SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreSabet_NerkhUpdate] 
    @fldId int,
    @fldParametreSabetId int,
    @fldTarikhFaalSazi nvarchar(10),
    @fldValue NVARCHAR(50),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
  
AS 
	BEGIN TRAN
	set @fldTarikhFaalSazi=com.fn_TextNormalize(@fldTarikhFaalSazi)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblParametreSabet_Nerkh]
	SET    [fldParametreSabetId] = @fldParametreSabetId, [fldTarikhFaalSazi] = @fldTarikhFaalSazi, [fldValue] = @fldValue, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getDate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
