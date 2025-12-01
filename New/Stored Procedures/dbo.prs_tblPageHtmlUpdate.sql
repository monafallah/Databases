SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblPageHtmlUpdate] 
    @fldId int,
    @fldMohtavaHtml nvarchar(MAX),
    @fldInputId int,
    
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	SET @fldMohtavaHtml=dbo.fn_TextNormalize(@fldMohtavaHtml)
	UPDATE [dbo].[tblPageHtml]
	SET    [fldMohtavaHtml] = @fldMohtavaHtml, [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	if(@@ERROR<>0)
	begin
	rollback
	end

	COMMIT TRAN
GO
