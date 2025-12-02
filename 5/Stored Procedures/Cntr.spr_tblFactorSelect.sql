SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblFactorSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@OrganId int,
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.fldStatus, f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldStatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	, isnull(fldSubject,'') fldNameContract, isnull(fldContractId,0)fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
	,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
	,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,e.fldName+' ' +e.fldFamily fldNameTankhah, tkh.fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join tblContract_Factor cf on cf.fldFactorId=f.fldid
	left join tblContracts c on c.fldid=fldContractId
	left join cntr.tblTankhah_Group tg on tg.fldid=fldTankhahGroupId
	left join cntr.tblTanKhahGardan tkh on tkh.fldid=fldTankhahId
	left join com.tblEmployee e on e.fldid=tkh.fldEmployeeId
	WHERE  f.fldId=@value


	if (@fieldname='fldStatus')/*فرق داره*/
	SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.fldStatus, f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldStatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	, isnull(fldSubject,'') fldNameContract, isnull(fldContractId,0)fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,e.fldName+' ' +e.fldFamily fldNameTankhah, tkh.fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join tblContract_Factor cf on cf.fldFactorId=f.fldid
	left join tblContracts c on c.fldid=fldContractId
	left join cntr.tblTankhah_Group tg on tg.fldid=fldTankhahGroupId
	left join cntr.tblTanKhahGardan tkh on tkh.fldid=fldTankhahId
	left join com.tblEmployee e on e.fldid=tkh.fldEmployeeId
	WHERE  f.fldStatus=@value
	

	
	if (@fieldname='')
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.[fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	, isnull(fldSubject,'') fldNameContract, isnull(fldContractId,0)fldContractId

	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,e.fldName+' ' +e.fldFamily fldNameTankhah, tkh.fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join tblContract_Factor cf on cf.fldFactorId=f.fldid
	left join tblContracts c on c.fldid=fldContractId
	left join cntr.tblTankhah_Group tg on tg.fldid=fldTankhahGroupId
	left join cntr.tblTanKhahGardan tkh on tkh.fldid=fldTankhahId
	left join com.tblEmployee e on e.fldid=tkh.fldEmployeeId


	if (@fieldname='fldOrganId')
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.[fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	, isnull(fldSubject,'') fldNameContract, isnull(fldContractId,0)fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah, 0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join tblContract_Factor cf on cf.fldFactorId=f.fldid
	left join tblContracts c on c.fldid=fldContractId
	where f.fldorganId=@OrganId
	

	if (@fieldname='CheckShanaseMoadiyan')
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.[fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	, isnull(fldSubject,'') fldNameContract, isnull(fldContractId,0)fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join tblContract_Factor cf on cf.fldFactorId=f.fldid
	left join tblContracts c on c.fldid=fldContractId
	where  fldShanaseMoadiyan like @value
/***************************************/

	if (@fieldname='Factor_Contract')--فاکتور هایی که حتمن قرارداد دارن 
	SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], f.[fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,case when fm.fldBudjeCodingId is null then c.fldSubject else c.fldSubject collate  Persian_100_CI_AI +'(' +cd.fldtitle+')' end as fldNameContract,fldContractId
	,'' as SellerName,cd.fldTitle as TitleProject
		,0 as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor] f 
	inner join tblContract_Factor cf on cf.fldFactorId=f.fldid
	inner join tblContracts c on c.fldid=fldContractId
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cd on cd.fldCodeingBudjeId=fm.fldBudjeCodingId
	where f.fldOrganId=@OrganId

	if (@fieldname='Factor_Contract_fldId')--فاکتور هایی که حتمن قرارداد دارن 
	SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], f.[fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,case when fm.fldBudjeCodingId is null then c.fldSubject else c.fldSubject collate  Persian_100_CI_AI +'(' +cd.fldtitle+')' end as fldNameContract,fldContractId
	,'' as SellerName,cd.fldTitle as TitleProject
		,0 as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor] f 
	inner join tblContract_Factor cf on cf.fldFactorId=f.fldid
	inner join tblContracts c on c.fldid=fldContractId
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cd on cd.fldCodeingBudjeId=fm.fldBudjeCodingId
	where  f.fldid=@value and f.fldOrganId=@OrganId

	if (@fieldname='Factor_Contract_fldTarikh')--فاکتور هایی که حتمن قرارداد دارن 
	SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], f.[fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,case when fm.fldBudjeCodingId is null then c.fldSubject else c.fldSubject collate  Persian_100_CI_AI +'(' +cd.fldtitle+')' end as fldNameContract,fldContractId
	,'' as SellerName,cd.fldTitle as TitleProject
		,0 as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor] f 
	inner join tblContract_Factor cf on cf.fldFactorId=f.fldid
	inner join tblContracts c on c.fldid=fldContractId
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cd on cd.fldCodeingBudjeId=fm.fldBudjeCodingId
	where f.fldTarikh like @value and f.fldOrganId=@OrganId

		if (@fieldname='Factor_Contract_fldShomare')--فاکتور هایی که حتمن قرارداد دارن 
	SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], f.[fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,case when fm.fldBudjeCodingId is null then c.fldSubject else c.fldSubject collate  Persian_100_CI_AI +'(' +cd.fldtitle+')' end as fldNameContract,fldContractId
	,'' as SellerName,cd.fldTitle as TitleProject
		,0 as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor] f 
	inner join tblContract_Factor cf on cf.fldFactorId=f.fldid
	inner join tblContracts c on c.fldid=fldContractId
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cd on cd.fldCodeingBudjeId=fm.fldBudjeCodingId
	where f.fldShomare like @value and  f.fldOrganId=@OrganId


		if (@fieldname='Factor_Contract_fldShanaseMoadiyan')--فاکتور هایی که حتمن قرارداد دارن 
	SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], f.[fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,case when fm.fldBudjeCodingId is null then c.fldSubject else c.fldSubject collate  Persian_100_CI_AI +'(' +cd.fldtitle+')' end as fldNameContract,fldContractId
	,'' as SellerName,cd.fldTitle as TitleProject
		,0 as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor] f 
	inner join tblContract_Factor cf on cf.fldFactorId=f.fldid
	inner join tblContracts c on c.fldid=fldContractId
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cd on cd.fldCodeingBudjeId=fm.fldBudjeCodingId
	where fldShanaseMoadiyan like @value and  f.fldOrganId=@OrganId


		if (@fieldname='Factor_Contract_fldstatusName')--فاکتور هایی که حتمن قرارداد دارن 
	SELECT top(@h)* from (select f.[fldId], f.[fldTarikh], f.[fldShomare], f.[fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,case when fm.fldBudjeCodingId is null then c.fldSubject else c.fldSubject collate  Persian_100_CI_AI +'(' +cd.fldtitle+')' end as fldNameContract,fldContractId
	,'' as SellerName,cd.fldTitle as TitleProject
		,0 as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor] f 
	inner join tblContract_Factor cf on cf.fldFactorId=f.fldid
	inner join tblContracts c on c.fldid=fldContractId
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cd on cd.fldCodeingBudjeId=fm.fldBudjeCodingId
	where f.fldOrganId=@OrganId
	)t where fldstatusName like @value 


		if (@fieldname='Factor_Contract_fldSharhSanad')--فاکتور هایی که حتمن قرارداد دارن 
	SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], f.[fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,case when fm.fldBudjeCodingId is null then c.fldSubject else c.fldSubject collate  Persian_100_CI_AI +'(' +cd.fldtitle+')' end as fldNameContract,fldContractId
	,'' as SellerName,cd.fldTitle as TitleProject
		,0 as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor] f 
	inner join tblContract_Factor cf on cf.fldFactorId=f.fldid
	inner join tblContracts c on c.fldid=fldContractId
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cd on cd.fldCodeingBudjeId=fm.fldBudjeCodingId
	where fldSharhSanad like @value and  f.fldOrganId=@OrganId



		if (@fieldname='Factor_Contract_fldNameContract')--فاکتور هایی که حتمن قرارداد دارن 
	SELECT top(@h)* from (select f.[fldId], f.[fldTarikh], f.[fldShomare], f.[fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,case when fm.fldBudjeCodingId is null then c.fldSubject else c.fldSubject collate  Persian_100_CI_AI +'(' +cd.fldtitle+')' end as fldNameContract,fldContractId
	,'' as SellerName,cd.fldTitle as TitleProject
		,0 as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor] f 
	inner join tblContract_Factor cf on cf.fldFactorId=f.fldid
	inner join tblContracts c on c.fldid=fldContractId
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cd on cd.fldCodeingBudjeId=fm.fldBudjeCodingId
	where f.fldOrganId=@OrganId
	)t
	where fldNameContract like @value 


		if (@fieldname='Factor_Contract_TitleProject')--فاکتور هایی که حتمن قرارداد دارن 
	SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], f.[fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,case when fm.fldBudjeCodingId is null then c.fldSubject else c.fldSubject collate  Persian_100_CI_AI +'(' +cd.fldtitle+')' end as fldNameContract,fldContractId
	,'' as SellerName,cd.fldTitle as TitleProject
		,0 as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor] f 
	inner join tblContract_Factor cf on cf.fldFactorId=f.fldid
	inner join tblContracts c on c.fldid=fldContractId
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cd on cd.fldCodeingBudjeId=fm.fldBudjeCodingId
	where cd.fldTitle  like @value and  f.fldOrganId=@OrganId


		if (@fieldname='Factor_Contract_fldProjeId')--فاکتور هایی که حتمن قرارداد دارن 
	SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], f.[fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,case when fm.fldBudjeCodingId is null then c.fldSubject else c.fldSubject collate  Persian_100_CI_AI +'(' +cd.fldtitle+')' end as fldNameContract,fldContractId
	,'' as SellerName,cd.fldTitle as TitleProject
		,0 as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor] f 
	inner join tblContract_Factor cf on cf.fldFactorId=f.fldid
	inner join tblContracts c on c.fldid=fldContractId
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cd on cd.fldCodeingBudjeId=fm.fldBudjeCodingId
	where fldBudjeCodingId like @value and  f.fldOrganId=@OrganId


		if (@fieldname='Factor_Contract_fldtarikhvariz')--فاکتور هایی که حتمن قرارداد دارن 
	SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], f.[fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,case when fm.fldBudjeCodingId is null then c.fldSubject else c.fldSubject collate  Persian_100_CI_AI +'(' +cd.fldtitle+')' end as fldNameContract,fldContractId
	,'' as SellerName,cd.fldTitle as TitleProject
		,0 as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor] f 
	inner join tblContract_Factor cf on cf.fldFactorId=f.fldid
	inner join tblContracts c on c.fldid=fldContractId
	left join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cd on cd.fldCodeingBudjeId=fm.fldBudjeCodingId
	where fldtarikhvariz like @value and  f.fldOrganId=@OrganId


/******************************************/
	if (@fieldname='Invoice')--فاکتور هایی که مربوط به فاکتور مستقل میشوند و حتمن اشخاص آنها پر هستند و مربوط به تنخواه نمیشوند
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,''fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	inner join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	where   fm.fldTankhahGRoupId is null and f.fldOrganId=@OrganId

		if (@fieldname='Invoice_fldId')--فاکتور هایی که مربوط به فاکتور مستقل میشوند و حتمن اشخاص آنها پر هستند و مربوط به تنخواه نمیشوند
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
		,''fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	inner join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	where f.fldId=@value and  fm.fldTankhahGRoupId is null and f.fldOrganId=@OrganId

		if (@fieldname='Invoice_fldTarikh')--فاکتور هایی که مربوط به فاکتور مستقل میشوند و حتمن اشخاص آنها پر هستند و مربوط به تنخواه نمیشوند
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
		,''fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	inner join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	where  f.fldTarikh like @value and  fm.fldTankhahGRoupId is null and f.fldOrganId=@OrganId

		if (@fieldname='Invoice_fldShomare')--فاکتور هایی که مربوط به فاکتور مستقل میشوند و حتمن اشخاص آنها پر هستند و مربوط به تنخواه نمیشوند
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
		,''fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	inner join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	where  f.fldShomare like @value  and  fm.fldTankhahGRoupId is null and f.fldOrganId=@OrganId

		if (@fieldname='Invoice_fldShanaseMoadiyan')--فاکتور هایی که مربوط به فاکتور مستقل میشوند و حتمن اشخاص آنها پر هستند و مربوط به تنخواه نمیشوند
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
		,''fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	inner join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	where  fldShanaseMoadiyan like @value and  fm.fldTankhahGRoupId is null and f.fldOrganId=@OrganId


		if (@fieldname='Invoice_fldstatusName')--فاکتور هایی که مربوط به فاکتور مستقل میشوند و حتمن اشخاص آنها پر هستند و مربوط به تنخواه نمیشوند
		SELECT top(@h)* from (select f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
		,''fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	inner join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	where   fm.fldTankhahGRoupId is null and f.fldOrganId=@OrganId
	)t 
	where fldstatusName like @value 


		if (@fieldname='Invoice_fldSharhSanad')--فاکتور هایی که مربوط به فاکتور مستقل میشوند و حتمن اشخاص آنها پر هستند و مربوط به تنخواه نمیشوند
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
		,''fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	inner join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	where  fldSharhSanad like @value and  fm.fldTankhahGRoupId is null and f.fldOrganId=@OrganId

		if (@fieldname='Invoice_SellerName')--فاکتور هایی که مربوط به فاکتور مستقل میشوند و حتمن اشخاص آنها پر هستند و مربوط به تنخواه نمیشوند
		SELECT top(@h)* from (select f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
		,''fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	inner join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	where    fm.fldTankhahGRoupId is null and f.fldOrganId=@OrganId
	)t  where SellerName  like @value 

		if (@fieldname='Invoice_TitleProject')--فاکتور هایی که مربوط به فاکتور مستقل میشوند و حتمن اشخاص آنها پر هستند و مربوط به تنخواه نمیشوند
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
		,''fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	inner join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	where  cb.fldTitle like @value and  fm.fldTankhahGRoupId is null and f.fldOrganId=@OrganId

		if (@fieldname='Invoice_fldtarikhvariz')--فاکتور هایی که مربوط به فاکتور مستقل میشوند و حتمن اشخاص آنها پر هستند و مربوط به تنخواه نمیشوند
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], [fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
		,''fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	inner join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	where fldtarikhvariz like @value and   fm.fldTankhahGRoupId is null and f.fldOrganId=@OrganId

	

/******************************************/
	if (@fieldname='Supplying')---فاکتورهایی که حتمن تنخواه گردان آنها پر هستند و در جدول قرارداد-فاکتور برا آنها چیزی ذخیره نمیشود 
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.[fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,'' fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	where fm.fldTankhahGroupId is not null and f.fldOrganId=@OrganId

		if (@fieldname='Supplying_fldId')---فاکتورهایی که حتمن تنخواه گردان آنها پر هستند و در جدول قرارداد-فاکتور برا آنها چیزی ذخیره نمیشود 
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.[fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,'' fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	where f.fldId=@value and  fm.fldTankhahGroupId is not null and f.fldOrganId=@OrganId

		if (@fieldname='Supplying_fldTarikh')---فاکتورهایی که حتمن تنخواه گردان آنها پر هستند و در جدول قرارداد-فاکتور برا آنها چیزی ذخیره نمیشود 
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.[fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,'' fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	where  f.fldTarikh like @value and fm.fldTankhahGroupId is not null and f.fldOrganId=@OrganId


		if (@fieldname='Supplying_fldShomare')---فاکتورهایی که حتمن تنخواه گردان آنها پر هستند و در جدول قرارداد-فاکتور برا آنها چیزی ذخیره نمیشود 
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.[fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,'' fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	where fldShomare like @value and  fm.fldTankhahGroupId is not null and f.fldOrganId=@OrganId


		if (@fieldname='Supplying_fldShanaseMoadiyan')---فاکتورهایی که حتمن تنخواه گردان آنها پر هستند و در جدول قرارداد-فاکتور برا آنها چیزی ذخیره نمیشود 
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.[fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,'' fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	where fldShanaseMoadiyan like @value and  fm.fldTankhahGroupId is not null and f.fldOrganId=@OrganId


		if (@fieldname='Supplying_fldstatusName')---فاکتورهایی که حتمن تنخواه گردان آنها پر هستند و در جدول قرارداد-فاکتور برا آنها چیزی ذخیره نمیشود 
		SELECT top(@h) * from (select f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.[fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,'' fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	where fm.fldTankhahGroupId is not null and f.fldOrganId=@OrganId
	)t
	where fldstatusName like @value

		if (@fieldname='Supplying_fldSharhSanad')---فاکتورهایی که حتمن تنخواه گردان آنها پر هستند و در جدول قرارداد-فاکتور برا آنها چیزی ذخیره نمیشود 
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.[fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,'' fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	where  fldSharhSanad like @value  and fm.fldTankhahGroupId is not null and f.fldOrganId=@OrganId

		if (@fieldname='Supplying_SellerName')---فاکتورهایی که حتمن تنخواه گردان آنها پر هستند و در جدول قرارداد-فاکتور برا آنها چیزی ذخیره نمیشود 
		SELECT top(@h) * from (select f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.[fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,'' fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	where fm.fldTankhahGroupId is not null and f.fldOrganId=@OrganId
	)t 
	where SellerName like @value 

	if (@fieldname='Supplying_TitleProject')---فاکتورهایی که حتمن تنخواه گردان آنها پر هستند و در جدول قرارداد-فاکتور برا آنها چیزی ذخیره نمیشود 
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.[fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,'' fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	where  cb.fldTitle like @value  and fm.fldTankhahGroupId is not null and f.fldOrganId=@OrganId


	if (@fieldname='Supplying_fldtarikhvariz')---فاکتورهایی که حتمن تنخواه گردان آنها پر هستند و در جدول قرارداد-فاکتور برا آنها چیزی ذخیره نمیشود 
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.[fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	,'' fldNameContract,0 fldContractId
	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,''fldNameTankhah,0 as fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	where  fldtarikhvariz like @value  and fm.fldTankhahGroupId is not null and f.fldOrganId=@OrganId

/****************************************************************/
	if (@fieldname='fldTankhahGroupId')
		SELECT top(@h)f.[fldId], f.[fldTarikh], f.[fldShomare], [fldShanaseMoadiyan], f.[fldStatus], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,case when f.fldstatus=1 then  N'تایید شده' else N'تایید نشده' end as fldstatusName ,fldSharhSanad
	, isnull(fldSubject,'') fldNameContract, isnull(fldContractId,0)fldContractId

	,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(a.fldId),'') as SellerName,cb.fldTitle as TitleProject
		,isnull(a.fldid,0) as fldAshkhasId ,isnull(fldBudjeCodingId,0) as fldProjeId
		,fldKasrBime,fldKasrHosnAnjamKar,isnull(fldtarikhvariz,'')fldtarikhvariz,isnull(fldQRCode,'') fldQrCode
	,ee.fldName+' '+ee.fldFamily fldNameTankhah,ee.fldid fldEmployeeId
	FROM   [Cntr].[tblFactor]  f
	inner join cntr.tblFactorMostaghel fm on fm.fldFactorId=f.fldid
	inner join cntr.tblTankhah_Group tt on tt.fldid=fm.fldTankhahGroupId
	inner join cntr.tblTanKhahGardan t1 on t1.fldid=tt.fldTankhahId
	inner join com.tblEmployee ee on ee.fldid=t1.fldEmployeeId
	left join bud.tblCodingBudje_Details cb on cb.fldCodeingBudjeId=fm.fldBudjeCodingId
	left join com.tblAshkhas a on a.fldId=fm.fldAshkhasId
	left join cntr.tblContract_Factor cf on cf.fldFactorId=f.fldid
	left join cntr.tblContracts c on c.fldid=fldContractId
	where fldTankhahGroupId =@value and f.fldOrganId=@OrganId
	COMMIT
GO
