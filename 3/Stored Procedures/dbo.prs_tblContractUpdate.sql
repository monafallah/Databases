SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblContractUpdate] 
    @fldId int,
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
	set @fldDesc=dbo.fn_textNormalize(@fldDesc)
set @fldTitle=dbo.fn_textNormalize(@fldTitle)
	UPDATE [dbo].[tblContract]
	SET    [fldTitle] = @fldTitle, [fldCreatedDate] = @fldCreatedDate, [fldTechnologies] = @fldTechnologies, [fldImageUrl] = @fldImageUrl, [fldInputId] = @fldInputId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	,fldGitHubUrl=@fldGitHubUrl
	,fldDemoUrl=@fldDemoUrl
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
