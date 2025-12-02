SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_IsCostCenter]
@CodingId int
as
begin tran
--declare @CodingId  int=921
declare @TempCodingId int,@ItemId int,@StrHid varchar(500)='',@tempNameId int
select @TempCodingId=fldTempCodingId from ACC.tblCoding_Details
where fldId=@CodingId
select @tempNameId=fldTempNameId from acc.tblTemplateCoding where fldid=@TempCodingId
-- اگر الگوی کدینگ نداشت
if(@TempCodingId is null)
	begin
		select 0 as Cost
		--return;
	end
else
begin
/*دومین پدرش ه*/
	--select @ItemId=fldItemId from ACC.tblTemplateCoding where fldid=@TempCodingId
	select @ItemId=parent.fldItemId from ACC.tblTemplateCoding child inner join/*New*/
	ACC.tblTemplateCoding parent on child.fldId=@TempCodingId and child.fldTempCodeId.IsDescendantOf(parent.fldTempCodeId)=1
	where parent.fldLevelId=2  and parent.fldTempNameId=@tempNameId
	
	
	-- اگر الگوی کدینگ آیتم الزامی نداشت
	if(@ItemId is null)
	begin
		select 0 as Cost
		--return;
	end
	--آن آیتم جد پدریش از نوع هزینه باشد که یک عدد ثابت  
	else
	begin
	--آن آیتم جد پدریش از نوع هزینه اقتصادی باشد که یک عدد ثابت  
		if exists(select parent.* from ACC.tblItemNecessary child inner join
		ACC.tblItemNecessary parent on child.fldId=@ItemId and child.fldItemId.IsDescendantOf(parent.fldItemId)=1
		where parent.fldId=10) or @ItemId =10
		begin
			if exists(select * from bud.tblBudje_khedmatDarsadId
			where fldCodingAcc_detailId=@CodingId)
				select 11 as Cost
			else 
				select 12 as Cost

		--return;
		end
		--آن آیتم جد پدریش از نوع هزینه تملک دارایی های مالی یا سرمایه ای باشد که یک عدد ثابت  
		else if exists(select parent.* from ACC.tblItemNecessary child inner join
		ACC.tblItemNecessary parent on child.fldId=@ItemId and child.fldItemId.IsDescendantOf(parent.fldItemId)=1
		where parent.fldId in (11,12)) or @ItemId in (11,12)
		begin
				select 2 as Cost
		--return;
		end
		else
		begin 
			select 0 as Cost
			--return;
		end
	end
end

commit 
GO
