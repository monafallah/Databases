SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblUserGroupDelete] 
	@fldID int,
	
	
	@fldTimeStamp int
AS 
	BEGIN TRAN
	Declare  @fldRowId varbinary(8),@fldRowId1 varbinary(8)
	Declare @flag tinyint
	if not exists(select * from tblUserGroup where fldId=@fldId )
			set @flag= 2 
		else if exists( select * from tblUserGroup where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=1 
		else if not exists(select * from tblUserGroup where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=0 
	if(@flag=1)
	begin
	DELETE
	FROM   [dbo].[tblUserGroup]
	WHERE  fldId = @fldId
	if (@@ERROR<>0)
		begin	
			rollback
		end
		select @flag as flag
	end

	else
		select @flag as flag
	COMMIT
GO
