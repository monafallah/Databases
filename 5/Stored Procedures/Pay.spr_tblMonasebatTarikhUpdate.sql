SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMonasebatTarikhUpdate] 
    @fldId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldDay tinyint,
    @fldMonasebatId tinyint,
    @fldIP varchar(15),
    @fldUserId int
AS 
	 
	
	BEGIN TRAN

	UPDATE [Pay].[tblMonasebatTarikh]
	SET    [fldYear] = @fldYear, [fldMonth] = @fldMonth, [fldDay] = @fldDay, [fldMonasebatId] = @fldMonasebatId, [fldIP] = @fldIP, [fldUserId] = @fldUserId, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
