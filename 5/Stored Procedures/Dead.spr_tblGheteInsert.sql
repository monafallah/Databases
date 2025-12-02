SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblGheteInsert] 
   
    @fldVadiSalamId int,
    @fldNameGhete nvarchar(200),
	@fldOrganid int,
    @fldUserId int,
    @fldIP nchar(10),
    @fldDesc nvarchar(100),
	@fldRadif int,
	@fldShomare int,
	@fldTabaghe varchar(max)
AS 

	
	BEGIN TRAN
	--declare @fldVadiSalamId int=1,
 --   @fldNameGhete nvarchar(200)=N'قطعه2',
	--@fldOrganid int=1,
 --   @fldUserId int=1,
 --   @fldIP nchar(10)=1,
 --   @fldDesc nvarchar(100)='',
	--@fldRadif int=10,
	--@fldShomare int=5,
	--@fldTabaghe varchar(500)='3,2,2,3,3,3,1,3,3,1,3,3,3,3,3,3,3,3,2,3,3,1,1,3,1,3,3,3,3,3,3,3,2,3,3,3,3,3,3,3,1,3,3,1,3,3,3,3,3,3,'
	set @fldNameGhete=com.fn_TextNormalize(@fldNameGhete)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int
	select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblGhete] 
	INSERT INTO [Dead].[tblGhete] ([fldId], [fldVadiSalamId], [fldNameGhete], [fldUserId], [fldIP], [fldDesc], [fldDate],fldOrganId)
	SELECT @fldId, @fldVadiSalamId, @fldNameGhete, @fldUserId, @fldIP, @fldDesc, getdate(),@fldOrganId
	if(@@Error<>0)
        rollback 

	/*INSERT INTO [Dead].[tblGhete] ([fldId], [fldVadiSalamId], [fldNameGhete], [fldUserId], [fldIP], [fldDesc], [fldDate],fldOrganId)
	SELECT @fldId, @fldVadiSalamId, @fldNameGhete, @fldUserId, @fldIP, @fldDesc, getdate(),@fldOrganId
	if(@@Error<>0)
        rollback 
	else
	begin
		declare @RadifId int,@ShId int , @statusId int
		select @ShId =ISNULL(max(fldId),0) from [Dead].[tblShomare] 
		select @RadifId =ISNULL(max(fldId),0) from [Dead].[tblRadif] 
		select @statusId=isnull(max(fldid),0) from dead.tblstatusGhabr
		;with radif as(
			select ROW_NUMBER() over (order by (select 1))as r,N'ردیف' as radifName
			union all
			select r+1,N'ردیف' as radif
			from radif as r 
			where r<@fldRadif
		)
		INSERT INTO [Dead].[tblRadif] ([fldId], [fldGheteId], [fldNameRadif], [fldUserId], [fldIP], [fldDesc], [fldDate],fldOrganId)
		select @RadifId+r, @fldID, radifName+' ' +cast (r as varchar(10)), @fldUserId, @fldIP, @fldDesc, getdate(),@fldOrganId
		  from radif
		if(@@Error<>0)
			rollback 
		else
		begin
				;with shomare as (
						select ROW_NUMBER() over (order by (select 1))as r_sh,N'شماره' as ShName
						union all
						select r_sh+1,N'شماره' as sh
						from shomare as a 
						where r_sh<@fldShomare
					)
				,tabaghe as (
				select ROW_NUMBER() over (order by (select 1))as rowT,s.Item as CountTabaghe from com.Split(@fldTabaghe,N',') as s
				)
				, sh_r as(
				select * from(
				select r_sh,ShName,r.fldId as RadifId,ROW_NUMBER() over (order by (r.fldId))as r2 from shomare
				cross join Dead.tblRadif as r
				where fldGheteId=@fldID
				)t
				inner join tabaghe as t2 on t.r2=t2.rowT
				)
				INSERT INTO [Dead].[tblShomare] ([fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], [fldUserId], [fldIp], [fldDesc], [fldDate],fldOrganId)
				  select r2+@ShId,RadifId,ShName+' '+cast (r_Sh as varchar(10)) as shName,CountTabaghe , @fldUserId, @fldIP, @fldDesc, getdate(),@fldOrganId 
				  from sh_r
				  order by RadifId,r_sh

				  if (@@Error<>0)
					rollback
				else
				begin	
				
				;with cte as
				(
					select ROW_NUMBER() over (partition by fldid order by (select 1)) rowId,fldid,fldTedadTabaghat from dead.tblshomare
					union all
					select  rowId+1,fldid,fldTedadTabaghat from cte
					where cte.rowId<fldTedadTabaghat --and cte.fldid=fldid
				)
				insert into dead.tblstatusGhabr
					select ROW_NUMBER()over (order by fldid)+@statusid,fldid,null,@fldUserId,getdate(),@fldOrganid from cte
					where fldid>@ShId
					order by fldid,rowId
					if(@@Error<>0)
						rollback 
				end
				--select r+@ShId,radif,ShName+' '+cast (rowSh as varchar(10)) as shName,CountTabaghe , @fldUserId, @fldIP, @fldDesc, getdate(),@fldOrganId
				--from (
				--select ROW_NUMBER() over (order by (r.fldId))as r,r.fldId as radif,N'?????' as ShName
				--,ROW_NUMBER() over (PARTITION BY r.fldId order by (r.fldId))as rowSh
				--	from Dead.tblRadif as r  
				--	cross join Dead.tblRadif as r2
				--	where r.fldGheteId=@fldID and r2.fldGheteId=@fldID
				--	)t
				--	inner join tabaghe as t2 on t.r=t2.rowT
				  
		end
	end*/
	COMMIT
GO
