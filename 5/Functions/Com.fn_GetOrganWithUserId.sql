SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_GetOrganWithUserId](@organId INT)
RETURNS @t TABLE (Id INT,PID INT)
AS
BEGIN
--DECLARE @organId INT
--SELECT @organId=fldOrganId FROM Com.tbluser WHERE fldid=@UserId
--DECLARE @t TABLE (Id INT,PID INT)
--INSERT INTO @t( Id, PID )
--SELECT fldId,fldPId FROM Com.tblOrganization WHERE fldid=@organId
INSERT INTO @t
        ( Id, PID )
SELECT fldid,fldPId FROM Com.tblOrganization WHERE fldPid=@organId 

RETURN
end
GO
