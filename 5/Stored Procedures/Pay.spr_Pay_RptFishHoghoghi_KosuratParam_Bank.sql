SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptFishHoghoghi_KosuratParam_Bank]
 
@Year SMALLINT,
@Month TINYINT,
@NobatPardakht INT,
@fldPersonalId INT,
@OrganId int ,
@userId int,
@flag tinyint,
@CalcType TINYINT=1
AS 
BEGIN TRAN
declare @YearP SMALLINT=@Year,@MonthP TINYINT=@Month-1

if(@Month=1)
begin
	set @YearP=@Year-1
	set @MonthP=12
end

declare @BankId int
 SELECT top 1  @BankId=s.fldBankId FROM Pay.tblMohasebat as m
	  inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId 
	  inner join com.tblShomareHesabeOmoomi as s on s.fldId=p.fldShomareHesabId
        WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht and fldOrganId=@OrganId and fldCalcType=@CalcType

DECLARE @M TABLE(fldId int,payId int)
IF @fldPersonalId <>0
INSERT INTO @M
      SELECT m.fldId,m.fldPersonalId FROM Pay.tblMohasebat as m
        WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht AND fldPersonalId=@fldPersonalId and fldCalcType=@CalcType
ELSE
INSERT INTO @M
      SELECT m.fldId,m.fldPersonalId FROM Pay.tblMohasebat as m
	  inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
        WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht and fldOrganId=@OrganId and fldCalcType=@CalcType


DECLARE @temp TABLE(fldId INT IDENTITY,fldTitle nvarchar(100),fldMablagh int,fldPersonalId int)

INSERT INTO @temp
        SELECT     CASE WHEN (Pay.tblMohasebat_PersonalInfo.fldTypeBimeId = 1) THEN N'حق بیمه' ELSE N'حق بازنشستگی' END AS fldTitle,
         Pay.tblMohasebat.fldBimePersonal + ISNULL ((SELECT     SUM(fldBimePersonal) AS Expr1  FROM    Pay.tblMoavaghat  WHERE     (fldMohasebatId = Pay.tblMohasebat.fldId)), 0) AS fldBimePersonal
        ,Pay.tblMohasebat.fldPersonalId
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
                       WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)

       INSERT INTO @temp
        SELECT     N'مالیات' AS fldTitle, (ISNULL(Pay.tblMohasebat.fldMaliyat,0)+ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0))),Pay.tblMohasebat.fldPersonalId
	FROM         Pay.tblMohasebat
                     WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
 INSERT INTO @temp
        SELECT     N'حق درمان' AS fldTitle,Pay.tblMohasebat.fldHaghDarman+ISNULL((SELECT    SUM(fldHaghDarman) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)AS fldTatilKar,Pay.tblMohasebat.fldPersonalId
	FROM         Pay.tblMohasebat 
       WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
        
        INSERT INTO @temp
        SELECT     N'بیمه عمر' AS fldTitle,Pay.tblMohasebat.fldBimeOmr,Pay.tblMohasebat.fldPersonalId
	FROM         Pay.tblMohasebat 
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)

        INSERT INTO @temp
        SELECT     N'بیمه تکمیلی' AS fldTitle,Pay.tblMohasebat.fldBimeTakmily,Pay.tblMohasebat.fldPersonalId
	FROM         Pay.tblMohasebat INNER JOIN
                      pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = pay.Pay_tblPersonalInfo.fldId INNER JOIN
					  prs.Prs_tblPersonalInfo on pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId =prs.Prs_tblPersonalInfo .fldid INNER JOIN
                      Com.tblEmployee AS tblEmployee ON prs.Prs_tblPersonalInfo .fldEmployeeId=tblEmployee.fldid
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
                    
       
        
        INSERT INTO @temp
        SELECT     N'مساعده' AS fldTitle,  Pay.tblMohasebat.fldMosaede,Pay.tblMohasebat.fldPersonalId
	FROM         Pay.tblMohasebat 
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)

        INSERT INTO @temp
        SELECT     N'قسط وام' AS fldTitle, Pay.tblMohasebat.fldGhestVam,Pay.tblMohasebat.fldPersonalId
	FROM         Pay.tblMohasebat 
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
           INSERT INTO @temp
        SELECT     N' پس انداز' AS fldTitle, Pay.tblMohasebat.fldPasAndaz+ISNULL((SELECT    SUM(fldPasAndaz) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0),Pay.tblMohasebat.fldPersonalId
	FROM         Pay.tblMohasebat
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
  INSERT INTO @temp
        SELECT     N'مقرری ماه اول' AS fldTitle, Pay.tblMohasebat.fldMogharari,Pay.tblMohasebat.fldPersonalId
	FROM         Pay.tblMohasebat
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
INSERT INTO @temp
    --SELECT     Pay.tblParametrs.fldTitle,(case when fldMondeFish=1 then N'('+ cast(fldMondeGHabl-SUM([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh) over (partition by fldParametrId ) As nvarchar(200))+')' else  [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh end),Pay.tblMohasebat.fldPersonalId
SELECT     Pay.tblParametrs.fldTitle/*+dbo.func_MandeOrJam(fldkosoratid)*/,[Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh,Pay.tblMohasebat.fldPersonalId
FROM         [Pay].[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                      Pay.tblKosorateParametri_Personal ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldKosoratId = Pay.tblKosorateParametri_Personal.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Pay.tblMohasebat ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M) AND fldKosoratId IS NOT NULL
					  and [tblMohasebat_kosorat/MotalebatParam].fldHesabTypeParamId>1
 INSERT INTO @temp
      SELECT     tblBank.fldBankName + N' شعبه ' + tblSHobe.fldName AS Expr1, Pay.tblMohasebat_KosoratBank.fldMablagh,Pay.tblMohasebat.fldPersonalId
FROM         Pay.tblMohasebat_KosoratBank INNER JOIN
                      Pay.tblKosuratBank ON Pay.tblMohasebat_KosoratBank.fldKosoratBankId = Pay.tblKosuratBank.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank AS tblBank ON tblSHobe.fldBankId = tblBank.fldId INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMohasebat_KosoratBank.fldMohasebatId = Pay.tblMohasebat.fldId
                       WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
 INSERT INTO @temp
SELECT     N'معوقه منفی ' +CAST(COUNT(*) AS NVARCHAR(5))+  N' ماهه ' AS fldTitle,
--SUM(Pay.tblMoavaghat.fldEzafeKar)+SUM(Pay.tblMoavaghat.fldTatilKar)+
--SUM(Pay.tblMoavaghat.fldMamoriyat)+SUM(Pay.tblMoavaghat.fldNobatKari)+SUM(Pay.tblMoavaghat.fldSPayanKhedmat)              
+
ISNULL((SELECT    abs( SUM(Pay.tblMoavaghat_Items.fldMablagh)) AS Expr1
FROM         Pay.tblMoavaghat_Items INNER JOIN
                      Pay.tblMoavaghat ON Pay.tblMoavaghat_Items.fldMoavaghatId = Pay.tblMoavaghat.fldId INNER JOIN
                      Pay.tblMohasebat AS m ON Pay.tblMoavaghat.fldMohasebatId = m.fldId  
                      WHERE m.fldId=Pay.tblMohasebat.fldId  and Pay.tblMoavaghat_Items.fldMablagh<0  
					  and (tblMoavaghat_Items.fldHesabTypeItemId<>1 or fldHesabTypeItemId is null)  ),0),Pay.tblMohasebat.fldPersonalId

FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMoavaghat.fldMohasebatId = Pay.tblMohasebat.fldId 
                       WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)  
                  GROUP BY Pay.tblMohasebat.fldId ,Pay.tblMohasebat.fldPersonalId  

				  insert @temp
 select N'معوقه منفی متمم',abs(sum(o.fldMablagh)) as fldMablaghMotamam,m2.fldPersonalId from pay.tblMohasebat as m2 
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                inner join @m as m on m.payId=m2.fldPersonalId
								where  m2.fldYear= @YearP and m2.fldMonth=@MonthP and o.fldMablagh<0
                                group by m2.fldPersonalId 
INSERT INTO @temp
SELECT      Com.tblItems_Estekhdam.fldTitle AS fldTitle,abs(Pay.tblMohasebat_Items.fldMablagh),Pay.tblMohasebat.fldPersonalId
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId 
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M) AND Com.tblItemsHoghughi.fldId=76   
					   and (tblMohasebat_Items.fldHesabTypeItemId<>1 or fldHesabTypeItemId is null)
if(@flag=1)/*فیش حقوقی*/
begin
	INSERT INTO @temp
	SELECT    N'سایر پرداخت ها',sum(fldAmount),fldPersonalId
	FROM         Pay.tblSayerPardakhts INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId  INNER JOIN
						  Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
						  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
		   WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatePardakt=@NobatPardakht 
						  AND  exists (select * from @M  where payId=Pay.tblSayerPardakhts.fldPersonalId ) and fldFlag=1 
						  and d.fldHesabTypeId>1 
	GROUP BY fldPersonalId   


	INSERT INTO @temp					         
	SELECT    N'کمک غیر نقدی',sum(fldMablagh),fldPersonalId
	FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId   INNER JOIN
						  Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
						  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
						   WHERE fldYear=@Year AND fldMonth=@Month 
						  AND  exists (select * from @M  where payId=tblKomakGheyerNaghdi.fldPersonalId ) and fldFlag=1 
						  and d.fldHesabTypeId>1 
	GROUP BY fldPersonalId 

	INSERT INTO @temp					         
	SELECT    N'عیدی',sum(fldKhalesPardakhti),fldPersonalId
	FROM         Pay.tblMohasebat_Eydi as e INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON e.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId    INNER JOIN
						  Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
						  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
						   WHERE fldYear=@Year --AND fldMonth=@Month 
						 and fldFlag=1
						  and d.fldHesabTypeId>1 and exists (select * from pay.tblMohasebat_Items as i inner join @m as m on m.fldId=i.fldMohasebatId 
						  inner join com.tblItems_Estekhdam as e2 on e2.fldId=i.fldItemEstekhdamId where m.payId=e.fldPersonalId and fldItemsHoghughiId=74 and i.fldMablagh<>0)
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
						   WHERE a.fldYear=@Year AND a.fldMonth=@Month and fldBankId=@BankId  and d.fldHesabTypeId>1 
						  AND  exists (select * from @M  where payId=pay.fldId ) and a.fldFlag=1
						  )t
	GROUP BY t.fldId 
end
SELECT * FROM @temp tem
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
