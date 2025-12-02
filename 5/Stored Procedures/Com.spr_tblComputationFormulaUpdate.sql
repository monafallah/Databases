SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblComputationFormulaUpdate] 
    @fldId int,
    @fldType bit,
    @fldFormule ntext,
    @fldOrganId int,
    @fldLibrary nvarchar(MAX),
    @fldAzTarikh NVARCHAR(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE  [Com].[tblComputationFormula]
	SET    [fldId] = @fldId, [fldType] = @fldType, [fldFormule] = @fldFormule, [fldOrganId] = @fldOrganId, [fldLibrary] = @fldLibrary,fldAzTarikh =@fldAzTarikh , [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
