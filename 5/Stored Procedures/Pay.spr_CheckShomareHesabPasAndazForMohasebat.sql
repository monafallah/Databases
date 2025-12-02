SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Pay].[spr_CheckShomareHesabPasAndazForMohasebat]
@Year varchar(4),
@Month varchar(2),
@NobatePardakht TINYINT,
@OrganId int,
@PersonalInfoId int
as
--declare @Year varchar(4)=1397,
--@Month varchar(2)=7,
--@NobatePardakht TINYINT=1,
--@OrganId int=1,
--@PersonalInfoId int=0
declare @BankId int=0

select @BankId=fldP_BankFixId from pay.tblSetting
where fldOrganId=@OrganId

select  distinct p.fldId,e.fldName+' '+e.fldFamily as fldName_Family,e.fldCodemeli 
from pay.Pay_tblPersonalInfo as p
inner join prs.prs_tblPersonalInfo as prs on prs.fldId=p.fldPrs_PersonalInfoId
inner join com.tblEmployee as e on e.fldId=prs.fldEmployeeId
inner join com.tblAshkhas as a on a.fldHaghighiId=e.fldId
INNER JOIN Pay.tblKarKardeMahane as k ON k.fldPersonalId = p.fldId
outer apply(select count(*) as fldcountPasAndaz from com.tblShomareHesabeOmoomi as s
			inner join pay.tblShomareHesabPasAndaz as sp on sp.fldShomareHesabPersonalId=s.fldId
			where s.fldAshkhasId=a.fldId and fldBankId=@BankId) pas
cross apply (select top 1 st.fldStatusId from com.tblPersonalStatus as st where st.fldPayPersonalInfoId=p.fldId order by st.fldDateTaghirVaziyat desc) as st
cross apply (select top 1 st2.fldStatusId from com.tblPersonalStatus as st2 where st2.fldPrsPersonalInfoId=prs.fldId order by st2.fldDateTaghirVaziyat desc) as st2
where  Com.fn_OrganId(prs.fldId)=@OrganId 
and k.fldYear=@Year and k.fldMah=@Month and k.fldNobatePardakht=@NobatePardakht 
and st.fldStatusId=1 and st2.fldStatusId=1 and p.fldPasAndaz=1 
 and( @PersonalInfoId=0 or p.fldId=@PersonalInfoId) 
 and (pas.fldcountPasAndaz=0)
GO
