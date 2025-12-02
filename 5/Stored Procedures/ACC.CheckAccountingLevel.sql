SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [ACC].[CheckAccountingLevel]
 @AccountingTypeId int,@OrganPostId int,@Year smallint
 as
 declare @temp table(fldName nvarchar(200),fldArghumNum int)
 declare @Count int=0
 declare @tblTemplateName table(fldId int, fldName nvarchar(200))

insert @temp
select fldName,fldArghumNum from acc.tblLevelsAccountingType where fldAccountTypeId=@AccountingTypeId
except
select fldName,fldArghamNum from acc.tblAccountingLevel where fldYear=@Year and fldOrganId=@OrganPostId

insert @temp
select fldName,fldArghamNum from acc.tblAccountingLevel where fldYear=@Year and fldOrganId=@OrganPostId
except
select fldName,fldArghumNum from acc.tblLevelsAccountingType where fldAccountTypeId=@AccountingTypeId

select @Count=COUNT(*) from @temp

if(@Count=0)
begin
	insert @tblTemplateName
	SELECT        fldId, fldName
	FROM            ACC.tblTemplateName
	where fldAccountingTypeId=@AccountingTypeId
end
select * from @tblTemplateName

GO
