SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_SelectHoghogh_OnAccount]( @year SMALLINT,@Month TINYINT,@NobatPardakht TINYINT,@OrgnId INT,@CalcType TINYINT=1)
as
begin tran
--declare @year SMALLINT=1402,@Month TINYINT=12,@NobatPardakht TINYINT=1,@OrgnId INT=1
declare @YearP SMALLINT=@year,@MonthP TINYINT=@Month-1

if(@Month=1)
begin
	set @YearP=@year-1
	set @MonthP=12
end
select *,case when fldkhalesPardakhti<0 then N'بدهکار' else N'بستانکار' end as fldType from (
SELECT      tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName, 
--ISNULL(ISNULL(Pay.tblMohasebat.fldkhalesPardakhti,0)+ISNULL((SELECT SUM(fldkhalesPardakhti) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) ,0)AS 
 ( CAST( ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items WHERE fldMohasebatId=Pay.tblMohasebat.fldId and tblMohasebat_Items.fldHesabTypeItemId<>1 ),0)
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
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP  and o.fldHesabTypeItemId<>1 ),0) 							 
						AS BIGINT))-
						 ( CAST((ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
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
						fldkhalesPardakhti,isnull((select fldkhalesPardakhti from [Pay].[fn_OnAccount]( fldPersonalId,@Year ,@Month,@NobatPardakht ,fldHesabTypeId,fldBankId )),0) as fldOnAccount
,Com.tblShomareHesabeOmoomi.fldShomareHesab,tblEmployee.fldCodemeli
,case when fldMaliyatType=1 or ( fldMaliyatType=2 and fldMaliyatCalc is null ) then ISNULL(Pay.tblMohasebat.fldMaliyat,0) else ISNULL(Pay.tblMohasebat.fldMaliyatCalc,0) end +ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0)) AS fldMaliyat,
case when fldMaliyatType=2  and fldMaliyatCalc is null  then 0 when fldMaliyatType=2  then  ISNULL(Pay.tblMohasebat.fldMaliyat,0) else ISNULL(Pay.tblMohasebat.fldMaliyatCalc,0)   end as fldMaliyatDaraei
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                     Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON  Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                         WHERE Pay.tblMohasebat.fldYear=@year AND Pay.tblMohasebat.fldMonth=@Month AND fldNobatPardakht=@NobatPardakht and tblMohasebat_PersonalInfo.fldOrganId=@OrgnId and fldCalcType=@CalcType
)t

commit tran
GO
