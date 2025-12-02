SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblCostCenterInsert] 
  
    @fldTitle nvarchar(200),
    @fldReportTypeId int,
    @fldTypeOfCostCenterId int,
    @fldEmploymentCenterId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldOrganId int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblCostCenter] 
	INSERT INTO [Pay].[tblCostCenter] ([fldId], [fldTitle], [fldReportTypeId], [fldTypeOfCostCenterId], [fldEmploymentCenterId], [fldUserId], [fldDate], [fldDesc],fldOrganId)
	SELECT @fldId, @fldTitle, @fldReportTypeId, @fldTypeOfCostCenterId, @fldEmploymentCenterId, @fldUserId, GETDATE(), @fldDesc,@fldOrganId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
