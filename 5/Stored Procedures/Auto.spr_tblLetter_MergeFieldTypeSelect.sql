SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetter_MergeFieldTypeSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@Value2 nvarchar(50),
@organId int,
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN

	if (@fieldname='fldLetterTamplateId')
	select  top(@h) isnull(c.fldid,0)fldId,isnull(c.fldLetterId,cast(0 as bigint))fldLetterId,isnull(fldValue,'')fldValue,f.fldid fldMergeTypeId,isnull(C.fldUserId,0)fldUserId,
	f.fldOrganId,isnull(c.fldDesc,'')fldDesc,isnull(c.fldDate,getdate())fldDate,f.fldFaName
	from Auto.tblMergeFieldTypes f
	inner join auto.tblMergeField_LetterTemplate t on f.fldid=t.fldMergeFieldId
	outer apply (select tt.fldvalue,tt.fldUserId,tt.fldDesc,tt.fldId,tt.fldDate,tt.fldLetterId from     Auto.tblLetter_MergeFieldType tt
					where ( (tt.fldLetterId=@value and fldMergeTypeId=f.fldid  and fldOrganId=@organId))
					)c
	where t.fldLetterTamplateId=@Value2 and f.fldType=1 and f.fldOrganId=@organId

	if (@fieldname='fldId')
	SELECT        top(@h)  Auto.tblLetter_MergeFieldType.fldId, Auto.tblLetter_MergeFieldType.fldLetterId,fldValue ,Auto.tblLetter_MergeFieldType.fldMergeTypeId, Auto.tblLetter_MergeFieldType.fldUserId, Auto.tblLetter_MergeFieldType.fldOrganId, 
                         Auto.tblLetter_MergeFieldType.fldDesc, Auto.tblLetter_MergeFieldType.fldDate, Auto.tblMergeFieldTypes.fldFaName
FROM            Auto.tblLetter_MergeFieldType INNER JOIN
                         Auto.tblMergeFieldTypes ON Auto.tblLetter_MergeFieldType.fldMergeTypeId = Auto.tblMergeFieldTypes.fldId
	WHERE  Auto.tblLetter_MergeFieldType.fldId=@value

	if (@fieldname='fldLetterId')
	SELECT        top(@h)  Auto.tblLetter_MergeFieldType.fldId, Auto.tblLetter_MergeFieldType.fldLetterId,fldValue , Auto.tblLetter_MergeFieldType.fldMergeTypeId, Auto.tblLetter_MergeFieldType.fldUserId, Auto.tblLetter_MergeFieldType.fldOrganId, 
                         Auto.tblLetter_MergeFieldType.fldDesc, Auto.tblLetter_MergeFieldType.fldDate, Auto.tblMergeFieldTypes.fldFaName
FROM            Auto.tblLetter_MergeFieldType INNER JOIN
                         Auto.tblMergeFieldTypes ON Auto.tblLetter_MergeFieldType.fldMergeTypeId = Auto.tblMergeFieldTypes.fldId
	WHERE  fldLetterId=@value and Auto.tblLetter_MergeFieldType.fldOrganId=@organId


	/*if (@fieldname='fldLetterTamplateId')
	select  top(@h) isnull(c.fldid,0)fldId,isnull(fldValue,'')fldValue,f.fldid fldMergeTypeId,isnull(C.fldUserId,0)fldUserId,
	isnull(c.fldDesc,'')fldDesc,isnull(c.fldDate,getdate())fldDate,f.fldFaName
	from Auto.tblMergeFieldTypes f
	inner join auto.tblMergeField_LetterTemplate t on f.fldid=t.fldMergeFieldId
	outer apply (select tt.fldvalue,tt.fldUserId,tt.fldDesc,tt.fldId,tt.fldDate from     Auto.tblLetter_MergeFieldType tt
					where ( @value=0 or (tt.fldLetterId=@value and fldMergeTypeId=f.fldid  and fldOrganId=@organId))
					)c

	where t.fldLetterTamplateId=@Value2 and f.fldType=1 and f.fldOrganId=@organId*/

	
	

	if (@fieldname='fldMergeTypeId')
	SELECT        top(@h)  Auto.tblLetter_MergeFieldType.fldId, Auto.tblLetter_MergeFieldType.fldLetterId,fldValue , Auto.tblLetter_MergeFieldType.fldMergeTypeId, Auto.tblLetter_MergeFieldType.fldUserId, Auto.tblLetter_MergeFieldType.fldOrganId, 
                         Auto.tblLetter_MergeFieldType.fldDesc, Auto.tblLetter_MergeFieldType.fldDate, Auto.tblMergeFieldTypes.fldFaName
FROM            Auto.tblLetter_MergeFieldType INNER JOIN
                         Auto.tblMergeFieldTypes ON Auto.tblLetter_MergeFieldType.fldMergeTypeId = Auto.tblMergeFieldTypes.fldId
	WHERE  fldMergeTypeId=@value  and Auto.tblLetter_MergeFieldType.fldOrganId=@organId
	
	if (@fieldname='fldOrganId')
	SELECT        top(@h)  Auto.tblLetter_MergeFieldType.fldId, Auto.tblLetter_MergeFieldType.fldLetterId,fldValue , Auto.tblLetter_MergeFieldType.fldMergeTypeId, Auto.tblLetter_MergeFieldType.fldUserId, Auto.tblLetter_MergeFieldType.fldOrganId, 
                         Auto.tblLetter_MergeFieldType.fldDesc, Auto.tblLetter_MergeFieldType.fldDate, Auto.tblMergeFieldTypes.fldFaName
FROM            Auto.tblLetter_MergeFieldType INNER JOIN
                         Auto.tblMergeFieldTypes ON Auto.tblLetter_MergeFieldType.fldMergeTypeId = Auto.tblMergeFieldTypes.fldId
	where Auto.tblLetter_MergeFieldType.fldOrganId=@OrganId

	if (@fieldname='')
	SELECT        top(@h)  Auto.tblLetter_MergeFieldType.fldId, Auto.tblLetter_MergeFieldType.fldLetterId,fldValue , Auto.tblLetter_MergeFieldType.fldMergeTypeId, Auto.tblLetter_MergeFieldType.fldUserId, Auto.tblLetter_MergeFieldType.fldOrganId, 
                         Auto.tblLetter_MergeFieldType.fldDesc, Auto.tblLetter_MergeFieldType.fldDate, Auto.tblMergeFieldTypes.fldFaName
FROM            Auto.tblLetter_MergeFieldType INNER JOIN
                         Auto.tblMergeFieldTypes ON Auto.tblLetter_MergeFieldType.fldMergeTypeId = Auto.tblMergeFieldTypes.fldId
	


	COMMIT
GO
