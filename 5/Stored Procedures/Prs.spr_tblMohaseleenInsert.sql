SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblMohaseleenInsert] 
    
    @fldAfradTahtePoosheshId int,
    @fldTarikh int,
    @fldUserId int
AS 
	 
	
	BEGIN TRAN
declare @fldid int
	select @fldid=isnull(max(fldId),0)+1  FROM   [Prs].[tblMohaseleen] 
	INSERT INTO [Prs].[tblMohaseleen] ([fldId], [fldAfradTahtePoosheshId], [fldTarikh], [fldUserId], [fldDate])
	SELECT @fldId, @fldAfradTahtePoosheshId, @fldTarikh, @fldUserId, GETDATE()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
