SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblChartOrganEjraeeUpdate] 
    @fldId int,
    @fldTitle nvarchar(200),
    @fldPId int,
    @fldOrganId int,
    @fldNoeVahed tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	UPDATE [Com].[tblChartOrganEjraee]
	SET    [fldId] = @fldId, [fldTitle] = @fldTitle, [fldPId] = @fldPId, [fldOrganId] = @fldOrganId, [fldNoeVahed] = @fldNoeVahed, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
