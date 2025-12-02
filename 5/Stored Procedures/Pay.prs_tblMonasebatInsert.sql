SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[prs_tblMonasebatInsert] 
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
declare @fldid int
	select @fldid=isnull(max(fldId),0)+1  FROM   [Pay].[tblMonasebat] 
	INSERT INTO [Pay].[tblMonasebat] ([fldId], [fldNameMonasebat], [fldMonasebatTypeId], [fldMonth], [fldDay], [fldDateType], [fldHoliday], [fldMazaya], [fldIP], [fldUserId], [fldDate])
	SELECT @fldId, @fldNameMonasebat, @fldMonasebatTypeId, @fldMonth, @fldDay, @fldDateType, @fldHoliday, @fldMazaya, @fldIP, @fldUserId, getdate()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
