SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMahdoodiyatMohasebat_AshkhasSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @value=com.fn_TextNormalize(@value) 
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(10) [fldId], [fldMahdoodiyatMohasebatId], [fldAshkhasId],com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshkhasId) as fldName, [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblMahdoodiyatMohasebat_Ashkhas] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldMahdoodiyatMohasebatId], [fldAshkhasId],com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshkhasId) as fldName, [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblMahdoodiyatMohasebat_Ashkhas] 
	WHERE fldDesc like  @Value
	
	if (@fieldname=N'fldMahdoodiyatMohasebatId')
	SELECT top(@h) [fldId], [fldMahdoodiyatMohasebatId], [fldAshkhasId],com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshkhasId) as fldName, [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblMahdoodiyatMohasebat_Ashkhas] 
	WHERE fldMahdoodiyatMohasebatId =  @Value
	
	if (@fieldname=N'fldAshkhasId')
	SELECT top(@h) [fldId], [fldMahdoodiyatMohasebatId], [fldAshkhasId],com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshkhasId) as fldName, [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblMahdoodiyatMohasebat_Ashkhas] 
	WHERE fldAshkhasId =  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldMahdoodiyatMohasebatId], [fldAshkhasId],com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshkhasId) as fldName, [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblMahdoodiyatMohasebat_Ashkhas] 

	COMMIT
GO
