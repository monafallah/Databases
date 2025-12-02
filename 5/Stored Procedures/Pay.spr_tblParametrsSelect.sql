SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblParametrsSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@value)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) Pay.tblParametrs.fldId, Pay.tblParametrs.fldTitle, Pay.tblParametrs.fldTypeParametr, Pay.tblParametrs.fldTypeMablagh, 
                      Pay.tblParametrs.fldTypeEstekhdamId, Pay.tblParametrs.fldUserId, Pay.tblParametrs.fldDesc, Pay.tblParametrs.fldDate, 
                      CASE WHEN fldTypeParametr = 0 THEN N'مطالبات' ELSE N'کسورات' END AS fldNoeParametrName, 
                      CASE WHEN fldTypeMablagh = 0 THEN N'عدد ثابت' ELSE N'تابع فرمول ' END AS fldNoeMablaghName, Com.tblTypeEstekhdam.fldTitle AS TypeEstekhdamName, 
                      Isnull(Pay.tblParameteriItemsFormul.fldId,0) as fldFormulId,fldActive,fldPrivate,fldHesabTypeParam
					  , CASE WHEN fldActive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActiveName,  CASE WHEN fldPrivate = 0 THEN N'خصوصی' ELSE N'عمومی' END AS fldPrivateName,h.fldTitle AS fldHesabTypeParamName
                      ,fldIsMostamar,CASE WHEN fldIsMostamar = 1 THEN N'مستمر' ELSE N'غیرمستمر' END AS fldMostamarName
					  FROM         Pay.tblParametrs  inner join 
					  com.tblHesabType as h on h.fldId=fldHesabTypeParam	LEFT OUTER JOIN
                      Pay.tblParameteriItemsFormul ON Pay.tblParametrs.fldId = Pay.tblParameteriItemsFormul.fldParametrId LEFT OUTER JOIN
                      Com.tblTypeEstekhdam ON Pay.tblParametrs.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId
WHERE     (Pay.tblParametrs.fldId = @Value)
order by fldTitle

if (@fieldname=N'fldTitle')
	SELECT     TOP (@h) Pay.tblParametrs.fldId, Pay.tblParametrs.fldTitle, Pay.tblParametrs.fldTypeParametr, Pay.tblParametrs.fldTypeMablagh, 
                      Pay.tblParametrs.fldTypeEstekhdamId, Pay.tblParametrs.fldUserId, Pay.tblParametrs.fldDesc, Pay.tblParametrs.fldDate, 
                      CASE WHEN fldTypeParametr = 0 THEN N'مطالبات' ELSE N'کسورات' END AS fldNoeParametrName, 
                      CASE WHEN fldTypeMablagh = 0 THEN N'عدد ثابت' ELSE N'تابع فرمول ' END AS fldNoeMablaghName, Com.tblTypeEstekhdam.fldTitle AS TypeEstekhdamName, 
                      Isnull(Pay.tblParameteriItemsFormul.fldId,0) as fldFormulId,fldActive,fldPrivate,fldHesabTypeParam
					  , CASE WHEN fldActive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActiveName
					  , CASE WHEN fldPrivate = 0 THEN N'خصوصی' ELSE N'عمومی' END AS fldPrivateName,h.fldTitle AS fldHesabTypeParamName
                      ,fldIsMostamar,CASE WHEN fldIsMostamar = 1 THEN N'مستمر' ELSE N'غیرمستمر' END AS fldMostamarName
					  FROM         Pay.tblParametrs  inner join 
					  com.tblHesabType as h on h.fldId=fldHesabTypeParam	LEFT OUTER JOIN
                      Pay.tblParameteriItemsFormul ON Pay.tblParametrs.fldId = Pay.tblParameteriItemsFormul.fldParametrId LEFT OUTER JOIN
                      Com.tblTypeEstekhdam ON Pay.tblParametrs.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId
WHERE     (Pay.tblParametrs.fldTitle LIKE @Value)and (fldPrivate=1  or Pay.tblParametrs.fldOrganId=@Value2 )
	order by Pay.tblParametrs.fldId desc

if (@fieldname=N'fldNoeParametrName')
	SELECT     TOP (@h)* FROM (SELECT Pay.tblParametrs.fldId, Pay.tblParametrs.fldTitle, Pay.tblParametrs.fldTypeParametr, Pay.tblParametrs.fldTypeMablagh, 
                      Pay.tblParametrs.fldTypeEstekhdamId, Pay.tblParametrs.fldUserId, Pay.tblParametrs.fldDesc, Pay.tblParametrs.fldDate, 
                      CASE WHEN fldTypeParametr = 0 THEN N'مطالبات' ELSE N'کسورات' END AS fldNoeParametrName, 
                      CASE WHEN fldTypeMablagh = 0 THEN N'عدد ثابت' ELSE N'تابع فرمول ' END AS fldNoeMablaghName, Com.tblTypeEstekhdam.fldTitle AS TypeEstekhdamName, 
                      Isnull(Pay.tblParameteriItemsFormul.fldId,0) as fldFormulId,fldActive,fldPrivate,fldHesabTypeParam
					  , CASE WHEN fldActive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActiveName, CASE WHEN fldPrivate = 0 THEN N'خصوصی' ELSE N'عمومی' END AS fldPrivateName,h.fldTitle AS fldHesabTypeParamName
                      ,fldIsMostamar,CASE WHEN fldIsMostamar = 1 THEN N'مستمر' ELSE N'غیرمستمر' END AS fldMostamarName
					  FROM         Pay.tblParametrs  inner join 
					  com.tblHesabType as h on h.fldId=fldHesabTypeParam	LEFT OUTER JOIN
                      Pay.tblParameteriItemsFormul ON Pay.tblParametrs.fldId = Pay.tblParameteriItemsFormul.fldParametrId LEFT OUTER JOIN
                      Com.tblTypeEstekhdam ON Pay.tblParametrs.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId
					  where (fldPrivate=1  or Pay.tblParametrs.fldOrganId=@Value2 ))t
WHERE     (fldNoeParametrName LIKE @Value)
	order by t.fldId desc

if (@fieldname=N'fldNoeMablaghName')
	SELECT     TOP (@h) * FROM (SELECT Pay.tblParametrs.fldId, Pay.tblParametrs.fldTitle, Pay.tblParametrs.fldTypeParametr, Pay.tblParametrs.fldTypeMablagh, 
                      Pay.tblParametrs.fldTypeEstekhdamId, Pay.tblParametrs.fldUserId, Pay.tblParametrs.fldDesc, Pay.tblParametrs.fldDate, 
                      CASE WHEN fldTypeParametr = 0 THEN N'مطالبات' ELSE N'کسورات' END AS fldNoeParametrName, 
                      CASE WHEN fldTypeMablagh = 0 THEN N'عدد ثابت' ELSE N'تابع فرمول ' END AS fldNoeMablaghName, Com.tblTypeEstekhdam.fldTitle AS TypeEstekhdamName, 
                      Isnull(Pay.tblParameteriItemsFormul.fldId,0) as fldFormulId,fldActive,fldPrivate,fldHesabTypeParam
					  , CASE WHEN fldActive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActiveName, CASE WHEN fldPrivate = 0 THEN N'خصوصی' ELSE N'عمومی' END AS fldPrivateName,h.fldTitle AS fldHesabTypeParamName
                      ,fldIsMostamar,CASE WHEN fldIsMostamar = 1 THEN N'مستمر' ELSE N'غیرمستمر' END AS fldMostamarName
					  FROM         Pay.tblParametrs  inner join 
					  com.tblHesabType as h on h.fldId=fldHesabTypeParam	LEFT OUTER JOIN
                      Pay.tblParameteriItemsFormul ON Pay.tblParametrs.fldId = Pay.tblParameteriItemsFormul.fldParametrId LEFT OUTER JOIN
                      Com.tblTypeEstekhdam ON Pay.tblParametrs.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId
					  where  (fldPrivate=1  or tblParametrs.fldOrganId=@Value2 ))t
WHERE     (fldNoeMablaghName LIKE @Value)
	order by t.fldId desc

if (@fieldname=N'TypeEstekhdamName')
	SELECT     TOP (@h)* FROM (SELECT Pay.tblParametrs.fldId, Pay.tblParametrs.fldTitle, Pay.tblParametrs.fldTypeParametr, Pay.tblParametrs.fldTypeMablagh, 
                      Pay.tblParametrs.fldTypeEstekhdamId, Pay.tblParametrs.fldUserId, Pay.tblParametrs.fldDesc, Pay.tblParametrs.fldDate, 
                      CASE WHEN fldTypeParametr = 0 THEN N'مطالبات' ELSE N'کسورات' END AS fldNoeParametrName, 
                      CASE WHEN fldTypeMablagh = 0 THEN N'عدد ثابت' ELSE N'تابع فرمول ' END AS fldNoeMablaghName, Com.tblTypeEstekhdam.fldTitle AS TypeEstekhdamName, 
                      Isnull(Pay.tblParameteriItemsFormul.fldId,0) as fldFormulId,fldActive,fldPrivate,fldHesabTypeParam
					  , CASE WHEN fldActive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActiveName
					  , CASE WHEN fldPrivate = 0 THEN N'خصوصی' ELSE N'عمومی' END AS fldPrivateName,h.fldTitle AS fldHesabTypeParamName
                      ,fldIsMostamar,CASE WHEN fldIsMostamar = 1 THEN N'مستمر' ELSE N'غیرمستمر' END AS fldMostamarName
					  FROM         Pay.tblParametrs  inner join 
					  com.tblHesabType as h on h.fldId=fldHesabTypeParam	LEFT OUTER JOIN
                      Pay.tblParameteriItemsFormul ON Pay.tblParametrs.fldId = Pay.tblParameteriItemsFormul.fldParametrId LEFT OUTER JOIN
                      Com.tblTypeEstekhdam ON Pay.tblParametrs.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId
					  where  (fldPrivate=1  or tblParametrs.fldOrganId=@Value2 ))t
WHERE     (TypeEstekhdamName LIKE @Value)
	order by t.fldId desc

if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) Pay.tblParametrs.fldId, Pay.tblParametrs.fldTitle, Pay.tblParametrs.fldTypeParametr, Pay.tblParametrs.fldTypeMablagh, 
                      Pay.tblParametrs.fldTypeEstekhdamId, Pay.tblParametrs.fldUserId, Pay.tblParametrs.fldDesc, Pay.tblParametrs.fldDate, 
                      CASE WHEN fldTypeParametr = 0 THEN N'مطالبات' ELSE N'کسورات' END AS fldNoeParametrName, 
                      CASE WHEN fldTypeMablagh = 0 THEN N'عدد ثابت' ELSE N'تابع فرمول ' END AS fldNoeMablaghName, Com.tblTypeEstekhdam.fldTitle AS TypeEstekhdamName, 
                      Isnull(Pay.tblParameteriItemsFormul.fldId,0) as fldFormulId,fldActive,fldPrivate,fldHesabTypeParam
					  , CASE WHEN fldActive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActiveName
					  , CASE WHEN fldPrivate = 0 THEN N'خصوصی' ELSE N'عمومی' END AS fldPrivateName,h.fldTitle AS fldHesabTypeParamName
                      ,fldIsMostamar,CASE WHEN fldIsMostamar = 1 THEN N'مستمر' ELSE N'غیرمستمر' END AS fldMostamarName
					  FROM         Pay.tblParametrs  inner join 
					  com.tblHesabType as h on h.fldId=fldHesabTypeParam	LEFT OUTER JOIN
                      Pay.tblParameteriItemsFormul ON Pay.tblParametrs.fldId = Pay.tblParameteriItemsFormul.fldParametrId LEFT OUTER JOIN
                      Com.tblTypeEstekhdam ON Pay.tblParametrs.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId
WHERE     (Pay.tblParametrs.fldDesc LIKE @Value)and (fldPrivate=1  or tblParametrs.fldOrganId=@Value2 )
	order by Pay.tblParametrs.fldId desc

if (@fieldname=N'fldTypeParametr')
	SELECT     TOP (@h) Pay.tblParametrs.fldId, Pay.tblParametrs.fldTitle, Pay.tblParametrs.fldTypeParametr, Pay.tblParametrs.fldTypeMablagh, 
                      Pay.tblParametrs.fldTypeEstekhdamId, Pay.tblParametrs.fldUserId, Pay.tblParametrs.fldDesc, Pay.tblParametrs.fldDate, 
                      CASE WHEN fldTypeParametr = 0 THEN N'مطالبات' ELSE N'کسورات' END AS fldNoeParametrName, 
                      CASE WHEN fldTypeMablagh = 0 THEN N'عدد ثابت' ELSE N'تابع فرمول ' END AS fldNoeMablaghName, Com.tblTypeEstekhdam.fldTitle AS TypeEstekhdamName, 
                      Isnull(Pay.tblParameteriItemsFormul.fldId,0) as fldFormulId,fldActive,fldPrivate,fldHesabTypeParam
					  , CASE WHEN fldActive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActiveName, CASE WHEN fldPrivate = 0 THEN N'خصوصی' ELSE N'عمومی' END AS fldPrivateName,h.fldTitle AS fldHesabTypeParamName
                      ,fldIsMostamar,CASE WHEN fldIsMostamar = 1 THEN N'مستمر' ELSE N'غیرمستمر' END AS fldMostamarName
					  FROM         Pay.tblParametrs  inner join 
					  com.tblHesabType as h on h.fldId=fldHesabTypeParam	LEFT OUTER JOIN
                      Pay.tblParameteriItemsFormul ON Pay.tblParametrs.fldId = Pay.tblParameteriItemsFormul.fldParametrId LEFT OUTER JOIN
                      Com.tblTypeEstekhdam ON Pay.tblParametrs.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId
WHERE     (Pay.tblParametrs.fldTypeParametr = @Value)and (fldPrivate=1  or tblParametrs.fldOrganId=@Value2 )
	order by Pay.tblParametrs.fldId desc
	
		if (@fieldname=N'Kosurat')
	SELECT     TOP (@h) Pay.tblParametrs.fldId, Pay.tblParametrs.fldTitle, Pay.tblParametrs.fldTypeParametr, Pay.tblParametrs.fldTypeMablagh, 
                      Pay.tblParametrs.fldTypeEstekhdamId, Pay.tblParametrs.fldUserId, Pay.tblParametrs.fldDesc, Pay.tblParametrs.fldDate, 
                      CASE WHEN fldTypeParametr = 0 THEN N'مطالبات' ELSE N'کسورات' END AS fldNoeParametrName, 
                      CASE WHEN fldTypeMablagh = 0 THEN N'عدد ثابت' ELSE N'تابع فرمول ' END AS fldNoeMablaghName, Com.tblTypeEstekhdam.fldTitle AS TypeEstekhdamName, 
                      Isnull(Pay.tblParameteriItemsFormul.fldId,0) as fldFormulId,fldActive,fldPrivate,fldHesabTypeParam
					  , CASE WHEN fldActive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActiveName, CASE WHEN fldPrivate = 0 THEN N'خصوصی' ELSE N'عمومی' END AS fldPrivateName
					  , h.fldTitle AS fldHesabTypeParamName
                      ,fldIsMostamar,CASE WHEN fldIsMostamar = 1 THEN N'مستمر' ELSE N'غیرمستمر' END AS fldMostamarName
					  FROM         Pay.tblParametrs inner join 
					  com.tblHesabType as h on h.fldId=fldHesabTypeParam	LEFT OUTER JOIN
                      Pay.tblParameteriItemsFormul ON Pay.tblParametrs.fldId = Pay.tblParameteriItemsFormul.fldParametrId LEFT OUTER JOIN
                      Com.tblTypeEstekhdam ON Pay.tblParametrs.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId
	WHERE fldTypeParametr=1 AND ((fldTypeMablagh=1 AND fldFormul<>'') OR fldTypeMablagh=0)
	and fldActive=1
	and (fldPrivate=1  or tblParametrs.fldOrganId=@Value2 )
	order by Pay.tblParametrs.fldId desc

			if (@fieldname=N'Motalebat')
	SELECT     TOP (@h) Pay.tblParametrs.fldId, Pay.tblParametrs.fldTitle, Pay.tblParametrs.fldTypeParametr, Pay.tblParametrs.fldTypeMablagh, 
                      Pay.tblParametrs.fldTypeEstekhdamId, Pay.tblParametrs.fldUserId, Pay.tblParametrs.fldDesc, Pay.tblParametrs.fldDate, 
                      CASE WHEN fldTypeParametr = 0 THEN N'مطالبات' ELSE N'کسورات' END AS fldNoeParametrName, 
                      CASE WHEN fldTypeMablagh = 0 THEN N'عدد ثابت' ELSE N'تابع فرمول ' END AS fldNoeMablaghName, Com.tblTypeEstekhdam.fldTitle AS TypeEstekhdamName, 
                      Isnull(Pay.tblParameteriItemsFormul.fldId,0) as fldFormulId,fldActive,fldPrivate,fldHesabTypeParam
					  , CASE WHEN fldActive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActiveName, CASE WHEN fldPrivate = 0 THEN N'خصوصی' ELSE N'عمومی' END AS fldPrivateName,h.fldTitle AS fldHesabTypeParamName
                      ,fldIsMostamar,CASE WHEN fldIsMostamar = 1 THEN N'مستمر' ELSE N'غیرمستمر' END AS fldMostamarName
					  FROM         Pay.tblParametrs  inner join 
					  com.tblHesabType as h on h.fldId=fldHesabTypeParam	LEFT OUTER JOIN
                      Pay.tblParameteriItemsFormul ON Pay.tblParametrs.fldId = Pay.tblParameteriItemsFormul.fldParametrId LEFT OUTER JOIN
                      Com.tblTypeEstekhdam ON Pay.tblParametrs.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId
	WHERE fldTypeParametr=0 AND ((fldTypeMablagh=1 AND fldFormul<>'') OR fldTypeMablagh=0) 
	and fldActive=1
	and (fldPrivate=1  or tblParametrs.fldOrganId=@Value2 )
	order by Pay.tblParametrs.fldId desc

	if (@fieldname=N'')
	SELECT     TOP (@h) Pay.tblParametrs.fldId, Pay.tblParametrs.fldTitle, Pay.tblParametrs.fldTypeParametr, Pay.tblParametrs.fldTypeMablagh, 
                      Pay.tblParametrs.fldTypeEstekhdamId, Pay.tblParametrs.fldUserId, Pay.tblParametrs.fldDesc, Pay.tblParametrs.fldDate, 
                      CASE WHEN fldTypeParametr = 0 THEN N'مطالبات' ELSE N'کسورات' END AS fldNoeParametrName, 
                      CASE WHEN fldTypeMablagh = 0 THEN N'عدد ثابت' ELSE N'تابع فرمول ' END AS fldNoeMablaghName, Com.tblTypeEstekhdam.fldTitle AS TypeEstekhdamName, 
                      Isnull(Pay.tblParameteriItemsFormul.fldId,0) as fldFormulId,fldActive,fldPrivate,fldHesabTypeParam
					  , CASE WHEN fldActive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActiveName, CASE WHEN fldPrivate = 0 THEN N'خصوصی' ELSE N'عمومی' END AS fldPrivateName,h.fldTitle AS fldHesabTypeParamName
                      ,fldIsMostamar,CASE WHEN fldIsMostamar = 1 THEN N'مستمر' ELSE N'غیرمستمر' END AS fldMostamarName
					  FROM         Pay.tblParametrs  inner join 
					  com.tblHesabType as h on h.fldId=fldHesabTypeParam	LEFT OUTER JOIN
                      Pay.tblParameteriItemsFormul ON Pay.tblParametrs.fldId = Pay.tblParameteriItemsFormul.fldParametrId LEFT OUTER JOIN
                      Com.tblTypeEstekhdam ON Pay.tblParametrs.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId
					  where  (fldPrivate=1  or tblParametrs.fldOrganId=@Value2 )
	order by Pay.tblParametrs.fldId desc

if (@fieldname=N'fldActive')
	SELECT     TOP (@h) Pay.tblParametrs.fldId, Pay.tblParametrs.fldTitle, Pay.tblParametrs.fldTypeParametr, Pay.tblParametrs.fldTypeMablagh, 
                      Pay.tblParametrs.fldTypeEstekhdamId, Pay.tblParametrs.fldUserId, Pay.tblParametrs.fldDesc, Pay.tblParametrs.fldDate, 
                      CASE WHEN fldTypeParametr = 0 THEN N'مطالبات' ELSE N'کسورات' END AS fldNoeParametrName, 
                      CASE WHEN fldTypeMablagh = 0 THEN N'عدد ثابت' ELSE N'تابع فرمول ' END AS fldNoeMablaghName, Com.tblTypeEstekhdam.fldTitle AS TypeEstekhdamName, 
                      Isnull(Pay.tblParameteriItemsFormul.fldId,0) as fldFormulId,fldActive,fldPrivate,fldHesabTypeParam
					  , CASE WHEN fldActive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActiveName, CASE WHEN fldPrivate = 0 THEN N'خصوصی' ELSE N'عمومی' END AS fldPrivateName,h.fldTitle AS fldHesabTypeParamName
                      ,fldIsMostamar,CASE WHEN fldIsMostamar = 1 THEN N'مستمر' ELSE N'غیرمستمر' END AS fldMostamarName
					  FROM         Pay.tblParametrs  inner join 
					  com.tblHesabType as h on h.fldId=fldHesabTypeParam	LEFT OUTER JOIN
                      Pay.tblParameteriItemsFormul ON Pay.tblParametrs.fldId = Pay.tblParameteriItemsFormul.fldParametrId LEFT OUTER JOIN
                      Com.tblTypeEstekhdam ON Pay.tblParametrs.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId
					  where  fldActive=1 and (fldPrivate=1  or tblParametrs.fldOrganId=@Value2 )
	order by Pay.tblParametrs.fldId desc
	COMMIT
GO
