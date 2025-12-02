SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptMaliyatSaliyane](@year smallint,@Month tinyint,@OrganId int,@type tinyint, @userId int,@PersonalId int)
as
--declare @year smallint=1403,@Month tinyint=8,@OrganId int=1
if(@type=1) /*جمع کل برای یک ماه*/
select fldMonth,fldName+'_'+fldFamily+'('+fldFatherName+')' as fldName,fldCodemeli,m2.fldPersonalId
,isnull(fldMablaghMostamarNaghdi,0)+isnull(fldMablaghMostamarNaghdiSayer,0)+isnull(fldMablaghMostamarNaghdiMotalebat,0) as fldMablaghMostamarNaghdi
	,isnull(fldMablaghMostamarGHeirNaghdi,0)+isnull(fldMablaghMostamarGHeirNaghdiKomak,0)+isnull(fldMablaghMostamarGHeirNaghdiSayer,0)+isnull(fldMablaghMostamarGheirNaghdiMotalebat,0) as fldMablaghMostamarGHeirNaghdi
	,isnull(fldMablaghGheirMostamarNaghdi,0)+isnull(fldMablaghGheirMostamarNaghdiSayer,0)+isnull(fldMablaghGheirMostamarNaghdiMotalebat,0)+isnull(fldMablaghGheirMostamarNaghdiEzafe ,0)as fldMablaghGheirMostamarNaghdi
	,isnull(fldMablaghGheirMostamarGHeirNaghdi,0)+isnull(fldMablaghGheirMostamarGHeirNaghdiKomak,0)+isnull(fldMablaghGheirMostamarGHeirNaghdiSayer,0)+isnull(fldMablaghGheirMostamarGheirNaghdiMotalebat,0)+isnull(fldMablaghGheirMostamarGheirNaghdiEzafe,0) as fldMablaghGheirMostamarGHeirNaghdi
	,bime.fldBimePersonal,isnull(maliyat.fldMaliyat,0)fldMaliyat
  from
pay.tblMohasebat as m2
inner join pay.tblMohasebat_PersonalInfo as mp on mp.fldMohasebatId=m2.fldId
inner join pay.Pay_tblPersonalInfo as pay on pay.fldId=m2.fldPersonalId
inner join prs.Prs_tblPersonalInfo as p on p.fldId=pay.fldPrs_PersonalInfoId
inner join com.tblEmployee as e on e.fldId=p.fldEmployeeId
inner join com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
 cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where fldPrsPersonalInfoId= P.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
 outer apply(select sum(cast(i.fldMablagh as bigint)) as fldMablaghMostamarNaghdi from pay.tblMohasebat as m inner join pay.tblMohasebat_Items as i on i.fldMohasebatId=m.fldid where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth<=m2.fldMonth  and i.fldMaliyatMashmool=1 and fldMostamar=1 and i.fldHesabTypeItemId>1  and fldCalcType=1)mn
 outer apply(select sum(cast(i.fldMablagh as bigint)) as fldMablaghMostamarGHeirNaghdi from pay.tblMohasebat as m inner join pay.tblMohasebat_Items as i on i.fldMohasebatId=m.fldid where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth<=m2.fldMonth and i.fldMaliyatMashmool=1 and fldMostamar=1 and i.fldHesabTypeItemId=1 and fldCalcType=1) mgn
 outer apply(select sum(cast(i.fldMablagh as bigint)) as fldMablaghGheirMostamarNaghdi from pay.tblMohasebat as m inner join pay.tblMohasebat_Items as i on i.fldMohasebatId=m.fldid where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth<=m2.fldMonth and i.fldMaliyatMashmool=1 and fldMostamar=2 and i.fldHesabTypeItemId>1 and fldCalcType=1)gmn
 outer apply(select sum(cast(i.fldMablagh as bigint)) as fldMablaghGheirMostamarGHeirNaghdi from pay.tblMohasebat as m inner join pay.tblMohasebat_Items as i on i.fldMohasebatId=m.fldid where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth<=m2.fldMonth  and fldMostamar=2 and i.fldHesabTypeItemId=1  and fldCalcType=1)gmgn
 outer apply(select sum(cast(m.fldMablagh as bigint)) as fldMablaghGheirMostamarGHeirNaghdiKomak from pay.tblKomakGheyerNaghdi as m where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth<=m2.fldMonth and fldNoeMostamer=0 )gmgnk
 outer apply(select sum(cast(m.fldMablagh as bigint)) as fldMablaghMostamarGHeirNaghdiKomak from pay.tblKomakGheyerNaghdi as m where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth<=m2.fldMonth  and fldNoeMostamer=1 )mgnk
 outer apply(select sum(cast(m.fldAmount as bigint))  as fldMablaghGheirMostamarGHeirNaghdiSayer from pay.tblSayerPardakhts as m inner join pay.tblMohasebat_PersonalInfo as p on m.fldId=p.fldSayerPardakhthaId inner join com.tblShomareHesabOmoomi_Detail as s on s.fldShomareHesabId=p.fldShomareHesabId where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth<=m2.fldMonth and fldMostamar=2 and s.fldHesabTypeId=1  and fldCalcType=1)gmgns
 outer apply(select sum(cast(m.fldAmount as bigint))  as fldMablaghGheirMostamarNaghdiSayer from pay.tblSayerPardakhts as m inner join pay.tblMohasebat_PersonalInfo as p on m.fldId=p.fldSayerPardakhthaId inner join com.tblShomareHesabOmoomi_Detail as s on s.fldShomareHesabId=p.fldShomareHesabId where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth<=m2.fldMonth  and fldHasMaliyat=1  and fldMostamar=2 and s.fldHesabTypeId>1 and fldCalcType=1)gmns
 outer apply(select sum(cast(m.fldAmount as bigint))  as fldMablaghMostamarGHeirNaghdiSayer from pay.tblSayerPardakhts as m inner join pay.tblMohasebat_PersonalInfo as p on m.fldId=p.fldSayerPardakhthaId inner join com.tblShomareHesabOmoomi_Detail as s on s.fldShomareHesabId=p.fldShomareHesabId where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth<=m2.fldMonth  and fldHasMaliyat=1  and fldMostamar=1 and s.fldHesabTypeId=1  and fldCalcType=1)mgns
 outer apply(select sum(cast(m.fldAmount as bigint))  as fldMablaghMostamarNaghdiSayer from pay.tblSayerPardakhts as m inner join pay.tblMohasebat_PersonalInfo as p on m.fldId=p.fldSayerPardakhthaId inner join com.tblShomareHesabOmoomi_Detail as s on s.fldShomareHesabId=p.fldShomareHesabId where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth<=m2.fldMonth  and fldHasMaliyat=1  and fldMostamar=1 and s.fldHesabTypeId>1  and fldCalcType=1)mns
 outer apply(select sum( fldBimePersonal) as fldBimePersonal from (select  ISNULL(Pay.tblMohasebat.fldBimePersonal,0)+ ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)  AS fldBimePersonal from pay.tblMohasebat   inner join pay.Pay_tblPersonalInfo as p on p.fldId=tblMohasebat.fldPersonalId where fldPersonalId=m2.fldPersonalId and fldYear=m2.fldYear and fldMonth<=m2.fldMonth and fldCalcType=1)t)bime
 outer apply(select sum(fldMaliyat)   as fldMaliyat from(select sum( fldMaliyat) +ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0))   as fldMaliyat from pay.tblMohasebat where fldPersonalId= m2.fldPersonalId and fldYear=m2.fldYear and fldMonth<m2.fldMonth  and fldCalcType=1 group by tblMohasebat.fldId)t)maliyat
 outer apply(select sum(cast(m.fldMablagh as bigint)) as fldMablaghGheirMostamarNaghdiEzafe from pay.tblMohasebatEzafeKari_TatilKari as m where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and fldMonth<=m2.fldMonth  and fldHesabTypeId>1 and m.fldMashmolMaliyat>0  and fldCalcType=1)gmne
 outer apply(select sum( cast(m.fldMablagh as bigint)) as fldMablaghGheirMostamarGheirNaghdiEzafe from pay.tblMohasebatEzafeKari_TatilKari as m where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and fldMonth<=m2.fldMonth  and fldHesabTypeId=1 and m.fldMashmolMaliyat>0 and fldCalcType=1 )gmgne
 outer apply(select sum(ISNULL( cast(i.fldMablagh as bigint),0)) as fldMablaghMostamarNaghdiMotalebat from pay.tblMohasebat as m 
						inner join pay.[tblMohasebat_kosorat/MotalebatParam] as i on i.fldMohasebatId=m.fldid 
						inner join pay.tblMotalebateParametri_Personal as p on p.fldId=i.fldMotalebatId
						where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and fldMonth<=m2.fldMonth AND fldMotalebatId IS NOT NULL and i.fldIsMostamar=1 and fldHesabTypeParamId>1 
						and p.fldMashmoleMaliyat=1 and fldCalcType=1)mnm
 outer apply(select sum(ISNULL( cast(i.fldMablagh as bigint),0)) as fldMablaghGheirMostamarNaghdiMotalebat from pay.tblMohasebat as m 
			inner join pay.[tblMohasebat_kosorat/MotalebatParam] as i on i.fldMohasebatId=m.fldid 
			inner join pay.tblMotalebateParametri_Personal as p on p.fldId=i.fldMotalebatId
			where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and fldMonth<=m2.fldMonth AND fldMotalebatId IS NOT NULL and i.fldIsMostamar=2 and fldHesabTypeParamId>1 
			and p.fldMashmoleMaliyat=1 and fldCalcType=1)gmnm
 outer apply(select sum(ISNULL( cast(i.fldMablagh as bigint),0)) as fldMablaghMostamarGheirNaghdiMotalebat from pay.tblMohasebat as m 
			inner join pay.[tblMohasebat_kosorat/MotalebatParam] as i on i.fldMohasebatId=m.fldid 
			inner join pay.tblMotalebateParametri_Personal as p on p.fldId=i.fldMotalebatId
			where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and fldMonth<=m2.fldMonth AND fldMotalebatId IS NOT NULL and i.fldIsMostamar=1 and fldHesabTypeParamId=1 
			and p.fldMashmoleMaliyat=1  and fldCalcType=1)mgnm
 outer apply(select sum(ISNULL( cast(i.fldMablagh as bigint),0)) as fldMablaghGheirMostamarGheirNaghdiMotalebat from pay.tblMohasebat as m 
			inner join pay.[tblMohasebat_kosorat/MotalebatParam] as i on i.fldMohasebatId=m.fldid 
			inner join pay.tblMotalebateParametri_Personal as p on p.fldId=i.fldMotalebatId
			where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and fldMonth<=m2.fldMonth AND fldMotalebatId IS NOT NULL and i.fldIsMostamar=2 and fldHesabTypeParamId=1 
			and p.fldMashmoleMaliyat=1  and fldCalcType=1)gmgnm
where  fldYear=@year and fldMonth=@Month and fldOrganId=@OrganId and fldCalcType=1
and (@PersonalId=0 or fldPersonalId=@PersonalId)

order by fldPersonalId,fldMonth

else /*به تفکیک هر ماه*/
select fldMonth,fldName+'_'+fldFamily+'('+fldFatherName+')' as fldName,fldCodemeli,m2.fldPersonalId
,isnull(fldMablaghMostamarNaghdi,0)+isnull(fldMablaghMostamarNaghdiSayer,0)+isnull(fldMablaghMostamarNaghdiMotalebat,0) as fldMablaghMostamarNaghdi
	,isnull(fldMablaghMostamarGHeirNaghdi,0)+isnull(fldMablaghMostamarGHeirNaghdiKomak,0)+isnull(fldMablaghMostamarGHeirNaghdiSayer,0)+isnull(fldMablaghMostamarGheirNaghdiMotalebat,0) as fldMablaghMostamarGHeirNaghdi
	,isnull(fldMablaghGheirMostamarNaghdi,0)+isnull(fldMablaghGheirMostamarNaghdiSayer,0)+isnull(fldMablaghGheirMostamarNaghdiMotalebat,0)+isnull(fldMablaghGheirMostamarNaghdiEzafe ,0)as fldMablaghGheirMostamarNaghdi
	,isnull(fldMablaghGheirMostamarGHeirNaghdi,0)+isnull(fldMablaghGheirMostamarGHeirNaghdiKomak,0)+isnull(fldMablaghGheirMostamarGHeirNaghdiSayer,0)+isnull(fldMablaghGheirMostamarGheirNaghdiMotalebat,0)+isnull(fldMablaghGheirMostamarGheirNaghdiEzafe,0) as fldMablaghGheirMostamarGHeirNaghdi
	,bime.fldBimePersonal,isnull(maliyat.fldMaliyat,0)fldMaliyat
  from
pay.tblMohasebat as m2
inner join pay.tblMohasebat_PersonalInfo as mp on mp.fldMohasebatId=m2.fldId
inner join pay.Pay_tblPersonalInfo as pay on pay.fldId=m2.fldPersonalId
inner join prs.Prs_tblPersonalInfo as p on p.fldId=pay.fldPrs_PersonalInfoId
inner join com.tblEmployee as e on e.fldId=p.fldEmployeeId
inner join com.tblEmployee_Detail as d on d.fldEmployeeId=e.fldId
 cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where fldPrsPersonalInfoId= p.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
 outer apply(select sum(cast(i.fldMablagh as bigint)) as fldMablaghMostamarNaghdi from pay.tblMohasebat as m inner join pay.tblMohasebat_Items as i on i.fldMohasebatId=m.fldid where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth=m2.fldMonth  and i.fldMaliyatMashmool=1 and fldMostamar=1 and i.fldHesabTypeItemId>1  and fldCalcType=1)mn
 outer apply(select sum(cast(i.fldMablagh as bigint)) as fldMablaghMostamarGHeirNaghdi from pay.tblMohasebat as m inner join pay.tblMohasebat_Items as i on i.fldMohasebatId=m.fldid where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth=m2.fldMonth and i.fldMaliyatMashmool=1 and fldMostamar=1 and i.fldHesabTypeItemId=1 and fldCalcType=1) mgn
 outer apply(select sum(cast(i.fldMablagh as bigint)) as fldMablaghGheirMostamarNaghdi from pay.tblMohasebat as m inner join pay.tblMohasebat_Items as i on i.fldMohasebatId=m.fldid where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth=m2.fldMonth and i.fldMaliyatMashmool=1 and fldMostamar=2 and i.fldHesabTypeItemId>1 and fldCalcType=1)gmn
 outer apply(select sum(cast(i.fldMablagh as bigint)) as fldMablaghGheirMostamarGHeirNaghdi from pay.tblMohasebat as m inner join pay.tblMohasebat_Items as i on i.fldMohasebatId=m.fldid where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth=m2.fldMonth  and fldMostamar=2 and i.fldHesabTypeItemId=1  and fldCalcType=1)gmgn
 outer apply(select sum(cast(m.fldMablagh as bigint)) as fldMablaghGheirMostamarGHeirNaghdiKomak from pay.tblKomakGheyerNaghdi as m where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth=m2.fldMonth and fldNoeMostamer=0  and fldCalcType=1)gmgnk
 outer apply(select sum(cast(m.fldMablagh as bigint)) as fldMablaghMostamarGHeirNaghdiKomak from pay.tblKomakGheyerNaghdi as m where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth=m2.fldMonth  and fldNoeMostamer=1  and fldCalcType=1)mgnk
 outer apply(select sum(cast(m.fldAmount as bigint))  as fldMablaghGheirMostamarGHeirNaghdiSayer from pay.tblSayerPardakhts as m inner join pay.tblMohasebat_PersonalInfo as p on m.fldId=p.fldSayerPardakhthaId inner join com.tblShomareHesabOmoomi_Detail as s on s.fldShomareHesabId=p.fldShomareHesabId where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth=m2.fldMonth and fldMostamar=2 and s.fldHesabTypeId=1  and fldCalcType=1)gmgns
 outer apply(select sum(cast(m.fldAmount as bigint))  as fldMablaghGheirMostamarNaghdiSayer from pay.tblSayerPardakhts as m inner join pay.tblMohasebat_PersonalInfo as p on m.fldId=p.fldSayerPardakhthaId inner join com.tblShomareHesabOmoomi_Detail as s on s.fldShomareHesabId=p.fldShomareHesabId where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth=m2.fldMonth  and fldHasMaliyat=1  and fldMostamar=2 and s.fldHesabTypeId>1 and fldCalcType=1)gmns
 outer apply(select sum(cast(m.fldAmount as bigint))  as fldMablaghMostamarGHeirNaghdiSayer from pay.tblSayerPardakhts as m inner join pay.tblMohasebat_PersonalInfo as p on m.fldId=p.fldSayerPardakhthaId inner join com.tblShomareHesabOmoomi_Detail as s on s.fldShomareHesabId=p.fldShomareHesabId where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth=m2.fldMonth  and fldHasMaliyat=1  and fldMostamar=1 and s.fldHesabTypeId=1 and fldCalcType=1 )mgns
 outer apply(select sum(cast(m.fldAmount as bigint))  as fldMablaghMostamarNaghdiSayer from pay.tblSayerPardakhts as m inner join pay.tblMohasebat_PersonalInfo as p on m.fldId=p.fldSayerPardakhthaId inner join com.tblShomareHesabOmoomi_Detail as s on s.fldShomareHesabId=p.fldShomareHesabId where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and m.fldMonth=m2.fldMonth  and fldHasMaliyat=1  and fldMostamar=1 and s.fldHesabTypeId>1  and fldCalcType=1)mns
 outer apply(select sum( fldBimePersonal) as fldBimePersonal from (select  ISNULL(Pay.tblMohasebat.fldBimePersonal,0)+ ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)  AS fldBimePersonal from pay.tblMohasebat   inner join pay.Pay_tblPersonalInfo as p on p.fldId=tblMohasebat.fldPersonalId where fldPersonalId=m2.fldPersonalId and fldYear=m2.fldYear and fldMonth=m2.fldMonth and fldCalcType=1)t)bime
 outer apply(select sum(fldMaliyat)   as fldMaliyat from(select sum( fldMaliyat) +ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0))   as fldMaliyat from pay.tblMohasebat where fldPersonalId= m2.fldPersonalId and fldYear=m2.fldYear and fldMonth=m2.fldMonth   and fldCalcType=1 group by tblMohasebat.fldId)t)maliyat
 outer apply(select sum(cast(m.fldMablagh as bigint)) as fldMablaghGheirMostamarNaghdiEzafe from pay.tblMohasebatEzafeKari_TatilKari as m where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and fldMonth=m2.fldMonth  and fldHesabTypeId>1 and m.fldMashmolMaliyat>0 and fldCalcType=1 )gmne
 outer apply(select sum( cast(m.fldMablagh as bigint)) as fldMablaghGheirMostamarGheirNaghdiEzafe from pay.tblMohasebatEzafeKari_TatilKari as m where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and fldMonth=m2.fldMonth  and fldHesabTypeId=1 and m.fldMashmolMaliyat>0 and fldCalcType=1 )gmgne
 outer apply(select sum(ISNULL( cast(i.fldMablagh as bigint),0)) as fldMablaghMostamarNaghdiMotalebat from pay.tblMohasebat as m 
						inner join pay.[tblMohasebat_kosorat/MotalebatParam] as i on i.fldMohasebatId=m.fldid 
						inner join pay.tblMotalebateParametri_Personal as p on p.fldId=i.fldMotalebatId
						where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and fldMonth=m2.fldMonth AND fldMotalebatId IS NOT NULL and i.fldIsMostamar=1 and fldHesabTypeParamId>1 
						and p.fldMashmoleMaliyat=1 and fldCalcType=1)mnm
 outer apply(select sum(ISNULL( cast(i.fldMablagh as bigint),0)) as fldMablaghGheirMostamarNaghdiMotalebat from pay.tblMohasebat as m 
			inner join pay.[tblMohasebat_kosorat/MotalebatParam] as i on i.fldMohasebatId=m.fldid 
			inner join pay.tblMotalebateParametri_Personal as p on p.fldId=i.fldMotalebatId
			where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and fldMonth=m2.fldMonth AND fldMotalebatId IS NOT NULL and i.fldIsMostamar=2 and fldHesabTypeParamId>1 
			and p.fldMashmoleMaliyat=1 and fldCalcType=1)gmnm
 outer apply(select sum(ISNULL( cast(i.fldMablagh as bigint),0)) as fldMablaghMostamarGheirNaghdiMotalebat from pay.tblMohasebat as m 
			inner join pay.[tblMohasebat_kosorat/MotalebatParam] as i on i.fldMohasebatId=m.fldid 
			inner join pay.tblMotalebateParametri_Personal as p on p.fldId=i.fldMotalebatId
			where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and fldMonth=m2.fldMonth AND fldMotalebatId IS NOT NULL and i.fldIsMostamar=1 and fldHesabTypeParamId=1 
			and p.fldMashmoleMaliyat=1  and fldCalcType=1)mgnm
 outer apply(select sum(ISNULL( cast(i.fldMablagh as bigint),0)) as fldMablaghGheirMostamarGheirNaghdiMotalebat from pay.tblMohasebat as m 
			inner join pay.[tblMohasebat_kosorat/MotalebatParam] as i on i.fldMohasebatId=m.fldid 
			inner join pay.tblMotalebateParametri_Personal as p on p.fldId=i.fldMotalebatId
			where m.fldPersonalId=m2.fldPersonalId and m.fldYear=m2.fldYear and fldMonth=m2.fldMonth AND fldMotalebatId IS NOT NULL and i.fldIsMostamar=2 and fldHesabTypeParamId=1 
			and p.fldMashmoleMaliyat=1  and fldCalcType=1)gmgnm
where  fldYear=@year and fldMonth<=@Month and fldOrganId=@OrganId and fldAnvaEstekhdamId<>10 and fldCalcType=1
and (@PersonalId=0 or fldPersonalId=@PersonalId) 
order by fldPersonalId,fldMonth


GO
