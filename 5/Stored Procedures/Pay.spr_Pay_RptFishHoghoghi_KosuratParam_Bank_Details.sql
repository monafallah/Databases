SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptFishHoghoghi_KosuratParam_Bank_Details]
@fldPersonalId INT,
@NobatPardakht INT,
@AzYear INT,
@TaYear INT
,@userId int,
@dHesabType int,
@CalcType TINYINT=1
 as
--declare @fldPersonalId int = 469,
--		@NobatPardakht int= 1,
--		@AzYear int = 140405,
--		@TaYear int = 140405,
--@userId int=1 ,
--@dHesabType int=2,
--@CalcType TINYINT=1
BEGIN TRAN
declare @AzYearp smallint =substring( cast(@AzYear as varchar(10)),1,4),@AzMonthP tinyint=substring( cast(@AzYear as varchar(10)),5,2),
		@TaYearp smallint = substring( cast(@TaYear  as varchar(10)),1,4),@TaMonthP tinyint=substring( cast(@TaYear  as varchar(10)),5,2)

select * from(
        SELECT    0 as fldItemsHoghughiId, CASE WHEN (Pay.tblMohasebat_PersonalInfo.fldTypeBimeId = 1) THEN N'حق بیمه' ELSE N'حق بازنشستگی' END AS fldTitle,
         Pay.tblMohasebat.fldBimePersonal  as fldMablagh
        ,Pay.tblMohasebat.fldPersonalId,fldMashmolBime,fldMashmolMaliyat,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,fldHokmId,1 fldtype,1 as fldCalcType
		,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
where @dHesabType<>1 and fldPersonalId=@fldPersonalId and fldYear*100+fldMonth>=@AzYear AND fldYear*100+fldMonth<=@TaYear AND fldNobatPardakht=@NobatPardakht 
 and fldCalcType=@CalcType
union all
select  e.fldItemsHoghughiId,e.fldTitle,abs(i.fldMablagh)fldMablagh,m.fldPersonalId,fldMashmolBime,fldMashmolMaliyat,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,p.fldHokmId,1 fldtype,1 as fldCalcType
,case when i.fldMaliyatMashmool= 1 then N'هست' when i.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when i.fldBimeMashmool= 1 then N'هست' when i.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,isnull(h.fldMablagh,0) as fldMablaghHokm
from Pay.tblMohasebat as m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
inner join pay.tblMohasebat_Items as i on i.fldMohasebatId=m.fldId
inner join com.tblItems_Estekhdam as e on i.fldItemEstekhdamId=e.fldId
left join prs.tblHokm_Item as h on h.fldPersonalHokmId=p.fldHokmId and h.fldItems_EstekhdamId=i.fldItemEstekhdamId
where   fldPersonalId=@fldPersonalId and fldYear*100+fldMonth>=@AzYear AND fldYear*100+fldMonth<=@TaYear AND fldNobatPardakht=@NobatPardakht  
and fldItemsHoghughiId =76 and fldCalcType=@CalcType
union all
        SELECT     0 as fldItemsHoghughiId,N'مالیات' AS fldTitle, Pay.tblMohasebat.fldMaliyat
				,Pay.tblMohasebat.fldPersonalId,fldMashmolBime,fldMashmolMaliyat,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,fldHokmId,2 fldtype,1 as fldCalcType
	,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
	FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
                     where @dHesabType<>1 and  fldPersonalId=@fldPersonalId and fldYear*100+fldMonth>=@AzYear 
					 AND fldYear*100+fldMonth<=@TaYear AND fldNobatPardakht=@NobatPardakht  and fldCalcType=@CalcType
union all
 SELECT    0 as fldItemsHoghughiId, N'مالیات منفی' AS fldTitle, fldMablagh 
		,Pay.tblMohasebat.fldPersonalId,fldMashmolBime,fldMashmolMaliyat,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,tblP_MaliyatManfi.fldSal as fldYear,tblP_MaliyatManfi.fldMah as fldMonth,fldKarkard,fldHokmId,3 fldtype,1 as fldCalcType
	,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
	FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId inner join
					  Pay.tblP_MaliyatManfi on fldMohasebeId=Pay.tblMohasebat.fldId
                     where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and fldYear*100+fldMonth>=@AzYear 
					 AND fldYear*100+fldMonth<=@TaYear AND fldNobatPardakht=@NobatPardakht  and fldCalcType=@CalcType
union all

        SELECT     0 as fldItemsHoghughiId,N'حق درمان' AS fldTitle,Pay.tblMohasebat.fldHaghDarman
		,Pay.tblMohasebat.fldPersonalId,fldMashmolBime,fldMashmolMaliyat,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,fldHokmId,4 fldtype,1 as fldCalcType
	,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
	FROM         Pay.tblMohasebat  INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
       where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and fldYear*100+fldMonth>=@AzYear 
	   AND fldYear*100+fldMonth<=@TaYear AND fldNobatPardakht=@NobatPardakht  and fldCalcType=@CalcType
        
union all

        SELECT     0 as fldItemsHoghughiId,N'بیمه عمر' AS fldTitle,Pay.tblMohasebat.fldBimeOmr,Pay.tblMohasebat.fldPersonalId,fldMashmolBime,fldMashmolMaliyat,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,fldHokmId,5 fldtype,1 as fldCalcType
	,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
	FROM         Pay.tblMohasebat  INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
                      where @dHesabType<>1 and  fldPersonalId=@fldPersonalId and fldYear*100+fldMonth>=@AzYear 
					  AND fldYear*100+fldMonth<=@TaYear AND fldNobatPardakht=@NobatPardakht  and fldCalcType=@CalcType
union all

        SELECT     0 as fldItemsHoghughiId,N'بیمه تکمیلی' AS fldTitle,Pay.tblMohasebat.fldBimeTakmily,Pay.tblMohasebat.fldPersonalId,fldMashmolBime,fldMashmolMaliyat,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,fldHokmId,6 fldtype,1 as fldCalcType
	,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
	FROM         Pay.tblMohasebat  INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
                      where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and fldYear*100+fldMonth>=@AzYear 
					  AND fldYear*100+fldMonth<=@TaYear AND fldNobatPardakht=@NobatPardakht  and fldCalcType=@CalcType
                    
union all

        SELECT     0 as fldItemsHoghughiId,N'مساعده' AS fldTitle,  Pay.tblMohasebat.fldMosaede,Pay.tblMohasebat.fldPersonalId,fldMashmolBime,fldMashmolMaliyat,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,fldHokmId,7 fldtype,1 as fldCalcType
	,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
	FROM         Pay.tblMohasebat  INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
                      where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and fldYear*100+fldMonth>=@AzYear 
					  AND fldYear*100+fldMonth<=@TaYear AND fldNobatPardakht=@NobatPardakht  and fldCalcType=@CalcType
union all

        SELECT     0 as fldItemsHoghughiId,N'قسط وام' AS fldTitle, Pay.tblMohasebat.fldGhestVam,Pay.tblMohasebat.fldPersonalId,fldMashmolBime,fldMashmolMaliyat,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,fldHokmId,8 fldtype,1 as fldCalcType
	,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
	FROM         Pay.tblMohasebat  INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
                      where @dHesabType<>1 and  fldPersonalId=@fldPersonalId and fldYear*100+fldMonth>=@AzYear 
					  AND fldYear*100+fldMonth<=@TaYear AND fldNobatPardakht=@NobatPardakht  and fldCalcType=@CalcType

union all

        SELECT    0 as fldItemsHoghughiId, N' پس انداز' AS fldTitle, Pay.tblMohasebat.fldPasAndaz
		,Pay.tblMohasebat.fldPersonalId,fldMashmolBime,fldMashmolMaliyat,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,fldHokmId,9 fldtype,1 as fldCalcType
	,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
	FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
                      where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and fldYear*100+fldMonth>=@AzYear 
					  AND fldYear*100+fldMonth<=@TaYear AND fldNobatPardakht=@NobatPardakht  and fldCalcType=@CalcType

union all

        SELECT     0 as fldItemsHoghughiId,N'مقرری ماه اول' AS fldTitle, Pay.tblMohasebat.fldMogharari,Pay.tblMohasebat.fldPersonalId,fldMashmolBime,fldMashmolMaliyat,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,fldHokmId,10 fldtype,1 as fldCalcType
	,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
	FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
                      where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and fldYear*100+fldMonth>=@AzYear 
					  AND fldYear*100+fldMonth<=@TaYear AND fldNobatPardakht=@NobatPardakht  and fldCalcType=@CalcType
union all

    --SELECT     Pay.tblParametrs.fldTitle,(case when fldMondeFish=1 then N'('+ cast(fldMondeGHabl-SUM([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh) over (partition by fldParametrId ) As nvarchar(200))+')' else  [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh end),Pay.tblMohasebat.fldPersonalId
SELECT     0 as fldItemsHoghughiId,Pay.tblParametrs.fldTitle collate Persian_100_CI_AI/*+dbo.func_MandeOrJam(fldkosoratid)*/,[Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh,Pay.tblMohasebat.fldPersonalId
,fldMashmolBime,fldMashmolMaliyat,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,fldHokmId,11 fldtype,1 as fldCalcType
,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
FROM         [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                      Pay.tblKosorateParametri_Personal ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldKosoratId = Pay.tblKosorateParametri_Personal.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Pay.tblMohasebat ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
                      where   tblMohasebat.fldPersonalId=@fldPersonalId and fldYear*100+fldMonth>=@AzYear 
					  AND fldYear*100+fldMonth<=@TaYear AND fldNobatPardakht=@NobatPardakht  AND fldKosoratId IS NOT NULL
					  and [tblMohasebat_kosorat/MotalebatParam].fldHesabTypeParamId=@dHesabType and fldCalcType=@CalcType
union all

      SELECT     0 as fldItemsHoghughiId,tblBank.fldBankName + N' شعبه ' + tblSHobe.fldName AS Expr1, Pay.tblMohasebat_KosoratBank.fldMablagh,Pay.tblMohasebat.fldPersonalId
	  ,fldMashmolBime,fldMashmolMaliyat,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,fldHokmId,12 fldtype,1 as fldCalcType
	  ,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
FROM         Pay.tblMohasebat_KosoratBank INNER JOIN
                      Pay.tblKosuratBank ON Pay.tblMohasebat_KosoratBank.fldKosoratBankId = Pay.tblKosuratBank.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank AS tblBank ON tblSHobe.fldBankId = tblBank.fldId INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMohasebat_KosoratBank.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
                       where  @dHesabType<>1 and tblMohasebat.fldPersonalId=@fldPersonalId and fldYear*100+fldMonth>=@AzYear 
					   AND fldYear*100+fldMonth<=@TaYear AND fldNobatPardakht=@NobatPardakht  and fldCalcType=@CalcType
union all
SELECT  i.fldItemsHoghughiId,i.fldTitle+N'_معوقه',  (Pay.tblMoavaghat_Items.fldMablagh) AS Expr1,fldPersonalId,tblMoavaghat.fldMashmolBime,tblMoavaghat.fldMashmolMaliyat,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,tblMoavaghat.fldyear,tblMoavaghat.fldmonth,mm.fldKarkard,tblMoavaghat.fldHokmId,13 fldtype,2 as fldCalcType
,case when tblMoavaghat_Items.fldMaliyatMashmool= 1 then N'هست' when tblMoavaghat_Items.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when tblMoavaghat_Items.fldBimeMashmool= 1 then N'هست' when tblMoavaghat_Items.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,isnull(h.fldMablagh,0) as fldMablaghHokm
FROM         Pay.tblMoavaghat_Items INNER JOIN
                      Pay.tblMoavaghat ON Pay.tblMoavaghat_Items.fldMoavaghatId = Pay.tblMoavaghat.fldId INNER JOIN
                      Pay.tblMohasebat AS m ON Pay.tblMoavaghat.fldMohasebatId = m.fldId  inner join
					  com.tblItems_Estekhdam as i on i.fldId=fldItemEstekhdamId				
					left join prs.tblHokm_Item as h on h.fldPersonalHokmId=tblMoavaghat.fldHokmId and h.fldItems_EstekhdamId=tblMoavaghat_Items.fldItemEstekhdamId
					  cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=tblMoavaghat.fldYear and mm.fldMonth=tblMoavaghat.fldMonth   and fldCalcType=@CalcType)mm
                      WHERE tblMoavaghat_Items.fldHesabTypeItemId= @dHesabType  and  fldPersonalId=@fldPersonalId 
					  and m.fldYear*100+m.fldMonth>=@AzYear AND m.fldYear*100+m.fldMonth<=@TaYear 
					  AND fldNobatPardakht=@NobatPardakht    and fldCalcType=@CalcType
					  and Pay.tblMoavaghat_Items.fldMablagh<0 and fldItemsHoghughiId not in (67,68 )

 union all
SELECT     tblItems_Estekhdam.fldItemsHoghughiId,Com.tblItems_Estekhdam.fldTitle+ a.fldNameMonasebat+'('+t.fldTypeName+')' +N'_معوقه'AS fldTitle,( Pay.tblMoavaghat_Items.fldMablagh),fldPersonalId,tblMoavaghat.fldMashmolBime,tblMoavaghat.fldMashmolMaliyat,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,tblMoavaghat.fldyear,tblMoavaghat.fldmonth,mm.fldKarkard,tblMoavaghat.fldHokmId,13 fldtype,2 as fldCalcType
,case when tblMoavaghat_Items.fldMaliyatMashmool= 1 then N'هست' when tblMoavaghat_Items.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when tblMoavaghat_Items.fldBimeMashmool= 1 then N'هست' when tblMoavaghat_Items.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,(isnull(h.fldMablagh,0)) as fldMablaghHokm
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat.fldMohasebatId INNER JOIN
                      Pay.tblMohasebat AS m ON Pay.tblMoavaghat.fldMohasebatId = m.fldId  inner join
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId inner join
					  pay.tblMonasebatMablagh as m2 on m2.fldId=tblMoavaghat_Items.fldSourceId inner join
					  pay.tblTypeNesbat as t on t.fldId=m2.fldTypeNesbatId inner join
					  pay.tblMonasebat as a on a.fldid=m2.fldMonasebatId 
					  left join prs.tblHokm_Item as h on h.fldPersonalHokmId=tblMoavaghat.fldHokmId and h.fldItems_EstekhdamId=tblMoavaghat_Items.fldItemEstekhdamId
                      cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=tblMoavaghat.fldYear and mm.fldMonth=tblMoavaghat.fldMonth   and fldCalcType=@CalcType)mm
					  WHERE tblMoavaghat_Items.fldHesabTypeItemId= @dHesabType  and  fldPersonalId=@fldPersonalId 
					  and m.fldYear*100+m.fldMonth>=@AzYear AND m.fldYear*100+m.fldMonth<=@TaYear AND fldNobatPardakht=@NobatPardakht    
					  and fldCalcType=@CalcType
					  and Pay.tblMoavaghat_Items.fldMablagh<0 and fldItemsHoghughiId=67  

	union all
SELECT     tblItems_Estekhdam.fldItemsHoghughiId,tblItems_Estekhdam.fldTitle +'('+
CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END
+')' +N'_معوقه'AS fldTitle,( Pay.tblMoavaghat_Items.fldMablagh),m.fldPersonalId,tblMoavaghat.fldMashmolBime,tblMoavaghat.fldMashmolMaliyat,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,tblMoavaghat.fldyear,tblMoavaghat.fldmonth,mm.fldKarkard,tblMoavaghat.fldHokmId,13 fldtype,2 as fldCalcType
,case when tblMoavaghat_Items.fldMaliyatMashmool= 1 then N'هست' when tblMoavaghat_Items.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when tblMoavaghat_Items.fldBimeMashmool= 1 then N'هست' when tblMoavaghat_Items.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,(isnull(h.fldMablagh,0)) as fldMablaghHokm
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat.fldMohasebatId INNER JOIN
                      Pay.tblMohasebat AS m ON Pay.tblMoavaghat.fldMohasebatId = m.fldId  inner join
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId inner join					  
					  prs.tblAfradTahtePooshesh as a on a.fldId=tblMoavaghat_Items.fldSourceId
					  left join prs.tblHokm_Item as h on h.fldPersonalHokmId=tblMoavaghat.fldHokmId and h.fldItems_EstekhdamId=tblMoavaghat_Items.fldItemEstekhdamId
                      cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=tblMoavaghat.fldYear and mm.fldMonth=tblMoavaghat.fldMonth   and fldCalcType=@CalcType)mm
					  WHERE tblMoavaghat_Items.fldHesabTypeItemId= @dHesabType  and  m.fldPersonalId=@fldPersonalId 
					  and m.fldYear*100+m.fldMonth>=@AzYear AND m.fldYear*100+m.fldMonth<=@TaYear AND fldNobatPardakht=@NobatPardakht   
					  and fldCalcType=@CalcType 
					  and Pay.tblMoavaghat_Items.fldMablagh<0 and fldItemsHoghughiId=68
				  
union all
 SELECT     0 as fldItemsHoghughiId,CASE WHEN (Pay.tblMohasebat_PersonalInfo.fldTypeBimeId = 1) THEN N'حق بیمه_معوقه' ELSE N'حق بازنشستگی_معوقه' END AS fldTitle,
         o.fldBimePersonal  as fldMablagh
        ,m.fldPersonalId,o.fldMashmolBime,o.fldMashmolMaliyat,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,o.fldYear,o.fldMonth,mm.fldKarkard,o.fldHokmId,14 fldtype,2 as fldCalcType
,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
FROM         Pay.tblMoavaghat as o inner join
                      Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId inner join					  
                      Pay.tblMohasebat_PersonalInfo ON m.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
					   cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=o.fldYear and mm.fldMonth=o.fldMonth  and fldCalcType=@CalcType )mm
where @dHesabType<>1 and  fldPersonalId=@fldPersonalId and m.fldYear*100+m.fldMonth>=@AzYear AND m.fldYear*100+m.fldMonth<=@TaYear 
AND fldNobatPardakht=@NobatPardakht  and fldCalcType=@CalcType

union all
   SELECT     0 as fldItemsHoghughiId,N'حق درمان_موقعه' AS fldTitle,
		o.fldHaghDarman
        ,m.fldPersonalId,o.fldMashmolBime,o.fldMashmolMaliyat,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,o.fldYear,o.fldMonth,mm.fldKarkard,o.fldHokmId,15 fldtype,2 as fldCalcType
		,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
FROM         Pay.tblMoavaghat as o inner join
                      Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId 
					   cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=o.fldYear and mm.fldMonth=o.fldMonth  and fldCalcType=@CalcType )mm
where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and m.fldYear*100+m.fldMonth>=@AzYear AND m.fldYear*100+m.fldMonth<=@TaYear 
AND fldNobatPardakht=@NobatPardakht  and fldCalcType=@CalcType
union all
   SELECT     0 as fldItemsHoghughiId,N'مالیات_موقعه' AS fldTitle,
		o.fldMaliyat
        ,m.fldPersonalId,o.fldMashmolBime,o.fldMashmolMaliyat,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,o.fldYear,o.fldMonth,mm.fldKarkard,o.fldHokmId,16 fldtype,2 as fldCalcType
,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
FROM         Pay.tblMoavaghat as o inner join
                      Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId 
					   cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=o.fldYear and mm.fldMonth=o.fldMonth  and fldCalcType=@CalcType )mm
where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and m.fldYear*100+m.fldMonth>=@AzYear AND m.fldYear*100+m.fldMonth<=@TaYear 
AND fldNobatPardakht=@NobatPardakht  and fldCalcType=@CalcType
union all
   SELECT     0 as fldItemsHoghughiId,N'پس انداز_موقعه' AS fldTitle,
		o.fldPasAndaz
        ,m.fldPersonalId,o.fldMashmolBime,o.fldMashmolMaliyat,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,o.fldYear,o.fldMonth,mm.fldKarkard,o.fldHokmId,17 fldtype,2 as fldCalcType
		,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
FROM         Pay.tblMoavaghat as o inner join
                      Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId 
					   cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=o.fldYear and mm.fldMonth=o.fldMonth   and fldCalcType=@CalcType)mm
where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and m.fldYear*100+m.fldMonth>=@AzYear AND m.fldYear*100+m.fldMonth<=@TaYear 
AND fldNobatPardakht=@NobatPardakht  and fldCalcType=@CalcType

-----------------------------------------------------------------متممم
union all
SELECT  i.fldItemsHoghughiId,i.fldTitle+N'_معوقه متمم ماه قبل',  (o.fldMablagh) AS Expr1,m.fldPersonalId,m.fldMashmolBime,m.fldMashmolMaliyat,[Com].[fn_GetNextYear](m.fldYear,m.fldmonth) as fldYearPardakht,[Com].[fn_GetNextMonth](m.fldYear,m.fldmonth) as fldMonthPardakht,m.fldyear,m.fldmonth,mm.fldKarkard,p.fldHokmId,18 fldtype,3 as fldCalcType
,case when o.fldMaliyatMashmool= 1 then N'هست' when o.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when o.fldBimeMashmool= 1 then N'هست' when o.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,isnull(h.fldMablagh,0) as fldMablaghHokm
FROM         Pay.tblMohasebat_ItemMotamam as o INNER JOIN
                      Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId  inner join
					  pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId = m.fldId inner join 	
					  com.tblItems_Estekhdam as i on i.fldId=fldItemEstekhdamId 			
					left join prs.tblHokm_Item as h on h.fldPersonalHokmId=p.fldHokmId and h.fldItems_EstekhdamId=o.fldItemEstekhdamId
					  cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=m.fldYear and mm.fldMonth=m.fldMonth and mm.fldCalcType=2 )mm
                      WHERE   fldHesabTypeItemId= @dHesabType  and   fldPersonalId=@fldPersonalId and m.fldYear*100+m.fldMonth>=com.fn_GetPreviousMonth(@AzYearp,@AzMonthP) AND  m.fldYear*100+m.fldMonth<=com.fn_GetPreviousMonth(@TaYearp,@TaMonthP) AND fldNobatPardakht=@NobatPardakht   
					  and o.fldMablagh<0   and fldItemsHoghughiId not in (67,68)
					  
					  union all
SELECT  i.fldItemsHoghughiId,i.fldTitle+ a.fldNameMonasebat+'('+t.fldTypeName+')'+N'_معوقه متمم ماه قبل',  (o.fldMablagh) AS Expr1,m.fldPersonalId,m.fldMashmolBime,m.fldMashmolMaliyat,[Com].[fn_GetNextYear](m.fldYear,m.fldmonth) as fldYearPardakht,[Com].[fn_GetNextMonth](m.fldYear,m.fldmonth) as fldMonthPardakht,m.fldyear,m.fldmonth,mm.fldKarkard,p.fldHokmId,19 fldtype,3 as fldCalcType
,case when o.fldMaliyatMashmool= 1 then N'هست' when o.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when o.fldBimeMashmool= 1 then N'هست' when o.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,isnull(h.fldMablagh,0) as fldMablaghHokm
FROM         Pay.tblMohasebat_ItemMotamam as o INNER JOIN
                      Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId  inner join
					  pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId = m.fldId inner join 
					  com.tblItems_Estekhdam as i on i.fldId=fldItemEstekhdamId 	 inner join
					  pay.tblMonasebatMablagh as m2 on m2.fldId=o.fldSourceId inner join
					  pay.tblTypeNesbat as t on t.fldId=m2.fldTypeNesbatId inner join
					  pay.tblMonasebat as a on a.fldid=m2.fldMonasebatId 			
					left join prs.tblHokm_Item as h on h.fldPersonalHokmId=p.fldHokmId and h.fldItems_EstekhdamId=o.fldItemEstekhdamId
					  cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=m.fldYear and mm.fldMonth=m.fldMonth  and mm.fldCalcType=2)mm
                      WHERE   fldHesabTypeItemId= @dHesabType  and   fldPersonalId=@fldPersonalId and m.fldYear*100+m.fldMonth>=com.fn_GetPreviousMonth(@AzYearp,@AzMonthP) AND  m.fldYear*100+m.fldMonth<=com.fn_GetPreviousMonth(@TaYearp,@TaMonthP) AND fldNobatPardakht=@NobatPardakht   
					  and o.fldMablagh<0 and fldItemsHoghughiId=67
					  
union all
SELECT  i.fldItemsHoghughiId,i.fldTitle+'('+
CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END
+')'+N'_معوقه متمم ماه قبل',  (o.fldMablagh) AS Expr1,m.fldPersonalId,m.fldMashmolBime,m.fldMashmolMaliyat,[Com].[fn_GetNextYear](m.fldYear,m.fldmonth) as fldYearPardakht,[Com].[fn_GetNextMonth](m.fldYear,m.fldmonth) as fldMonthPardakht,m.fldyear,m.fldmonth,mm.fldKarkard,p.fldHokmId,20 fldtype,3 as fldCalcType
,case when o.fldMaliyatMashmool= 1 then N'هست' when o.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when o.fldBimeMashmool= 1 then N'هست' when o.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,isnull(h.fldMablagh,0) as fldMablaghHokm
FROM         Pay.tblMohasebat_ItemMotamam as o INNER JOIN
                      Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId  inner join
					  com.tblItems_Estekhdam as i on i.fldId=fldItemEstekhdamId  inner join
					  pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId = m.fldId	inner join					  
					  prs.tblAfradTahtePooshesh as a on a.fldId=o.fldSourceId			
					left join prs.tblHokm_Item as h on h.fldPersonalHokmId=p.fldHokmId and h.fldItems_EstekhdamId=o.fldItemEstekhdamId
					  cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=m.fldYear and mm.fldMonth=m.fldMonth  and mm.fldCalcType=2)mm
                      WHERE   fldHesabTypeItemId= @dHesabType  and   m.fldPersonalId=@fldPersonalId and m.fldYear*100+m.fldMonth>=com.fn_GetPreviousMonth(@AzYearp,@AzMonthP) AND  m.fldYear*100+m.fldMonth<=com.fn_GetPreviousMonth(@TaYearp,@TaMonthP) AND fldNobatPardakht=@NobatPardakht   
					  and o.fldMablagh<0 and fldItemsHoghughiId=68 
)t2
WHERE fldMablagh<>0    
and exists (select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														inner join pay.pay_tblPersonalInfo p on p.fldPrs_PersonalInfoId=fldPrsPersonalInfoId
														where p.fldid=t2.fldPersonalId
														order by fldTarikh desc)history
														where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
														group by  t.fldTypeEstekhamId
														)
order by fldYearPardakht*100+fldMonthPardakht ,fldtype ,fldYear*100+fldMonth desc



COMMIT
GO
