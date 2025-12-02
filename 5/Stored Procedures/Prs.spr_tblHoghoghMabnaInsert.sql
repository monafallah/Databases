SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHoghoghMabnaInsert] 
	@fldId INT out ,
    @fldYear int,
    @fldType bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	--declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldId =ISNULL(max(fldId),0)+1 from [Prs].[tblHoghoghMabna] 
	INSERT INTO [Prs].[tblHoghoghMabna] ([fldId], [fldYear], [fldType], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldYear, @fldType, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
