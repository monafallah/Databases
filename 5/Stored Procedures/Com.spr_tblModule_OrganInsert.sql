SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblModule_OrganInsert] 

    @fldOrganId int,
    @fldModuleId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblModule_Organ] 
	INSERT INTO [Com].[tblModule_Organ] ([fldId], [fldOrganId], [fldModuleId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldOrganId, @fldModuleId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
