SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblHeaderImageInsert] 
 
    @fldTitle nvarchar(150),
    @fldImageUrl nvarchar(500),
	@fldMatn1 nvarchar(max),
	@fldMatn2 nvarchar(max),
    @fldInputId int
AS 
	 
	
	BEGIN TRAN
declare @fldid smallint
set @fldTitle=dbo.fn_TextNormalize(@fldTitle)

	select @fldid=isnull(max(fldId),0)+1  FROM   [dbo].[tblHeaderImage] 
	INSERT INTO [dbo].[tblHeaderImage] ([fldId], [fldTitle], [fldImageUrl], [fldStatus],fldMatn1,fldMatn2, [fldInputId], [fldDate])
	SELECT @fldId, @fldTitle, @fldImageUrl, 0,@fldMatn1,@fldMatn2, @fldInputId, getdate()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT

GO
