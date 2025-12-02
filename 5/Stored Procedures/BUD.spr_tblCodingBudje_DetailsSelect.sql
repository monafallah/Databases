SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblCodingBudje_DetailsSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@value2 nvarchar(50),
@value3 nvarchar(max),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)  [fldCodeingBudjeId], [fldhierarchyidId], [fldLevelId], [fldStrhid], [fldHeaderId], c.[fldTitle], c.[fldCode], [fldOldId], [fldTarh_KhedmatTypeId], [fldEtebarTypeId], [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], [fldBudCode] 
	,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,fldCodeingLevelId
	,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
	,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
	FROM   [BUD].[tblCodingBudje_Details] c
	inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
	left join bud.tblCodingLevel  l on l.fldid=fldCodeingLevelId
	left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
	left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
	outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
	outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
	outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2
	WHERE  [fldCodeingBudjeId]=@value order by fldBudCode
	
	if (@fieldname='fldPID')
	begin
		if (@Value3='')	
			SELECT top(@h)c.[fldCodeingBudjeId], c.[fldhierarchyidId], c.[fldLevelId], c.[fldStrhid], c.[fldHeaderId], c.[fldTitle], c.[fldCode], c.[fldOldId], c.[fldTarh_KhedmatTypeId], 
			c.[fldEtebarTypeId],c. [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], c.[fldBudCode] 
			,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,c.fldCodeingLevelId
			,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
			,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
			FROM   [BUD].[tblCodingBudje_Details] c
			inner join  [BUD].[tblCodingBudje_Details] p on p.fldCodeingBudjeId=@Value and c.fldHeaderId=@value2 and c.fldhierarchyidId.GetAncestor(1)=p.fldhierarchyidId 
			inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
			left join bud.tblCodingLevel  l on l.fldid=c.fldCodeingLevelId
			left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
			left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
			outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
			outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
			outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2
			order by fldBudCode
		else
			SELECT distinct top(@h)c.[fldCodeingBudjeId], c.[fldhierarchyidId], c.[fldLevelId], c.[fldStrhid], c.[fldHeaderId], c.[fldTitle], c.[fldCode], c.[fldOldId], c.[fldTarh_KhedmatTypeId], 
			c.[fldEtebarTypeId],c. [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], c.[fldBudCode] 
			,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,c.fldCodeingLevelId
			,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
			,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
			FROM   [BUD].[tblCodingBudje_Details] c
			inner join  [BUD].[tblCodingBudje_Details] p on p.fldCodeingBudjeId=@Value and c.fldHeaderId=@value2 and c.fldhierarchyidId.GetAncestor(1)=p.fldhierarchyidId 
			inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
			left join bud.tblCodingLevel  l on l.fldid=c.fldCodeingLevelId
			left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
			left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
			outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
			outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
			outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2
			cross apply (select t.fldTitle,t.fldBudCode fldBudCode,t.fldStrhid from BUD.tblCodingBudje_Details t	
								where t.fldHeaderId=c.fldHeaderId and  t.fldhierarchyidId.IsDescendantOf(c.fldhierarchyidId)=1)child
			where	(c.[fldBudCode]+'-'+c.fldTitle) like @value3 or (child.[fldBudCode]+'-'+child.fldTitle like @value3) 
			order by fldBudCode
		end
		
	
	if (@fieldname='fldBudCode')
	
	SELECT top(@h)* from(select  [fldCodeingBudjeId], [fldhierarchyidId], [fldLevelId], [fldStrhid], [fldHeaderId], c.[fldTitle], c.[fldCode], [fldOldId], [fldTarh_KhedmatTypeId], [fldEtebarTypeId], [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], [fldBudCode] 
	,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,fldCodeingLevelId
	,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
	,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
	FROM   [BUD].[tblCodingBudje_Details] c
	inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
	left join bud.tblCodingLevel  l on l.fldid=fldCodeingLevelId
	left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
	left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
	outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
	outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
	outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2
		)t 
		where fldBudCode=@value and fldHeaderId=@value2 order by fldBudCode

		

	if (@fieldname='Child')
	SELECT top(@h)c.[fldCodeingBudjeId], c.[fldhierarchyidId], c.[fldLevelId], c.[fldStrhid], c.[fldHeaderId], c.[fldTitle], c.[fldCode], c.[fldOldId], c.[fldTarh_KhedmatTypeId], 
	c.[fldEtebarTypeId],c. [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], c.[fldBudCode] 
	,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,c.fldCodeingLevelId
	,isnull(pcod.t,'') as fldPcode
	,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
	,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
	FROM   [BUD].[tblCodingBudje_Details] c
	left outer join[BUD].[tblCodingBudje_Details] as p on p.fldhierarchyidId.GetAncestor(1)=c.fldhierarchyidId
	inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
	left join bud.tblCodingLevel  l on l.fldid=c.fldCodeingLevelId
	left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
	left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
	outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
	outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
	outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2

	where p.fldCodeingBudjeId is null and h.fldYear=@Value and h.fldOrganId=@Value2 order by fldBudCode

	
	if (@fieldname='fldEtebarType')
	SELECT top(@h)  [fldCodeingBudjeId], [fldhierarchyidId], [fldLevelId], [fldStrhid], [fldHeaderId], c.[fldTitle], c.[fldCode], [fldOldId], [fldTarh_KhedmatTypeId], [fldEtebarTypeId], [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], [fldBudCode] 
	,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,fldCodeingLevelId
	,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
	,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
	FROM   [BUD].[tblCodingBudje_Details] c
	inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
	left join bud.tblCodingLevel  l on l.fldid=fldCodeingLevelId
	left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
	left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
	outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
	outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
	outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2
	where e.fldTitle like @value order by fldBudCode

	
	if (@fieldname='fldMasrafTTitle')
	SELECT top(@h)  [fldCodeingBudjeId], [fldhierarchyidId], [fldLevelId], [fldStrhid], [fldHeaderId], c.[fldTitle], c.[fldCode], [fldOldId], [fldTarh_KhedmatTypeId], [fldEtebarTypeId], [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], [fldBudCode] 
	,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,fldCodeingLevelId
	,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
	,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
	FROM   [BUD].[tblCodingBudje_Details] c
	inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
	left join bud.tblCodingLevel  l on l.fldid=fldCodeingLevelId
	left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
	left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
	outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
	outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
	outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2
	where m.fldTitle like @value order by fldBudCode
	
	if (@fieldname='Project_Sarmayeii')
	SELECT top(@h)  [fldCodeingBudjeId], [fldhierarchyidId], [fldLevelId], [fldStrhid], [fldHeaderId], c.[fldTitle], c.[fldCode], [fldOldId], [fldTarh_KhedmatTypeId], [fldEtebarTypeId], [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], [fldBudCode] 
	,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,fldCodeingLevelId
	,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
	,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
	FROM   [BUD].[tblCodingBudje_Details] c
	inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
	left join bud.tblCodingLevel  l on l.fldid=fldCodeingLevelId
	left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
	left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
	cross apply(select fldItemId from bud.tblPishbini as b
				inner join acc.tblCoding_Details as ch on ch.fldId=b.fldCodingAcc_DetailsId
				inner join acc.tblCoding_Details as p on p.fldHeaderCodId=ch.fldHeaderCodId and ch.fldCodeId.IsDescendantOf(p.fldCodeId)=1
				inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId
				where b.fldCodingBudje_DetailsId=c.fldCodeingBudjeId and fldItemId=11)t
	outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
	outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
	outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2
	where h.fldYear = @value and h.fldOrganId=@value2 and c.fldLevelId=4 and fldTarh_KhedmatTypeId=1
	order by fldBudCode

	if (@fieldname='fldHeaderId')
SELECT top(@h)  [fldCodeingBudjeId], [fldhierarchyidId], [fldLevelId], [fldStrhid], [fldHeaderId], c.[fldTitle], c.[fldCode], [fldOldId], [fldTarh_KhedmatTypeId], [fldEtebarTypeId], [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], [fldBudCode] 
	,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,fldCodeingLevelId
	,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
	,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
	FROM   [BUD].[tblCodingBudje_Details] c
	inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
	left join bud.tblCodingLevel  l on l.fldid=fldCodeingLevelId
	left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
	left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
	outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
	outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
	outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2
	where fldHeaderId like @value order by fldBudCode

	
	if (@fieldname='fldCode')
	SELECT top(@h)  [fldCodeingBudjeId], [fldhierarchyidId], [fldLevelId], [fldStrhid], [fldHeaderId], c.[fldTitle], c.[fldCode], [fldOldId], [fldTarh_KhedmatTypeId], [fldEtebarTypeId], [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], [fldBudCode] 
	,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,fldCodeingLevelId
	,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
	,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
	FROM   [BUD].[tblCodingBudje_Details] c
	inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
	left join bud.tblCodingLevel  l on l.fldid=fldCodeingLevelId
	left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
	left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
	outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
	outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
	outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2
	where c.fldCode like @value order by fldBudCode
	

	
	if (@fieldname='fldTitle')
SELECT top(@h)  [fldCodeingBudjeId], [fldhierarchyidId], [fldLevelId], [fldStrhid], [fldHeaderId], c.[fldTitle], c.[fldCode], [fldOldId], [fldTarh_KhedmatTypeId], [fldEtebarTypeId], [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], [fldBudCode] 
	,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,fldCodeingLevelId
	,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
	,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
	FROM   [BUD].[tblCodingBudje_Details] c
	inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
	left join bud.tblCodingLevel  l on l.fldid=fldCodeingLevelId
	left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
	left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
	outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
	outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
	outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2
	where c.fldTitle like @value order by fldBudCode


	if (@fieldname='')
	SELECT top(@h)  [fldCodeingBudjeId], [fldhierarchyidId], [fldLevelId], [fldStrhid], [fldHeaderId], c.[fldTitle], c.[fldCode], [fldOldId], [fldTarh_KhedmatTypeId], [fldEtebarTypeId], [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], [fldBudCode] 
	,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,fldCodeingLevelId
	,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
	,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
	FROM   [BUD].[tblCodingBudje_Details] c
	inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
	left join bud.tblCodingLevel  l on l.fldid=fldCodeingLevelId
	left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
	left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
	outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
	outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
	outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2
	order by fldBudCode



	if (@fieldname='Khedmat')
	SELECT top(@h)  [fldCodeingBudjeId], [fldhierarchyidId], [fldLevelId], [fldStrhid], [fldHeaderId], c.[fldTitle], c.[fldCode], [fldOldId], [fldTarh_KhedmatTypeId], [fldEtebarTypeId], [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], [fldBudCode] 
	,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,fldCodeingLevelId
	,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
	,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
	FROM   [BUD].[tblCodingBudje_Details] c
	inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
	left join bud.tblCodingLevel  l on l.fldid=fldCodeingLevelId
	left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
	left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
	outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
	outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
	outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2
	where h.fldYear=@value  and h.fldOrganId=@value2 and c.fldLevelId=3 and fldTarh_KhedmatTypeId=2 order by fldBudCode
	
	 
	if (@fieldname='Poroje')
	SELECT top(@h)  [fldCodeingBudjeId], [fldhierarchyidId], [fldLevelId], [fldStrhid], [fldHeaderId], c.[fldTitle], c.[fldCode], [fldOldId], [fldTarh_KhedmatTypeId], [fldEtebarTypeId], [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], [fldBudCode] 
	,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,fldCodeingLevelId
	,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
	,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
	FROM   [BUD].[tblCodingBudje_Details] c
	inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
	left join bud.tblCodingLevel  l on l.fldid=fldCodeingLevelId
	left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
	left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
	outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
	outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
	outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2
	where h.fldYear=@value  and h.fldOrganId=@value2 and c.fldLevelId=4 and fldTarh_KhedmatTypeId=1 order by fldBudCode
	
	if (@fieldname='Mali')
	SELECT top(@h)  [fldCodeingBudjeId], [fldhierarchyidId], [fldLevelId], [fldStrhid], [fldHeaderId], c.[fldTitle], c.[fldCode], [fldOldId], [fldTarh_KhedmatTypeId], [fldEtebarTypeId], [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], [fldBudCode] 
	,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,fldCodeingLevelId
	,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
	,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
	FROM   [BUD].[tblCodingBudje_Details] c
	inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
	left join bud.tblCodingLevel  l on l.fldid=fldCodeingLevelId
	left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
	left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
	outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
	outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
	outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2
	where h.fldYear=@value  and h.fldOrganId=@value2 and fldEtebarTypeId=2 order by fldBudCode
	

	if (@fieldname='Sarmayeii')
	SELECT top(@h)  [fldCodeingBudjeId], [fldhierarchyidId], [fldLevelId], [fldStrhid], [fldHeaderId], c.[fldTitle], c.[fldCode], [fldOldId], [fldTarh_KhedmatTypeId], [fldEtebarTypeId], [fldMasrafTypeId], c.[fldDate], c.[fldIp], c.[fldUserId], [fldBudCode] 
	,h.fldYear,isnull(m.fldTitle,'')fldMasrafTTitle,isnull(e.fldTitle,'')fldEtebarType,isnull(l.fldName,'') fldNameLevel,fldCodeingLevelId
	,isnull(pcod.t,'') as fldPcode,isnull(p1.fldCodeBarname,N'')fldCodeBarname,isnull(p1.fldTitleBarname,N'')fldTitleBarname
	,isnull(p2.fldCodeMamooriyat,N'') fldCodeMamooriyat,isnull(p2.fldTitleMamooriyat,N'')fldTitleMamooriyat
	FROM   [BUD].[tblCodingBudje_Details] c
	inner join bud.tblCodingBudje_Header h on h.fldHedaerId=c.fldHeaderId
	left join bud.tblCodingLevel  l on l.fldid=fldCodeingLevelId
	left join bud.tblEtebarType e on e.fldId=c.fldEtebarTypeId
	left join bud.tblMasrafType m on m.fldId=c.fldMasrafTypeId
	outer apply (select t from bud.fn_AllFatherOneNode (c.[fldCodeingBudjeId],c.fldHeaderId) f where id=c.[fldCodeingBudjeId] )pcod
	outer apply(select p1.fldCode as fldCodeBarname,p1.fldTitle as fldTitleBarname from [BUD].[tblCodingBudje_Details] as p1 where p1.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=p1.fldhierarchyidId)p1
	outer apply(select p2.fldCode as fldCodeMamooriyat,p2.fldTitle as fldTitleMamooriyat from [BUD].[tblCodingBudje_Details] as p2 where p2.fldHeaderId=c.fldHeaderId and c.fldhierarchyidId.GetAncestor(2)=p2.fldhierarchyidId)p2
	where h.fldYear=@value  and h.fldOrganId=@value2 and fldEtebarTypeId=3 order by fldBudCode
	COMMIT
GO
