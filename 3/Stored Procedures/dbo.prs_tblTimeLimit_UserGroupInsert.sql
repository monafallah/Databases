SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblTimeLimit_UserGroupInsert] 
    @fldAppId int,
    @fldTimeLimit smallint,
    @fldUserGroupId int,
	@fldinputid int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblTimeLimit_UserGroup] 
	INSERT INTO [dbo].[tblTimeLimit_UserGroup] ([fldId], [fldAppId], [fldTimeLimit], [fldUserGroupId])
	SELECT @fldId, @fldAppId, @fldTimeLimit, @fldUserGroupId
	if (@@ERROR<>0)
	begin	
		ROLLBACK
		end
else
begin
	insert tblLogTable
	select 67,@fldID,@fldInputId,GETDATE(),1
	if(@@ERROR<>0)
	rollback
end
	COMMIT
GO
