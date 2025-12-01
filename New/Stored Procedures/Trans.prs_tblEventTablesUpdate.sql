SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblEventTablesUpdate] 
    @fldId int,
    @fldNameTablesId int,
    @fldEventTypeId int,
  
    @fldFlag bit
AS 
	BEGIN TRAN
	
	UPDATE [Trans].[tblEventTables]
	SET    [fldNameTablesId] = @fldNameTablesId, [fldEventTypeId] = @fldEventTypeId,  [fldFlag] = @fldFlag
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
