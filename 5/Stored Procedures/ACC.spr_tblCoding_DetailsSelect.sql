SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCoding_DetailsSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 NVARCHAR(50),
	@Value3 nvarchar(max),
	@h int
AS 
	BEGIN TRAN
	declare @Year smallint=0
	declare @OrganId int=0
	SET @Value=Com.fn_TextNormalize(@Value)
	SET @Value3=Com.fn_TextNormalize(@Value3)
	if (@h=0) set @h=2147483647

	if (@fieldname=N'fldId')
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],0 fldItemIdParent,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						  left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
	WHERE  ACC.tblCoding_Details.fldId = @Value  

	if (@fieldname=N'fldItemId')
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],0 fldItemIdParent,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId inner join
						  acc.tblFiscalYear as f on f.fldYear=tblCoding_Header.fldYear and f.fldOrganId=tblCoding_Header.fldOrganId
						  left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
	WHERE  f.fldId=@Value and tblTemplateCoding.fldItemId =@Value2

	if (@fieldname=N'CodingBudje_DetailsId')
	SELECT distinct   ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],0 fldItemIdParent
						  ,case when d.fldId is not null then 0 else 1 end as LastNod
						  ,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						  left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						  inner join bud.tblPishbini as p on p.fldCodingAcc_DetailsId=tblCoding_Details.fldid
						  outer apply(select top 1 d.fldId  from acc.tblDocumentRecord_Details as d inner join acc.tblCase as c on c.fldId=d.fldCaseId
										where d.fldCodingId=tblCoding_Details.fldId and c.fldSourceId=@Value and fldCaseTypeId=15)d
	WHERE p.fldCodingBudje_DetailsId = @Value

	if (@fieldname=N'Mali')
	SELECT   TOP(@h)  tblCoding_Details.fldStrhid,ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,tblCoding_Details.[fldDaramadCode],0 fldItemIdParent,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,tblTemplateCoding.fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						  left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						  left join ACC.tblCoding_Details as p on p.fldCodeId.GetAncestor(1)=tblCoding_Details.fldCodeId and p.fldHeaderCodId=tblCoding_Details.fldHeaderCodId
	cross apply(select top 1 parent.fldItemId from ACC.tblTemplateCoding child inner join
			ACC.tblTemplateCoding parent on child.fldId=tblCoding_Details.fldTempCodingId and child.fldTempCodeId.IsDescendantOf(parent.fldTempCodeId)=1
				where parent.fldLevelId=2  and parent.fldTempNameId=child.fldtempNameId and parent.fldItemId=12
	)temp
						   
	where ACC.tblCoding_Header.fldYear=@value  and ACC.tblCoding_Header.fldOrganId=@value2 and p.fldCodeId is null
		order by fldCode

	if (@fieldname=N'Sarmayeii')
	SELECT   TOP(@h)  tblCoding_Details.fldStrhid,ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,tblCoding_Details.[fldDaramadCode],0 fldItemIdParent,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,tblTemplateCoding.fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						  left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						  left join ACC.tblCoding_Details as p on p.fldCodeId.GetAncestor(1)=tblCoding_Details.fldCodeId and p.fldHeaderCodId=tblCoding_Details.fldHeaderCodId
	cross apply( select top 1 parent.fldItemId from ACC.tblTemplateCoding child inner join
			ACC.tblTemplateCoding parent on child.fldId=tblCoding_Details.fldTempCodingId and child.fldTempCodeId.IsDescendantOf(parent.fldTempCodeId)=1
				where parent.fldLevelId=2  and parent.fldTempNameId=child.fldtempNameId and parent.fldItemId=11
	)temp
						   
	where ACC.tblCoding_Header.fldYear=@value  and ACC.tblCoding_Header.fldOrganId=@value2 and p.fldCodeId is null
		order by fldCode
	

	if (@fieldname=N'fldDesc')
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab  
						  ,[fldDaramadCode],0 fldItemIdParent ,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   
	WHERE ACC.tblCoding_Details.fldDesc like  @Value 
		order by fldCode

	if (@fieldname=N'')
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],0 fldItemIdParent ,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
			order by fldCode				   
              
    
    if (@fieldname=N'fldName_AccountingLevel')
		SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],0 fldItemIdParent ,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode

FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId 
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   
	WHERE ACC.tblAccountingLevel.fldName like  @Value  
		order by fldCode

	if (@fieldname=N'fldName_TemplateCoding')
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],0 fldItemIdParent ,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId 
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   
	WHERE ACC.tblTemplateCoding.fldName like  @Value  
		order by fldCode

	if (@fieldname=N'fldTitle')
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],0 fldItemIdParent ,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   
	WHERE ACC.tblCoding_Details.fldTitle like  @Value   
		order by fldCode
	
if (@fieldname=N'fldPID')
BEGIN 
	if (@Value3='')	
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab
						 , tblCoding_Details.[fldDaramadCode],isnull(fldItemIdParent,0)fldItemIdParent,isnull(lastNod,0) as LastNod,tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
	FROM          ACC.tblCoding_Details inner join
		ACC.tblCoding_Details as p on p.fldId=@Value and ACC.tblCoding_Details.fldHeaderCodId=@Value2 and tblCoding_Details.fldCodeId.GetAncestor(1)=p.fldCodeId   and (p.fldHeaderCodId=tblCoding_Details.fldHeaderCodId or @Value=0) left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId  left outer  JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   outer apply (select 1 lastNod
									fROM          ACC.tblCoding_Details  s left outer join
											ACC.tblCoding_Details as p on p.fldCodeId.GetAncestor(1)=s.fldCodeId and p.fldHeaderCodId=s.fldHeaderCodId
											where p.fldid is null and s.fldid= ACC.tblCoding_Details.fldId and s.fldHeaderCodId=@Value2	)lastNot
						   outer apply (  select  fldItemId as fldItemIdParent from ACC.tblCoding_Details child inner join
								ACC.tblCoding_Details parent on  child.fldCodeId.IsDescendantOf(parent.fldCodeId)=1
								left join acc.tblTemplateCoding t on t.fldid=parent.fldTempCodingId
								where child.fldid= ACC.tblCoding_Details.fldid and child.fldHeaderCodId=@Value2 
								and parent.fldHeaderCodId=@Value2 and parent.fldLevelId=1 )item
						   	order by fldCode

	else 
	SELECT distinct  TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab
						 , tblCoding_Details.[fldDaramadCode],isnull(fldItemIdParent,0)fldItemIdParent,isnull(lastNod,0) as LastNod,tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
	FROM          ACC.tblCoding_Details inner join
		ACC.tblCoding_Details as p on p.fldId=@Value and ACC.tblCoding_Details.fldHeaderCodId=@Value2 and tblCoding_Details.fldCodeId.GetAncestor(1)=p.fldCodeId and (p.fldHeaderCodId=tblCoding_Details.fldHeaderCodId or @Value=0)  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId  left outer  JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   outer apply (select 1 lastNod
									fROM          ACC.tblCoding_Details  s left outer join
											ACC.tblCoding_Details as p on p.fldCodeId.GetAncestor(1)=s.fldCodeId and p.fldHeaderCodId=s.fldHeaderCodId
											where p.fldid is null and s.fldid= ACC.tblCoding_Details.fldId and s.fldHeaderCodId=@Value2	)lastNot
						   outer apply (  select  fldItemId as fldItemIdParent from ACC.tblCoding_Details child inner join
								ACC.tblCoding_Details parent on  child.fldCodeId.IsDescendantOf(parent.fldCodeId)=1
								left join acc.tblTemplateCoding t on t.fldid=parent.fldTempCodingId
								where child.fldid= ACC.tblCoding_Details.fldid and child.fldHeaderCodId=@Value2 
								and parent.fldHeaderCodId=@Value2 and parent.fldLevelId=1 )item
								cross apply (select t.fldTitle,t.fldCode fldcod,t.fldStrhid from ACC.tblCoding_Details t	
								where t.fldHeaderCodId=@Value2 and t.fldStrhid like tblCoding_Details.fldStrhid+'%'  )child
						   
								where /*child.fldStrhid like  '%'+ACC.tblCoding_Details.fldStrhid+'%' and */
								((ACC.tblCoding_Details.fldCode+'-'+ACC.tblCoding_Details.fldTitle) like @Value3 or (child.fldcod+'-'+child.fldTitle like @value3) )
			order by fldCode
							
END 

if (@fieldname=N'Child')
BEGIN 	
	SELECT     ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,p.fldId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,ACC.tblCoding_Details.[fldDaramadCode],0 fldItemIdParent,0 as LastNod,tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
	FROM          ACC.tblCoding_Details  left outer join
		ACC.tblCoding_Details as p on p.fldCodeId.GetAncestor(1)=tblCoding_Details.fldCodeId  and p.fldHeaderCodId=tblCoding_Details.fldHeaderCodId left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId  left outer  JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   
						  where p.fldId is null and tblCoding_Header.fldYear=@Value and tblCoding_Header.fldOrganId=@Value2
						  and ACC.tblAccountingLevel.fldName not in (N'گروه',N'کل')
						  	order by fldCode
END 
if (@fieldname=N'Child_Level')
BEGIN 	
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],0 fldItemIdParent,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   
	WHERE ACC.tblCoding_Details.fldAccountLevelId like  @Value3  AND ACC.tblCoding_Header.fldOrganId LIKE @value2  
	order by ACC.tblCoding_Details.fldCode
END 
if (@fieldname=N'Child_ItemId10')
BEGIN 	
	SELECT     ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,p.fldId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,ACC.tblCoding_Details.[fldDaramadCode],0 fldItemIdParent,0 as LastNod,tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
	FROM          ACC.tblCoding_Details  left outer join
		ACC.tblCoding_Details as p on p.fldCodeId.GetAncestor(1)=tblCoding_Details.fldCodeId  and p.fldHeaderCodId=tblCoding_Details.fldHeaderCodId left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId  left outer  JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   cross apply    (select top 1 fldTempNameId from     
											 acc.tblCoding_Details as p2  
											inner join acc.tblTemplateCoding as t on t.fldId=p2.fldTempCodingId 
											where p2.fldHeaderCodId=tblCoding_Details.fldHeaderCodId and t.fldItemId=10 and tblCoding_Details.fldCodeId.IsDescendantOf(p2.fldCodeId) =1   )tempname 
						  where p.fldId is null and tblCoding_Header.fldYear=@Value and tblCoding_Header.fldOrganId=@Value2
						  	order by fldCode
END 
if (@fieldname=N'Child_ItemId1112')
BEGIN 	
	SELECT     ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,p.fldId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,ACC.tblCoding_Details.[fldDaramadCode],0 fldItemIdParent,0 as LastNod,tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
	FROM          ACC.tblCoding_Details  left outer join
		ACC.tblCoding_Details as p on p.fldCodeId.GetAncestor(1)=tblCoding_Details.fldCodeId  and p.fldHeaderCodId=tblCoding_Details.fldHeaderCodId left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId  left outer  JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   cross apply    (select top 1 fldTempNameId from     
											 acc.tblCoding_Details as p2  
											inner join acc.tblTemplateCoding as t on t.fldId=p2.fldTempCodingId 
											where p2.fldHeaderCodId=tblCoding_Details.fldHeaderCodId and t.fldItemId IN(11,12) and tblCoding_Details.fldCodeId.IsDescendantOf(p2.fldCodeId) =1   )tempname 
						  where p.fldId is null and tblCoding_Header.fldYear=@Value and tblCoding_Header.fldOrganId=@Value2
						  	order by fldCode
END 
		if (@fieldname=N'fldCode')
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],isnull(fldItemIdParent,0) fldItemIdParent,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
 outer apply (  select  fldItemId as fldItemIdParent from ACC.tblCoding_Details child inner join
								ACC.tblCoding_Details parent on  child.fldCodeId.IsDescendantOf(parent.fldCodeId)=1
								left join acc.tblTemplateCoding t on t.fldid=parent.fldTempCodingId
								where child.fldid= ACC.tblCoding_Details.fldid and child.fldHeaderCodId=@Value2 
								and parent.fldHeaderCodId=@Value2 and parent.fldLevelId=1 )item
						   
	WHERE ACC.tblCoding_Details.fldCode like  @Value  AND ACC.tblCoding_Details.fldHeaderCodId LIKE @value2  
		order by fldCode
	
		if (@fieldname=N'fldYear')
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],0 fldItemIdParent,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId 
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   
	WHERE ACC.tblCoding_Header.fldYear like @Value
		order by fldCode

		if (@fieldname=N'fldYear_Pay')
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle + '('+fldDaramadCode+')' as fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],0 fldItemIdParent,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId 
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   cross apply    (select top 1 fldTempNameId from          acc.tblCoding_Details as parent       
							 inner join acc.tblTemplateCoding as t on t.fldId=parent.fldTempCodingId     
							 where parent.fldHeaderCodId=tblCoding_Details.fldHeaderCodId and t.fldItemId=10 	and tblCoding_Details.fldCodeId.IsDescendantOf(parent.fldCodeId) =1   )tempname1
	WHERE ACC.tblCoding_Header.fldYear like @Value and fldDaramadCode is not null
		order by fldCode

	if (@fieldname=N'fldHeaderCodId')
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],0 fldItemIdParent,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   
						  	WHERE  ACC.tblCoding_Details.fldHeaderCodId = @Value 
  	order by fldCode
  if (@fieldname=N'fldTempCodingId')
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],0 fldItemIdParent,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   
	WHERE  ACC.tblCoding_Details.fldTempCodingId = @Value 
  	order by fldCode
    if (@fieldname=N'fldAccountLevelId')
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],0 fldItemIdParent,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   
	WHERE  ACC.tblCoding_Details.fldAccountLevelId = @Value 
		order by fldCode

		 if (@fieldname=N'fldAccountLevelId_PID')
		 begin
			select @Value3=c.fldStrhid from acc.tblCoding_Details as c
			where c.fldId=@Value2 
		

			SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
								  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
								  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
								 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
								  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
								  ,tblCoding_Details.[fldDaramadCode],0 fldItemIdParent,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
			FROM         ACC.tblCoding_Details  left outer JOIN
								  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
								  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
								  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
								  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
	cross apply(select top 1 parent.fldStrhid from acc.tblCoding_Details as parent where tblCoding_Details.fldCodeId.IsDescendantOf(parent.fldCodeId)=1 and tblCoding_Details.fldHeaderCodId=parent.fldHeaderCodId order by parent.fldId)parent
					 			left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   
			WHERE  ACC.tblCoding_Details.fldAccountLevelId = @Value and tblCoding_Details.fldStrhid>=@Value3
			order by fldCode
		end
	    if (@fieldname=N'fldTypeHesabId')
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],0 fldItemIdParent,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						   
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
	WHERE  ACC.tblCoding_Details.fldTypeHesabId = @Value 
		order by fldCode

		    if (@fieldname=N'fldNameTypeHesab')
	SELECT   TOP(@h)  ACC.tblCoding_Details.fldId, ACC.tblCoding_Details.fldPCod,ISNULL(ACC.tblCoding_Details.fldTempCodingId,0)fldTempCodingId, ACC.tblCoding_Details.fldTitle, 
						  ACC.tblCoding_Details.fldCode, ACC.tblCoding_Details.fldAccountLevelId, ACC.tblCoding_Details.fldDesc, ACC.tblCoding_Details.fldDate, ACC.tblCoding_Details.fldIp, 
						  ACC.tblCoding_Details.fldUserId, ACC.tblCoding_Details.fldMahiyatId, ACC.tblCoding_Details.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,tblCoding_Details.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,[fldDaramadCode],0 fldItemIdParent,0 as LastNod,ACC.tblCoding_Details.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
FROM         ACC.tblCoding_Details  left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
						  ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
						  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId
						   left join Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   
	WHERE  t.fldName like @Value 
      	order by fldCode
	
if (@fieldname=N'FirstParent')
	SELECT   TOP(@h) parent.fldId, parent.fldPCod,ISNULL(parent.fldTempCodingId,0)fldTempCodingId,parent.fldTitle, 
						 parent.fldCode, parent.fldAccountLevelId, parent.fldDesc, parent.fldDate,parent.fldIp, 
						  parent.fldUserId, parent.fldMahiyatId,parent.fldHeaderCodId,ISNULL(ACC.tblTemplateCoding.fldName,'')  AS fldName_TemplateCoding
						 ,isnull(ACC.tblTemplateCoding.fldTempNameId,0)fldTempNameId, ACC.tblAccountingLevel.fldName AS  fldName_AccountingLevel,ISNULL(ACC.tblTemplateName.fldAccountingTypeId,0)fldAccountingTypeId, ACC.tblCoding_Header.fldYear, 
						  ACC.tblCoding_Header.fldOrganId,parent.fldTypeHesabId,t.fldName as fldNameTypeHesab 
						  ,parent.[fldDaramadCode],0 fldItemIdParent,0 as LastNod,parent.fldMahiyat_GardeshId,fldItemId,isnull(fldAddChildNode,cast(1 as bit)) as  fldAddChildNode
 from ACC.tblCoding_Details  child inner join
								 ACC.tblCoding_Details  parent on  child.fldCodeId.IsDescendantOf(parent.fldCodeId)=1
								left outer JOIN
								  ACC.tblTemplateCoding ON child.fldTempCodingId = ACC.tblTemplateCoding.fldId INNER JOIN
								  ACC.tblAccountingLevel ON child.fldAccountLevelId = ACC.tblAccountingLevel.fldId left outer JOIN
								  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId INNER JOIN
								  ACC.tblCoding_Header ON child.fldHeaderCodId = ACC.tblCoding_Header.fldId
								    left join Acc.tblTypeHesab t on t.fldid=parent.fldTypeHesabId
						  
								where child.fldid= @value and parent.fldHeaderCodId=@Value2 and child.fldHeaderCodId=@Value2 and parent.fldLevelId=1 
									order by fldCode


              
	  
	  
	           
	COMMIT
GO
