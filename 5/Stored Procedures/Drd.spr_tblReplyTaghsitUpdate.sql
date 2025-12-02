SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblReplyTaghsitUpdate] 
    @fldId int,
    @fldMablaghNaghdi bigint,
    @fldTedadAghsat tinyint,
    @fldShomareMojavez nvarchar(50),
    @fldTarikh nvarchar(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldStatusId int,
	@fldTedadMahAghsat tinyint,
	@fldJarimeTakhir bigint
AS 
	BEGIN TRAN
	set @fldShomareMojavez=com.fn_TextNormalize(@fldShomareMojavez)
	set @fldTarikh=com.fn_TextNormalize(@fldTarikh)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblReplyTaghsit]
	SET    [fldId] = @fldId, [fldMablaghNaghdi] = @fldMablaghNaghdi, [fldTedadAghsat] = @fldTedadAghsat, [fldShomareMojavez] = @fldShomareMojavez, [fldTarikh] = @fldTarikh, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldStatusId=@fldStatusId ,fldTedadMahAghsat=@fldTedadMahAghsat,fldJarimeTakhir=@fldJarimeTakhir
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
