SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMadrakTahsiliInsert] 

    @fldTitle nvarchar(100),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from com.[tblMadrakTahsili] 
	INSERT INTO [com].[tblMadrakTahsili] ([fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldTitle, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
