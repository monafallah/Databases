SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblImmediacyUpdate] 
    @fldID int,
    @fldName nvarchar(50),
    @fldFileId int,
    @fldOrganID int,
    @fldImage VARBINARY(max),
    @fldPasvand NVARCHAR(5), 
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(15)
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	SET @fldName=com.fn_TextNormalize(@fldName)
	IF(@fldImage IS NULL)
	UPDATE Auto.tblImmediacy
	SET    [fldID] = @fldID, [fldName] = @fldName, [fldFileId] = @fldFileId, [fldOrganID] = @fldOrganID, [fldDate] = GETDATE(), [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldIP] = @fldIP
	WHERE  [fldID] = @fldID
	ELSE
	BEGIn
		UPDATE Auto.tblImmediacy
		SET    [fldID] = @fldID, [fldName] = @fldName, [fldFileId] = @fldFileId, [fldOrganID] = @fldOrganID, [fldDate] = GETDATE(), [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldIP] = @fldIP
		WHERE  [fldID] = @fldID
		IF(@@ERROR<>0)
		BEGIN 
		ROLLBACK 
		SET @flag=1
		END
		IF(@flag=0)
		BEGIN
		UPDATE Com.tblFile
		SET  [fldImage]=@fldImage, [fldPasvand]=@fldPasvand, [fldUserId]=@fldUserID, [fldDesc]=@fldDesc,[fldDate] =GETDATE()
		WHERE fldId=@fldFileId
		IF(@@ERROR<>0)
			ROLLBACK
			END
	END
	COMMIT TRAN
GO
