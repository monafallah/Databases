SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_SelectVariziForBank] (@FieldName NVARCHAR(50), @year SMALLINT,@Month TINYINT,@NobatPardakht TINYINT,@MarhalePardakht TINYINT,@OrgnId INT,@Value nvarchar(500) )
AS
declare @FieldName1 NVARCHAR(50), @year1 SMALLINT,@Month1 TINYINT,@NobatPardakht1 TINYINT,@MarhalePardakht1 TINYINT,@OrgnId1 INT
set @FieldName1=@FieldName
set @year1=@year
set @Month1=@Month
set @NobatPardakht1=@NobatPardakht
set @MarhalePardakht1=@MarhalePardakht
set @OrgnId1=@OrgnId

declare @YearP SMALLINT=@year,@MonthP TINYINT=@Month-1

if(@Month=1)
begin
	set @YearP=@year-1
	set @MonthP=12
end

IF(@FieldName1='Hoghogh')
BEGIN
	IF(@NobatPardakht1<>0)
	select * from (
SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName, 
--ISNULL(ISNULL(Pay.tblMohasebat.fldkhalesPardakhti,0)+ISNULL((SELECT SUM(fldkhalesPardakhti) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) ,0)AS 
 ( CAST( ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId<>1 and fldItemsHoghughiId<>76),0)
 +isnull((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldId 
 AND fldKosoratId IS NULL and fldHesabTypeParamId>1 ),0)+fldHaghDarmanKarfFarma+fldHaghDarmanDolat
 +(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma+fldBimeOmrKarFarma+fldBimeKarFarma+fldBimeBikari+
					    ISNULL((SELECT   DISTINCT SUM(fldMablagh)   OVER (PARTITION BY fldMohasebatId) 
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						 WHERE fldMohasebatId=Pay.tblMohasebat.fldId and tblMoavaghat_Items.fldHesabTypeItemId<>1) ,0)
						 + ISNULL((SELECT SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat
						 +(Pay.tblMoavaghat.fldPasAndaz/2)
						 +Pay.tblMoavaghat.fldBimeBikari+Pay.tblMoavaghat.fldBimeKarFarma )
						  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid GROUP BY fldMohasebatId),0)	
						  +isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@Year ,@Month ,fldHesabTypeId )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@Year ,@Month,@NobatPardakht ,fldHesabTypeId )),0)
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP 
								 and o.fldHesabTypeItemId<>1 ),0) 							 
						
                        AS BIGINT))-
						 ( CAST( ISNULL((SELECT abs(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId=76),0)+
						 (ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL and fldHesabTypeParamId>1 ),0)
+ISNULL((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
+fldMosaede+fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari+fldMaliyat+fldHaghDarman+Pay.tblMohasebat.fldPasAndaz
+Pay.tblMohasebat.fldGhestVam+fldBimeTakmily+Pay.tblMohasebat.fldBimeOmr)+
					    ISNULL(Com.fn_IsMaliyatforMohasebe(Pay.tblMohasebat.fldId),0)
						+ISNULL((SELECT sum(fldBimePersonal+fldPasAndaz+fldHaghDarman+fldBimeKarFarma+fldBimeBikari ) 
						FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@Year ,@Month ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@Year ,@Month ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@Year ,@Month,@NobatPardakht ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_OnAccount]( fldPersonalId,@Year ,@Month,@NobatPardakht ,fldHesabTypeId,fldBankId )),0)
						AS bigint) ) 
						fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
, (ISNULL(Pay.tblMohasebat.fldMaliyat,0)+ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0))) AS fldMaliyat
,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat.fldPersonalId as fldPayPersonalId
,0 AS fldMablagh
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                         WHERE Pay.tblMohasebat.fldYear=@year1 AND Pay.tblMohasebat.fldMonth=@Month1 AND fldNobatPardakht=@NobatPardakht1 and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1
				 and fldCalcType=1
						 )t

						 --where fldkhalesPardakhti<=0
						  order by fldFamily
ELSE 
	SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,
	--,ISNULL( ISNULL(Pay.tblMohasebat.fldkhalesPardakhti,0)+ISNULL((SELECT SUM(fldkhalesPardakhti) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0),0) AS fldkhalesPardakhti
( CAST( ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId<>1 and fldItemsHoghughiId<>76),0)
+isnull((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NULL and fldHesabTypeParamId>1 ),0)+fldHaghDarmanKarfFarma+fldHaghDarmanDolat+(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma+fldBimeOmrKarFarma+fldBimeKarFarma+fldBimeBikari+
					    ISNULL((SELECT   DISTINCT SUM(fldMablagh)   OVER (PARTITION BY fldMohasebatId) 
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						 WHERE fldMohasebatId=Pay.tblMohasebat.fldId and tblMoavaghat_Items.fldHesabTypeItemId<>1 and fldMablagh>0) ,0)
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP 
								 and o.fldHesabTypeItemId<>1 and fldMablagh>0),0) 
						 + ISNULL((SELECT SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat+(Pay.tblMoavaghat.fldPasAndaz/2)
						 +Pay.tblMoavaghat.fldBimeBikari+Pay.tblMoavaghat.fldBimeKarFarma )
						  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid  GROUP BY fldMohasebatId),0)
						   +isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@Year ,@Month ,fldHesabTypeId )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@Year ,@Month,@NobatPardakht ,fldHesabTypeId )),0)
AS BIGINT))-
						 ( CAST( ISNULL((SELECT abs(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId=76),0)
						 +(ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL and fldHesabTypeParamId>1 ),0)
+ISNULL((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
+fldMosaede+fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari+fldMaliyat+fldHaghDarman+Pay.tblMohasebat.fldPasAndaz+Pay.tblMohasebat.fldGhestVam+fldBimeTakmily+Pay.tblMohasebat.fldBimeOmr)+
					    ISNULL(Com.fn_IsMaliyatforMohasebe(Pay.tblMohasebat.fldId),0)+ISNULL((SELECT sum(fldBimePersonal+fldPasAndaz+fldHaghDarman+fldBimeKarFarma+fldBimeBikari ) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) 
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@Year ,@Month ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@Year ,@Month ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@Year ,@Month,@NobatPardakht ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_OnAccount]( fldPersonalId,@Year ,@Month,@NobatPardakht ,fldHesabTypeId,fldBankId )),0)
						AS bigint) ) fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
, (ISNULL(Pay.tblMohasebat.fldMaliyat,0)+ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0))) AS fldMaliyat
,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat.fldPersonalId as fldPayPersonalId
,0 AS fldMablagh
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                         WHERE Pay.tblMohasebat.fldYear=@year1 AND Pay.tblMohasebat.fldMonth=@Month1  and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1 and fldCalcType=1
						 order by fldFamily

END 
IF(@FieldName1='Hoghogh_Maliyat')
BEGIN
	IF(@NobatPardakht1<>0)
	select fldName,fldFamily,fldFatherName 
	,case when fldkhalesPardakhti<0 then 0 else fldkhalesPardakhti end as fldkhalesPardakhti
	,fldShomareHesab,fldCodemeli,fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,fldCodePosti,fldShomareBime
, fldMadrakId,fldRasteShoghli,fldTypeBimeId,
fldMeliyat, MahalKhedmat, Semat
,  fldMaliyat
, fldNoeEstekhdam, fldPersonalId,fldPersonalId as fldPayPersonalId
,0 AS fldMablagh
	from (
SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName, 
--ISNULL(ISNULL(Pay.tblMohasebat.fldkhalesPardakhti,0)+ISNULL((SELECT SUM(fldkhalesPardakhti) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) ,0)AS 
 ( CAST( ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId<>1 and fldItemsHoghughiId<>76 ),0)
 +isnull((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldId 
 AND fldKosoratId IS NULL and fldHesabTypeParamId>1 ),0)--+fldHaghDarmanKarfFarma+fldHaghDarmanDolat
 +(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma--+fldBimeOmrKarFarma+fldBimeKarFarma+fldBimeBikari
					   + ISNULL((SELECT   DISTINCT SUM(fldMablagh)   OVER (PARTITION BY fldMohasebatId) 
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						 WHERE fldMohasebatId=Pay.tblMohasebat.fldId and tblMoavaghat_Items.fldHesabTypeItemId<>1) ,0)
						 /*+ ISNULL((SELECT SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat
						 +(Pay.tblMoavaghat.fldPasAndaz/2)
						 +Pay.tblMoavaghat.fldBimeBikari+Pay.tblMoavaghat.fldBimeKarFarma )
						  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid GROUP BY fldMohasebatId),0)	*/
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP 
								 and o.fldHesabTypeItemId<>1 ),0) 						
                        AS BIGINT))-
						 ( CAST( ISNULL((SELECT abs(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId=76),0)
						 +(
--						 ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
--WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL and fldHesabTypeParamId>1 ),0)
+ISNULL((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
/*+fldMosaede*/+fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari/*+fldMaliyat*/+fldHaghDarman+Pay.tblMohasebat.fldPasAndaz
/*+Pay.tblMohasebat.fldGhestVam*/+fldBimeTakmily+Pay.tblMohasebat.fldBimeOmr
+fldBimeTakmilyKarFarma+Pay.tblMohasebat.fldPasAndaz/2)/*new*/
					    /*ISNULL(Com.fn_IsMaliyatforMohasebe(Pay.tblMohasebat.fldId),0)*/
						/*+ISNULL((SELECT sum(fldBimePersonal+fldPasAndaz+fldHaghDarman+fldBimeKarFarma+fldBimeBikari ) 
						FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0)*/
												AS bigint) )
						fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
, (ISNULL(Pay.tblMohasebat.fldMaliyat,0)+ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0))) AS fldMaliyat
,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat.fldPersonalId as fldPayPersonalId
,0 AS fldMablagh
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                         WHERE Pay.tblMohasebat.fldYear=@year1 AND Pay.tblMohasebat.fldMonth=@Month1 AND fldNobatPardakht=@NobatPardakht1 and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1 and fldCalcType=1
)t
ELSE 
select fldName,fldFamily,fldFatherName 
	,case when fldkhalesPardakhti<0 then 0 else fldkhalesPardakhti end as fldkhalesPardakhti
	,fldShomareHesab,fldCodemeli,fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,fldCodePosti,fldShomareBime
, fldMadrakId,fldRasteShoghli,fldTypeBimeId,
fldMeliyat, MahalKhedmat, Semat
,  fldMaliyat
, fldNoeEstekhdam, fldPersonalId,fldPersonalId as fldPayPersonalId
,0 AS fldMablagh
 from(
	SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,
	--,ISNULL( ISNULL(Pay.tblMohasebat.fldkhalesPardakhti,0)+ISNULL((SELECT SUM(fldkhalesPardakhti) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0),0) AS fldkhalesPardakhti
( CAST( ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId<>1 and fldItemsHoghughiId<>76 ),0)
 +isnull((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldId 
 AND fldKosoratId IS NULL and fldHesabTypeParamId>1 ),0)--+fldHaghDarmanKarfFarma+fldHaghDarmanDolat
 +(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma--+fldBimeOmrKarFarma+fldBimeKarFarma+fldBimeBikari
					   + ISNULL((SELECT   DISTINCT SUM(fldMablagh)   OVER (PARTITION BY fldMohasebatId) 
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						 WHERE fldMohasebatId=Pay.tblMohasebat.fldId and tblMoavaghat_Items.fldHesabTypeItemId<>1) ,0)
						 /*+ ISNULL((SELECT SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat
						 +(Pay.tblMoavaghat.fldPasAndaz/2)
						 +Pay.tblMoavaghat.fldBimeBikari+Pay.tblMoavaghat.fldBimeKarFarma )
						  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid GROUP BY fldMohasebatId),0)	*/
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP 
								 and o.fldHesabTypeItemId<>1 ),0) 
						 AS BIGINT))-
						 ( CAST( ISNULL((SELECT abs(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items  as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId WHERE fldMohasebatId=Pay.tblMohasebat.fldId and i.fldHesabTypeItemId>1  and fldItemsHoghughiId=76),0)
						 +(
--						 ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
--WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL and fldHesabTypeParamId>1 ),0)
+ISNULL((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
/*+fldMosaede*/+fldBimePersonal+fldBimeKarFarma+fldBimeBikari+fldMogharari/*+fldMaliyat*/+fldHaghDarman+Pay.tblMohasebat.fldPasAndaz
/*+Pay.tblMohasebat.fldGhestVam*/+fldBimeTakmily+Pay.tblMohasebat.fldBimeOmr
+fldBimeTakmilyKarFarma+Pay.tblMohasebat.fldPasAndaz/2)/*new*/
					    /*ISNULL(Com.fn_IsMaliyatforMohasebe(Pay.tblMohasebat.fldId),0)*/
						/*+ISNULL((SELECT sum(fldBimePersonal+fldPasAndaz+fldHaghDarman+fldBimeKarFarma+fldBimeBikari ) 
						FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0)*/
												AS bigint) )
						fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
, (ISNULL(Pay.tblMohasebat.fldMaliyat,0)+ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0))) AS fldMaliyat
,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat.fldPersonalId as fldPayPersonalId
,0 AS fldMablagh
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                         WHERE Pay.tblMohasebat.fldYear=@year1 AND Pay.tblMohasebat.fldMonth=@Month1  and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1 and fldCalcType=1
)t
END 

IF(@FieldName1='BonKart')
BEGIN
select * from (
SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName, 
--ISNULL(ISNULL(Pay.tblMohasebat.fldkhalesPardakhti,0)+ISNULL((SELECT SUM(fldkhalesPardakhti) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) ,0)AS 
 ( CAST( ISNULL((m.fldMablagh),0)
 + ISNULL((SELECT   DISTINCT SUM(fldMablagh)   OVER (PARTITION BY fldMohasebatId) 
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						 WHERE fldMohasebatId=Pay.tblMohasebat.fldId  and tblMoavaghat_Items.fldHesabTypeItemId=1) ,0)
						 +isnull(mo.fldMablagh,0)
						 +isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@Year ,@Month ,1 )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@Year ,@Month,@NobatPardakht ,1 )),0)
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP 
								 and o.fldHesabTypeItemId=1 ),0) 
						 -cast ( isnull(k.fldMablagh,0)
						 +isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@Year ,@Month ,1 )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@Year ,@Month ,1 )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@Year ,@Month,@NobatPardakht ,1 )),0)
						
						as bigint)
						 AS bigint) )
						fldkhalesPardakhti
,m.fldShomareHesab,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
, 0 AS fldMaliyat
,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat.fldPersonalId as fldPayPersonalId
,0 AS fldMablagh
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                     
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply(select sum(isnull(m.fldMablagh,0)) as fldMablagh,max(s.fldShomareHesab) as fldShomareHesab,max(fldBankId) as fldBankId  FROM Pay.tblMohasebat_Items as m
					  inner join  Com.tblShomareHesabeOmoomi as s ON m.fldShomareHesabItemId =s.fldId
					  WHERE fldMohasebatId=Pay.tblMohasebat.fldId 
					  and m.fldHesabTypeItemId=1)m
					  outer apply(SELECT SUM(isnull(fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k WHERE  fldMohasebatId=Pay.tblMohasebat.fldId 
									AND fldKosoratId IS NULL and fldHesabTypeParamId=1 )mo
					outer apply(SELECT SUM(isnull(fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k WHERE  fldMohasebatId=Pay.tblMohasebat.fldId 
									AND fldKosoratId IS not NULL and fldHesabTypeParamId=1 )k
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                         WHERE Pay.tblMohasebat.fldYear=@year1 AND Pay.tblMohasebat.fldMonth=@Month1 
						 AND (@NobatPardakht1=0 or fldNobatPardakht=@NobatPardakht1) and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1  and fldCalcType=1)t
						 where fldkhalesPardakhti>=0

END 
IF(@FieldName1='BonKart_Mostamar')
BEGIN

SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName, 
--ISNULL(ISNULL(Pay.tblMohasebat.fldkhalesPardakhti,0)+ISNULL((SELECT SUM(fldkhalesPardakhti) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) ,0)AS 
 ( CAST( ISNULL((m.fldMablagh),0)
  
						-- +isnull(mo.fldMablagh,0)-isnull(k.fldMablagh,0) 
						 AS bigint) )						fldkhalesPardakhti
,m.fldShomareHesab,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam
,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat
,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
, 0 AS fldMaliyat
,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat.fldPersonalId as fldPayPersonalId
,ISNULL((SELECT   DISTINCT SUM(tblMoavaghat_Items.fldMablagh)   OVER (PARTITION BY fldMohasebatId) 
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						inner join com.tblItems_Estekhdam as e on e.fldId=tblMoavaghat_Items.fldItemEstekhdamId
						inner join com.tblItemsHoghughi as i on i.fldId=e.fldItemsHoghughiId
						 WHERE fldMohasebatId=Pay.tblMohasebat.fldId  and tblMoavaghat_Items.fldHesabTypeItemId=1 and i.fldMostamar=1
						 and tblMoavaghat_Items.fldMaliyatMashmool=1 and tblMoavaghat_Items.fldMostamar=1) ,0) 
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP 
								   and o.fldHesabTypeItemId=1 
						 and o.fldMaliyatMashmool=1 and o.fldMostamar=1),0)                          
                         AS fldMablagh
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                     
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					   outer apply(select sum(isnull(m.fldMablagh,0)) as fldMablagh,max(s.fldShomareHesab) as fldShomareHesab  
									FROM Pay.tblMohasebat_Items as m
								  inner join  Com.tblShomareHesabeOmoomi as s ON m.fldShomareHesabItemId =s.fldId
								  inner join com.tblItems_Estekhdam as e on e.fldId=m.fldItemEstekhdamId
								  inner join com.tblItemsHoghughi as i on i.fldId=e.fldItemsHoghughiId
								  WHERE fldMohasebatId=Pay.tblMohasebat.fldId 
								  and m.fldHesabTypeItemId=1 and i.fldMostamar=1 and m.fldMaliyatMashmool=1)m
					  outer apply(SELECT SUM(isnull(k.fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k 
									inner join pay.tblMotalebateParametri_Personal as p on p.fldId=k.fldMotalebatId 
									WHERE  fldMohasebatId=Pay.tblMohasebat.fldId 									
									AND fldKosoratId IS NULL and fldHesabTypeParamId=1 and p.fldMashmoleMaliyat=1 and k.fldIsMostamar=1)mo
					 --outer apply(SELECT SUM(isnull(fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k WHERE  fldMohasebatId=Pay.tblMohasebat.fldId 
						--			AND fldKosoratId IS not NULL and fldHesabTypeParamId=1 )k
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                         WHERE Pay.tblMohasebat.fldYear=@year1 AND Pay.tblMohasebat.fldMonth=@Month1 
						 AND (@NobatPardakht1=0 or fldNobatPardakht=@NobatPardakht1) and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1 and fldCalcType=1

END 
IF(@FieldName1='BonKart_MostamarPersonalId')
BEGIN

SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName, 
--ISNULL(ISNULL(Pay.tblMohasebat.fldkhalesPardakhti,0)+ISNULL((SELECT SUM(fldkhalesPardakhti) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) ,0)AS 
 ( CAST( ISNULL((m.fldMablagh),0)
  
						-- +isnull(mo.fldMablagh,0)-isnull(k.fldMablagh,0) 
						 AS bigint) )						fldkhalesPardakhti
,m.fldShomareHesab,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam
,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat
,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
, 0 AS fldMaliyat
,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat.fldPersonalId as fldPayPersonalId
,ISNULL((SELECT   DISTINCT SUM(tblMoavaghat_Items.fldMablagh)   OVER (PARTITION BY fldMohasebatId) 
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						inner join com.tblItems_Estekhdam as e on e.fldId=tblMoavaghat_Items.fldItemEstekhdamId
						inner join com.tblItemsHoghughi as i on i.fldId=e.fldItemsHoghughiId
						 WHERE fldMohasebatId=Pay.tblMohasebat.fldId  and tblMoavaghat_Items.fldHesabTypeItemId=1 and i.fldMostamar=1
						 and tblMoavaghat_Items.fldMaliyatMashmool=1 and tblMoavaghat_Items.fldMostamar=1) ,0) 
 +ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP 
								 and o.fldHesabTypeItemId=1
						 and o.fldMaliyatMashmool=1 and o.fldMostamar=1 ),0)                         
                         AS fldMablagh
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                     
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					   outer apply(select sum(isnull(m.fldMablagh,0)) as fldMablagh,max(s.fldShomareHesab) as fldShomareHesab  
									FROM Pay.tblMohasebat_Items as m
								  inner join  Com.tblShomareHesabeOmoomi as s ON m.fldShomareHesabItemId =s.fldId
								  inner join com.tblItems_Estekhdam as e on e.fldId=m.fldItemEstekhdamId
								  inner join com.tblItemsHoghughi as i on i.fldId=e.fldItemsHoghughiId
								  WHERE fldMohasebatId=Pay.tblMohasebat.fldId 
								  and m.fldHesabTypeItemId=1 and i.fldMostamar=1 and m.fldMaliyatMashmool=1)m
					  outer apply(SELECT SUM(isnull(k.fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k 
									inner join pay.tblMotalebateParametri_Personal as p on p.fldId=k.fldMotalebatId 
									WHERE  fldMohasebatId=Pay.tblMohasebat.fldId 									
									AND fldKosoratId IS NULL and fldHesabTypeParamId=1 and p.fldMashmoleMaliyat=1 and k.fldIsMostamar=1)mo
					 --outer apply(SELECT SUM(isnull(fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k WHERE  fldMohasebatId=Pay.tblMohasebat.fldId 
						--			AND fldKosoratId IS not NULL and fldHesabTypeParamId=1 )k
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                         WHERE Pay.tblMohasebat.fldYear=@year1 AND Pay.tblMohasebat.fldMonth=@Month1 
						 AND (@NobatPardakht1=0 or fldNobatPardakht=@NobatPardakht1) and tblMohasebat.fldPersonalId=@OrgnId1 and fldCalcType=1

END 
IF(@FieldName1='BonKart_GheyrMostamar')
BEGIN
SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName, 
--ISNULL(ISNULL(Pay.tblMohasebat.fldkhalesPardakhti,0)+ISNULL((SELECT SUM(fldkhalesPardakhti) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) ,0)AS 
 ( CAST( ISNULL((m.fldMablagh),0)
  
						 +isnull(mo.fldMablagh,0)
						 /*-isnull(k.fldMablagh,0) */
						 AS bigint) )						fldkhalesPardakhti
,m.fldShomareHesab,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
, 0 AS fldMaliyat
,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat.fldPersonalId as fldPayPersonalId
,ISNULL((SELECT   DISTINCT SUM(tblMoavaghat_Items.fldMablagh)   OVER (PARTITION BY fldMohasebatId) 
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						inner join com.tblItems_Estekhdam as e on e.fldId=tblMoavaghat_Items.fldItemEstekhdamId
						inner join com.tblItemsHoghughi as i on i.fldId=e.fldItemsHoghughiId
						 WHERE fldMohasebatId=Pay.tblMohasebat.fldId  and tblMoavaghat_Items.fldHesabTypeItemId=1 and i.fldMostamar=2
						 and tblMoavaghat_Items.fldMaliyatMashmool=1 and tblMoavaghat_Items.fldMostamar=2) ,0) 
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP 
								 and o.fldHesabTypeItemId=1 
						 and o.fldMaliyatMashmool=1 and o.fldMostamar=2 ),0)                          
                         AS fldMablagh
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                     
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					   outer apply(select sum(isnull(m.fldMablagh,0)) as fldMablagh,max(s.fldShomareHesab) as fldShomareHesab  
									FROM Pay.tblMohasebat_Items as m
								  inner join  Com.tblShomareHesabeOmoomi as s ON m.fldShomareHesabItemId =s.fldId
								  inner join com.tblItems_Estekhdam as e on e.fldId=m.fldItemEstekhdamId
								  inner join com.tblItemsHoghughi as i on i.fldId=e.fldItemsHoghughiId
								  WHERE fldMohasebatId=Pay.tblMohasebat.fldId 
								  and m.fldHesabTypeItemId=1 and i.fldMostamar=2 and m.fldMaliyatMashmool=1)m
					  outer apply(SELECT SUM(isnull(k.fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k 
									inner join pay.tblMotalebateParametri_Personal as p on p.fldId=k.fldMotalebatId 
									WHERE  fldMohasebatId=Pay.tblMohasebat.fldId 									
									AND fldKosoratId IS NULL and fldHesabTypeParamId=1 and p.fldMashmoleMaliyat=1 and k.fldIsMostamar=2)mo
					 --outer apply(SELECT SUM(isnull(fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k WHERE  fldMohasebatId=Pay.tblMohasebat.fldId 
						--			AND fldKosoratId IS not NULL and fldHesabTypeParamId=1 )k
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                         WHERE Pay.tblMohasebat.fldYear=@year1 AND Pay.tblMohasebat.fldMonth=@Month1 
						 AND (@NobatPardakht1=0 or fldNobatPardakht=@NobatPardakht1) and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1 and fldCalcType=1

END  
IF(@FieldName1='BonKart_GheyrMostamarPersonalId')
BEGIN
SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName, 
--ISNULL(ISNULL(Pay.tblMohasebat.fldkhalesPardakhti,0)+ISNULL((SELECT SUM(fldkhalesPardakhti) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) ,0)AS 
 ( CAST( ISNULL((m.fldMablagh),0)
  
						 +isnull(mo.fldMablagh,0)
						 /*-isnull(k.fldMablagh,0) */
						 AS bigint) )						fldkhalesPardakhti
,m.fldShomareHesab,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
, 0 AS fldMaliyat
,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat.fldPersonalId as fldPayPersonalId
,ISNULL((SELECT   DISTINCT SUM(tblMoavaghat_Items.fldMablagh)   OVER (PARTITION BY fldMohasebatId) 
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						inner join com.tblItems_Estekhdam as e on e.fldId=tblMoavaghat_Items.fldItemEstekhdamId
						inner join com.tblItemsHoghughi as i on i.fldId=e.fldItemsHoghughiId
						 WHERE fldMohasebatId=Pay.tblMohasebat.fldId  and tblMoavaghat_Items.fldHesabTypeItemId=1 and i.fldMostamar=2
						 and tblMoavaghat_Items.fldMaliyatMashmool=1 and tblMoavaghat_Items.fldMostamar=2) ,0) 
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP 
								 and o.fldHesabTypeItemId=1 
						 and o.fldMaliyatMashmool=1 and o.fldMostamar=2),0)                          
                         AS fldMablagh
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                     
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					   outer apply(select sum(isnull(m.fldMablagh,0)) as fldMablagh,max(s.fldShomareHesab) as fldShomareHesab  
									FROM Pay.tblMohasebat_Items as m
								  inner join  Com.tblShomareHesabeOmoomi as s ON m.fldShomareHesabItemId =s.fldId
								  inner join com.tblItems_Estekhdam as e on e.fldId=m.fldItemEstekhdamId
								  inner join com.tblItemsHoghughi as i on i.fldId=e.fldItemsHoghughiId
								  WHERE fldMohasebatId=Pay.tblMohasebat.fldId 
								  and m.fldHesabTypeItemId=1 and i.fldMostamar=2 and m.fldMaliyatMashmool=1)m
					  outer apply(SELECT SUM(isnull(k.fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k 
									inner join pay.tblMotalebateParametri_Personal as p on p.fldId=k.fldMotalebatId 
									WHERE  fldMohasebatId=Pay.tblMohasebat.fldId 									
									AND fldKosoratId IS NULL and fldHesabTypeParamId=1 and p.fldMashmoleMaliyat=1 and k.fldIsMostamar=2)mo
					 --outer apply(SELECT SUM(isnull(fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k WHERE  fldMohasebatId=Pay.tblMohasebat.fldId 
						--			AND fldKosoratId IS not NULL and fldHesabTypeParamId=1 )k
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                         WHERE Pay.tblMohasebat.fldYear=@year1 AND Pay.tblMohasebat.fldMonth=@Month1 
						 AND (@NobatPardakht1=0 or fldNobatPardakht=@NobatPardakht1) and tblMohasebat.fldPersonalId=@OrgnId1 and fldCalcType=1

END  
IF(@FieldName1='EzafeKari')
BEGIN
 IF(@NobatPardakht1<>0)
SELECT     tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName
,cast(ISNULL( Pay.tblMohasebatEzafeKari_TatilKari.fldKhalesPardakhti ,0)as bigint)fldKhalesPardakhti,
                     Com.tblShomareHesabeOmoomi.fldShomareHesab, tblEmployee.fldCodemeli, isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari, Prs.Prs_tblPersonalInfo.fldEsargariId, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                      isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Pay.Pay_tblPersonalInfo.fldTypeBimeId, fldMeliyat
                      ,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,
                          (SELECT     fldTitle
                            FROM          Com.tblOrganizationalPosts
                            WHERE      (fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId)) AS Semat
                            , ISNULL(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat,0) AS fldMaliyat
                            ,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebatEzafeKari_TatilKari.fldPersonalId as fldPayPersonalId
,fldMablagh
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                      WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@year1 
					  AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month1 AND fldNobatPardakht=@NobatPardakht1 AND fldType=1 
					  and Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1 

ELSE
	SELECT     tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL( Pay.tblMohasebatEzafeKari_TatilKari.fldKhalesPardakhti ,0)as bigint)fldKhalesPardakhti,
                     Com.tblShomareHesabeOmoomi.fldShomareHesab, tblEmployee.fldCodemeli, isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari, Prs.Prs_tblPersonalInfo.fldEsargariId, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, isnull(fldCodePosti,N'')fldCodePosti, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                      isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Pay.Pay_tblPersonalInfo.fldTypeBimeId, fldMeliyat
                      ,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,
                          (SELECT     fldTitle
                            FROM          Com.tblOrganizationalPosts
                            WHERE      (fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId)) AS Semat
                            , ISNULL(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat,0) AS fldMaliyat
                            ,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebatEzafeKari_TatilKari.fldPersonalId as fldPayPersonalId
,fldMablagh
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                      WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@year1 AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month1 AND fldNobatPardakht=@NobatPardakht1 AND fldType=1
                      and Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1

END 
IF(@FieldName1='EzafeKari_Maliyat')
BEGIN
 IF(@NobatPardakht1<>0)
SELECT     tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName
,cast(ISNULL( Pay.tblMohasebatEzafeKari_TatilKari.fldKhalesPardakhti ,0)as bigint)fldKhalesPardakhti,
                     Com.tblShomareHesabeOmoomi.fldShomareHesab, tblEmployee.fldCodemeli, isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari, Prs.Prs_tblPersonalInfo.fldEsargariId, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                      isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Pay.Pay_tblPersonalInfo.fldTypeBimeId, fldMeliyat
                      ,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,
                          (SELECT     fldTitle
                            FROM          Com.tblOrganizationalPosts
                            WHERE      (fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId)) AS Semat
                            , ISNULL(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat,0) AS fldMaliyat
                            ,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebatEzafeKari_TatilKari.fldPersonalId as fldPayPersonalId
,fldMablagh
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
					 Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                      WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@year1 AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month1 AND fldNobatPardakht=@NobatPardakht1 AND tblMohasebatEzafeKari_TatilKari.fldType=1 and Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1
					  and tblMohasebatEzafeKari_TatilKari.fldMashmolMaliyat>0
ELSE
	SELECT     tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL( Pay.tblMohasebatEzafeKari_TatilKari.fldKhalesPardakhti ,0)as bigint)fldKhalesPardakhti,
                     Com.tblShomareHesabeOmoomi.fldShomareHesab, tblEmployee.fldCodemeli, isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari, Prs.Prs_tblPersonalInfo.fldEsargariId, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, isnull(fldCodePosti,N'')fldCodePosti, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                      isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Pay.Pay_tblPersonalInfo.fldTypeBimeId, fldMeliyat
                      ,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,
                          (SELECT     fldTitle
                            FROM          Com.tblOrganizationalPosts
                            WHERE      (fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId)) AS Semat
                            , ISNULL(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat,0) AS fldMaliyat
                            ,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebatEzafeKari_TatilKari.fldPersonalId as fldPayPersonalId
,fldMablagh
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                      WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@year1 AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month1 AND fldNobatPardakht=@NobatPardakht1 AND fldType=1
                      and Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1 and tblMohasebatEzafeKari_TatilKari.fldMashmolMaliyat>0

END 
IF(@FieldName1='EzafeKari_MaliyatPersonalId')
BEGIN
 IF(@NobatPardakht1<>0)
SELECT     tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName
,cast(ISNULL( Pay.tblMohasebatEzafeKari_TatilKari.fldKhalesPardakhti ,0)as bigint)fldKhalesPardakhti,
                     Com.tblShomareHesabeOmoomi.fldShomareHesab, tblEmployee.fldCodemeli, isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari, Prs.Prs_tblPersonalInfo.fldEsargariId, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                      isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Pay.Pay_tblPersonalInfo.fldTypeBimeId, fldMeliyat
                      ,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,
                          (SELECT     fldTitle
                            FROM          Com.tblOrganizationalPosts
                            WHERE      (fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId)) AS Semat
                            , ISNULL(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat,0) AS fldMaliyat
                            ,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebatEzafeKari_TatilKari.fldPersonalId as fldPayPersonalId
,fldMablagh
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
					 Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                      WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@year1 AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month1 
					  AND fldNobatPardakht=@NobatPardakht1 AND tblMohasebatEzafeKari_TatilKari.fldType=1 
					  and Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId=@OrgnId1
					  and tblMohasebatEzafeKari_TatilKari.fldMashmolMaliyat>0
ELSE
	SELECT     tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL( Pay.tblMohasebatEzafeKari_TatilKari.fldKhalesPardakhti ,0)as bigint)fldKhalesPardakhti,
                     Com.tblShomareHesabeOmoomi.fldShomareHesab, tblEmployee.fldCodemeli, isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari, Prs.Prs_tblPersonalInfo.fldEsargariId, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, isnull(fldCodePosti,N'')fldCodePosti, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                      isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Pay.Pay_tblPersonalInfo.fldTypeBimeId, fldMeliyat
                      ,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,
                          (SELECT     fldTitle
                            FROM          Com.tblOrganizationalPosts
                            WHERE      (fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId)) AS Semat
                            , ISNULL(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat,0) AS fldMaliyat
                            ,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebatEzafeKari_TatilKari.fldPersonalId as fldPayPersonalId
,fldMablagh
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                      WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@year1 AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month1 AND fldNobatPardakht=@NobatPardakht1 AND fldType=1
                      and Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId=@OrgnId1 and tblMohasebatEzafeKari_TatilKari.fldMashmolMaliyat>0

END 
IF(@FieldName1='TatilKari')
BEGIN
IF(@NobatPardakht1<>0)
SELECT     tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL( Pay.tblMohasebatEzafeKari_TatilKari.fldKhalesPardakhti,0)as bigint)fldKhalesPardakhti, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab, tblEmployee.fldCodemeli, isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari, Prs.Prs_tblPersonalInfo.fldEsargariId, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, isnull(fldCodePosti,N'')fldCodePosti, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                      isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Pay.Pay_tblPersonalInfo.fldTypeBimeId, fldMeliyat, 
                      Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,
                          (SELECT     fldTitle
                            FROM          Com.tblOrganizationalPosts
                            WHERE      (fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId)) AS Semat,  ISNULL(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat,0) AS fldMaliyat
,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebatEzafeKari_TatilKari.fldPersonalId as fldPayPersonalId
,Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                      WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@year1 AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month1 AND fldNobatPardakht=@NobatPardakht1 AND fldType=2
					  and Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1
ELSE 
SELECT     tblEmployee.fldName, tblEmployee.fldFamily,fldFatherName,ISNULL( Pay.tblMohasebatEzafeKari_TatilKari.fldKhalesPardakhti ,0)fldKhalesPardakhti,
                     Com.tblShomareHesabeOmoomi.fldShomareHesab, tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari, Prs.Prs_tblPersonalInfo.fldEsargariId, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, isnull(fldCodePosti,N'')fldCodePosti, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                      isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Pay.Pay_tblPersonalInfo.fldTypeBimeId, fldMeliyat
                      ,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,
                          (SELECT     fldTitle
                            FROM          Com.tblOrganizationalPosts
                            WHERE      (fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId)) AS Semat
                            , ISNULL(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat,0) AS fldMaliyat
                            ,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebatEzafeKari_TatilKari.fldPersonalId as fldPayPersonalId
,Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                      WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@year1 AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month1  AND fldType=1
                     and Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1

END

IF(@FieldName1='TatilKari_Maliyat')
BEGIN
IF(@NobatPardakht1<>0)
SELECT     tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL( Pay.tblMohasebatEzafeKari_TatilKari.fldKhalesPardakhti,0)as bigint)fldKhalesPardakhti, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab, tblEmployee.fldCodemeli, isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari, Prs.Prs_tblPersonalInfo.fldEsargariId, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, isnull(fldCodePosti,N'')fldCodePosti, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                      isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Pay.Pay_tblPersonalInfo.fldTypeBimeId, fldMeliyat, 
                      Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,
                          (SELECT     fldTitle
                            FROM          Com.tblOrganizationalPosts
                            WHERE      (fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId)) AS Semat,  ISNULL(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat,0) AS fldMaliyat
,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebatEzafeKari_TatilKari.fldPersonalId as fldPayPersonalId
,Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                      WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@year1 AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month1 AND fldNobatPardakht=@NobatPardakht1 AND fldType=2
					  and Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1 and tblMohasebatEzafeKari_TatilKari.fldMashmolMaliyat>0
ELSE 
SELECT     tblEmployee.fldName, tblEmployee.fldFamily,fldFatherName,ISNULL( Pay.tblMohasebatEzafeKari_TatilKari.fldKhalesPardakhti ,0)fldKhalesPardakhti,
                     Com.tblShomareHesabeOmoomi.fldShomareHesab, tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari, Prs.Prs_tblPersonalInfo.fldEsargariId, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, isnull(fldCodePosti,N'')fldCodePosti, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                      isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Pay.Pay_tblPersonalInfo.fldTypeBimeId, fldMeliyat
                      ,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,
                          (SELECT     fldTitle
                            FROM          Com.tblOrganizationalPosts
                            WHERE      (fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId)) AS Semat
                            , ISNULL(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat,0) AS fldMaliyat
                            ,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebatEzafeKari_TatilKari.fldPersonalId as fldPayPersonalId
,Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                      WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@year1 AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month1  AND fldType=1
                     and Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1 and tblMohasebatEzafeKari_TatilKari.fldMashmolMaliyat>0

END
IF(@FieldName1='TatilKari_MaliyatPersonalId')
BEGIN
IF(@NobatPardakht1<>0)
SELECT     tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL( Pay.tblMohasebatEzafeKari_TatilKari.fldKhalesPardakhti,0)as bigint)fldKhalesPardakhti, 
                     Com.tblShomareHesabeOmoomi.fldShomareHesab, tblEmployee.fldCodemeli, isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari, Prs.Prs_tblPersonalInfo.fldEsargariId, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, isnull(fldCodePosti,N'')fldCodePosti, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                      isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Pay.Pay_tblPersonalInfo.fldTypeBimeId, fldMeliyat, 
                      Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,
                          (SELECT     fldTitle
                            FROM          Com.tblOrganizationalPosts
                            WHERE      (fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId)) AS Semat,  ISNULL(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat,0) AS fldMaliyat
,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebatEzafeKari_TatilKari.fldPersonalId as fldPayPersonalId
,Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                      WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@year1 AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month1 AND fldNobatPardakht=@NobatPardakht1 AND fldType=2
					  and tblMohasebatEzafeKari_TatilKari.fldPersonalId=@OrgnId1 and tblMohasebatEzafeKari_TatilKari.fldMashmolMaliyat>0
ELSE 
SELECT     tblEmployee.fldName, tblEmployee.fldFamily,fldFatherName,ISNULL( Pay.tblMohasebatEzafeKari_TatilKari.fldKhalesPardakhti ,0)fldKhalesPardakhti,
                     Com.tblShomareHesabeOmoomi.fldShomareHesab, tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari, Prs.Prs_tblPersonalInfo.fldEsargariId, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, isnull(fldCodePosti,N'')fldCodePosti, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                      isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Pay.Pay_tblPersonalInfo.fldTypeBimeId, fldMeliyat
                      ,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,
                          (SELECT     fldTitle
                            FROM          Com.tblOrganizationalPosts
                            WHERE      (fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId)) AS Semat
                            , ISNULL(Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat,0) AS fldMaliyat
                            ,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebatEzafeKari_TatilKari.fldPersonalId as fldPayPersonalId
,Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                      WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@year1 AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month1  AND fldType=1
                     and Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId=@OrgnId1 and tblMohasebatEzafeKari_TatilKari.fldMashmolMaliyat>0

END
IF(@FieldName1='Morakhasi')
BEGIN
IF(@NobatPardakht1<>0)
SELECT       tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(Pay.tblMohasebat_Morakhasi.fldMablagh,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,0 AS fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId)  AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat_Morakhasi.fldPersonalId as fldPayPersonalId
,Pay.tblMohasebat_Morakhasi.fldMablagh
FROM         Pay.tblMohasebat_Morakhasi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Morakhasi.fldId = Pay.tblMohasebat_PersonalInfo.fldMorakhasiId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Morakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                      WHERE fldYear=@year1 AND fldMonth=@Month1 AND fldNobatPardakht=@NobatPardakht1 and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1
ELSE
SELECT       tblEmployee.fldName, tblEmployee.fldFamily,fldFatherName,cast(ISNULL(Pay.tblMohasebat_Morakhasi.fldMablagh,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,0 AS fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId)AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat_Morakhasi.fldPersonalId as fldPayPersonalId
,Pay.tblMohasebat_Morakhasi.fldMablagh
FROM         Pay.tblMohasebat_Morakhasi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Morakhasi.fldId = Pay.tblMohasebat_PersonalInfo.fldMorakhasiId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Morakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                      WHERE fldYear=@year1 AND fldMonth=@Month1 and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1
END

IF(@FieldName1='EydiPersonalId')
BEGIN
IF(@NobatPardakht1<>0)
SELECT       tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,Pay.tblMohasebat_Eydi.fldMaliyat AS fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat_Eydi.fldPersonalId as fldPayPersonalId
,Pay.tblMohasebat_Eydi.fldMablagh
FROM         Pay.tblMohasebat_Eydi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Eydi .fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldNobatPardakht=@NobatPardakht1 and tblMohasebat_Eydi.fldPersonalId=@OrgnId1
 ELSE 
 SELECT       tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,Pay.tblMohasebat_Eydi.fldMaliyat AS fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat_Eydi.fldPersonalId as fldPayPersonalId
,Pay.tblMohasebat_Eydi.fldMablagh
FROM         Pay.tblMohasebat_Eydi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Eydi .fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND tblMohasebat_Eydi.fldPersonalId=@OrgnId1
 end
 
 IF(@FieldName1='Eydi')
BEGIN
IF(@NobatPardakht1<>0)
SELECT       tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,Pay.tblMohasebat_Eydi.fldMaliyat AS fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat_Eydi.fldPersonalId as fldPayPersonalId
,Pay.tblMohasebat_Eydi.fldMablagh
FROM         Pay.tblMohasebat_Eydi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Eydi .fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldNobatPardakht=@NobatPardakht1 and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1
 ELSE 
 SELECT       tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,Pay.tblMohasebat_Eydi.fldMaliyat AS fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat_Eydi.fldPersonalId as fldPayPersonalId
,Pay.tblMohasebat_Eydi.fldMablagh
FROM         Pay.tblMohasebat_Eydi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Eydi .fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1
 end   

 
  IF(@FieldName1='Mamuriyat')   
            
  SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,0 AS fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId)AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat_Mamuriyat.fldPersonalId as fldPayPersonalId
,Pay.tblMohasebat_Mamuriyat.fldMablagh
FROM         Pay.tblMohasebat_Mamuriyat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldId = Pay.tblMohasebat_PersonalInfo.fldMamuriyatId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h  
                        WHERE fldYear=@year1 AND fldMonth=@Month1  and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1 

IF(@FieldName1='Mamuriyat_Maliyat')   
            
  SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,0 AS fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId)AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat_Mamuriyat.fldPersonalId as fldPayPersonalId
,Pay.tblMohasebat_Mamuriyat.fldMablagh
FROM         Pay.tblMohasebat_Mamuriyat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldId = Pay.tblMohasebat_PersonalInfo.fldMamuriyatId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h  
                        WHERE fldYear=@year1 AND fldMonth=@Month1  and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1 
						and tblMohasebat_Mamuriyat.fldMashmolMaliyat>0

IF(@FieldName1='Mamuriyat_MaliyatPersonalId')   
            
  SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,0 AS fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId)AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblMohasebat_Mamuriyat.fldPersonalId as fldPayPersonalId
,Pay.tblMohasebat_Mamuriyat.fldMablagh
FROM         Pay.tblMohasebat_Mamuriyat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldId = Pay.tblMohasebat_PersonalInfo.fldMamuriyatId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h  
                        WHERE fldYear=@year1 AND fldMonth=@Month1  and tblMohasebat_Mamuriyat.fldPersonalId=@OrgnId1 
						and tblMohasebat_Mamuriyat.fldMashmolMaliyat>0

IF(@FieldName1='KomakGheyerNaghdi_Mostamer')
 SELECT     tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblKomakGheyerNaghdi.fldMaliyat,0)fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblKomakGheyerNaghdi.fldPersonalId as fldPayPersonalId
,Pay.tblKomakGheyerNaghdi.fldMablagh
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKomakGheyerNaghdi .fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  AND fldNoeMostamer=1 and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1
 
 IF(@FieldName1='KomakGheyerNaghdi_Mostamer_Maliyat')
 SELECT     tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblKomakGheyerNaghdi.fldMaliyat,0)fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblKomakGheyerNaghdi.fldPersonalId as fldPayPersonalId
,Pay.tblKomakGheyerNaghdi.fldMablagh
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKomakGheyerNaghdi .fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  AND fldNoeMostamer=1 and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1
 and fldMaliyat>0

 IF(@FieldName1='KomakGheyerNaghdi_Mostamer_MaliyatPersonalId')
 SELECT     tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblKomakGheyerNaghdi.fldMaliyat,0)fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblKomakGheyerNaghdi.fldPersonalId as fldPayPersonalId
,Pay.tblKomakGheyerNaghdi.fldMablagh
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKomakGheyerNaghdi .fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  AND fldNoeMostamer=1 and tblKomakGheyerNaghdi.fldPersonalId=@OrgnId1
 and fldMaliyat>0

 IF(@FieldName1='KomakGheyerNaghdi_GheyreMostamer')
 SELECT     tblEmployee.fldName, tblEmployee.fldFamily,fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblKomakGheyerNaghdi.fldMaliyat,0) AS fldMaliyat ,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblKomakGheyerNaghdi.fldPersonalId as fldPayPersonalId
,Pay.tblKomakGheyerNaghdi.fldMablagh
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblKomakGheyerNaghdi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  AND fldNoeMostamer=0 and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1

IF(@FieldName1='KomakGheyerNaghdi_GheyreMostamer_Maliyat')
 SELECT     tblEmployee.fldName, tblEmployee.fldFamily,fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblKomakGheyerNaghdi.fldMaliyat,0) AS fldMaliyat ,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblKomakGheyerNaghdi.fldPersonalId as fldPayPersonalId
,Pay.tblKomakGheyerNaghdi.fldMablagh
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblKomakGheyerNaghdi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  AND fldNoeMostamer=0 and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1
                           and fldMaliyat>0   
	IF(@FieldName1='KomakGheyerNaghdi_GheyreMostamer_MaliyatPersonalId')
 SELECT     tblEmployee.fldName, tblEmployee.fldFamily,fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblKomakGheyerNaghdi.fldMaliyat,0) AS fldMaliyat ,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblKomakGheyerNaghdi.fldPersonalId as fldPayPersonalId
,Pay.tblKomakGheyerNaghdi.fldMablagh
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblKomakGheyerNaghdi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  AND fldNoeMostamer=0 
					   and tblKomakGheyerNaghdi.fldPersonalId=@OrgnId1
                           and fldMaliyat>0		
IF(@FieldName1='KomakGheyerNaghdi_calc')
 SELECT     tblEmployee.fldName, tblEmployee.fldFamily,fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblKomakGheyerNaghdi.fldMaliyat,0) AS fldMaliyat ,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblKomakGheyerNaghdi.fldPersonalId as fldPayPersonalId
,Pay.tblKomakGheyerNaghdi.fldMablagh
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON   Pay.tblKomakGheyerNaghdi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1 
					   and tblKomakGheyerNaghdi.fldPersonalId=@OrgnId1
                           and fldMaliyat>0							   
IF(@FieldName1='SayerPardakht')
BEGIN
	IF(@NobatPardakht1<>0)
 SELECT      tblEmployee.fldName, tblEmployee.fldFamily,fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblSayerPardakhts.fldMaliyat,0)fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId)AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblSayerPardakhts.fldPersonalId as fldPayPersonalId
,fldAmount AS fldMablagh
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON  Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  AND fldMarhalePardakht=@MarhalePardakht1 
					   AND fldNobatePardakt=@NobatPardakht1 
                       and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1
 ELSE
  SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblSayerPardakhts.fldMaliyat,0)fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblSayerPardakhts.fldPersonalId as fldPayPersonalId
,fldAmount AS fldMablagh
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  AND fldMarhalePardakht=@MarhalePardakht1
                       and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1 
 END

 IF(@FieldName1='SayerPardakht_Maliyat')
BEGIN
	IF(@NobatPardakht1<>0)
 SELECT      tblEmployee.fldName, tblEmployee.fldFamily,fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblSayerPardakhts.fldMaliyat,0)fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId)AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblSayerPardakhts.fldPersonalId as fldPayPersonalId
,fldAmount AS fldMablagh
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON  Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  AND fldMarhalePardakht=@MarhalePardakht1 AND fldNobatePardakt=@NobatPardakht1 
                       and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1 and fldHasMaliyat=1
 ELSE
  SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblSayerPardakhts.fldMaliyat,0)fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblSayerPardakhts.fldPersonalId as fldPayPersonalId
,fldAmount AS fldMablagh
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  AND fldMarhalePardakht=@MarhalePardakht1
                       and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId1  and fldHasMaliyat=1
 END
 IF(@FieldName1='SayerPardakht_GheirMostamar_MaliyatPersonalId')
BEGIN
	IF(@NobatPardakht1<>0)
 SELECT      tblEmployee.fldName, tblEmployee.fldFamily,fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblSayerPardakhts.fldMaliyat,0)fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId)AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblSayerPardakhts.fldPersonalId as fldPayPersonalId
,fldAmount AS fldMablagh
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON  Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  AND fldMarhalePardakht=@MarhalePardakht1 AND fldNobatePardakt=@NobatPardakht1 
                       and tblSayerPardakhts.fldPersonalId=@OrgnId1 and fldHasMaliyat=1 and fldmostamar=2
 ELSE
  SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblSayerPardakhts.fldMaliyat,0)fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblSayerPardakhts.fldPersonalId as fldPayPersonalId
,fldAmount AS fldMablagh
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  AND fldMarhalePardakht=@MarhalePardakht1
                       and tblSayerPardakhts.fldPersonalId=@OrgnId1  and fldHasMaliyat=1 and fldmostamar=2
 END
 IF(@FieldName1='SayerPardakht_Mostamar_MaliyatPersonalId')
BEGIN
	IF(@NobatPardakht1<>0)
 SELECT      tblEmployee.fldName, tblEmployee.fldFamily,fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblSayerPardakhts.fldMaliyat,0)fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId)AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblSayerPardakhts.fldPersonalId as fldPayPersonalId
,fldAmount AS fldMablagh
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON  Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  AND fldMarhalePardakht=@MarhalePardakht1 AND fldNobatePardakt=@NobatPardakht1 
                       and tblSayerPardakhts.fldPersonalId=@OrgnId1 and fldHasMaliyat=1 and fldmostamar=1
 ELSE
  SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblSayerPardakhts.fldMaliyat,0)fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblSayerPardakhts.fldPersonalId as fldPayPersonalId
,fldAmount AS fldMablagh
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  AND fldMarhalePardakht=@MarhalePardakht1
                       and tblSayerPardakhts.fldPersonalId=@OrgnId1  and fldHasMaliyat=1 and fldmostamar=1
 END
 IF(@FieldName1='SayerPardakht_MaliyatPersonalId')
BEGIN
	IF(@NobatPardakht1<>0)
 SELECT      tblEmployee.fldName, tblEmployee.fldFamily,fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblSayerPardakhts.fldMaliyat,0)fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId)AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblSayerPardakhts.fldPersonalId as fldPayPersonalId
,fldAmount AS fldMablagh
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON  Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  --AND fldMarhalePardakht=@MarhalePardakht1 
					   AND fldNobatePardakt=@NobatPardakht1 
                       and tblSayerPardakhts.fldPersonalId=@OrgnId1 and fldHasMaliyat=1 
 ELSE
  SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,Com.tblShomareHesabeOmoomi.fldShomareHesab ,tblEmployee.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.Pay_tblPersonalInfo.fldShomareBime
,isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldRasteShoghli,Pay.Pay_tblPersonalInfo.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS Semat
,ISNULL(Pay.tblSayerPardakhts.fldMaliyat,0)fldMaliyat,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,tblSayerPardakhts.fldPersonalId as fldPayPersonalId
,fldAmount AS fldMablagh
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId   INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                       WHERE fldYear=@year1 AND fldMonth=@Month1  --AND fldMarhalePardakht=@MarhalePardakht1
                       and tblSayerPardakhts.fldPersonalId=@OrgnId1  and fldHasMaliyat=1 
 END
IF(@FieldName1='OnAccount')
BEGIN
 SELECT  distinct    e.fldName, e.fldFamily,fldFatherName,cast(ISNULL(a.fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
,a.fldShomareHesab ,e.fldCodemeli,isnull(fldAddress,N'')fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,isnull(fldCodePosti,N'')fldCodePosti,Pay.fldShomareBime
,tblEmployee_Detail.fldMadrakId as fldMadrakId,fldRasteShoghli,Pay.fldTypeBimeId,
fldMeliyat,Com.fn_MahaleKhedmat(p.fldId) AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=p.fldOrganPostId) AS Semat
,0 fldMaliyat,0 AS fldNoeEstekhdam,p.fldId AS fldPersonalId,pay.fldId as fldPayPersonalId
,A.fldKhalesPardakhti AS fldMablagh
FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join Com.tblEmployee_Detail ON e.fldid=Com.tblEmployee_Detail.fldEmployeeId
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId	
	inner join pay.tblMohasebat as m on m.fldPersonalId=pay.fldId and m.fldYear=a.fldYear and m.fldMonth=a.fldMonth
	--inner join com.tblShomareHesabeOmoomi as s on s.fldShomareHesab=a.fldShomareHesab
	--inner join com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=s.fldId
	inner join prs.tblVaziyatEsargari as v on v.fldId=p.fldEsargariId
                       WHERE a.fldYear=@year1 AND a.fldMonth=@Month1   
					   AND fldNobatePardakt=@NobatPardakht1 
                       and a.fldOrganId=@OrgnId1 and fldghatei=1

 END
GO
