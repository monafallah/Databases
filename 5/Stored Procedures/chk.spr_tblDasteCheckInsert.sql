SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [chk].[spr_tblDasteCheckInsert] 
   
    @fldIdOlgoCheck int,
    @fldShomareHesab int,
    @fldMoshakhaseDasteCheck nvarchar(50),
    @fldTedadBarg tinyint,
    @fldShoroeSeriyal nvarchar(50),
    @fldUserID int,
    @fldDesc nvarchar(MAX),
	@fldOrganId int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [chk].[tblDasteCheck] 
	INSERT INTO [chk].[tblDasteCheck] ([fldId], [fldIdOlgoCheck], [fldIdShomareHesab], [fldMoshakhaseDasteCheck], [fldTedadBarg], [fldShoroeSeriyal], [fldUserID], [fldDesc], [fldDate],fldOrganId)
	SELECT @fldId, @fldIdOlgoCheck, @fldShomareHesab, @fldMoshakhaseDasteCheck, @fldTedadBarg, @fldShoroeSeriyal, @fldUserID, @fldDesc,getdate(),@fldOrganId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
