SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_organIdWithPayPersonal](@PersonalId INT)
RETURNS INT
AS
BEGIN
DECLARE @id int,@OrganId INT
	SELECT @id= tblChartOrgan.fldId   
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId=tblOrganizationalPosts.fldId
                      INNER JOIN Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId=tblChartOrgan.fldId
                      WHERE Pay.Pay_tblPersonalInfo.fldId=@PersonalId

;WITH temp AS (
SELECT fldId,fldOrganId,fldTitle,fldPId FROM Com.tblChartOrgan
WHERE fldId=@Id
UNION ALL
SELECT       c.fldid, c.fldOrganId,c.fldTitle,c.fldPId
FROM           temp AS t INNER JOIN
                         Com.tblChartOrgan AS c ON t.fldPId = c.fldId
						
          )   
SELECT @organid=temp.fldOrganId FROM temp 
WHERE temp.fldOrganId IS NOT NULL   

RETURN @OrganId

END
GO
