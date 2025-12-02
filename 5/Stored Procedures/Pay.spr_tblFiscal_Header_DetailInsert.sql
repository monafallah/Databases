SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblFiscal_Header_DetailInsert] 
    
    @fldEffectiveDate nvarchar(10),
    @fldDateOfIssue nvarchar(10),
    @fldAmountFrom int,
    @fldAmountTo int,
    @fldPercentTaxOnWorkers decimal(8, 4),
    @fldTaxationOfEmployees decimal(8, 4),
    @fldTax int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID INT,@DetailId INT,@flag BIT=0
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblFiscal_Header] 
	INSERT INTO [Pay].[tblFiscal_Header] ([fldId], [fldEffectiveDate], [fldDateOfIssue], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldEffectiveDate, @fldDateOfIssue, @fldUserId, GETDATE(), @fldDesc
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END 
	IF(@flag=0)
	begin
	select @DetailId =ISNULL(max(fldId),0)+1 from [Pay].[tblFiscal_Detail] 
	INSERT INTO [Pay].[tblFiscal_Detail] ([fldId], [fldFiscalHeaderId], [fldAmountFrom], [fldAmountTo], [fldPercentTaxOnWorkers], [fldTaxationOfEmployees], [fldTax], [fldUserId], [fldDate], [fldDesc])
	SELECT @DetailId, @fldID, @fldAmountFrom, @fldAmountTo, @fldPercentTaxOnWorkers, @fldTaxationOfEmployees, @fldTax, @fldUserId, GETDATE(), @fldDesc
	IF (@@ERROR<>0)
		ROLLBACK

	END
	
	COMMIT
GO
