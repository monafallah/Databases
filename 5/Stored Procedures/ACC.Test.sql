SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE  proc [ACC].[Test] 
@Value nvarchar(50),
	@Value2 NVARCHAR(50)
	,@h int
as
	if (@h=0) set @h=2147483647
declare @temp table (id int)
insert into @temp
select fldid from acc.tblAccountingLevel
where fldName  in (N'گروه',N'کل') and fldYear=@Value
--select * from @temp
SELECT  ACC.tblCoding_Details.*,ACC.tblAccountingLevel.fldName
	FROM          ACC.tblCoding_Details  left outer join
		ACC.tblCoding_Details as p on p.fldCodeId.GetAncestor(1)=tblCoding_Details.fldCodeId  left outer JOIN
		  ACC.tblCoding_Header ON ACC.tblCoding_Details.fldHeaderCodId = ACC.tblCoding_Header.fldId 
		    left outer JOIN
						  ACC.tblTemplateCoding ON ACC.tblCoding_Details.fldTempCodingId = ACC.tblTemplateCoding.fldId left JOIN
						 ACC.tblAccountingLevel ON ACC.tblCoding_Details.fldAccountLevelId = ACC.tblAccountingLevel.fldId  left outer  JOIN
						  ACC.tblTemplateName ON  tblTemplateName.fldId = tblTemplateCoding.fldTempNameId left JOIN
						
						   Acc.tblTypeHesab t on t.fldid=tblCoding_Details.fldTypeHesabId
						   
						  where p.fldId is null and tblCoding_Header.fldOrganId=@Value2 and tblCoding_Header.fldYear=@Value  
						 and not exists (select * from @temp where id=tblCoding_Details.fldAccountLevelId)

						 
GO
