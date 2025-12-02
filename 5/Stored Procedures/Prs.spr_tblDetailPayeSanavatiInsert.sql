SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblDetailPayeSanavatiInsert] 

    @fldPayeSanavatiId int,
    @fldGroh tinyint,
    @fldMablagh int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblDetailPayeSanavati] 
	INSERT INTO [Prs].[tblDetailPayeSanavati] ([fldId], [fldPayeSanavatiId], [fldGroh], [fldMablagh], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldPayeSanavatiId, @fldGroh, @fldMablagh, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
