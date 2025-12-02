SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblCodeDaramadAramestanInsert] 
   
    @fldCodeDaramadId int,
	@fldOrganId int,
    @fldUserId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblCodeDaramadAramestan] 

	INSERT INTO [Dead].[tblCodeDaramadAramestan] ([fldId], [fldCodeDaramadId], [fldUserId], [fldIP], [fldDesc], [fldDate],fldOrganId)
	SELECT @fldId, @fldCodeDaramadId, @fldUserId, @fldIP, @fldDesc, getdate(),@fldOrganId
	if(@@Error<>0)
        rollback       
	COMMIT
GO
