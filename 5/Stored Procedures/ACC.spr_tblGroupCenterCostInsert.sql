SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblGroupCenterCostInsert] 
   
    @fldOrganId int,
    @fldNameGroup nvarchar(100),
    @fldDesc nvarchar(MAX),
   
    @fldIP varchar(16),
    @fldUserId int
AS 
	
	BEGIN TRAN
	SET @fldNameGroup=Com.fn_TextNormalize(@fldNameGroup)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblGroupCenterCost] 
	INSERT INTO [ACC].[tblGroupCenterCost] ([fldId], [fldOrganId], [fldNameGroup], [fldDesc], [fldDate], [fldIP], [fldUserId])
	SELECT @fldId, @fldOrganId, @fldNameGroup, @fldDesc, GETDATE(), @fldIP, @fldUserId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
