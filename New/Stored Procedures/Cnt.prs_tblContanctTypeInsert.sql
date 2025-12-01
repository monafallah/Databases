SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblContanctTypeInsert] 
   
    @fldType nvarchar(100),
	 @fldFormul nvarchar(MAX) = NULL,
    @fldFormulId int = NULL,
    @fldIcon varbinary(mAx),
	@Pasavand nvarchar(6),
	@FileName nvarchar(100),
	@inputid int,
    @fldJsonParametr nvarchar(2000)
AS 

	begin try
	BEGIN TRAN
	Declare  @fldRowId varbinary(8),@flag bit=0
	declare @fldID int , @fldIconId int
	SET @FileName=dbo.fn_TextNormalize(@FileName)
	SET @fldType=dbo.fn_TextNormalize(@fldType)
	SELECT @fldIconId=isNull(max (fldID),0)+1 FROM dbo.tblFile
	INSERT INTO dbo.tblFile( fldId , fldFile ,fldPasvand  , fldDesc  ,fldSize,fldFileName )
	SELECT  @fldIconId,@fldIcon ,@Pasavand,'',cast(round((DATALENGTH(@fldIcon)/1024.0)/1024.0,2) as decimal(8,2)) ,@FileName
	
	
	select @fldID =ISNULL(max(fldId),0)+1 from [Cnt].[tblContanctType] 
	INSERT INTO [Cnt].[tblContanctType] ([fldId], [fldType], [fldIconId], [fldFormul], [fldFormulId],fldInputId)
	SELECT @fldId, @fldType, @fldIconId,  @fldFormul,    @fldFormulId ,@inputid

		select @fldRowId=tblContanctType.%%physLoc%% from cnt.tblContanctType WHERE  [fldId] = @fldId
		exec  [Trans].[prs_tblSubTransactionInsert] '',
													@inputId ,
													1 ,
													1 ,
													'tblContanctType' ,
													@fldRowId,
													null ,
													@fldJsonParametr 

		
	  
	   select 0 as ErrorCode,'' as ErrorMsg
	COMMIT
	end try
	begin catch
		rollback 
		select @@error as ErrorCode,ERROR_MESSAGE() as ErrorMsg
	end catch
GO
