SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblSodoorFish_DetailUpdate] 
    @fldId int,
    @fldFishId int,
    @fldCodeElamAvarezId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblSodoorFish_Detail]
	SET    [fldId] = @fldId, [fldFishId] = @fldFishId, [fldCodeElamAvarezId] = @fldCodeElamAvarezId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
