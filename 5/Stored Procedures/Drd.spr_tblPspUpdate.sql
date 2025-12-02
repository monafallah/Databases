SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPspUpdate] 
    @fldId int,
    @fldTitle nvarchar(300),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldFile varbinary(MAX),
	@fldPasvand NVARCHAR(5),
    @fldFileId int
AS 
	BEGIN TRAN
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	DECLARE @flag bit=0
	IF(@fldFile IS NULL)
	BEGIN
	UPDATE [Drd].[tblPsp]
	SET    [fldTitle] = @fldTitle, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldFileId] = @fldFileId
	WHERE  [fldId] = @fldId
	END
	ELSE
  BEGIN
		UPDATE [Com].[tblFile]
		SET    [fldImage] = @fldFile, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldPasvand=@fldPasvand
		WHERE  [fldId] = @fldFileId
		IF(@@ERROR<>0)
		BEGIN
			SET @flag=1
			ROLLBACK
  END
	IF(@flag=0)
		BEGIN
		UPDATE [Drd].[tblPsp]
		SET    [fldTitle] = @fldTitle, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldFileId] = @fldFileId
		WHERE  [fldId] = @fldId
	END
END
COMMIT TRAN
GO
