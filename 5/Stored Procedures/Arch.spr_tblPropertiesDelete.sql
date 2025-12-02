SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblPropertiesDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN

	DELETE
	FROM   [Arch].[tblProperties]
	WHERE  fldId = @fldId

	delete tblComputationFormula from Com.tblComputationFormula as tblComputationFormula inner join  [Arch].[tblProperties] as tblProperties
	on fldFormulId=tblComputationFormula.fldId
	 where tblProperties.fldId=@fldId

	COMMIT
GO
