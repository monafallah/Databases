SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoteghayerhayeEydiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc], 
	CASE WHEN (fldTypeMohasebatMaliyat=0) then N'به صورت ثابت' ELSE N'از طریق جدول مالیاتی' END AS fldTypeMohasebatMaliyatName,CASE WHEN (fldTypeMohasebe=0) THEN N'مزد ثابت' ELSE N'فقط مزد شغل ماهیانه' END AS fldTypeMohasebeName
	FROM   [Pay].[tblMoteghayerhayeEydi] 
	WHERE  fldId = @Value
	ORDER BY fldId DESC

		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc], 
	CASE WHEN (fldTypeMohasebatMaliyat=0) then N'به صورت ثابت' ELSE N'از طریق جدول مالیاتی' END AS fldTypeMohasebatMaliyatName,CASE WHEN (fldTypeMohasebe=0) THEN N'مزد ثابت' ELSE N'فقط مزد شغل ماهیانه' END AS fldTypeMohasebeName
	FROM   [Pay].[tblMoteghayerhayeEydi] 
	WHERE  fldDesc LIKE @Value
	ORDER BY fldId DESC
	
	 if (@fieldname=N'fldTypeMohasebatMaliyatName')
	SELECT top(@h)* FROM(SELECT [fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc], 
	CASE WHEN (fldTypeMohasebatMaliyat=0) then N'به صورت ثابت' ELSE N'از طریق جدول مالیاتی' END AS fldTypeMohasebatMaliyatName,CASE WHEN (fldTypeMohasebe=0) THEN N'مزد ثابت' ELSE N'فقط مزد شغل ماهیانه' END AS fldTypeMohasebeName
	FROM   [Pay].[tblMoteghayerhayeEydi])t
	WHERE  t.fldTypeMohasebatMaliyatName like @Value
	ORDER BY fldId DESC
	
	if (@fieldname=N'fldTypeMohasebeName')
	SELECT top(@h) * FROM (SELECT [fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc], 
	CASE WHEN (fldTypeMohasebatMaliyat=0) then N'به صورت ثابت' ELSE N'از طریق جدول مالیاتی' END AS fldTypeMohasebatMaliyatName,CASE WHEN (fldTypeMohasebe=0) THEN N'مزد ثابت' ELSE N'فقط مزد شغل ماهیانه' END AS fldTypeMohasebeName
	FROM   [Pay].[tblMoteghayerhayeEydi])t
	WHERE  t.fldTypeMohasebeName like @Value
	ORDER BY fldId DESC
	
  if (@fieldname=N'fldYear')
	SELECT top(@h) [fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc], 
	CASE WHEN (fldTypeMohasebatMaliyat=0) then N'به صورت ثابت' ELSE N'از طریق جدول مالیاتی' END AS fldTypeMohasebatMaliyatName,CASE WHEN (fldTypeMohasebe=0) THEN N'مزد ثابت' ELSE N'فقط مزد شغل ماهیانه' END AS fldTypeMohasebeName
	FROM   [Pay].[tblMoteghayerhayeEydi]
	WHERE  fldYear like @Value
	ORDER BY fldId DESC

	if (@fieldname=N'fldMaxEydiKarmand')
	SELECT top(@h) [fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc], 
	CASE WHEN (fldTypeMohasebatMaliyat=0) then N'به صورت ثابت' ELSE N'از طریق جدول مالیاتی' END AS fldTypeMohasebatMaliyatName,CASE WHEN (fldTypeMohasebe=0) THEN N'مزد ثابت' ELSE N'فقط مزد شغل ماهیانه' END AS fldTypeMohasebeName
	FROM   [Pay].[tblMoteghayerhayeEydi]
	WHERE  fldMaxEydiKarmand like @Value
	ORDER BY fldId DESC
	
	if (@fieldname=N'fldMaxEydiKargar')
	SELECT top(@h) [fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc], 
	CASE WHEN (fldTypeMohasebatMaliyat=0) then N'به صورت ثابت' ELSE N'از طریق جدول مالیاتی' END AS fldTypeMohasebatMaliyatName,CASE WHEN (fldTypeMohasebe=0) THEN N'مزد ثابت' ELSE N'فقط مزد شغل ماهیانه' END AS fldTypeMohasebeName
	FROM   [Pay].[tblMoteghayerhayeEydi] 
	WHERE  fldMaxEydiKargar like @Value
	ORDER BY fldId DESC
	
	if (@fieldname=N'fldZaribEydiKargari')
	SELECT top(@h) [fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc], 
	CASE WHEN (fldTypeMohasebatMaliyat=0) then N'به صورت ثابت' ELSE N'از طریق جدول مالیاتی' END AS fldTypeMohasebatMaliyatName,CASE WHEN (fldTypeMohasebe=0) THEN N'مزد ثابت' ELSE N'فقط مزد شغل ماهیانه' END AS fldTypeMohasebeName
	FROM   [Pay].[tblMoteghayerhayeEydi]
	WHERE  fldZaribEydiKargari like @Value
	ORDER BY fldId DESC
	
	if (@fieldname=N'fldTypeMohasebatMaliyat')
	SELECT top(@h) [fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc], 
	CASE WHEN (fldTypeMohasebatMaliyat=0) then N'به صورت ثابت' ELSE N'از طریق جدول مالیاتی' END AS fldTypeMohasebatMaliyatName,CASE WHEN (fldTypeMohasebe=0) THEN N'مزد ثابت' ELSE N'فقط مزد شغل ماهیانه' END AS fldTypeMohasebeName
	FROM   [Pay].[tblMoteghayerhayeEydi]
	WHERE  fldTypeMohasebatMaliyat like @Value
	ORDER BY fldId DESC
	
	if (@fieldname=N'fldMablaghMoafiatKarmand')
	SELECT top(@h) [fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc], 
	CASE WHEN (fldTypeMohasebatMaliyat=0) then N'به صورت ثابت' ELSE N'از طریق جدول مالیاتی' END AS fldTypeMohasebatMaliyatName,CASE WHEN (fldTypeMohasebe=0) THEN N'مزد ثابت' ELSE N'فقط مزد شغل ماهیانه' END AS fldTypeMohasebeName
	FROM   [Pay].[tblMoteghayerhayeEydi]
	WHERE  fldMablaghMoafiatKarmand like @Value
	ORDER BY fldId DESC
	
	if (@fieldname=N'fldMablaghMoafiatKargar')
	SELECT top(@h) [fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc], 
	CASE WHEN (fldTypeMohasebatMaliyat=0) then N'به صورت ثابت' ELSE N'از طریق جدول مالیاتی' END AS fldTypeMohasebatMaliyatName,CASE WHEN (fldTypeMohasebe=0) THEN N'مزد ثابت' ELSE N'فقط مزد شغل ماهیانه' END AS fldTypeMohasebeName
	FROM   [Pay].[tblMoteghayerhayeEydi]
	WHERE  fldMablaghMoafiatKargar like @Value
	ORDER BY fldId DESC
	
	if (@fieldname=N'fldDarsadMaliyatKarmand')
SELECT top(@h) [fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc], 
	CASE WHEN (fldTypeMohasebatMaliyat=0) then N'به صورت ثابت' ELSE N'از طریق جدول مالیاتی' END AS fldTypeMohasebatMaliyatName,CASE WHEN (fldTypeMohasebe=0) THEN N'مزد ثابت' ELSE N'فقط مزد شغل ماهیانه' END AS fldTypeMohasebeName
	FROM   [Pay].[tblMoteghayerhayeEydi]
	WHERE  fldDarsadMaliyatKarmand like @Value
	ORDER BY fldId DESC
	
	if (@fieldname=N'fldDarsadMaliyatKargar')
	SELECT top(@h) [fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc], 
	CASE WHEN (fldTypeMohasebatMaliyat=0) then N'به صورت ثابت' ELSE N'از طریق جدول مالیاتی' END AS fldTypeMohasebatMaliyatName,CASE WHEN (fldTypeMohasebe=0) THEN N'مزد ثابت' ELSE N'فقط مزد شغل ماهیانه' END AS fldTypeMohasebeName
	FROM   [Pay].[tblMoteghayerhayeEydi]
	WHERE  fldDarsadMaliyatKargar like @Value
	ORDER BY fldId DESC
	
	if (@fieldname=N'fldTypeMohasebe')
	SELECT top(@h) [fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc], 
	CASE WHEN (fldTypeMohasebatMaliyat=0) then N'به صورت ثابت' ELSE N'از طریق جدول مالیاتی' END AS fldTypeMohasebatMaliyatName,CASE WHEN (fldTypeMohasebe=0) THEN N'مزد ثابت' ELSE N'فقط مزد شغل ماهیانه' END AS fldTypeMohasebeName
	FROM   [Pay].[tblMoteghayerhayeEydi]
	WHERE  fldTypeMohasebe like @Value
	ORDER BY fldId DESC
	
  	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldYear], [fldMaxEydiKarmand], [fldMaxEydiKargar], [fldZaribEydiKargari], [fldTypeMohasebatMaliyat], [fldMablaghMoafiatKarmand], [fldMablaghMoafiatKargar], [fldDarsadMaliyatKarmand], [fldDarsadMaliyatKargar], [fldTypeMohasebe], [fldUserId], [fldDate], [fldDesc], 
	CASE WHEN (fldTypeMohasebatMaliyat=0) then N'به صورت ثابت' ELSE N'از طریق جدول مالیاتی' END AS fldTypeMohasebatMaliyatName,CASE WHEN (fldTypeMohasebe=0) THEN N'مزد ثابت' ELSE N'فقط مزد شغل ماهیانه' END AS fldTypeMohasebeName
	FROM   [Pay].[tblMoteghayerhayeEydi]
	ORDER BY fldId DESC

	COMMIT
GO
