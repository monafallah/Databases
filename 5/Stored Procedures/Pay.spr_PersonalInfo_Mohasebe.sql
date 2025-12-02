SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_PersonalInfo_Mohasebe]( @Year SMALLINT,@Month TINYINT,@NobatPardakht TINYINT,@Type TINYINT,@Ezafe_Tatil TINYINT,@OrganId INT
,@CostCenterId varchar(max),@AnvaeEstekhdamId varchar(max),@Tarikh varchar(10),@fieldName varchar(50),@CalcType tinyint)
AS
BEGIN
if(@fieldName='Calc')
begin
		IF(@Type=1)
		SELECT  Pay.Pay_tblPersonalInfo.fldId AS PayId, Prs.Prs_tblPersonalInfo.fldId AS PrsId, tblEmployee.fldFamily+'_'+ tblEmployee.fldName+'('+fldFatherName+')' AS fldName_Family
		,tblEmployee.fldCodemeli,fldSh_Personali,Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)  AS fldOrganId,fldCostCenterId,fldAnvaeEstekhdamId
		FROM         Pay.tblKarKardeMahane INNER JOIN
							  Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS  tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
							  Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
							  cross apply (SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId
										FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
															  Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
										WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId) AND fldTarikh<=@Tarikh
										ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
										)t
							  WHERE fldYear =@Year AND fldMah=@Month AND fldNobatePardakht=@NobatPardakht 
							   and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=fldCostCenterId ))
							   and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=fldAnvaeEstekhdamId ))
							   AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId  AND Com.fn_MaxPersonalStatus( Pay.Pay_tblPersonalInfo.fldId ,'hoghoghi')=1
							   and exists (SELECT   top(1)    Prs.tblPersonalHokm .fldPrs_PersonalInfoId
									  FROM  Prs.tblPersonalHokm  
									   WHERE fldPrs_PersonalInfoId=  Prs.Prs_tblPersonalInfo.fldId  and  fldTarikhEjra<=Cast(@Year as varchar(5))+ '/'+  right('0' + convert(varchar,@Month),2)+'/31' and fldStatusHokm=1  
									   ORDER BY fldTarikhSodoor DESC,fldTarikhEjra DESC)
	/*union
		SELECT  Pay.Pay_tblPersonalInfo.fldId AS PayId, Prs.Prs_tblPersonalInfo.fldId AS PrsId, tblEmployee.fldFamily+'_'+ tblEmployee.fldName+'('+fldFatherName+')' AS fldName_Family
		,tblEmployee.fldCodemeli,fldSh_Personali,Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)  AS fldOrganId,fldCostCenterId,fldAnvaeEstekhdamId
		FROM      
							  Pay.Pay_tblPersonalInfo inner join
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS  tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
							  Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
							  cross apply (SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId
										FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
															  Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
										WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId) AND fldTarikh<=@Tarikh
										ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
										)t
							  WHERE 
							    ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=fldCostCenterId ))
							   and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=fldAnvaeEstekhdamId ))
							   AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId  AND Com.fn_MaxPersonalStatus( Pay.Pay_tblPersonalInfo.fldId ,'hoghoghi')=3
							   and exists (SELECT   top(1)    Prs.tblPersonalHokm .fldPrs_PersonalInfoId
									  FROM  Prs.tblPersonalHokm  
									   WHERE fldPrs_PersonalInfoId=  Prs.Prs_tblPersonalInfo.fldId  and  fldTarikhEjra<=Cast(@Year as varchar(5))+ '/'+  right('0' + convert(varchar,@Month),2)+'/31' and fldStatusHokm=1  
									   ORDER BY fldTarikhSodoor DESC,fldTarikhEjra DESC)*/
		IF(@Type=2 or @Type=3)
		SELECT     Pay.Pay_tblPersonalInfo.fldId AS PayId, Prs.Prs_tblPersonalInfo.fldId AS PrsId, 
							  tblEmployee.fldFamily+'_'+ tblEmployee.fldName+'('+fldFatherName+')' AS fldName_Family, tblEmployee.fldCodemeli, 
							  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) AS fldOrganId,fldCostCenterId,fldAnvaeEstekhdamId
		FROM         Pay.Pay_tblPersonalInfo INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
							  Pay.tblEzafeKari_TatilKari ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblEzafeKari_TatilKari.fldPersonalId  INNER JOIN
							  Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
							  cross apply (SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId
										FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
															  Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
										WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId) AND fldTarikh<=@Tarikh
										ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
										)t
							   WHERE fldYear =@Year AND fldMonth=@Month AND fldNobatePardakht=@NobatPardakht  
							   and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=fldCostCenterId ))
							   and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=fldAnvaeEstekhdamId ))
							   AND fldType= @Ezafe_Tatil 
								AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId AND Com.fn_MaxPersonalStatus( Pay.Pay_tblPersonalInfo.fldId ,'hoghoghi')=1
								and exists (SELECT   top(1)    Prs.tblPersonalHokm .fldPrs_PersonalInfoId
									  FROM  Prs.tblPersonalHokm  
									   WHERE fldPrs_PersonalInfoId=  Prs.Prs_tblPersonalInfo.fldId  and  fldTarikhEjra<=Cast(@Year as varchar(5))+ '/'+  right('0' + convert(varchar,@Month),2)+'/31' and fldStatusHokm=1  
									   ORDER BY fldTarikhSodoor DESC,fldTarikhEjra DESC)
		IF(@Type=4)
		SELECT     Pay.Pay_tblPersonalInfo.fldId AS PayId, Prs.Prs_tblPersonalInfo.fldId AS PrsId, 
							 tblEmployee.fldFamily+'_'+ tblEmployee.fldName+'('+fldFatherName+')' AS fldName_Family, tblEmployee.fldCodemeli, 
							  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) AS fldOrganId,fldCostCenterId,fldAnvaeEstekhdamId
		FROM         Pay.Pay_tblPersonalInfo INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
							  Pay.tblEtelaatEydi ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblEtelaatEydi.fldPersonalId   INNER JOIN
							  Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
							  cross apply (SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId
										FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
															  Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
										WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId) AND fldTarikh<=@Tarikh
										ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
										)t
							   WHERE fldYear =@Year AND fldNobatePardakht=@NobatPardakht 
							   and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=fldCostCenterId ))
							   and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=fldAnvaeEstekhdamId ))
							   AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId AND Com.fn_MaxPersonalStatus( Pay.Pay_tblPersonalInfo.fldId ,'hoghoghi')=1
							   and exists (SELECT   top(1)    Prs.tblPersonalHokm .fldPrs_PersonalInfoId
									  FROM  Prs.tblPersonalHokm  
									   WHERE fldPrs_PersonalInfoId=  Prs.Prs_tblPersonalInfo.fldId  and  fldTarikhEjra<=Cast(@Year as varchar(5))+ '/'+  right('0' + convert(varchar,@Month),2)+'/31' and fldStatusHokm=1  
									   ORDER BY fldTarikhSodoor DESC,fldTarikhEjra DESC)

		IF(@Type=5)
		SELECT     Pay.Pay_tblPersonalInfo.fldId AS PayId, Prs.Prs_tblPersonalInfo.fldId AS PrsId, 
							  tblEmployee.fldFamily+'_'+ tblEmployee.fldName+'('+fldFatherName+')'AS fldName_Family, tblEmployee.fldCodemeli, 
							  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) AS fldOrganId,fldCostCenterId,fldAnvaeEstekhdamId
		FROM         Pay.Pay_tblPersonalInfo INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
							  Pay.tblMamuriyat ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblMamuriyat.fldPersonalId  INNER JOIN
							  Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
							  cross apply (SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId
										FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
															  Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
										WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId) AND fldTarikh<=@Tarikh
										ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
										)t
							   WHERE fldYear =@Year AND fldMonth=@Month AND fldNobatePardakht=@NobatPardakht 
							   and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=fldCostCenterId ))
							   and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=fldAnvaeEstekhdamId )) 
							   AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId AND Com.fn_MaxPersonalStatus( Pay.Pay_tblPersonalInfo.fldId ,'hoghoghi')=1
							   and exists (SELECT   top(1)    Prs.tblPersonalHokm .fldPrs_PersonalInfoId
									  FROM  Prs.tblPersonalHokm  
									   WHERE fldPrs_PersonalInfoId=  Prs.Prs_tblPersonalInfo.fldId  and  fldTarikhEjra<=Cast(@Year as varchar(5))+ '/'+  right('0' + convert(varchar,@Month),2)+'/31' and fldStatusHokm=1  
									   ORDER BY fldTarikhSodoor DESC,fldTarikhEjra DESC)
                       
		 IF(@Type=6)                      
		SELECT     Pay.Pay_tblPersonalInfo.fldId AS PayId, Prs.Prs_tblPersonalInfo.fldId AS PrsId, 
							  tblEmployee.fldFamily+'_'+ tblEmployee.fldName+'('+fldFatherName+')'AS fldName_Family, tblEmployee.fldCodemeli, 
							  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) AS fldOrganId,fldCostCenterId,fldAnvaeEstekhdamId
		FROM         Pay.Pay_tblPersonalInfo INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
							  Pay.tblMorakhasi ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblMorakhasi.fldPersonalId  INNER JOIN
							  Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
							  cross apply (SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId
										FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
															  Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
										WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId) AND fldTarikh<=@Tarikh
										ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
										)t
							   WHERE fldYear =@Year AND fldMonth=@Month AND fldNobatePardakht=@NobatPardakht 
							   and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=fldCostCenterId ))
							   and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=fldAnvaeEstekhdamId ))
							   AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId AND Com.fn_MaxPersonalStatus( Pay.Pay_tblPersonalInfo.fldId ,'hoghoghi')=1                                                   
							   and exists (SELECT   top(1)    Prs.tblPersonalHokm .fldPrs_PersonalInfoId
									  FROM  Prs.tblPersonalHokm  
									   WHERE fldPrs_PersonalInfoId=  Prs.Prs_tblPersonalInfo.fldId  and  fldTarikhEjra<=Cast(@Year as varchar(5))+ '/'+  right('0' + convert(varchar,@Month),2)+'/31' and fldStatusHokm=1  
									   ORDER BY fldTarikhSodoor DESC,fldTarikhEjra DESC)
 
		 end
end
if(@fieldName='DelCalc')
begin
		IF(@Type=1)
		SELECT  Pay.Pay_tblPersonalInfo.fldId AS PayId, Prs.Prs_tblPersonalInfo.fldId AS PrsId, tblEmployee.fldFamily+'_'+ tblEmployee.fldName+'('+fldFatherName+')' AS fldName_Family
		,tblEmployee.fldCodemeli,fldSh_Personali, fldOrganId,p.fldCostCenterId,fldAnvaeEstekhdamId
		FROM         Pay.tblMohasebat inner join 
		pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=tblMohasebat.fldId INNER JOIN
							  Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS  tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
							  Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
							  cross apply (SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId
										FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
															  Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
										WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId) AND fldTarikh<=@Tarikh
										ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
										)t
							  WHERE fldYear =@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht and fldCalcType=@CalcType
							   and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=p.fldCostCenterId ))
							   and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=fldAnvaeEstekhdamId ))
							   AND /*Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)*/p.fldOrganId =@OrganId  
							   
		IF(@Type=2 or @Type=3)
		SELECT     Pay.Pay_tblPersonalInfo.fldId AS PayId, Prs.Prs_tblPersonalInfo.fldId AS PrsId, 
							  tblEmployee.fldFamily+'_'+ tblEmployee.fldName+'('+fldFatherName+')' AS fldName_Family, tblEmployee.fldCodemeli, 
							  Prs.Prs_tblPersonalInfo.fldSh_Personali,  fldOrganId,p.fldCostCenterId,fldAnvaeEstekhdamId
		FROM         Pay.Pay_tblPersonalInfo INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
							  Pay.tblMohasebatEzafeKari_TatilKari ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId  INNER JOIN
		pay.tblMohasebat_PersonalInfo as p on p.fldEzafe_TatilKariId=tblMohasebatEzafeKari_TatilKari.fldId INNER JOIN
							  Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
							  cross apply (SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId
										FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
															  Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
										WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId) AND fldTarikh<=@Tarikh
										ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
										)t
							   WHERE fldYear =@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht 
							   and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=p.fldCostCenterId ))
							   and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=fldAnvaeEstekhdamId ))
							   AND fldType= @Ezafe_Tatil 
								AND /*Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)*/p.fldOrganId =@OrganId 
								
		IF(@Type=4)
		SELECT     Pay.Pay_tblPersonalInfo.fldId AS PayId, Prs.Prs_tblPersonalInfo.fldId AS PrsId, 
							 tblEmployee.fldFamily+'_'+ tblEmployee.fldName+'('+fldFatherName+')' AS fldName_Family, tblEmployee.fldCodemeli, 
							  Prs.Prs_tblPersonalInfo.fldSh_Personali,  fldOrganId,p.fldCostCenterId,fldAnvaeEstekhdamId
		FROM         Pay.Pay_tblPersonalInfo INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
							  Pay.tblMohasebat_Eydi ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblMohasebat_Eydi.fldPersonalId   INNER JOIN
		pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatEydiId=tblMohasebat_Eydi.fldId INNER JOIN
							  Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
							  cross apply (SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId
										FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
															  Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
										WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId) AND fldTarikh<=@Tarikh
										ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
										)t
							   WHERE fldYear =@Year AND fldNobatPardakht=@NobatPardakht 
							   and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=p.fldCostCenterId ))
							   and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=fldAnvaeEstekhdamId ))
							   AND p.fldOrganId =@OrganId 
							   

		IF(@Type=5)
		SELECT     Pay.Pay_tblPersonalInfo.fldId AS PayId, Prs.Prs_tblPersonalInfo.fldId AS PrsId, 
							  tblEmployee.fldFamily+'_'+ tblEmployee.fldName+'('+fldFatherName+')'AS fldName_Family, tblEmployee.fldCodemeli, 
							  Prs.Prs_tblPersonalInfo.fldSh_Personali,  fldOrganId,p.fldCostCenterId,fldAnvaeEstekhdamId
		FROM         Pay.Pay_tblPersonalInfo INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
							  Pay.tblMohasebat_Mamuriyat ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblMohasebat_Mamuriyat.fldPersonalId  INNER JOIN
		pay.tblMohasebat_PersonalInfo as p on p.fldMamuriyatId=tblMohasebat_Mamuriyat.fldId INNER JOIN
							  Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
							  cross apply (SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId
										FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
															  Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
										WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId) AND fldTarikh<=@Tarikh
										ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
										)t
							   WHERE fldYear =@Year AND fldMonth=@Month AND fldNobatePardakht=@NobatPardakht
							   and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=p.fldCostCenterId ))
							   and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=fldAnvaeEstekhdamId )) 
							   AND /*Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)*/p.fldOrganId =@OrganId
							  
                       
		 IF(@Type=6)                      
		SELECT     Pay.Pay_tblPersonalInfo.fldId AS PayId, Prs.Prs_tblPersonalInfo.fldId AS PrsId, 
							  tblEmployee.fldFamily+'_'+ tblEmployee.fldName+'('+fldFatherName+')'AS fldName_Family, tblEmployee.fldCodemeli, 
							  Prs.Prs_tblPersonalInfo.fldSh_Personali,  fldOrganId,p.fldCostCenterId,fldAnvaeEstekhdamId
		FROM         Pay.Pay_tblPersonalInfo INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
							  Pay.tblMohasebat_Morakhasi ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblMohasebat_Morakhasi.fldPersonalId  INNER JOIN
		pay.tblMohasebat_PersonalInfo as p on p.fldMorakhasiId=tblMohasebat_Morakhasi.fldId INNER JOIN
							  Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
							  cross apply (SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId
										FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
															  Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
										WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId) AND fldTarikh<=@Tarikh
										ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
										)t
							   WHERE fldYear =@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht
							   and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=p.fldCostCenterId ))
							   and ( @AnvaeEstekhdamId='' or exists (select item from com.Split(@AnvaeEstekhdamId,',') where item=fldAnvaeEstekhdamId ))
							   AND p.fldOrganId =@OrganId 
							   
 
		 
end
if(@fieldName='CheckDisketBazneshastegi')
begin
		SELECT  Pay.Pay_tblPersonalInfo.fldId AS PayId, Prs.Prs_tblPersonalInfo.fldId AS PrsId, tblEmployee.fldFamily+'_'+ tblEmployee.fldName+'('+fldFatherName+')' AS fldName_Family
		,tblEmployee.fldCodemeli,fldSh_Personali,fldOrganId,0 as fldCostCenterId,0 as fldAnvaeEstekhdamId
		FROM         Pay.tblMohasebat INNER JOIN
							  Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS  tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
							  Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
							  Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
							 left join [Com].[tblRaste] as r on [fldText]=fldRasteShoghli
							  WHERE fldYear =@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht and fldCalcType=1
							   AND tblMohasebat_PersonalInfo.fldOrganId  =@OrganId  
							   and r.fldText is null and tblMohasebat_PersonalInfo.fldTypeBimeId=2 

							 
end
GO
