SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create
 PROC [Str].[spr_UpdatePID_Anbar_Tree] (@Anbar_TreeId int,@Parent INT,@UserId int)
AS

UPDATE Str.tblAnbar_Tree SET fldAnbarTreeId=@Parent,fldUserId=@UserId,fldDate=GETDATE() WHERE fldId=@Anbar_TreeId
GO
