SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblFactorUpdate] 
    @fldId int,
    @fldFishId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
  
AS 
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblFactor]
	SET    [fldFishId] = @fldFishId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
