SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblCaseBillsUpdate] 
    @fldId int,
    @fldBillsTypeId int,
    @fldFileNum int,
    @fldCentercoId int,
    @fldOrganId int,
    @fldOrganChartId int,
    @fldAshkhasId int,
    @fldDesc nvarchar(MAX),
   
    @fldIP varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Com].[tblCaseBills]
	SET    [fldId] = @fldId, [fldBillsTypeId] = @fldBillsTypeId, [fldFileNum] = @fldFileNum, [fldCentercoId] = @fldCentercoId, [fldOrganId] = @fldOrganId, [fldOrganChartId] = @fldOrganChartId, [fldAshkhasId] = @fldAshkhasId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
