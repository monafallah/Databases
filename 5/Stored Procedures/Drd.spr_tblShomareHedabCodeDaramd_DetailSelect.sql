SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblShomareHedabCodeDaramd_DetailSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldStartYear], [fldEndYear], [fldCodeDaramdId], [fldDate], [fldUserId] 
	FROM   [Drd].[tblShomareHedabCodeDaramd_Detail] 
	WHERE  fldId=@Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldStartYear], [fldEndYear], [fldCodeDaramdId], [fldDate], [fldUserId] 
	FROM   [Drd].[tblShomareHedabCodeDaramd_Detail] 

	
	COMMIT
GO
