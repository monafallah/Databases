SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblPishbiniInsert] 
    
	@fldCodingAcc_DetailsId int,
    @fldCodingBudje_DetailsId int = NULL,
    @Pishbini Bud.Pishbini readonly,
    @fldUserId int
AS 
	 
--begin try	
	BEGIN TRAN
	merge [BUD].[tblPishbini] as t
using (select @fldCodingAcc_DetailsId, @fldCodingBudje_DetailsId,Mablagh ,BudgetTypeId,MotammamId from @Pishbini ) as s(CodingAcc_DetailsId, CodingBudje_DetailsId,Mablagh,BudgetTypeId,MotammamId)
on(t.fldCodingAcc_DetailsId=s.CodingAcc_DetailsId and (( s.CodingBudje_DetailsId is null and  t.fldCodingBudje_DetailsId is null) or t.fldCodingBudje_DetailsId=s.CodingBudje_DetailsId) and t.fldBudgetTypeId=s.BudgetTypeId) and ((s.MotammamId is null  and t.fldMotammamId is null)or t.fldMotammamId=s.MotammamId)
WHEN MATCHED
        THEN
            UPDATE
            SET fldMablagh = s.Mablagh,fldUserId=@fldUserId,fldDate=getdate()
WHEN NOT MATCHED and Mablagh<>0
        THEN
INSERT   ([fldCodingAcc_DetailsId], [fldCodingBudje_DetailsId], [fldMablagh], [fldBudgetTypeId], [fldDate], [fldUserId],fldMotammamId)
	values (CodingAcc_DetailsId, CodingBudje_DetailsId, Mablagh, BudgetTypeId, getdate(), @fldUserId,MotammamId);
	commit tran

/*declare @fldid int,@mablaghold bigint,@HeaderId int,@errorid int,@mid int
 

if (@fldMotammamId=0)
set @mid=null
else
set @mid=@fldMotammamId
/*فقط آخرین نود ها از ورودی ارسال میشود*/
if not exists (select * from bud.tblPishbini where (fldCodingAcc_DetailsId =@fldCodingAcc_DetailsId or fldCodingBudje_DetailsId=@fldCodingBudje_DetailsId ) and fldBudgetTypeId=@fldBudgetTypeId and isnull(fldMotammamId,0)=@fldMotammamId )
begin
	--select @fldid=isnull(max(fldpishbiniId),0)+1  FROM   [BUD].[tblPishbini] 
	INSERT INTO [BUD].[tblPishbini] ([fldCodingAcc_DetailsId], [fldCodingBudje_DetailsId], [fldMablagh], [fldBudgetTypeId], [fldDate], [fldUserId],fldMotammamId)
	SELECT @fldCodingAcc_DetailsId, @fldCodingBudje_DetailsId, @fldMablagh, @fldBudgetTypeId, getdate(), @fldUserId,@mid
	
end	

-----اینزرت همه ی پدرای نود ورودی	
declare @temp table (Id int)
if (@fldCodingBudje_DetailsId is not null)/*بودجه*/
begin
	select  @HeaderId= fldHeaderId from bud.[tblCodingBudje_Details] 
	where fldCodeingBudjeId=@fldCodingBudje_DetailsId



	;with budje as 
	( 
		select fldCodeingBudjeId,fldhierarchyidId,1 c from bud.[tblCodingBudje_Details] 
		where fldCodeingBudjeId=@fldCodingBudje_DetailsId
		union all
		select e.fldCodeingBudjeId,e.fldhierarchyidId,2 c
		from bud.[tblCodingBudje_Details] e join budje on budje.fldhierarchyidId.GetAncestor(1)=e.fldhierarchyidId
		where fldHeaderId =@HeaderId
	)

	insert @temp (id)
	select fldCodeingBudjeId from budje
	where  fldCodeingBudjeId<>@fldCodingBudje_DetailsId

---اگه داده در پیش بینی بود مبلغ قبلی از مبلغ پدر ها کم میشود
if exists (select * from bud.tblPishbini where  fldCodingBudje_DetailsId=@fldCodingBudje_DetailsId  and fldBudgetTypeId=@fldBudgetTypeId and isnull(fldMotammamId,0)=@fldMotammamId )
begin
	select @mablaghold=fldMablagh from bud.tblPishbini where  fldCodingBudje_DetailsId=@fldCodingBudje_DetailsId  and fldBudgetTypeId=@fldBudgetTypeId and  isnull(fldMotammamId,0)=@fldMotammamId
	
	update p
	set fldMablagh=fldMablagh-@mablaghold
	from  bud.tblPishbini p
	inner join @temp b on b.id=p.fldCodingBudje_DetailsId
	where fldBudgetTypeId=@fldBudgetTypeId and isnull(fldMotammamId,0)=@fldMotammamId 

	update bud.tblPishbini
	set fldMablagh=@fldMablagh ,flddate=getdate(),fldUserId=@fldUserId
	where  fldCodingBudje_DetailsId=@fldCodingBudje_DetailsId  and fldBudgetTypeId=@fldBudgetTypeId  and isnull(fldMotammamId,0)=@fldMotammamId 

end
-------------
	update p
	set fldMablagh=fldMablagh+@fldMablagh ,flddate=getdate(),fldUserId=@fldUserId
	from  bud.tblPishbini p
	inner join @temp b on b.id=p.fldCodingBudje_DetailsId
	where fldBudgetTypeId=@fldBudgetTypeId and isnull(fldMotammamId,0)=@fldMotammamId 


	insert into bud.tblPishbini([fldCodingAcc_DetailsId], [fldCodingBudje_DetailsId], [fldMablagh], [fldBudgetTypeId], [fldDate], [fldUserId],fldMotammamId)
	select NULL,t.id,@fldMablagh,@fldBudgetTypeId,getdate(),@fldUserId,@mid from @temp t 
	left join bud.tblPishbini p on p.fldCodingBudje_DetailsId=t.id and p.fldBudgetTypeId=@fldBudgetTypeId and isnull(fldMotammamId,0)=@fldMotammamId 
	where p.fldpishbiniId is null

	delete from @temp
end			
  
 if (@fldCodingAcc_DetailsId is not null)/*حسابداری*/
begin
select @HeaderId= fldHeaderCodId from acc.tblCoding_Details
where fldid=@fldCodingAcc_DetailsId

	;with budje as 
	( 
		select fldid as fldCodeAcc,fldCodeId,1 c from acc.tblCoding_Details
		where fldid=@fldCodingAcc_DetailsId
		union all
		select e.fldid,e.fldCodeId,2 c
		from acc.tblCoding_Details e join budje on budje.fldCodeId.GetAncestor(1)=e.fldCodeId
		where e.fldHeaderCodId=@HeaderId
	)
	insert @temp (id)
	select fldCodeAcc from budje
	where  fldCodeAcc<>@fldCodingAcc_DetailsId

---
if exists (select * from bud.tblPishbini where  fldCodingAcc_DetailsId=@fldCodingAcc_DetailsId  and fldBudgetTypeId=@fldBudgetTypeId and isnull(fldMotammamId,0)=@fldMotammamId )
begin
	select @mablaghold=fldMablagh from bud.tblPishbini where fldCodingAcc_DetailsId=@fldCodingAcc_DetailsId   and fldBudgetTypeId=@fldBudgetTypeId and isnull(fldMotammamId,0)=@fldMotammamId 
	
	update p
	set fldMablagh=fldMablagh-@mablaghold
	from  bud.tblPishbini p
	inner join @temp b on b.id=p.fldCodingAcc_DetailsId
	where fldBudgetTypeId=@fldBudgetTypeId and  isnull(fldMotammamId,0)=@fldMotammamId 


	update bud.tblPishbini
	set fldMablagh=@fldMablagh,flddate=getdate(),fldUserId=@fldUserId
	where fldCodingAcc_DetailsId=@fldCodingAcc_DetailsId   and fldBudgetTypeId=@fldBudgetTypeId and  isnull(fldMotammamId,0)=@fldMotammamId 

end
----

	update p
	set fldMablagh=fldMablagh+@fldMablagh ,flddate=getdate(),fldUserId=@fldUserId
	from  bud.tblPishbini p
	inner join @temp b on b.id=p.fldCodingAcc_DetailsId
	where fldBudgetTypeId=@fldBudgetTypeId and  isnull(fldMotammamId,0)=@fldMotammamId 

	insert into bud.tblPishbini([fldCodingAcc_DetailsId], [fldCodingBudje_DetailsId], [fldMablagh], [fldBudgetTypeId], [fldDate], [fldUserId],fldMotammamId)
	select t.id,NULL,@fldMablagh,@fldBudgetTypeId,getdate(),@fldUserId,@mid from @temp t 
	left join bud.tblPishbini p on p.fldCodingAcc_DetailsId=t.id and p.fldBudgetTypeId=@fldBudgetTypeId and  isnull(p.fldMotammamId,0)=@fldMotammamId 
	where p.fldpishbiniId is null

	delete from @temp

end	 

    select 0 as   fldErrorCode,''   fldErrorMsg      
COMMIT

end try
begin catch 
	rollback

	select @errorid= max(fldid)+1 from com.tblError
	insert into com.tblError(fldid,fldMatn,fldTarikh,fldUserId,fldUserName,fldIP,fldDesc,fldDate)
	select @errorid,ERROR_MESSAGE() ,(select fldTarikh from com.tblDateDim where fldDate=cast(getdate() as date)),@fldUserId,
	(select fldUserName  from com.tblUser where fldid=@fldUserId),'','',GETDATE()
	select @errorid as fldErrorCode ,N'خطایی با شماره '+cast(@errorid as varchar(10)) +N' رخ داده است.'as fldErrorMsg

end catch*/
GO
