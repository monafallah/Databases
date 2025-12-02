SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [ACC].[spr_tblFiscalYearInsert] 
    
    @fldOrganId int,
    @fldYear smallint,
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int
AS 
	
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].tblfiscalYear 
	INSERT INTO [ACC].[tblfiscalYear] ([fldId],[fldYear], [fldOrganId], [fldDesc], [fldDate], [fldIP], [fldUserId])
	SELECT @fldId,@fldYear, @fldOrganId, @fldDesc,GETDATE(), @fldIP, @fldUserId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
