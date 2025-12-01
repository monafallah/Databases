SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblSubTransactionTablesInsert] 
    @fldSubTransactionId int,
    @fldNameTablesId int,
    @fldRowId varbinary(8),
    @fldFlag bit
AS 
	
	BEGIN TRAN
	
	INSERT INTO [Trans].[tblSubTransactionTables] ([fldSubTransactionId], [fldNameTablesId], [fldRowId], [fldFlag])
	SELECT @fldSubTransactionId, @fldNameTablesId, @fldRowId, @fldFlag
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
