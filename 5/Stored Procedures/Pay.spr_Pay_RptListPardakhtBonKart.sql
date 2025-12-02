SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListPardakhtBonKart](@Sal SMALLINT,@Mah TINYINT,@nobatPardakh TINYINT,@organId INT,@CalcType TINYINT=1)
AS
declare @YearP SMALLINT=@Sal,@MonthP TINYINT=@Mah-1

if(@Mah=1)
begin
	set @YearP=@Sal-1
	set @MonthP=12
end
select (t.fldMablagh+isnull(fldMablaghMoavagh,0)+isnull(k.fldMablagh,0)+isnull(motamam.fldMablaghMotamam,0)
		+isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal ,@Mah ,1 )),0)
		+isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal ,@Mah,@nobatPardakh ,1 )),0)
)-(	isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal ,@Mah ,1 )),0)
	+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal ,@Mah ,1 )),0)
	+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal ,@Mah,@nobatPardakh ,1 )),0)
						
)

as fldMablagh, 
                     fldName_Family, fldFatherName
					  , fldPersonalId, 
                      isnull( t.fldShomareHesab,k.fldShomareHesab) asfldShomareHesab,  NameNobat
					  , sal, NameMah
					  --,e.fldTitle
					  ,fldCodemeli  from(
SELECT  distinct  sum(isnull(i.fldMablagh,0)/*+isnull(fldMablaghMoavagh,0)*/) as fldMablagh, 
                      tblEmployee.fldFamily+'_'+tblEmployee.fldName AS fldName_Family, Com.tblEmployee_Detail.fldFatherName
					  , Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, 
                     isnull( Com.tblShomareHesabeOmoomi.fldShomareHesab,'') as fldShomareHesab, Com.fn_nobatePardakht(@nobatPardakh) AS NameNobat
					  , @sal AS sal, Com.fn_month(@mah) AS NameMah
					  --,e.fldTitle
					  ,tblEmployee.fldCodemeli,m.fldId
FROM         Pay.tblMohasebat as m INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON m.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId left JOIN
					  pay.tblMohasebat_Items as i on i.fldMohasebatId=m.fldId  AND i.fldHesabTypeItemId=1 left join
					   --pay.[tblMohasebat_kosorat/MotalebatParam] as k on k.fldMohasebatId=m.fldId  AND k.fldHesabTypeParamId=1 left join 
                      Com.tblShomareHesabeOmoomi ON i.fldShomareHesabItemId = Com.tblShomareHesabeOmoomi.fldId  left join 
                      --Com.tblShomareHesabeOmoomi  as s ON k.fldShomareHesabParamId = s.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON m.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                   
					  WHERE fldYear=@sal AND fldMonth=@Mah AND m.fldNobatPardakht=@nobatPardakh 
                      AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId  and fldCalcType=@CalcType  /*حقوق*/
					  group by  m.fldId,tblEmployee.fldFamily,tblEmployee.fldName,fldFatherName,Pay.Pay_tblPersonalInfo.fldId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldCodemeli
					  )t
					   outer apply(select SUM(CAST(i.fldMablagh AS BIGINT)) fldMablaghMoavagh FROM        
									pay.tblMoavaghat as o  inner join
									pay.tblMoavaghat_Items as i on i.fldMoavaghatId=o.fldId 
									WHERE o.fldMohasebatId=t.fldid
					  and i.fldHesabTypeItemId=1 )o
					  outer apply( select sum(k.fldMablagh)fldMablagh,s.fldShomareHesab from pay.[tblMohasebat_kosorat/MotalebatParam] as k 
									left join Com.tblShomareHesabeOmoomi  as s ON k.fldShomareHesabParamId = s.fldId
									where	 k.fldMohasebatId=t.fldId  AND k.fldHesabTypeParamId=1 
									group by fldShomareHesab)k
						outer apply(select sum(o.fldMablagh) as fldMablaghMotamam from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
								where t.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP and o.fldHesabTypeItemId=1
								
                                group by m2.fldPersonalId )motamam
                     where t.fldMablagh>=0
					 ORDER BY fldName_Family--tblEmployee.fldFamily,tblEmployee.fldName
                      
 
                
GO
