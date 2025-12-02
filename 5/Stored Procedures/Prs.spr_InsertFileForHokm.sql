SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
	CREATE PROC [Prs].[spr_InsertFileForHokm]
	@fldPersonalHokmId INT,
	@fldImage varbinary(MAX),
    @fldPasvand NVARCHAR(5),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
    AS
    BEGIN
    DECLARE @fileId INT,@flag BIT=0
	SELECT @fileId =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
	INSERT INTO [Com].[tblFile] ([fldId], [fldImage],fldPasvand, [fldUserId], [fldDesc], [fldDate])
	SELECT @fileId, @fldImage,@fldPasvand, @fldUserId, @fldDesc, GETDATE()
	IF(@@ERROR<>0)
	BEGIN
	ROLLBACK
	SET @flag=1
	end
	IF(@flag=0)
	BEGIN
	UPDATE Prs.tblPersonalHokm
	SET fldFileId=@fileId,fldStatusHokm=1
	WHERE fldId=@fldPersonalHokmId
	IF(@@ERROR<>0)
	ROLLBACK
	END
	end
GO
