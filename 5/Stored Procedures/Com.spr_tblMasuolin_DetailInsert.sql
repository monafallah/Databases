SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMasuolin_DetailInsert] 
   
    @fldEmployId int,
    @fldOrganPostId int,
    @fldMasuolinId int,
   
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int ,@fldOrderId tinyint
	SET @fldDesc =Com.fn_TextNormalize(@fldDesc)
	SELECT @fldOrderId=ISNULL(MAX(fldorderId),0)+1 FROM Com.tblMasuolin_Detail WHERE fldMasuolinId=@fldMasuolinId
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblMasuolin_Detail] 
	INSERT INTO [Com].[tblMasuolin_Detail] ([fldId], [fldEmployId], [fldOrganPostId], [fldMasuolinId], [fldOrderId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldEmployId, @fldOrganPostId, @fldMasuolinId, @fldOrderId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
