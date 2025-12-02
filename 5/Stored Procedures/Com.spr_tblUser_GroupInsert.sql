SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblUser_GroupInsert] 

    @fldUserGroupId int,
    @fldUserSelectId int,
    @fldUserId int,
	@fldGrant bit,
	@fldWithGrant bit,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblUser_Group] 
	INSERT INTO [Com].[tblUser_Group] ([fldId], [fldUserGroupId], [fldUserSelectId], [fldUserId],	[fldGrant] ,[fldWithGrant], [fldDesc], [fldDate])
	SELECT @fldId, @fldUserGroupId, @fldUserSelectId, @fldUserId,@fldGrant ,@fldWithGrant, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
