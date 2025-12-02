SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKarkardMahane_DetailUpdate] 
    @fldId int,
    @fldKarkardMahaneId int,
    @fldKarkard int,
    @fldKargahBimeId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblKarkardMahane_Detail]
	SET    [fldId] = @fldId, [fldKarkardMahaneId] = @fldKarkardMahaneId, [fldKarkard] = @fldKarkard, [fldKargahBimeId] = @fldKargahBimeId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
