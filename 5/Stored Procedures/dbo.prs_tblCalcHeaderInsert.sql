SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblCalcHeaderInsert] 
	@fldID int out ,
    @fldYear smallint,
	@fldMonth tinyint,
    @fldNobatPardakhtId int,
    @fldOrganId int,
    @fldStatus tinyint,
    @fldIp varchar(15) = NULL,
    @fldUserId int,
    @fldPersnalId varchar(max),
	@fldCalcType int
AS 
	
	BEGIN TRAN
	declare @HeaderId int, @Status int

	/*اگر محاسبات به خطا خورده بود*/
	--if  (@Status>=5 and @Status not in (11,14))
	
	if exists (select* from tblCalcHeader 
	where fldYear=@fldYear and fldMonth=@fldMonth and fldNobatPardakhtId=@fldNobatPardakhtId and fldCalcType=@fldCalcType and fldOrganId=@fldOrganId
	and (fldStatus>=5 and fldStatus not in (11,14)))
	begin
		delete d from tblCalcDetail  as d
		inner join tblCalcHeader as h on h.fldId=d.fldHeaderId
		where fldYear=@fldYear and fldMonth=@fldMonth and fldNobatPardakhtId=@fldNobatPardakhtId and fldCalcType=@fldCalcType and fldOrganId=@fldOrganId
			and (fldStatus>=5 and fldStatus not in (11,14))
		--where fldHeaderId=@HeaderId
		if (@@ERROR<>0)
			ROLLBACK
		else
		begin
			delete tblCalcHeader 
			where fldYear=@fldYear and fldMonth=@fldMonth and fldNobatPardakhtId=@fldNobatPardakhtId and fldCalcType=@fldCalcType and fldOrganId=@fldOrganId
			and (fldStatus>=5 and fldStatus not in (11,14))
			--where fldId=@HeaderId
				if (@@ERROR<>0)
					ROLLBACK
				else
				begin
					INSERT INTO [dbo].[tblCalcHeader] ([fldYear],fldMonth, [fldNobatPardakhtId], [fldOrganId], [fldStatus], [fldIp], [fldUserId], [fldDate],fldCalcType)
					SELECT @fldYear,@fldMonth, @fldNobatPardakhtId, @fldOrganId, @fldStatus, @fldIp, @fldUserId, GETDATE(),@fldCalcType 
					if (@@ERROR<>0)
						ROLLBACK
					else
					begin
						set @fldID=SCOPE_IDENTITY();
						INSERT INTO [dbo].[tblCalcDetail] ([fldHeaderId], [fldPersonalId],fldUserId,fldDate,fldTypeEstekhdamId,fldCostCenterId)
						SELECT @fldID, Item,@fldUserId,GETDATE(),fldNoeEstekhdamId,p.fldCostCenterId
						from Com.Split(@fldPersnalId,';') as s 
						inner join pay.Pay_tblPersonalInfo as p on p.fldId=item
						left outer join tblCalcDetail as c 
						inner join  tblCalcHeader as h on h.fldId=c.fldHeaderId and fldYear=@fldYear and fldMonth=@fldMonth and fldNobatPardakhtId=@fldNobatPardakhtId
						and h.fldCalcType=@fldCalcType
						 on c.fldPersonalId=s.Item
						 outer apply(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam 
									WHERE fldPrsPersonalInfoId=p.fldPrs_PersonalInfoId 
									and fldTarikh<= Cast(@fldYear as varchar(5))+ '/'+  right('0' + convert(varchar,@fldMonth),2)+'/31'
									ORDER BY fldTarikh desc,fldDate desc) t
						where Item<>''	and (c.fldPersonalId is null 
						--or (fldStatus>=5 and fldStatus not in (11,14))
						)
						if (@@ERROR<>0)
							ROLLBACK
						else
						begin
							--IF NOT EXISTS(     
						 --  select * from( SELECT top(1) sj.name
						 --  , sja.*
							--FROM msdb.dbo.sysjobactivity AS sja
							--INNER JOIN msdb.dbo.sysjobs AS sj ON sja.job_id = sj.job_id
							--WHERE sja.start_execution_date IS NOT NULL
							--	and name='CalcQueue'
							--   order by start_execution_date desc)t
							--   where stop_execution_date IS NULL
							--) 
							--BEGIN      
    
							--	EXEC msdb.dbo.sp_start_job N'CalcQueue'; 
							--END  
						/*	exec prs_CalcQueue;  بساااااااااااااازم*/ 
						select 1
						end
					end
				end
			end
		end
		else if exists (SELECT*
				from Com.Split(@fldPersnalId,';') as s 
				left outer join tblCalcDetail as c 
				inner join  tblCalcHeader as h on h.fldId=c.fldHeaderId and fldYear=@fldYear and fldMonth=@fldMonth and fldNobatPardakhtId=@fldNobatPardakhtId
				and h.fldCalcType=@fldCalcType
					on c.fldPersonalId=s.Item
				where Item<>''	and (c.fldPersonalId is null 
				--or (fldStatus>=5 and fldStatus not in (11,14))
				)
				) 
		begin				
			INSERT INTO [dbo].[tblCalcHeader] ([fldYear],fldMonth, [fldNobatPardakhtId], [fldOrganId], [fldStatus], [fldIp], [fldUserId], [fldDate],fldCalcType)
			SELECT @fldYear,@fldMonth, @fldNobatPardakhtId, @fldOrganId, @fldStatus, @fldIp, @fldUserId, GETDATE(),@fldCalcType
			if (@@ERROR<>0)
				ROLLBACK
			else
			begin
				set @fldID=SCOPE_IDENTITY();
				INSERT INTO [dbo].[tblCalcDetail] ([fldHeaderId], [fldPersonalId],fldUserId,fldDate,fldTypeEstekhdamId,fldCostCenterId)
				SELECT @fldID, Item,@fldUserId,GETDATE(),fldNoeEstekhdamId,fldCostCenterId
				from Com.Split(@fldPersnalId,';') as s 
				inner join pay.Pay_tblPersonalInfo as p on p.fldId=item
				left outer join tblCalcDetail as c 
				inner join  tblCalcHeader as h on h.fldId=c.fldHeaderId and fldYear=@fldYear and fldMonth=@fldMonth and fldNobatPardakhtId=@fldNobatPardakhtId
				and h.fldCalcType=@fldCalcType
					on c.fldPersonalId=s.Item
				outer apply(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam 
								WHERE fldPrsPersonalInfoId=p.fldPrs_PersonalInfoId 
								and fldTarikh<= Cast(@fldYear as varchar(5))+ '/'+  right('0' + convert(varchar,@fldMonth),2)+'/31'
								ORDER BY fldTarikh desc,fldDate desc) t
				where Item<>''	and (c.fldPersonalId is null 
				--or (fldStatus>=5 and fldStatus not in (11,14))
				)
				if (@@ERROR<>0)
					ROLLBACK
				else
				begin
				--WAITFOR DELAY '00:00:01';
					--IF NOT EXISTS(     
					--select * from( SELECT top(1) sj.name
					--, sja.*
					--FROM msdb.dbo.sysjobactivity AS sja
					--INNER JOIN msdb.dbo.sysjobs AS sj ON sja.job_id = sj.job_id
					--WHERE sja.start_execution_date IS NOT NULL
					--	and name='CalcQueue'
					--	order by start_execution_date desc)t
					--	where stop_execution_date IS NULL
					--) 
					BEGIN      
    
						--EXEC msdb.dbo.sp_start_job N'CalcQueue'; 
						/*	exec prs_CalcQueue;  بساااااااااااااازم*/ 
						select 1
					END  
				end
			end
		end
		
	COMMIT
GO
