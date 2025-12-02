SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_GetOrganPostEjra](@Id INT)
RETURNS @t TABLE (Id INT,PID INT,title NVARCHAR(150),NameChart NVARCHAR(150),fldOrgPostCode NVARCHAR(50))
AS
BEGIN
--DECLARE @organId INT
--SELECT @organId=fldOrganId FROM Com.tbluser WHERE fldid=@UserId
--DECLARE @t TABLE (Id INT,PID INT)
--INSERT INTO @t( Id, PID )
--SELECT fldId,fldPId FROM Com.tblOrganization WHERE fldid=@organId
INSERT INTO @t
        ( Id, PID,title,NameChart,fldOrgPostCode )
SELECT        Com.tblOrganizationalPostsEjraee.fldId, Com.tblOrganizationalPostsEjraee.fldPID, Com.tblOrganizationalPostsEjraee.fldTitle, Com.tblChartOrganEjraee.fldTitle AS Expr1
,fldOrgPostCode
FROM            Com.tblOrganizationalPostsEjraee INNER JOIN
                         Com.tblChartOrganEjraee ON Com.tblOrganizationalPostsEjraee.fldChartOrganId = Com.tblChartOrganEjraee.fldId
						 WHERE tblOrganizationalPostsEjraee.fldPid=@Id 

RETURN
end
GO
