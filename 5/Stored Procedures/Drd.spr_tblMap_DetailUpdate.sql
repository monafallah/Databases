SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMap_DetailUpdate] 
    @fldId int,
    @fldHeaderId int,
    @fldMaghsadId int,
    @fldCodeDaramadMabda nvarchar(50),
   
    @fldOrganId int,
    @fldUserId int
AS 
	 
	
	BEGIN TRAN

	UPDATE [Drd].[tblMap_Detail]
	SET    [fldHeaderId] = @fldHeaderId, [fldMaghsadId] = @fldMaghsadId, [fldCodeDaramadMabda] = @fldCodeDaramadMabda, [fldDate] = getdate(), [fldOrganId] = @fldOrganId, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
