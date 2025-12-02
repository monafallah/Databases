SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblAnvaGroupTashvighiInsert] 

    @fldTitle nvarchar(50),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID TINYINT
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblAnvaGroupTashvighi] 
	INSERT INTO [Prs].[tblAnvaGroupTashvighi] ([fldId], [fldTitle], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldTitle, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
