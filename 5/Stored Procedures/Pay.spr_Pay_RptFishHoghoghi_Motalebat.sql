SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Pay].[spr_Pay_RptFishHoghoghi_Motalebat]
@fldPersonalId INT,
@NobatPardakht INT,
@Year SMALLINT,
@Month TINYINT
,@userId int,
@flag tinyint,
@CalcType TINYINT=1
 as
--declare @fldPersonalId int = 0,
--		@NobatPardakht int= 1,
--		@Year int = 1404,
--		@Month int= 4,
--@userId int=1 ,
--@flag tinyint=1,
--@CalcType TINYINT=1

BEGIN TRAN
declare @BankId int
declare @YearP SMALLINT=@Year,@MonthP TINYINT=@Month-1

if(@Month=1)
begin
	set @YearP=@Year-1
	set @MonthP=12
end
 SELECT top 1  @BankId=s.fldBankId FROM Pay.tblMohasebat as m
	  inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId 
	  inner join com.tblShomareHesabeOmoomi as s on s.fldId=p.fldShomareHesabId
        WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht AND fldPersonalId=@fldPersonalId
		 and fldCalcType=@CalcType

DECLARE @M TABLE(fldId int,payId int)
IF @fldPersonalId <>0
INSERT INTO @M
      SELECT fldId,fldPersonalId FROM Pay.tblMohasebat
        WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht AND fldPersonalId=@fldPersonalId
		 and fldCalcType=@CalcType
ELSE
INSERT INTO @M
      SELECT fldId,fldPersonalId FROM Pay.tblMohasebat
        WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht 
		 and fldCalcType=@CalcType

DECLARE @temp TABLE(fldId INT IDENTITY,fldTitle nvarchar(500),fldMablagh int,fldPersonalId int)
declare @hog table(id int primary key)
insert into @hog select 1 union select 2 union select 3 union select 4 union select 5 union select 30 union select 31 union select 38
INSERT INTO @temp
select N'حقوق',fldMablagh,fldPersonalId from (select sum(fldMablagh)as fldMablagh,fldMohasebatId from pay.tblMohasebat_Items
inner join com.tblItems_Estekhdam on pay.tblMohasebat_Items.fldItemEstekhdamId=com.tblItems_Estekhdam.fldId
inner join @M as m on m.fldId=pay.tblMohasebat_Items.fldMohasebatId
where fldItemsHoghughiId in(select id from @hog)  
group by fldMohasebatId)as d
inner join pay.tblMohasebat on pay.tblMohasebat.fldId=fldMohasebatId
--SELECT      N'حقوق' AS fldTitle,(SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh),0)
--									FROM         Pay.tblMohasebat_Items INNER JOIN
									--Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
									--Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId
									-- WHERE fldMohasebatId =Pay.tblMohasebat.fldId AND Com.tblItemsHoghughi.fldId IN (1,2,3,4,5,30,31,38)),
									--fldPersonalId
--FROM         Pay.tblMohasebat 
--                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M) 
INSERT INTO @temp
SELECT      Com.tblItems_Estekhdam.fldTitle AS fldTitle,Pay.tblMohasebat_Items.fldMablagh,Pay.tblMohasebat.fldPersonalId
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId 
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M) AND Com.tblItemsHoghughi.fldId NOT IN (1,2,3,4,5,30,31,33,34,35,36,38,19,47,48,21,49,50,20,51,52,54,60,61,62,44,45,68,76)   
					   and (tblMohasebat_Items.fldHesabTypeItemId<>1 or fldHesabTypeItemId is null)
INSERT INTO @temp
SELECT      Com.tblItems_Estekhdam.fldTitle AS fldTitle,sum(Pay.tblMohasebat_Items.fldMablagh),Pay.tblMohasebat.fldPersonalId
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId 
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M) AND Com.tblItemsHoghughi.fldId =68
					   and (tblMohasebat_Items.fldHesabTypeItemId<>1 or fldHesabTypeItemId is null)
					   group by tblItems_Estekhdam.fldTitle ,Pay.tblMohasebat.fldPersonalId
INSERT INTO @temp
        SELECT      Com.tblItems_Estekhdam.fldTitle AS fldTitle,Pay.tblMohasebat_Items.fldMablagh,Pay.tblMohasebat.fldPersonalId
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId 
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M) AND Com.tblItemsHoghughi.fldId  IN (33,34,35,36)   

INSERT INTO @temp
select N'تجمیع تفاوت بند(ی) و جزء1',fldMablagh,fldPersonalId from (select sum(fldMablagh)as fldMablagh,fldMohasebatId from pay.tblMohasebat_Items
inner join com.tblItems_Estekhdam on pay.tblMohasebat_Items.fldItemEstekhdamId=com.tblItems_Estekhdam.fldId
inner join @M as m on m.fldId=pay.tblMohasebat_Items.fldMohasebatId
where fldItemsHoghughiId in(44,45)
group by fldMohasebatId)as d
inner join pay.tblMohasebat on pay.tblMohasebat.fldId=fldMohasebatId

declare @jazb table(id int primary key)
insert into @jazb select 19 union select 47 union select 48  union select 60
INSERT INTO @temp
select N'فوق العاده جذب',fldMablagh,fldPersonalId from (select sum(fldMablagh)as fldMablagh,fldMohasebatId from pay.tblMohasebat_Items
inner join com.tblItems_Estekhdam on pay.tblMohasebat_Items.fldItemEstekhdamId=com.tblItems_Estekhdam.fldId
inner join @M as m on m.fldId=pay.tblMohasebat_Items.fldMohasebatId
where fldItemsHoghughiId in(select id from @jazb)
group by fldMohasebatId)as d
inner join pay.tblMohasebat on pay.tblMohasebat.fldId=fldMohasebatId
--SELECT      N'فوق العاده جذب' AS fldTitle,(SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh),0)
--									FROM         Pay.tblMohasebat_Items INNER JOIN
--														  Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
--														  Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId WHERE fldMohasebatId =Pay.tblMohasebat.fldId AND Com.tblItemsHoghughi.fldId IN (19,47,48)),
--														  fldPersonalId
--FROM         Pay.tblMohasebat 
--                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M) 
declare @vije table(id int primary key)
insert into @vije select 21 union select 49 union select 50 union select 61
INSERT INTO @temp
select N'فوق العاده ویژه',fldMablagh,fldPersonalId from (select sum(fldMablagh)as fldMablagh,fldMohasebatId from pay.tblMohasebat_Items
inner join com.tblItems_Estekhdam on pay.tblMohasebat_Items.fldItemEstekhdamId=com.tblItems_Estekhdam.fldId
inner join @M as m on m.fldId=pay.tblMohasebat_Items.fldMohasebatId
where fldItemsHoghughiId in(select id from @vije)
group by fldMohasebatId)as d
inner join pay.tblMohasebat on pay.tblMohasebat.fldId=fldMohasebatId
--SELECT      N'فوق العاده ویژه' AS fldTitle,(SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh),0)
--									FROM         Pay.tblMohasebat_Items INNER JOIN
--														  Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
--														  Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId WHERE fldMohasebatId =Pay.tblMohasebat.fldId AND Com.tblItemsHoghughi.fldId IN (21,49,50)),
--														  fldPersonalId
--FROM         Pay.tblMohasebat 
--                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M) 
declare @makhsos table(id int primary key)
insert into @makhsos select 20 union select 51 union select 52
INSERT INTO @temp
select N'فوق العاده مخصوص',fldMablagh,fldPersonalId from (select sum(fldMablagh)as fldMablagh,fldMohasebatId from pay.tblMohasebat_Items
inner join com.tblItems_Estekhdam on pay.tblMohasebat_Items.fldItemEstekhdamId=com.tblItems_Estekhdam.fldId
inner join @M as m on m.fldId=pay.tblMohasebat_Items.fldMohasebatId
where fldItemsHoghughiId in(select id from @makhsos)
group by fldMohasebatId)as d
inner join pay.tblMohasebat on pay.tblMohasebat.fldId=fldMohasebatId

declare @khas table(id int primary key)
insert into @khas select 54 union select 62 
INSERT INTO @temp
select N'فوق العاده خاص',fldMablagh,fldPersonalId from (select sum(fldMablagh)as fldMablagh,fldMohasebatId from pay.tblMohasebat_Items
inner join com.tblItems_Estekhdam on pay.tblMohasebat_Items.fldItemEstekhdamId=com.tblItems_Estekhdam.fldId
inner join @M as m on m.fldId=pay.tblMohasebat_Items.fldMohasebatId
where fldItemsHoghughiId in(select id from @khas)
group by fldMohasebatId)as d
inner join pay.tblMohasebat on pay.tblMohasebat.fldId=fldMohasebatId
--SELECT      N'فوق العاده مخصوص' AS fldTitle,(SELECT     ISNULL(SUM(Pay.tblMohasebat_Items.fldMablagh),0)
--									FROM         Pay.tblMohasebat_Items INNER JOIN
--														  Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
--														  Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId WHERE fldMohasebatId =Pay.tblMohasebat.fldId AND Com.tblItemsHoghughi.fldId IN (20,51,52)),
--														  fldPersonalId
--FROM         Pay.tblMohasebat 
--                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M) 
                    
 --       INSERT INTO @temp
 --       SELECT     N'اضافه کار' AS fldTitle,Pay.tblMohasebat.fldEzafeKar,Pay.tblMohasebat.fldPersonalId
	--FROM         Pay.tblMohasebat 
 --                     WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
                   
 --       INSERT INTO @temp
 --       SELECT     N'تعطیل کاری' AS fldTitle,Pay.tblMohasebat.fldTatilKar,Pay.tblMohasebat.fldPersonalId
	--FROM         Pay.tblMohasebat 
 --                     WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
                    
 --       INSERT INTO @temp
 --       SELECT     N'ماموریت' AS fldTitle,Pay.tblMohasebat.fldMamoriyat,Pay.tblMohasebat.fldPersonalId
	--FROM         Pay.tblMohasebat 
 --                     WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
                   
        INSERT INTO @temp
        SELECT     N'بیمه عمر کارفرما' AS fldTitle, Pay.tblMohasebat.fldBimeOmrKarFarma,Pay.tblMohasebat.fldPersonalId
	FROM         Pay.tblMohasebat 
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
                  
        INSERT INTO @temp
        SELECT     N'بیمه تکمیلی کارفرما' AS fldTitle,  Pay.tblMohasebat.fldBimeTakmilyKarFarma,Pay.tblMohasebat.fldPersonalId
	FROM         Pay.tblMohasebat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId =  Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId=Prs.Prs_tblPersonalInfo.fldId INNER join
                      Com.tblEmployee AS tblEmployee  ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
                  
        INSERT INTO @temp
		select  N'حق درمان کارفرما' AS fldTitle,sum(fldMablagh),fldPersonalId from(
		select fldHaghDarmanKarfFarma as fldMablagh,fldId as fldMohasebatId FROM         Pay.tblMohasebat
		WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
		union all
		SELECT    SUM(fldHaghDarmanKarfFarma),fldMohasebatId FROM Pay.tblMoavaghat WHERE fldMohasebatId IN(SELECT fldId FROM @M) group by fldMohasebatId
		union all
		select fldHaghDarmanDolat,fldId FROM         Pay.tblMohasebat
		WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
		union all
		SELECT    SUM(fldHaghDarmanDolat),fldMohasebatId FROM Pay.tblMoavaghat WHERE fldMohasebatId IN(SELECT fldId FROM @M)group by fldMohasebatId
		)as g
		inner join pay.tblMohasebat on pay.tblMohasebat.fldId=g.fldMohasebatId
		group by fldPersonalId
 --       SELECT     N'حق درمان کارفرما' AS fldTitle, (Pay.tblMohasebat.fldHaghDarmanKarfFarma+
	--	ISNULL((SELECT    SUM(fldHaghDarmanKarfFarma) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0))+
	--	 (Pay.tblMohasebat.fldHaghDarmanDolat+ISNULL((SELECT    SUM(fldHaghDarmanDolat) 
	--	 FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)),Pay.tblMohasebat.fldPersonalId
	--FROM         Pay.tblMohasebat 
 --                     WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)

                
 --       INSERT INTO @temp
 --       SELECT    N'نوبت کاری' AS fldTitle, Pay.tblMohasebat.fldTedadNobatKari,Pay.tblMohasebat.fldPersonalId
	--FROM         Pay.tblMohasebat 
 --                     WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
                    
        INSERT INTO @temp
        SELECT     N'پس انداز کارفرما' AS fldTitle, Pay.tblMohasebat.fldPasAndaz/2+ISNULL((SELECT    SUM(fldPasAndaz/2) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldPasAndaz,Pay.tblMohasebat.fldPersonalId
	FROM         Pay.tblMohasebat 
                      WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)


              
-- --   INSERT INTO @temp
-- --       SELECT     N'سنوات پایان خدمت' AS fldTitle, Pay.tblMohasebat.fldSPayanKhedmat,Pay.tblMohasebat.fldPersonalId
--	--FROM         Pay.tblMohasebat 
-- --                     WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)
   

INSERT INTO @temp
SELECT      Pay.tblParametrs.fldTitle,[Pay].[tblMohasebat_kosorat/MotalebatParam].fldMablagh,Pay.tblMohasebat.fldPersonalId
FROM         Pay.tblMohasebat INNER JOIN
                      [Pay].[tblMohasebat_kosorat/MotalebatParam] ON Pay.tblMohasebat.fldId = [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId INNER JOIN
                      Pay.tblMotalebateParametri_Personal ON [Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId = Pay.tblMotalebateParametri_Personal.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId
WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M) AND 
                      ([Pay].[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId IS NOT NULL)
					  and [tblMohasebat_kosorat/MotalebatParam].fldHesabTypeParamId>1
 
 
INSERT INTO @temp
SELECT     N'معوقه ' +CAST(COUNT(*) AS NVARCHAR(5))+  N' ماهه ' AS fldTitle,
--SUM(Pay.tblMoavaghat.fldEzafeKar)+SUM(Pay.tblMoavaghat.fldTatilKar)+
--SUM(Pay.tblMoavaghat.fldMamoriyat)+SUM(Pay.tblMoavaghat.fldNobatKari)+SUM(Pay.tblMoavaghat.fldSPayanKhedmat)              
+
ISNULL((SELECT     SUM(Pay.tblMoavaghat_Items.fldMablagh) AS Expr1
FROM         Pay.tblMoavaghat_Items INNER JOIN
                      Pay.tblMoavaghat ON Pay.tblMoavaghat_Items.fldMoavaghatId = Pay.tblMoavaghat.fldId INNER JOIN
                      Pay.tblMohasebat AS m ON Pay.tblMoavaghat.fldMohasebatId = m.fldId  
                      WHERE m.fldId=Pay.tblMohasebat.fldId  and Pay.tblMoavaghat_Items.fldMablagh>0 
					  and (tblMoavaghat_Items.fldHesabTypeItemId<>1 or fldHesabTypeItemId is null) ),0),Pay.tblMohasebat.fldPersonalId

FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMoavaghat.fldMohasebatId = Pay.tblMohasebat.fldId 
                       WHERE Pay.tblMohasebat.fldId IN(SELECT fldId FROM @M)  
                  GROUP BY Pay.tblMohasebat.fldId ,Pay.tblMohasebat.fldPersonalId   
				  
insert @temp
select N'معوقه متمم',sum(o.fldMablagh) as fldMablaghMotamam,m2.fldPersonalId from pay.tblMohasebat as m2 
			inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
            inner join @m as m on m.payId=m2.fldPersonalId
			where  m2.fldYear= @YearP and m2.fldMonth=@MonthP and o.fldMablagh>0
            group by m2.fldPersonalId 


if(@flag=1)/*فیش حقوقی*/
begin
	INSERT INTO @temp
	SELECT    N'سایر پرداخت ها',sum(fldAmount),fldPersonalId
	FROM         Pay.tblSayerPardakhts INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId  INNER JOIN
						  Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
						  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
		   WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatePardakt=@NobatPardakht 
						  AND  Pay.tblSayerPardakhts.fldPersonalId=@fldPersonalId  --and fldMaliyat>0 
						  and d.fldHesabTypeId>1 
	GROUP BY fldPersonalId   


	INSERT INTO @temp					         
	SELECT    N'کمک غیر نقدی',sum(fldMablagh),fldPersonalId
	FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
						  Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId   INNER JOIN
						  Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
						  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
						   WHERE fldYear=@Year AND fldMonth=@Month 
						 AND Pay.tblKomakGheyerNaghdi.fldPersonalId=@fldPersonalId --and fldMaliyat>0 
						  and d.fldHesabTypeId>1 
	GROUP BY fldPersonalId 
end


SELECT *  FROM @temp tem
 

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
