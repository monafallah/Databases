SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Pay].[spr_Pay_SelectConflictKarkard_Mohasebat]
 @Year smallint,@Month tinyint,@OrganId int,@PersonalId int,@CostCenterId nvarchar(200),@AnvaeEstekhdam nvarchar(200)
 as
 begin tran
if(@PersonalId<>0)
	select  tblEmployee.fldFamily+'_'+ tblEmployee.fldName+'('+fldFatherName+')' AS fldName_Family
	,tblEmployee.fldCodemeli  from (
	select   max(m.fldid) as Id ,fldPersonalId 
	FROM   [Pay].[tblMohasebat] as m
	WHERE m.fldPersonalId=@PersonalId and  fldYear = @Year  and fldMonth=@Month    
	group by fldPersonalId
	)t
	INNER JOIN [Pay].[tblMohasebat] as m on m.fldId=t.Id
	INNER JOIN pay.tblKarKardeMahane as k on k.fldPersonalId=m.fldPersonalId and m.fldYear=k.fldYear and m.fldMonth=k.fldMah
	INNER JOIN Pay.Pay_tblPersonalInfo as pay ON  m.fldPersonalId = Pay.fldId
	INNER JOIN Prs.Prs_tblPersonalInfo ON Pay.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId 
	INNER JOIN Com.tblEmployee AS  tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  
	INNER JOIN Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
	where m.fldKarkard<>k.fldKarkard or m.fldTedadEzafeKar<>k.fldEzafeKari or  ROUND( (m.fldTedadTatilKar/7.33), 0)<>k.fldTatileKari or m.fldTedadNobatKari<>k.fldNobateKari
	and m.fldShift<>k.fldShift or m.fldMeetingCount<>k.fldMeetingCount or  m.fldBaBeytute+m.fldBedunBeytute<>k.fldMamoriatBaBeitote+k.fldMamoriatBedoneBeitote
	and m.fldGheybat<>k.fldGheybat 

else
	select  tblEmployee.fldFamily+'_'+ tblEmployee.fldName+'('+fldFatherName+')' AS fldName_Family
		,tblEmployee.fldCodemeli  from (
	select   max(m.fldid) as Id ,fldPersonalId 
	FROM   [Pay].[tblMohasebat] as m
	INNER JOIN pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
	INNER JOIN Pay.Pay_tblPersonalInfo as pay ON  m.fldPersonalId = Pay.fldId
	cross apply (SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId
									FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
															Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
									WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = pay.fldPrs_PersonalInfoId) 
									ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
									)t
	WHERE  fldYear = @Year  and fldMonth=@Month    and fldOrganId=@OrganId 
	and ( @CostCenterId='' or exists (select item from com.Split(@CostCenterId,',') where item=p.fldCostCenterId ))
							and ( @AnvaeEstekhdam='' or exists (select item from com.Split(@AnvaeEstekhdam,',') where item=fldAnvaeEstekhdamId ))
	group by fldPersonalId
	)t
	INNER JOIN [Pay].[tblMohasebat] as m on m.fldId=t.Id
	INNER JOIN pay.tblKarKardeMahane as k on k.fldPersonalId=m.fldPersonalId and m.fldYear=k.fldYear and m.fldMonth=k.fldMah
	INNER JOIN Pay.Pay_tblPersonalInfo as pay ON  m.fldPersonalId = Pay.fldId
	INNER JOIN Prs.Prs_tblPersonalInfo ON Pay.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId 
	INNER JOIN Com.tblEmployee AS  tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  
	INNER JOIN Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
	where m.fldKarkard<>k.fldKarkard or m.fldTedadEzafeKar<>k.fldEzafeKari or  ROUND( (m.fldTedadTatilKar/7.33), 0)<>k.fldTatileKari or m.fldTedadNobatKari<>k.fldNobateKari
	and m.fldShift<>k.fldShift or m.fldMeetingCount<>k.fldMeetingCount or  m.fldBaBeytute+m.fldBedunBeytute<>k.fldMamoriatBaBeitote+k.fldMamoriatBedoneBeitote
	and m.fldGheybat<>k.fldGheybat

commit tran

GO
