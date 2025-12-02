SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblModule_OrganUpdate] 
    @fldId int,
    @fldOrganId int,
    @fldModuleId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	UPDATE [Com].[tblModule_Organ]
	SET    [fldId] = @fldId, [fldOrganId] = @fldOrganId, [fldModuleId] = @fldModuleId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
