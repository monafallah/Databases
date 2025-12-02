SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblDisketUpdate] 
    @fldId int,
 
    @fldTarikh nvarchar(10),
    @fldTedad int,
    @fldType bit,
    @fldJam bigint,
    @fldTypePardakht tinyint,
    @fldShobeCode	NVARCHAR(50)	,
	@fldOrganCode	NVARCHAR(50)	,
	@fldFileId INT,
	@fldFile	VARBINARY(max)	,
	@fldPasvand NVARCHAR(50),
	@fldNameFile	nvarchar(150),
	@fldBankFixId int,
	@fldNameShobe NVARCHAR(50),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
		SET @fldNameShobe=Com.fn_TextNormalize(@fldNameShobe)
	SET @fldNameFile=Com.fn_TextNormalize(@fldNameFile)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	DECLARE @flag BIT=0
	IF(@fldFile IS NULL)
	UPDATE [Pay].[tblDisket]
	SET    [fldId] = @fldId, [fldTarikh] = @fldTarikh, [fldTedad] = @fldTedad, [fldType] = @fldType, [fldJam] = @fldJam, [fldTypePardakht] = @fldTypePardakht,fldShobeCode=@fldShobeCode,fldOrganCode=@fldOrganCode, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldNameShobe=@fldNameShobe
	WHERE  [fldId] = @fldId
	ELSE 
	UPDATE Com.tblFile
	SET fldImage=@fldFile ,fldUserId=@fldUserId,fldDesc=@fldDesc
	WHERE @fldId=@fldFileId
	
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK 
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	UPDATE [Pay].[tblDisket]
	SET    [fldId] = @fldId,  [fldTarikh] = @fldTarikh, [fldTedad] = @fldTedad, [fldType] = @fldType, [fldJam] = @fldJam, [fldTypePardakht] = @fldTypePardakht,fldShobeCode=@fldShobeCode,fldOrganCode=@fldOrganCode, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldNameShobe=@fldNameShobe
	WHERE  [fldId] = @fldId
	IF(@@ERROR<>0)
	ROLLBACK 
	END
	
	COMMIT TRAN
GO
