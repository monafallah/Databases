SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Pay].[spr_Pay_RptFishHoghoghi_Moavaghe_Details]
@fldPersonalId INT,
@NobatPardakht INT,
@YearPardakht int ,
@MonthPardakht int ,
@Year int ,
@Month int ,
@userId int,
@dHesabType int,
@CalcType TINYINT=1,
@MoavaghType tinyint
 as
--declare @fldPersonalId int = 469,
--		@NobatPardakht int= 1,
--		@YearPardakht int = 1405,
--		@MonthPardakht int = 5,
--		@Year int = 1404,
--		@Month int = 4,
--@userId int=1 ,
--@dHesabType int=2,
--@CalcType TINYINT=1,
--@MoavaghType tinyint=3
BEGIN TRAN
if(@MoavaghType=2)
begin
		select * from(
		SELECT  i.fldTitle+N'_معوقه' as fldTitle,  (Pay.tblMoavaghat_Items.fldMablagh) AS fldMablagh,tblMoavaghat.fldMashmolBime,tblMoavaghat.fldMashmolMaliyat,m.fldPersonalId
		,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,tblMoavaghat.fldyear,tblMoavaghat.fldmonth,mm.fldKarkard,tblMoavaghat.fldHokmId,1 fldtype
		,case when tblMoavaghat_Items.fldMaliyatMashmool= 1 then N'هست' when tblMoavaghat_Items.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
		,case when tblMoavaghat_Items.fldBimeMashmool= 1 then N'هست' when tblMoavaghat_Items.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
		,  fldYearMoavagh, fldMonthMoavagh,fldMashmolBimeMoavaghe,fldMashmolMaliyatMoavaghe, fldMablaghMoavaghe	, fldMaliyatMashmoolMoavaghe, fldBimeMashmoolMoavaghe
		, fldMashmolBimeMahAsli, fldMashmolMaliyatMahAsli, fldMablaghMahAsli, fldMaliyatMashmoolMahAsli, fldBimeMashmoolMahAsli 
		,fldMablaghMahAsli+sum(isnull(fldMablaghMoavaghe,0)) over (partition by i.fldId)+Pay.tblMoavaghat_Items.fldMablagh as fldMablaghNahaee
		FROM         Pay.tblMoavaghat_Items INNER JOIN
							  Pay.tblMoavaghat ON Pay.tblMoavaghat_Items.fldMoavaghatId = Pay.tblMoavaghat.fldId INNER JOIN
							  Pay.tblMohasebat AS m ON Pay.tblMoavaghat.fldMohasebatId = m.fldId  inner join
							  com.tblItems_Estekhdam as i on i.fldId=fldItemEstekhdamId 
							  outer apply(select m2.fldYear as fldYearMoavagh,m2.fldMonth as fldMonthMoavagh,m2.fldMashmolBime,m2.fldMashmolMaliyat
											,o2.fldMashmolBime as fldMashmolBimeMoavaghe,o2.fldMashmolMaliyat as fldMashmolMaliyatMoavaghe,i2.fldMablagh as fldMablaghMoavaghe
											,case when i2.fldMaliyatMashmool= 1 then N'هست' when i2.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmoolMoavaghe
											,case when i2.fldBimeMashmool= 1 then N'هست' when i2.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmoolMoavaghe

											from pay.tblMohasebat as m2 
											inner join pay.tblMoavaghat as o2 on o2.fldMohasebatId=m2.fldId 
											inner join pay.tblMoavaghat_Items as i2 on i2.fldMoavaghatId=o2.fldId 
											inner join com.tblItems_Estekhdam as E2 ON  e2.fldid=i2.fldItemEstekhdamId 
											where i2.fldHesabTypeItemId= @dHesabType  and m2.fldPersonalId=@fldPersonalId and o2.fldYear=@Year AND o2.fldMonth=@Month  
											and m2.fldYear<>@YearPardakht and m2.fldMonth<>@MonthPardakht
											and i.fldItemsHoghughiId=e2.fldItemsHoghughiId and fldCalcType=1)o2
							outer apply(select m3.fldMashmolBime as fldMashmolBimeMahAsli,m3.fldMashmolMaliyat as fldMashmolMaliyatMahAsli
											,i2.fldMablagh as fldMablaghMahAsli 
											,case when i2.fldMaliyatMashmool= 1 then N'هست' when i2.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmoolMahAsli
											,case when i2.fldBimeMashmool= 1 then N'هست' when i2.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmoolMahAsli
											from  Pay.tblMohasebat as m3
									inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m3.fldId
									inner join pay.tblMohasebat_Items as i2 on i2.fldMohasebatId=m3.fldId
									inner join com.tblItems_Estekhdam as e on i2.fldItemEstekhdamId=e.fldId
									where  i2.fldHesabTypeItemId= @dHesabType  and  fldPersonalId=@fldPersonalId and m3.fldYear=@Year 
									AND m3.fldMonth=@Month  and i.fldItemsHoghughiId=e.fldItemsHoghughiId and fldCalcType=1)m3
							  cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=tblMoavaghat.fldYear and mm.fldMonth=tblMoavaghat.fldMonth  
							  and fldCalcType=1)mm
							  WHERE  tblMoavaghat_Items.fldHesabTypeItemId= @dHesabType  and  m.fldPersonalId=@fldPersonalId and m.fldYear=@YearPardakht AND m.fldMonth=@MonthPardakht AND fldNobatPardakht=@NobatPardakht   
							  and tblMoavaghat.fldYear=@Year AND tblMoavaghat.fldMonth=@Month and fldItemsHoghughiId not in (67,68)
							   and fldCalcType=1
		union all
		SELECT  i.fldTitle+ a.fldNameMonasebat+'('+t.fldTypeName+')'+N'_معوقه' as fldTitle,  (Pay.tblMoavaghat_Items.fldMablagh) AS fldMablagh,tblMoavaghat.fldMashmolBime,tblMoavaghat.fldMashmolMaliyat,m.fldPersonalId
		,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,tblMoavaghat.fldyear,tblMoavaghat.fldmonth,mm.fldKarkard,tblMoavaghat.fldHokmId,1 fldtype
		,case when tblMoavaghat_Items.fldMaliyatMashmool= 1 then N'هست' when tblMoavaghat_Items.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
		,case when tblMoavaghat_Items.fldBimeMashmool= 1 then N'هست' when tblMoavaghat_Items.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
		,  fldYearMoavagh, fldMonthMoavagh,fldMashmolBimeMoavaghe,fldMashmolMaliyatMoavaghe, fldMablaghMoavaghe	, fldMaliyatMashmoolMoavaghe, fldBimeMashmoolMoavaghe
		, fldMashmolBimeMahAsli, fldMashmolMaliyatMahAsli, fldMablaghMahAsli, fldMaliyatMashmoolMahAsli, fldBimeMashmoolMahAsli 
		,fldMablaghMahAsli+sum(isnull(fldMablaghMoavaghe,0)) over (partition by i.fldId)+Pay.tblMoavaghat_Items.fldMablagh as fldMablaghNahaee
		FROM         Pay.tblMoavaghat_Items INNER JOIN
							  Pay.tblMoavaghat ON Pay.tblMoavaghat_Items.fldMoavaghatId = Pay.tblMoavaghat.fldId INNER JOIN
							  Pay.tblMohasebat AS m ON Pay.tblMoavaghat.fldMohasebatId = m.fldId  inner join
							  com.tblItems_Estekhdam as i on i.fldId=fldItemEstekhdamId  inner join
							  pay.tblMonasebatMablagh as m2 on m2.fldId=tblMoavaghat_Items.fldSourceId inner join
							  pay.tblTypeNesbat as t on t.fldId=m2.fldTypeNesbatId inner join
							  pay.tblMonasebat as a on a.fldid=m2.fldMonasebatId 
							  outer apply(select m2.fldYear as fldYearMoavagh,m2.fldMonth as fldMonthMoavagh,m2.fldMashmolBime,m2.fldMashmolMaliyat
											,o2.fldMashmolBime as fldMashmolBimeMoavaghe,o2.fldMashmolMaliyat as fldMashmolMaliyatMoavaghe,i2.fldMablagh as fldMablaghMoavaghe
											,case when i2.fldMaliyatMashmool= 1 then N'هست' when i2.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmoolMoavaghe
											,case when i2.fldBimeMashmool= 1 then N'هست' when i2.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmoolMoavaghe

											from pay.tblMohasebat as m2 
											inner join pay.tblMoavaghat as o2 on o2.fldMohasebatId=m2.fldId 
											inner join pay.tblMoavaghat_Items as i2 on i2.fldMoavaghatId=o2.fldId 
											inner join com.tblItems_Estekhdam as E2 ON  e2.fldid=i2.fldItemEstekhdamId 
											where i2.fldHesabTypeItemId= @dHesabType  and m2.fldPersonalId=@fldPersonalId and o2.fldYear=@Year AND o2.fldMonth=@Month  
											and m2.fldYear<>@YearPardakht and m2.fldMonth<>@MonthPardakht
											and i.fldItemsHoghughiId=e2.fldItemsHoghughiId and i2.fldSourceId=tblMoavaghat_Items.fldSourceId
											 and fldCalcType=1)o2
							outer apply(select m3.fldMashmolBime as fldMashmolBimeMahAsli,m3.fldMashmolMaliyat as fldMashmolMaliyatMahAsli
											,i2.fldMablagh as fldMablaghMahAsli 
											,case when i2.fldMaliyatMashmool= 1 then N'هست' when i2.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmoolMahAsli
											,case when i2.fldBimeMashmool= 1 then N'هست' when i2.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmoolMahAsli
											from  Pay.tblMohasebat as m3
									inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m3.fldId
									inner join pay.tblMohasebat_Items as i2 on i2.fldMohasebatId=m3.fldId
									inner join com.tblItems_Estekhdam as e on i2.fldItemEstekhdamId=e.fldId
									where  i2.fldHesabTypeItemId= @dHesabType  and  fldPersonalId=@fldPersonalId and m3.fldYear=@Year AND m3.fldMonth=@Month  
									and i.fldItemsHoghughiId=e.fldItemsHoghughiId and i2.fldSourceId=tblMoavaghat_Items.fldSourceId
									 and fldCalcType=1)m3
							  cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=tblMoavaghat.fldYear and mm.fldMonth=tblMoavaghat.fldMonth
							   and fldCalcType=1 )mm
							  WHERE  tblMoavaghat_Items.fldHesabTypeItemId= @dHesabType  and  m.fldPersonalId=@fldPersonalId and m.fldYear=@YearPardakht AND m.fldMonth=@MonthPardakht AND fldNobatPardakht=@NobatPardakht   
							  and tblMoavaghat.fldYear=@Year AND tblMoavaghat.fldMonth=@Month and fldItemsHoghughiId=67
							   and fldCalcType=1
		union all
		SELECT  i.fldTitle+'('+
		CASE WHEN a.fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END
		+')'+N'_معوقه' as fldTitle,  (Pay.tblMoavaghat_Items.fldMablagh) AS fldMablagh,tblMoavaghat.fldMashmolBime,tblMoavaghat.fldMashmolMaliyat,m.fldPersonalId
		,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,tblMoavaghat.fldyear,tblMoavaghat.fldmonth,mm.fldKarkard,tblMoavaghat.fldHokmId,1 fldtype
		,case when tblMoavaghat_Items.fldMaliyatMashmool= 1 then N'هست' when tblMoavaghat_Items.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
		,case when tblMoavaghat_Items.fldBimeMashmool= 1 then N'هست' when tblMoavaghat_Items.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
		,  fldYearMoavagh, fldMonthMoavagh,fldMashmolBimeMoavaghe,fldMashmolMaliyatMoavaghe, fldMablaghMoavaghe	, fldMaliyatMashmoolMoavaghe, fldBimeMashmoolMoavaghe
		, fldMashmolBimeMahAsli, fldMashmolMaliyatMahAsli, fldMablaghMahAsli, fldMaliyatMashmoolMahAsli, fldBimeMashmoolMahAsli 
		,fldMablaghMahAsli+sum(isnull(fldMablaghMoavaghe,0)) over (partition by i.fldId)+Pay.tblMoavaghat_Items.fldMablagh as fldMablaghNahaee
		FROM         Pay.tblMoavaghat_Items INNER JOIN
							  Pay.tblMoavaghat ON Pay.tblMoavaghat_Items.fldMoavaghatId = Pay.tblMoavaghat.fldId INNER JOIN
							  Pay.tblMohasebat AS m ON Pay.tblMoavaghat.fldMohasebatId = m.fldId  inner join
							  com.tblItems_Estekhdam as i on i.fldId=fldItemEstekhdamId inner join					  
							  prs.tblAfradTahtePooshesh as a on a.fldId=tblMoavaghat_Items.fldSourceId
							  outer apply(select m2.fldYear as fldYearMoavagh,m2.fldMonth as fldMonthMoavagh,m2.fldMashmolBime,m2.fldMashmolMaliyat
											,o2.fldMashmolBime as fldMashmolBimeMoavaghe,o2.fldMashmolMaliyat as fldMashmolMaliyatMoavaghe,i2.fldMablagh as fldMablaghMoavaghe
											,case when i2.fldMaliyatMashmool= 1 then N'هست' when i2.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmoolMoavaghe
											,case when i2.fldBimeMashmool= 1 then N'هست' when i2.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmoolMoavaghe

											from pay.tblMohasebat as m2 
											inner join pay.tblMoavaghat as o2 on o2.fldMohasebatId=m2.fldId 
											inner join pay.tblMoavaghat_Items as i2 on i2.fldMoavaghatId=o2.fldId 
											inner join com.tblItems_Estekhdam as E2 ON  e2.fldid=i2.fldItemEstekhdamId 
											where i2.fldHesabTypeItemId= @dHesabType  and m2.fldPersonalId=@fldPersonalId and o2.fldYear=@Year AND o2.fldMonth=@Month  
											and m2.fldYear<>@YearPardakht and m2.fldMonth<>@MonthPardakht
											and i.fldItemsHoghughiId=e2.fldItemsHoghughiId and i2.fldSourceId=tblMoavaghat_Items.fldSourceId
											 and fldCalcType=1)o2
							outer apply(select m3.fldMashmolBime as fldMashmolBimeMahAsli,m3.fldMashmolMaliyat as fldMashmolMaliyatMahAsli
											,i2.fldMablagh as fldMablaghMahAsli 
											,case when i2.fldMaliyatMashmool= 1 then N'هست' when i2.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmoolMahAsli
											,case when i2.fldBimeMashmool= 1 then N'هست' when i2.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmoolMahAsli
											from  Pay.tblMohasebat as m3
									inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m3.fldId
									inner join pay.tblMohasebat_Items as i2 on i2.fldMohasebatId=m3.fldId
									inner join com.tblItems_Estekhdam as e on i2.fldItemEstekhdamId=e.fldId
									where  i2.fldHesabTypeItemId= @dHesabType  and  fldPersonalId=@fldPersonalId and m3.fldYear=@Year AND m3.fldMonth=@Month  
									and i.fldItemsHoghughiId=e.fldItemsHoghughiId and i2.fldSourceId=tblMoavaghat_Items.fldSourceId
									 and fldCalcType=1)m3
							  cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=tblMoavaghat.fldYear and mm.fldMonth=tblMoavaghat.fldMonth 
							   and fldCalcType=1)mm
							  WHERE  tblMoavaghat_Items.fldHesabTypeItemId= @dHesabType  and  m.fldPersonalId=@fldPersonalId and m.fldYear=@YearPardakht AND m.fldMonth=@MonthPardakht AND fldNobatPardakht=@NobatPardakht   
							  and tblMoavaghat.fldYear=@Year AND tblMoavaghat.fldMonth=@Month and fldItemsHoghughiId=68
							   and fldCalcType=1
		union all
				select  N'حق درمان کارفرما_معوقه' AS fldTitle,(fldMablagh),fldMashmolBime,fldMashmolMaliyat,fldPersonalId, fldYearPardakht, fldMonthPardakht,fldYear,fldMonth,fldKarkard,fldHokmId,2 fldtype
				,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmoolh
		,  fldYearMoavagh, fldMonthMoavagh,fldMashmolBimeMoavaghe,fldMashmolMaliyatMoavaghe, fldMablaghMoavaghe	, fldMaliyatMashmoolMoavaghe, fldBimeMashmoolMoavaghe
		, fldMashmolBimeMahAsli, fldMashmolMaliyatMahAsli, fldMablaghMahAsli, fldMaliyatMashmoolMahAsli, fldBimeMashmoolMahAsli 
		,fldMablaghMahAsli+sum(isnull(fldMablaghMoavaghe,0)) over (partition by g.fldid)+fldMablagh as fldMablaghNahaee
				from(
		
				SELECT    m.fldid,(o.fldHaghDarmanKarfFarma) as fldMablagh,o.fldMashmolBime,o.fldMashmolMaliyat,fldPersonalId,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht ,o.fldyear,o.fldmonth,o.fldHokmId,mm.fldKarkard
				,  fldYearMoavagh, fldMonthMoavagh,fldMashmolBimeMoavaghe,fldMashmolMaliyatMoavaghe, fldMablaghMoavaghe	, fldMaliyatMashmoolMoavaghe, fldBimeMashmoolMoavaghe
				, fldMashmolBimeMahAsli, fldMashmolMaliyatMahAsli, fldMablaghMahAsli, fldMaliyatMashmoolMahAsli, fldBimeMashmoolMahAsli 
				FROM pay.tblMohasebat as m
				inner join Pay.tblMoavaghat as o on m.fldId=o.fldMohasebatId 
				outer apply(select m2.fldYear as fldYearMoavagh,m2.fldMonth as fldMonthMoavagh,m2.fldMashmolBime,m2.fldMashmolMaliyat
											,o2.fldMashmolBime as fldMashmolBimeMoavaghe,o2.fldMashmolMaliyat as fldMashmolMaliyatMoavaghe,o2.fldHaghDarmanKarfFarma as fldMablaghMoavaghe
											,  N'نیست'  as fldMaliyatMashmoolMoavaghe
											, N'نیست'  as fldBimeMashmoolMoavaghe
											from pay.tblMohasebat as m2 
											inner join pay.tblMoavaghat as o2 on o2.fldMohasebatId=m2.fldId  
											where  @dHesabType<>1 and m2.fldPersonalId=@fldPersonalId and o2.fldYear=@Year AND o2.fldMonth=@Month  
											and m2.fldYear<>@YearPardakht and m2.fldMonth<>@MonthPardakht and fldCalcType=1
											)o2
				OUTER apply(select m3.fldMashmolBime as fldMashmolBimeMahAsli,m3.fldMashmolMaliyat as fldMashmolMaliyatMahAsli
											,m3.fldHaghDarmanKarfFarma as fldMablaghMahAsli
											, N'نیست'  as fldMaliyatMashmoolMahAsli
											, N'نیست'  as fldBimeMashmoolMahAsli 
											from  Pay.tblMohasebat as m3
									where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and m3.fldYear=@Year AND m3.fldMonth=@Month 
									 and fldCalcType=1 )m3
				cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=o.fldYear and mm.fldMonth=o.fldMonth )mm
				 WHERE   @dHesabType<>1 and fldPersonalId=@fldPersonalId and m.fldYear=@YearPardakht AND m.fldMonth=@MonthPardakht AND fldNobatPardakht=@NobatPardakht   
							  and o.fldYear=@Year AND o.fldMonth=@Month  
							  and o.fldHaghDarmanKarfFarma>0   and fldCalcType=1
				union all
				SELECT     m.fldid,(o.fldHaghDarmanDolat) as fldMablagh,o.fldMashmolBime,o.fldMashmolMaliyat,fldPersonalId,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,o.fldyear,o.fldmonth,o.fldHokmId,mm.fldKarkard 
				,  fldYearMoavagh, fldMonthMoavagh,fldMashmolBimeMoavaghe,fldMashmolMaliyatMoavaghe, fldMablaghMoavaghe	, fldMaliyatMashmoolMoavaghe, fldBimeMashmoolMoavaghe
				, fldMashmolBimeMahAsli, fldMashmolMaliyatMahAsli, fldMablaghMahAsli, fldMaliyatMashmoolMahAsli, fldBimeMashmoolMahAsli 
				FROM pay.tblMohasebat as m
				inner join Pay.tblMoavaghat as o on m.fldId=o.fldMohasebatId 
				outer apply(select m2.fldYear as fldYearMoavagh,m2.fldMonth as fldMonthMoavagh,m2.fldMashmolBime,m2.fldMashmolMaliyat
											,o2.fldMashmolBime as fldMashmolBimeMoavaghe,o2.fldMashmolMaliyat as fldMashmolMaliyatMoavaghe,o2.fldHaghDarmanDolat as fldMablaghMoavaghe
											,  N'نیست'  as fldMaliyatMashmoolMoavaghe
											, N'نیست'  as fldBimeMashmoolMoavaghe
											from pay.tblMohasebat as m2 
											inner join pay.tblMoavaghat as o2 on o2.fldMohasebatId=m2.fldId  
											where  @dHesabType<>1 and m2.fldPersonalId=@fldPersonalId and o2.fldYear=@Year AND o2.fldMonth=@Month  
											and m2.fldYear<>@YearPardakht and m2.fldMonth<>@MonthPardakht and fldCalcType=1
											)o2
				outer apply(select m3.fldMashmolBime as fldMashmolBimeMahAsli,m3.fldMashmolMaliyat as fldMashmolMaliyatMahAsli
											,m3.fldHaghDarmanDolat as fldMablaghMahAsli
											, N'نیست'  as fldMaliyatMashmoolMahAsli
											, N'نیست'  as fldBimeMashmoolMahAsli 
											from  Pay.tblMohasebat as m3
									where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and m3.fldYear=@Year AND m3.fldMonth=@Month  
									 and fldCalcType=1)m3
				cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=o.fldYear and mm.fldMonth=o.fldMonth
				 and fldCalcType=1 )mm
				WHERE   @dHesabType<>1 and fldPersonalId=@fldPersonalId and m.fldYear=@YearPardakht AND m.fldMonth=@MonthPardakht AND fldNobatPardakht=@NobatPardakht   
							  and o.fldYear=@Year AND o.fldMonth=@Month     
							  and o.fldHaghDarmanKarfFarma>0   and fldCalcType=1
				)as g
		union all
				SELECT     N'پس انداز کارفرما_معوقه' AS fldTitle, o.fldPasAndaz/2 ,o.fldMashmolBime,o.fldMashmolMaliyat,fldPersonalId,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,o.fldYear,o.fldMonth,mm.fldKarkard,o.fldHokmId,3 fldtype
			,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,  fldYearMoavagh, fldMonthMoavagh,fldMashmolBimeMoavaghe,fldMashmolMaliyatMoavaghe
		, fldMablaghMoavaghe	, fldMaliyatMashmoolMoavaghe, fldBimeMashmoolMoavaghe
		, fldMashmolBimeMahAsli, fldMashmolMaliyatMahAsli, fldMablaghMahAsli, fldMaliyatMashmoolMahAsli, fldBimeMashmoolMahAsli 
		,fldMablaghMahAsli+sum(isnull(fldMablaghMoavaghe,0)) over (partition by m.fldid)+o.fldPasAndaz/2 as fldMablaghNahaee
			FROM         Pay.tblMohasebat as m
				 inner join Pay.tblMoavaghat as o on m.fldId=o.fldMohasebatId 
				outer apply(select m2.fldYear as fldYearMoavagh,m2.fldMonth as fldMonthMoavagh,m2.fldMashmolBime,m2.fldMashmolMaliyat
											,o2.fldMashmolBime as fldMashmolBimeMoavaghe,o2.fldMashmolMaliyat as fldMashmolMaliyatMoavaghe,o2.fldPasAndaz/2 as fldMablaghMoavaghe
											,  N'نیست'  as fldMaliyatMashmoolMoavaghe
											, N'نیست'  as fldBimeMashmoolMoavaghe
											from pay.tblMohasebat as m2 
											inner join pay.tblMoavaghat as o2 on o2.fldMohasebatId=m2.fldId  
											where  @dHesabType<>1 and m2.fldPersonalId=@fldPersonalId and o2.fldYear=@Year AND o2.fldMonth=@Month  
											and m2.fldYear<>@YearPardakht and m2.fldMonth<>@MonthPardakht  and fldCalcType=1
											)o2
				cross apply(select m3.fldMashmolBime as fldMashmolBimeMahAsli,m3.fldMashmolMaliyat as fldMashmolMaliyatMahAsli
											,m3.fldPasAndaz/2  as fldMablaghMahAsli
											, N'نیست'  as fldMaliyatMashmoolMahAsli
											, N'نیست'  as fldBimeMashmoolMahAsli 
											from  Pay.tblMohasebat as m3
									where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and m3.fldYear=@Year AND m3.fldMonth=@Month 
									 and fldCalcType=1 )m3
				cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=o.fldYear and mm.fldMonth=o.fldMonth
				 and fldCalcType=1 )mm
				WHERE   @dHesabType<>1 and fldPersonalId=@fldPersonalId and m.fldYear=@YearPardakht AND m.fldMonth=@MonthPardakht AND fldNobatPardakht=@NobatPardakht   
							  and o.fldYear=@Year AND o.fldMonth=@Month   and fldCalcType=1
			union all
		 SELECT     CASE WHEN (Pay.tblMohasebat_PersonalInfo.fldTypeBimeId = 1) THEN N'حق بیمه_معوقه' ELSE N'حق بازنشستگی_معوقه' END AS fldTitle,
				 o.fldBimePersonal  as fldMablagh
				,m.fldPersonalId,o.fldMashmolBime,o.fldMashmolMaliyat,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,o.fldYear,o.fldMonth,mm.fldKarkard,o.fldHokmId,4 fldtype
		,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool
		,  fldYearMoavagh, fldMonthMoavagh,fldMashmolBimeMoavaghe,fldMashmolMaliyatMoavaghe, fldMablaghMoavaghe	, fldMaliyatMashmoolMoavaghe, fldBimeMashmoolMoavaghe
		, fldMashmolBimeMahAsli, fldMashmolMaliyatMahAsli, fldMablaghMahAsli, fldMaliyatMashmoolMahAsli, fldBimeMashmoolMahAsli 
		,fldMablaghMahAsli+sum(isnull(fldMablaghMoavaghe,0)) over (partition by m.fldid)+o.fldBimePersonal as fldMablaghNahaee
		FROM         Pay.tblMoavaghat as o inner join
							  Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId inner join					  
							  Pay.tblMohasebat_PersonalInfo ON m.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
							  outer apply(select m2.fldYear as fldYearMoavagh,m2.fldMonth as fldMonthMoavagh,m2.fldMashmolBime,m2.fldMashmolMaliyat
											,o2.fldMashmolBime as fldMashmolBimeMoavaghe,o2.fldMashmolMaliyat as fldMashmolMaliyatMoavaghe,o2.fldBimePersonal as fldMablaghMoavaghe
											,  N'نیست'  as fldMaliyatMashmoolMoavaghe
											, N'نیست'  as fldBimeMashmoolMoavaghe
											from pay.tblMohasebat as m2 
											inner join pay.tblMoavaghat as o2 on o2.fldMohasebatId=m2.fldId  
											where  @dHesabType<>1 and m2.fldPersonalId=@fldPersonalId and o2.fldYear=@Year AND o2.fldMonth=@Month  
											and m2.fldYear<>@YearPardakht and m2.fldMonth<>@MonthPardakht and fldCalcType=1
											)o2
				OUTER apply(select m3.fldMashmolBime as fldMashmolBimeMahAsli,m3.fldMashmolMaliyat as fldMashmolMaliyatMahAsli
											,m3.fldBimePersonal as fldMablaghMahAsli
											, N'نیست'  as fldMaliyatMashmoolMahAsli
											, N'نیست'  as fldBimeMashmoolMahAsli 
											from  Pay.tblMohasebat as m3
									where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and m3.fldYear=@Year AND m3.fldMonth=@Month  
									 and fldCalcType=1)m3
							   cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=o.fldYear and mm.fldMonth=o.fldMonth
								and fldCalcType=1 )mm
		WHERE   @dHesabType<>1 and fldPersonalId=@fldPersonalId and m.fldYear=@YearPardakht AND m.fldMonth=@MonthPardakht AND fldNobatPardakht=@NobatPardakht   
							  and o.fldYear=@Year AND o.fldMonth=@Month    and fldCalcType=1

		union all
		   SELECT     N'حق درمان_موقعه' AS fldTitle,
				o.fldHaghDarman
				,m.fldPersonalId,o.fldMashmolBime,o.fldMashmolMaliyat,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,o.fldYear,o.fldMonth,mm.fldKarkard,o.fldHokmId,5 fldtype
				,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool
				,  fldYearMoavagh, fldMonthMoavagh,fldMashmolBimeMoavaghe,fldMashmolMaliyatMoavaghe, fldMablaghMoavaghe	, fldMaliyatMashmoolMoavaghe, fldBimeMashmoolMoavaghe
		, fldMashmolBimeMahAsli, fldMashmolMaliyatMahAsli, fldMablaghMahAsli, fldMaliyatMashmoolMahAsli, fldBimeMashmoolMahAsli 
		,fldMablaghMahAsli+sum(isnull(fldMablaghMoavaghe,0)) over (partition by m.fldid)+o.fldHaghDarman as fldMablaghNahaee
		FROM         Pay.tblMoavaghat as o inner join
							  Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId 
							  outer apply(select m2.fldYear as fldYearMoavagh,m2.fldMonth as fldMonthMoavagh,m2.fldMashmolBime,m2.fldMashmolMaliyat
											,o2.fldMashmolBime as fldMashmolBimeMoavaghe,o2.fldMashmolMaliyat as fldMashmolMaliyatMoavaghe,o2.fldHaghDarman as fldMablaghMoavaghe
											,  N'نیست'  as fldMaliyatMashmoolMoavaghe
											, N'نیست'  as fldBimeMashmoolMoavaghe
											from pay.tblMohasebat as m2 
											inner join pay.tblMoavaghat as o2 on o2.fldMohasebatId=m2.fldId  
											where  @dHesabType<>1 and m2.fldPersonalId=@fldPersonalId and o2.fldYear=@Year AND o2.fldMonth=@Month  
											and m2.fldYear<>@YearPardakht and m2.fldMonth<>@MonthPardakht and fldCalcType=1
											)o2
				OUTER apply(select m3.fldMashmolBime as fldMashmolBimeMahAsli,m3.fldMashmolMaliyat as fldMashmolMaliyatMahAsli
											,m3.fldHaghDarman as fldMablaghMahAsli
											, N'نیست'  as fldMaliyatMashmoolMahAsli
											, N'نیست'  as fldBimeMashmoolMahAsli 
											from  Pay.tblMohasebat as m3
									where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and m3.fldYear=@Year AND m3.fldMonth=@Month 
									 and fldCalcType=1 )m3
							   cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=o.fldYear and mm.fldMonth=o.fldMonth 
								and fldCalcType=1)mm
		WHERE   @dHesabType<>1 and fldPersonalId=@fldPersonalId and m.fldYear=@YearPardakht AND m.fldMonth=@MonthPardakht AND fldNobatPardakht=@NobatPardakht   
							  and o.fldYear=@Year AND o.fldMonth=@Month   and fldCalcType=1
		union all
		   SELECT     N'مالیات_موقعه' AS fldTitle,
				o.fldMaliyat
				,m.fldPersonalId,o.fldMashmolBime,o.fldMashmolMaliyat,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,o.fldYear,o.fldMonth,mm.fldKarkard,o.fldHokmId,6 fldtype
		,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,  fldYearMoavagh, fldMonthMoavagh,fldMashmolBimeMoavaghe,fldMashmolMaliyatMoavaghe, fldMablaghMoavaghe	, fldMaliyatMashmoolMoavaghe, fldBimeMashmoolMoavaghe
		, fldMashmolBimeMahAsli, fldMashmolMaliyatMahAsli, fldMablaghMahAsli, fldMaliyatMashmoolMahAsli, fldBimeMashmoolMahAsli 
		,fldMablaghMahAsli+sum(isnull(fldMablaghMoavaghe,0)) over (partition by m.fldid)+o.fldMaliyat as fldMablaghNahaee
		FROM         Pay.tblMoavaghat as o inner join
							  Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId 
							  outer apply(select m2.fldYear as fldYearMoavagh,m2.fldMonth as fldMonthMoavagh,m2.fldMashmolBime,m2.fldMashmolMaliyat
											,o2.fldMashmolBime as fldMashmolBimeMoavaghe,o2.fldMashmolMaliyat as fldMashmolMaliyatMoavaghe,o2.fldMaliyat as fldMablaghMoavaghe
											,  N'نیست'  as fldMaliyatMashmoolMoavaghe
											, N'نیست'  as fldBimeMashmoolMoavaghe
											from pay.tblMohasebat as m2 
											inner join pay.tblMoavaghat as o2 on o2.fldMohasebatId=m2.fldId  
											where  @dHesabType<>1 and m2.fldPersonalId=@fldPersonalId and o2.fldYear=@Year 
											AND o2.fldMonth=@Month  
											and m2.fldYear<>@YearPardakht and m2.fldMonth<>@MonthPardakht and fldCalcType=1
											)o2
				OUTER apply(select m3.fldMashmolBime as fldMashmolBimeMahAsli,m3.fldMashmolMaliyat as fldMashmolMaliyatMahAsli
											,m3.fldMaliyat as fldMablaghMahAsli
											, N'نیست'  as fldMaliyatMashmoolMahAsli
											, N'نیست'  as fldBimeMashmoolMahAsli 
											from  Pay.tblMohasebat as m3
									where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and m3.fldYear=@Year AND m3.fldMonth=@Month
									 and fldCalcType=1  )m3
							   cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=o.fldYear and mm.fldMonth=o.fldMonth 
								and fldCalcType=1)mm
		wHERE   @dHesabType<>1 and fldPersonalId=@fldPersonalId and m.fldYear=@YearPardakht AND m.fldMonth=@MonthPardakht AND fldNobatPardakht=@NobatPardakht   
							  and o.fldYear=@Year AND o.fldMonth=@Month   and fldCalcType=1
		union all
		   SELECT     N'پس انداز_موقعه' AS fldTitle,
				o.fldPasAndaz
				,m.fldPersonalId,o.fldMashmolBime,o.fldMashmolMaliyat,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,o.fldYear,o.fldMonth,mm.fldKarkard,o.fldHokmId,7 fldtype
				,N'نیست' fldMaliyatMashmool,N'نیست' fldBimeMashmool,  fldYearMoavagh, fldMonthMoavagh,fldMashmolBimeMoavaghe,fldMashmolMaliyatMoavaghe, fldMablaghMoavaghe	, fldMaliyatMashmoolMoavaghe, fldBimeMashmoolMoavaghe
		, fldMashmolBimeMahAsli, fldMashmolMaliyatMahAsli, fldMablaghMahAsli, fldMaliyatMashmoolMahAsli, fldBimeMashmoolMahAsli 
		,fldMablaghMahAsli+sum(isnull(fldMablaghMoavaghe,0)) over (partition by m.fldid)+o.fldPasAndaz as fldMablaghNahaee
		FROM         Pay.tblMoavaghat as o inner join
							  Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId 
							  outer apply(select m2.fldYear as fldYearMoavagh,m2.fldMonth as fldMonthMoavagh,m2.fldMashmolBime,m2.fldMashmolMaliyat
											,o2.fldMashmolBime as fldMashmolBimeMoavaghe,o2.fldMashmolMaliyat as fldMashmolMaliyatMoavaghe,o2.fldPasAndaz as fldMablaghMoavaghe
											,  N'نیست'  as fldMaliyatMashmoolMoavaghe
											, N'نیست'  as fldBimeMashmoolMoavaghe
											from pay.tblMohasebat as m2 
											inner join pay.tblMoavaghat as o2 on o2.fldMohasebatId=m2.fldId  
											where  @dHesabType<>1 and m2.fldPersonalId=@fldPersonalId and o2.fldYear=@Year AND o2.fldMonth=@Month  
											and m2.fldYear<>@YearPardakht and m2.fldMonth<>@MonthPardakht and fldCalcType=1
											)o2
				OUTER apply(select m3.fldMashmolBime as fldMashmolBimeMahAsli,m3.fldMashmolMaliyat as fldMashmolMaliyatMahAsli
											,m3.fldPasAndaz as fldMablaghMahAsli
											, N'نیست'  as fldMaliyatMashmoolMahAsli
											, N'نیست'  as fldBimeMashmoolMahAsli 
											from  Pay.tblMohasebat as m3
									where  @dHesabType<>1 and fldPersonalId=@fldPersonalId and m3.fldYear=@Year AND m3.fldMonth=@Month 
									and fldCalcType=1  )m3
							   cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=o.fldYear and mm.fldMonth=o.fldMonth 
								and fldCalcType=1)mm
		wHERE   @dHesabType<>1 and fldPersonalId=@fldPersonalId and m.fldYear=@YearPardakht AND m.fldMonth=@MonthPardakht AND fldNobatPardakht=@NobatPardakht   
							  and o.fldYear=@Year AND o.fldMonth=@Month   and fldCalcType=1
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
end
else if(@MoavaghType=3)--متمم
begin
		select * from(
		SELECT  i.fldTitle+N'_معوقه متمم' as fldTitle,  (o.fldMablagh) AS fldMablagh,m.fldMashmolBime,m.fldMashmolMaliyat,m.fldPersonalId
		,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,m.fldyear,m.fldmonth,mm.fldKarkard,p.fldHokmId,1 fldtype
		,case when o.fldMaliyatMashmool= 1 then N'هست' when o.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
		,case when o.fldBimeMashmool= 1 then N'هست' when o.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
		,cast(0 as smallint)  fldYearMoavagh,cast(0 as tinyint) fldMonthMoavagh,0 fldMashmolBimeMoavaghe,0 fldMashmolMaliyatMoavaghe,0 fldMablaghMoavaghe	,N'نیست' fldMaliyatMashmoolMoavaghe,N'نیست' fldBimeMashmoolMoavaghe
		, fldMashmolBimeMahAsli, fldMashmolMaliyatMahAsli, fldMablaghMahAsli, fldMaliyatMashmoolMahAsli, fldBimeMashmoolMahAsli 
		,fldMablaghMahAsli+o.fldMablagh as fldMablaghNahaee
		FROM         Pay.tblMohasebat_Items as o INNER JOIN
							  Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId  inner join
							  com.tblItems_Estekhdam as i on i.fldId=fldItemEstekhdamId  inner join
					  pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId = m.fldId
							outer apply(select m3.fldMashmolBime as fldMashmolBimeMahAsli,m3.fldMashmolMaliyat as fldMashmolMaliyatMahAsli
											,i2.fldMablagh as fldMablaghMahAsli 
											,case when i2.fldMaliyatMashmool= 1 then N'هست' when i2.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmoolMahAsli
											,case when i2.fldBimeMashmool= 1 then N'هست' when i2.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmoolMahAsli
											from  Pay.tblMohasebat as m3
									inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m3.fldId
									inner join pay.tblMohasebat_Items as i2 on i2.fldMohasebatId=m3.fldId
									inner join com.tblItems_Estekhdam as e on i2.fldItemEstekhdamId=e.fldId
									where  i2.fldHesabTypeItemId= @dHesabType  and  fldPersonalId=@fldPersonalId and m3.fldYear=@Year 
									AND m3.fldMonth=@Month  and i.fldItemsHoghughiId=e.fldItemsHoghughiId and fldCalcType=1)m3
							  cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=@Year and mm.fldMonth=@Month  
							  and fldCalcType=2)mm
							  WHERE  o.fldHesabTypeItemId= @dHesabType  and  m.fldPersonalId=@fldPersonalId   
							  and m.fldYear=@Year AND m.fldMonth=@Month and fldItemsHoghughiId not in (67,68)
							   and fldCalcType=2
		union all
		SELECT  i.fldTitle+ a.fldNameMonasebat+'('+t.fldTypeName+')'+N'_معوقه متمم' as fldTitle,  (o.fldMablagh) AS fldMablagh,m.fldMashmolBime,m.fldMashmolMaliyat,m.fldPersonalId
		,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,m.fldyear,m.fldmonth,mm.fldKarkard,p.fldHokmId,1 fldtype
		,case when o.fldMaliyatMashmool= 1 then N'هست' when o.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
		,case when o.fldBimeMashmool= 1 then N'هست' when o.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
		, cast(0 as smallint) fldYearMoavagh,cast(0 as tinyint) fldMonthMoavagh,0 fldMashmolBimeMoavaghe,0 fldMashmolMaliyatMoavaghe,0 fldMablaghMoavaghe	,N'نیست' fldMaliyatMashmoolMoavaghe,N'نیست' fldBimeMashmoolMoavaghe
		, fldMashmolBimeMahAsli, fldMashmolMaliyatMahAsli, fldMablaghMahAsli, fldMaliyatMashmoolMahAsli, fldBimeMashmoolMahAsli 
		,fldMablaghMahAsli+o.fldMablagh as fldMablaghNahaee
		FROM         Pay.tblMohasebat_Items as o INNER JOIN
							  Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId  inner join
							  com.tblItems_Estekhdam as i on i.fldId=fldItemEstekhdamId  inner join
					  pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId = m.fldId  inner join
							  pay.tblMonasebatMablagh as m2 on m2.fldId=o.fldSourceId inner join
							  pay.tblTypeNesbat as t on t.fldId=m2.fldTypeNesbatId inner join
							  pay.tblMonasebat as a on a.fldid=m2.fldMonasebatId 
							  
							outer apply(select m3.fldMashmolBime as fldMashmolBimeMahAsli,m3.fldMashmolMaliyat as fldMashmolMaliyatMahAsli
											,i2.fldMablagh as fldMablaghMahAsli 
											,case when i2.fldMaliyatMashmool= 1 then N'هست' when i2.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmoolMahAsli
											,case when i2.fldBimeMashmool= 1 then N'هست' when i2.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmoolMahAsli
											from  Pay.tblMohasebat as m3
									inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m3.fldId
									inner join pay.tblMohasebat_Items as i2 on i2.fldMohasebatId=m3.fldId
									inner join com.tblItems_Estekhdam as e on i2.fldItemEstekhdamId=e.fldId
									where  i2.fldHesabTypeItemId= @dHesabType  and  fldPersonalId=@fldPersonalId and m3.fldYear=@Year AND m3.fldMonth=@Month  
									and i.fldItemsHoghughiId=e.fldItemsHoghughiId and i2.fldSourceId=o.fldSourceId
									 and fldCalcType=1)m3
							  cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=m.fldYear and mm.fldMonth=m.fldMonth
							   and fldCalcType=2 )mm
							  WHERE  o.fldHesabTypeItemId= @dHesabType  and  m.fldPersonalId=@fldPersonalId 
							  and m.fldYear=@YearPardakht AND m.fldMonth=@MonthPardakht AND fldNobatPardakht=@NobatPardakht   
							  and m.fldYear=@Year AND m.fldMonth=@Month and fldItemsHoghughiId=67
							   and fldCalcType=2
		union all
		SELECT  i.fldTitle+'('+
		CASE WHEN a.fldNesbatShakhs=1 THEN N'فرزند' WHEN fldNesbatShakhs=2 THEN N'همسر' WHEN fldNesbatShakhs=3 THEN N'پدر' WHEN fldNesbatShakhs=4 THEN N'مادر' END
		+')'+N'_معوقه متمم' as fldTitle,  (o.fldMablagh) AS fldMablagh,m.fldMashmolBime,m.fldMashmolMaliyat,m.fldPersonalId
		,m.fldYear as fldYearPardakht,m.fldMonth as fldMonthPardakht,m.fldyear,m.fldmonth,mm.fldKarkard,p.fldHokmId,1 fldtype
		,case when o.fldMaliyatMashmool= 1 then N'هست' when o.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmool
		,case when o.fldBimeMashmool= 1 then N'هست' when o.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmool
		, cast(0 as smallint) fldYearMoavagh,cast(0 as tinyint) fldMonthMoavagh,0 fldMashmolBimeMoavaghe,0 fldMashmolMaliyatMoavaghe,0 fldMablaghMoavaghe	,N'نیست' fldMaliyatMashmoolMoavaghe,N'نیست' fldBimeMashmoolMoavaghe
		, fldMashmolBimeMahAsli, fldMashmolMaliyatMahAsli, fldMablaghMahAsli, fldMaliyatMashmoolMahAsli, fldBimeMashmoolMahAsli 
		,fldMablaghMahAsli+o.fldMablagh as fldMablaghNahaee
		FROM         Pay.tblMohasebat_Items as o INNER JOIN
							  Pay.tblMohasebat AS m ON o.fldMohasebatId = m.fldId  inner join
							  com.tblItems_Estekhdam as i on i.fldId=fldItemEstekhdamId  inner join
					  pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId = m.fldId  inner join					  
							  prs.tblAfradTahtePooshesh as a on a.fldId=o.fldSourceId
							  
							outer apply(select m3.fldMashmolBime as fldMashmolBimeMahAsli,m3.fldMashmolMaliyat as fldMashmolMaliyatMahAsli
											,i2.fldMablagh as fldMablaghMahAsli 
											,case when i2.fldMaliyatMashmool= 1 then N'هست' when i2.fldMaliyatMashmool= 0 then  N'نیست' else N'نامشخص' end as fldMaliyatMashmoolMahAsli
											,case when i2.fldBimeMashmool= 1 then N'هست' when i2.fldBimeMashmool= 0 then N'نیست' else N'نامشخص' end as fldBimeMashmoolMahAsli
											from  Pay.tblMohasebat as m3
									inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m3.fldId
									inner join pay.tblMohasebat_Items as i2 on i2.fldMohasebatId=m3.fldId
									inner join com.tblItems_Estekhdam as e on i2.fldItemEstekhdamId=e.fldId
									where  i2.fldHesabTypeItemId= @dHesabType  and  fldPersonalId=@fldPersonalId and m3.fldYear=@Year AND m3.fldMonth=@Month  
									and i.fldItemsHoghughiId=e.fldItemsHoghughiId and i2.fldSourceId=o.fldSourceId
									 and fldCalcType=1)m3
							  cross apply(select mm.fldKarkard from pay.tblMohasebat as mm where mm.fldPersonalId=m.fldPersonalId and mm.fldYear=m.fldYear and mm.fldMonth=m.fldMonth 
							   and fldCalcType=2)mm
							  WHERE  o.fldHesabTypeItemId= @dHesabType  and  m.fldPersonalId=@fldPersonalId and m.fldYear=@YearPardakht AND m.fldMonth=@MonthPardakht AND fldNobatPardakht=@NobatPardakht   
							  and m.fldYear=@Year AND m.fldMonth=@Month and fldItemsHoghughiId=68
							   and fldCalcType=2
		
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
end

 COMMIT
GO
