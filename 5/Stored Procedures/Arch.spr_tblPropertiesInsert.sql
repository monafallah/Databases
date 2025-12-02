SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblPropertiesInsert] 

    @fldNameFn nvarchar(100),
	@fldNameEn nvarchar(100),
    @fldType int,
    @fldFormulId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	SET @fldNameFn=Com.fn_TextNormalize(@fldNameFn)
	SET @fldNameEn=Com.fn_TextNormalize(@fldNameEn)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Arch].[tblProperties] 
	INSERT INTO [Arch].[tblProperties] ([fldId], [fldNameFn],fldNameEn, [fldType], fldFormulId, [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldNameFn,@fldNameEn, @fldType, @fldFormulId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
