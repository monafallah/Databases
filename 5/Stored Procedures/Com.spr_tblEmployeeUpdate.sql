SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblEmployeeUpdate] 
    @fldId int,
    @fldName nvarchar(100),
    @fldFamily nvarchar(100),
    @fldCodemeli NVARCHAR(50),
    @fldStatus bit, 
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldTypeShakhs tinyint
AS 
	BEGIN TRAN
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldFamily=Com.fn_TextNormalize(@fldFamily)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Com].[tblEmployee]
	SET    [fldId] = @fldId, [fldName] = @fldName, [fldFamily] = @fldFamily,  [fldCodemeli] = @fldCodemeli,  [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldStatus=@fldStatus,fldTypeShakhs=@fldTypeShakhs 
	WHERE  [fldId] = @fldId
	
	COMMIT 
	
GO
