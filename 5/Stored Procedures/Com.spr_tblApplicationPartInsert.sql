SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblApplicationPartInsert] 

    @fldTitle nvarchar(50),
    @fldPID int,
    @fldModuleId INT,
    @fldUserID int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblApplicationPart] 
	INSERT INTO [Com].[tblApplicationPart] ([fldId], [fldTitle], [fldPID], [fldUserID], [fldDesc], [fldDate],fldModuleId)
	SELECT @fldId, @fldTitle, @fldPID, @fldUserID, @fldDesc, GETDATE(),@fldModuleId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
