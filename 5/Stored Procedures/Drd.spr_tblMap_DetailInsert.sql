SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMap_DetailInsert] 
   
    @fldHeaderId int,
    @fldMaghsadId int,
    @fldCodeDaramadMabda nvarchar(50),
  
    @fldOrganId int,
    @fldUserId int
AS 
	 
	
	BEGIN TRAN
declare @fldid int
	select @fldid=isnull(max(fldId),0)+1  FROM   [Drd].[tblMap_Detail] 
	INSERT INTO [Drd].[tblMap_Detail] ([fldId], [fldHeaderId], [fldMaghsadId], [fldCodeDaramadMabda], [fldDate], [fldOrganId], [fldUserId])
	SELECT @fldId, @fldHeaderId, @fldMaghsadId, @fldCodeDaramadMabda, getdate(), @fldOrganId, @fldUserId
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
