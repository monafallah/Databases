SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMonasebatMablaghInsert] 
    @fldHeaderId int,
    @fldMonasebatId tinyint,
    @fldMablagh int,
    @fldTypeNesbatId tinyint,
    @fldIP varchar(15),
    @fldUserId int
AS 
	 
	
	BEGIN TRAN
declare @fldid int
	select @fldid=isnull(max(fldId),0)+1  FROM   [Pay].[tblMonasebatMablagh] 
	INSERT INTO [Pay].[tblMonasebatMablagh] ([fldId], [fldHeaderId], [fldMonasebatId], [fldMablagh], [fldTypeNesbatId], [fldIP], [fldUserId], [fldDate])
	SELECT @fldId, @fldHeaderId, @fldMonasebatId, @fldMablagh, @fldTypeNesbatId, @fldIP, @fldUserId, getdate()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
