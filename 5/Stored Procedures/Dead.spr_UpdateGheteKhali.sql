SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Dead].[spr_UpdateGheteKhali]
	@fldVadiSalamId int,
	@fldGheteId int,
    @fldNameGhete nvarchar(200),
	@fldOrganid int,
    @fldUserId int,
    @fldIP nchar(10),
    @fldDesc nvarchar(100),
	@fldRadif int,
	@fldShomare int,
	@fldTabaghe varchar(max)--='1,3,1,2,1,1,2,3,2,2,3,3,1,3,3,3'
as
	set @fldNameGhete=com.fn_TextNormalize(@fldNameGhete)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @IdHistoryRequset int ,@IdHistoryKartabl int,@flag bit=0
	select @IdHistoryRequset=isnull(max(fldid),0)+1 from dead.tblhistoryRequestAmanat
	select @IdHistoryKartabl=isnull(max(fldid),0)+1 from dead.tblhistoryKartabl_Request

if not exists (select  *  from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join dead.tblGhabreAmanat gh on s.fldid=fldShomareId
	where fldGheteId=@fldGheteId) and not exists(select  *  from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join  dead.tblRequestAmanat gh on s.fldid=fldShomareId
	where fldGheteId=@fldGheteId and fldIsEbtal<>1)

begin

	update dead.tblghete /*UpdateGhete*/
	set fldNameGhete=@fldNameGhete,fldVadiSalamId=@fldVadiSalamId ,fldUserId=@fldUserId,fldDate=getdate(),fldDesc=@fldDesc,fldIP=@fldIP
	where fldId=@fldGheteId
	if (@@error<>0)
	begin
		rollback

		set @flag=1
	end

	if (@flag=0)/*insert tblhistoryKartabl_Request*/
	begin
		insert into dead.tblhistoryKartabl_Request  ([fldId], [fldKartablName], [fldActionName], [fldRequestId], 
		[fldKartablNextName], [fldEtmamCharkhe], [fldUserIdInsert], [fldOrganId], [fldIPInsert], [fldDesc],
		[fldDateInsert], [fldUserIdDelete], [fldDateDelete], [fldIPDelete])

		select  row_number()over (order by kr.fldid)+@IdHistoryKartabl,k.fldTitleKartabl,a.fldTitleAction,ra.fldid
		,isnull(k1.fldTitleKartabl,''),fldEtmamCharkhe,kr.fldUserId,kr.fldOrganId,kr.fldip,kr.fldDesc,kr.fldDate,@fldUserId,getdate(),@fldip
		from dead.tblKartabl_Request kr 
		inner join dead.tblRequestAmanat ra on fldRequestId=ra.fldid
		inner join dead.tblShomare s on s.fldid=fldShomareId
		inner join Dead.tblRadif r on r.fldid=fldRadifId
		inner join dead.tblKartabl k on fldKartablId=k.fldid
		inner join dead.tblActions a on a.fldid=fldActionId
		left join dead.tblKartabl k1 on k1.fldid=fldKartablNextId
		where fldGheteId=@fldGheteId and fldIsEbtal=1 
		if (@@ERROR<>0)
		begin
			rollback
			set @flag=1
		end
	end
	if (@flag=0)/*insert historyRequestAmanat*/
	begin
		insert into dead.tblhistoryRequestAmanat([fldId], [fldEmployeeName], [fldShomareName], [fldTarikh], [fldOrganId], [fldUserIdInsert],
					[fldIPInsert], [fldDesc], [fldDateInsert], [fldDateDelete], [fldUserIdDelete], [fldIPDelete], [fldRequstId])
		select row_number()over (order by tblRequestAmanat.fldid)+@IdHistoryRequset,e.fldName+' '+fldFamily
		,s.fldShomare,fldTarikh,tblRequestAmanat.fldOrganId,tblRequestAmanat.fldUserId,tblRequestAmanat.fldIP,tblRequestAmanat.fldDesc,tblRequestAmanat.fldDate
		,getdate(),@fldUserId,@fldIp,tblRequestAmanat.fldid
		from Dead.tblRequestAmanat 
		inner join com.tblEmployee e on e.fldid=fldEmployeeId
		inner join dead.tblShomare s on s.fldid=fldShomareId
		inner join Dead.tblRadif r on r.fldid=fldRadifId
		where fldGheteId=@fldGheteId and fldIsEbtal=1
		if (@@error<>0)
		begin
			rollback
			set @flag=1
		end
	end	 
	if (@flag=0) /*delete tblKartabl_Request*/
		begin
			delete r from dead.tblKartabl_Request r
			inner join dead.tblRequestAmanat ra on fldRequestId=ra.fldid
			inner join dead.tblShomare s on s.fldid=fldShomareId
			inner join Dead.tblRadif Radif on Radif.fldid=fldRadifId
			where fldGheteId=@fldGheteId and fldIsEbtal=1 
			if (@@error<>0)
			begin
				rollback
				set @flag=1
			end
		end
	if (@flag=0)/*delete tblRequestAmanat*/
		begin
			delete ra from
			 dead.tblRequestAmanat ra
			inner join dead.tblShomare s on s.fldid=fldShomareId
			inner join Dead.tblRadif Radif on Radif.fldid=fldRadifId
			where fldGheteId=@fldGheteId and fldIsEbtal=1 
			if (@@error<>0)
			begin
				rollback
				set @flag=1
			end
		end

	if (@flag=0)/*delete tblShomare*/
	begin
		delete sh 
		from dead.tblShomare sh 
		inner join tblRadif r on fldRadifId=r.fldid
		where fldGheteId=@fldGheteId
		if (@@ERROR<>0)
		begin
			rollback
			set @flag=1
		end

	end
	if (@flag=0)/*delete tblRadif*/
	begin
		delete from tblRadif
		where fldGheteId=@fldGheteId
		if (@@ERROR<>0)
			rollback
	end

	if (@flag=0)/*insert ghete*/
	begin
		declare @RadifId int,@ShId int 
		select @ShId =ISNULL(max(fldId),0) from [Dead].[tblShomare] 
		select @RadifId =ISNULL(max(fldId),0) from [Dead].[tblRadif] 
		;with radif as(
			select ROW_NUMBER() over (order by (select 1))as r,N'ردیف' as radifName
			union all
			select r+1,N'ردیف' as radif
			from radif as r 
			where r<@fldRadif
		)
		INSERT INTO [Dead].[tblRadif] ([fldId], [fldGheteId], [fldNameRadif], [fldUserId], [fldIP], [fldDesc], [fldDate],fldOrganId)
		select @RadifId+r, @fldGheteId, radifName+' ' +cast (r as varchar(10)), @fldUserId, @fldIP, @fldDesc, getdate(),@fldOrganId
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
			where fldGheteId=@fldGheteId
			)t
			inner join tabaghe as t2 on t.r2=t2.rowT
			)
			INSERT INTO [Dead].[tblShomare] ([fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], [fldUserId], [fldIp], [fldDesc], [fldDate],fldOrganId)
				  select r2+@ShId,RadifId,ShName+' '+cast (r_Sh as varchar(10)) as shName,CountTabaghe , @fldUserId, @fldIP, @fldDesc, getdate(),@fldOrganId 
				  from sh_r
				  order by RadifId,r_sh

				--INSERT INTO [Dead].[tblShomare] ([fldId], [fldRadifId], [fldShomare], [fldTedadTabaghat], [fldUserId], [fldIp], [fldDesc], [fldDate],fldOrganId)
				--select r+@ShId,radif,ShName+' '+cast (rowSh as varchar(10)) as shName,CountTabaghe , @fldUserId, @fldIP, @fldDesc, getdate(),@fldOrganId
				--from (
				--select ROW_NUMBER() over (order by (r.fldId))as r,r.fldId as radif,N'شماره' as ShName
				--,ROW_NUMBER() over (PARTITION BY r.fldId order by (r.fldId))as rowSh
				--	from Dead.tblRadif as r  
				--	cross join Dead.tblRadif as r2
				--	where r.fldGheteId=@fldGheteId and r2.fldGheteId=@fldGheteId
				--	)t
				--	inner join tabaghe as t2 on t.r=t2.rowT
				  if(@@Error<>0)
					rollback 
		end
	end
end
GO
