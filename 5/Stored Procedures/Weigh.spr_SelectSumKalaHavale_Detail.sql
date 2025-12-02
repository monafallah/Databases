SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Weigh].[spr_SelectSumKalaHavale_Detail](@fieldname nvarchar(50),@value nvarchar(50),@idHavale int,@idKala int)
as 
if (@fieldname='')
SELECT v.[fldId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali]
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali
	,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance

	
	where fldRemittanceId=@idHavale and fldKalaId =@idKala
	and fldEbtal=0


if (@fieldname='fldId')
SELECT v.[fldId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali]
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali
	,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance

	
	where fldRemittanceId=@idHavale and fldKalaId =@idKala
	and fldEbtal=0 and v.fldid=@value

if (@fieldname='fldVaznKol')
SELECT v.[fldId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali]
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali
	,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance

	
	where fldRemittanceId=@idHavale and fldKalaId =@idKala
	and fldEbtal=0 and fldVaznKol like @value

if (@fieldname='fldVaznKhals')
SELECT v.[fldId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali]
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali
	,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance

	
	where fldRemittanceId=@idHavale and fldKalaId =@idKala
	and fldEbtal=0 and fldVaznKhals like @value


if (@fieldname='fldNameRanande')
SELECT  * from (select v.[fldId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali]
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali
	,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance

	
	where fldRemittanceId=@idHavale and fldKalaId =@idKala
	and fldEbtal=0) t
	where fldNameRanande like @value


if (@fieldname='fldNameKala')
SELECT * from (select v.[fldId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali]
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali
	,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance

	
	where fldRemittanceId=@idHavale and fldKalaId =@idKala
	and fldEbtal=0) t
	where fldNameKala like @value


	if (@fieldname='fldTarikhVaznKhali')
SELECT * from (select v.[fldId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali]
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali
	,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance

	
	where fldRemittanceId=@idHavale and fldKalaId =@idKala
	and fldEbtal=0) t
	where fldTarikhVaznKhali like @value





if (@fieldname='fldNamePlace')
SELECT * from (select v.[fldId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali]
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali
	,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance

	
	where fldRemittanceId=@idHavale and fldKalaId =@idKala
	and fldEbtal=0) t
	where fldNamePlace like @value



	if (@fieldname='fldPlaque')
SELECT * from (select  v.[fldId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali]
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali
	,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance

	
	where fldRemittanceId=@idHavale and fldKalaId =@idKala
	and fldEbtal=0)t
	where fldPlaque like @value 



	if (@fieldname='fldTarikh_TimeTozin')
SELECT * from (select v.[fldId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali]
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali
	,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance

	
	where fldRemittanceId=@idHavale and fldKalaId =@idKala
	and fldEbtal=0)t
	where fldTarikh_TimeTozin like @value 



	if (@fieldname='fldVaznKhali')
SELECT  * from (select v.[fldId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali]
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali
	,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance

	
	where fldRemittanceId=@idHavale and fldKalaId =@idKala
	and fldEbtal=0)t
	where fldVaznKhali like @value 



	if (@fieldname='fldNameKhodro')
SELECT * from (select  v.[fldId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali]
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali
	,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance

	
	where fldRemittanceId=@idHavale and fldKalaId =@idKala
	and fldEbtal=0) t
	where fldNameKhodro like @value 



	if (@fieldname='fldNameHavale')
SELECT  * from (select v.[fldId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali]
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali
	,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance

	
	where fldRemittanceId=@idHavale and fldKalaId =@idKala
	and fldEbtal=0) t
	where fldNameHavale like @value 


	if (@fieldname='fldNameBaskool')
SELECT * from (select  v.[fldId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali]
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali
	,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance

	
	where fldRemittanceId=@idHavale and fldKalaId =@idKala
	and fldEbtal=0) t
	where fldNameBaskool like @value 

	if (@fieldname='fldCodeMeliRanande')
SELECT v.[fldId], [fldVaznKol], [fldVaznKhals], [fldRemittanceId], [fldTarikhVaznKhali]
	,e.fldName collate  SQL_Latin1_General_CP1_CI_AS +' '+ fldFamily collate  SQL_Latin1_General_CP1_CI_AS  as fldNameRanande,isnull(k.fldName,'') as fldNameKala ,isnull(l.fldName,'') as  fldNamePlace,cast(fldSerialPlaque as varchar(10))+' '+ fldPlaque  as fldPlaque
	,cast(cast(fldDateTazin  as time(0))as varchar(8))+' '+ d.fldTarikh as fldTarikh_TimeTozin,case when fldispor =0 then N'خالی' else N'پر' end as fldIsporName
	,fldVaznKol-fldVaznKhals as fldVaznKhali
	,t.fldName as fldNameKhodro,isnull(h.fldtitle,'') as fldNameHavale,w.fldName as fldNameBaskool,e.fldCodemeli as fldCodeMeliRanande
	FROM   [Weigh].[tblVazn_Baskool] v
	inner join Com.tblEmployee e on e.fldid =fldRananadeId
	inner join com.tblPlaque p on p.fldid=fldPluqeId
	inner join com.tblDateDim d on cast(fldDateTazin as date)=d.fldDate
	inner join com.tblTypeKhodro t on t.fldid=fldtypekhodroId
	inner join Weigh.tblWeighbridge w on w.fldid=fldBaskoolId
	inner join Weigh.tblRemittance_Header h on h.fldid=v.fldRemittanceId
	left join com.tblKala k on k.fldid=fldKalaId
	left join Weigh.tblLoadingPlace l on l.fldid=fldLoadingPlaceId
	left join Weigh.tblNoeMasraf n on n.fldId=fldNoeMasrafId
	outer apply (select fldMaxTon from Weigh.tblRemittance_Details  r
				where r.fldRemittanceId=v.fldRemittanceId and r.fldKalaId=v.fldKalaId  
				
				)Remittance

	
	where fldRemittanceId=@idHavale and fldKalaId =@idKala
	and fldEbtal=0 and fldCodeMeli like @value 
	 

	
GO
