SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPatternFishInsert] 
   @fldName nvarchar(200),
    @fldFile VARBINARY(max),
    @pasvand NVARCHAR(5),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int ,@fldFileId INT,@flag BIT=0
	select @fldFileId =ISNULL(max(fldId),0)+1 from Com.tblFile
	INSERT INTO Com.tblFile( fldId ,fldImage ,fldPasvand ,fldUserId ,fldDesc ,fldDate)
	SELECT @fldFileId,@fldFile,@pasvand,@fldUserId,@fldDesc,GETDATE()
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblPatternFish] 
	INSERT INTO [Drd].[tblPatternFish] ([fldId],fldName, [fldFileId],  [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId,@fldName, @fldFileId,  @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK
	end
	COMMIT
GO
