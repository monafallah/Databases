SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKarkardMahane_DetailInsert] 

    @fldKarkardMahaneId int,
    @fldKarkard int,
    @fldKargahBimeId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblKarkardMahane_Detail] 
	INSERT INTO [Pay].[tblKarkardMahane_Detail] ([fldId], [fldKarkardMahaneId], [fldKarkard], [fldKargahBimeId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldKarkardMahaneId, @fldKarkard, @fldKargahBimeId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
