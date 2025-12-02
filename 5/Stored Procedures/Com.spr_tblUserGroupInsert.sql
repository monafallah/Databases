SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblUserGroupInsert] 
	@fldId INT OUT,
    @fldTitle nvarchar(100),
    @fldUserID int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
 
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblUserGroup] 
	INSERT INTO [Com].[tblUserGroup] ([fldId], [fldTitle], [fldUserID], [fldDesc], [fldDate])
	SELECT @fldId, @fldTitle, @fldUserID, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
