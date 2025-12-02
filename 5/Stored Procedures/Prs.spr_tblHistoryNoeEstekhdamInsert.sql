SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHistoryNoeEstekhdamInsert] 

    @fldNoeEstekhdamId int,
    @fldPrsPersonalInfoId int,
    @fldTarikh char(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc =Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblHistoryNoeEstekhdam] 
	INSERT INTO [Prs].[tblHistoryNoeEstekhdam] ([fldId], [fldNoeEstekhdamId], [fldPrsPersonalInfoId], [fldTarikh], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldNoeEstekhdamId, @fldPrsPersonalInfoId, @fldTarikh, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
