SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCenterCostInsert] 
    
    @fldOrganId int,
    @fldNameCenter nvarchar(100),
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int
AS 
	
	BEGIN TRAN
	SET @fldNameCenter=Com.fn_TextNormalize(@fldNameCenter)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblCenterCost] 
	INSERT INTO [ACC].[tblCenterCost] ([fldId], [fldOrganId], [fldNameCenter], [fldDesc], [fldDate], [fldIP], [fldUserId])
	SELECT @fldId, @fldOrganId, @fldNameCenter, @fldDesc,GETDATE(), @fldIP, @fldUserId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
