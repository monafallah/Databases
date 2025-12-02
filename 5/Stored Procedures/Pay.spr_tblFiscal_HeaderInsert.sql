SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblFiscal_HeaderInsert] 
    @fldID INT OUT ,
    @fldEffectiveDate nvarchar(10),
    @fldDateOfIssue nvarchar(10),
    @fldUserId int,
     @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	--declare 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblFiscal_Header] 
	INSERT INTO [Pay].[tblFiscal_Header] ([fldId], [fldEffectiveDate], [fldDateOfIssue], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldEffectiveDate, @fldDateOfIssue, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
