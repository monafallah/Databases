SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblParameteriItemsFormulInsert] 
   
    @fldParametrId int,
    @fldFormul nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldFormul=Com.fn_TextNormalize(@fldFormul)
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblParameteriItemsFormul] 
	INSERT INTO [Pay].[tblParameteriItemsFormul] ([fldId], [fldParametrId], [fldFormul], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldParametrId, @fldFormul, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
