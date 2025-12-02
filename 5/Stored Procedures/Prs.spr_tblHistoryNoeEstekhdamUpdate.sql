SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHistoryNoeEstekhdamUpdate] 
    @fldId int,
    @fldNoeEstekhdamId int,
    @fldPrsPersonalInfoId int,
    @fldTarikh char(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Prs].[tblHistoryNoeEstekhdam]
	SET    [fldId] = @fldId, [fldNoeEstekhdamId] = @fldNoeEstekhdamId, [fldPrsPersonalInfoId] = @fldPrsPersonalInfoId, [fldTarikh] = @fldTarikh, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
