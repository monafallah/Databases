SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblSecretariat_OrganizationUnitInsert] 
   
    @fldSecretariatID int,
    @fldOrganizationUnitID int,
    
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(15),
    @fldOrganId int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblSecretariat_OrganizationUnit] 
	INSERT INTO [Auto].[tblSecretariat_OrganizationUnit] ([fldID], [fldSecretariatID], [fldOrganizationUnitID], [fldDate], [fldUserID], [fldDesc], [fldIP], [fldOrganId])
	SELECT @fldID, @fldSecretariatID, @fldOrganizationUnitID,GETDATE(), @fldUserID, @fldDesc, @fldIP, @fldOrganId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
