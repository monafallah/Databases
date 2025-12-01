SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblHelpInsert] 
  
    @fldFormName nvarchar(150),
	@fldFilePdf  varbinary(max),
	@fldFileVideo varbinary(max),
	@fldpasvandPdf nvarchar(5),
	@fldpasvandVideo nvarchar(5),
	@fldFilenamePdf nvarchar(100),
	@fldFilenameVideo nvarchar(100), 
    @fldDesc nvarchar(100)
AS 
	 
	
	BEGIN TRAN
declare @fldid int ,  @fldFilePdfId int = NULL,
    @fldFileVideoId int = NULL
	if (	@fldFilePdf is not null )
	begin 
		select @fldFilePdfId =isnull(max(fldid),0)+1 from tblfile
		insert into tblFile (fldId,fldFile,fldPasvand,fldDesc,fldFileName,[fldSize])
		 select @fldFilePdfId, @fldFilePdf, @fldpasvandPdf, '', @fldFilenamePdf, 0 
	end 
	if (@fldFileVideo is not null)
	begin
		select @fldFileVideoID =isnull(max(fldid),0)+1 from tblfile
		insert into tblFile (fldId,fldFile,fldPasvand,fldDesc,fldFileName,[fldSize])
		 select @fldFileVideoId, @fldFileVideo,@fldpasvandVideo, '', @fldFilenameVideo , 0 
	end 

	select @fldid=isnull(max(fldId),0)+1  FROM   [dbo].[tblHelp] 
	INSERT INTO [dbo].[tblHelp] ([fldId], [fldFormName], [fldFilePdfId], [fldFileVideoId], [fldDesc])
	SELECT @fldId, @fldFormName, @fldFilePdfId, @fldFileVideoId, @fldDesc
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
