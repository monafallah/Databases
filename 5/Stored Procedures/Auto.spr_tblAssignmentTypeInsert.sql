SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblAssignmentTypeInsert] 
    
    @fldType nvarchar(250),
    @fldOrganID int,
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(15)
AS 
	
	BEGIN TRAN
	declare @fldID INT
	SET @fldType=com.fn_TextNormalize(@fldType) 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblAssignmentType] 
	INSERT INTO [Auto].[tblAssignmentType] ([fldID], [fldType], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP])
	SELECT @fldID, @fldType, @fldOrganID, GETDATE(), @fldUserID, @fldDesc, @fldIP
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
