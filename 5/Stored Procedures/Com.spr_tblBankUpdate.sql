SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblBankUpdate] 
    @fldId int,
    @fldBankName nvarchar(100),
    @fldFileId int,
    @fldFile VARBINARY(max),
    @fldPasvand NVARCHAR(5),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldCentralBankCode	tinyint	,
	@fldInfinitiveBank	nvarchar(20)	,
	@fldFix bit
	AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	SET @fldBankName=Com.fn_TextNormalize(@fldBankName)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldPasvand=Com.fn_TextNormalize(@fldPasvand)
	IF(@fldFile IS NULL)
	UPDATE [Com].[tblBank]
	SET    [fldId] = @fldId, [fldBankName] = @fldBankName, [fldFileId] = @fldFileId, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc,fldCentralBankCode=@fldCentralBankCode,fldInfinitiveBank=@fldInfinitiveBank,fldFix=@fldFix
	WHERE  [fldId] = @fldId
	ELSE
	begin
	UPDATE [Com].[tblBank]
	SET    [fldId] = @fldId, [fldBankName] = @fldBankName, [fldFileId] = @fldFileId, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc,fldCentralBankCode=@fldCentralBankCode,fldInfinitiveBank=@fldInfinitiveBank,fldFix=@fldFix
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
		WHERE fldid=@fldFileId
		IF(@@ERROR<>0)
		ROLLBACK
	END
	
	end
	
	COMMIT TRAN
GO
