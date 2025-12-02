SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblSecretariat_OrganizationUnitUpdate] 
    @fldID int,
    @fldSecretariatID int,
    @fldOrganizationUnitID int,
    
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(15),
    @fldOrganId int
AS 
	BEGIN TRAN
	UPDATE [Auto].[tblSecretariat_OrganizationUnit]
	SET    [fldID] = @fldID, [fldSecretariatID] = @fldSecretariatID, [fldOrganizationUnitID] = @fldOrganizationUnitID, [fldDate] = GETDATE(), [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldIP] = @fldIP, [fldOrganId] = @fldOrganId
	WHERE  [fldID] = @fldID
	COMMIT TRAN
GO
