SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Pay].[spr_AfradTahtePoosheshSelect_FromExcel]
@Codemeli nvarchar(max),
@BimeId int,
@UserId int
as
begin tran
--declare @Codemeli nvarchar(max)='4590295563;4580019230;111111;2222;',@BimeId int=14,@UserId int=1
declare @NewTable table( id int)
declare @fldID int 
	select @fldID =ISNULL(max(fldId),0) from [Pay].[tblAfradeTahtePoshesheBimeTakmily] 
	INSERT INTO [Pay].[tblAfradeTahtePoshesheBimeTakmily] ([fldId], [fldPersonalId], [fldTedadAsli], [fldTedadTakafol60Sal], [fldTedadTakafol70Sal], [fldGHarardadBimeId], [fldUserId], [fldDesc], [fldDate])
	 OUTPUT inserted.fldId INTO @NewTable(ID)
	select @fldID+ROW_NUMBER() over (order by fldPay_PersonalId), fldPay_PersonalId,[asli]+1 as asli,[shast],[haftad],@BimeId as BimeId,@UserId,N'',getdate() from(
	select fldPay_PersonalId,case when fldAge<60 then N'asli' when fldAge>=60 and fldAge<70 then N'shast' when fldAge>=70 then N'haftad' else N'' end as s
	from(select pay.fldId as fldPay_PersonalId,datediff(year,t.flddate,getdate()) as fldAge
	FROM     Pay.Pay_tblPersonalInfo as pay 
	INNER JOIN Prs.Prs_tblPersonalInfo as prs ON pay.fldPrs_PersonalInfoId = prs.fldId 
	inner join com.tblEmployee as e on e.fldId=prs.fldEmployeeId
	inner join [Prs].[tblAfradTahtePooshesh] as a on prs.fldId=a.fldPersonalId
	inner join com.tblDateDim as t on t.fldTarikh=a.fldBirthDate 
	cross apply(select Item as fldCodemeli from com.Split(@Codemeli,';') where Item<>'' and e.fldCodemeli COLLATE SQL_Latin1_General_CP1_CI_AS=Item)c

	--where Item<>'' and )
	where /*e.fldCodemeli=@Codemeli and */  not exists(select * from [Pay].[tblAfradeTahtePoshesheBimeTakmily] as b where pay.fldid = b.fldPersonalId and b.fldGHarardadBimeId=@BimeId )
					  )t)t2
					  pivot (
					  count(s) for s in  ([asli],[haftad],[shast]))
					  p
					 
if (@@ERROR<>0)
		ROLLBACK
	else
	begin
		declare @fldDetailID int 
	select @fldDetailID =ISNULL(max(fldId),0) from [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] 

	INSERT INTO [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details] ([fldId], [fldAfradTahtePoshehsId], [fldBimeTakmiliId], [fldUserId], [fldDesc], [fldDate])
	select @fldDetailID+ROW_NUMBER() over(order by a.fldid),a.fldId,b.fldId,@UserId,N'',getdate()
	FROM     Pay.Pay_tblPersonalInfo as pay 
	INNER JOIN [Pay].[tblAfradeTahtePoshesheBimeTakmily] as b ON pay.fldid = b.fldPersonalId 
	inner join [Prs].[tblAfradTahtePooshesh] as a on pay.fldPrs_PersonalInfoId=a.fldPersonalId 
	where b.fldId in (select id from @NewTable)
	if(@@Error<>0)
        rollback   

	end
select stuff((	select ', '+Item from com.Split(@Codemeli,';')
	where Item<>'' and not exists (select * from com.tblEmployee as e where e.fldCodemeli COLLATE SQL_Latin1_General_CP1_CI_AS=Item)
	for xml path('')),1,1,'') as fldCodemeli 

	
	
commit tran
GO
