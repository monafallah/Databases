SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblTransactionGroupInsert] 
   
    @fldName nvarchar(200)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldName=dbo.fn_TextNormalize(@fldName)
	select @fldID =ISNULL(max(fldId),0)+1 from [Trans].[tblTransactionGroup] 
	INSERT INTO [Trans].[tblTransactionGroup] ([fldId], [fldName])
	SELECT @fldId, @fldName
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
