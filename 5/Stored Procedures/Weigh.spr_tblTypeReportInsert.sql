SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblTypeReportInsert] 
   
    @fldType tinyint,
    @fldOrganId int,
    @fldBaskoolId int,
    @fldUserId int,
    @fldIP varchar(16)
AS 

	
	BEGIN TRAN
	
	declare @fldID tinyint
	if exists (select * from [Weigh].[tblTypeReport] where fldorganId=@fldOrganId and fldbaskoolid=@fldBaskoolId)
	begin
		
		update [Weigh].[tblTypeReport]
		set fldtype=@fldType,fldDate=getdate(),fldUserId=@flduserId
		where  fldorganId=@fldOrganId and fldbaskoolid=@fldBaskoolId and fldtype<>@fldType
		if (@@error<>0)
			rollback
	end
	else
	begin
	 
		select @fldID =ISNULL(max(fldId),0)+1 from [Weigh].[tblTypeReport] 

		INSERT INTO [Weigh].[tblTypeReport] ([fldId], [fldType], [fldOrganId], [fldBaskoolId], [fldDate], [fldUserId], [fldIP])
		SELECT @fldId, @fldType, @fldOrganId, @fldBaskoolId, getdate(), @fldUserId, @fldIP
		if(@@Error<>0)
			rollback  
	end	     
	COMMIT
GO
