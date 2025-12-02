SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblTypeEstekhdam_UserGroupUpdate] 
    @fldId int,
    @fldTypeEstekhamId nvarchar(800),
    @fldUseGroupId int,
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(15)
AS 

	BEGIN TRAN
		set @fldDesc=com.fn_TextNormalize(@fldDesc)
	delete from tblTypeEstekhdam_UserGroup
	where fldUseGroupId=@fldUseGroupId and   fldOrganId=@fldOrganId
	if(@@Error<>0)
        rollback   
	else
	begin
		select @fldId=isnull(max(fldid),0) from [Pay].[tblTypeEstekhdam_UserGroup]
		INSERT INTO [Pay].[tblTypeEstekhdam_UserGroup] ([fldId], [fldTypeEstekhamId], [fldUseGroupId], [fldOrganId], [fldUserId], [fldDesc], [fldIP], [fldDate])
		SELECT @fldId+row_number()over (order by item), item, @fldUseGroupId, @fldOrganId, @fldUserId, @fldDesc, @fldIP, getdate() from com.split(@fldTypeEstekhamId,',')
		where item<>''
		if(@@Error<>0)
			rollback    
	end

	--UPDATE [Pay].[tblTypeEstekhdam_UserGroup]
	--SET    [fldTypeEstekhamId] = @fldTypeEstekhamId, [fldUseGroupId] = @fldUseGroupId, [fldOrganId] = @fldOrganId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldIP] = @fldIP, [fldDate] = GETDATE()
	--WHERE  fldId=@fldId


	COMMIT
GO
