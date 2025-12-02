SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [BUD].[spr_CopyCodingDetail](@headerNew int,@ip varchar(16),@userId int)
as
begin tran
--declare @headerOld int,@headerNew int,@ip varchar(16),@userId int
declare @organid int,@Year smallint,@fldCodeingBudjeId int , @headerOld int
select @Year=fldYear-1 ,@organid=fldOrganId from bud.tblCodingBudje_Header
where fldHedaerId=@headerNew

select @headerOld=fldHedaerId from bud.tblCodingBudje_Header
where fldOrganId=@organid and fldYear=@Year

select @fldCodeingBudjeId=isnull(max(fldCodeingBudjeId),0)+1  FROM   [BUD].[tblCodingBudje_Details] 
	INSERT INTO [BUD].[tblCodingBudje_Details] ([fldCodeingBudjeId], [fldhierarchyidId], [fldHeaderId], [fldTitle], [fldCode], [fldOldId], [fldTarh_KhedmatTypeId], [fldEtebarTypeId], [fldMasrafTypeId], [fldDate], [fldIp], [fldUserId], [fldBudCode],fldCodeingLevelId)
	SELECT row_number()over (order by fldCodeingBudjeId)+@fldCodeingBudjeId,fldhierarchyidId,@headerNew,fldTitle,fldCode,fldOldId,fldTarh_KhedmatTypeId,fldEtebarTypeId,fldMasrafTypeId,getdate(),@ip,@userId,fldBudCode ,levelid.fldId
	from bud.tblCodingBudje_Details d
	inner join bud.tblCodingBudje_Header h on h.fldHedaerId=d.fldHeaderId
	cross apply (select * from (
					select l.fldid,row_number()over (order by l.fldid)Nod from bud.tblCodingLevel l inner join acc.tblFiscalYear f 
					on f.fldid=l.fldFiscalBudjeId where f.fldOrganId=h.fldOrganId and f.fldYear=h.fldYear
					)t
					where fldLevelId=Nod
			)levelid
	where fldHeaderId=@headerOld 
	if (@@ERROR<>0)
		rollback

commit
GO
