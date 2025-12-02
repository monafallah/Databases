SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_OrganId] (@PersonalId INT)
RETURNS INT
AS
BEGIN
DECLARE @Id INT,@organid INT
--IF(@fieldName='Prs_PersonalId')
SELECT   @Id=  tblChartOrgan.fldId
FROM         Com.tblOrganizationalPosts INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId INNER JOIN
                      prs.Prs_tblPersonalInfo ON Com.tblOrganizationalPosts.fldId = Prs_tblPersonalInfo.fldOrganPostId
WHERE prs.Prs_tblPersonalInfo.fldId=@PersonalId

;WITH temp AS (
SELECT fldId,fldOrganId,fldTitle,fldPId FROM Com.tblChartOrgan
WHERE fldId=@Id
UNION ALL
SELECT       c.fldid, c.fldOrganId,c.fldTitle,c.fldPId
FROM           temp AS t INNER JOIN
                         Com.tblChartOrgan AS c ON t.fldPId = c.fldId
						 where t.fldOrganId is null
          )   
SELECT @organid=temp.fldOrganId FROM temp 
WHERE temp.fldOrganId IS NOT NULL   

--IF(@fieldName='Pay_PersonalId')
--SELECT   @Id=  tblChartOrgan.fldOrganId
--FROM         Com.tblOrganizationalPosts INNER JOIN
--                      Com.tblChartOrgan AS tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId INNER JOIN
--                      Prs_tblPersonalInfo ON Com.tblOrganizationalPosts.fldId = Prs_tblPersonalInfo.fldOrganPostId
--WHERE Prs_tblPersonalInfo.fldId IN (SELECT fldPrs_PersonalInfoId FROM Pay.tblPersonalInfo WHERE fldid=@PersonalId)
RETURN @organid
end
GO
