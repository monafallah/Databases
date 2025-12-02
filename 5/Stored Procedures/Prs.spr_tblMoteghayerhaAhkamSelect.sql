SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblMoteghayerhaAhkamSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldYear], [fldType], [fldHagheOlad], [fldHagheAeleMandi], [fldKharoBar], [fldMaskan], [fldKharoBarMojarad], [fldHadaghalDaryafti], [fldHaghBon], [fldUserId], [fldDate], [fldDesc] 
	,CASE WHEN(fldType=0) THEN N'کارگری' ELSE N'کارمندی' END AS fldTypeName,[fldHadaghalTadil]
	FROM   [Prs].[tblMoteghayerhaAhkam] 
	WHERE  fldId = @Value

		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldYear], [fldType], [fldHagheOlad], [fldHagheAeleMandi], [fldKharoBar], [fldMaskan], [fldKharoBarMojarad], [fldHadaghalDaryafti], [fldHaghBon], [fldUserId], [fldDate], [fldDesc] 
	,CASE WHEN(fldType=0) THEN N'کارگری' ELSE N'کارمندی' END AS fldTypeName,[fldHadaghalTadil]
	FROM   [Prs].[tblMoteghayerhaAhkam] 
	WHERE  fldDesc = @Value
	
	if (@fieldname=N'fldHagheOlad')
	SELECT TOP (@h) fldId, fldYear, fldType, fldHagheOlad, fldHagheAeleMandi, fldKharoBar, fldMaskan, fldKharoBarMojarad, fldHadaghalDaryafti, fldHaghBon, fldUserId, fldDate, 
                  fldDesc, CASE WHEN (fldType = 0) THEN N'کارگری' ELSE N'کارمندی' END AS fldTypeName, fldHadaghalTadil
FROM     Prs.tblMoteghayerhaAhkam
	WHERE  fldHagheOlad LIKE @Value
	
	if (@fieldname=N'fldKharoBar')
	SELECT top(@h) [fldId], [fldYear], [fldType], [fldHagheOlad], [fldHagheAeleMandi], [fldKharoBar], [fldMaskan], [fldKharoBarMojarad], [fldHadaghalDaryafti], [fldHaghBon], [fldUserId], [fldDate], [fldDesc] 
	,CASE WHEN(fldType=0) THEN N'کارگری' ELSE N'کارمندی' END AS fldTypeName,[fldHadaghalTadil]
	FROM   [Prs].[tblMoteghayerhaAhkam] 
	WHERE  fldKharoBar LIKE @Value
	
	if (@fieldname=N'fldMaskan')
	SELECT top(@h) [fldId], [fldYear], [fldType], [fldHagheOlad], [fldHagheAeleMandi], [fldKharoBar], [fldMaskan], [fldKharoBarMojarad], [fldHadaghalDaryafti], [fldHaghBon], [fldUserId], [fldDate], [fldDesc] 
	,CASE WHEN(fldType=0) THEN N'کارگری' ELSE N'کارمندی' END AS fldTypeName,[fldHadaghalTadil]
	FROM   [Prs].[tblMoteghayerhaAhkam] 
	WHERE  fldMaskan LIKE @Value
	
	if (@fieldname=N'fldKharoBarMojarad')
	SELECT top(@h) [fldId], [fldYear], [fldType], [fldHagheOlad], [fldHagheAeleMandi], [fldKharoBar], [fldMaskan], [fldKharoBarMojarad], [fldHadaghalDaryafti], [fldHaghBon], [fldUserId], [fldDate], [fldDesc] 
	,CASE WHEN(fldType=0) THEN N'کارگری' ELSE N'کارمندی' END AS fldTypeName,[fldHadaghalTadil]
	FROM   [Prs].[tblMoteghayerhaAhkam] 
	WHERE  fldKharoBarMojarad LIKE @Value

	if (@fieldname=N'fldYear')
	SELECT top(@h) [fldId], [fldYear], [fldType], [fldHagheOlad], [fldHagheAeleMandi], [fldKharoBar], [fldMaskan], [fldKharoBarMojarad], [fldHadaghalDaryafti], [fldHaghBon], [fldUserId], [fldDate], [fldDesc] 
	,CASE WHEN(fldType=0) THEN N'کارگری' ELSE N'کارمندی' END AS fldTypeName,[fldHadaghalTadil]
	FROM   [Prs].[tblMoteghayerhaAhkam] 
	WHERE  fldYear LIKE @Value

		if (@fieldname=N'fldTypeName')
	SELECT top(@h) * FROM (SELECT [fldId], [fldYear], [fldType], [fldHagheOlad], [fldHagheAeleMandi], [fldKharoBar], [fldMaskan], [fldKharoBarMojarad], [fldHadaghalDaryafti], [fldHaghBon], [fldUserId], [fldDate], [fldDesc] 
	,CASE WHEN(fldType=0) THEN N'کارگری' ELSE N'کارمندی' END AS fldTypeName,[fldHadaghalTadil]
	FROM   [Prs].[tblMoteghayerhaAhkam] )t
	WHERE  fldTypeName LIKE @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldYear], [fldType], [fldHagheOlad], [fldHagheAeleMandi], [fldKharoBar], [fldMaskan], [fldKharoBarMojarad], [fldHadaghalDaryafti], [fldHaghBon],  [fldUserId], [fldDate], [fldDesc] 
	,CASE WHEN(fldType=0) THEN N'کارگری' ELSE N'کارمندی' END AS fldTypeName,[fldHadaghalTadil]
	FROM   [Prs].[tblMoteghayerhaAhkam] 

	COMMIT
GO
