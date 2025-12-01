SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblApplicationPartInsert] 
 @fldTitle nvarchar(100),
    @fldPID int = NULL
AS 

	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblApplicationPart] 

	INSERT INTO [dbo].[tblApplicationPart] ([fldId], [fldTitle], [fldPID],fldUserType)
	SELECT @fldId, @fldTitle, @fldPID,1
	
	SELECT * 
	FROM   [dbo].[tblApplicationPart] 
	order by fldId desc
     
	COMMIT
GO
