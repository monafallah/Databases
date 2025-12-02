SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblDaramadGroupUpdate] 
    @fldId int,
    @fldTitle nvarchar(150),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldOrganId INT
AS 
	BEGIN TRAN
	SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	SET @fldTitle=com.fn_TextNormalize(@fldTitle)
	UPDATE [Drd].[tblDaramadGroup]
	SET    [fldId] = @fldId, [fldTitle] = @fldTitle, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldOrganId=@fldOrganId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
