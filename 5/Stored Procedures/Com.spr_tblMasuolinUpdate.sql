SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMasuolinUpdate] 
    @fldId int,
    @fldTarikhEjra CHAR(10),
    @fldModule_OrganId INT,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 

	
	BEGIN TRANSACTION
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	UPDATE [Com].[tblMasuolin]
	SET    [fldId] = @fldId, [fldTarikhEjra] = @fldTarikhEjra, [fldModule_OrganId] = @fldModule_OrganId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	
	COMMIT TRAN
GO
