SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_UpdateCoding]
as
--آپدی جدول الگوی کدینگ

UPDATE t SET t.fldName=t2.fldName,fldCodeBudget=t2.fldCodeBudget
 FROM acc.tblTemplateCoding AS t
INNER JOIN RasaNewFMSRasa.acc.tblTemplateCoding AS t2 ON t2.fldCode=t.fldCode
WHERE t.fldTempNameId=1 AND t2.fldTempNameId=1 AND t.fldName<>t2.fldName/*ممکن کدها فرق داشته باشه*/

DECLARE @fldID1 int
select @fldID1 =ISNULL(max(fldId),0) from [ACC].[tblTemplateCoding] 
	INSERT INTO [ACC].[tblTemplateCoding] ([fldId], fldTempCodeId, [fldItemId], [fldName],  [fldPCod], [fldMahiyatId], [fldCode]
	, [fldTempNameId], [fldLevelsAccountTypId], [fldDesc], [fldDate], [fldIp], [fldUserId],fldTypeHesabId,fldCodeBudget,fldAddChildNode)

SELECT 
@fldID1+ROW_NUMBER() OVER (ORDER BY t2.fldId),t2.fldTempCodeId,t2.fldItemId,t2.fldName,t2.fldPCod,t2.fldMahiyatId,t2.fldCode
,t2.fldTempNameId,t2.fldLevelsAccountTypId,t2.fldDesc,GETDATE(),t2.fldIp,t2.fldUserId,t2.fldTypeHesabId,t2.fldCodeBudget,t2.fldAddChildNode
 FROM acc.tblTemplateCoding AS t
right JOIN RasaNewFMSRasa.acc.tblTemplateCoding AS t2 ON t2.fldCode=t.fldCode
WHERE t2.fldTempNameId=1 AND t.fldId IS NULL

--اپدیت و اینزرت جدول کدینگ
update c set fldTitle=t.fldName,fldDaramadCode=t.fldCodeBudget from acc.tblCoding_Details as c
inner join ACC.tblTemplateCoding AS t on c.fldTempCodingId=t.fldid

--CREATE UNIQUE NONCLUSTERED INDEX UI_UI ON [ACC].tblCoding_Details(fldHeaderCodId,fldDaramadCode) WHERE fldDaramadCode IS NOT NULL;

declare @fldID int 
select @fldID =ISNULL(max(fldId),0) from [ACC].[tblCoding_Details] 
	INSERT INTO [ACC].[tblCoding_Details] ([fldId], fldCodeId, [fldPCod], [fldTempCodingId], [fldTitle], [fldCode],[fldAccountLevelId], [fldDesc], [fldDate], [fldIp], [fldUserId],[fldMahiyatId],[fldHeaderCodId],fldTypeHesabId,fldDaramadCode)
				

select ROW_NUMBER() over (order by t.fldid)+@fldID,t.fldTempCodeId,t.fldPCod,t.fldId,t.fldName,t.fldCode,a.fldId,'',GETDATE(),t.fldIp,t.fldUserId,t.fldMahiyatId,h.headrid,t.fldTypeHesabId,t.fldCodeBudget

from ACC.tblTemplateCoding AS t
left join  acc.tblCoding_Details as c on c.fldTempCodingId=t.fldid
cross apply (select ROW_NUMBER() over (order by fldid) as levelid,* from acc.tblAccountingLevel as a
where fldYear=1402 and fldOrganId=1) a
cross apply(select h.fldId as headrid  from acc.tblCoding_Header as h
where fldYear=1402 and fldOrganId=1)h
where  a.levelid=t.fldLevelId and c.fldId is null 
and not exists (select * from  acc.tblCoding_Details as c2 where c2.fldCode=t.fldCode and c2.fldHeaderCodId=h.headrid)
and t.fldTempNameId=1 --AND t.fldId NOT IN (1681,1685)
order by t.fldid

--select t.fldid,t.fldPCod,t.fldCode,t.fldStrhid,t.fldName,t2.*,child.ToString() AS child from ACC.tblTemplateCoding AS t
--left join  acc.tblCoding_Details as c on c.fldTempCodingId=t.fldid and c.fldHeaderCodId=4
--outer apply(select t2.fldId,t2.fldStrhid as str,c2.fldId as idcode,c2.fldStrhid,t2.fldName,c2.fldTitle,c2.fldCodeId,c2.fldCode from ACC.tblTemplateCoding AS t2
--			left join  acc.tblCoding_Details as c2 on c2.fldTempCodingId=t2.fldid  and c2.fldHeaderCodId=4
--			 where  t2.fldTempNameId=1 and t.fldTempCodeId.GetAncestor(1)=t2.fldTempCodeId and t2.fldTempNameId=1)t2
--outer apply(SELECT  t2.fldCodeId.GetDescendant(MAX(fldCodeId),NULL) child FROM [ACC].[tblCoding_Details] as c3 WHERE fldCodeId.GetAncestor(1)=t2.fldCodeId and c3.fldHeaderCodId=4 )c3
--where t.fldTempNameId=1 and c.fldId is NULL AND t.fldId  IN (1681,1685)
--and not exists (select * from  acc.tblCoding_Details as c2 where c2.fldCode=t.fldCode and c2.fldHeaderCodId=2)
--order by t.fldid*/



GO
