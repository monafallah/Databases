SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblReplyTakhfifUpdate] 
    @fldId int,
    @fldDarsad decimal(5, 2),
    @fldMablagh bigint,
    @fldShomareMajavez nvarchar(50),
    @fldTarikh nvarchar(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldStatusId int
AS 
	BEGIN TRAN
	set @fldShomareMajavez=com.fn_TextNormalize(@fldShomareMajavez)
	set @fldTarikh=com.fn_TextNormalize(@fldTarikh)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblReplyTakhfif]
	SET    [fldId] = @fldId, [fldDarsad] = @fldDarsad, [fldMablagh] = @fldMablagh, [fldShomareMajavez] = @fldShomareMajavez, [fldTarikh] = @fldTarikh, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldStatusId=@fldStatusId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
