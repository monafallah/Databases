SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblKala_TreeUpdate] 
    @fldId int,
    @fldKalaId int,
    @fldKalaTreeId int,
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int,
	@fldOrganId int
AS 
	BEGIN TRAN
	UPDATE com.[tblKala_Tree]
	SET    [fldId] = @fldId, [fldKalaId] = @fldKalaId, [fldKalaTreeId] = @fldKalaTreeId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	,fldOrganId=@fldOrganId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
