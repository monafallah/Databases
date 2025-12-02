SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblDisketInsert] 
   
   @fldID int OUT ,
    @fldTarikh nvarchar(10),
    @fldTedad int,
    @fldType bit,
    @fldJam bigint,
    @fldTypePardakht tinyint,
    @fldShobeCode	NVARCHAR(50)	,
	@fldOrganCode	NVARCHAR(50)	,
	@fldFile	VARBINARY(max)	,
	@fldPasvand NVARCHAR(50),
	@fldNameFile	nvarchar(150),
	@fldBankFixId INT,
	@fldNameShobe	nvarchar(50)	,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldOrganId int

AS 
	
	BEGIN TRAN
	SET @fldNameShobe=Com.fn_TextNormalize(@fldNameShobe)
	SET @fldNameFile=Com.fn_TextNormalize(@fldNameFile)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldMarhale nvarchar(4)='',@FileId INT,@flag BIT=0
IF(@fldBankFixId=1)
BEGIN
	IF(@fldType=1)
	BEGIN
		select @fldMarhale=ISNULL(max(fldMarhale),0100)+1 from [Pay].[tblDisket] WHERE fldType=1 AND fldBankFixId=1 and fldOrganId=@fldOrganId
		SELECT @fldMarhale=REPLACE(STR(@fldMarhale, 4), SPACE(1), '0') 
	END
	IF(@fldType=0)
	BEGIN
		select @fldMarhale =ISNULL(max(fldMarhale),0100)+1 from [Pay].[tblDisket] WHERE fldType=0 AND fldBankFixId=1 and fldOrganId=@fldOrganId
		SELECT @fldMarhale=REPLACE(STR(@fldMarhale, 4), SPACE(1), '0') 
	END
END
IF(@fldBankFixId=5)
BEGIN
	IF(@fldType=1)
	BEGIN
		select @fldMarhale =ISNULL(max(fldMarhale),0100)+1 from [Pay].[tblDisket] WHERE fldType=1 AND fldBankFixId=5 and fldOrganId=@fldOrganId
		SELECT @fldMarhale=REPLACE(STR(@fldMarhale, 4), SPACE(1), '0') 
	END
	IF(@fldType=0)
	BEGIN
		select @fldMarhale =ISNULL(max(fldMarhale),0100)+1 from [Pay].[tblDisket] WHERE fldType=0 AND fldBankFixId=5 and fldOrganId=@fldOrganId
		SELECT @fldMarhale=REPLACE(STR(@fldMarhale, 4), SPACE(1), '0') 
	END
END
IF(@fldBankFixId=4)
BEGIN
	IF(@fldType=1)
	BEGIN
		select @fldMarhale =ISNULL((MAX(CAST(fldMarhale AS INT))),0)+1 from [Pay].[tblDisket] WHERE fldType=1 AND fldBankFixId=4 and fldOrganId=@fldOrganId
		--SELECT @fldMarhale=REPLACE(STR(@fldMarhale, 4), SPACE(1), '0') 
	END
	IF(@fldType=0)
	BEGIN
		select @fldMarhale =ISNULL((MAX(CAST(fldMarhale AS INT))),0)+1 from [Pay].[tblDisket] WHERE fldType=0 AND fldBankFixId=4 and fldOrganId=@fldOrganId
		--SELECT @fldMarhale=REPLACE(STR(@fldMarhale, 4), SPACE(1), '0') 
	END
END
IF(@fldBankFixId=15)
BEGIN
	IF(@fldType=1)
	BEGIN
		select @fldMarhale =ISNULL(max(fldMarhale),0000)+1 from [Pay].[tblDisket] WHERE fldType=1 AND fldBankFixId=15 and fldOrganId=@fldOrganId
		SELECT @fldMarhale=REPLACE(STR(@fldMarhale, 4), SPACE(1), '0') 
	END
	IF(@fldType=0)
	BEGIN
		select @fldMarhale =ISNULL(max(fldMarhale),0000)+1 from [Pay].[tblDisket] WHERE fldType=0 AND fldBankFixId=15 and fldOrganId=@fldOrganId
		SELECT @fldMarhale=REPLACE(STR(@fldMarhale, 4), SPACE(1), '0') 
	END
END
	select @FileId =ISNULL(max(fldId),0)+1 FROM Com.tblFile 
	INSERT INTO Com.tblFile
	        ( fldId ,fldImage ,fldPasvand ,fldUserId ,fldDesc ,fldDate)
	SELECT @FileId,@fldFile,@fldPasvand,@fldUserId,@fldDesc,GETDATE()        
      IF(@@ERROR<>0)
      BEGIN
      	  ROLLBACK
      	  SET @flag=1
      END
     IF(@flag=0)
     BEGIN
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblDisket] 
	INSERT INTO [Pay].[tblDisket] ([fldId], [fldMarhale], [fldTarikh], [fldTedad], [fldType], [fldJam], [fldTypePardakht],fldShobeCode,fldOrganCode,fldFileId,fldNameFile, [fldUserId], [fldDesc], [fldDate],fldBankFixId,fldNameShobe,fldOrganId)
	SELECT @fldId, @fldMarhale, @fldTarikh, @fldTedad, @fldType, @fldJam, @fldTypePardakht,@fldShobeCode,@fldOrganCode,@FileId,@fldNameFile ,@fldUserId, @fldDesc, GETDATE(),@fldBankFixId,@fldNameShobe,@fldOrganId
	if (@@ERROR<>0)
		ROLLBACK
	end

	COMMIT
GO
