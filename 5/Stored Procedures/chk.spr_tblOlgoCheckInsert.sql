SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [chk].[spr_tblOlgoCheckInsert] 
    @fldFile VARBINARY(max),
    @fldPasvand NVARCHAR(5),
    @fldIdBank int,
    @fldUserID int,
    @fldDesc nvarchar(MAX),
	@fldTitle nvarchar(50),
	@fldOrganId int

AS 
		BEGIN TRAN
	declare @fldID int ,@fileId INT,@flag BIT=0
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
	select @fldId =ISNULL(max(fldId),0)+1 from [chk].[tblOlgoCheck] 
	INSERT INTO [chk].[tblOlgoCheck] ([fldId], [fldIdFile], [fldIdBank], [fldUserID], [fldDesc], [fldDate],fldtitle,fldOrganId)
	SELECT @fldId, @fileId, @fldIdBank, @fldUserID, @fldDesc, GETDATE(),@fldTitle,@fldOrganId 
	if (@@ERROR<>0)
		ROLLBACK
		end
	COMMIT
GO
