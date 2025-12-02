SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Dead].[spr_DeleteAllTablesOnGhete]
@fldGheteId int,
@fldUserId int,
@fldIP nvarchar(15)
as 
declare @IdHistoryRequset int ,@IdHistoryKartabl int,@flag bit=0
if not exists (select  *  from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join dead.tblGhabreAmanat gh on s.fldid=fldShomareId
	where fldGheteId=@fldGheteId) and not exists(select  *  from dead.tblradif r inner join dead.tblShomare s on r.fldid=fldRadifId
	inner join  dead.tblRequestAmanat gh on s.fldid=fldShomareId
	where fldGheteId=@fldGheteId and fldIsEbtal<>1)
	
begin
	
	select @IdHistoryRequset=isnull(max(fldid),0)+1 from dead.tblhistoryRequestAmanat
	select @IdHistoryKartabl=isnull(max(fldid),0)+1 from dead.tblhistoryKartabl_Request

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
	if (@flag=0)
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
	if (@flag=0)
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
	if (@flag=0)
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
		if (@flag=0)
		begin
			update sh set fldUserId=@fldUserId,fldDate=GETDATE()
			from dead.tblShomare sh 
			inner join tblRadif r on fldRadifId=r.fldid
			where fldGheteId=@fldGheteId
			if (@@ERROR<>0)
				rollback
			else 
			begin
				delete sh 
				from dead.tblShomare sh 
				inner join tblRadif r on fldRadifId=r.fldid
				where fldGheteId=@fldGheteId
				if (@@ERROR<>0)
					rollback
				else
				begin
					update  tblRadif set fldUserId=@fldUserId,fldDate=GETDATE()
					where fldGheteId=@fldGheteId

					delete from tblRadif
					where fldGheteId=@fldGheteId
					if (@@ERROR<>0)
						rollback
					else
					begin
						update	tblghete set fldUserId=@fldUserId,fldDate=GETDATE()
						where fldid=@fldGheteId

						delete from
						tblghete where fldid=@fldGheteId
						if (@@Error<>0)
						rollback
					end
				end

			end
		end

end
GO
