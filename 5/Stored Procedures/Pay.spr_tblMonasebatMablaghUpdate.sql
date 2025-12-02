SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMonasebatMablaghUpdate] 
    @fldId int,
    @fldHeaderId int,
    @fldMonasebatId tinyint,
    @fldMablagh int,
    @fldTypeNesbatId tinyint,
    @fldIP varchar(15),
    @fldUserId int
AS 
	 
	
	BEGIN TRAN

	UPDATE [Pay].[tblMonasebatMablagh]
	SET    [fldHeaderId] = @fldHeaderId, [fldMonasebatId] = @fldMonasebatId, [fldMablagh] = @fldMablagh, [fldTypeNesbatId] = @fldTypeNesbatId, [fldIP] = @fldIP, [fldUserId] = @fldUserId, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
