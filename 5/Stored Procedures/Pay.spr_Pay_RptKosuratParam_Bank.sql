SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [Pay].[spr_Pay_RptKosuratParam_Bank]
@Year SMALLINT,
@Month TINYINT,
@NobatePardakht TINYINT,
@organId INT,
@costCenter int,
@CalcType TINYINT=1
as 
BEGIN TRAN
-- declare @Year SMALLINT=1403,
--@Month TINYINT=11,
--@NobatePardakht TINYINT=1,
--@organId INT=2,
--@costCenter int=0

 declare @Year1 SMALLINT=@Year,
@Month1 TINYINT=@Month,
@NobatePardakht1 TINYINT=@NobatePardakht,
@organId1 INT=@organId,
@costCenter1 int=@costCenter
declare @BankId int
 SELECT top 1  @BankId=s.fldBankId FROM Pay.tblMohasebat as m
	  inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId 
	  inner join com.tblShomareHesabeOmoomi as s on s.fldId=p.fldShomareHesabId
        WHERE fldYear=@Year1 AND fldMonth=@Month1 AND fldNobatPardakht=@NobatePardakht1 and fldOrganId=@organId1
		and fldCalcType=@CalcType

IF(@costCenter1=0)
select fldId,fldTitle,sum(cast(fldMablagh as bigint))as fldMablagh,fldYear,fldMonth from(SELECT     Pay.tblParametrs.fldId, cast(Pay.tblParametrs.fldTitle COLLATE Latin1_General_CI_AI AS NVARCHAR(300))fldTitle, [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh
,fldYear,Com.fn_month(fldMonth) AS fldMonth
FROM         [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                      Pay.tblMohasebat ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
					  pay.tblMohasebat_PersonalInfo on Pay.tblMohasebat.fldid=pay.tblMohasebat_PersonalInfo.fldMohasebatId inner join
                      Pay.tblKosorateParametri_Personal ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldKosoratId = Pay.tblKosorateParametri_Personal.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId
                      WHERE fldNobatPardakht=@NobatePardakht1 AND fldYear=@Year1 AND fldMonth=@Month1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1 and fldCalcType=@CalcType
)as d 
GROUP BY fldId, fldTitle,fldYear,fldMonth
union
SELECT      fldItemEstekhdamId,Com.tblItems_Estekhdam.fldTitle AS fldTitle,sum(abs(Pay.tblMohasebat_Items.fldMablagh)),fldYear,Com.fn_month(fldMonth) AS fldMonth
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId INNER JOIN
					  pay.tblMohasebat_PersonalInfo on Pay.tblMohasebat.fldid=pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId 
                       WHERE fldNobatPardakht=@NobatePardakht1 AND fldYear=@Year1 AND fldMonth=@Month1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1 and fldCalcType=@CalcType
					    AND Com.tblItemsHoghughi.fldId=76   
					  GROUP BY fldItemEstekhdamId, tblItems_Estekhdam.fldTitle,fldYear,fldMonth
UNION
SELECT     tblShobe.fldId,tblBank.fldBankName+N' شعبه '+ tblShobe.fldName AS fldName, SUM(Pay.tblMohasebat_KosoratBank.fldMablagh) AS fldMablagh 
,fldYear,Com.fn_month(fldMonth) AS fldMonth
FROM         Pay.tblMohasebat_KosoratBank INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMohasebat_KosoratBank.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
					  pay.tblMohasebat_PersonalInfo on Pay.tblMohasebat.fldid=pay.tblMohasebat_PersonalInfo.fldMohasebatId inner join
                      Pay.tblKosuratBank AS tblKosuratBank_1 ON Pay.tblMohasebat_KosoratBank.fldKosoratBankId = tblKosuratBank_1.fldId INNER JOIN
                      Com.tblSHobe AS tblShobe ON tblKosuratBank_1.fldShobeId = tblShobe.fldId INNER JOIN
                      Com.tblBank AS tblBank ON tblShobe.fldBankId = tblBank.fldId
                      WHERE fldNobatPardakht=@NobatePardakht1 AND fldYear=@Year1 AND fldMonth=@Month1  AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1 and fldCalcType=@CalcType
                      GROUP BY tblSHobe.fldId,tblBank.fldBankName, tblSHobe.fldName,fldYear,fldMonth
UNION
SELECT   0,N'ساير پرداخت ها',sum(fldAmount)  as fldKhalesPardakhti,@Year1,Com.fn_month(@Month1) AS fldMonth
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId  INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
					  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
       WHERE   fldYear=@Year1 AND fldMonth=@Month1 AND fldNobatePardakt=@NobatePardakht1 
					 and fldFlag=1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1 
					  and d.fldHesabTypeId>1 
GROUP BY fldYear,fldMonth   


UNION				         
SELECT    0,'کمک غير نقدي',sum(fldMablagh),@Year1,Com.fn_month(@Month1) AS fldMonth
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId   INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
					  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
                       WHERE fldYear=@Year1 AND fldMonth=@Month1 
					  and fldFlag=1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1 
					  and d.fldHesabTypeId>1 
GROUP BY fldYear,fldMonth 

UNION					         
SELECT   0,N'عيدي',sum(cast(fldKhalesPardakhti as bigint)),@Year1,Com.fn_month(@Month1) AS fldMonth
FROM         Pay.tblMohasebat_Eydi as e INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON e.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId    INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
					  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
                       WHERE  fldYear=@Year1 --AND fldMonth=@Month1 
					  and fldFlag=1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1 
					  and d.fldHesabTypeId>1   and fldOrganId=@organId1  
					  and   exists (select * from pay.tblMohasebat_Items as i inner join pay.tblMohasebat as m on m.fldId=i.fldMohasebatId 
						  inner join com.tblItems_Estekhdam as e2 on e2.fldId=i.fldItemEstekhdamId where m.fldPersonalId=e.fldPersonalId and m.fldYear=e.fldYear and m.fldMonth=@Month1  and fldItemsHoghughiId=74 and i.fldMablagh<>0)
GROUP BY fldYear,fldMonth 

UNION					         
SELECT    0,N'علي الحساب',sum(cast(t.fldKhalesPardakhti as bigint)),@Year1,Com.fn_month(@Month1) AS fldMonth
from(select distinct a.fldKhalesPardakhti
FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pa on pa.fldPrs_PersonalInfoId=p.fldId
	inner join pay.tblMohasebat as m on m.fldPersonalId=pa.fldId and m.fldYear=a.fldYear and m.fldMonth=a.fldMonth
	inner join pay.tblMohasebat_PersonalInfo as f on f.fldMohasebatId=m.fldId
	inner join com.tblShomareHesabeOmoomi as s on s.fldShomareHesab=a.fldShomareHesab
	inner join com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=s.fldId
                       WHERE  a.fldYear=@Year1 AND a.fldMonth=@Month1 and fldBankId=@BankId  and d.fldHesabTypeId>1 
					   AND f.fldOrganId=@organId1 and fldCalcType=@CalcType
					  and a.fldFlag=1)t
					  having sum(cast(t.fldKhalesPardakhti as bigint))>0
					  order by fldTitle

else
select fldId,fldTitle,sum(cast(fldMablagh as bigint))as fldMablagh,fldYear,fldMonth from(SELECT     Pay.tblParametrs.fldId, cast(Pay.tblParametrs.fldTitle COLLATE Latin1_General_CI_AI AS NVARCHAR(300))fldTitle, [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh
,fldYear,Com.fn_month(fldMonth) AS fldMonth
FROM         [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                      Pay.tblMohasebat ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
					  pay.tblMohasebat_PersonalInfo on Pay.tblMohasebat.fldid=pay.tblMohasebat_PersonalInfo.fldMohasebatId inner join
                      Pay.tblKosorateParametri_Personal ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldKosoratId = Pay.tblKosorateParametri_Personal.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId
                      WHERE fldCostCenterId=@costCenter1 and fldNobatPardakht=@NobatePardakht1 AND fldYear=@Year1 AND fldMonth=@Month1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1 and fldCalcType=@CalcType
)as d 
GROUP BY fldId, fldTitle,fldYear,fldMonth
union
SELECT      fldItemEstekhdamId,Com.tblItems_Estekhdam.fldTitle AS fldTitle,sum(abs(Pay.tblMohasebat_Items.fldMablagh)),fldYear,Com.fn_month(fldMonth) AS fldMonth
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId INNER JOIN
					  pay.tblMohasebat_PersonalInfo on Pay.tblMohasebat.fldid=pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId 
                       WHERE fldNobatPardakht=@NobatePardakht1 AND fldYear=@Year1 AND fldMonth=@Month1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1 and fldCalcType=@CalcType
					    AND Com.tblItemsHoghughi.fldId=76   
					  GROUP BY fldItemEstekhdamId, tblItems_Estekhdam.fldTitle,fldYear,fldMonth
UNION
SELECT     tblShobe.fldId,tblBank.fldBankName+N' شعبه '+ tblShobe.fldName AS fldName, SUM(Pay.tblMohasebat_KosoratBank.fldMablagh) AS fldMablagh 
,fldYear,Com.fn_month(fldMonth) AS fldMonth
FROM         Pay.tblMohasebat_KosoratBank INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMohasebat_KosoratBank.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
					  pay.tblMohasebat_PersonalInfo on Pay.tblMohasebat.fldid=pay.tblMohasebat_PersonalInfo.fldMohasebatId inner join
                      Pay.tblKosuratBank AS tblKosuratBank_1 ON Pay.tblMohasebat_KosoratBank.fldKosoratBankId = tblKosuratBank_1.fldId INNER JOIN
                      Com.tblSHobe AS tblShobe ON tblKosuratBank_1.fldShobeId = tblShobe.fldId INNER JOIN
                      Com.tblBank AS tblBank ON tblShobe.fldBankId = tblBank.fldId
                      WHERE fldCostCenterId=@costCenter1 and fldNobatPardakht=@NobatePardakht1 AND fldYear=@Year1 AND fldMonth=@Month1  AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1 and fldCalcType=@CalcType
                      GROUP BY tblSHobe.fldId,tblBank.fldBankName, tblSHobe.fldName,fldYear,fldMonth
UNION
SELECT   0,N'ساير پرداخت ها',sum(fldAmount)  as fldKhalesPardakhti,fldYear,Com.fn_month(fldMonth)fldMonth 
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId  INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
					  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
       WHERE  fldCostCenterId=@costCenter1 and  fldYear=@Year1 AND fldMonth=@Month1 AND fldNobatePardakt=@NobatePardakht1 
					 and fldFlag=1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1 
					  and d.fldHesabTypeId>1 
GROUP BY fldYear,fldMonth   


UNION				         
SELECT    0,'کمک غير نقدي',sum(fldMablagh),fldYear,Com.fn_month(fldMonth) AS fldMonth
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId   INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
					  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
                       WHERE fldCostCenterId=@costCenter1 and fldYear=@Year1 AND fldMonth=@Month1 
					  and fldFlag=1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1 
					  and d.fldHesabTypeId>1 
GROUP BY fldYear,fldMonth 

UNION					         
SELECT   0,N'عيدي',sum(fldKhalesPardakhti),fldYear,Com.fn_month(fldMonth) AS fldMonth
FROM         Pay.tblMohasebat_Eydi as e INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON e.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId    INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
					  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
                       WHERE fldCostCenterId=@costCenter1 and  fldYear=@Year1 AND fldMonth=@Month1 
					  and fldFlag=1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1 
					  and d.fldHesabTypeId>1  and fldOrganId=@organId1 and   exists (select * from pay.tblMohasebat_Items as i inner join pay.tblMohasebat as m on m.fldId=i.fldMohasebatId 
						  inner join com.tblItems_Estekhdam as e2 on e2.fldId=i.fldItemEstekhdamId where m.fldPersonalId=e.fldPersonalId and m.fldYear=e.fldYear and m.fldMonth=e.fldMonth and fldItemsHoghughiId=74 and i.fldMablagh<>0)
GROUP BY fldYear,fldMonth 

UNION					         
SELECT    0,N'علي الحساب',sum(cast(t.fldKhalesPardakhti as bigint)),@Year1,Com.fn_month(@Month1) AS fldMonth
from(select distinct a.fldKhalesPardakhti
FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId
	inner join pay.tblMohasebat as m on m.fldPersonalId=pay.fldId and m.fldYear=a.fldYear and m.fldMonth=a.fldMonth
	inner join pay.tblMohasebat_PersonalInfo as f on f.fldMohasebatId=m.fldId
	inner join com.tblShomareHesabeOmoomi as s on s.fldShomareHesab=a.fldShomareHesab
	inner join com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=s.fldId
                       WHERE  f.fldCostCenterId=@costCenter1 and  a.fldYear=@Year1 AND a.fldMonth=@Month1 and fldBankId=@BankId  and d.fldHesabTypeId>1 
					  and a.fldFlag=1
					  AND f.fldOrganId=@organId1 and fldCalcType=@CalcType)t
					  having sum(cast(t.fldKhalesPardakhti as bigint))>0
					  order by fldTitle
commit tran
GO
