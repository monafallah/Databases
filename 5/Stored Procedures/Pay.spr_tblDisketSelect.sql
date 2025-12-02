SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblDisketSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldMarhale], [fldTarikh], [fldTedad], [fldType], [fldJam], [fldTypePardakht], [fldUserId], [fldDesc], [fldDate], [fldTimeEdit], [fldEdit] 
	,fldShobeCode,fldOrganCode,fldFileId,fldNameFile,fldBankFixId,fldNameShobe,
	CASE WHEN fldTypePardakht=1 THEN N'حقوق' WHEN fldTypePardakht=2 THEN N'عیدی' WHEN fldTypePardakht=3 THEN N'سایر مزایا' WHEN fldTypePardakht=4 THEN N'اضافه کار' WHEN fldTypePardakht=5 THEN N'تعطیل کار' WHEN fldTypePardakht=6 THEN N'مرخصی' WHEN fldTypePardakht=7 THEN N'ماموریت' WHEN fldTypePardakht=8 THEN N'کمک نقدی مستمر' WHEN fldTypePardakht=9 THEN N'کمک نقدی غیر مستمر' WHEN fldTypePardakht=10 THEN N'پس انداز'  
	 WHEN fldTypePardakht=11 THEN N'بن مزایای جانبی رفاهی' 
	END fldNameTypePardakht,fldOrganId
	FROM   [Pay].[tblDisket] 
	WHERE  fldId = @Value
	
		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldMarhale], [fldTarikh], [fldTedad], [fldType], [fldJam], [fldTypePardakht], [fldUserId], [fldDesc], [fldDate], [fldTimeEdit], [fldEdit] 
	,fldShobeCode,fldOrganCode,fldFileId,fldNameFile,fldBankFixId,fldNameShobe,
	CASE WHEN fldTypePardakht=1 THEN N'حقوق' WHEN fldTypePardakht=2 THEN N'عیدی' WHEN fldTypePardakht=3 THEN N'سایر مزایا' WHEN fldTypePardakht=4 THEN N'اضافه کار' WHEN fldTypePardakht=5 THEN N'تعطیل کار' WHEN fldTypePardakht=6 THEN N'مرخصی' WHEN fldTypePardakht=7 THEN N'ماموریت' WHEN fldTypePardakht=8 THEN N'کمک نقدی مستمر' WHEN fldTypePardakht=9 THEN N'کمک نقدی غیر مستمر' WHEN fldTypePardakht=10 THEN N'پس انداز'  
	WHEN fldTypePardakht=11 THEN N'بن مزایای جانبی رفاهی' END fldNameTypePardakht,fldOrganId
	FROM   [Pay].[tblDisket] 
	WHERE  fldDesc LIKE  @Value
	

		if (@fieldname=N'fldBankFixId')
	SELECT top(@h) [fldId], [fldMarhale], [fldTarikh], [fldTedad], [fldType], [fldJam], [fldTypePardakht], [fldUserId], [fldDesc], [fldDate], [fldTimeEdit], [fldEdit] 
	,fldShobeCode,fldOrganCode,fldFileId,fldNameFile,fldBankFixId,fldNameShobe,
	CASE WHEN fldTypePardakht=1 THEN N'حقوق' WHEN fldTypePardakht=2 THEN N'عیدی' WHEN fldTypePardakht=3 THEN N'سایر مزایا' WHEN fldTypePardakht=4 THEN N'اضافه کار' WHEN fldTypePardakht=5 THEN N'تعطیل کار' WHEN fldTypePardakht=6 THEN N'مرخصی' WHEN fldTypePardakht=7 THEN N'ماموریت' WHEN fldTypePardakht=8 THEN N'کمک نقدی مستمر' WHEN fldTypePardakht=9 THEN N'کمک نقدی غیر مستمر' WHEN fldTypePardakht=10 THEN N'پس انداز'  
	WHEN fldTypePardakht=11 THEN N'بن مزایای جانبی رفاهی' END fldNameTypePardakht,fldOrganId
	FROM   [Pay].[tblDisket] 
	WHERE  fldBankFixId = @Value
	
	
	if (@fieldname=N'CheckShobeId')
	SELECT top(@h) [fldId], [fldMarhale], [fldTarikh], [fldTedad], [fldType], [fldJam], [fldTypePardakht], [fldUserId], [fldDesc], [fldDate], [fldTimeEdit], [fldEdit] 
	,fldShobeCode,fldOrganCode,fldFileId,fldNameFile	,fldBankFixId,fldNameShobe
	,CASE WHEN fldTypePardakht=1 THEN N'حقوق' WHEN fldTypePardakht=2 THEN N'عیدی' WHEN fldTypePardakht=3 THEN N'سایر مزایا' WHEN fldTypePardakht=4 THEN N'اضافه کار' WHEN fldTypePardakht=5 THEN N'تعطیل کار' WHEN fldTypePardakht=6 THEN N'مرخصی' WHEN fldTypePardakht=7 THEN N'ماموریت' WHEN fldTypePardakht=8 THEN N'کمک نقدی مستمر' WHEN fldTypePardakht=9 THEN N'کمک نقدی غیر مستمر' WHEN fldTypePardakht=10 THEN N'پس انداز'  
	WHEN fldTypePardakht=11 THEN N'بن مزایای جانبی رفاهی' END fldNameTypePardakht,fldOrganId
	FROM   [Pay].[tblDisket] 
	WHERE  fldShobeCode = @Value
	
	
		if (@fieldname=N'CheckOrganId')
	SELECT top(@h) [fldId], [fldMarhale], [fldTarikh], [fldTedad], [fldType], [fldJam], [fldTypePardakht], [fldUserId], [fldDesc], [fldDate], [fldTimeEdit], [fldEdit] 
	,fldShobeCode,fldOrganCode,fldFileId,fldNameFile	,fldBankFixId,fldNameShobe
	,CASE WHEN fldTypePardakht=1 THEN N'حقوق' WHEN fldTypePardakht=2 THEN N'عیدی' WHEN fldTypePardakht=3 THEN N'سایر مزایا' WHEN fldTypePardakht=4 THEN N'اضافه کار' WHEN fldTypePardakht=5 THEN N'تعطیل کار' WHEN fldTypePardakht=6 THEN N'مرخصی' WHEN fldTypePardakht=7 THEN N'ماموریت' WHEN fldTypePardakht=8 THEN N'کمک نقدی مستمر' WHEN fldTypePardakht=9 THEN N'کمک نقدی غیر مستمر' WHEN fldTypePardakht=10 THEN N'پس انداز'  
	WHEN fldTypePardakht=11 THEN N'بن مزایای جانبی رفاهی' END fldNameTypePardakht,fldOrganId
	FROM   [Pay].[tblDisket] 
	WHERE  fldOrganCode = @Value
	
		if (@fieldname=N'CheckFileId')
	SELECT top(@h) [fldId], [fldMarhale], [fldTarikh], [fldTedad], [fldType], [fldJam], [fldTypePardakht], [fldUserId], [fldDesc], [fldDate], [fldTimeEdit], [fldEdit] 
	,fldShobeCode,fldOrganCode,fldFileId,fldNameFile	,fldBankFixId,fldNameShobe 
	,CASE WHEN fldTypePardakht=1 THEN N'حقوق' WHEN fldTypePardakht=2 THEN N'عیدی' WHEN fldTypePardakht=3 THEN N'سایر مزایا' WHEN fldTypePardakht=4 THEN N'اضافه کار' WHEN fldTypePardakht=5 THEN N'تعطیل کار' WHEN fldTypePardakht=6 THEN N'مرخصی' WHEN fldTypePardakht=7 THEN N'ماموریت' WHEN fldTypePardakht=8 THEN N'کمک نقدی مستمر' WHEN fldTypePardakht=9 THEN N'کمک نقدی غیر مستمر' WHEN fldTypePardakht=10 THEN N'پس انداز'  
	WHEN fldTypePardakht=11 THEN N'بن مزایای جانبی رفاهی' END fldNameTypePardakht,fldOrganId
	FROM   [Pay].[tblDisket] 
	WHERE  fldFileId = @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldMarhale], [fldTarikh], [fldTedad], [fldType], [fldJam], [fldTypePardakht], [fldUserId], [fldDesc], [fldDate], [fldTimeEdit], [fldEdit] 
	,fldShobeCode,fldOrganCode,fldFileId,fldNameFile	,fldBankFixId,fldNameShobe
	,CASE WHEN fldTypePardakht=1 THEN N'حقوق' WHEN fldTypePardakht=2 THEN N'عیدی' WHEN fldTypePardakht=3 THEN N'سایر مزایا' WHEN fldTypePardakht=4 THEN N'اضافه کار' WHEN fldTypePardakht=5 THEN N'تعطیل کار' WHEN fldTypePardakht=6 THEN N'مرخصی' WHEN fldTypePardakht=7 THEN N'ماموریت' WHEN fldTypePardakht=8 THEN N'کمک نقدی مستمر' WHEN fldTypePardakht=9 THEN N'کمک نقدی غیر مستمر' WHEN fldTypePardakht=10 THEN N'پس انداز'  
	WHEN fldTypePardakht=11 THEN N'بن مزایای جانبی رفاهی' END fldNameTypePardakht,fldOrganId
	FROM   [Pay].[tblDisket] 

	COMMIT
GO
