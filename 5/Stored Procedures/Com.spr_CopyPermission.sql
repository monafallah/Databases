SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_CopyPermission](@por INT,@Khali INT,@userId INT)
AS
DECLARE @count INT
DECLARE @t TABLE (ModuleOrganId INT,id INT)
DECLARE @id INT,@madule INT,@idPermi INT
DECLARE @app TABLE (id INT)
INSERT INTO @t
SELECT      Com.tblUserGroup_ModuleOrgan.fldModuleOrganId,fldId
FROM Com.tblUserGroup_ModuleOrgan
                      WHERE fldUserGroupId =@por AND fldModuleOrganId IN (SELECT      Com.tblUserGroup_ModuleOrgan.fldModuleOrganId 
                      FROM com.tblUserGroup_ModuleOrgan
                      WHERE fldUserGroupId=@Khali)


                      
WHILE ((SELECT COUNT(*) FROM @t )>0)                     
 BEGIN                     
	  SELECT TOP(1) @madule=ModuleOrganId FROM @t
	  INSERT INTO @app
	  SELECT fldApplicationPartID FROM Com.tblPermission WHERE fldUserGroup_ModuleOrganID IN (SELECT fldId FROM Com.tblUserGroup_ModuleOrgan WHERE fldUserGroupId=@Khali AND fldModuleOrganId=@madule)            
   	  SELECT @idPermi =ISNULL(max(fldId),0)+1 from [com].[tblPermission]    
	 INSERT INTO Com.tblPermission( fldId ,fldUserGroup_ModuleOrganID ,fldApplicationPartID ,fldUserID ,fldDesc ,fldDate)             
	 SELECT @idPermi+ROW_NUMBER()OVER(ORDER BY fldid DESC) ,
    (SELECT fldId FROM Com.tblUserGroup_ModuleOrgan WHERE fldUserGroupId=@Khali AND fldModuleOrganId=@madule),fldApplicationPartID,@userId,fldDesc,GETDATE()
    FROM Com.tblPermission 
    WHERE fldUserGroup_ModuleOrganID IN (SELECT fldId FROM Com.tblUserGroup_ModuleOrgan WHERE fldUserGroupId=@Por AND fldModuleOrganId=@madule)                    
	AND fldApplicationPartID NOT IN (SELECT id FROM @app)
	DELETE TOP(1) FROM @t
end


 
GO
