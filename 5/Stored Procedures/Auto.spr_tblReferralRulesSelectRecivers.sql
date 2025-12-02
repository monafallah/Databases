SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Auto].[spr_tblReferralRulesSelectRecivers](@fieldname nvarchar(50),@Value nvarchar(50),	@h as int,@fldCommisionId int
)
	as
	--select 0 fldid,'' fldReceiverComisionName,1 fldType,''fldId_Type
declare @organpost int,@organId int
select  @organpost=fldOrganizPostEjraeeID,@organId=fldOrganID from auto.tblCommision
where fldid=@fldCommisionId



declare @temp table (id int)
declare @tarikh nvarchar(10) =dbo.Fn_AssembelyMiladiToShamsi(getdate())
;with ReferralRule as 
(
	select [fldPostErjaGirandeId],[fldChartEjraeeGirandeId] from [Auto].[tblReferralRules]
	where [fldPostErjaDahandeId]=@organpost
)
, girande as
(
	select fldChartEjraeeGirandeId fldid,fldPId from ReferralRule
	inner join com.tblChartOrganEjraee c on fldChartEjraeeGirandeId=c.fldid
	where fldPostErjaGirandeId is null
	union all
	select tblChartOrganEjraee.fldid,tblChartOrganEjraee.fldPId from com.tblChartOrganEjraee
	inner join girande on  girande.fldid=tblChartOrganEjraee.fldpid

)
,posts as 
(
	select tblOrganizationalPostsEjraee.fldid,fldTitle from com.tblOrganizationalPostsEjraee
	inner join girande on fldChartOrganId=girande.fldid
	
	
)
insert @temp
select fldid from posts

if (@fieldname='')
begin
if not exists (select * from [Auto].[tblReferralRules] where [fldPostErjaDahandeId]=@organpost)
select * from (SELECT   Auto.tblCommision.fldid , Com.tblEmployee.fldName COLLATE Latin1_General_CS_AS+' '+ Com.tblEmployee.fldFamily COLLATE Latin1_General_CS_AS +'('+ Com.tblOrganizationalPostsEjraee.fldTitle+')' AS fldReceiverComisionName

		 ,1 as fldType, cast(Auto.tblCommision.fldId  as varchar(10))+'|1' fldId_Type
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId			 
					  left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
where tblCommision.fldid<>@fldCommisionId and tblCommision.fldorganid=@OrganId and fldEndDate>=@tarikh

union all 
	select fldid,fldname,2 as fldtype,cast(fldId  as varchar(10))+'|2' fldId_Type from  auto.tblAshkhaseHoghoghiTitles
)t
group by fldid,fldReceiverComisionName,fldtype,fldId_Type
else

select * from (SELECT    Auto.tblCommision.fldid , Com.tblEmployee.fldName COLLATE Latin1_General_CS_AS+' '+ Com.tblEmployee.fldFamily COLLATE Latin1_General_CS_AS +'('+ Com.tblOrganizationalPostsEjraee.fldTitle+')' AS fldReceiverComisionName

		 ,1 as fldType, cast(Auto.tblCommision.fldId  as varchar(10))+'|1' fldId_Type
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId			 
					 left join @temp posts on posts.id=fldOrganizPostEjraeeID
					
					  left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
					  where  tblCommision.fldorganid=@OrganId and fldEndDate>=@tarikh
					 

union all 

SELECT    Auto.tblCommision.fldId , Com.tblEmployee.fldName COLLATE Latin1_General_CS_AS+' '+ Com.tblEmployee.fldFamily COLLATE Latin1_General_CS_AS+'('+ Com.tblOrganizationalPostsEjraee.fldTitle+')' AS fldRecieverComisionName

		 ,1 as fldtype, cast(Auto.tblCommision.fldId  as varchar(10))+'|1' fldId_Type
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId			 
					 outer apply (select tblOrganizationalPostsEjraee.fldid,fldTitle from Auto.[tblReferralRules]
						inner join com.tblOrganizationalPostsEjraee on fldPostErjaGirandeId=tblOrganizationalPostsEjraee.fldid
						where fldChartEjraeeGirandeId is null )post
					  left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
					  where  tblCommision.fldorganid=@OrganId and post.fldid=fldOrganizPostEjraeeID and fldEndDate>=@tarikh 
union all 
	select fldid,fldname,2 as fldtype,cast(fldId  as varchar(10))+'|2' fldId_Type from  auto.tblAshkhaseHoghoghiTitles	

)t
group by fldid,fldReceiverComisionName,fldtype,fldId_Type
end	
if (@fieldname='fldReceiverComisionName')
begin
if not exists (select * from [Auto].[tblReferralRules] where [fldPostErjaDahandeId]=@organpost)
SELECT * from (select   Auto.tblCommision.fldid , Com.tblEmployee.fldName COLLATE Latin1_General_CS_AS+' '+ Com.tblEmployee.fldFamily COLLATE Latin1_General_CS_AS +'('+ Com.tblOrganizationalPostsEjraee.fldTitle+')' AS fldReceiverComisionName

		 ,1 as fldType, cast(Auto.tblCommision.fldId  as varchar(10))+'|1' fldId_Type
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId			 
					  left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
where tblCommision.fldid<>@fldCommisionId and tblCommision.fldorganid=@OrganId and fldEndDate>=@tarikh

union all 
	select fldid,fldname,2 as fldtype,cast(fldId  as varchar(10))+'|2' fldId_Type from  auto.tblAshkhaseHoghoghiTitles	)t
	where  fldReceiverComisionName like @value 	
	
	group by fldid,fldReceiverComisionName,fldtype,fldId_Type
	else


SELECT * from (select    Auto.tblCommision.fldid , Com.tblEmployee.fldName COLLATE Latin1_General_CS_AS +' '+ Com.tblEmployee.fldFamily COLLATE Latin1_General_CS_AS+'('+ Com.tblOrganizationalPostsEjraee.fldTitle+')' AS fldReceiverComisionName

		 ,1 as fldType, cast(Auto.tblCommision.fldId  as varchar(10))+'|1' fldId_Type
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId			 
					 left join @temp posts on posts.id=fldOrganizPostEjraeeID
					
					  left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
					  where  tblCommision.fldorganid=@OrganId and fldEndDate>=@tarikh
					 

union all 

SELECT    Auto.tblCommision.fldId , Com.tblEmployee.fldName COLLATE Latin1_General_CS_AS+' '+ Com.tblEmployee.fldFamily COLLATE Latin1_General_CS_AS+'('+ Com.tblOrganizationalPostsEjraee.fldTitle+')' AS fldRecieverComisionName

		 ,1 as fldtype, cast(Auto.tblCommision.fldId  as varchar(10))+'|1' fldId_Type
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId			 
					 outer apply (select tblOrganizationalPostsEjraee.fldid,fldTitle from Auto.[tblReferralRules]
						inner join com.tblOrganizationalPostsEjraee on fldPostErjaGirandeId=tblOrganizationalPostsEjraee.fldid
						where fldChartEjraeeGirandeId is null )post
					  left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
					  where  tblCommision.fldorganid=@OrganId and post.fldid=fldOrganizPostEjraeeID and fldEndDate>=@tarikh 
union all 
	select fldid,fldname,2 as fldtype,cast(fldId  as varchar(10))+'|2' fldId_Type from auto.tblAshkhaseHoghoghiTitles
	)t
	where fldReceiverComisionName like @value 	
	group by fldid,fldReceiverComisionName,fldtype,fldId_Type
end				  
GO
