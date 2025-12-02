SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblEtelaatEydiGroupSelect]
@fieldname Nvarchar(50),
@sal SMALLINT,
@NobatePardakht TINYINT,
@value NVARCHAR(50),
@OrganId INT,
@CostCenter_Chart INT

AS 

	BEGIN TRAN
	DECLARE @organ TABLE (id int)
	;WITH organ as	(
	SELECT    fldId    
	FROM            Com.tblChartOrganEjraee
	WHERE fldId=@CostCenter_Chart
	UNION ALL
	SELECT t.fldId FROM Com.tblChartOrganEjraee AS t
	INNER JOIN organ ON t.fldPId=organ.fldId
	 )
	 INSERT INTO @organ 
			 ( id )
	 SELECT organ.fldId FROM organ

	if (@fieldname=N'fldEtelaatEydi')
	BEGIN
	IF(@value='')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, 
                      tblEmployee.fldFamily+ '_' + tblEmployee.fldName + ' (' + tblEmployee_Detail.fldFatherName + ')' AS fldName, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali
                        ,isnull((SELECT TOP(1) fldId from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), 0) as  fldEtelaatEydiId 
                        ,isnull((SELECT TOP(1) fldYear from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht), 1393) as  fldYear 
                        ,isnull((SELECT TOP(1) fldDayCount from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), (CASE when Com.fn_IsKabise(@sal)=1 THEN  366 ELSE 365 end)) as  fldDayCount
                        ,isnull((SELECT TOP(1) fldKosurat from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), 0) as  fldKosurat
                        ,isnull((SELECT TOP(1) fldNobatePardakht from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht), 1) as  fldNobatePardakht
                        ,CAST(0 AS bit) AS fldChecked
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldId=tblEmployee_Detail.fldEmployeeId
                      
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId             
      ORDER BY fldFamily,fldName ASC
      else
     SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, 
                      tblEmployee.fldFamily+ '_' + tblEmployee.fldName + ' (' + tblEmployee_Detail.fldFatherName + ')' AS fldName, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali
                        ,isnull((SELECT TOP(1) fldId from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), 0) as  fldEtelaatEydiId 
                        ,isnull((SELECT TOP(1) fldYear from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht), 1393) as  fldYear 
                        ,isnull((SELECT TOP(1) fldDayCount from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), (CASE when Com.fn_IsKabise(@sal)=1 THEN  366 ELSE 365 end)) as  fldDayCount
                        ,isnull((SELECT TOP(1) fldKosurat from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), 0) as  fldKosurat
                        ,isnull((SELECT TOP(1) fldNobatePardakht from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht), 1) as  fldNobatePardakht
                        ,CAST(0 AS bit) AS fldChecked
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldId=tblEmployee_Detail.fldEmployeeId
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND fldCostCenterId=@Value AND  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId               
      
	  ORDER BY fldFamily,fldName ASC
      END
      
	  if (@fieldname=N'CostCenter')
	BEGIN
	IF(@value='')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, 
                      tblEmployee.fldFamily+ '_' + tblEmployee.fldName + ' (' + tblEmployee_Detail.fldFatherName + ')' AS fldName, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali
                        ,isnull((SELECT TOP(1) fldId from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), 0) as  fldEtelaatEydiId 
                        ,isnull((SELECT TOP(1) fldYear from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht), 1393) as  fldYear 
                        ,isnull((SELECT TOP(1) fldDayCount from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), (CASE when Com.fn_IsKabise(@sal)=1 THEN  366 ELSE 365 end)) as  fldDayCount
                        ,isnull((SELECT TOP(1) fldKosurat from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), 0) as  fldKosurat
                        ,isnull((SELECT TOP(1) fldNobatePardakht from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht), 1) as  fldNobatePardakht
                        ,CAST(0 AS bit) AS fldChecked
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldId=tblEmployee_Detail.fldEmployeeId
                      
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId             
      AND Pay.Pay_tblPersonalInfo.fldCostCenterId=@CostCenter_Chart
	  ORDER BY fldFamily,fldName ASC
      else
     SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, 
                      tblEmployee.fldFamily+ '_' + tblEmployee.fldName + ' (' + tblEmployee_Detail.fldFatherName + ')' AS fldName, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali
                        ,isnull((SELECT TOP(1) fldId from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), 0) as  fldEtelaatEydiId 
                        ,isnull((SELECT TOP(1) fldYear from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht), 1393) as  fldYear 
                        ,isnull((SELECT TOP(1) fldDayCount from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), (CASE when Com.fn_IsKabise(@sal)=1 THEN  366 ELSE 365 end)) as  fldDayCount
                        ,isnull((SELECT TOP(1) fldKosurat from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), 0) as  fldKosurat
                        ,isnull((SELECT TOP(1) fldNobatePardakht from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht), 1) as  fldNobatePardakht
                        ,CAST(0 AS bit) AS fldChecked
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldId=tblEmployee_Detail.fldEmployeeId
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND fldCostCenterId=@Value AND  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId               
      AND Pay.Pay_tblPersonalInfo.fldCostCenterId=@CostCenter_Chart
	 ORDER BY fldFamily,fldName ASC
      END
      

	
	  if (@fieldname=N'ChartOrgan')
	BEGIN
	IF(@value='')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, 
                      tblEmployee.fldFamily+ '_' + tblEmployee.fldName + ' (' + tblEmployee_Detail.fldFatherName + ')' AS fldName, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali
                        ,isnull((SELECT TOP(1) fldId from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), 0) as  fldEtelaatEydiId 
                        ,isnull((SELECT TOP(1) fldYear from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht), 1393) as  fldYear 
                        ,isnull((SELECT TOP(1) fldDayCount from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), (CASE when Com.fn_IsKabise(@sal)=1 THEN  366 ELSE 365 end)) as  fldDayCount
                        ,isnull((SELECT TOP(1) fldKosurat from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), 0) as  fldKosurat
                        ,isnull((SELECT TOP(1) fldNobatePardakht from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht), 1) as  fldNobatePardakht
                        ,CAST(0 AS bit) AS fldChecked
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldId=tblEmployee_Detail.fldEmployeeId
                      
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId             
           	AND Prs_tblPersonalInfo.fldOrganPostId IN (SELECT fldId FROM Com.tblOrganizationalPosts WHERE fldChartOrganId IN (SELECT id FROM @organ) AND fldId=Prs_tblPersonalInfo.fldOrganPostId)
	  ORDER BY fldFamily,fldName ASC
      else
     SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, 
                      tblEmployee.fldFamily+ '_' + tblEmployee.fldName + ' (' + tblEmployee_Detail.fldFatherName + ')' AS fldName, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali
                        ,isnull((SELECT TOP(1) fldId from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), 0) as  fldEtelaatEydiId 
                        ,isnull((SELECT TOP(1) fldYear from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht), 1393) as  fldYear 
                        ,isnull((SELECT TOP(1) fldDayCount from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), (CASE when Com.fn_IsKabise(@sal)=1 THEN  366 ELSE 365 end)) as  fldDayCount
                        ,isnull((SELECT TOP(1) fldKosurat from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht ), 0) as  fldKosurat
                        ,isnull((SELECT TOP(1) fldNobatePardakht from Pay.tblEtelaatEydi where Pay.tblEtelaatEydi.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId and fldYear=@sal and  fldNobatePardakht=@NobatePardakht), 1) as  fldNobatePardakht
                        ,CAST(0 AS bit) AS fldChecked
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldId=tblEmployee_Detail.fldEmployeeId
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND fldCostCenterId=@Value AND  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId               
      	AND Prs_tblPersonalInfo.fldOrganPostEjraeeId IN (SELECT fldId FROM Com.tblOrganizationalPostsEjraee WHERE fldChartOrganId IN (SELECT id FROM @organ) AND fldId=Prs_tblPersonalInfo.fldOrganPostEjraeeId)
	  ORDER BY fldFamily,fldName ASC
      end

      	COMMIT
GO
