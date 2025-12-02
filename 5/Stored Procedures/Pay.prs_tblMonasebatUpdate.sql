SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[prs_tblMonasebatUpdate] 
    @fldId tinyint,
    @fldNameMonasebat nvarchar(300),
    @fldMonasebatTypeId tinyint,
    @fldMonth tinyint,
    @fldDay tinyint,
    @fldDateType bit,
    @fldHoliday bit,
    @fldMazaya bit,
    @fldIP varchar(15),
    @fldUserId int
AS 
	 
	
	BEGIN TRAN

	UPDATE [Pay].[tblMonasebat]
	SET    [fldNameMonasebat] = @fldNameMonasebat, [fldMonasebatTypeId] = @fldMonasebatTypeId, [fldMonth] = @fldMonth, [fldDay] = @fldDay, [fldDateType] = @fldDateType, [fldHoliday] = @fldHoliday, [fldMazaya] = @fldMazaya, [fldIP] = @fldIP, [fldUserId] = @fldUserId, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
