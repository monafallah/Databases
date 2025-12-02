SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblPayeSanavatiInsert] 
  @fldId int OUT,
    @fldYear int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	--declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldId =ISNULL(max(fldId),0)+1 from [Prs].[tblPayeSanavati] 
	INSERT INTO [Prs].[tblPayeSanavati] ([fldId], [fldYear], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldYear, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

COMMIT
GO
