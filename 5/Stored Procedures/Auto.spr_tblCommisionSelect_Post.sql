SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Auto].[spr_tblCommisionSelect_Post](@fldId int,@OrganId int)
as 
declare @organpost int
select @organpost=[fldOrganizPostEjraeeID] from [Auto].[tblCommision] where fldid =@fldId and fldorganid=@OrganId

declare @tarikh nvarchar(10) =dbo.Fn_AssembelyMiladiToShamsi(getdate())
if not exists (select * from [Auto].[tblReferralRules] where [fldPostErjaDahandeId]=@organpost)
SELECT    Auto.tblCommision.fldId , Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily AS fldName, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_title
					,isnull(fldFatherName,'')fldFatherName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId			 
					  left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
where tblCommision.fldid<>@fldId and tblCommision.fldorganid=@OrganId and fldEndDate>=@tarikh

else 
begin
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
select * from (SELECT    Auto.tblCommision.fldId , Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily AS fldName, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_title
					,isnull(fldFatherName,'')fldFatherName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId			 
					 left join posts on posts.fldid=fldOrganizPostEjraeeID
					
					  left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
					  where  tblCommision.fldorganid=@OrganId and fldEndDate>=@tarikh and tblCommision.fldid<>@fldId
					  group by  Auto.tblCommision.fldId , Com.tblEmployee.fldName,Com.tblEmployee.fldFamily , Com.tblOrganizationalPostsEjraee.fldTitle 
					,fldFatherName

union all 

SELECT    Auto.tblCommision.fldId , Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily AS fldName, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_title
					,isnull(fldFatherName,'')fldFatherName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId			 
					 outer apply (select tblOrganizationalPostsEjraee.fldid,fldTitle from Auto.[tblReferralRules]
						inner join com.tblOrganizationalPostsEjraee on fldPostErjaGirandeId=tblOrganizationalPostsEjraee.fldid
						where fldChartEjraeeGirandeId is null )post
					  left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
					  where  tblCommision.fldorganid=@OrganId and post.fldid=fldOrganizPostEjraeeID and fldEndDate>=@tarikh and tblCommision.fldid<>@fldId
					  group by  Auto.tblCommision.fldId , Com.tblEmployee.fldName,Com.tblEmployee.fldFamily , Com.tblOrganizationalPostsEjraee.fldTitle 
					,fldFatherName)t

group by fldId,fldName,fldO_postEjraee_title,fldFatherName
end
GO
