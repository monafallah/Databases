SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblBankInsert] 

    @fldBankName nvarchar(100),
    @fldFile VARBINARY(max),
    @fldPasvand NVARCHAR(5),
    @fldUserId int,
    @fldCentralBankCode	tinyint	,
	@fldInfinitiveBank	nvarchar(20)	,
	@fldFix BIT,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int ,@fileId INT,@flag BIT=0
	SET @fldBankName=Com.fn_TextNormalize(@fldBankName)
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
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblBank] 
	INSERT INTO [Com].[tblBank] ([fldId], [fldBankName], [fldFileId], [fldUserId], [fldDate], [fldDesc],fldCentralBankCode,fldInfinitiveBank,fldFix)
	SELECT @fldId, @fldBankName, @fileId, @fldUserId, GETDATE(), @fldDesc,@fldCentralBankCode,@fldInfinitiveBank,@fldFix
	IF (@@ERROR<>0)
		ROLLBACK
	END

	COMMIT
GO
