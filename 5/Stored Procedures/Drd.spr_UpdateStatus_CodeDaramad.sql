SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_UpdateStatus_CodeDaramad](@Id INT,@Status BIT,@userId INT )
AS
UPDATE Drd.tblShomareHesabCodeDaramad
SET fldstatus=@Status,fldUserId=@userId,fldDate=GETDATE()
WHERE fldId=@Id
GO
