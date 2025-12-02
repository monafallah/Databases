SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblCodingBudje_HeaderInsert] 
  @fldID int out,
    @fldYear smallint,
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(100),

    @fldIP nvarchar(16)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	--declare @fldID int 
	select @fldID =ISNULL(max(fldHedaerId),0)+1 from [BUD].[tblCodingBudje_Header] 

	INSERT INTO [BUD].[tblCodingBudje_Header] (fldHedaerId, fldYear, [fldOrganId], [fldUserId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @fldYear, @fldOrganId, @fldUserId, @fldDesc, getdate(), @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
