SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblDetailHoghoghMabnaInsert] 
  
    @fldHoghoghMabnaId int,
    @fldGroh tinyint,
    @fldMablagh int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblDetailHoghoghMabna] 
	INSERT INTO [Prs].[tblDetailHoghoghMabna] ([fldId], [fldHoghoghMabnaId], [fldGroh], [fldMablagh], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldHoghoghMabnaId, @fldGroh, @fldMablagh, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
