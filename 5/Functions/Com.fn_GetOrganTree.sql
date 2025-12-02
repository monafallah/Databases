SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_GetOrganTree](@Userid INT)
RETURNS @temp TABLE(Id INT,PID int)
AS
BEGIN
--DECLARE @userId INT=2
DECLARE  @organId INT
--SELECT @organId=fldOrganId FROM Com.tblUser WHERE fldid=@userId


--DECLARE @temp TABLE(Id INT,PID int)
INSERT INTO @temp
SELECT fldId,fldPId FROM Com.tblOrganization WHERE fldId IN  (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@Userid) ))

--SELECT * FROM fn_GetOrganWithUserId(@organId)
INSERT INTO @temp
	SELECT * FROM fn_GetOrganWithUserId(@organId)
DECLARE c CURSOR FOR
SELECT * FROM @temp
WHERE PID IS NOT NULL
OPEN c
DECLARE @Id int, @PID INT
FETCH NEXT FROM c INTO @Id,@PID
WHILE @@FETCH_STATUS=0
BEGIN
	INSERT INTO @temp
	SELECT * FROM Com.fn_GetOrganWithUserId(@Id)
	FETCH NEXT FROM c INTO @Id,@PID
END
CLOSE c
DEALLOCATE c

RETURN
END
GO
