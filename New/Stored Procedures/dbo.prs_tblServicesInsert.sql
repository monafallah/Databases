SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblServicesInsert] 
   
    @fldTitle nvarchar(300),
    @fldIconUrl nvarchar(500),
    @fldDetailedDescription nvarchar(MAX),
    @fldInputId int,
    @fldDesc nvarchar(MAX)
AS 
	 
	
	BEGIN TRAN
declare @fldid int
set @fldDesc=dbo.fn_textNormalize(@fldDesc)
set @fldDetailedDescription=dbo.fn_textNormalize(@fldDetailedDescription)
	select @fldid=isnull(max(fldId),0)+1  FROM   [dbo].[tblServices] 
	INSERT INTO [dbo].[tblServices] ([fldId], [fldTitle], [fldIconUrl], [fldDetailedDescription], [fldInputId], [fldDesc], [fldDate])
	SELECT @fldId, @fldTitle, @fldIconUrl, @fldDetailedDescription, @fldInputId, @fldDesc, getdate()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
