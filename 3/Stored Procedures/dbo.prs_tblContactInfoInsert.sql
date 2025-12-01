SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblContactInfoInsert] 
   
    @fldType tinyint,
    @fldMatn nvarchar(MAX),
    @fldInputId int
AS 
	 
	
	BEGIN TRAN
declare @fldid int
set @fldMatn=[dbo].[fn_TextNormalize](@fldMatn)
	select @fldid=isnull(max(fldId),0)+1  FROM   [dbo].[tblContactInfo] 
	INSERT INTO [dbo].[tblContactInfo] ([fldId], [fldType], [fldMatn], [fldInputId], [fldDate])
	SELECT @fldId, @fldType, @fldMatn, @fldInputId, getdate()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
