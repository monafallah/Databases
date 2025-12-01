SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblAshkhasUpdate] 
    @fldId int,
    @fldName nvarchar(100),
    @fldFamily nvarchar(150),
    @fldFatherName nvarchar(100) = NULL,
    @fldCodeMeli varchar(10),
    @fldEmail varchar(100) = NULL,
    @fldMobile varchar(19) = NULL,
    @fldFileId int = NULL,
	@fldFile varbinary (max),
	@fldPasvand nvarchar(5),
	@fldFileName nvarchar(150),
    @fldDesc nvarchar(100) = NULL,
    @fldSh_Shenasname varchar(10) = NULL,
    @fldCodeMahalTavalod int = NULL,
    @fldCodeMahalSodoor int = NULL,
    @fldJensiyat bit = NULL,
    @fldTarikhTavalod int = NULL,
	@Inputid int,
	@fldTimeStamp int
AS 
	begin try
	BEGIN TRAN
	set @fldName= dbo.fn_TextNormalize(@fldName)
	set @fldFamily= dbo.fn_TextNormalize(@fldFamily)
	set @fldFatherName= dbo.fn_TextNormalize(@fldFatherName)
	set @fldDesc= dbo.fn_TextNormalize(@fldDesc)
	set @fldFileName= dbo.fn_TextNormalize(@fldFileName)

	Declare @flag tinyint,@flag2 bit=0
	if not exists(select * from tblAshkhas where fldId=@fldId )
			set @flag= 2 
		else if exists( select * from tblAshkhas where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=1 
		else if not exists(select * from tblAshkhas where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=0 
	
	if(@flag=1)
	begin
		if (@fldFileId is null and @fldFile is not null)
		begin
			select @fldFileId =ISNULL(max(fldId),0)+1 from [dbo].[tblfile] 
			INSERT INTO [dbo].[tblFile] ([fldId], [fldFile], [fldPasvand], [fldDesc], [fldFileName], [fldSize])
			SELECT @fldFileId, @fldFile, @fldPasvand, @fldDesc, @fldFileName, cast(round((DATALENGTH(@fldFile)/1024.0)/1024.0,2) as decimal(8,2))
			
		end
		else if (@fldFileId is null and @fldFile is not null)
		begin
			update tblfile
				set fldfile=@fldFile,fldPasvand=@fldPasvand,fldDesc=@fldDesc,
				fldFilename=@fldFileName,fldsize= cast(round((DATALENGTH(@fldFile)/1024.0)/1024.0,2) as decimal(8,2))
				where fldid=@fldFileId
				
		end
		
			UPDATE [dbo].[tblAshkhas]
			SET    [fldName] = @fldName, [fldFamily] = @fldFamily, [fldFatherName] = @fldFatherName, [fldCodeMeli] = @fldCodeMeli,
			 [fldEmail] = @fldEmail, [fldMobile] = @fldMobile, [fldFileId] = @fldFileId, [fldDesc] = @fldDesc, 
			 [fldSh_Shenasname] = @fldSh_Shenasname, [fldCodeMahalTavalod] = @fldCodeMahalTavalod, 
			 [fldCodeMahalSodoor] = @fldCodeMahalSodoor, [fldJensiyat] = @fldJensiyat, [fldTarikhTavalod] = @fldTarikhTavalod 
			,fldInputId=@Inputid
			WHERE  fldId=@fldId
			 
		end

		select @flag as flag,'' as ErrorMsg
	COMMIT
	end try
	begin catch
		rollback
		select @@error as flag ,ERROR_MESSAGE() as ErrorMsg
	end catch
GO
