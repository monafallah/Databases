SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Pay].[spr_Pay_RptFishBonKart_Motalebat]
@fldPersonalId INT=0,
@NobatPardakht INT=1,
@Year SMALLINT=1398,
@Month TINYINT=12
,@userId int,
@CalcType TINYINT=1
 as
--declare @fldPersonalId int = 0,
--		@NobatPardakht int= 1,
--		@Year int = 1401,
--		@Month int= 4,
--@userId int=14 
BEGIN TRAN
declare @salP SMALLINT=@Year,@mahP TINYINT=@Month-1

if(@Month=1)
begin
	set @salP=@Year-1
	set @mahP=12
end

DECLARE @M TABLE(fldId int,fldPersonalId int)
IF @fldPersonalId <>0
INSERT INTO @M
      SELECT fldId,fldPersonalId FROM Pay.tblMohasebat
        WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht AND fldPersonalId=@fldPersonalId and fldCalcType=@CalcType
ELSE
INSERT INTO @M
      SELECT fldId,fldPersonalId FROM Pay.tblMohasebat 
        WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht and fldCalcType=@CalcType

DECLARE @temp TABLE(fldId INT IDENTITY,fldTitle nvarchar(500),fldMablagh int,fldPersonalId int)

INSERT INTO @temp
SELECT      Com.tblItems_Estekhdam.fldTitle AS fldTitle,Pay.tblMohasebat_Items.fldMablagh,Pay.tblMohasebat.fldPersonalId
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId 
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M) and fldItemsHoghughiId not in (67,68)
					   and tblMohasebat_Items.fldHesabTypeItemId=1
union all
SELECT     Com.tblItems_Estekhdam.fldTitle+ a.fldNameMonasebat AS fldTitle,sum( Pay.tblMohasebat_Items.fldMablagh),Pay.tblMohasebat.fldPersonalId
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId inner join
					  pay.tblMonasebatMablagh as m on m.fldId=tblMohasebat_Items.fldSourceId inner join
					  pay.tblMonasebat as a on a.fldid=m.fldMonasebatId 
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M) and fldItemsHoghughiId=67
					   and tblMohasebat_Items.fldHesabTypeItemId=1
					   group by a.fldNameMonasebat,Pay.tblMohasebat.fldPersonalId,Com.tblItems_Estekhdam.fldTitle
union all
SELECT     Com.tblItems_Estekhdam.fldTitle,sum( Pay.tblMohasebat_Items.fldMablagh),Pay.tblMohasebat.fldPersonalId
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId inner join
					  pay.tblMonasebatMablagh as m on m.fldId=tblMohasebat_Items.fldSourceId inner join
					  pay.tblMonasebat as a on a.fldid=m.fldMonasebatId 
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M) and fldItemsHoghughiId=68
					   and tblMohasebat_Items.fldHesabTypeItemId=1
					   group by Pay.tblMohasebat.fldPersonalId,Com.tblItems_Estekhdam.fldTitle

INSERT INTO @temp
SELECT      Pay.tblParametrs.fldTitle,[Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh,Pay.tblMohasebat.fldPersonalId
FROM         Pay.tblMohasebat INNER JOIN
                      [Pay].[tblMohasebat_kosorat/MotalebatParam] ON Pay.tblMohasebat.fldId = [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId INNER JOIN
                      Pay.tblMotalebateParametri_Personal ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId = Pay.tblMotalebateParametri_Personal.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId
WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M) AND 
                      ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId IS NOT NULL)
					  and [tblMohasebat_kosorat/MotalebatParam].fldHesabTypeParamId=1
INSERT INTO @temp
SELECT     N'معوقه ' +CAST(COUNT(*) AS NVARCHAR(5))+  N' ماهه ' AS fldTitle,
--SUM(Pay.tblMoavaghat.fldEzafeKar)+SUM(Pay.tblMoavaghat.fldTatilKar)+
--SUM(Pay.tblMoavaghat.fldMamoriyat)+SUM(Pay.tblMoavaghat.fldNobatKari)+SUM(Pay.tblMoavaghat.fldSPayanKhedmat)              
+
ISNULL((SELECT     SUM(Pay.tblMoavaghat_Items.fldMablagh) AS Expr1
FROM         Pay.tblMoavaghat_Items INNER JOIN
                      Pay.tblMoavaghat ON Pay.tblMoavaghat_Items.fldMoavaghatId = Pay.tblMoavaghat.fldId INNER JOIN
                      Pay.tblMohasebat AS m ON Pay.tblMoavaghat.fldMohasebatId = m.fldId  
                      WHERE m.fldId=Pay.tblMohasebat.fldId  and Pay.tblMoavaghat_Items.fldMablagh>0 and tblMoavaghat_Items.fldHesabTypeItemId=1 ),0),Pay.tblMohasebat.fldPersonalId

FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMoavaghat.fldMohasebatId = Pay.tblMohasebat.fldId 
                       WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)  
                  GROUP BY Pay.tblMohasebat.fldId ,Pay.tblMohasebat.fldPersonalId    
				  
 
 insert @temp
 select N'معوقه متمم',sum(o.fldMablagh) as fldMablaghMotamam,m2.fldPersonalId from pay.tblMohasebat as m2 
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                inner join @m as m on m.fldPersonalId=m2.fldPersonalId
								where  m2.fldYear= @salP and m2.fldMonth=@mahP and o.fldMablagh>0
                                group by m2.fldPersonalId  

INSERT INTO @temp
SELECT    N'سایر پرداخت ها',sum(fldAmount),fldPersonalId
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId  INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
					  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
       WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatePardakt=@NobatPardakht 
					  AND  Pay.tblSayerPardakhts.fldPersonalId=@fldPersonalId  --and fldMaliyat>0 
					  and d.fldHesabTypeId=1 
GROUP BY fldPersonalId   


INSERT INTO @temp					         
SELECT    N'کمک غیر نقدی',sum(fldMablagh),fldPersonalId
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId   INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
					  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
                       WHERE fldYear=@Year AND fldMonth=@Month 
					 AND Pay.tblKomakGheyerNaghdi.fldPersonalId=@fldPersonalId --and fldMaliyat>0 
					  and d.fldHesabTypeId=1 
GROUP BY fldPersonalId 

SELECT *,sum(fldMablagh) over (partition by fldPersonalId ) as fldJamMotalebat FROM @temp tem
 

 WHERE fldMablagh<>0   and exists (select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														inner join pay.pay_tblPersonalInfo p on p.fldPrs_PersonalInfoId=fldPrsPersonalInfoId
														where p.fldid=tem.fldPersonalId
														order by fldTarikh desc)history
														where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
														group by  t.fldTypeEstekhamId)
 --order by fldPersonalId
 COMMIT
GO
