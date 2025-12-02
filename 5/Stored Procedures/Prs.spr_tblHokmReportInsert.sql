SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHokmReportInsert] 

    @fldName nvarchar(50),
    @fldFile VARBINARY(max),
    @fldPasvand NVARCHAR(5),
    @fldAnvaEstekhdamId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldPasvand=Com.fn_TextNormalize(@fldPasvand)
	SET @fldName=Com.fn_TextNormalize(@fldName)
	declare @fldID int ,@fldFileId INT,@flag BIT=0
	select @fldFileId =ISNULL(max(fldId),0)+1 from Com.tblFile
	INSERT INTO Com.tblFile( fldId ,fldImage ,fldPasvand ,fldUserId , fldDesc ,fldDate)
	SELECT @fldFileId,@fldFile,@fldPasvand,@fldUserId,@fldDesc,GETDATE()
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblHokmReport] 
	INSERT INTO [Prs].[tblHokmReport] ([fldId], [fldName], [fldFileId], [fldAnvaEstekhdamId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldName, @fldFileId, @fldAnvaEstekhdamId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK
	end
	COMMIT
GO
