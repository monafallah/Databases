SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblInsuranceCompanyInsert] 

    @fldName nvarchar(100),
    @fldFile VARBINARY(max),
    @fldPasvand NVARCHAR(5),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldOrganId INT,
    @fldIp VARCHAR(16)
AS 
	
	BEGIN TRAN
	declare @fldID int ,@fileId INT,@flag BIT=0
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldPasvand=Com.fn_TextNormalize(@fldPasvand)
	select @fileId =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
	INSERT INTO [Com].tblFile( fldId , fldImage ,fldPasvand ,fldUserId , fldDesc ,fldDate)
	SELECT @fileId, @fldFile, @fldPasvand, @fldUserId, @fldDesc, GETDATE()
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	select @fldID =ISNULL(max(fldId),0)+1 from [Str].[tblInsuranceCompany] 
	INSERT INTO [Str].[tblInsuranceCompany] ([fldId], [fldName], [fldFileId], [fldUserId], [fldDate], [fldDesc],[fldOrganId],[fldIp])
	SELECT @fldId, @fldName, @fileId, @fldUserId, GETDATE(), @fldDesc,@fldOrganId,@fldIp
	IF (@@ERROR<>0)
		ROLLBACK
	END

	COMMIT
GO
