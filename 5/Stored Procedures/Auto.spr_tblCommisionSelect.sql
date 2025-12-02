SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblCommisionSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganID INT,
	@h int
AS 
	BEGIN TRAN
	SET @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT   TOP(@h)   Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblAshkhaseHoghoghi.fldName AS fldName,N'شخص حقوقی' AS fldTypeShakhs, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_Title
					 ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,cast('' as nvarchar(100)) as fldFatherName
					 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
	WHERE  Auto.tblCommision.fldId = @Value AND fldOrganID=@fldOrganID
	
	 UNION
 
SELECT TOP(@h)    Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily AS fldName,N'شخص حقیقی' AS fldTypeShakhs, Com.tblEmployee.fldCodemeli AS fldCodemelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_title
					  ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,isnull(fldFatherName,'')fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
					  left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
					  
                      WHERE  Auto.tblCommision.fldId = @Value AND fldOrganID=@fldOrganID


if (@fieldname=N'HaveSign')
begin
 declare @Tarikh nvarchar(10)=dbo.Fn_AssembelyMiladiToShamsi(getdate())
	SELECT   TOP(@h)   Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblAshkhaseHoghoghi.fldName AS fldName,N'شخص حقوقی' AS fldTypeShakhs, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_Title
					 ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,cast('' as nvarchar(100)) as fldFatherName
					 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
	WHERE fldEndDate >= @Tarikh and fldSign=1 AND fldOrganID=@fldOrganID
	
	 UNION
 
SELECT TOP(@h)    Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily AS fldName,N'شخص حقیقی' AS fldTypeShakhs, Com.tblEmployee.fldCodemeli AS fldCodemelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_title
					  ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,isnull(fldFatherName,'')fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
					  left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
					 
                  WHERE fldEndDate >= @Tarikh and fldSign=1 AND fldOrganID=@fldOrganID


end
	if (@fieldname=N'fldDesc')
	SELECT  TOP(@h)   Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblAshkhaseHoghoghi.fldName AS fldName,N'شخص حقوقی' AS fldTypeShakhs, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_Title
					  ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,cast('' as nvarchar(100)) as fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId 
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh

	WHERE Auto.tblCommision.fldDesc like  @Value AND fldOrganID=@fldOrganID
 
 UNION
                 
   SELECT  TOP(@h)   Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily AS fldName,N'شخص حقیقی' AS fldTypeShakhs, Com.tblEmployee.fldCodemeli AS fldCodemelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_title
					,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,isnull(fldFatherName,'')fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
					    left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
						
                      WHERE Auto.tblCommision.fldDesc like  @Value AND fldOrganID=@fldOrganID



	if (@fieldname=N'UserKartabls')
begin
 declare @shakhsid int
select @shakhsid=fldEmployId from com.tbluser
 where fldid=@value
                
    SELECT  TOP(@h)   Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily AS fldName,N'شخص حقیقی' AS fldTypeShakhs, Com.tblEmployee.fldCodemeli AS fldCodemelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_title
					 ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,cast('' as nvarchar(100)) as fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
					    left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
						
					  where tblEmployee.fldid=@shakhsid and  Auto.tblCommision.fldOrganID =@fldOrganID-- and d.fldDate>=cast(getdate() as date)
					  order by fldEndDate desc

end




	if (@fieldname=N'')
SELECT TOP(@h)    Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblAshkhaseHoghoghi.fldName AS fldName,N'شخص حقوقی' AS fldTypeShakhs, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_Title
						,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,cast('' as nvarchar(100)) as fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
    UNION
                
    SELECT  TOP(@h)   Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily AS fldName,N'شخص حقیقی' AS fldTypeShakhs, Com.tblEmployee.fldCodemeli AS fldCodemelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_title
						,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,isnull(fldFatherName,'')fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
					    left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
						
                      
                      
        
        
        
        
        
                      
 
 	if (@fieldname=N'fldAshkhasID')
	SELECT   TOP(@h)  Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblAshkhaseHoghoghi.fldName AS fldName,N'شخص حقوقی' AS fldTypeShakhs, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_Title
					  ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,cast('' as nvarchar(100)) as fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
                      
                      WHERE Auto.tblCommision.fldAshkhasID=@value and  Auto.tblCommision.fldOrganID =@fldOrganID
	 UNION 
                 
SELECT  TOP(@h)   Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily AS fldName,N'شخص حقیقی' AS fldTypeShakhs, Com.tblEmployee.fldCodemeli AS fldCodemelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_title
					  ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,isnull(fldFatherName,'')fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
                        left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
						
                      WHERE Auto.tblCommision.fldAshkhasID=@value and  Auto.tblCommision.fldOrganID =@fldOrganID
                      
                      
          
          
                      
                      
  
 	if (@fieldname=N'fldOrganizPostEjraeeID')
	SELECT   TOP(@h)  Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblAshkhaseHoghoghi.fldName AS fldName,N'شخص حقوقی' AS fldTypeShakhs, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_Title
					  ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,cast('' as nvarchar(100)) as fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
	WHERE  Auto.tblCommision.fldOrganizPostEjraeeID = @Value 
	 UNION
                
SELECT   TOP(@h)  Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily AS fldName,N'شخص حقیقی' AS fldTypeShakhs, Com.tblEmployee.fldCodemeli AS fldCodemelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_title
					  ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,isnull(fldFatherName,'')fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
					    left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
						
                      WHERE  Auto.tblCommision.fldOrganizPostEjraeeID = @Value  
                      
                      
      
      
      
                      
   if (@fieldname=N'fldOrganID')
	SELECT  TOP(@h)   Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblAshkhaseHoghoghi.fldName AS fldName,N'شخص حقوقی' AS fldTypeShakhs, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_Title
					  ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,cast('' as nvarchar(100)) as fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
	WHERE  Auto.tblCommision.fldOrganID =@fldOrganID
	 UNION
              
  SELECT  TOP(@h)   Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily AS fldName,N'شخص حقیقی' AS fldTypeShakhs, Com.tblEmployee.fldCodemeli AS fldCodemelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_title
					  ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,isnull(fldFatherName,'')fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
					    left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
					
                      WHERE  Auto.tblCommision.fldOrganID = @fldOrganID 
                      
                      
             
                      
                      
  
  	if (@fieldname=N'fldAshkhas_OrganPost')
	SELECT  TOP(@h)   Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblAshkhaseHoghoghi.fldName AS fldName,N'شخص حقوقی' AS fldTypeShakhs, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_Title
					  ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,cast('' as nvarchar(100)) as fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
	WHERE Auto.tblCommision.fldAshkhasID LIKE  @Value AND fldOrganizPostEjraeeID=@fldOrganID
	 UNION
             
SELECT   TOP(@h)  Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily AS fldName,N'شخص حقیقی' AS fldTypeShakhs, Com.tblEmployee.fldCodemeli AS fldCodemelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_title
					  ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,isnull(fldFatherName,'')fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
					    left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
						
                      WHERE Auto.tblCommision.fldAshkhasID like  @Value AND fldOrganizPostEjraeeID=@fldOrganID                                                         

  
  
  
  
  
  if (@fieldname=N'fldUserID')
	SELECT TOP(@h)    Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblAshkhaseHoghoghi.fldName AS fldName,N'شخص حقوقی' AS fldTypeShakhs, Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_Title
					  ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,cast('' as nvarchar(100)) as fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblAshkhas.fldHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
	WHERE  Auto.tblCommision.fldUserID =@Value
	 UNION
            
SELECT  TOP(@h)   Auto.tblCommision.fldID, Auto.tblCommision.fldAshkhasID, Auto.tblCommision.fldOrganizPostEjraeeID, Auto.tblCommision.fldStartDate, Auto.tblCommision.fldEndDate, 
                      Auto.tblCommision.fldOrganicNumber, Auto.tblCommision.fldOrganID, Auto.tblCommision.fldDate, Auto.tblCommision.fldUserID, Auto.tblCommision.fldDesc, 
                      Auto.tblCommision.fldIP, Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily AS fldName,N'شخص حقیقی' AS fldTypeShakhs, Com.tblEmployee.fldCodemeli AS fldCodemelli, Com.tblOrganizationalPostsEjraee.fldTitle AS fldO_postEjraee_title
					  ,case when d.fldDate>=cast(getdate() as date) then '1' else '0' end fldActive,isnull(fldFatherName,'')fldFatherName
	 ,fldSign,case when fldsign=1 then N'دارد' else N'ندارد' end as fldSignName
FROM         Auto.tblCommision INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId AND 
                      Auto.tblCommision.fldOrganizPostEjraeeID = Com.tblOrganizationalPostsEjraee.fldId
					  inner join com.tblDatedim d on fldEndDate=d.fldTarikh
					    left join com.tblEmployee_Detail on fldEmployeeId=fldHaghighiId
						
                      WHERE  Auto.tblCommision.fldUserId = @Value                                         

	COMMIT
GO
