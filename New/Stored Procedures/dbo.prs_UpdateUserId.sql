SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_UpdateUserId](@Id int,@Userd INT)
as
begin tran
UPDATE tblUser
SET fldUserId=@Userd
WHERE fldId=@Id
if(@@ERROR<>0)
	rollback
	commit
GO
