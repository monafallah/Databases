SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Pay].[spr_payListNoMaliyat_BimePersonal]
@fieldname nvarchar(50),

 @Year SMALLINT,@Month TINYINT,@NobatPardakht TINYINT,@organid int,@personalid int
 as
 if (@fieldname='Maliyat')
 select * from(
select (select fldnameEstekhdam+','
FROM         Pay.tblKarKardeMahane INNER JOIN
							  Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS  tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
							  Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
							  cross apply (SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId
										,tblAnvaEstekhdam.fldTitle as fldnameEstekhdam
										FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
															  Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
										WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId) 
										ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
										)t
										 WHERE (tblKarKardeMahane.fldPersonalId=@personalid or @personalid=0)and  fldYear =@Year AND fldMah=@Month AND fldNobatePardakht=@NobatPardakht
										   AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
										   and not exists  (select * from pay.tblFiscal_Header h inner join pay.tblFiscalTitle f  
										   on f.fldFiscalHeaderId=h.fldid where substring(fldEffectiveDate,1,4)=@Year and substring(fldEffectiveDate,6,2)<=@Month and f.fldAnvaEstekhdamId=t.fldAnvaeEstekhdamId)
										   
group by fldnameEstekhdam
for xml path (''))NoeEstekhdam ,'' bime)t
where NoeEstekhdam is not null 

if (@fieldname='Bime')
select * from(
select (select fldnameEstekhdam+'('+tt.fldTitle +')'+','
FROM         Pay.tblKarKardeMahane INNER JOIN
							  Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS  tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN
							  Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
							 inner join com.tblTypeBime tt on tt.fldId=Pay_tblPersonalInfo.fldTypeBimeId
							  cross apply (SELECT     TOP (1) ISNULL(Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId, 0) AS fldAnvaeEstekhdamId
										,tblAnvaEstekhdam.fldTitle as fldnameEstekhdam
										FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
															  Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
										WHERE     (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId) 
										ORDER BY tblHistoryNoeEstekhdam.fldTarikh DESC ,tblHistoryNoeEstekhdam.fldDate DESC
										)t
										 WHERE (tblKarKardeMahane.fldPersonalId=@personalid or @personalid=0)and  fldYear =@Year AND fldMah=@Month AND fldNobatePardakht=@NobatPardakht
										   AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
										   and not exists  (select * from pay.tblMoteghayerhayeHoghoghi h 
										   where substring(h.fldTarikhEjra,1,4)=@Year and substring(h.fldTarikhEjra,6,2)<=@Month 
										   and h.fldAnvaeEstekhdamId=t.fldAnvaeEstekhdamId and h.fldTypeBimeId=Pay_tblPersonalInfo.fldTypeBimeId)
										   
group by fldnameEstekhdam,fldTitle
for xml path (''))NoeEstekhdam ,'' bime)t
where NoeEstekhdam is not null 






GO
