SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE
 PROC [Str].[spr_UpdatePID_Anbar] (@Child int ,@Parent INT,@UserId int)
AS

UPDATE Str.tblAnbarTree SET fldPId=@Parent,fldUserId=@UserId,fldDate=GETDATE() WHERE fldId=@Child
GO
