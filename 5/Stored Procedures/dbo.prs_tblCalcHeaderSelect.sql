SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [dbo].[prs_tblCalcHeaderSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(max),
	@Year smallint,
	@Month tinyint,
	@NobatPardakhtId int,
	@UserId int,
	@OrganId int,
	@h int
AS 
	BEGIN TRAN
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
		select t.*,fldQueue*3 fldQueueTime from(
		SELECT top(@h) tblCalcHeader.[fldId], [fldYear],[fldMonth], [fldNobatPardakhtId], [fldOrganId],tblCalcHeader.[fldStatus], tblCalcHeader.[fldIp], tblCalcHeader.[fldUserId], tblCalcHeader.[fldDate] 
		,case when tblCalcHeader.[fldStatus]=0  then  N'در انتظار محاسبات'		  when tblCalcHeader.[fldStatus]=1 then  N'پایان محاسبات'		  when tblCalcHeader.[fldStatus]=2	       then  N'محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=3  then  N'محاسبات دپو'				  when tblCalcHeader.[fldStatus]=4 then  N'محاسبات سیر'		  when tblCalcHeader.[fldStatus]=5	       then  N'خطا در محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=6  then  N'خطا در محاسبات دپو'		  when tblCalcHeader.[fldStatus]=7 then  N'خطا در محاسبات سیر'  when tblCalcHeader.[fldStatus] in(8,9,13)   then  N'خطا در محاسبات ممیزی'
			  when tblCalcHeader.[fldStatus]=11 then  N' محاسبات دوره های آموزشی'  when tblCalcHeader.[fldStatus]=12 then  N'خطا در محاسبات دوره های آموزشی' 
			  when tblCalcHeader.[fldStatus]=14 then  N' محاسبات تشویقی'			when tblCalcHeader.[fldStatus]=15 then  N'خطا در محاسبات تشویقی' 
			 else  N'' end [fldStatusName]
		,case when tblCalcHeader.[fldStatus]=0 then (select count(*) from tblCalcHeader c where c.[fldStatus]=0 and  c.fldDate<=tblCalcHeader.fldDate) else 0 end as fldQueue
		,Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,isnull(p.fldFamily+'_'+p.fldName,'') as fldName
		,case when [fldMonth]=1  then N'فروردین' when [fldMonth]=2  then N'اردیبهشت' when [fldMonth]=3 then N'خرداد' when [fldMonth]=4  then N'تیر' when [fldMonth]=5  then N'مرداد'  
			  when [fldMonth]=6  then N'شهریور'  when [fldMonth]=7  then N'مهر'       when [fldMonth]=8 then N'آبان'  when [fldMonth]=9  then N'آذر' when [fldMonth]=10 then N'دی' 
			  when [fldMonth]=11 then N'بهمن'    when [fldMonth]=12 then N'اسفند' end as [fldMonthName]
		,dbo.Fn_AssembelyMiladiToShamsi(tblCalcHeader.fldDate)+' '+cast(cast(tblCalcHeader.fldDate as time(0)) as varchar(5)) fldTarikh,fldCalcType
		,case when fldCalcType=1 then N'محاسبات حقوق' else N'محاسبات عیدی' end  as fldCalcTypeName
		FROM   [Pay].[tblCalcHeader] 
		inner join com.tblUser as u on u.fldId=tblCalcHeader.fldUserId
		inner join com.tblOrganization on com.tblOrganization.fldId=tblCalcHeader.fldOrganId
		left outer join com.tblEmployee as p on p.fldId=u.fldEmployId 
		WHERE  tblCalcHeader.fldId = @Value
		)t

	if (@fieldname=N'CountQueue')/*فرق داره*/
		select t.*,fldQueue*3 fldQueueTime from(
		SELECT top(@h) tblCalcHeader.[fldId], [fldYear],[fldMonth], [fldNobatPardakhtId], [fldOrganId], tblCalcHeader.[fldStatus], tblCalcHeader.[fldIp], tblCalcHeader.[fldUserId], tblCalcHeader.[fldDate] 
		,case when tblCalcHeader.[fldStatus]=0  then  N'در انتظار محاسبات'		  when tblCalcHeader.[fldStatus]=1 then  N'پایان محاسبات'		  when tblCalcHeader.[fldStatus]=2	       then  N'محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=3  then  N'محاسبات دپو'				  when tblCalcHeader.[fldStatus]=4 then  N'محاسبات سیر'		  when tblCalcHeader.[fldStatus]=5	       then  N'خطا در محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=6  then  N'خطا در محاسبات دپو'		  when tblCalcHeader.[fldStatus]=7 then  N'خطا در محاسبات سیر'  when tblCalcHeader.[fldStatus] in(8,9,13)   then  N'خطا در محاسبات ممیزی'
			  when tblCalcHeader.[fldStatus]=11 then  N' محاسبات دوره های آموزشی'  when tblCalcHeader.[fldStatus]=12 then  N'خطا در محاسبات دوره های آموزشی' 
			  when tblCalcHeader.[fldStatus]=14 then  N' محاسبات تشویقی'			when tblCalcHeader.[fldStatus]=15 then  N'خطا در محاسبات تشویقی' 
			 else  N'' end [fldStatusName]
		,case when tblCalcHeader.[fldStatus]=0 then (select count(*) from tblCalcHeader c where c.[fldStatus]=0) else 0 end as fldQueue
		,Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,isnull(p.fldFamily+'_'+p.fldName, '') as fldName
		,case when [fldMonth]=1  then N'فروردین' when [fldMonth]=2  then N'اردیبهشت' when [fldMonth]=3 then N'خرداد' when [fldMonth]=4  then N'تیر' when [fldMonth]=5  then N'مرداد'  
			  when [fldMonth]=6  then N'شهریور'  when [fldMonth]=7  then N'مهر'       when [fldMonth]=8 then N'آبان'  when [fldMonth]=9  then N'آذر' when [fldMonth]=10 then N'دی' 
			  when [fldMonth]=11 then N'بهمن'    when [fldMonth]=12 then N'اسفند' end as [fldMonthName]
		,dbo.Fn_AssembelyMiladiToShamsi(tblCalcHeader.fldDate)+' '+cast(cast(tblCalcHeader.fldDate as time(0)) as varchar(5)) fldTarikh,fldCalcType
		,case when fldCalcType=1 then N'محاسبات حقوق' else N'محاسبات عیدی' end  as fldCalcTypeName
		FROM   [Pay].[tblCalcHeader] 
		inner join com.tblUser as u on u.fldId=tblCalcHeader.fldUserId
		inner join com.tblOrganization on com.tblOrganization.fldId=tblCalcHeader.fldOrganId
		left outer join com.tblEmployee as p on p.fldId=u.fldEmployId 
		WHERE  tblCalcHeader.[fldStatus] = 0
		)t	

	if (@fieldname=N'CheckStatus_CalcEnd_IP')
		select fldId,fldYear,fldNobatPardakhtId,fldOrganId,[fldStatus],fldIp,fldUserId,fldDate,[fldStatusName],fldQueue, fldNameOrgan
				,fldName,[fldMonthName],fldTarikh,fldQueue*3 fldQueueTime,fldQueue*3 fldQueueTime,fldCalcType,fldCalcTypeName  from(
		SELECT top(@h) tblCalcHeader.[fldId], [fldYear],[fldMonth], [fldNobatPardakhtId], [fldOrganId], tblCalcHeader.[fldStatus], tblCalcHeader.[fldIp], tblCalcHeader.[fldUserId], tblCalcHeader.[fldDate] 
		,case when tblCalcHeader.[fldStatus]=0  then  N'در انتظار محاسبات'		  when tblCalcHeader.[fldStatus]=1 then  N'پایان محاسبات'		  when tblCalcHeader.[fldStatus]=2	       then  N'محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=3  then  N'محاسبات دپو'				  when tblCalcHeader.[fldStatus]=4 then  N'محاسبات سیر'		  when tblCalcHeader.[fldStatus]=5	       then  N'خطا در محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=6  then  N'خطا در محاسبات دپو'		  when tblCalcHeader.[fldStatus]=7 then  N'خطا در محاسبات سیر'  when tblCalcHeader.[fldStatus] in(8,9,13)   then  N'خطا در محاسبات ممیزی'
			  when tblCalcHeader.[fldStatus]=11 then  N' محاسبات دوره های آموزشی'  when tblCalcHeader.[fldStatus]=12 then  N'خطا در محاسبات دوره های آموزشی' 
			  when tblCalcHeader.[fldStatus]=14 then  N' محاسبات تشویقی'			when tblCalcHeader.[fldStatus]=15 then  N'خطا در محاسبات تشویقی' 
			 else  N'' end [fldStatusName]
		,case when tblCalcHeader.[fldStatus]=0 then (select count(*) from tblCalcHeader c where c.[fldStatus]=0 and  c.fldDate<=tblCalcHeader.fldDate) else 0 end as fldQueue
		,Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,isnull(p.fldFamily+'_'+p.fldName, '') as fldName
		,case when [fldMonth]=1  then N'فروردین' when [fldMonth]=2  then N'اردیبهشت' when [fldMonth]=3 then N'خرداد' when [fldMonth]=4  then N'تیر' when [fldMonth]=5  then N'مرداد'  
			  when [fldMonth]=6  then N'شهریور'  when [fldMonth]=7  then N'مهر'       when [fldMonth]=8 then N'آبان'  when [fldMonth]=9  then N'آذر' when [fldMonth]=10 then N'دی' 
			  when [fldMonth]=11 then N'بهمن'    when [fldMonth]=12 then N'اسفند' end as [fldMonthName]
		,dbo.Fn_AssembelyMiladiToShamsi(tblCalcHeader.fldDate)+' '+cast(cast(tblCalcHeader.fldDate as time(0)) as varchar(5))fldTarikh,fldCalcType
		,case when tblCalcHeader.[fldStatus]>=5 and tblCalcHeader.[fldStatus] not in (11,14) then 1 when tblCalcHeader.[fldStatus]=1 then 2 else 3 end OrderStatus
		,case when fldCalcType=1 then N'محاسبات حقوق' else N'محاسبات عیدی' end  as fldCalcTypeName
		FROM   [Pay].[tblCalcHeader] 
		inner join com.tblUser as u on u.fldId=tblCalcHeader.fldUserId
		inner join com.tblOrganization on com.tblOrganization.fldId=tblCalcHeader.fldOrganId
		left outer join com.tblEmployee as p on p.fldId=u.fldEmployId 
		where fldYear=@Year and fldMonth=@Month  and fldNobatPardakhtId=@NobatPardakhtId 
		and tblCalcHeader.fldUserId=@UserId and tblCalcHeader.fldIp=@Value
		and fldOrganId=@OrganId 
		)t
		order by fldId desc
	
	if (@fieldname=N'CheckStatus_CalcEnd')
	begin
			
			if  exists (select [value] from string_split(@Value,';')
						where value<>'' and  not exists (select d.fldPersonalId from    [Pay].[tblCalcHeader]   as c
						inner join tblCalcDetail as d on d.fldHeaderId=c.fldId
						 where fldYear=@Year and fldMonth=@Month and fldNobatPardakhtId=@NobatPardakhtId 
						 and fldOrganId=@OrganId and value=d.fldPersonalId))
			begin
				select t.*,fldQueue*3 fldQueueTime from(
				SELECT top(@h) tblCalcHeader.[fldId], [fldYear],[fldMonth], [fldNobatPardakhtId], [fldOrganId], tblCalcHeader.[fldStatus], tblCalcHeader.[fldIp], tblCalcHeader.[fldUserId], tblCalcHeader.[fldDate] 
				,case when tblCalcHeader.[fldStatus]=0  then  N'در انتظار محاسبات'		  when tblCalcHeader.[fldStatus]=1 then  N'پایان محاسبات'		  when tblCalcHeader.[fldStatus]=2	       then  N'محاسبات مانور'
					  when tblCalcHeader.[fldStatus]=3  then  N'محاسبات دپو'				  when tblCalcHeader.[fldStatus]=4 then  N'محاسبات سیر'		  when tblCalcHeader.[fldStatus]=5	       then  N'خطا در محاسبات مانور'
					  when tblCalcHeader.[fldStatus]=6  then  N'خطا در محاسبات دپو'		  when tblCalcHeader.[fldStatus]=7 then  N'خطا در محاسبات سیر'  when tblCalcHeader.[fldStatus] in(8,9,13)   then  N'خطا در محاسبات ممیزی'
					  when tblCalcHeader.[fldStatus]=11 then  N' محاسبات دوره های آموزشی'  when tblCalcHeader.[fldStatus]=12 then  N'خطا در محاسبات دوره های آموزشی' 
					  when tblCalcHeader.[fldStatus]=14 then  N' محاسبات تشویقی'			when tblCalcHeader.[fldStatus]=15 then  N'خطا در محاسبات تشویقی' 
					 else  N'' end [fldStatusName]
				,case when tblCalcHeader.[fldStatus]=0 then (select count(*) from tblCalcHeader c where c.[fldStatus]=0 and  c.fldDate<=tblCalcHeader.fldDate) else 0 end as fldQueue
				,Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,isnull(p.fldFamily+'_'+p.fldName, '') as fldName
				,case when [fldMonth]=1  then N'فروردین' when [fldMonth]=2  then N'اردیبهشت' when [fldMonth]=3 then N'خرداد' when [fldMonth]=4  then N'تیر' when [fldMonth]=5  then N'مرداد'  
					  when [fldMonth]=6  then N'شهریور'  when [fldMonth]=7  then N'مهر'       when [fldMonth]=8 then N'آبان'  when [fldMonth]=9  then N'آذر' when [fldMonth]=10 then N'دی' 
					  when [fldMonth]=11 then N'بهمن'    when [fldMonth]=12 then N'اسفند' end as [fldMonthName]
				,dbo.Fn_AssembelyMiladiToShamsi(tblCalcHeader.fldDate)+' '+cast(cast(tblCalcHeader.fldDate as time(0)) as varchar(5))fldTarikh,fldCalcType
				,case when fldCalcType=1 then N'محاسبات حقوق' else N'محاسبات عیدی' end  as fldCalcTypeName
		FROM   [Pay].[tblCalcHeader] 
		inner join com.tblUser as u on u.fldId=tblCalcHeader.fldUserId
		inner join com.tblOrganization on com.tblOrganization.fldId=tblCalcHeader.fldOrganId
		left outer join com.tblEmployee as p on p.fldId=u.fldEmployId 
				where tblCalcHeader.fldId=0
				)t	
			END
			else
			begin
				select fldId,fldYear,fldNobatPardakhtId,fldOrganId,[fldStatus],fldIp,fldUserId,fldDate,[fldStatusName],fldQueue, fldNameOrgan
				,fldName,[fldMonthName],fldTarikh,fldQueue*3 fldQueueTime,fldQueue*3 fldQueueTime ,fldCalcType,fldCalcTypeName from(
				SELECT top(@h) tblCalcHeader.[fldId], [fldYear],[fldMonth], [fldNobatPardakhtId], [fldOrganId], tblCalcHeader.[fldStatus], tblCalcHeader.[fldIp], tblCalcHeader.[fldUserId], tblCalcHeader.[fldDate] 
				,case when tblCalcHeader.[fldStatus]=0  then  N'در انتظار محاسبات'		  when tblCalcHeader.[fldStatus]=1 then  N'پایان محاسبات'		  when tblCalcHeader.[fldStatus]=2	       then  N'محاسبات مانور'
					  when tblCalcHeader.[fldStatus]=3  then  N'محاسبات دپو'				  when tblCalcHeader.[fldStatus]=4 then  N'محاسبات سیر'		  when tblCalcHeader.[fldStatus]=5	       then  N'خطا در محاسبات مانور'
					  when tblCalcHeader.[fldStatus]=6  then  N'خطا در محاسبات دپو'		  when tblCalcHeader.[fldStatus]=7 then  N'خطا در محاسبات سیر'  when tblCalcHeader.[fldStatus] in(8,9,13)   then  N'خطا در محاسبات ممیزی'
					  when tblCalcHeader.[fldStatus]=11 then  N' محاسبات دوره های آموزشی'  when tblCalcHeader.[fldStatus]=12 then  N'خطا در محاسبات دوره های آموزشی' 
					  when tblCalcHeader.[fldStatus]=14 then  N' محاسبات تشویقی'			when tblCalcHeader.[fldStatus]=15 then  N'خطا در محاسبات تشویقی' 
					 else  N'' end [fldStatusName]
				,case when tblCalcHeader.[fldStatus]=0 then (select count(*) from tblCalcHeader c where c.[fldStatus]=0 and  c.fldDate<=tblCalcHeader.fldDate) else 0 end as fldQueue
				,Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,isnull(p.fldFamily+'_'+p.fldName, '') as fldName
				,case when [fldMonth]=1  then N'فروردین' when [fldMonth]=2  then N'اردیبهشت' when [fldMonth]=3 then N'خرداد' when [fldMonth]=4  then N'تیر' when [fldMonth]=5  then N'مرداد'  
					  when [fldMonth]=6  then N'شهریور'  when [fldMonth]=7  then N'مهر'       when [fldMonth]=8 then N'آبان'  when [fldMonth]=9  then N'آذر' when [fldMonth]=10 then N'دی' 
					  when [fldMonth]=11 then N'بهمن'    when [fldMonth]=12 then N'اسفند' end as [fldMonthName]
				,dbo.Fn_AssembelyMiladiToShamsi(tblCalcHeader.fldDate)+' '+cast(cast(tblCalcHeader.fldDate as time(0)) as varchar(5))fldTarikh,fldCalcType
				--,count(d.fldPersonalId) over (partition by d.fldPersonalId) as cnt
				,case when tblCalcHeader.[fldStatus]=0 then 0 when tblCalcHeader.[fldStatus] in (2,3,4,11,14)  then 1 
				when tblCalcHeader.[fldStatus]>=5 and tblCalcHeader.[fldStatus] not in (11,14) then 3 when tblCalcHeader.[fldStatus]=1 then 4 else 5 end OrderStatus
				,case when fldCalcType=1 then N'محاسبات حقوق' else N'محاسبات عیدی' end  as fldCalcTypeName
		FROM   [Pay].[tblCalcHeader] 
		inner join com.tblUser as u on u.fldId=tblCalcHeader.fldUserId
		inner join com.tblOrganization on com.tblOrganization.fldId=tblCalcHeader.fldOrganId
		inner join pay.tblCalcDetail as d on d.fldHeaderId=[tblCalcHeader].fldId
		left outer join com.tblEmployee as p on p.fldId=u.fldEmployId 
				where 
				fldYear=@Year and fldMonth=@Month and fldNobatPardakhtId=@NobatPardakhtId 
				and fldOrganId=@OrganId
				and d.fldPersonalId in (select [value] from string_split(@Value,';'))
				)t	
				order by OrderStatus	
			END
	end
		if (@fieldname=N'CheckStatus_CalcEnd_Nahi')
		select t.*,fldQueue*3 fldQueueTime from(
		SELECT top(@h) tblCalcHeader.[fldId], [fldYear],[fldMonth], [fldNobatPardakhtId], [fldOrganId], tblCalcHeader.[fldStatus], tblCalcHeader.[fldIp], tblCalcHeader.[fldUserId], tblCalcHeader.[fldDate] 
		,case when tblCalcHeader.[fldStatus]=0  then  N'در انتظار محاسبات'		  when tblCalcHeader.[fldStatus]=1 then  N'پایان محاسبات'		  when tblCalcHeader.[fldStatus]=2	       then  N'محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=3  then  N'محاسبات دپو'				  when tblCalcHeader.[fldStatus]=4 then  N'محاسبات سیر'		  when tblCalcHeader.[fldStatus]=5	       then  N'خطا در محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=6  then  N'خطا در محاسبات دپو'		  when tblCalcHeader.[fldStatus]=7 then  N'خطا در محاسبات سیر'  when tblCalcHeader.[fldStatus] in(8,9,13)   then  N'خطا در محاسبات ممیزی'
			  when tblCalcHeader.[fldStatus]=11 then  N' محاسبات دوره های آموزشی'  when tblCalcHeader.[fldStatus]=12 then  N'خطا در محاسبات دوره های آموزشی' 
			  when tblCalcHeader.[fldStatus]=14 then  N' محاسبات تشویقی'			when tblCalcHeader.[fldStatus]=15 then  N'خطا در محاسبات تشویقی' 
			 else  N'' end [fldStatusName]
		,case when tblCalcHeader.[fldStatus]=0 then (select count(*) from tblCalcHeader c where c.[fldStatus]=0 and  c.fldDate<=tblCalcHeader.fldDate) else 0 end as fldQueue
		,Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,isnull(p.fldFamily+'_'+p.fldName, '') as fldName
		,case when [fldMonth]=1  then N'فروردین' when [fldMonth]=2  then N'اردیبهشت' when [fldMonth]=3 then N'خرداد' when [fldMonth]=4  then N'تیر' when [fldMonth]=5  then N'مرداد'  
			  when [fldMonth]=6  then N'شهریور'  when [fldMonth]=7  then N'مهر'       when [fldMonth]=8 then N'آبان'  when [fldMonth]=9  then N'آذر' when [fldMonth]=10 then N'دی' 
			  when [fldMonth]=11 then N'بهمن'    when [fldMonth]=12 then N'اسفند' end as [fldMonthName]
		,dbo.Fn_AssembelyMiladiToShamsi(tblCalcHeader.fldDate)+' '+cast(cast(tblCalcHeader.fldDate as time(0)) as varchar(5))fldTarikh,fldCalcType
		,case when fldCalcType=1 then N'محاسبات حقوق' else N'محاسبات عیدی' end  as fldCalcTypeName
		FROM   [Pay].[tblCalcHeader] 
		inner join com.tblUser as u on u.fldId=tblCalcHeader.fldUserId
		inner join com.tblOrganization on com.tblOrganization.fldId=tblCalcHeader.fldOrganId
		left outer join com.tblEmployee as p on p.fldId=u.fldEmployId 
		where tblCalcHeader.fldUserId=@UserId
		and fldOrganId=@OrganId
		)t
		

	if (@fieldname=N'CalcStatus')
		select fldId,fldYear,fldNobatPardakhtId,fldOrganId,[fldStatus],fldIp,fldUserId,fldDate,[fldStatusName],fldQueue, fldNameOrgan
				,fldName,[fldMonthName],fldTarikh,fldQueue*3 fldQueueTime,fldQueue*3 fldQueueTime,fldCalcType,fldCalcTypeName  from(
		SELECT top(@h) tblCalcHeader.[fldId], [fldYear],[fldMonth], [fldNobatPardakhtId], [fldOrganId], tblCalcHeader.[fldStatus], tblCalcHeader.[fldIp], tblCalcHeader.[fldUserId], tblCalcHeader.[fldDate] 
		,case when tblCalcHeader.[fldStatus]=0  then  N'در انتظار محاسبات'		  when tblCalcHeader.[fldStatus]=1 then  N'پایان محاسبات'		  when tblCalcHeader.[fldStatus]=2	       then  N'محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=3  then  N'محاسبات دپو'				  when tblCalcHeader.[fldStatus]=4 then  N'محاسبات سیر'		  when tblCalcHeader.[fldStatus]=5	       then  N'خطا در محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=6  then  N'خطا در محاسبات دپو'		  when tblCalcHeader.[fldStatus]=7 then  N'خطا در محاسبات سیر'  when tblCalcHeader.[fldStatus] in(8,9,13)   then  N'خطا در محاسبات ممیزی'
			  when tblCalcHeader.[fldStatus]=11 then  N' محاسبات دوره های آموزشی'  when tblCalcHeader.[fldStatus]=12 then  N'خطا در محاسبات دوره های آموزشی' 
			  when tblCalcHeader.[fldStatus]=14 then  N' محاسبات تشویقی'			when tblCalcHeader.[fldStatus]=15 then  N'خطا در محاسبات تشویقی' 
			 else  N'' end [fldStatusName]
		,case when tblCalcHeader.[fldStatus]=0 then (select count(*) from tblCalcHeader c where c.[fldStatus]=0 and  c.fldDate<=tblCalcHeader.fldDate) else 0 end as fldQueue
		,Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,isnull(p.fldFamily+'_'+p.fldName, '') as fldName
		,case when [fldMonth]=1  then N'فروردین' when [fldMonth]=2  then N'اردیبهشت' when [fldMonth]=3 then N'خرداد' when [fldMonth]=4  then N'تیر' when [fldMonth]=5  then N'مرداد'  
			  when [fldMonth]=6  then N'شهریور'  when [fldMonth]=7  then N'مهر'       when [fldMonth]=8 then N'آبان'  when [fldMonth]=9  then N'آذر' when [fldMonth]=10 then N'دی' 
			  when [fldMonth]=11 then N'بهمن'    when [fldMonth]=12 then N'اسفند' end as [fldMonthName]
		,dbo.Fn_AssembelyMiladiToShamsi(tblCalcHeader.fldDate)+' '+cast(cast(tblCalcHeader.fldDate as time(0)) as varchar(5))fldTarikh,fldCalcType
		,case  when (tblCalcHeader.[fldStatus] in (2,3,4,11,14)) then 1 
			   when (tblCalcHeader.[fldStatus]>=5 and tblCalcHeader.[fldStatus] not in (11,14)) or tblCalcHeader.[fldStatus]=1 then 2 
			   when tblCalcHeader.[fldStatus]=0 then 3 else 4 end OrderStatus
		,case when fldCalcType=1 then N'محاسبات حقوق' else N'محاسبات عیدی' end  as fldCalcTypeName
		FROM   [Pay].[tblCalcHeader] 
		inner join com.tblUser as u on u.fldId=tblCalcHeader.fldUserId
		inner join com.tblOrganization on com.tblOrganization.fldId=tblCalcHeader.fldOrganId
		inner join pay.tblCalcDetail as d on d.fldHeaderId=[tblCalcHeader].fldId
		left outer join com.tblEmployee as p on p.fldId=u.fldEmployId 
		cross apply (SELECT value FROM STRING_SPLIT(@Value, ';') where value=d.fldPersonalId)code
		where fldYear=@Year  and fldMonth=@month  and fldNobatPardakhtId=@NobatPardakhtId
		
		)t
		order by OrderStatus

		if (@fieldname=N'CalcStatus_notRegulationId')
		select fldId,fldYear,fldNobatPardakhtId,fldOrganId,[fldStatus],fldIp,fldUserId,fldDate,[fldStatusName],fldQueue, fldNameOrgan
				,fldName,[fldMonthName],fldTarikh,fldQueue*3 fldQueueTime,fldQueue*3 fldQueueTime,fldCalcType,fldCalcTypeName  from(
		SELECT top(@h) tblCalcHeader.[fldId], [fldYear],[fldMonth], [fldNobatPardakhtId], [fldOrganId], tblCalcHeader.[fldStatus], tblCalcHeader.[fldIp], tblCalcHeader.[fldUserId], tblCalcHeader.[fldDate] 
		,case when tblCalcHeader.[fldStatus]=0  then  N'در انتظار محاسبات'		  when tblCalcHeader.[fldStatus]=1 then  N'پایان محاسبات'		  when tblCalcHeader.[fldStatus]=2	       then  N'محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=3  then  N'محاسبات دپو'				  when tblCalcHeader.[fldStatus]=4 then  N'محاسبات سیر'		  when tblCalcHeader.[fldStatus]=5	       then  N'خطا در محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=6  then  N'خطا در محاسبات دپو'		  when tblCalcHeader.[fldStatus]=7 then  N'خطا در محاسبات سیر'  when tblCalcHeader.[fldStatus] in(8,9,13)   then  N'خطا در محاسبات ممیزی'
			  when tblCalcHeader.[fldStatus]=11 then  N' محاسبات دوره های آموزشی'  when tblCalcHeader.[fldStatus]=12 then  N'خطا در محاسبات دوره های آموزشی' 
			  when tblCalcHeader.[fldStatus]=14 then  N' محاسبات تشویقی'			when tblCalcHeader.[fldStatus]=15 then  N'خطا در محاسبات تشویقی' 
			 else  N'' end [fldStatusName]
		,case when tblCalcHeader.[fldStatus]=0 then (select count(*) from tblCalcHeader c where c.[fldStatus]=0 and  c.fldDate<=tblCalcHeader.fldDate) else 0 end as fldQueue
		,Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,isnull(p.fldFamily+'_'+p.fldName, '') as fldName
		,case when [fldMonth]=1  then N'فروردین' when [fldMonth]=2  then N'اردیبهشت' when [fldMonth]=3 then N'خرداد' when [fldMonth]=4  then N'تیر' when [fldMonth]=5  then N'مرداد'  
			  when [fldMonth]=6  then N'شهریور'  when [fldMonth]=7  then N'مهر'       when [fldMonth]=8 then N'آبان'  when [fldMonth]=9  then N'آذر' when [fldMonth]=10 then N'دی' 
			  when [fldMonth]=11 then N'بهمن'    when [fldMonth]=12 then N'اسفند' end as [fldMonthName]
		,dbo.Fn_AssembelyMiladiToShamsi(tblCalcHeader.fldDate)+' '+cast(cast(tblCalcHeader.fldDate as time(0)) as varchar(5))fldTarikh,fldCalcType
		,case  when (tblCalcHeader.[fldStatus] in (2,3,4,11,14)) then 1 
			   when (tblCalcHeader.[fldStatus]>=5 and tblCalcHeader.[fldStatus] not in (11,14)) or tblCalcHeader.[fldStatus]=1 then 2 
			   when tblCalcHeader.[fldStatus]=0 then 3 else 4 end OrderStatus
		,case when fldCalcType=1 then N'محاسبات حقوق' else N'محاسبات عیدی' end  as fldCalcTypeName
		FROM   [Pay].[tblCalcHeader] 
		inner join com.tblUser as u on u.fldId=tblCalcHeader.fldUserId
		inner join com.tblOrganization on com.tblOrganization.fldId=tblCalcHeader.fldOrganId
		inner join pay.tblCalcDetail as d on d.fldHeaderId=[tblCalcHeader].fldId
		left outer join com.tblEmployee as p on p.fldId=u.fldEmployId 
		cross apply (SELECT value FROM STRING_SPLIT(@Value, ';') where value=d.fldPersonalId)code
		where fldYear=@Year and fldMonth=@Month and   fldNobatPardakhtId=@NobatPardakhtId

		)t
		order by OrderStatus

		if (@fieldname=N'CalcStatus_fldPersonalId')
		select t.*,fldQueue*3 fldQueueTime from(
		SELECT top(@h) tblCalcHeader.[fldId], [fldYear],[fldMonth], [fldNobatPardakhtId], [fldOrganId], tblCalcHeader.[fldStatus], tblCalcHeader.[fldIp], tblCalcHeader.[fldUserId], tblCalcHeader.[fldDate] 
		,case when tblCalcHeader.[fldStatus]=0  then  N'در انتظار محاسبات'		  when tblCalcHeader.[fldStatus]=1 then  N'پایان محاسبات'		  when tblCalcHeader.[fldStatus]=2	       then  N'محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=3  then  N'محاسبات دپو'				  when tblCalcHeader.[fldStatus]=4 then  N'محاسبات سیر'		  when tblCalcHeader.[fldStatus]=5	       then  N'خطا در محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=6  then  N'خطا در محاسبات دپو'		  when tblCalcHeader.[fldStatus]=7 then  N'خطا در محاسبات سیر'  when tblCalcHeader.[fldStatus] in(8,9,13)   then  N'خطا در محاسبات ممیزی'
			  when tblCalcHeader.[fldStatus]=11 then  N' محاسبات دوره های آموزشی'  when tblCalcHeader.[fldStatus]=12 then  N'خطا در محاسبات دوره های آموزشی' 
			  when tblCalcHeader.[fldStatus]=14 then  N' محاسبات تشویقی'			when tblCalcHeader.[fldStatus]=15 then  N'خطا در محاسبات تشویقی' 
			 else  N'' end [fldStatusName]
		,case when tblCalcHeader.[fldStatus]=0 then (select count(*) from tblCalcHeader c where c.[fldStatus]=0 and  c.fldDate<=tblCalcHeader.fldDate) else 0 end as fldQueue
		,Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,isnull(p.fldFamily+'_'+p.fldName, '') as fldName
		,case when [fldMonth]=1  then N'فروردین' when [fldMonth]=2  then N'اردیبهشت' when [fldMonth]=3 then N'خرداد' when [fldMonth]=4  then N'تیر' when [fldMonth]=5  then N'مرداد'  
			  when [fldMonth]=6  then N'شهریور'  when [fldMonth]=7  then N'مهر'       when [fldMonth]=8 then N'آبان'  when [fldMonth]=9  then N'آذر' when [fldMonth]=10 then N'دی' 
			  when [fldMonth]=11 then N'بهمن'    when [fldMonth]=12 then N'اسفند' end as [fldMonthName]
		,dbo.Fn_AssembelyMiladiToShamsi(tblCalcHeader.fldDate)+' '+cast(cast(tblCalcHeader.fldDate as time(0)) as varchar(5))fldTarikh,fldCalcType
		,case when fldCalcType=1 then N'محاسبات حقوق' else N'محاسبات عیدی' end  as fldCalcTypeName
		FROM   [Pay].[tblCalcHeader] 
		inner join com.tblUser as u on u.fldId=tblCalcHeader.fldUserId
		inner join com.tblOrganization on com.tblOrganization.fldId=tblCalcHeader.fldOrganId
		inner join pay.tblCalcDetail as d on d.fldHeaderId=[tblCalcHeader].fldId
		left outer join com.tblEmployee as p on p.fldId=u.fldEmployId 
		where fldYear=@Year  and fldMonth=@month  and fldNobatPardakhtId=@NobatPardakhtId and d.fldPersonalId=@Value
		
		)t

	if (@fieldname=N'CalcStatus_fldPersonalId_notRegulationId')
		select t.*,fldQueue*3 fldQueueTime from(
		SELECT top(@h) tblCalcHeader.[fldId], [fldYear],[fldMonth], [fldNobatPardakhtId], [fldOrganId], tblCalcHeader.[fldStatus], tblCalcHeader.[fldIp], tblCalcHeader.[fldUserId], tblCalcHeader.[fldDate] 
		,case when tblCalcHeader.[fldStatus]=0  then  N'در انتظار محاسبات'		  when tblCalcHeader.[fldStatus]=1 then  N'پایان محاسبات'		  when tblCalcHeader.[fldStatus]=2	       then  N'محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=3  then  N'محاسبات دپو'				  when tblCalcHeader.[fldStatus]=4 then  N'محاسبات سیر'		  when tblCalcHeader.[fldStatus]=5	       then  N'خطا در محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=6  then  N'خطا در محاسبات دپو'		  when tblCalcHeader.[fldStatus]=7 then  N'خطا در محاسبات سیر'  when tblCalcHeader.[fldStatus] in(8,9,13)   then  N'خطا در محاسبات ممیزی'
			  when tblCalcHeader.[fldStatus]=11 then  N' محاسبات دوره های آموزشی'  when tblCalcHeader.[fldStatus]=12 then  N'خطا در محاسبات دوره های آموزشی' 
			  when tblCalcHeader.[fldStatus]=14 then  N' محاسبات تشویقی'			when tblCalcHeader.[fldStatus]=15 then  N'خطا در محاسبات تشویقی' 
			 else  N'' end [fldStatusName]
		,case when tblCalcHeader.[fldStatus]=0 then (select count(*) from tblCalcHeader c where c.[fldStatus]=0 and  c.fldDate<=tblCalcHeader.fldDate) else 0 end as fldQueue
		,Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,isnull(p.fldFamily+'_'+p.fldName, '') as fldName
		,case when [fldMonth]=1  then N'فروردین' when [fldMonth]=2  then N'اردیبهشت' when [fldMonth]=3 then N'خرداد' when [fldMonth]=4  then N'تیر' when [fldMonth]=5  then N'مرداد'  
			  when [fldMonth]=6  then N'شهریور'  when [fldMonth]=7  then N'مهر'       when [fldMonth]=8 then N'آبان'  when [fldMonth]=9  then N'آذر' when [fldMonth]=10 then N'دی' 
			  when [fldMonth]=11 then N'بهمن'    when [fldMonth]=12 then N'اسفند' end as [fldMonthName]
		,dbo.Fn_AssembelyMiladiToShamsi(tblCalcHeader.fldDate)+' '+cast(cast(tblCalcHeader.fldDate as time(0)) as varchar(5))fldTarikh,fldCalcType
		,case when fldCalcType=1 then N'محاسبات حقوق' else N'محاسبات عیدی' end  as fldCalcTypeName
		FROM   [Pay].[tblCalcHeader] 
		inner join com.tblUser as u on u.fldId=tblCalcHeader.fldUserId
		inner join com.tblOrganization on com.tblOrganization.fldId=tblCalcHeader.fldOrganId
		inner join pay.tblCalcDetail as d on d.fldHeaderId=[tblCalcHeader].fldId
		left outer join com.tblEmployee as p on p.fldId=u.fldEmployId 
		where fldYear=@Year and fldMonth=@Month and fldNobatPardakhtId=@NobatPardakhtId and d.fldpersonalId=@Value

		)t

	if (@fieldname=N'')
	select t.*,fldQueue*3 fldQueueTime from(
		SELECT top(@h) tblCalcHeader.[fldId], [fldYear],[fldMonth], [fldNobatPardakhtId], [fldOrganId], tblCalcHeader.[fldStatus], tblCalcHeader.[fldIp], tblCalcHeader.[fldUserId], tblCalcHeader.[fldDate] 
		,case when tblCalcHeader.[fldStatus]=0  then  N'در انتظار محاسبات'		  when tblCalcHeader.[fldStatus]=1 then  N'پایان محاسبات'		  when tblCalcHeader.[fldStatus]=2	       then  N'محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=3  then  N'محاسبات دپو'				  when tblCalcHeader.[fldStatus]=4 then  N'محاسبات سیر'		  when tblCalcHeader.[fldStatus]=5	       then  N'خطا در محاسبات مانور'
			  when tblCalcHeader.[fldStatus]=6  then  N'خطا در محاسبات دپو'		  when tblCalcHeader.[fldStatus]=7 then  N'خطا در محاسبات سیر'  when tblCalcHeader.[fldStatus] in(8,9,13)   then  N'خطا در محاسبات ممیزی'
			  when tblCalcHeader.[fldStatus]=11 then  N' محاسبات دوره های آموزشی'  when tblCalcHeader.[fldStatus]=12 then  N'خطا در محاسبات دوره های آموزشی' 
			  when tblCalcHeader.[fldStatus]=14 then  N' محاسبات تشویقی'  when tblCalcHeader.[fldStatus]=15 then  N'خطا در محاسبات تشویقی' 
			 else  N'' end [fldStatusName]
		,case when tblCalcHeader.[fldStatus]=0 then (select count(*) from tblCalcHeader c where c.[fldStatus]=0 and  c.fldDate<=tblCalcHeader.fldDate) else 0 end as fldQueue
		,Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,isnull(p.fldFamily+'_'+p.fldName, '') as fldName
		,case when [fldMonth]=1  then N'فروردین' when [fldMonth]=2  then N'اردیبهشت' when [fldMonth]=3 then N'خرداد' when [fldMonth]=4  then N'تیر' when [fldMonth]=5  then N'مرداد'  
			  when [fldMonth]=6  then N'شهریور'  when [fldMonth]=7  then N'مهر'       when [fldMonth]=8 then N'آبان'  when [fldMonth]=9  then N'آذر' when [fldMonth]=10 then N'دی' 
			  when [fldMonth]=11 then N'بهمن'    when [fldMonth]=12 then N'اسفند' end as [fldMonthName]
		,dbo.Fn_AssembelyMiladiToShamsi(tblCalcHeader.fldDate)+' '+cast(cast(tblCalcHeader.fldDate as time(0)) as varchar(5))fldTarikh,fldCalcType
		,case when fldCalcType=1 then N'محاسبات حقوق' else N'محاسبات عیدی' end  as fldCalcTypeName
		FROM   [Pay].[tblCalcHeader] 
		inner join com.tblUser as u on u.fldId=tblCalcHeader.fldUserId
		inner join com.tblOrganization on com.tblOrganization.fldId=tblCalcHeader.fldOrganId
		left outer join com.tblEmployee as p on p.fldId=u.fldEmployId  
	)t
	order by fldId desc
	COMMIT
GO
