SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblVaziyatEsargariSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTitle], fldMoafAsBime,fldMoafAsMaliyat,isnull(fldMoafAsBimeOmr,cast(0 as bit)) as fldMoafAsBimeOmr, [fldUserId], [fldDate], [fldDesc],
	CASE when(fldMoafAsBime=1)then N'بله' else N'خیر' end as  fldMoafAsBimeName
	,CASE WHEN (fldMoafAsMaliyat=1)then N'بله' else N'خیر' end as  fldMoafAsMaliyatName
	,CASE WHEN (fldMoafAsBimeOmr=1)then N'بله' else N'خیر' end as  fldMoafAsBimeOmrName
	,isnull(fldMoafAsBimeTakmili,cast(0 as bit)) as fldMoafAsBimeTakmili 
	,CASE WHEN (fldMoafAsBimeTakmili=1)then N'بله' else N'خیر' end as  fldMoafAsBimeTakmiliName
	FROM   [Prs].[tblVaziyatEsargari] 
	WHERE  fldId = @Value

		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldTitle], fldMoafAsBime,fldMoafAsMaliyat,isnull(fldMoafAsBimeOmr,cast(0 as bit)) as fldMoafAsBimeOmr, [fldUserId], [fldDate], [fldDesc],
	CASE when(fldMoafAsBime=1)then N'بله' else N'خیر' end as  fldMoafAsBimeName
	,CASE WHEN (fldMoafAsMaliyat=1)then N'بله' else N'خیر' end as  fldMoafAsMaliyatName
	,CASE WHEN (fldMoafAsBimeOmr=1)then N'بله' else N'خیر' end as  fldMoafAsBimeOmrName
	,isnull(fldMoafAsBimeTakmili,cast(0 as bit)) as fldMoafAsBimeTakmili 
	,CASE WHEN (fldMoafAsBimeTakmili=1)then N'بله' else N'خیر' end as  fldMoafAsBimeTakmiliName
	FROM   [Prs].[tblVaziyatEsargari] 
	WHERE  fldDesc LIKE @Value

	if (@fieldname=N'fldTitle')
		SELECT top(@h) [fldId], [fldTitle], fldMoafAsBime,fldMoafAsMaliyat,isnull(fldMoafAsBimeOmr,cast(0 as bit)) as fldMoafAsBimeOmr, [fldUserId], [fldDate], [fldDesc],
	CASE when(fldMoafAsBime=1)then N'بله' else N'خیر' end as  fldMoafAsBimeName
	,CASE WHEN (fldMoafAsMaliyat=1)then N'بله' else N'خیر' end as  fldMoafAsMaliyatName
	,CASE WHEN (fldMoafAsBimeOmr=1)then N'بله' else N'خیر' end as  fldMoafAsBimeOmrName
	,isnull(fldMoafAsBimeTakmili,cast(0 as bit)) as fldMoafAsBimeTakmili 
	,CASE WHEN (fldMoafAsBimeTakmili=1)then N'بله' else N'خیر' end as  fldMoafAsBimeTakmiliName
	FROM   [Prs].[tblVaziyatEsargari] 
	WHERE  fldTitle like @Value

	
	if (@fieldname=N'fldMoafAsBimeName')
	SELECT top(@h)* FROM(	SELECT  [fldId], [fldTitle], fldMoafAsBime,fldMoafAsMaliyat,isnull(fldMoafAsBimeOmr,cast(0 as bit)) as fldMoafAsBimeOmr, [fldUserId], [fldDate], [fldDesc],
	CASE when(fldMoafAsBime=1)then N'بله' else N'خیر' end as  fldMoafAsBimeName
	,CASE WHEN (fldMoafAsMaliyat=1)then N'بله' else N'خیر' end as  fldMoafAsMaliyatName
	,CASE WHEN (fldMoafAsBimeOmr=1)then N'بله' else N'خیر' end as  fldMoafAsBimeOmrName
	,isnull(fldMoafAsBimeTakmili,cast(0 as bit)) as fldMoafAsBimeTakmili 
	,CASE WHEN (fldMoafAsBimeTakmili=1)then N'بله' else N'خیر' end as  fldMoafAsBimeTakmiliName
	FROM   [Prs].[tblVaziyatEsargari] ) temp
	WHERE  fldMoafAsBimeName like @Value
	
		if (@fieldname=N'fldMoafAsMaliyatName')
	SELECT top(@h)* FROM(	SELECT  [fldId], [fldTitle], fldMoafAsBime,fldMoafAsMaliyat,isnull(fldMoafAsBimeOmr,cast(0 as bit)) as fldMoafAsBimeOmr, [fldUserId], [fldDate], [fldDesc],
	CASE when(fldMoafAsBime=1)then N'بله' else N'خیر' end as  fldMoafAsBimeName
	,CASE WHEN (fldMoafAsMaliyat=1)then N'بله' else N'خیر' end as  fldMoafAsMaliyatName
	,CASE WHEN (fldMoafAsBimeOmr=1)then N'بله' else N'خیر' end as  fldMoafAsBimeOmrName
	,isnull(fldMoafAsBimeTakmili,cast(0 as bit)) as fldMoafAsBimeTakmili 
	,CASE WHEN (fldMoafAsBimeTakmili=1)then N'بله' else N'خیر' end as  fldMoafAsBimeTakmiliName
	FROM   [Prs].[tblVaziyatEsargari] ) temp
	WHERE  fldMoafAsMaliyatName like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTitle], fldMoafAsBime,fldMoafAsMaliyat,isnull(fldMoafAsBimeOmr,cast(0 as bit)) as fldMoafAsBimeOmr, [fldUserId], [fldDate], [fldDesc],
	CASE when(fldMoafAsBime=1)then N'بله' else N'خیر' end as  fldMoafAsBimeName
	,CASE WHEN (fldMoafAsMaliyat=1)then N'بله' else N'خیر' end as  fldMoafAsMaliyatName
	,CASE WHEN (fldMoafAsBimeOmr=1)then N'بله' else N'خیر' end as  fldMoafAsBimeOmrName
	,isnull(fldMoafAsBimeTakmili,cast(0 as bit)) as fldMoafAsBimeTakmili 
	,CASE WHEN (fldMoafAsBimeTakmili=1)then N'بله' else N'خیر' end as  fldMoafAsBimeTakmiliName
	FROM   [Prs].[tblVaziyatEsargari] 

	COMMIT
GO
