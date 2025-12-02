SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblZirListHaUpdate] 
    @fldId int,
    @fldReportId int,
    @fldMasuolin_DetailId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	UPDATE [Com].[tblZirListHa]
	SET    [fldId] = @fldId, [fldReportId] = @fldReportId, [fldMasuolin_DetailId] = @fldMasuolin_DetailId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
