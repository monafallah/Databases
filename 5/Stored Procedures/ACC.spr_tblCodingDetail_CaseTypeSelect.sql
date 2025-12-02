SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCodingDetail_CaseTypeSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldCodingDetailId], [fldCaseTypeId], [fldUserId], [fldIP], [fldDate] 
	FROM   [ACC].[tblCodingDetail_CaseType] 
	WHERE  fldId=@value
	

	if (@fieldname='fldCodingDetailId')
	SELECT top(@h)[fldId], [fldCodingDetailId], [fldCaseTypeId], [fldUserId], [fldIP], [fldDate] 
	FROM   [ACC].[tblCodingDetail_CaseType] 
	WHERE  fldCodingDetailId=@value


	if (@fieldname='fldCaseTypeId')
	SELECT top(@h)[fldId], [fldCodingDetailId], [fldCaseTypeId], [fldUserId], [fldIP], [fldDate] 
	FROM   [ACC].[tblCodingDetail_CaseType] 
	WHERE  fldCaseTypeId=@value

	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldCodingDetailId], [fldCaseTypeId], [fldUserId], [fldIP], [fldDate] 
	FROM   [ACC].[tblCodingDetail_CaseType] 
	


	COMMIT
GO
