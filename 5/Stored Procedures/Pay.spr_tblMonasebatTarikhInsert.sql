SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMonasebatTarikhInsert] 
    @fldYear smallint,
    @fldMonth tinyint,
    @fldDay tinyint,
    @fldMonasebatId tinyint,
    @fldIP varchar(15),
    @fldUserId int
AS 
	 
	
	BEGIN TRAN
declare @fldid int
	select @fldid=isnull(max(fldId),0)+1  FROM   [Pay].[tblMonasebatTarikh] 
	INSERT INTO [Pay].[tblMonasebatTarikh] ([fldId], [fldYear], [fldMonth], [fldDay], [fldMonasebatId], [fldIP], [fldUserId], [fldDate])
	SELECT @fldId, @fldYear, @fldMonth, @fldDay, @fldMonasebatId, @fldIP, @fldUserId, getdate()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
