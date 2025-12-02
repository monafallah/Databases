SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptStatusPersonal](@Type TINYINT,@OrganId INT)
AS
IF(@Type=1)
                      
               SELECT   distinct  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName AS fldName_Family, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                      Pay.Pay_tblPersonalInfo.fldId
                      ,(SELECT     Com.tblStatus.fldTitle
FROM         Com.tblPersonalStatus INNER JOIN
                      Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId
                      WHERE tblPersonalStatus.fldid IN (SELECT top(1) id FROM  [Com].[fn_MaxPersonalStatusTable]( Pay.Pay_tblPersonalInfo .fldid) order by id desc))
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                     wHERE Com.fn_MaxPersonalStatus( Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId


IF(@Type=2)
   SELECT    distinct Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName AS fldName_Family, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                      Pay.Pay_tblPersonalInfo.fldId
                      ,(SELECT     Com.tblStatus.fldTitle
FROM         Com.tblPersonalStatus INNER JOIN
                      Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId
                      WHERE tblPersonalStatus.fldid IN (SELECT toP(1) id FROM  [Com].[fn_MaxPersonalStatusTable]( Pay.Pay_tblPersonalInfo .fldid)  order by id desc))
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                     wHERE Com.fn_MaxPersonalStatus( Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=2 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId


IF(@Type=3)
   SELECT  distinct   Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName AS fldName_Family, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                      Pay.Pay_tblPersonalInfo.fldId
                      ,(SELECT     Com.tblStatus.fldTitle
FROM         Com.tblPersonalStatus INNER JOIN
                      Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId
                      WHERE tblPersonalStatus.fldid IN (SELECT top(1) id FROM  [Com].[fn_MaxPersonalStatusTable]( Pay.Pay_tblPersonalInfo .fldid)  order by id desc))
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                     wHERE Com.fn_MaxPersonalStatus( Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=3 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId

GO
