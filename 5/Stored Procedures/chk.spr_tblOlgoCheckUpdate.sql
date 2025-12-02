SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [chk].[spr_tblOlgoCheckUpdate] 
   
    @fldId int,
	@fldFile VARBINARY(max),
    @fldPasvand NVARCHAR(5),
    @fldIdFile int,
    @fldIdBank int,
    @fldUserID int,
    @fldDesc nvarchar(MAX),
	@fldTitle NVARCHAR(50),
		@fldOrganId int
	AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldPasvand=Com.fn_TextNormalize(@fldPasvand)
	IF(@fldFile IS NULL)
		UPDATE [chk].[tblOlgoCheck]
	SET    [fldIdFile] = @fldIdFile, [fldIdBank] = @fldIdBank, [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldDate] =  GETDATE(),fldTitle=@fldTitle,fldOrganId =	@fldOrganId 
	WHERE  [fldId] = @fldId
	else
	BEGIN
	UPDATE [chk].[tblOlgoCheck]
	SET    [fldIdFile] = @fldIdFile, [fldIdBank] = @fldIdBank, [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldTitle=@fldTitle,fldOrganId =	@fldOrganId 
	WHERE  [fldId] = @fldId
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK 
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
		UPDATE Com.tblFile
		SET fldImage=@fldFile,fldPasvand=@fldPasvand,fldUserId=@fldUserId ,fldDesc=@fldDesc,fldDate=GETDATE()
		WHERE fldid=@fldIdFile
		IF(@@ERROR<>0)
		ROLLBACK
	END
	end
	COMMIT TRAN
GO
