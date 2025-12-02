SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Pay].[spr_Pay_RptFishHoghoghi_Motalebat_Moavaghe_Details]
@fldPersonalId INT,
@NobatPardakht INT,
@Year INT,
@Month INT
,@userId int,
@dHesabType int,
@CalcType TINYINT=1
 as
--declare @fldPersonalId int = 563,
--		@NobatPardakht int= 1,
--		@Year int = 1401,
--		@Month int = 1,
--@userId int=1 
BEGIN TRAN
declare @MonthPre int=com.fn_GetPreviousMonth(@Year,@Month) 
select * from (
select  e.fldItemsHoghughiId,e.fldTitle,i.fldMablagh,fldMashmolBime,fldMashmolMaliyat,fldPersonalId,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,p.fldHokmId,1 fldtype,1 as fldCalcType
,case when i.fldMaliyatMashmool= 1 then N'هست' when i.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when i.fldBimeMashmool= 1 then N'هست' when i.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,isnull(h.fldMablagh,0) as fldMablaghHokm
from Pay.tblMohasebat as m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
inner join pay.tblMohasebat_Items as i on i.fldMohasebatId=m.fldId
inner join com.tblItems_Estekhdam as e on i.fldItemEstekhdamId=e.fldId
left join prs.tblHokm_Item as h on h.fldPersonalHokmId=p.fldHokmId and h.fldItems_EstekhdamId=i.fldItemEstekhdamId
where fldHesabTypeItemId= @dHesabType  and fldPersonalId=@fldPersonalId and fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht  
and fldItemsHoghughiId not in (67,68) and fldCalcType=@CalcType
union all
select  e.fldItemsHoghughiId,e.fldTitle+ a.fldNameMonasebat+'('+t.fldTypeName+')',i.fldMablagh,fldMashmolBime,fldMashmolMaliyat,fldPersonalId
,fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,fldYear,m.fldMonth,fldKarkard,p.fldHokmId,1 fldtype,1 as fldCalcType
,case when i.fldMaliyatMashmool= 1 then N'هست' when i.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when i.fldBimeMashmool= 1 then N'هست' when i.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,isnull(h.fldMablagh,0) as fldMablaghHokm
from Pay.tblMohasebat as m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
inner join pay.tblMohasebat_Items as i on i.fldMohasebatId=m.fldId
inner join com.tblItems_Estekhdam as e on i.fldItemEstekhdamId=e.fldId
inner join pay.tblMonasebatMablagh as m2 on m2.fldId=i.fldSourceId 
inner join pay.tblTypeNesbat as t on t.fldId=m2.fldTypeNesbatId 
inner join pay.tblMonasebat as a on a.fldid=m2.fldMonasebatId 
left join prs.tblHokm_Item as h on h.fldPersonalHokmId=p.fldHokmId and h.fldItems_EstekhdamId=i.fldItemEstekhdamId
where fldHesabTypeItemId= @dHesabType  and fldPersonalId=@fldPersonalId and fldYear=@Year AND m.fldMonth=@Month AND fldNobatPardakht=@NobatPardakht  
and fldItemsHoghughiId=67 and fldCalcType=@CalcType
union all
select  e.fldItemsHoghughiId,e.fldTitle+'('+
CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END+')',i.fldMablagh,fldMashmolBime,fldMashmolMaliyat,m.fldPersonalId,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,p.fldHokmId,1 fldtype,1 as fldCalcType
,case when i.fldMaliyatMashmool= 1 then N'هست' when i.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when i.fldBimeMashmool= 1 then N'هست' when i.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,isnull(h.fldMablagh,0) as fldMablaghHokm
from Pay.tblMohasebat as m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
inner join pay.tblMohasebat_Items as i on i.fldMohasebatId=m.fldId
inner join com.tblItems_Estekhdam as e on i.fldItemEstekhdamId=e.fldId
inner join prs.tblAfradTahtePooshesh as a on a.fldId=i.fldSourceId
left join prs.tblHokm_Item as h on h.fldPersonalHokmId=p.fldHokmId and h.fldItems_EstekhdamId=i.fldItemEstekhdamId
where fldHesabTypeItemId= @dHesabType  and m.fldPersonalId=@fldPersonalId and fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht  
and fldItemsHoghughiId=68 and fldCalcType=@CalcType
union all
SELECT     0 as fldItemsHoghughiId,N'بیمه عمر کارفرما' AS fldTitle,m.fldBimeOmrKarFarma,m.fldMashmolBime,fldMashmolMaliyat,fldPersonalId,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,p.fldHokmId,2 fldtype,1 as fldCalcType
,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
FROM         Pay.tblMohasebat m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
 where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht  
  and fldCalcType=@CalcType
 union all
SELECT    0 as fldItemsHoghughiId, N'بیمه تکمیلی کارفرما' AS fldTitle,  m.fldBimeTakmilyKarFarma,fldMashmolBime,fldMashmolMaliyat,fldPersonalId,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,p.fldHokmId,3 fldtype,1 as fldCalcType
,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm	
	FROM         Pay.tblMohasebat m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
 where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht 
  and fldCalcType=@CalcType
union all
select  0 as fldItemsHoghughiId,N'حق درمان کارفرما' AS fldTitle,sum(fldMablagh),fldMashmolBime,fldMashmolMaliyat,fldPersonalId,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,fldHokmId,4 fldtype ,1 as fldCalcType
,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
from(
select fldHaghDarmanKarfFarma as fldMablagh,fldMashmolBime,fldMashmolMaliyat,fldPersonalId,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,p.fldHokmId 
FROM         Pay.tblMohasebat m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht 
  and fldCalcType=@CalcType
union all
select fldHaghDarmanDolat,fldMashmolBime,fldMashmolMaliyat,fldPersonalId,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,p.fldHokmId 
FROM         Pay.tblMohasebat  m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht 
  and fldCalcType=@CalcType
)as g
 group by fldMashmolBime,fldMashmolMaliyat, fldYearPardakht,fldMonthPardakht,fldYear,fldMonth,fldKarkard,fldHokmId,fldPersonalId
 
union all
        SELECT     0 as fldItemsHoghughiId,N'پس انداز کارفرما' AS fldTitle, m.fldPasAndaz/2 ,fldMashmolBime,fldMashmolMaliyat,fldPersonalId,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,p.fldHokmId,5 fldtype,1 as fldCalcType
	,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
	FROM         Pay.tblMohasebat  m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
                     where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht 
  and fldCalcType=@CalcType
union all
SELECT      0 as fldItemsHoghughiId,Pay.tblParametrs.fldTitle collate Persian_100_CI_AI,[Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh,fldMashmolBime,fldMashmolMaliyat,tblMohasebat.fldPersonalId,fldYear as fldYearPardakht,fldMonth as fldMonthPardakht,fldYear,fldMonth,fldKarkard,p.fldHokmId,6 fldtype,1 as fldCalcType
, case when tblMotalebateParametri_Personal.fldMashmoleMaliyat= 1 then N'هست' else N'نیست' end as  fldMaliyatMashmool, case when tblMotalebateParametri_Personal.fldMashmoleBime= 1 then N'هست' else N'نیست' end as   fldBimeMashmool,0 as fldMablaghHokm
FROM         Pay.tblMohasebat  
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=tblMohasebat.fldId INNER JOIN
                      [Pay].[tblMohasebat_kosorat/MotalebatParam] ON Pay.tblMohasebat.fldId = [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId INNER JOIN
                      Pay.tblMotalebateParametri_Personal ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId = Pay.tblMotalebateParametri_Personal.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId
where   tblMohasebat.fldPersonalId=@fldPersonalId and fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht  AND 
                      ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId IS NOT NULL)
				  and [tblMohasebat_kosorat/MotalebatParam].fldHesabTypeParamId=@dHesabType
  and fldCalcType=@CalcType
union all
SELECT  i.fldItemsHoghughiId,i.fldTitle+N'_معوقه',  (Pay.tblMoavaghat_Items.fldMablagh) AS Expr1,tblMoavaghat.fldMashmolBime,tblMoavaghat.fldMashmolMaliyat,m.fldPersonalId,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,tblMoavaghat.fldyear,tblMoavaghat.fldmonth,mm.fldKarkard,tblMoavaghat.fldHokmId,7 fldtype,2 as fldCalcType
,case when tblMoavaghat_Items.fldMaliyatMashmool= 1 then N'هست' when tblMoavaghat_Items.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when tblMoavaghat_Items.fldBimeMashmool= 1 then N'هست' when tblMoavaghat_Items.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,isnull(h.fldMablagh,0) as fldMablaghHokm
FROM         Pay.tblMoavaghat_Items INNER JOIN
                      Pay.tblMoavaghat ON Pay.tblMoavaghat_Items.fldMoavaghatId = Pay.tblMoavaghat.fldId INNER JOIN
                      Pay.tblMohasebat AS m ON Pay.tblMoavaghat.fldMohasebatId = m.fldId  inner join
					  com.tblItems_Estekhdam as i on i.fldId=fldItemEstekhdamId 				
					left join prs.tblHokm_Item as h on h.fldPersonalHokmId=tblMoavaghat.fldHokmId and h.fldItems_EstekhdamId=tblMoavaghat_Items.fldItemEstekhdamId
					  cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=tblMoavaghat.fldYear and mm.fldMonth=tblMoavaghat.fldMonth    and fldCalcType=1)mm
                      WHERE  fldHesabTypeItemId= @dHesabType  and fldPersonalId=@fldPersonalId and tblMoavaghat.fldYear=@Year AND tblMoavaghat.fldMonth=@Month 
					  and Pay.tblMoavaghat_Items.fldMablagh>0  and fldItemsHoghughiId not in (67,68)
					    and fldCalcType=1

					  union all
SELECT  i.fldItemsHoghughiId,i.fldTitle+ a.fldNameMonasebat+'('+t.fldTypeName+')'+N'_معوقه',  (Pay.tblMoavaghat_Items.fldMablagh) AS Expr1,tblMoavaghat.fldMashmolBime,tblMoavaghat.fldMashmolMaliyat,m.fldPersonalId,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,tblMoavaghat.fldyear,tblMoavaghat.fldmonth,mm.fldKarkard,tblMoavaghat.fldHokmId,7 fldtype,2 as fldCalcType
,case when tblMoavaghat_Items.fldMaliyatMashmool= 1 then N'هست' when tblMoavaghat_Items.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when tblMoavaghat_Items.fldBimeMashmool= 1 then N'هست' when tblMoavaghat_Items.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,isnull(h.fldMablagh,0) as fldMablaghHokm
FROM         Pay.tblMoavaghat_Items INNER JOIN
                      Pay.tblMoavaghat ON Pay.tblMoavaghat_Items.fldMoavaghatId = Pay.tblMoavaghat.fldId INNER JOIN
                      Pay.tblMohasebat AS m ON Pay.tblMoavaghat.fldMohasebatId = m.fldId  inner join
					  com.tblItems_Estekhdam as i on i.fldId=fldItemEstekhdamId  inner join
					  pay.tblMonasebatMablagh as m2 on m2.fldId=tblMoavaghat_Items.fldSourceId inner join
					  pay.tblTypeNesbat as t on t.fldId=m2.fldTypeNesbatId inner join
					  pay.tblMonasebat as a on a.fldid=m2.fldMonasebatId 					
					left join prs.tblHokm_Item as h on h.fldPersonalHokmId=tblMoavaghat.fldHokmId and h.fldItems_EstekhdamId=tblMoavaghat_Items.fldItemEstekhdamId
					  cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=tblMoavaghat.fldYear and mm.fldMonth=tblMoavaghat.fldMonth   
					  and fldCalcType=1)mm
                      WHERE  fldHesabTypeItemId= @dHesabType  and fldPersonalId=@fldPersonalId and tblMoavaghat.fldYear=@Year AND tblMoavaghat.fldMonth=@Month 
					  and Pay.tblMoavaghat_Items.fldMablagh>0   and fldItemsHoghughiId=67  and fldCalcType=1


union all
SELECT  i.fldItemsHoghughiId,i.fldTitle+N'_معوقه',  (Pay.tblMoavaghat_Items.fldMablagh) AS Expr1,tblMoavaghat.fldMashmolBime,tblMoavaghat.fldMashmolMaliyat,m.fldPersonalId,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,tblMoavaghat.fldyear,tblMoavaghat.fldmonth,mm.fldKarkard,tblMoavaghat.fldHokmId,7 fldtype,2 as fldCalcType
,case when tblMoavaghat_Items.fldMaliyatMashmool= 1 then N'هست' when tblMoavaghat_Items.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when tblMoavaghat_Items.fldBimeMashmool= 1 then N'هست' when tblMoavaghat_Items.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,isnull(h.fldMablagh,0) as fldMablaghHokm
FROM         Pay.tblMoavaghat_Items INNER JOIN
                      Pay.tblMoavaghat ON Pay.tblMoavaghat_Items.fldMoavaghatId = Pay.tblMoavaghat.fldId INNER JOIN
                      Pay.tblMohasebat AS m ON Pay.tblMoavaghat.fldMohasebatId = m.fldId  inner join
					  com.tblItems_Estekhdam as i on i.fldId=fldItemEstekhdamId 	inner join					  
					  prs.tblAfradTahtePooshesh as a on a.fldId=tblMoavaghat_Items.fldSourceId					
					left join prs.tblHokm_Item as h on h.fldPersonalHokmId=tblMoavaghat.fldHokmId and h.fldItems_EstekhdamId=tblMoavaghat_Items.fldItemEstekhdamId
					  cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=tblMoavaghat.fldYear and mm.fldMonth=tblMoavaghat.fldMonth 
					    and fldCalcType=1)mm
                      WHERE  fldHesabTypeItemId= @dHesabType  and m.fldPersonalId=@fldPersonalId and tblMoavaghat.fldYear=@Year AND tblMoavaghat.fldMonth=@Month 
					  and Pay.tblMoavaghat_Items.fldMablagh>0   and fldItemsHoghughiId=68  and fldCalcType=1

union all
		select 0 as fldItemsHoghughiId, N'حق درمان کارفرما_معوقه' AS fldTitle,(fldMablagh),fldMashmolBime,fldMashmolMaliyat,fldPersonalId, fldYearPardakht, fldMonthPardakht,fldYear,fldMonth,fldKarkard,fldHokmId,8 fldtype,2 as fldCalcType
		,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
		from(
		
		SELECT    (o.fldHaghDarmanKarfFarma) as fldMablagh,o.fldMashmolBime,o.fldMashmolMaliyat,fldPersonalId,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht ,o.fldyear,o.fldmonth,o.fldHokmId,mm.fldKarkard
		FROM pay.tblMohasebat as m
		inner join Pay.tblMoavaghat as o on m.fldId=o.fldMohasebatId 
		cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=o.fldYear and mm.fldMonth=o.fldMonth   and fldCalcType=1 )mm
		WHERE   @dHesabType<>1 and fldPersonalId=@fldPersonalId and o.fldYear=@Year AND o.fldMonth=@Month  
					  and o.fldHaghDarmanKarfFarma>0    and fldCalcType=1

		union all
		SELECT    (o.fldHaghDarmanDolat) as fldMablagh,o.fldMashmolBime,o.fldMashmolMaliyat,fldPersonalId,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,o.fldyear,o.fldmonth,o.fldHokmId,mm.fldKarkard 
		FROM pay.tblMohasebat as m
		inner join Pay.tblMoavaghat as o on m.fldId=o.fldMohasebatId 
		cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=o.fldYear and mm.fldMonth=o.fldMonth    and fldCalcType=1)mm
		WHERE   @dHesabType<>1 and fldPersonalId=@fldPersonalId and  o.fldYear=@Year AND o.fldMonth=@Month   
					  and o.fldHaghDarmanKarfFarma>0     and fldCalcType=1
		)as g
union all
        SELECT     0 as fldItemsHoghughiId,N'پس انداز کارفرما_معوقه' AS fldTitle, o.fldPasAndaz/2 ,o.fldMashmolBime,o.fldMashmolMaliyat,fldPersonalId,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,o.fldYear,o.fldMonth,mm.fldKarkard,o.fldHokmId,10 fldtype,2 as fldCalcType
	,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,0 as fldMablaghHokm
	FROM         Pay.tblMohasebat as m
         inner join Pay.tblMoavaghat as o on m.fldId=o.fldMohasebatId 
		cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=o.fldYear and mm.fldMonth=o.fldMonth    and fldCalcType=1)mm
		WHERE   @dHesabType<>1 and fldPersonalId=@fldPersonalId and  o.fldYear=@Year AND o.fldMonth=@Month 	   
		and fldCalcType=1
----------------------------------------------متمم
union all
SELECT  i.fldItemsHoghughiId,i.fldTitle+N'_معوقه متمم ماه قبل',  (o.fldMablagh) AS Expr1,m.fldMashmolBime,m.fldMashmolMaliyat,fldPersonalId,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,m.fldyear,m.fldmonth,mm.fldKarkard,p.fldHokmId,11 fldtype,3 as fldCalcType
,case when o.fldMaliyatMashmool= 1 then N'هست' when o.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when o.fldBimeMashmool= 1 then N'هست' when o.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,isnull(h.fldMablagh,0) as fldMablaghHokm
FROM         Pay.tblMohasebat_ItemMotamam as o INNER JOIN
                      Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId  inner join
					  com.tblItems_Estekhdam as i on i.fldId=fldItemEstekhdamId	  inner join
					  pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId = m.fldId			
					left join prs.tblHokm_Item as h on h.fldPersonalHokmId=p.fldHokmId and h.fldItems_EstekhdamId=o.fldItemEstekhdamId
					  cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=m.fldYear and mm.fldMonth=m.fldMonth  and mm.fldCalcType=2 )mm
                      WHERE  fldHesabTypeItemId=@dHesabType and  m.fldPersonalId=@fldPersonalId and m.fldYear*100+m.fldMonth=@MonthPre 
					  and o.fldMablagh<0  and fldItemsHoghughiId not in (67,68)
union all
SELECT     tblItems_Estekhdam.fldItemsHoghughiId,Com.tblItems_Estekhdam.fldTitle+ a.fldNameMonasebat+'('+t.fldTypeName+')' +N'_معوقه متمم ماه قبل'AS fldTitle,( o.fldMablagh),m.fldMashmolBime,m.fldMashmolMaliyat,fldPersonalId,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,m.fldyear,m.fldmonth,mm.fldKarkard,p.fldHokmId,12 fldtype,3 as fldCalcType
,case when o.fldMaliyatMashmool= 1 then N'هست' when o.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when o.fldBimeMashmool= 1 then N'هست' when o.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,(isnull(h.fldMablagh,0)) as fldMablaghHokm
FROM         Pay.tblMohasebat_ItemMotamam as o INNER JOIN
                      Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId inner join
					  pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId = m.fldId	 inner join
                      Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId inner join
					  pay.tblMonasebatMablagh as m2 on m2.fldId=o.fldSourceId inner join
					  pay.tblTypeNesbat as t on t.fldId=m2.fldTypeNesbatId inner join
					  pay.tblMonasebat as a on a.fldid=m2.fldMonasebatId 
					  left join prs.tblHokm_Item as h on h.fldPersonalHokmId=p.fldHokmId and h.fldItems_EstekhdamId=o.fldItemEstekhdamId
                      cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=m.fldYear and mm.fldMonth=m.fldMonth and mm.fldCalcType=2 )mm
					  WHERE  fldHesabTypeItemId=@dHesabType and  m.fldPersonalId=@fldPersonalId and m.fldYear*100+m.fldMonth=@MonthPre 
 
					  and o.fldMablagh<0 and fldItemsHoghughiId=67  

	union all
SELECT     tblItems_Estekhdam.fldItemsHoghughiId,tblItems_Estekhdam.fldTitle +'('+
CASE WHEN fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END
+')' +N'_معوقه متمم ماه قبل'AS fldTitle,( o.fldMablagh),m.fldMashmolBime,m.fldMashmolMaliyat,m.fldPersonalId,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,m.fldyear,m.fldmonth,mm.fldKarkard,p.fldHokmId,13 fldtype,3 as fldCalcType
,case when o.fldMaliyatMashmool= 1 then N'هست' when o.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
,case when o.fldBimeMashmool= 1 then N'هست' when o.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
,(isnull(h.fldMablagh,0)) as fldMablaghHokm
FROM        Pay.tblMohasebat_ItemMotamam as o  INNER JOIN
                      Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId  inner join
					  pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId = m.fldId	 inner join
                      Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId inner join					  
					  prs.tblAfradTahtePooshesh as a on a.fldId=o.fldSourceId
					  left join prs.tblHokm_Item as h on h.fldPersonalHokmId=p.fldHokmId and h.fldItems_EstekhdamId=o.fldItemEstekhdamId
                     cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=m.fldYear and mm.fldMonth=m.fldMonth and mm.fldCalcType=2 )mm
					   WHERE  fldHesabTypeItemId=@dHesabType and  m.fldPersonalId=@fldPersonalId and  m.fldYear*100+m.fldMonth=@MonthPre 
					   
					  and o.fldMablagh<0 and fldItemsHoghughiId=68
 )t2 
 where fldMablagh<>0 and exists (select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														inner join pay.pay_tblPersonalInfo p on p.fldPrs_PersonalInfoId=fldPrsPersonalInfoId
														where p.fldid=t2.fldPersonalId
														order by fldTarikh desc)history
														where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
														group by  t.fldTypeEstekhamId)
													
order by fldYearPardakht*100+fldMonthPardakht ,fldtype ,fldYear*100+fldMonth desc



 COMMIT
GO
