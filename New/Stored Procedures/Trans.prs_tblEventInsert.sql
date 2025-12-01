SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblEventInsert] 
    @fldTransactionTypeId int,
   
    @fldFlag bit,
	@fldDesc nvarchar(100)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	set @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Trans].[tblEvent] 
	INSERT INTO [Trans].[tblEvent] ([fldTransactionTypeId], [fldFormulId], [fldFlag])
	SELECT @fldTransactionTypeId,NULL, @fldFlag
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
