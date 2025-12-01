SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblContractInsert] 
   
    @fldTitle nvarchar(300),
    @fldCreatedDate datetime,
    @fldTechnologies nvarchar(2000),
    @fldImageUrl nvarchar(300),
    @fldInputId int,
    @fldDesc nvarchar(MAX),
	@fldGitHubUrl nvarchar(100),
	@fldDemoUrl nvarchar(100)
AS 
	 
	
	BEGIN TRAN
declare @fldid int
set @fldDesc=dbo.fn_textNormalize(@fldDesc)
set @fldTitle=dbo.fn_textNormalize(@fldTitle)
	select @fldid=isnull(max(fldId),0)+1  FROM   [dbo].[tblContract] 
	INSERT INTO [dbo].[tblContract] ([fldId], [fldTitle], [fldCreatedDate], [fldTechnologies], [fldImageUrl], [fldInputId], [fldDesc], [fldDate],fldGitHubUrl,fldDemoUrl)
	SELECT @fldId, @fldTitle, @fldCreatedDate, @fldTechnologies, @fldImageUrl, @fldInputId, @fldDesc, getdate(),@fldGitHubUrl,@fldDemoUrl
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
