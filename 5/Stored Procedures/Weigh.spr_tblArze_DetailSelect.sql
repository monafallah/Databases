SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblArze_DetailSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT    top (@h)    a.fldId, fldHeaderId, fldParametrSabetCodeDaramd
	,case when fldNoeField=5 then c.fldTitle else  a.fldValue end as fldValue, a.fldValue  as fldValue_Arze
	, fldFlag, a.fldUserId, a.fldOrganId, a.fldDesc, a.fldDate, a.fldIP
	,p.fldNameParametreEn,p.fldNameParametreFa
FROM            Weigh.tblArze_Detail AS a
inner join Weigh.tblArze as h on h.fldId=a.fldHeaderId
inner join drd.tblParametreSabet as p on p.fldId=a.fldParametrSabetCodeDaramd
inner join drd.tblShomareHesabCodeDaramad as s on s.fldId=h.fldShomareHesabCodeDaramadId
left join drd.tblComboBoxValue as c on c.fldComboBoxId=p.fldComboBaxId and c.fldValue=a.fldValue
	WHERE  a.fldId=@Value and a.fldOrganId=@organId and p.fldTypeParametr=1
union all
select 0 as fldId, h.fldId as fldHeaderId,0 as fldParametrSabetCodeDaramd
	,cast(h.fldTedad as nvarchar(100)) as fldValue, N''  as fldValue_Arze
	,cast (0 as bit) as fldFlag, h.fldUserId, h.fldOrganId, h.fldDesc, h.fldDate, h.fldIP
	,N'' as fldNameParametreEn,N'تعداد'  as fldNameParametreFa
FROM            Weigh.tblArze as h
where h.fldId=@Value and h.fldOrganId=@organId 
 union all
 select -1 as fldId, h.fldId as fldHeaderId,0 as fldParametrSabetCodeDaramd
	,cast ((h.fldMablagh/h.fldTedad)as nvarchar(1000)) as fldValue, N''  as fldValue_Arze
	,cast (0 as bit) as fldFlag, h.fldUserId, h.fldOrganId, h.fldDesc, h.fldDate, h.fldIP
	,N'' as fldNameParametreEn,N'مبلغ واحد'  as fldNameParametreFa
FROM     Weigh.tblArze as h 
inner join drd.tblShomareHesabCodeDaramad as s on s.fldId=h.fldShomareHesabCodeDaramadId
where h.fldId=@Value and  h.fldOrganId=@organId  and s.fldFormolsaz is null and s.fldFormulMohasebatId is null 


if (@FieldName='fldNameParametreEn')
	SELECT    top (@h)    a.fldId, fldHeaderId, fldParametrSabetCodeDaramd
	,case when fldNoeField=5 then c.fldTitle else  a.fldValue end as fldValue, a.fldValue  as fldValue_Arze
	, fldFlag, a.fldUserId, a.fldOrganId, a.fldDesc, a.fldDate, a.fldIP
	,p.fldNameParametreEn,p.fldNameParametreFa
FROM            Weigh.tblArze_Detail AS a
inner join Weigh.tblArze as h on h.fldId=a.fldHeaderId
inner join drd.tblParametreSabet as p on p.fldId=a.fldParametrSabetCodeDaramd
inner join drd.tblShomareHesabCodeDaramad as s on s.fldId=h.fldShomareHesabCodeDaramadId
left join drd.tblComboBoxValue as c on c.fldComboBoxId=p.fldComboBaxId and c.fldValue=a.fldValue
	WHERE  fldNameParametreEn like @Value and a.fldOrganId=@organId and p.fldTypeParametr=1
/*union all
select 0 as fldId, h.fldId as fldHeaderId,0 as fldParametrSabetCodeDaramd
	,cast(h.fldTedad as nvarchar(100)) as fldValue, a.fldValue  as fldValue_Arze
	,cast (0 as bit) as fldFlag, h.fldUserId, h.fldOrganId, h.fldDesc, h.fldDate, h.fldIP
	,N'' as fldNameParametreEn,N'تعداد'  as fldNameParametreFa
FROM            Weigh.tblArze as h
where h.fldId=@Value and h.fldOrganId=@organId 
 union all
 select -1 as fldId, h.fldId as fldHeaderId,0 as fldParametrSabetCodeDaramd
	,cast ((h.fldMablagh/h.fldTedad)as nvarchar(1000)) as fldValue, a.fldValue  as fldValue_Arze
	,cast (0 as bit) as fldFlag, h.fldUserId, h.fldOrganId, h.fldDesc, h.fldDate, h.fldIP
	,N'' as fldNameParametreEn,N'مبلغ واحد'  as fldNameParametreFa
FROM     Weigh.tblArze as h 
inner join drd.tblShomareHesabCodeDaramad as s on s.fldId=h.fldShomareHesabCodeDaramadId
where h.fldId=@Value and  h.fldOrganId=@organId  and s.fldFormolsaz is null and s.fldFormulKoliId is null*/



	if (@FieldName='fldDesc')
SELECT    top (@h)    a.fldId, a.fldHeaderId, a.fldParametrSabetCodeDaramd
	,case when fldNoeField=5 then c.fldTitle else  a.fldValue end as fldValue, a.fldValue  as fldValue_Arze
	, a.fldFlag, a.fldUserId, a.fldOrganId, a.fldDesc, a.fldDate, a.fldIP
	,p.fldNameParametreEn,p.fldNameParametreFa
FROM            Weigh.tblArze_Detail AS a
inner join Weigh.tblArze as h on h.fldId=a.fldHeaderId
inner join drd.tblParametreSabet as p on p.fldId=a.fldParametrSabetCodeDaramd
inner join drd.tblShomareHesabCodeDaramad as s on s.fldId=h.fldShomareHesabCodeDaramadId
left join drd.tblComboBoxValue as c on c.fldComboBoxId=p.fldComboBaxId and c.fldValue=a.fldValue
	WHERE  a.fldDesc like @Value and a.fldOrganId=@organId and p.fldTypeParametr=1
union all
select 0 as fldId, h.fldId as fldHeaderId,0 as fldParametrSabetCodeDaramd
	,cast(h.fldTedad as nvarchar(100)) as fldValue, N''  as fldValue_Arze
	,cast (0 as bit) as fldFlag, h.fldUserId, h.fldOrganId, h.fldDesc, h.fldDate, h.fldIP
	,N'' as fldNameParametreEn,N'تعداد'  as fldNameParametreFa
FROM            Weigh.tblArze as h
where h.fldDesc like @Value and h.fldOrganId=@organId 
 union all
 select -1 as fldId, h.fldId as fldHeaderId,0 as fldParametrSabetCodeDaramd
	,cast ((h.fldMablagh/h.fldTedad)as nvarchar(1000)) as fldValue, N''  as fldValue_Arze
	,cast (0 as bit) as fldFlag, h.fldUserId, h.fldOrganId, h.fldDesc, h.fldDate, h.fldIP
	,N'' as fldNameParametreEn,N'مبلغ واحد'  as fldNameParametreFa
FROM     Weigh.tblArze as h 
inner join drd.tblShomareHesabCodeDaramad as s on s.fldId=h.fldShomareHesabCodeDaramadId
where h.fldDesc like @Value and h.fldOrganId=@organId  and s.fldFormolsaz is null and s.fldFormulMohasebatId is null  

	if (@FieldName='fldHeaderId')
	SELECT    top (@h)    a.fldId, fldHeaderId, fldParametrSabetCodeDaramd
	,case when fldNoeField=5 then c.fldTitle else  a.fldValue end as fldValue, a.fldValue  as fldValue_Arze
	, fldFlag, a.fldUserId, a.fldOrganId, a.fldDesc, a.fldDate, a.fldIP
	,p.fldNameParametreEn,p.fldNameParametreFa
FROM            Weigh.tblArze_Detail AS a
inner join Weigh.tblArze as h on h.fldId=a.fldHeaderId
inner join drd.tblParametreSabet as p on p.fldId=a.fldParametrSabetCodeDaramd
inner join drd.tblShomareHesabCodeDaramad as s on s.fldId=h.fldShomareHesabCodeDaramadId
left join drd.tblComboBoxValue as c on c.fldComboBoxId=p.fldComboBaxId and c.fldValue=a.fldValue
	WHERE a. fldHeaderId like @Value  and p.fldTypeParametr=1
union all
select 0 as fldId, h.fldId as fldHeaderId,0 as fldParametrSabetCodeDaramd
	,cast(h.fldTedad as nvarchar(100)) as fldValue, N''  as fldValue_Arze
	,cast (0 as bit) as fldFlag, h.fldUserId, h.fldOrganId, h.fldDesc, h.fldDate, h.fldIP
	,N'' as fldNameParametreEn,N'تعداد'  as fldNameParametreFa
FROM            Weigh.tblArze as h
where h.fldId like @Value  
 union all
 select -1 as fldId, h.fldId as fldHeaderId,0 as fldParametrSabetCodeDaramd
	,cast ((h.fldMablagh/h.fldTedad)as nvarchar(1000)) as fldValue, N''  as fldValue_Arze
	,cast (0 as bit) as fldFlag, h.fldUserId, h.fldOrganId, h.fldDesc, h.fldDate, h.fldIP
	,N'' as fldNameParametreEn,N'مبلغ واحد'  as fldNameParametreFa
FROM     Weigh.tblArze as h 
inner join drd.tblShomareHesabCodeDaramad as s on s.fldId=h.fldShomareHesabCodeDaramadId
where h.fldId like @Value    and s.fldFormolsaz is null and s.fldFormulMohasebatId is null 

	if (@FieldName='')
	SELECT    top (@h)    a.fldId, fldHeaderId, fldParametrSabetCodeDaramd
	,case when fldNoeField=5 then c.fldTitle else  a.fldValue end as fldValue, a.fldValue  as fldValue_Arze
	, fldFlag, a.fldUserId, a.fldOrganId, a.fldDesc, a.fldDate, a.fldIP
	,p.fldNameParametreEn,p.fldNameParametreFa
FROM            Weigh.tblArze_Detail AS a
inner join Weigh.tblArze as h on h.fldId=a.fldHeaderId
inner join drd.tblParametreSabet as p on p.fldId=a.fldParametrSabetCodeDaramd
inner join drd.tblShomareHesabCodeDaramad as s on s.fldId=h.fldShomareHesabCodeDaramadId
left join drd.tblComboBoxValue as c on c.fldComboBoxId=p.fldComboBaxId and c.fldValue=a.fldValue
	where a.fldOrganId=@organId and p.fldTypeParametr=1
union all
select 0 as fldId, h.fldId as fldHeaderId,0 as fldParametrSabetCodeDaramd
	,cast(h.fldTedad as nvarchar(100)) as fldValue, N''  as fldValue_Arze
	,cast (0 as bit) as fldFlag, h.fldUserId, h.fldOrganId, h.fldDesc, h.fldDate, h.fldIP
	,N'' as fldNameParametreEn,N'تعداد'  as fldNameParametreFa
FROM            Weigh.tblArze as h
where h.fldOrganId=@organId 
 union all
 select -1 as fldId, h.fldId as fldHeaderId,0 as fldParametrSabetCodeDaramd
	,cast ((h.fldMablagh/h.fldTedad)as nvarchar(1000)) as fldValue, N''  as fldValue_Arze
	,cast (0 as bit) as fldFlag, h.fldUserId, h.fldOrganId, h.fldDesc, h.fldDate, h.fldIP
	,N'' as fldNameParametreEn,N'مبلغ واحد'  as fldNameParametreFa
FROM     Weigh.tblArze as h 
inner join drd.tblShomareHesabCodeDaramad as s on s.fldId=h.fldShomareHesabCodeDaramadId
where h.fldOrganId=@organId  and s.fldFormolsaz is null and s.fldFormulMohasebatId is null 

	if (@FieldName='fldOrganId')
	SELECT    top (@h)   a.fldId, fldHeaderId, fldParametrSabetCodeDaramd
	,case when fldNoeField=5 then c.fldTitle else  a.fldValue end as fldValue, a.fldValue  as fldValue_Arze
	, fldFlag, a.fldUserId, a.fldOrganId, a.fldDesc, a.fldDate, a.fldIP
	,p.fldNameParametreEn,p.fldNameParametreFa
FROM            Weigh.tblArze_Detail AS a
inner join Weigh.tblArze as h on h.fldId=a.fldHeaderId
inner join drd.tblParametreSabet as p on p.fldId=a.fldParametrSabetCodeDaramd
inner join drd.tblShomareHesabCodeDaramad as s on s.fldId=h.fldShomareHesabCodeDaramadId
left join drd.tblComboBoxValue as c on c.fldComboBoxId=p.fldComboBaxId and c.fldValue=a.fldValue
	where a.fldOrganId=@organId and p.fldTypeParametr=1
union all
select 0 as fldId, h.fldId as fldHeaderId,0 as fldParametrSabetCodeDaramd
	,cast(h.fldTedad as nvarchar(100)) as fldValue, N''  as fldValue_Arze
	,cast (0 as bit) as fldFlag, h.fldUserId, h.fldOrganId, h.fldDesc, h.fldDate, h.fldIP
	,N'' as fldNameParametreEn,N'تعداد'  as fldNameParametreFa
FROM            Weigh.tblArze as h
where h.fldOrganId=@organId 
 union all
 select -1 as fldId, h.fldId as fldHeaderId,0 as fldParametrSabetCodeDaramd
	,cast ((h.fldMablagh/h.fldTedad)as nvarchar(1000)) as fldValue,N''  as fldValue_Arze
	,cast (0 as bit) as fldFlag, h.fldUserId, h.fldOrganId, h.fldDesc, h.fldDate, h.fldIP
	,N'' as fldNameParametreEn,N'مبلغ واحد'  as fldNameParametreFa
FROM     Weigh.tblArze as h 
inner join drd.tblShomareHesabCodeDaramad as s on s.fldId=h.fldShomareHesabCodeDaramadId
where h.fldOrganId=@organId  and s.fldFormolsaz is null and s.fldFormulMohasebatId is null 

	
	COMMIT
GO
