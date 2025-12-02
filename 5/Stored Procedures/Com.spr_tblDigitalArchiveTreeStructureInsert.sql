SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblDigitalArchiveTreeStructureInsert] 

    @fldTitle nvarchar(400),
    @fldPID int,
    @fldModuleId int,
    @fldAttachFile bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblDigitalArchiveTreeStructure] 
	INSERT INTO [Com].[tblDigitalArchiveTreeStructure] ([fldId], [fldTitle], [fldPID], [fldModuleId], [fldAttachFile], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldTitle, @fldPID, @fldModuleId, @fldAttachFile, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
