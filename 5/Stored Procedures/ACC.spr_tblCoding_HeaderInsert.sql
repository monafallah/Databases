SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCoding_HeaderInsert] 
    
    @fldYear smallint,
    @fldOrganId int,
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblCoding_Header] 
	INSERT INTO [ACC].[tblCoding_Header] ([fldId], [fldYear], [fldOrganId], [fldDesc], [fldDate], [fldIP], [fldUserId])
	SELECT @fldId, @fldYear, @fldOrganId, @fldDesc, GETDATE(), @fldIP, @fldUserId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
