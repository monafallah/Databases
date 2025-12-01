SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
	
CREATE PROC [dbo].[prs_CopyPermission](@por INT,@Khali INT,@UserId int,@InputID int)
as
begin
	declare @fldid INT
	DECLARE @temp TABLE (id INT)
	select @fldid = isnull(max(fldId),0)+1 from tblPermission
	INSERT INTO [dbo].[tblPermission] ([fldID], [fldUserGroupID], [fldApplicationPartID],  [fldDesc],fldInpuId)
	SELECT    @fldid+row_number() over (order by fldid desc), @Khali, [fldApplicationPartID], [fldDesc],@InputID
	FROM   [dbo].[tblPermission] as r
                      WHERE fldUserGroupId =@por and [fldApplicationPartID] not in(select s.fldApplicationPartID from tblPermission s where r.fldApplicationPartID=s.fldApplicationPartID and fldUserGroupID=@Khali )


IF(@@ERROR<>0)
ROLLBACK
end
GO
