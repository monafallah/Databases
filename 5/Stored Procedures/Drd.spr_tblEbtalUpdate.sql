SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblEbtalUpdate] 
    @fldId int,
    @fldFishId int,
    @fldRequestTaghsit_TakhfifId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblEbtal]
	SET    [fldId] = @fldId, [fldFishId] = @fldFishId, [fldRequestTaghsit_TakhfifId] = @fldRequestTaghsit_TakhfifId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
