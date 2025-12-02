SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMokatebatUpdate] 
    @fldId int,
    @fldCodhayeDaramadiElamAvarezId int,
    @fldFileId INT OUT,
    @fldFile varbinary(MAX),
	@fldPasvand NVARCHAR(5),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
   
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	select @fldFileId =ISNULL(max(fldId),0)+1 from [Drd].[tblMokatebat] 
	INSERT INTO Com.tblFile
	        (fldId ,fldImage ,fldPasvand ,fldUserId ,fldDesc ,fldDate)
	SELECT @fldFileId,@fldFile,@fldPasvand,@fldUserId,@fldDesc,GETDATE()
	IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	IF(@flag=0)
	BEGIN
	UPDATE [Drd].[tblMokatebat]
	SET    [fldCodhayeDaramadiElamAvarezId] = @fldCodhayeDaramadiElamAvarezId, [fldFileId] = @fldFileId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	END
	
	COMMIT TRAN
GO
