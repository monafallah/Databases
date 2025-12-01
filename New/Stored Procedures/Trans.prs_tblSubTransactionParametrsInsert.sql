SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblSubTransactionParametrsInsert] 
    @fldSubTransactionId int,
    @fldJsonParametr nvarchar(2000)
AS 
	
	BEGIN TRAN

	INSERT INTO [Trans].[tblSubTransactionParametrs] ([fldSubTransactionId], [fldJsonParametr])
	SELECT @fldSubTransactionId, @fldJsonParametr
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
