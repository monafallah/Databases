SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblKalaGroupUpdate] 
    @fldId int,
    @fldName nvarchar(100),
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int,
	@fldOrganId int
AS 
	BEGIN TRAN
	UPDATE com.[tblKalaGroup]
	SET    [fldId] = @fldId, [fldName] = @fldName, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	,fldOrganId=@fldOrganId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
