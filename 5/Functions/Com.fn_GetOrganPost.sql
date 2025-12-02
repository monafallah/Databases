SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_GetOrganPost](@Id INT)
RETURNS @t TABLE (Id INT,PID INT,title NVARCHAR(150),Namechart NVARCHAR(150),fldOrgPostCode NVARCHAR(50))
AS
BEGIN
--DECLARE @organId INT
--SELECT @organId=fldOrganId FROM Com.tbluser WHERE fldid=@UserId
--DECLARE @t TABLE (Id INT,PID INT)
--INSERT INTO @t( Id, PID )
--SELECT fldId,fldPId FROM Com.tblOrganization WHERE fldid=@organId
INSERT INTO @t
        ( Id, PID,title ,Namechart,fldOrgPostCode)
SELECT        Com.tblOrganizationalPosts.fldId, Com.tblOrganizationalPosts.fldPID, Com.tblOrganizationalPosts.fldTitle, Com.tblChartOrgan.fldTitle AS Expr1
,fldOrgPostCode
FROM            Com.tblOrganizationalPosts INNER JOIN
                         Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId
						  WHERE tblOrganizationalPosts.fldPid=@Id 

RETURN
end
GO
