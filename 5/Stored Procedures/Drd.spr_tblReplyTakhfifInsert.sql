SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblReplyTakhfifInsert] 

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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblReplyTakhfif] 
	INSERT INTO [Drd].[tblReplyTakhfif] ([fldId], [fldDarsad], [fldMablagh], [fldShomareMajavez], [fldTarikh], [fldUserId], [fldDesc], [fldDate],fldStatusId)
	SELECT @fldId, @fldDarsad, @fldMablagh, @fldShomareMajavez, @fldTarikh, @fldUserId, @fldDesc, GETDATE(),@fldStatusId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
