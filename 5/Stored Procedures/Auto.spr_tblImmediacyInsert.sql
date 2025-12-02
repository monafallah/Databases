SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblImmediacyInsert] 
    
    @fldName nvarchar(50),
    
    @fldOrganID int,  
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(15),
    @fldImage VARBINARY(MAX),
    @fldPasvand NVARCHAR(5)
AS 
	
	BEGIN TRAN
	SET @fldName=com.fn_TextNormalize(@fldName)
	declare @fldID INT,@flag BIT=0,@fldFileId int
	SELECT @fldId=ISNULL(MAX(fldId),0)+1 FROM Com.tblFile
	SELECT @fldFileId=ISNULL(MAX(fldId),0)+1 FROM Com.tblFile
	INSERT INTO Com.tblFile( fldId,fldImage,fldPasvand,fldUserId,fldDesc,fldDate)    
	SELECT @fldId,@fldImage,@fldPasvand,@fldUserId,@fldDesc,GETDATE()
	IF(@@ERROR<>0)
	BEGIN
	ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblImmediacy] 
	INSERT INTO [Auto].[tblImmediacy] ([fldID], [fldName], [fldFileId], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP])
	SELECT @fldID, @fldName, @fldFileId, @fldOrganID, GETDATE(), @fldUserID, @fldDesc, @fldIP
	 
	
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
	end
GO
