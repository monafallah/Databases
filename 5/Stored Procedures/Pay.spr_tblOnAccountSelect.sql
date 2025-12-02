SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblOnAccountSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@value2 nvarchar(50),
@value3 nvarchar(50),
@value4 nvarchar(50),
@OrganId int,
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h) a.[fldId],a.fldCodeMeli,pay.fldId as [fldPersonalId], [fldYear], [fldMonth], [fldTitle], [fldNobatePardakt], [fldKhalesPardakhti], a.[fldUserId], [fldIP], a.[fldDate], [fldFlag] 
	,fldFamily+'_'+fldName as fldName,a.fldOrganId,fldGhatei,fldShomareHesab,case when fldGhatei=1 then N'قطعی' else N'غیر قطعی' end as fldGhateiName
	FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId
	WHERE  a.fldId=@value
	
	if (@fieldname='fldPersonalId')
	SELECT top(@h) a.[fldId],a.fldCodeMeli,pay.fldId as [fldPersonalId], [fldYear], [fldMonth], [fldTitle], [fldNobatePardakt], [fldKhalesPardakhti], a.[fldUserId], [fldIP], a.[fldDate], [fldFlag] 
	,fldFamily+'_'+fldName as fldName,a.fldOrganId,fldGhatei,fldShomareHesab,case when fldGhatei=1 then N'قطعی' else N'غیر قطعی' end as fldGhateiName
	FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId
	WHERE  pay.fldId=@value and a.fldOrganId=@OrganId

	if (@fieldname='fldCodeMeli')
	SELECT top(@h) a.[fldId],a.fldCodeMeli,pay.fldId as [fldPersonalId], [fldYear], [fldMonth], [fldTitle], [fldNobatePardakt], [fldKhalesPardakhti], a.[fldUserId], [fldIP], a.[fldDate], [fldFlag] 
	,fldFamily+'_'+fldName as fldName,a.fldOrganId,fldGhatei,fldShomareHesab,case when fldGhatei=1 then N'قطعی' else N'غیر قطعی' end as fldGhateiName
	FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId
	WHERE  a.fldCodeMeli=@value and a.fldOrganId=@OrganId

	if (@fieldname='fldTitle')
	SELECT top(@h) a.[fldId],a.fldCodeMeli,pay.fldId as [fldPersonalId], [fldYear], [fldMonth], [fldTitle], [fldNobatePardakt], [fldKhalesPardakhti], a.[fldUserId], [fldIP], a.[fldDate], [fldFlag] 
	,fldFamily+'_'+fldName as fldName,a.fldOrganId,fldGhatei,fldShomareHesab,case when fldGhatei=1 then N'قطعی' else N'غیر قطعی' end as fldGhateiName
	FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId
	WHERE  a.fldTitle like @value and a.fldOrganId=@OrganId

	if (@fieldname='check')
	SELECT  a.[fldId],a.fldCodeMeli,pay.fldId as [fldPersonalId], [fldYear], [fldMonth], [fldTitle], [fldNobatePardakt], [fldKhalesPardakhti], a.[fldUserId], [fldIP], a.[fldDate], [fldFlag] 
	,fldFamily+'_'+fldName as fldName,a.fldOrganId,fldGhatei,fldShomareHesab,case when fldGhatei=1 then N'قطعی' else N'غیر قطعی' end as fldGhateiName
	FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId
	WHERE  a.fldTitle = @value and fldYear=@value2 and fldMonth=@value3  and fldNobatePardakt=@value4 and a.fldOrganId=@OrganId

	if (@fieldname='fldYear')
	SELECT top(@h) a.[fldId],a.fldCodeMeli,pay.fldId as [fldPersonalId], [fldYear], [fldMonth], [fldTitle], [fldNobatePardakt], [fldKhalesPardakhti], a.[fldUserId], [fldIP], a.[fldDate], [fldFlag] 
	,fldFamily+'_'+fldName as fldName,a.fldOrganId,fldGhatei,fldShomareHesab,case when fldGhatei=1 then N'قطعی' else N'غیر قطعی' end as fldGhateiName
	FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId
	WHERE  a.fldYear=@value and a.fldOrganId=@OrganId

	if (@fieldname='fldMonth')
	SELECT top(@h) a.[fldId],a.fldCodeMeli,pay.fldId as [fldPersonalId], [fldYear], [fldMonth], [fldTitle], [fldNobatePardakt], [fldKhalesPardakhti], a.[fldUserId], [fldIP], a.[fldDate], [fldFlag] 
	,fldFamily+'_'+fldName as fldName,a.fldOrganId,fldGhatei,fldShomareHesab,case when fldGhatei=1 then N'قطعی' else N'غیر قطعی' end as fldGhateiName
	FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId
	WHERE  a.fldMonth=@value and a.fldOrganId=@OrganId

	if (@fieldname='fldShomareHesab')
	SELECT top(@h) a.[fldId],a.fldCodeMeli,pay.fldId as [fldPersonalId], [fldYear], [fldMonth], [fldTitle], [fldNobatePardakt], [fldKhalesPardakhti], a.[fldUserId], [fldIP], a.[fldDate], [fldFlag] 
	,fldFamily+'_'+fldName as fldName,a.fldOrganId,fldGhatei,fldShomareHesab,case when fldGhatei=1 then N'قطعی' else N'غیر قطعی' end as fldGhateiName
	FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId
	WHERE  a.fldShomareHesab like @value and a.fldOrganId=@OrganId

	if (@fieldname='fldGhatei')
	SELECT top(@h) a.[fldId],a.fldCodeMeli,pay.fldId as [fldPersonalId], [fldYear], [fldMonth], [fldTitle], [fldNobatePardakt], [fldKhalesPardakhti], a.[fldUserId], [fldIP], a.[fldDate], [fldFlag] 
	,fldFamily+'_'+fldName as fldName,a.fldOrganId,fldGhatei,fldShomareHesab,case when fldGhatei=1 then N'قطعی' else N'غیر قطعی' end as fldGhateiName
	FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId
	WHERE  a.fldGhatei=@value and a.fldOrganId=@OrganId

	if (@fieldname='fldName')
	select  top(@h) * from(
	SELECT a.[fldId],a.fldCodeMeli,pay.fldId as [fldPersonalId], [fldYear], [fldMonth], [fldTitle], [fldNobatePardakt], [fldKhalesPardakhti], a.[fldUserId], [fldIP], a.[fldDate], [fldFlag] 
	,fldFamily+'_'+fldName as fldName,a.fldOrganId,fldGhatei,fldShomareHesab,case when fldGhatei=1 then N'قطعی' else N'غیر قطعی' end as fldGhateiName
	FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId
	where a.fldOrganId=@OrganId)t
	WHERE  fldName=@value 

	if (@fieldname='fldGhateiName')
	select  top(@h) * from(
	SELECT a.[fldId],a.fldCodeMeli,pay.fldId as [fldPersonalId], [fldYear], [fldMonth], [fldTitle], [fldNobatePardakt], [fldKhalesPardakhti], a.[fldUserId], [fldIP], a.[fldDate], [fldFlag] 
	,fldFamily+'_'+fldName as fldName,a.fldOrganId,fldGhatei,fldShomareHesab,case when fldGhatei=1 then N'قطعی' else N'غیر قطعی' end as fldGhateiName
	FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId
	where a.fldOrganId=@OrganId)t
	WHERE  fldGhateiName=@value 

	if (@fieldname='')
	SELECT top(@h) a.[fldId],a.fldCodeMeli,pay.fldId as [fldPersonalId], [fldYear], [fldMonth], [fldTitle], [fldNobatePardakt], [fldKhalesPardakhti], a.[fldUserId], [fldIP], a.[fldDate], [fldFlag] 
	,fldFamily+'_'+fldName as fldName,a.fldOrganId,fldGhatei,fldShomareHesab,case when fldGhatei=1 then N'قطعی' else N'غیر قطعی' end as fldGhateiName
	FROM   [Pay].[tblOnAccount]  as a
	inner join com.tblEmployee as e on e.fldCodemeli=a.fldCodeMeli
	inner join prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=e.fldId
	inner join pay.Pay_tblPersonalInfo as pay on pay.fldPrs_PersonalInfoId=p.fldId
	where   a.fldOrganId=@OrganId


	COMMIT
GO
