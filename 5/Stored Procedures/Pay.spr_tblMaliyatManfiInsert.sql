SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMaliyatManfiInsert] 

    @fldMablagh int,
    @fldMohasebeId int,
    @fldSal SMALLINT,
    @fldMah tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMaliyatManfi] 
	INSERT INTO [Pay].[tblMaliyatManfi] ([fldId], [fldMablagh], fldMohasebeId, [fldSal], [fldMah], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldMablagh, @fldMohasebeId, @fldSal, @fldMah, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
