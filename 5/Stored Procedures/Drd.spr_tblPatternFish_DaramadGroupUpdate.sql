SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPatternFish_DaramadGroupUpdate] 
    @fldId int,
    @fldPatternFishId int,
    @fldDaramadGroupId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
    
AS 
	BEGIN TRAN
	SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblPatternFish_DaramadGroup]
	SET    [fldId] = @fldId, [fldPatternFishId] = @fldPatternFishId, [fldDaramadGroupId] = @fldDaramadGroupId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
