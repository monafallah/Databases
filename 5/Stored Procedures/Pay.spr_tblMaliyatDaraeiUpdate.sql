SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMaliyatDaraeiUpdate] 
    @fldYear smallint,
    @fldMonth tinyint,
    @fldNobatePardakht tinyint,
    @fldOrganId int,
    @fldUserId int,
    @fldIp varchar(15)
AS 
	 
	
	BEGIN TRAN
	--@fldMaliyatType=1 محاسبات براساس مالیات سامانه
	--@fldMaliyatType=2 محاسبات براساس مالیات دارایی
	declare @MaliyatType tinyint=1
	select top(1)  @MaliyatType=fldMaliyatType from Pay.tblMohasebat as m
	inner join pay.tblMohasebat_PersonalInfo as mp on mp.fldMohasebatId=m.fldId
	WHERE  m.[fldYear] = @fldYear and m. [fldMonth] = @fldMonth and  m.[fldNobatPardakht] = @fldNobatePardakht and mp.[fldOrganId] = @fldOrganId

	if(@MaliyatType=2)
	begin
		update m set m.fldMaliyatCalc=m.fldMaliyat from  Pay.tblMohasebat as m
		inner join pay.tblMohasebat_PersonalInfo as mp on mp.fldMohasebatId=m.fldId
				inner join pay.Pay_tblPersonalInfo as p on p.fldid=m.fldPersonalId
				inner join prs.Prs_tblPersonalInfo as prs on prs.fldid=p.fldPrs_PersonalInfoId
				inner join com.tblEmployee as e on e.fldId=prs.fldEmployeeId
				inner join pay.tblMaliyatDaraei as d on d.fldCodemeli=e.fldCodemeli collate SQL_Latin1_General_CP1_CI_AS  and d.fldYear=m.fldYear and d.fldMonth=m.fldMonth
				WHERE  m.[fldYear] = @fldYear and m. [fldMonth] = @fldMonth and  m.[fldNobatPardakht] = @fldNobatePardakht and mp.[fldOrganId] = @fldOrganId
				and m.fldMaliyatCalc is null
	
		update m set m.fldMaliyat=d.fldMaliyat from  Pay.tblMohasebat as m
		inner join pay.tblMohasebat_PersonalInfo as mp on mp.fldMohasebatId=m.fldId
				inner join pay.Pay_tblPersonalInfo as p on p.fldid=m.fldPersonalId
				inner join prs.Prs_tblPersonalInfo as prs on prs.fldid=p.fldPrs_PersonalInfoId
				inner join com.tblEmployee as e on e.fldId=prs.fldEmployeeId
				inner join pay.tblMaliyatDaraei as d on d.fldCodemeli=e.fldCodemeli collate SQL_Latin1_General_CP1_CI_AS  and d.fldYear=m.fldYear and d.fldMonth=m.fldMonth
				WHERE  m.[fldYear] = @fldYear and m. [fldMonth] = @fldMonth and  m.[fldNobatPardakht] = @fldNobatePardakht and mp.[fldOrganId] = @fldOrganId
	end	
	else
	begin
			update m set m.fldMaliyatCalc=d.fldMaliyat from  Pay.tblMohasebat as m
				inner join pay.tblMohasebat_PersonalInfo as mp on mp.fldMohasebatId=m.fldId
				inner join pay.Pay_tblPersonalInfo as p on p.fldid=m.fldPersonalId
				inner join prs.Prs_tblPersonalInfo as prs on prs.fldid=p.fldPrs_PersonalInfoId
				inner join com.tblEmployee as e on e.fldId=prs.fldEmployeeId
				inner join pay.tblMaliyatDaraei as d on d.fldCodemeli=e.fldCodemeli collate SQL_Latin1_General_CP1_CI_AS  and d.fldYear=m.fldYear and d.fldMonth=m.fldMonth
				WHERE  m.[fldYear] = @fldYear and m. [fldMonth] = @fldMonth and  m.[fldNobatPardakht] = @fldNobatePardakht and mp.[fldOrganId] = @fldOrganId

	end	

	
	if (@@error<>0)
		rollback

	COMMIT
GO
