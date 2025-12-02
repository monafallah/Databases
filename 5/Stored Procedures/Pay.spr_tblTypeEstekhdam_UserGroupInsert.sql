SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblTypeEstekhdam_UserGroupInsert] 

    @fldTypeEstekhamId nvarchar(800),
    @fldUseGroupId int,
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(15)
AS 


	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblTypeEstekhdam_UserGroup] 
	delete from tblTypeEstekhdam_UserGroup
	where fldUseGroupId=@fldUseGroupId and   fldOrganId=@fldOrganId
	if(@@Error<>0)
        rollback   
	else
	begin
			select @fldId=isnull(max(fldid),0) from [Pay].[tblTypeEstekhdam_UserGroup]
		INSERT INTO [Pay].[tblTypeEstekhdam_UserGroup] ([fldId], [fldTypeEstekhamId], [fldUseGroupId], [fldOrganId], [fldUserId], [fldDesc], [fldIP], [fldDate])
		SELECT @fldId+row_number()over (order by item) , item, @fldUseGroupId, @fldOrganId, @fldUserId, @fldDesc, @fldIP, getdate() from com.split(@fldTypeEstekhamId,',')
		where item<>''
		if(@@Error<>0)
			rollback    
	end	   
	COMMIT
GO
