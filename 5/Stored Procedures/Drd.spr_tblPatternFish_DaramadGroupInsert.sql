SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblPatternFish_DaramadGroupInsert] 

    @fldPatternFishId int,
    @fldDaramadGroupId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblPatternFish_DaramadGroup] 
	INSERT INTO [Drd].[tblPatternFish_DaramadGroup] ([fldId], [fldPatternFishId], [fldDaramadGroupId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldPatternFishId, @fldDaramadGroupId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
