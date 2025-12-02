SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [BUD].[spr_CopytoMosavab]
@Year smallint,
@OrganId int,
@fldUserId int
as
begin tran
		update p2 set fldMablagh=p.fldMablagh,fldUserId=@fldUserId,fldDate=getdate()
			from  bud.tblPishbini p2 
			inner join acc.tblCoding_Details as c on c.fldId=p2.fldCodingAcc_DetailsId
			inner join acc.tblCoding_Header as h on h.fldId=c.fldHeaderCodId
			cross apply (select p.fldMablagh from  bud.tblPishbini p where p2.fldCodingAcc_DetailsId=p.fldCodingAcc_DetailsId 
					and ((p2.fldBudgetTypeId=6 and p.fldBudgetTypeId=1 )
							or (p2.fldBudgetTypeId=11 and p.fldBudgetTypeId=9 )
							or (p2.fldBudgetTypeId=12 and p.fldBudgetTypeId=10 ))
					and ((p.fldCodingBudje_DetailsId is null and p2.fldCodingBudje_DetailsId is null)
					or p.fldCodingBudje_DetailsId=p2.fldCodingBudje_DetailsId))p
			where h.fldYear=@Year and h.fldOrganId=@OrganId and fldBudgetTypeId in (6,11,12)

	if (@@ERROR<>0)
		ROLLBACK
	else
	begin
	
		insert into bud.tblPishbini([fldCodingAcc_DetailsId], [fldCodingBudje_DetailsId], [fldMablagh], [fldBudgetTypeId], [fldDate], [fldUserId],fldMotammamId)
	select p.fldCodingAcc_DetailsId,p.fldCodingBudje_DetailsId,p.fldMablagh,
	 case when fldBudgetTypeId=1 then 6  --مصوب
	      when fldBudgetTypeId=9 then 11 --افزایش مصوب
		  when fldBudgetTypeId=10 then 12 --کاهش مصوب	  
	  END
	,getdate(),@fldUserId,fldMotammamId
	from  bud.tblPishbini p 
	inner join acc.tblCoding_Details as c on c.fldId=p.fldCodingAcc_DetailsId
	inner join acc.tblCoding_Header as h on h.fldId=c.fldHeaderCodId
	where h.fldYear=@Year and h.fldOrganId=@OrganId and fldBudgetTypeId in (1,9,10)
	and not exists (select * from  bud.tblPishbini p2 where p2.fldCodingAcc_DetailsId=p.fldCodingAcc_DetailsId 
					and ((p2.fldBudgetTypeId=6 and p.fldBudgetTypeId=1 )
							or (p2.fldBudgetTypeId=11 and p.fldBudgetTypeId=9 )
							or (p2.fldBudgetTypeId=12 and p.fldBudgetTypeId=10 ))
					and ((p.fldCodingBudje_DetailsId is null and p2.fldCodingBudje_DetailsId is null)
					or p.fldCodingBudje_DetailsId=p2.fldCodingBudje_DetailsId))
			
	end
COMMIT tran

GO
