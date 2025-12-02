SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPatternFishUpdate] 
    @fldId int,
   @fldName nvarchar(200),
    @fldFileId int,
    @fldFile VARBINARY(max),
    @pasvand NVARCHAR(5),

    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	IF(@fldFile IS NULL)
	BEGIN
	UPDATE [Drd].[tblPatternFish]
	SET    [fldId] = @fldId,fldName=@fldName, [fldFileId] = @fldFileId,  [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	END
	ELSE
	UPDATE Com.tblFile
	SET fldImage=@fldFile,fldPasvand=@pasvand,fldUserId=@fldUserId,fldDesc=@fldDesc,fldDate=GETDATE()
	WHERE fldId=@fldFileId
	IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	IF(@flag=0)
	BEGIN
		UPDATE [Drd].[tblPatternFish]
		SET    [fldId] = @fldId,fldName=@fldName, [fldFileId] = @fldFileId,  [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
		WHERE  [fldId] = @fldId
		IF(@@ERROR<>0)
		BEGIN
		SET @flag=1
		ROLLBACK
		END
	END
	
	
	COMMIT TRAN
GO
