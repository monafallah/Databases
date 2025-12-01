SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblEventTablesInsert] 
    @fldNameTablesId int,
    @fldEventTypeId int,
   
    @fldFlag bit
AS 
	
	BEGIN TRAN
	declare @fldID int 
	
	select @fldID =ISNULL(max(fldId),0)+1 from [Trans].[tblEventTables] 
	INSERT INTO [Trans].[tblEventTables] ([fldNameTablesId], [fldEventTypeId], [fldFormulId], [fldFlag])
	SELECT @fldNameTablesId, @fldEventTypeId, null, @fldFlag
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
