SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblCostCenterUpdate] 
    @fldId int,
    @fldTitle nvarchar(200),
    @fldReportTypeId int,
    @fldTypeOfCostCenterId int,
    @fldEmploymentCenterId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldOrganId int
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	UPDATE [Pay].[tblCostCenter]
	SET    [fldId] = @fldId, [fldTitle] = @fldTitle, [fldReportTypeId] = @fldReportTypeId, [fldTypeOfCostCenterId] = @fldTypeOfCostCenterId, [fldEmploymentCenterId] = @fldEmploymentCenterId, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	,fldOrganId=@fldOrganId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
