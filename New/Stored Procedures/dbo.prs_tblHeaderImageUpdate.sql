SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblHeaderImageUpdate] 
    @fldId smallint,
    @fldTitle nvarchar(150),
    @fldImageUrl nvarchar(500),
	@fldMatn1 nvarchar(max),
	@fldMatn2 nvarchar(max),
    @fldInputId int
AS 
	 
	
	BEGIN TRAN
	set @fldTitle=dbo.fn_TextNormalize(@fldTitle)
	UPDATE [dbo].[tblHeaderImage]
	SET    [fldTitle] = @fldTitle, [fldImageUrl] = @fldImageUrl,[fldInputId] = @fldInputId, [fldDate] = getdate()
	,fldMatn1=@fldMatn1,fldMatn2=@fldMatn2
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
