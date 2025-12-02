SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Pay].[spr_CheckShomareHesabForMohasebat]
@Year varchar(4),
@Month varchar(2),
@NobatePardakht TINYINT,
@OrganId int,
@PersonalInfoId int,
@HesabTypeId tinyint
as
--declare @Year varchar(4)=1401,
--@Month varchar(2)=7,
--@NobatePardakht TINYINT=1,
--@OrganId int=1,
--@PersonalInfoId int=0

declare @BankId int=0

select @BankId=fldH_BankFixId from pay.tblSetting
where fldOrganId=@OrganId

select  distinct p.fldId,e.fldName+' '+e.fldFamily as fldName_Family,e.fldCodemeli 
from pay.Pay_tblPersonalInfo as p
inner join prs.prs_tblPersonalInfo as prs on prs.fldId=p.fldPrs_PersonalInfoId
inner join com.tblEmployee as e on e.fldId=prs.fldEmployeeId
inner join com.tblAshkhas as a on a.fldHaghighiId=e.fldId
INNER JOIN Pay.tblKarKardeMahane as k ON k.fldPersonalId = p.fldId
outer apply( SELECT count(com.tblShomareHesabeOmoomi.fldId) as fldcount FROM com.tblShomareHesabeOmoomi 
	INNER JOIN com.tblShomareHesabOmoomi_Detail  
	ON com.tblShomareHesabeOmoomi.fldId=com.tblShomareHesabOmoomi_Detail.fldShomareHesabId 
	WHERE fldAshkhasId=a.fldId AND fldBankId=@BankId AND fldTypeHesab=0 and fldHesabTypeId=@HesabTypeId
)hesab
cross apply (select top 1 st.fldStatusId from com.tblPersonalStatus as st where st.fldPayPersonalInfoId=p.fldId order by st.fldDateTaghirVaziyat desc) as st
cross apply (select top 1 st2.fldStatusId from com.tblPersonalStatus as st2 where st2.fldPrsPersonalInfoId=prs.fldId order by st2.fldDateTaghirVaziyat desc) as st2
where  Com.fn_OrganId(prs.fldId)=@OrganId 
and k.fldYear=@Year and k.fldMah=@Month and k.fldNobatePardakht=@NobatePardakht 
and st.fldStatusId=1 and st2.fldStatusId=1
 and( @PersonalInfoId=0 or p.fldId=@PersonalInfoId) 
 and (hesab.fldcount=0)


GO
