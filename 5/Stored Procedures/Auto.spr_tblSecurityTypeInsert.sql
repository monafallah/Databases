SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblSecurityTypeInsert] 
    
    @fldSecurityType nvarchar(50),
    @fldOrganID int,  
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(15)
AS 
	
	BEGIN TRAN
	SET @fldSecurityType=com.fn_TextNormalize(@fldSecurityType)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblSecurityType] 
	INSERT INTO [Auto].[tblSecurityType] ([fldID], [fldSecurityType], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP])
	SELECT @fldID, @fldSecurityType, @fldOrganID, GETDATE(), @fldUserID, @fldDesc, @fldIP
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
