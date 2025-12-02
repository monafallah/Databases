SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_EydiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldDayCount], [fldMablagh], [fldMaliyat], [fldKosurat], [fldKhalesPardakhti], [fldNobatPardakht], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Eydi] 
	WHERE  fldId = @Value AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	
		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldDayCount], [fldMablagh], [fldMaliyat], [fldKosurat], [fldKhalesPardakhti], [fldNobatPardakht], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Eydi] 
	WHERE  fldDesc LIKE @Value

	if (@fieldname=N'fldPersonalId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldDayCount], [fldMablagh], [fldMaliyat], [fldKosurat], [fldKhalesPardakhti], [fldNobatPardakht], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Eydi] 
	WHERE  fldPersonalId = @Value AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	
	if (@fieldname=N'CheckPersonalId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldDayCount], [fldMablagh], [fldMaliyat], [fldKosurat], [fldKhalesPardakhti], [fldNobatPardakht], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Eydi] 
	WHERE  fldPersonalId = @Value

	IF (@fieldname=N'fldYear')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldDayCount], [fldMablagh], [fldMaliyat], [fldKosurat], [fldKhalesPardakhti], [fldNobatPardakht], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Eydi] 
	WHERE  fldYear = @Value AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	
	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldDayCount], [fldMablagh], [fldMaliyat], [fldKosurat], [fldKhalesPardakhti], [fldNobatPardakht], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Eydi] 
	where Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	
	if (@fieldname=N'ALL')
	SELECT top(@h) [fldId], [fldPersonalId], [fldYear], [fldMonth], [fldDayCount], [fldMablagh], [fldMaliyat], [fldKosurat], [fldKhalesPardakhti], [fldNobatPardakht], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMohasebat_Eydi] 

	COMMIT
GO
