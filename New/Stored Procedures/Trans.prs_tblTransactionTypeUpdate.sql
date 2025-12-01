SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblTransactionTypeUpdate] 
    @fldId int,
    @fldName nvarchar(200),
    @fldTransactionGroupId int,
	@Fileid int,
	@file varbinary(max),
	@Pasvand nvarchar(5),
	@fileName nvarchar(100)
AS 
	BEGIN TRAN
	declare @flag bit=0
	SET @fldName=dbo.fn_TextNormalize(@fldName)
	if(@file is not null)
	begin
	if(@file is not null and @Fileid is null)
	begin
		SELECT @Fileid=isNull(max (fldID),0)+1 FROM dbo.tblFile
			INSERT INTO dbo.tblFile( fldId , fldFile ,fldPasvand  , fldDesc ,fldSize,fldFileName )
			SELECT  @Fileid,@file,@Pasvand,'',cast(round((DATALENGTH(@file)/1024.0)/1024.0,2) as decimal(8,2)) ,@fileName
			if(@@error<>0)
			begin
			rollback
			set @flag=1
		end
	end
	else if (@file is not null and @Fileid is not null)
	UPDATE tblfile 
		 SET fldFile=@file,fldSize=cast(round((DATALENGTH(@file)/1024.0)/1024.0,2) as decimal(8,2))
		 WHERE fldid=@Fileid
		 	if(@@error<>0)
			begin
			rollback
			set @flag=1
		end
	
	if(@flag=0)
	begin
	UPDATE [Trans].[tblTransactionType]
	SET    [fldName] = @fldName, [fldTransactionGroupId] = @fldTransactionGroupId,fldFileid=@Fileid
	WHERE  [fldId] = @fldId
	if(@@error<>0)
	rollback
	end
end
else
begin
	UPDATE [Trans].[tblTransactionType]
	SET    [fldName] = @fldName, [fldTransactionGroupId] = @fldTransactionGroupId,fldFileid=null
	WHERE  [fldId] = @fldId
	if(@@error<>0)
	rollback
	else
	begin
		delete from tblfile
		where fldid=@Fileid
		if(@@error<>0)
		rollback
	end
end
	COMMIT TRAN
GO
