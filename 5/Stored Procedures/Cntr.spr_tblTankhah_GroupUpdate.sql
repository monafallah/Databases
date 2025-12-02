SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblTankhah_GroupUpdate] 
    @fldId int,
    @fldTankhahId int,
    @fldTitle nvarchar(300),
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
    @fldIP varchar(15)
AS 
	 
	
	BEGIN TRAN
	set @fldTitle= com.fn_TextNormalize(@fldTitle)
	UPDATE [Cntr].[tblTankhah_Group]
	SET    [fldTankhahId] = @fldTankhahId, [fldTitle] = @fldTitle, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldIP] = @fldIP, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
