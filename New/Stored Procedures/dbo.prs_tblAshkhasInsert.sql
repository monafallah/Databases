SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE  PROC [dbo].[prs_tblAshkhasInsert] 
    
    @fldName nvarchar(100),
    @fldFamily nvarchar(150),
    @fldFatherName nvarchar(100) = NULL,
    @fldCodeMeli varchar(10),
    @fldEmail varchar(100) = NULL,
    @fldMobile varchar(19) = NULL,
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
	@fldJsonParametr  nvarchar(2000)
AS 

	begin try
	BEGIN TRAN
	set @fldName= dbo.fn_TextNormalize(@fldName)
	set @fldFamily= dbo.fn_TextNormalize(@fldFamily)
	set @fldFatherName= dbo.fn_TextNormalize(@fldFatherName)
	set @fldDesc= dbo.fn_TextNormalize(@fldDesc)
	set @fldFileName= dbo.fn_TextNormalize(@fldFileName)

	declare @fldID int ,@fldFileId int = NULL

	Declare  @fldRowId varbinary(8)

	if (@fldfile is not null)
	begin
		select @fldFileId =ISNULL(max(fldId),0)+1 from [dbo].[tblfile] 
		INSERT INTO [dbo].[tblFile] ([fldId], [fldFile], [fldPasvand], [fldDesc], [fldFileName], [fldSize])
		SELECT @fldFileId, @fldFile, @fldPasvand, @fldDesc, @fldFileName, cast(round((DATALENGTH(@fldFile)/1024.0)/1024.0,2) as decimal(8,2))
	end
	else 
	set @fldFileId=null

	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblAshkhas] 
	INSERT INTO [dbo].[tblAshkhas] ([fldId], [fldName], [fldFamily], [fldFatherName], [fldCodeMeli], [fldEmail], [fldMobile], [fldFileId], [fldDesc], [fldSh_Shenasname], [fldCodeMahalTavalod], [fldCodeMahalSodoor], [fldJensiyat], [fldTarikhTavalod],fldInputId)
	SELECT @fldId, @fldName, @fldFamily, @fldFatherName, @fldCodeMeli, @fldEmail, @fldMobile, @fldFileId, @fldDesc, @fldSh_Shenasname, @fldCodeMahalTavalod, @fldCodeMahalSodoor, @fldJensiyat, @fldTarikhTavalod,@Inputid
	
	
	
	
		select @fldRowId=[tblAshkhas].%%physLoc%% from [tblAshkhas] WHERE  [fldId] = @fldId
		exec  [Trans].[prs_tblSubTransactionInsert] '',
													@inputId ,
													1 ,
													1 ,
													'tblAshkhas' ,
													@fldRowId,
													null ,
													@fldJsonParametr 
		
	
	select 0 as ErrorCode,'' as ErrorMessage
			      
	COMMIT
	end try
	begin  catch
		
			rollback
			select @@ERROR as ErrorCode,ERROR_MESSAGE() as ErrorMessage
	end catch
GO
