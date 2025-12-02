SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblVamUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldTarikhDaryaft nvarchar(10),
    @fldTypeVam tinyint,
    @fldMablaghVam int,
    @fldStartDate nvarchar(10),
    @fldCount smallint,
    @fldMablagh int,
    @fldMandeVam int,
    @fldStatus bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblVam]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldTarikhDaryaft] = @fldTarikhDaryaft, [fldTypeVam] = @fldTypeVam, [fldMablaghVam] = @fldMablaghVam, [fldStartDate] = @fldStartDate, [fldCount] = @fldCount, [fldMablagh] = @fldMablagh, [fldMandeVam] = @fldMandeVam, [fldStatus] = @fldStatus, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
