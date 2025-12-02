SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosParam_DetailSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldPcPosParamId], [fldPcPosInfoId], [fldValue], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPcPosParam_Detail] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldPcPosParamId], [fldPcPosInfoId], [fldValue], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPcPosParam_Detail] 
	WHERE  fldDesc like @Value 

	if (@fieldname=N'fldPcPosInfoId')
	SELECT top(@h) [fldId], [fldPcPosParamId], [fldPcPosInfoId], [fldValue], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPcPosParam_Detail] 
	WHERE  fldPcPosInfoId = @Value 


	if (@fieldname=N'fldPcPosParamId')
	SELECT top(@h) [fldId], [fldPcPosParamId], [fldPcPosInfoId], [fldValue], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPcPosParam_Detail] 
	WHERE  fldPcPosParamId = @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldPcPosParamId], [fldPcPosInfoId], [fldValue], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPcPosParam_Detail] 

	COMMIT
GO
