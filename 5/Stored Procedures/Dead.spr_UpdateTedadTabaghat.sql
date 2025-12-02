SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Dead].[spr_UpdateTedadTabaghat]
@fldShomare nvarchar(800),
@fldIdGhete int,
@NameGhate nvarchar(200),
@Desc nvarchar(300),
@UserId int,
@organid int
as
begin tran
set @NameGhate=com.fn_TextNormalize(@NameGhate)
	set @Desc=com.fn_TextNormalize(@Desc)
--declare @shomare nvarchar(800)='15;2|14;3|16;3'
update dead.tblghete
set fldNameGhete=@NameGhate,fldDesc=@Desc,fldDate=getdate(),fldUserId=@UserId
where fldid=@fldIdGhete
if (@@error<>0)
rollback

else 
begin
	--;with aval as
	--(
	--	select * from com.Split_id(@fldShomare,'|')
	--)
	--,dovom as
	--(
	--	select ROW_NUMBER()over (partition by i order by i)rowid,* from
	--	 (select aval.item i,  d.item from aval
	--	cross apply (select item from com.Split(aval.item,';') )d)t
	
	--)update S 
	--set fldTedadTabaghat=ta.item
	--from dovom d1 inner join dead.tblShomare s
	--on fldid=item and rowid=1
	--cross apply (select * from dovom d where d.i=d1.i and   rowid=2)ta
	--where not exists(select * from dead.tblGhabreAmanat where fldShomareId=s.fldid)
	declare @statusid int
	select @statusid=isnull(max(fldid),0) from dead.tblstatusGhabr

	update shomare
	set fldTedadTabaghat=tabaghe
	from dead.tblshomare  shomare
	cross apply(select * from 
					(select substring(item,1,CHARINDEX(';', item)-1) id
						,substring(item,CHARINDEX(';', item)+1,len(item)) tabaghe 
						 from com.Split(@fldShomare,'|'))t
							where id=shomare.fldid) ta
	where  not exists(select * from dead.tblGhabreAmanat inner join dead.tblMotevaffa
	on fldGhabreAmanatId=tblGhabreAmanat.fldid where fldShomareId=shomare.fldid)
	
	if (@@error<>0)
			rollback
	/*else
	begin
			delete tblstatusGhabr 
			from  dead.tblstatusGhabr 
			cross apply(select * from (select substring(item,1,CHARINDEX(';', item)-1) id
						,substring(item,CHARINDEX(';', item)+1,len(item)) tabaghe
						from com.Split(@fldShomare,'|'))t
						where id=tblstatusGhabr.fldshomareid) ta
						where not exists(select * from dead.tblGhabreAmanat inner join dead.tblMotevaffa
						on fldGhabreAmanatId=tblGhabreAmanat.fldid where fldShomareId=tblstatusGhabr.fldshomareid)
			if (@@error<>0)
				rollback

			else 
			begin
				;with cte as 
				(		select row_number()over(partition by id  order by (select 1))rowId,id,tabaghe from (select substring(item,1,CHARINDEX(';', item)-1) id
									,substring(item,CHARINDEX(';', item)+1,len(item)) tabaghe
									from com.Split(@fldShomare,'|'))t

					union all
						select rowid+1,id,tabaghe from  cte
						where cte.rowid<tabaghe

				)insert into dead.tblstatusGhabr
					select ROW_NUMBER()over (order by id)+@statusid,id,null,@UserId,getdate(),@organid
					from cte
					where  not exists(select * from dead.tblGhabreAmanat inner join dead.tblMotevaffa
					on fldGhabreAmanatId=tblGhabreAmanat.fldid where fldShomareId=id)
					order by id,rowId
					if(@@Error<>0)
						rollback 

			end

	end*/

end

commit

GO
