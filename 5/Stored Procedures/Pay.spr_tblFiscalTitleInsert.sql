SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblFiscalTitleInsert] 

    @fldFiscalHeaderId int,
    @fldItemEstekhdamId int,

    @fldAnvaEstekhdamId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID INT
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblFiscalTitle] 
	if not exists (select * from pay.tblFiscalTitle where fldFiscalHeaderId=@fldFiscalHeaderId and fldAnvaEstekhdamId= @fldAnvaEstekhdamId and fldItemEstekhdamId= @fldItemEstekhdamId)
	INSERT INTO [Pay].[tblFiscalTitle] ([fldId], [fldFiscalHeaderId], [fldItemEstekhdamId],  [fldAnvaEstekhdamId], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldFiscalHeaderId, @fldItemEstekhdamId,  @fldAnvaEstekhdamId, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
