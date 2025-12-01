SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblPageHtmlInsert] 

    @fldTitle nvarchar(100),
    @fldMasir nvarchar(MAX),
    @fldMohtavaHtml nvarchar(MAX),
    @fldInputId int,
    @fldUserId int,
    @fldDesc nvarchar(500)
AS 
	
	BEGIN TRAN
	SET @fldTitle=dbo.fn_TextNormalize(@fldTitle)
	SET @fldMasir=dbo.fn_TextNormalize(@fldMasir)
	SET @fldMohtavaHtml=dbo.fn_TextNormalize(@fldMohtavaHtml)
	SET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblPageHtml] 
	INSERT INTO [dbo].[tblPageHtml] ([fldId], [fldTitle], [fldMasir], [fldMohtavaHtml] , [fldDesc])
	SELECT @fldId, @fldTitle, @fldMasir, @fldMohtavaHtml ,@fldDesc
	if (@@ERROR<>0)
	begin	
		ROLLBACK
	end
	
	

	COMMIT
GO
