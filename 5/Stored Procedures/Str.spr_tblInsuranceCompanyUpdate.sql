SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblInsuranceCompanyUpdate] 
    @fldId int,
    @fldName nvarchar(100),
    @fldFileId int,
    @fldFile VARBINARY(max),
    @fldPasvand NVARCHAR(5),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldOrganId INT,
    @fldIp varCHAR(16)
	AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldPasvand=Com.fn_TextNormalize(@fldPasvand)
	IF(@fldFile IS NULL)
	UPDATE [Str].[tblInsuranceCompany]
	SET    [fldId] = @fldId, [fldName] = @fldName, [fldFileId] = @fldFileId, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc,[fldOrganId]=@fldOrganId,[fldIp]=@fldIp
	WHERE  [fldId] = @fldId
	ELSE
	begin
	UPDATE [Str].[tblInsuranceCompany]
	SET    [fldId] = @fldId, [fldName] = @fldName, [fldFileId] = @fldFileId, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc,[fldOrganId]=@fldOrganId,[fldIp]=@fldIp
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
