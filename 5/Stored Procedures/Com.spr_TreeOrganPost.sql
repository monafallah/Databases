SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_TreeOrganPost](@fieldname NVARCHAR(50),@value NVARCHAR(50),@UserId INT)
AS

DECLARE @t TABLE (id INT ,pid INT)
DECLARE @temp TABLE (id INT ,pid int,title NVARCHAR(150),Namechart NVARCHAR(150),fldOrgPostCode NVARCHAR(50))
INSERT @t
        ( id, pid )

SELECT fldId,fldPId FROM Com.tblChartOrgan 
WHERE ( tblChartOrgan.fldUserId=@UserId OR  (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblChartOrgan.fldUserId=@UserId or  [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

INSERT INTO @t
SELECT fldid,fldPId FROM Com.tblChartOrgan WHERE fldPid IN (SELECT id FROM @t) 
	
	
DECLARE c CURSOR FOR
SELECT * FROM @t
WHERE PID IS NOT NULL
OPEN c
DECLARE @Id int, @PID INT
FETCH NEXT FROM c INTO @Id,@PID
WHILE @@FETCH_STATUS=0
BEGIN
	INSERT INTO @t
	SELECT * FROM Com.fn_GetchartOrgan(@Id)
	FETCH NEXT FROM c INTO @Id,@PID
END
CLOSE c
DEALLOCATE c
INSERT INTO @temp
        ( id, pid, title,Namechart,fldOrgPostCode )

SELECT        Com.tblOrganizationalPosts.fldId, Com.tblOrganizationalPosts.fldPID, Com.tblOrganizationalPosts.fldTitle,tblChartOrgan.fldTitle
,fldOrgPostCode
FROM            Com.tblOrganizationalPosts INNER JOIN
                         Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId
						 WHERE fldChartOrganId IN (SELECT id FROM @t)

INSERT INTO @temp
SELECT        Com.tblOrganizationalPosts.fldId, Com.tblOrganizationalPosts.fldPID, Com.tblOrganizationalPosts.fldTitle,tblChartOrgan.fldTitle
,fldOrgPostCode
FROM            Com.tblOrganizationalPosts INNER JOIN
                         Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId
						  WHERE tblOrganizationalPosts.fldPid IN (SELECT id FROM @temp)

DECLARE cu CURSOR FOR
SELECT id,pid FROM @temp
WHERE PID IS NOT NULL
OPEN cu
DECLARE @Id1 int, @PID1 INT
FETCH NEXT FROM cu INTO @Id,@PID
WHILE @@FETCH_STATUS=0
BEGIN
	INSERT INTO @temp
	SELECT id,pid,title,Namechart,fldOrgPostCode FROM Com.fn_GetOrganPost(@Id1)
	FETCH NEXT FROM cu INTO @Id1,@PID1
END
CLOSE cu
DEALLOCATE cu
IF(@fieldname='fldid')
SELECT * FROM @temp WHERE id LIKE @value
IF(@fieldname='fldTitle')
SELECT * FROM @temp WHERE title LIKE @value

IF(@fieldname='Namechart')
SELECT * FROM @temp WHERE Namechart LIKE @value

IF(@fieldname='')
SELECT * FROM @temp
GO
