SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblArzeSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)
	declare @sal smallint=substring([dbo].[Fn_AssembelyMiladiToShamsi](getdate()),1,4)
	if (@FieldName='fldId')
	SELECT top(@h) [tblArze].[fldId], [fldBaskoolId], [fldKalaId], [fldShomareHesabCodeDaramadId], [tblArze].[fldUserId], [tblArze].[fldOrganId], [tblArze].[fldDesc], [tblArze].[fldDate], [tblArze].[fldIP] 
	,k.fldName as fldNameKala,fldDaramadCode,fldDaramadTitle,isnull(fldTedad,1)fldTedad,isnull(fldMablagh,0)fldMablagh
	,com. fn_stringDecode(o.fldName) as fldOrganName,fldStatusForoosh
	,case when fldStatusForoosh=0 then N'وزنی' when fldStatusForoosh=1 then N'تعدادی' end as fldStatusForooshName,
	fldVaznVahed
	FROM   [Weigh].[tblArze]  inner join Com.tblKala k on k.fldid=fldKalaId

	inner join drd.tblShomareHesabCodeDaramad  s on s.fldid=fldShomareHesabCodeDaramadId
	inner join drd.tblCodhayeDaramd c on c.fldId=s.fldCodeDaramadId
	inner join drd.tblShomareHedabCodeDaramd_Detail dd on dd.fldCodeDaramdId=c.fldid
	inner join com.tblMeasureUnit m on m.fldid=c.fldUnitId
	inner join com.tblOrganization as o on o.fldId=Weigh.[tblArze].fldOrganId
	
	WHERE  [tblArze].fldId=@Value  and @sal between fldStartYear and fldEndYear

	if (@FieldName='fldDesc')
		SELECT top(@h) [tblArze].[fldId], [fldBaskoolId], [fldKalaId], [fldShomareHesabCodeDaramadId], [tblArze].[fldUserId], [tblArze].[fldOrganId], [tblArze].[fldDesc], [tblArze].[fldDate], [tblArze].[fldIP] 
	,k.fldName as fldNameKala,fldDaramadCode,fldDaramadTitle,isnull(fldTedad,1)fldTedad,isnull(fldMablagh,0)fldMablagh
	,com. fn_stringDecode(o.fldName) as fldOrganName,fldStatusForoosh
	,case when fldStatusForoosh=0 then N'وزنی' when fldStatusForoosh=1 then N'تعدادی' end as fldStatusForooshName,fldVaznVahed
	FROM   [Weigh].[tblArze]  inner join Com.tblKala k on k.fldid=fldKalaId
	inner join drd.tblShomareHesabCodeDaramad  s on s.fldid=fldShomareHesabCodeDaramadId
	inner join drd.tblCodhayeDaramd c on c.fldId=s.fldCodeDaramadId
	inner join drd.tblShomareHedabCodeDaramd_Detail dd on dd.fldCodeDaramdId=c.fldid
	inner join com.tblMeasureUnit m on m.fldid=c.fldUnitId
	inner join com.tblOrganization as o on o.fldId=Weigh.[tblArze].fldOrganId
	WHERE  [tblArze].fldDesc like @Value and [tblArze].fldOrganId =@OrganId and @sal between fldStartYear and fldEndYear

	if (@FieldName='')
	SELECT top(@h) [tblArze].[fldId], [fldBaskoolId], [fldKalaId], [fldShomareHesabCodeDaramadId], [tblArze].[fldUserId], [tblArze].[fldOrganId], [tblArze].[fldDesc], [tblArze].[fldDate], [tblArze].[fldIP] 
	,k.fldName as fldNameKala,fldDaramadCode,fldDaramadTitle,isnull(fldTedad,1)fldTedad,isnull(fldMablagh,0)fldMablagh
	,com. fn_stringDecode(o.fldName) as fldOrganName,fldStatusForoosh
	,case when fldStatusForoosh=0 then N'وزنی' when fldStatusForoosh=1 then N'تعدادی' end as fldStatusForooshName,
	fldVaznVahed
	FROM   [Weigh].[tblArze]  inner join Com.tblKala k on k.fldid=fldKalaId
	inner join drd.tblShomareHesabCodeDaramad  s on s.fldid=fldShomareHesabCodeDaramadId
	inner join drd.tblCodhayeDaramd c on c.fldId=s.fldCodeDaramadId
	inner join drd.tblShomareHedabCodeDaramd_Detail dd on dd.fldCodeDaramdId=c.fldid
	inner join com.tblMeasureUnit m on m.fldid=c.fldUnitId
	inner join com.tblOrganization as o on o.fldId=Weigh.[tblArze].fldOrganId
		where [tblArze].fldOrganId =@OrganId and @sal between fldStartYear and fldEndYear

	if (@FieldName='fldOrganId')
		SELECT top(@h) [tblArze].[fldId], [fldBaskoolId], [fldKalaId], [fldShomareHesabCodeDaramadId], [tblArze].[fldUserId], [tblArze].[fldOrganId], [tblArze].[fldDesc], [tblArze].[fldDate], [tblArze].[fldIP] 
	,k.fldName as fldNameKala,fldDaramadCode,fldDaramadTitle,isnull(fldTedad,1)fldTedad,isnull(fldMablagh,0)fldMablagh
	,com. fn_stringDecode(o.fldName) as fldOrganName,fldStatusForoosh
	,case when fldStatusForoosh=0 then N'وزنی' when fldStatusForoosh=1 then N'تعدادی' end as fldStatusForooshName,fldVaznVahed
	FROM   [Weigh].[tblArze]  inner join Com.tblKala k on k.fldid=fldKalaId
	inner join drd.tblShomareHesabCodeDaramad  s on s.fldid=fldShomareHesabCodeDaramadId
	inner join drd.tblCodhayeDaramd c on c.fldId=s.fldCodeDaramadId
	inner join drd.tblShomareHedabCodeDaramd_Detail dd on dd.fldCodeDaramdId=c.fldid
	inner join com.tblMeasureUnit m on m.fldid=c.fldUnitId
	inner join com.tblOrganization as o on o.fldId=Weigh.[tblArze].fldOrganId
	where [tblArze].fldOrganId =@OrganId and @sal between fldStartYear and fldEndYear

	if (@FieldName='fldBaskoolId')
		SELECT top(@h) [tblArze].[fldId], [fldBaskoolId], [fldKalaId], [fldShomareHesabCodeDaramadId], [tblArze].[fldUserId], [tblArze].[fldOrganId], [tblArze].[fldDesc], [tblArze].[fldDate], [tblArze].[fldIP] 
	,k.fldName as fldNameKala,fldDaramadCode,fldDaramadTitle,isnull(fldTedad,1)fldTedad,isnull(fldMablagh,0)fldMablagh
	,com. fn_stringDecode(o.fldName) as fldOrganName,fldStatusForoosh
	,case when fldStatusForoosh=0 then N'وزنی' when fldStatusForoosh=1 then N'تعدادی' end as fldStatusForooshName,fldVaznVahed
	FROM   [Weigh].[tblArze]  inner join Com.tblKala k on k.fldid=fldKalaId
	inner join drd.tblShomareHesabCodeDaramad  s on s.fldid=fldShomareHesabCodeDaramadId
	inner join drd.tblCodhayeDaramd c on c.fldId=s.fldCodeDaramadId
	inner join drd.tblShomareHedabCodeDaramd_Detail dd on dd.fldCodeDaramdId=c.fldid
	inner join com.tblMeasureUnit m on m.fldid=c.fldUnitId
	inner join com.tblOrganization as o on o.fldId=Weigh.[tblArze].fldOrganId
	where fldBaskoolId =@Value and @sal between fldStartYear and fldEndYear


	if (@FieldName='fldBaskoolId_OrganId')
		SELECT top(@h) [tblArze].[fldId], [fldBaskoolId], [fldKalaId], [fldShomareHesabCodeDaramadId], [tblArze].[fldUserId], [tblArze].[fldOrganId], [tblArze].[fldDesc], [tblArze].[fldDate], [tblArze].[fldIP] 
	,k.fldName as fldNameKala,fldDaramadCode,fldDaramadTitle,isnull(fldTedad,1)fldTedad,isnull(fldMablagh,0)fldMablagh
	,com. fn_stringDecode(o.fldName) as fldOrganName,fldStatusForoosh
	,case when fldStatusForoosh=0 then N'وزنی' when fldStatusForoosh=1 then N'تعدادی' end as fldStatusForooshName,fldVaznVahed
	FROM   [Weigh].[tblArze]  inner join Com.tblKala k on k.fldid=fldKalaId
	inner join drd.tblShomareHesabCodeDaramad  s on s.fldid=fldShomareHesabCodeDaramadId
	inner join drd.tblCodhayeDaramd c on c.fldId=s.fldCodeDaramadId
	inner join drd.tblShomareHedabCodeDaramd_Detail dd on dd.fldCodeDaramdId=c.fldid
	inner join com.tblMeasureUnit m on m.fldid=c.fldUnitId
	inner join com.tblOrganization as o on o.fldId=Weigh.[tblArze].fldOrganId
	where fldBaskoolId =@Value and [tblArze].fldOrganId=@OrganId and @sal between fldStartYear and fldEndYear

	if (@FieldName='fldKalaId_OrganId')
		SELECT top(@h) [tblArze].[fldId], [fldBaskoolId], [fldKalaId], [fldShomareHesabCodeDaramadId], [tblArze].[fldUserId], [tblArze].[fldOrganId], [tblArze].[fldDesc], [tblArze].[fldDate], [tblArze].[fldIP] 
	,k.fldName as fldNameKala,fldDaramadCode,fldDaramadTitle,isnull(fldTedad,1)fldTedad,isnull(fldMablagh,0)fldMablagh
	,com. fn_stringDecode(o.fldName) as fldOrganName,fldStatusForoosh
	,case when fldStatusForoosh=0 then N'وزنی' when fldStatusForoosh=1 then N'تعدادی' end as fldStatusForooshName,fldVaznVahed
	FROM   [Weigh].[tblArze]  inner join Com.tblKala k on k.fldid=fldKalaId
	inner join drd.tblShomareHesabCodeDaramad  s on s.fldid=fldShomareHesabCodeDaramadId
	inner join drd.tblCodhayeDaramd c on c.fldId=s.fldCodeDaramadId
	inner join drd.tblShomareHedabCodeDaramd_Detail dd on dd.fldCodeDaramdId=c.fldid
	inner join com.tblMeasureUnit m on m.fldid=c.fldUnitId
	inner join com.tblOrganization as o on o.fldId=Weigh.[tblArze].fldOrganId
	where fldKalaId =@Value and [tblArze].fldOrganId=@OrganId and @sal between fldStartYear and fldEndYear

	if (@FieldName='fldKalaId')
		SELECT top(@h) [tblArze].[fldId], [fldBaskoolId], [fldKalaId], [fldShomareHesabCodeDaramadId], [tblArze].[fldUserId], [tblArze].[fldOrganId], [tblArze].[fldDesc], [tblArze].[fldDate], [tblArze].[fldIP] 
	,k.fldName as fldNameKala,fldDaramadCode,fldDaramadTitle,isnull(fldTedad,1)fldTedad,isnull(fldMablagh,0)fldMablagh
	,com. fn_stringDecode(o.fldName) as fldOrganName,fldStatusForoosh
	,case when fldStatusForoosh=0 then N'وزنی' when fldStatusForoosh=1 then N'تعدادی' end as fldStatusForooshName,fldVaznVahed
	FROM   [Weigh].[tblArze]  inner join Com.tblKala k on k.fldid=fldKalaId
	inner join drd.tblShomareHesabCodeDaramad  s on s.fldid=fldShomareHesabCodeDaramadId
	inner join drd.tblCodhayeDaramd c on c.fldId=s.fldCodeDaramadId
	inner join drd.tblShomareHedabCodeDaramd_Detail dd on dd.fldCodeDaramdId=c.fldid
	inner join com.tblMeasureUnit m on m.fldid=c.fldUnitId
	inner join com.tblOrganization as o on o.fldId=Weigh.[tblArze].fldOrganId
	where fldKalaId =@Value and @sal between fldStartYear and fldEndYear


	if (@FieldName='fldShomareHesabCodeDaramadId')
		SELECT top(@h) [tblArze].[fldId], [fldBaskoolId], [fldKalaId], [fldShomareHesabCodeDaramadId], [tblArze].[fldUserId], [tblArze].[fldOrganId], [tblArze].[fldDesc], [tblArze].[fldDate], [tblArze].[fldIP] 
	,k.fldName as fldNameKala,fldDaramadCode,fldDaramadTitle,isnull(fldTedad,1)fldTedad,isnull(fldMablagh,0)fldMablagh
	,com. fn_stringDecode(o.fldName) as fldOrganName,fldStatusForoosh
	,case when fldStatusForoosh=0 then N'وزنی' when fldStatusForoosh=1 then N'تعدادی' end as fldStatusForooshName,fldVaznVahed
	FROM   [Weigh].[tblArze]  inner join Com.tblKala k on k.fldid=fldKalaId
	inner join drd.tblShomareHesabCodeDaramad  s on s.fldid=fldShomareHesabCodeDaramadId
	inner join drd.tblCodhayeDaramd c on c.fldId=s.fldCodeDaramadId
	inner join drd.tblShomareHedabCodeDaramd_Detail dd on dd.fldCodeDaramdId=c.fldid
	inner join com.tblMeasureUnit m on m.fldid=c.fldUnitId
	inner join com.tblOrganization as o on o.fldId=Weigh.[tblArze].fldOrganId
	where fldShomareHesabCodeDaramadId =@Value and @sal between fldStartYear and fldEndYear

	if (@FieldName='fldShomareHesabCodeDaramadId_OrganId')
		SELECT top(@h) [tblArze].[fldId], [fldBaskoolId], [fldKalaId], [fldShomareHesabCodeDaramadId], [tblArze].[fldUserId], [tblArze].[fldOrganId], [tblArze].[fldDesc], [tblArze].[fldDate], [tblArze].[fldIP] 
	,k.fldName as fldNameKala,fldDaramadCode,fldDaramadTitle,isnull(fldTedad,1)fldTedad,isnull(fldMablagh,0)fldMablagh
	,com. fn_stringDecode(o.fldName) as fldOrganName,fldStatusForoosh
	,case when fldStatusForoosh=0 then N'وزنی' when fldStatusForoosh=1 then N'تعدادی' end as fldStatusForooshName,fldVaznVahed
	FROM   [Weigh].[tblArze]  inner join Com.tblKala k on k.fldid=fldKalaId
	inner join drd.tblShomareHesabCodeDaramad  s on s.fldid=fldShomareHesabCodeDaramadId
	inner join drd.tblCodhayeDaramd c on c.fldId=s.fldCodeDaramadId
	inner join drd.tblShomareHedabCodeDaramd_Detail dd on dd.fldCodeDaramdId=c.fldid
	inner join com.tblMeasureUnit m on m.fldid=c.fldUnitId
	inner join com.tblOrganization as o on o.fldId=Weigh.[tblArze].fldOrganId
	where fldShomareHesabCodeDaramadId =@Value and [tblArze].fldOrganId=@OrganId and @sal between fldStartYear and fldEndYear


	if (@FieldName='fldDaramadCode')
		SELECT top(@h) [tblArze].[fldId], [fldBaskoolId], [fldKalaId], [fldShomareHesabCodeDaramadId], [tblArze].[fldUserId], [tblArze].[fldOrganId], [tblArze].[fldDesc], [tblArze].[fldDate], [tblArze].[fldIP] 
	,k.fldName as fldNameKala,fldDaramadCode,fldDaramadTitle,isnull(fldTedad,1)fldTedad,isnull(fldMablagh,0)fldMablagh
	,com. fn_stringDecode(o.fldName) as fldOrganName,fldStatusForoosh
	,case when fldStatusForoosh=0 then N'وزنی' when fldStatusForoosh=1 then N'تعدادی' end as fldStatusForooshName,fldVaznVahed
	FROM   [Weigh].[tblArze]  inner join Com.tblKala k on k.fldid=fldKalaId
	inner join drd.tblShomareHesabCodeDaramad  s on s.fldid=fldShomareHesabCodeDaramadId
	inner join drd.tblCodhayeDaramd c on c.fldId=s.fldCodeDaramadId
	inner join drd.tblShomareHedabCodeDaramd_Detail dd on dd.fldCodeDaramdId=c.fldid
	inner join com.tblMeasureUnit m on m.fldid=c.fldUnitId
	inner join com.tblOrganization as o on o.fldId=Weigh.[tblArze].fldOrganId
	where fldDaramadCode  like @Value and [tblArze].fldOrganId=@OrganId and @sal between fldStartYear and fldEndYear


	if (@FieldName='fldDaramadTitle')
		SELECT top(@h) [tblArze].[fldId], [fldBaskoolId], [fldKalaId], [fldShomareHesabCodeDaramadId], [tblArze].[fldUserId], [tblArze].[fldOrganId], [tblArze].[fldDesc], [tblArze].[fldDate], [tblArze].[fldIP] 
	,k.fldName as fldNameKala,fldDaramadCode,fldDaramadTitle,isnull(fldTedad,1)fldTedad,isnull(fldMablagh,0)fldMablagh
	,com. fn_stringDecode(o.fldName) as fldOrganName,fldStatusForoosh
	,case when fldStatusForoosh=0 then N'وزنی' when fldStatusForoosh=1 then N'تعدادی' end as fldStatusForooshName,fldVaznVahed
	FROM   [Weigh].[tblArze]  inner join Com.tblKala k on k.fldid=fldKalaId
	inner join drd.tblShomareHesabCodeDaramad  s on s.fldid=fldShomareHesabCodeDaramadId
	inner join drd.tblCodhayeDaramd c on c.fldId=s.fldCodeDaramadId
	inner join drd.tblShomareHedabCodeDaramd_Detail dd on dd.fldCodeDaramdId=c.fldid
	inner join com.tblMeasureUnit m on m.fldid=c.fldUnitId
	inner join com.tblOrganization as o on o.fldId=Weigh.[tblArze].fldOrganId
	where fldDaramadTitle  like @Value and [tblArze].fldOrganId=@OrganId and @sal between fldStartYear and fldEndYear



	if (@FieldName='fldNameKala')
		SELECT top(@h) [tblArze].[fldId], [fldBaskoolId], [fldKalaId], [fldShomareHesabCodeDaramadId], [tblArze].[fldUserId], [tblArze].[fldOrganId], [tblArze].[fldDesc], [tblArze].[fldDate], [tblArze].[fldIP] 
	,k.fldName as fldNameKala,fldDaramadCode,fldDaramadTitle,isnull(fldTedad,1)fldTedad,isnull(fldMablagh,0)fldMablagh
	,com. fn_stringDecode(o.fldName) as fldOrganName,fldStatusForoosh
	,case when fldStatusForoosh=0 then N'وزنی' when fldStatusForoosh=1 then N'تعدادی' end as fldStatusForooshName,fldVaznVahed
	FROM   [Weigh].[tblArze]  inner join Com.tblKala k on k.fldid=fldKalaId
	inner join drd.tblShomareHesabCodeDaramad  s on s.fldid=fldShomareHesabCodeDaramadId
	inner join drd.tblCodhayeDaramd c on c.fldId=s.fldCodeDaramadId
	inner join drd.tblShomareHedabCodeDaramd_Detail dd on dd.fldCodeDaramdId=c.fldid
	inner join com.tblMeasureUnit m on m.fldid=c.fldUnitId
	inner join com.tblOrganization as o on o.fldId=Weigh.[tblArze].fldOrganId
	where k.fldName  like @Value and [tblArze].fldOrganId=@OrganId and @sal between fldStartYear and fldEndYear




	



	COMMIT
GO
