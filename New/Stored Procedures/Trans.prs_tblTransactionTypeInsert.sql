SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblTransactionTypeInsert] 

    @fldName nvarchar(200),
    @fldTransactionGroupId int,
	@file varbinary(max),
	@Pasvand nvarchar(5),
	@fileName nvarchar(100),
	@fldDesc nvarchar(200)
AS 
	
	BEGIN TRAN
	SET @FileName=dbo.fn_TextNormalize(@FileName)
		SET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
		SET @fldName=dbo.fn_TextNormalize(@fldName)
	declare @fldID int ,@fldFileId int=null,@flag bit=0
	if(@file is not null)
	begin
	SELECT @fldFileId=isNull(max (fldID),0)+1 FROM dbo.tblFile
			INSERT INTO dbo.tblFile( fldId , fldFile ,fldPasvand  , fldDesc ,fldSize,fldFileName )
			SELECT  @fldFileId,@file,@Pasvand,@fldDesc,cast(round((DATALENGTH(@file)/1024.0)/1024.0,2) as decimal(8,2)) ,@fileName
			if(@@error<>0)
			begin
			rollback
			set @flag=1
		end
	end
	if(@flag=0)
		begin
		select @fldID =ISNULL(max(fldId),0)+1 from [Trans].[tblTransactionType] 
		INSERT INTO [Trans].[tblTransactionType] ([fldId], [fldName], [fldTransactionGroupId],fldFileId)
		SELECT @fldId, @fldName, @fldTransactionGroupId,@fldFileId
		if (@@ERROR<>0)
			ROLLBACK
		
	end
	COMMIT
GO
