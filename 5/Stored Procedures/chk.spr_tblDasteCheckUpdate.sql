SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [chk].[spr_tblDasteCheckUpdate] 
    @fldId int,
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
	UPDATE [chk].[tblDasteCheck]
	SET    [fldIdOlgoCheck] = @fldIdOlgoCheck, [fldIdShomareHesab] = @fldShomareHesab, [fldMoshakhaseDasteCheck] = @fldMoshakhaseDasteCheck, [fldTedadBarg] = @fldTedadBarg, [fldShoroeSeriyal] = @fldShoroeSeriyal, [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldDate] =getdate()	,fldOrganId =	@fldOrganId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
