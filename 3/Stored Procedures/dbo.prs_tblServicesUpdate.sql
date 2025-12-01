SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblServicesUpdate] 
    @fldId int,
    @fldTitle nvarchar(300),
    @fldIconUrl nvarchar(500),
    @fldDetailedDescription nvarchar(MAX),
    @fldInputId int,
    @fldDesc nvarchar(MAX)
AS 
	 
	
	BEGIN TRAN
set @fldDesc=dbo.fn_textNormalize(@fldDesc)
set @fldDetailedDescription=dbo.fn_textNormalize(@fldDetailedDescription)
set @fldTitle=dbo.fn_textNormalize(@fldTitle)
	UPDATE [dbo].[tblServices]
	SET    [fldTitle] = @fldTitle, [fldIconUrl] = @fldIconUrl, [fldDetailedDescription] = @fldDetailedDescription, [fldInputId] = @fldInputId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
