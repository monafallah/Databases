SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblMasrafTypeDelete] 
    @fldId INT,
    @fldUserid int
AS 
	 
	
	BEGIN TRAN
 UPDATE BUD.tblMasrafType
 SET fldUserId=@fldUserid,fldDate=GETDATE()
 WHERE fldId=@fldId
	DELETE
	FROM   [BUD].[tblMasrafType]
	WHERE  [fldId] = @fldId

	COMMIT
GO
