SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblGozareshatFileInsert] 

    @fldGozareshatId int,
    @fldOrganId int,
    @file VARBINARY(max),
    @Passvand NVARCHAR(5),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID INT,@FileId INT,@flag BIT=0
	SELECT @FileId=ISNULL(max(fldId),0)+1  FROM com.tblFile
	INSERT INTO Com.tblFile( fldId ,fldImage ,fldPasvand ,fldUserId , fldDesc ,fldDate)
	SELECT @FileId,@file,@Passvand,@fldUserId,@fldDesc,GETDATE()
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblGozareshatFile] 
	INSERT INTO [Drd].[tblGozareshatFile] ([fldId], [fldGozareshatId], [fldOrganId], [fldReportFileId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldGozareshatId, @fldOrganId, @FileId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK
	END
	

	COMMIT
GO
