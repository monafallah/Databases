SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKarKardHokmSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 NVARCHAR(50),
	@KarkardId int,
	@Roze decimal(4, 1),
	@Gheybat decimal(4, 1),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldKarkardId], [fldHokmId], [fldRoze],fldGheybat 
	FROM   [Pay].[tblKarKardHokm] 
	WHERE  fldId = @Value
	

	if (@fieldname=N'fldHokmId_KarkardId')
	SELECT top(@h) [fldId], [fldKarkardId], [fldHokmId], [fldRoze] ,fldGheybat 
	FROM   [Pay].[tblKarKardHokm] 
	WHERE  fldHokmId = @Value and fldKarkardId=@KarkardId

	if (@fieldname=N'fldKarkardId_Formul')
	SELECT top(@h) [fldId], [fldKarkardId], [fldHokmId], [fldRoze] ,fldGheybat 
	FROM   [Pay].[tblKarKardHokm] 
	WHERE   fldKarkardId=@KarkardId

	if (@fieldname=N'fldKarkardId')
	begin
		declare @day varchar(3)='',@id int=0
		select @id=fldPrs_PersonalInfoId from pay.Pay_tblPersonalInfo where fldid=@Value

		select top(1) @day= case when a.fldNoeEstekhdamId=1 and SUBSTRING(@Value2,6,2)<=6 then 31  when a.fldNoeEstekhdamId=1 and SUBSTRING(@Value2,6,2)=12 then 29 else 30 end  from prs.tblPersonalHokm  as p
		inner join com.tblAnvaEstekhdam as a on a.fldId=p.fldAnvaeEstekhdamId 
		WHERE  p.fldPrs_PersonalInfoId like @id AND fldTarikhEjra<=@Value2+'/31' and   fldStatusHokm=1
		ORDER BY fldTarikhSodoor DESC,fldTarikhEjra DESC


	select  isnull([fldId],0) as fldId,isnull( [fldKarkardId],0)[fldKarkardId], [fldHokmId]
		,case when @h=1 then fldRoze else  (cast( cast((DATEDIFF(day,dbo.Fn_AssembelyShamsiToMiladiDate(fldTarikhEjra) ,dbo.Fn_AssembelyShamsiToMiladiDate( isnull((lead(fldTarikhEjra) over (order by fldTarikhEjra)),dbo.Fn_AssembelyMiladiToShamsi(dateadd(day,1, dbo.Fn_AssembelyShamsiToMiladiDate(@Value2+'/'+@day)))))))*@Roze*1.0/@day as decimal(4,1)) as varchar(5))) end as fldRoze
		,case when @h=1 then fldGheybat else (cast( cast((DATEDIFF(day,dbo.Fn_AssembelyShamsiToMiladiDate(fldTarikhEjra) ,dbo.Fn_AssembelyShamsiToMiladiDate( isnull((lead(fldTarikhEjra) over (order by fldTarikhEjra)),dbo.Fn_AssembelyMiladiToShamsi(dateadd(day,1, dbo.Fn_AssembelyShamsiToMiladiDate(@Value2+'/'+@day)))))))*@Gheybat*1.0/@day as decimal(4,1)) as varchar(5)))end as fldGheybat  
		from (
	select * from(
		select top(1) @Value2+'/01' as fldTarikhEjra	
		,k.[fldId], [fldKarkardId],isnull(k.fldHokmId,p.fldId) as [fldHokmId], [fldRoze],fldGheybat
		from  Prs.tblPersonalHokm as p 
		left join [Pay].[tblKarKardHokm]  as k on k.fldHokmId=p.fldId and  k.fldKarkardId=@KarkardId
		WHERE  p.fldPrs_PersonalInfoId = @id AND fldTarikhEjra<=@Value2+'/01' and   fldStatusHokm=1
		ORDER BY fldTarikhSodoor DESC,fldTarikhEjra DESC)t
		union
		select P.fldTarikhEjra,k.[fldId], [fldKarkardId],isnull(k.fldHokmId,p.fldId) as [fldHokmId], [fldRoze],fldGheybat
		from  Prs.tblPersonalHokm as p 
				  left join [Pay].[tblKarKardHokm]  as k on k.fldHokmId=p.fldId and  k.fldKarkardId=@KarkardId
		WHERE fldPrs_PersonalInfoId=@id and  fldTarikhEjra<=@Value2 + '/31' and fldStatusHokm=1 and 
         fldTarikhEjra>@Value2 + '/01' and
           p.fldTarikhSodoor in (select t.fldTarikhSodoor from(select max(fldTarikhSodoor) as fldTarikhSodoor, fldTarikhEjra FROM  Prs.tblPersonalHokm  
           WHERE fldPrs_PersonalInfoId=@id and  fldTarikhEjra<=@Value2 + '/31' and fldStatusHokm=1 
          group by fldTarikhEjra)t)
		  )t2

		
	end
	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldKarkardId], [fldHokmId], [fldRoze],fldGheybat  
	FROM   [Pay].[tblKarKardHokm] 

	COMMIT
GO
