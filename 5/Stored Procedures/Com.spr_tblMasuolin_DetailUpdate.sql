SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMasuolin_DetailUpdate] 
    @fldId int,
    @fldEmployId int,
    @fldOrganPostId int,
    @fldMasuolinId int,
    @fldOrderId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	UPDATE [Com].[tblMasuolin_Detail]
	SET    [fldId] = @fldId, [fldEmployId] = @fldEmployId, [fldOrganPostId] = @fldOrganPostId, [fldMasuolinId] = @fldMasuolinId, [fldOrderId] = @fldOrderId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
