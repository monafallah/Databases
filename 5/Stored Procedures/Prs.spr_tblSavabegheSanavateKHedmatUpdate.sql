SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblSavabegheSanavateKHedmatUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldNoeSabeghe bit,
    @fldAzTarikh NVARCHAR(10),
    @fldTaTarikh NVARCHAR(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	UPDATE [Prs].[tblSavabegheSanavateKHedmat]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldNoeSabeghe] = @fldNoeSabeghe, [fldAzTarikh] = @fldAzTarikh, [fldTaTarikh] = @fldTaTarikh, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
