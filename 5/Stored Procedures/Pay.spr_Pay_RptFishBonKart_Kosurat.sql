SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptFishBonKart_Kosurat]
 
@Year SMALLINT,
@Month TINYINT,
@NobatPardakht INT,
@fldPersonalId INT,
@OrganId int ,
@userId int,
@CalcType TINYINT=1
AS 
BEGIN TRAN
declare @salP SMALLINT=@Year,@mahP TINYINT=@Month-1

if(@Month=1)
begin
	set @salP=@Year-1
	set @mahP=12
end

declare @BankId int
 SELECT top 1  @BankId=s.fldBankId FROM Pay.tblMohasebat as m
	  inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId 
	  inner join com.tblShomareHesabeOmoomi as s on s.fldId=p.fldShomareHesabId
        WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht and fldOrganId=@OrganId
		and fldCalcType=@CalcType

DECLARE @M TABLE(fldId int,payId int)
IF @fldPersonalId <>0
INSERT INTO @M
      SELECT fldId,fldPersonalId FROM Pay.tblMohasebat
        WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht AND fldPersonalId=@fldPersonalId and fldCalcType=@CalcType
ELSE
INSERT INTO @M
      SELECT m.fldId,fldPersonalId FROM Pay.tblMohasebat as m
	  inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
        WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht and fldOrganId=@OrganId and fldCalcType=@CalcType

DECLARE @temp TABLE(fldId INT IDENTITY,fldTitle nvarchar(100),fldMablagh int,fldPersonalId int)

 INSERT INTO @temp
    --SELECT     Pay.tblParametrs.fldTitle,(case when fldMondeFish=1 then N'('+ cast(fldMondeGHabl-SUM([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh) over (partition by fldParametrId ) As nvarchar(200))+')' else  [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh end),Pay.tblMohasebat.fldPersonalId
SELECT     Pay.tblParametrs.fldTitle/*+dbo.func_MandeOrJam(fldkosoratid)*/,[Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh,Pay.tblMohasebat.fldPersonalId
FROM         [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                      Pay.tblKosorateParametri_Personal ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldKosoratId = Pay.tblKosorateParametri_Personal.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Pay.tblMohasebat ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M) AND fldKosoratId IS NOT NULL
					  and fldHesabTypeParam=1
 INSERT INTO @temp
SELECT     N'معوقه منفی ' +CAST(COUNT(*) AS NVARCHAR(5))+  N' ماهه ' AS fldTitle,
--SUM(Pay.tblMoavaghat.fldEzafeKar)+SUM(Pay.tblMoavaghat.fldTatilKar)+
--SUM(Pay.tblMoavaghat.fldMamoriyat)+SUM(Pay.tblMoavaghat.fldNobatKari)+SUM(Pay.tblMoavaghat.fldSPayanKhedmat)              
+
ISNULL((SELECT    abs( SUM(Pay.tblMoavaghat_Items.fldMablagh)) AS Expr1
FROM         Pay.tblMoavaghat_Items INNER JOIN
                      Pay.tblMoavaghat ON Pay.tblMoavaghat_Items.fldMoavaghatId = Pay.tblMoavaghat.fldId INNER JOIN
                      Pay.tblMohasebat AS m ON Pay.tblMoavaghat.fldMohasebatId = m.fldId  
                      WHERE m.fldId=Pay.tblMohasebat.fldId  and Pay.tblMoavaghat_Items.fldMablagh<0   and tblMoavaghat_Items.fldHesabTypeItemId=1),0),Pay.tblMohasebat.fldPersonalId

FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMoavaghat.fldMohasebatId = Pay.tblMohasebat.fldId 
                       WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)  
                  GROUP BY Pay.tblMohasebat.fldId ,Pay.tblMohasebat.fldPersonalId  

 insert @temp
 select N'معوقه منفی متمم',sum(o.fldMablagh) as fldMablaghMotamam,m2.fldPersonalId from pay.tblMohasebat as m2 
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                inner join @m as m on m.payId=m2.fldPersonalId
								where  m2.fldYear= @salP and m2.fldMonth=@mahP and o.fldMablagh<0
                                group by m2.fldPersonalId 

INSERT INTO @temp
SELECT    N'سایر پرداخت ها',sum(fldAmount),fldPersonalId
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId  INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
					  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
       WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatePardakt=@NobatPardakht 
					  AND  exists (select * from @M  where payId=Pay.tblSayerPardakhts.fldPersonalId ) and fldFlag=1 
					  and d.fldHesabTypeId=1 
GROUP BY fldPersonalId   


INSERT INTO @temp					         
SELECT    N'کمک غیر نقدی',sum(fldMablagh),fldPersonalId
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId   INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
					  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
                       WHERE fldYear=@Year AND fldMonth=@Month 
					  AND  exists (select * from @M  where payId=tblKomakGheyerNaghdi.fldPersonalId ) and fldFlag=1 
					  and d.fldHesabTypeId=1 
GROUP BY fldPersonalId 

INSERT INTO @temp					         
SELECT    N'عیدی',sum(fldMablagh),fldPersonalId
FROM         Pay.tblMohasebat_Eydi as e INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON e.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId    INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
					  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
                       WHERE fldYear=@Year AND fldMonth=@Month 
					  AND  exists (select * from @M  where payId=e.fldPersonalId ) and fldFlag=1
					  and d.fldHesabTypeId=1 
GROUP BY fldPersonalId 

INSERT INTO @temp					         
SELECT    N'علی الحساب',sum( fldKhalesPardakhti),t.fldId from
(select distinct a.fldKhalesPardakhti,pay.fldId
FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId
	inner join pay.tblMohasebat as m on m.fldPersonalId=pay.fldId and m.fldYear=a.fldYear and m.fldMonth=a.fldMonth
	inner join com.tblShomareHesabeOmoomi as s on s.fldShomareHesab=a.fldShomareHesab
	inner join com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=s.fldId
                       WHERE a.fldYear=@Year AND a.fldMonth=@Month and fldBankId=@BankId  and d.fldHesabTypeId=1 
					  AND  exists (select * from @M  where payId=pay.fldId ) and a.fldFlag=1
					  )t
GROUP BY t.fldId 


SELECT *,sum(fldMablagh) over (partition by fldPersonalId ) as fldJamKosurat FROM @temp tem
/*cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														inner join pay.pay_tblPersonalInfo p on p.fldPrs_PersonalInfoId=fldPrsPersonalInfoId
														where p.fldid= fldPersonalId
														order by fldTarikh desc)history
														where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId)typeestekhdam*/
WHERE fldMablagh<>0    
and exists (select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														inner join pay.pay_tblPersonalInfo p on p.fldPrs_PersonalInfoId=fldPrsPersonalInfoId
														where p.fldid=tem.fldPersonalId
														order by fldTarikh desc)history
														where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
														group by  t.fldTypeEstekhamId)

COMMIT
GO
