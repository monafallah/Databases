SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblItems_EstekhdamUpdate] 
    @fldId int,
    @fldTitle nvarchar(400),
    @fldUserId int

AS 
	BEGIN TRAN
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	UPDATE  [Com].[tblItems_Estekhdam]
	SET    [fldId] = @fldId,  [fldTitle] = @fldTitle
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
