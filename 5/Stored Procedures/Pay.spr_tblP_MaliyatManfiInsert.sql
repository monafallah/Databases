SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblP_MaliyatManfiInsert] 
   
    @fldMohasebeId int,
    @fldMablagh int,
    @fldSal smallint,
    @fldMah tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID INT
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblP_MaliyatManfi] 
	INSERT INTO [Pay].[tblP_MaliyatManfi] ([fldId], [fldMohasebeId], [fldMablagh], [fldSal], [fldMah], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldMohasebeId, @fldMablagh, @fldSal, @fldMah, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
